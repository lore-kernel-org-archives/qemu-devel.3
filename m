Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E1CC369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 02:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9xR7-0002fb-2N; Tue, 29 Apr 2025 22:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9xQt-0002eo-RY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 22:44:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9xQs-00054X-Dw
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 22:44:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223fd89d036so84588425ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745981060; x=1746585860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tC+8ZhooHZTvAGLomekaVbQIkO6+UDOUQQNKJ/Ad/fk=;
 b=CnGtJw5OSXBhldQnDmJ5ynEiaGi3rYZrlbZ1LgMex5/VAEbHWRzcfc7ZXWMMoFaoaH
 8yNtcJSZBfD7ZG9MN4W+jiGl/ghG1CiDADkHPSezcP7Bpd8vognbB53FDJFtKFiH6+Ug
 LPfEtgwrxCn3beZQ7j9y7KS9mLdacE8EzPfxwETwCkO78CkLqeXlOnM/US9YrTUXh2iv
 kPHc3nn0GuVcJUXY3BCrJw9VzYtKPtTiN8PkA0WBd5ovPrcgxWA/NL0pemC1QRiRoHA2
 97/QNFgVsh86TcWjM7H2ilV77JFe7B6WCy8VjoVxihB9HTPV/9nRQQK/6yij4VFqZL2l
 n64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745981060; x=1746585860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tC+8ZhooHZTvAGLomekaVbQIkO6+UDOUQQNKJ/Ad/fk=;
 b=mM2TjYse7gQ+ofTSz5RV6KFmixc/XiHCIfevhomAcg7D4kSdnnseB6SgnavT5R9QaE
 CKfPBaNLkwYlo3vn0rrPbxXlpTXiFV0g9Of4dCxlQmb8oPMPS84Pyf3kep8Ji39Mm2xE
 AgynGpRDZPaRCS1PBkxke/5KS1CVdhjT68KItfxxoXKLvCHPxrSS+OGHmlw1tkAG9xeR
 flk1ubp0IigveqH5iOMQbpWYmz9ja+hUThmem5Gu30ojjMo3N4M4emlCCZO0ppAnRbWd
 iRIm/CV1os30deAbrOiTXcd9nTjpZAEkY9YV5hbl2Qy0tncJzqSeo8RGHMnNmRtLzljJ
 DuSg==
X-Gm-Message-State: AOJu0YytHuiLqKZbgraSb1284gZiIeEcv8BAQhwJGDchJMpBQoc16A3o
 x/fDY+QSyWk7TC5Ee29RsftQ4JFStpZVlX9zHOj7oi2nxVa9WxNJxK+Kk5Ln/GfB1tSnqOvnovW
 c
X-Gm-Gg: ASbGncteza3zdq5101JLQqbJcsNPLx9jLzW8vapoEyRnsBxDYOgtI+pZlWK7CYSxXXx
 vJppZ46ySYwu7Jl0tb5B1G2gsUyIgFPMvw2TQ3GoOAQO/iu8kWQUD2SuOP+Gquwf6C0T828p8a2
 jpsNxcp7kYrYaJWpI/8Oer+6YFV/HXZgizaQvhjEyr6JuZK6S15gFgfSO9EBoZz8Utl4HRHIp/j
 5cW8d/gUDr5kXScscPuyACzh76edQY8osbnW/4K5DwzDGjGh1jH7e00YcbvthqZcDJYh6eviKSy
 GoA0z7E9lCJzMkCYQcV4lp62yW0Enegky0550VTdi7GznqXyxvO9i0BOzAZVVC9Qz4Q6G0/TKCZ
 KUwFsXSg=
X-Google-Smtp-Source: AGHT+IFkZzDdwmc6rFF72LWG935Xq3DyptiB8wPGhr8+oEuayERh9oWI5LNRqmkBkcmHfmYrMh7TmQ==
X-Received: by 2002:a17:902:dac2:b0:223:4b8d:32f1 with SMTP id
 d9443c01a7336-22df5764b99mr13026935ad.1.1745981060626; 
 Tue, 29 Apr 2025 19:44:20 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76f61sm110465665ad.3.2025.04.29.19.44.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 19:44:20 -0700 (PDT)
Message-ID: <7117ae7c-6f98-4d79-be4e-79f545529633@linaro.org>
Date: Tue, 29 Apr 2025 19:44:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/arm: Remove deprecated virt-3.0 up to virt-4.0
 machines
To: qemu-devel@nongnu.org
References: <20250429153907.31866-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429153907.31866-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/29/25 08:39, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (4):
>    hw/arm/virt: Update comment about Multiprocessor Affinity Register
>    hw/arm/virt: Remove deprecated virt-3.0 machine
>    hw/arm/virt: Remove deprecated virt-3.1 machine
>    hw/arm/virt: Remove deprecated virt-4.0 machine

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

