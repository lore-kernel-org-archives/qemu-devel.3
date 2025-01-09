Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CFFE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1wp-0008EW-IG; Thu, 09 Jan 2025 18:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1wn-00087t-Bu
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:28:17 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1wl-0003BM-Us
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:28:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso11279915e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736465292; x=1737070092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RP46uE6CHnm5t2MkFg9O/hnNVgd0PiCYIqPlrFcnTCc=;
 b=Pc//+jxNIX8coyBhJU0/x2lbPvDZCyEJ3qsEOJxdHGOoVA4SxuxjWrI2MstKSQA+70
 KBAszekUmf0ZqxESfU8n6B4Vmrnpvq+1HhiKbV+Lw5rEL3PrqvZkswdE8eq5usR/6Db9
 oiCfrLJ4NnwKlG/aZ5VwyRYodCtYmcrH9bLxpQXqC509VDIiFAfCXdr1azTY2ug4Xdiw
 Mg/J3Jwp0kuHDDW11gJJI8lJDADZVEjStELdVOm7q2tkmJFJXTdtzwX7ncV5zAJaizP+
 QFuM04cT9yP1LUPgqejuSuLybQXmrCNDsXNpNWYIL2DSqrEaX9XbXRIFtFWPH9oL94kO
 hbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736465292; x=1737070092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RP46uE6CHnm5t2MkFg9O/hnNVgd0PiCYIqPlrFcnTCc=;
 b=ZT7ms+id3VFUbX8Zqh1ejFGg9ZeKxhlR0whRLIWI4qSki71Up0iGKQyjyAlbyVIDvL
 MwlRGl2c3Ls7v3yAK0l8iG+NMFkdStUl6aduQwRR4PJIWqeD3zKVldDiFlJXWD4m8vWg
 5ZdUcKO69/GrxyoeNT7PPdIm/M93lsMyivjnNEeiXx4oHHUnEfsINCsTZe1Nai8qGvRZ
 oijinMTdyP5+F5YBffzojGAQtM7DbNUgI8594bEwbaH7URjpotniov4OOwL0vOZ2Uzo0
 6ZbQ52enl18+ntX6G68b+l2elXLDgP2KPJxb5q3K/3Ps5S4mJKSmBmu2QuzdA7t+JCLX
 s3Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9asO7gzicOAPsXeXi1FmYUS4vRVI5+Z7aPkYKu1lkOP7+nceH32mNuuCk1xxjCKVpKe+RTFDFXjLV@nongnu.org
X-Gm-Message-State: AOJu0YwSztnO1Ok+W/xrxYtBDCjF0lmgBDMZPWZy9Wvcv/5ao3HylHQd
 k9cZrrk6kRu+wR1m77xJonbLqZGekdBNXCkPLLItaG2lXZzU4uC/tzeCIsUv8Ks=
X-Gm-Gg: ASbGnctBECXYwDsYvgi9mo+MycxrpTgxj21rZfeZ49x4vFSZlitrzgJQz+VJwOCqI50
 DrhKT9BRJ3evXWxYIYty0xSfDI6Rcg10K0JUjf7R3WIU0Z39jUQSCIWRlBNI8oa00XO/llaTe0S
 4i9HDHAmX5pbKp5rrc0SvDRHfwcyJDInh87G4NWjiQdllaFLGQMWEigDvYLWS6WHp1QH6qjLYML
 qfDUP3Lbm8EPXuBhKdrQOxeKu8m2IP+okRBtcLIt9WXNn8mx/DN4mfuXyFGBzwXJ7fyB1VfnMem
 QIAsB0h7qy/OEm/aIm8SEADbTDo=
X-Google-Smtp-Source: AGHT+IG8PZ1NGw8IyLt71oaHIhXJEzz62YmiGu82DhWn3TlDIVNhy1neyfakWejLqOGa6KElEdYolQ==
X-Received: by 2002:adf:c007:0:b0:385:eb8b:3ec6 with SMTP id
 ffacd0b85a97d-38a872e9356mr5174570f8f.29.1736465292620; 
 Thu, 09 Jan 2025 15:28:12 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92f60sm68206305e9.40.2025.01.09.15.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:28:11 -0800 (PST)
Message-ID: <16b8ecbe-8967-4dea-93e2-33ebcd2dc141@linaro.org>
Date: Fri, 10 Jan 2025 00:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 56/81] tcg/optimize: Fold andc with immediate to and
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-57-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-57-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


