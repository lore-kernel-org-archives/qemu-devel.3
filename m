Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F2D1118F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJyq-0000zN-39; Wed, 26 Nov 2025 13:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJyo-0000s8-5U
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:11:02 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJym-0005BA-Gf
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:11:01 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2953ad5517dso614705ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764180659; x=1764785459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KbLKyoydxbUtuPk/ZwAEhYm5ZvDSj7sP8AT+i8XdMGo=;
 b=siwDU1KCflIgbhb+xcm+yxvl6JSfKKdHuj6DSd/aGHrqbfF/F8yZmAbkdEseKt3KQd
 xHTe7gf3uuwLeBDtym7ayN5Cg5v/0w7+8CTBdNywy23SREvx8EhP/fx0oowQqtEYRqpS
 AkiU7FEObZYyRf85Bw3aDuc8CKhhBpiPF6Z5NHJH/GfDRUAMLPLAHcA0s54ov5hbD3sj
 QCACWcOHvTzLmL96UWBrQk7ercdkkGCQ5Ijd/Vm2aHl61ZW+yeAs1t1/RXRy2ExWEJus
 ZkNJyuDGycJNI+DhxarJtkVZbHvAt09BxpzyJxEolsL6kXyT/kg/ZALcbrXDPbE7xSqg
 eJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764180659; x=1764785459;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KbLKyoydxbUtuPk/ZwAEhYm5ZvDSj7sP8AT+i8XdMGo=;
 b=YS5ggQMHGPuWdLk96fJLQj8lGxQmKpWh4orSCWN+L9vxH0+pU7xostcY41KmGgN5Og
 ULf72zPSrYapL93kosHEM8aCnomsmM76ndHP8sN0R+AdqpGpCULnoCeYtd6VUtZILH/j
 jh7LSLu4xNRg4ljWjmQUIoZR8RIiteMCKP5siGg3fOYN0nCQPDUy1fJRDJVw3ezt9b4Z
 SnZJ8uStIL+D0PBGovbeT9oLINVB/GAlY7AwAXCwnj1F0jXm6lMQqCjhpFpo36kn0c7y
 C0qTKNK7OQIbK14X0EeAoBfN/L3Byj7kMUbM8H9c237uI/3Wp/Sm752G0TmxvnNw8Ia/
 93mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpXk2uk31EFOqQzLk5Pr6jm18a6IhEZfZV2h2uLK6OQPb97DvNZPpPvtxp+5mnmAuVehRoL62EwJCC@nongnu.org
X-Gm-Message-State: AOJu0Yzw4hWjD+FqDwOz7TcPetKjQMMi0C8+r4KFgo0TVlzHS7pfqxND
 fmV6/Wd2f63vlWvQokKE+qe1tIUZcF1hNEaLDJ70FkuUPwnar2XONXh6ODelU2u96+g=
X-Gm-Gg: ASbGncvAOOurqPeX2VXcSIYYqLyXcCxDdp7yXFpmOeob3MTkMgVIdqDdOzPV2PG14gJ
 443E7MTdtMXKllYbpNB/Uk1ZNfeSk+PVL9yjrp+hJKDI6htOZ4NEknBgqBaZn7CzUpjT9jDK2aL
 ejMjUFBWNatILKzzXHPnoZTF/mY4vz8USkozmrdhpjmrvqgOOhROeCUH/MBmV7tQzPOhTnZXPun
 oNE0tDhOJCyiwbJL0j7mg1u7Wec9MRif6JAhlkWqHFVL1BI113KYX7dCigs1VUkypu+GOL3l1Y8
 jU7tmz3sfa0H/P4rNIbzVIMPBLPXXv9ZBwxBY0PdMicoab8s5La/uU1wn5k6mnzFjX28Xhn5xjV
 8zbjigZIrV/aEYBayEgsZvSGADsUme9GmWWCkncjwA1YPpy68E4HzD4Q3KhS2DCbG7IGcbLLEV7
 lt+WBhuaQgIEv9L49Zz6Hv2DG6Xo4566/nUA3KlIAnaZf7AeaOoQ==
X-Google-Smtp-Source: AGHT+IH879XYhjN+zim4RI8FDaKIUQrGL3L4BXl/v4sRVdt4TYwRhO0zX08Cu0CKXGiNUl+klw5mKw==
X-Received: by 2002:a17:903:1aa5:b0:298:b4f1:37eb with SMTP id
 d9443c01a7336-29baae4ee74mr93159665ad.10.1764180658833; 
 Wed, 26 Nov 2025 10:10:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd7603e9f57sm19952818a12.23.2025.11.26.10.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 10:10:58 -0800 (PST)
Message-ID: <ab5b7a9b-22cd-4507-8dc3-0637fcaf0d58@linaro.org>
Date: Wed, 26 Nov 2025 10:10:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 09/12] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126075003.4826-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 11/25/25 23:50, Philippe Mathieu-Daudé wrote:
> We only build the SPARC targets using big endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the big
> endian declarations. Use the explicit big-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=sparc; \
>      end=be; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/ldst_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

