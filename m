Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108B1C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDri-0003WZ-Mc; Wed, 30 Jul 2025 16:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDSW-0006a2-9s
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:31:32 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDSU-00054E-D0
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:31:32 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so204323a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907489; x=1754512289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UHIVOnELgIuhPcblRnUH5DxMLJA8aU4b0HX0Lu7iUc4=;
 b=d5HjubU/hvQ77c8yyGv3Rsogvo+vWAtA/O04g+U4U6F4pxIMAhor+KMxUFBuZUhxDu
 SQxrz6hPEaDs61kSe3j/p1om8tvHerNKiosdcyhBs63PyOgJ28/7aCtR0eXHt7L1Ygdz
 ++2L5ynUr1Kc3S4ShPOgeUzJ5T4crZ/Kjlxcd81+U1UzrFuGKRfiWxbPOTOGbADxoxIW
 Q7wzMGgAg0aIfxLjG/q5BJvHegWrcEFcW5wfvKI9GyEuHVakQNcDEmLewiWwLH5jQ8vr
 sJvKcA1UwbBF6nHnUY97AiAsSyeZXaHFnQN/5GDpOTeYqT18NVYh+c5Mo8Nw4TkQznoC
 Fhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907489; x=1754512289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UHIVOnELgIuhPcblRnUH5DxMLJA8aU4b0HX0Lu7iUc4=;
 b=Wxyduk06aMD1JmMjpGSCI5T9jVqh0hCnnoR6BbKBBXGFHiknn/NBGph61EWbwGZ/PR
 37QEUuxuACw+zdGJcF1hHA29QnoGJoTigWYiPX98LlgyEkTHdsYLbMUJ16XGUeBX4qN5
 uoo7Z5y6b33N56v+MQGl/AGf9GROWAHKbx2qvs5FpK6Br0k0JYQqoHarfuNyxikAz5TG
 ynt3lfHnkP7Z+RhWV/CJqlrQ9D2U1naRaYpsKcLPP0IDJB7fEBqGfyETNnO0vqO5nAA9
 /ASnBRapNZQo3PLplyXLl2oelU02UCEWAaXYggDFgaRUsQ7HSVuLf0j1ZOej2XcBgU/J
 WqsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7KE8wqAFJT8VioCMKAyHHJLYoYmPopyCym+EbrJnxJm+YSSBZDUunK3ElXUEv6QLbSQsh5lyWvSI8@nongnu.org
X-Gm-Message-State: AOJu0YySebQB09Auqk5pJOsFY8F95qkd/W5yiF0ruPWLCYasyU+F7YC2
 dDsKpiPP8xwrP8gVFJOEs1dv9CO8sEHYBPYEK/E/QI+phGPUj99Gse+FLYfSFvyHAkM=
X-Gm-Gg: ASbGnctG1fdIfcMsNUheRCh2MgsI0v/MM437vnpn1fezkxOrTjrsWyabq7ZOMWONnUE
 hnQAhlPiZ86dBdFjTbeDxmamZESQwOQ+EddrJ1e6dU6v+S9DNLnpPkVwlhiuKihsgc70H/ZzjEq
 E2FSo1/5pYUFEMqBnzr8u1IeqSksfX7H4zXEUsMQlALAbWqmbxihNOBDL9i6AuYv5xNMoe/BYgQ
 Xkfe67RMbd+mFsKbAFjFLEWBXag7YI4NljAElvUZSf/I0ReIRhYWnIHj6FvBko1O0bXYcXsLDiU
 78SlP5rBYDhxRoN6ldAaHTUmd4P4qigMMZw/l77xhK1FDfxoMigFKcwqxlNqO9zsad/kXs+TwrW
 lwWbpvxlCXD2lDcW7pGbAaIOrOEf5JJTyOF0=
X-Google-Smtp-Source: AGHT+IEyZ5NQv69fY7EKj7H8yowrxQCngayeeT3sOz2a6GFc/VpRil971N7cYzjine9iSxlnkVHkoA==
X-Received: by 2002:a17:90b:5286:b0:313:17e3:7ae0 with SMTP id
 98e67ed59e1d1-31f5de7bac5mr5696285a91.34.1753907488761; 
 Wed, 30 Jul 2025 13:31:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ee4f42sm2787770a91.23.2025.07.30.13.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:31:28 -0700 (PDT)
Message-ID: <32d2c522-142e-458b-be9b-098d464c93fa@linaro.org>
Date: Wed, 30 Jul 2025 13:31:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/82] target/arm: Skip AF and DB updates for AccessType_AT
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> We are required to skip DB update for AT instructions, and
> we are allowed to skip AF updates.  Choose to skip both.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


