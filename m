Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6CFC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUa1K-00056Z-SD; Thu, 18 Jul 2024 18:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUa1J-00055u-NW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:54:41 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUa1H-0008Nk-Fw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:54:41 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5ce74defe42so787699eaf.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721343278; x=1721948078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rP9ObB7kczQt3SB01IB4zHA/918S3o262OQktUISJDk=;
 b=k68W28oR5/7kYnyd8UEGz0GM6q6b3yVwKRbj/NJ9MMr7Jvjl4ONsTfFDa6VICg4W/T
 Eki0WNpFcGZPrZQ8sUui/srOJGPqniAMRZuzbLkyHEfAAjzRibIx2gR7o2PQQtKPWOKt
 +sQElbaR25VJB35uia7LqeBHD2ant6iJ/cyma/3sHsJpor+sNrlVnaeTap0q4vCyUi1z
 wphZG3SYiPxpBv8WvB1ugmb8XCxUmp/qa5zZRHfVonmFM/He4sM3ocpsQ71aauVwLfhV
 h3QHief5YLMxyZ7iJrDFrjEQYkhAEf0jrKRIOCvMDlHF8KFgcNRCcfDyQVWnfe9gsVsA
 mjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721343278; x=1721948078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rP9ObB7kczQt3SB01IB4zHA/918S3o262OQktUISJDk=;
 b=ssVGWN8ejRkOo5lbU9D0KfYR9jXEuK7850Bff1BQyKcsqgazpepRvqhNRrHZ6lz0kf
 8j4YjyhTx3nh+XQSKJrTZOY2unGV577oXeYVcd0NcgNAjPGErVoPgjooIDVCfB9Z48eD
 oZaJk2aObnuaSzQcFEtSLNacXxZOoOrhoTgG/q0z7XCCimQt713gDYWT9whPgxwINCru
 0D74K9puvKhfZduWzgn2QXdxULaHlmmsb3ALwRdY/CtUChBVLk3UK08oZ8mxwVL5nUwd
 SxSzQyzvOehtKbqZJ9v6R7ctXPuiIedbHD1ta92Z7hst+pCpm6lZ+Nv+Z1xLaY+KFvdQ
 ca3A==
X-Gm-Message-State: AOJu0YwsqT5QgYyHXAaXHPCRXoe5DEwa3EbVdB9JBiF/ENPmyg+UrU3X
 rc6NhelAhi6lCLnKRTVWMYF/S9Aymr1k4p7vS+23bG3jDDhHSsoVFg72KHfHFenHfWsVFQVSeqQ
 gKjnMuQ==
X-Google-Smtp-Source: AGHT+IGZXeV48TP/syJ8HNCDy2FvIqbXcPlek6v+5FSROHjPjoXeg0KpZssMk03uO/aaJXPeU8ipag==
X-Received: by 2002:a05:6359:459d:b0:1aa:b8ba:6d with SMTP id
 e5c5f4694b2df-1aca9f34525mr384475255d.23.1721343278113; 
 Thu, 18 Jul 2024 15:54:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79db5786589sm101174a12.10.2024.07.18.15.54.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:54:37 -0700 (PDT)
Message-ID: <2dc9d775-cd79-424f-b79a-955c3816e54c@linaro.org>
Date: Fri, 19 Jul 2024 08:54:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] Reconstruct loongson ipi driver
To: qemu-devel@nongnu.org
References: <20240718133312.10324-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/18/24 23:32, Philippe Mathieu-Daudé wrote:
> Since v4:
> - Fix build failure due to rebase (Song)
> - Loongarch -> LoongArch (Song)
> - Added Song's tags
> 
> Since v3:
> - Use DEFINE_TYPES() macro (unreviewed patch #1)
> - Update MAINTAINERS
> - Added Bibo's tags

Ho hum, I didn't notice v5 when I just reviewed v4.

For the series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

