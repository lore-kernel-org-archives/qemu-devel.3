Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAC0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 21:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3haD-0008B4-5U; Tue, 30 Sep 2025 17:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3ha1-00089h-OB
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:08:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3hZr-0005XY-CE
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:08:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso3341521b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759266479; x=1759871279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pPkKbMSm3b9ABgbELSYyIU5QjO45rOvAEWGlFfg54ZE=;
 b=ZoZkOScw4TNoJ6K6gtomNMpYqBzjTK/5lq9ehRhqe6acf4mG/5MxytpoWTTUPA5YM7
 8HlgQuFQjZYXTepQbNLnbLNBhwTMDRkhY+//cpPrQygETHKnJyZujqQ1n1QaBJFSIFxg
 txFYBI+tJo/La1cd06THvef/dFl8afMJyqmplyol+nhrCCJIpCEBiakbt+GgJ5LHyjZ5
 Teha7AZ8TaZwiBsMxW35PGwegPK2kpcT3ewiqvnyea4tHstLw/HxXXBm9nlHUaKaxg0w
 AuigIxziJEL72jOALy5vonkj7exHHSobCGHRTIajkHW6kW0k5cNPMwTHVZZNUMbRIGIw
 tHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759266479; x=1759871279;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pPkKbMSm3b9ABgbELSYyIU5QjO45rOvAEWGlFfg54ZE=;
 b=EyNXYnWguXlEP4pu1Uatdpmi99C2xjJFRo07JoK727hOHDYoJpbvm2MtJVaLIg8ni2
 nwg8Fv7DoWNfykHT4uognILlkG6XzJUQesBAGgD7ww9cu0Rhav59mJbiyeF6E2it4tq9
 5hbdddivZ5sVsjIveYYJXWcKiPEUi4ipHsdtXiuQxtijZFRli+EVD2LLpaztP7ItnoIJ
 I0fxwj/fBx4f5T0uvQeb3oJPMVvHP6+IeY1vwW8MIAUpBsLof/BzSwOdUmTJuPxRghUg
 xO2/RplP7CySvdMARxakNV+6W96h9ZgaDgVEeY74ttrRlks/TZ5G/9JnSNbo2bRDa8MS
 HY/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3mDTI/T81+PAMCw2BzMDUyrT1yretbmgfPh3SbJ1CTUVazD8OolfCd1OUbXxdpMN6S+xCFpMiaJt8@nongnu.org
X-Gm-Message-State: AOJu0YztLP/8lwOEI2rft5v05KqBW4qqR+Bwr7sN1UGta2UcxmHCH7Iy
 MJLIT7mNpqPxSKwBifMy9SDK9IBl0RU9KSFMOsfAUXFi2pE8or2gtKajcmMAHqnKcDc=
X-Gm-Gg: ASbGncthKNzHEgM0AtGjaUC2J8RCFA1SBOXxmcFn9YChnl3D/u/D9x6xaayulMM35Lf
 0ngN9ABwxhylZLRtkazG0HvASRaxYrvBgguFw8Alz1+t4BwarXn/XvCBxXJ5k8Xh0PJ+2qZIuQv
 koEGLyPEkDu6bhuUy2v3XUrmEkqK+vPT07edCSDDcOFkXQDQrQFijnyGSMvofEFldd3lWDC7zHe
 NJWYcaUO56BUd8cK/EWjRE/kUHarlw1eIqzJ8Gx1zn/K2fW3fyIhLFPPiiKGlLe36H8HFriZ0ZL
 Z4KCvy5WeliO5Osyrt6yxmoFXycNhDyR5e8mASbXlw1GpdswrJvNYhJ2LbFFLzrS54oD0OeRvZf
 DOa5MfnXpeTvb1qMK6aBKHkhW2UFIGAACBjV1xzb9H2M07w/jR+MdcDujchGq
X-Google-Smtp-Source: AGHT+IGZ15RQzyLtNej4LubmumsxVg8S0gw+mz3DDgtkGrEcS3/jfSt/Dk/2zNrCF9qoVQzklAIx8w==
X-Received: by 2002:a05:6a00:14cc:b0:781:19d0:5544 with SMTP id
 d2e1a72fcca58-78af3fe8b5cmr782317b3a.7.1759266478908; 
 Tue, 30 Sep 2025 14:07:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78348969edcsm7582181b3a.25.2025.09.30.14.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 14:07:58 -0700 (PDT)
Message-ID: <82d89190-e18b-41a1-a7e6-ad52a19102af@linaro.org>
Date: Tue, 30 Sep 2025 14:07:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/18] system/physmem: Remove legacy
 cpu_physical_memory_rw()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> The legacy cpu_physical_memory_rw() method is no more used,
> remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/loads-stores.rst            |  4 +---
>   scripts/coccinelle/exec_rw_const.cocci | 10 ----------
>   include/exec/cpu-common.h              |  2 --
>   system/physmem.c                       |  7 -------
>   4 files changed, 1 insertion(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

