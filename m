Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC744CF58E7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 08:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYij-0007Zb-UT; Fri, 20 Sep 2024 04:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1srYii-0007Yd-Su
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 04:10:28 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1srYih-0004fR-5j
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 04:10:28 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5365aa568ceso2131981e87.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819824; x=1727424624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:cc
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6rjZHJd/Y2qAuD1jwBMX8+IRlC+eOI/FYBNNLqHxnuw=;
 b=RyWsnDXZlKW33r8oJehge4O/3VXhpRar7B2WiiFzkmuGdMCL9u5El6b+pO9aa2PuoU
 9+rtOjFH6J/Zco2BpilEL9NNyMlb42BmsKEO+JqMzEdG9en9/t75PDVPD4mz3CAJY6rt
 iaQnn4+7Q46/2bkqoqBR6dCiD2+KQCG71FECmgo/65XcbTgkFofo7ZxEV/Bgc843Uqe6
 +L6jlL7Fwp6+t0Czmdm4FUbfF3NAk08ZsOUgzT3Ur9O3NO85Jb0gNV1w0deQQgvc6lwp
 S+PvgfOzOZq+Opr8F1wbE+3KpK1ByUKPtxLvIjZrWRmPYx7/uJzYgRuaVARzHgmFQSqX
 kN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819824; x=1727424624;
 h=content-transfer-encoding:in-reply-to:organization:cc
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rjZHJd/Y2qAuD1jwBMX8+IRlC+eOI/FYBNNLqHxnuw=;
 b=YlYYkatb/QMOmjt+AcondFi2v94dEk8GJxabH3x9LfjBfX7osUadpDmZaXQ/SLT8Fl
 206NlwADF0tA8N4vQ0eXa4Gm4tNA/rxKE1my2ya5N2At7JJbsxwjnKs9gUbtEFHJHUK7
 ta9Wc5JPX3UoNy4pMhvyLekuIz2ufo0dA29GgJOKIGJQ79VxXnuOjqXS+34qRPXBlEzU
 8F3pdf2G7mjhKZWSNdzoWKQZpuWDmJjoDij+3gzT5faaqq/8QTrQKwYpTWq731P++ni9
 xnGHHPltKPHKYl9m+PDrWJ5nG2949xLeSvQpaJlAaKhGjwUqAB4bQZ/If6PrIGWDczU6
 Xipg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzlR8E6olOGKIWXYt43nl3p+K359cdkAYinz//pH4sWq9KrqyUz8eQ/5l61LT/e0HD0jpMkVVLDn6@nongnu.org
X-Gm-Message-State: AOJu0Ywux1m11HQNCShFBl4Rbl5TgcjyrN1Hv+n8S8sXQzp1/IME7+0v
 ylTwyfi6sYnSjsmKuBb0AhE9d+IkYBSUjCH7ZJOILxLj+yom3a42okcGQTs+Jgc=
X-Google-Smtp-Source: AGHT+IFklO5n2+Z1cvMWwfOx5QJrbKy1e1xhhjKuQVRom/6JjVo9cm7cqtwVCTNMRwztncdi0wP0IA==
X-Received: by 2002:a05:6512:130e:b0:535:3d15:e70e with SMTP id
 2adb3069b0e04-536ac32e4e4mr1452367e87.37.1726819823701; 
 Fri, 20 Sep 2024 01:10:23 -0700 (PDT)
Received: from [192.168.200.25] (83.11.24.101.ipv4.supernova.orange.pl.
 [83.11.24.101]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f43d2sm816304766b.87.2024.09.20.01.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 01:10:23 -0700 (PDT)
Message-ID: <10cfbfd3-6f7d-475e-b8b8-3cf8b031e66c@linaro.org>
Date: Fri, 20 Sep 2024 10:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240917161337.3012188-1-peter.maydell@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Cc: Michael Tokarev <mjt@tls.msk.ru>
Organization: Linaro
In-Reply-To: <20240917161337.3012188-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x135.google.com
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

W dniu 17.09.2024 o 18:13, Peter Maydell pisze:
> The Neoverse-V1 TRM is a bit confused about the layout of the
> ID_AA64ISAR1_EL1 register, and so its table 3-6 has the wrong value
> for this ID register.  Trust instead section 3.2.74's list of which
> fields are set.
> 
> This means that we stop incorrectly reporting FEAT_XS as present, and
> now report the presence of FEAT_BF16.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/cpu64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index b9f34f044d0..01689208286 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -677,7 +677,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>       cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
>       cpu->isar.id_aa64dfr1 = 0x00000000;
>       cpu->isar.id_aa64isar0 = 0x1011111110212120ull; /* with FEAT_RNG */
> -    cpu->isar.id_aa64isar1 = 0x0111000001211032ull;
> +    cpu->isar.id_aa64isar1 = 0x0011100001211032ull;
>       cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
>       cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
>       cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;

I think that it would nice to have it backported to stable branches. It 
applies to stable-8.1 and above.

In master it is 8676007eff04bb4e454bcdf92fab3f855bcc59b3 commit.

