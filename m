Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B9ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 17:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGhdJ-0004hs-JG; Wed, 05 Nov 2025 12:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vGhdF-0004gY-9z
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:49:17 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vGhdD-00017w-H8
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:49:17 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so17257766b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 09:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762364953; x=1762969753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lXNN36xnDiP8tAFeM51P9BC0hLY1MVgx2GJDI54N4Fc=;
 b=CH2kDwAtf+/a204QyTypkpafA578cUT6eON6zRBwarJGQQcP5LSXrd+F/fQPYXnRCy
 Y+M/9p2vvkMfJb9N3TQ11dAhra2wzS8JiJppnwf4N5hzIBNAevDOzHXMtUG+cYdfVjlM
 UsOMa+d17rDzTMD36w2Eq/dcbNVjVFpsE08Fw3Y6skYIGRIo8ibfjsxYSqfuLHO8f3f8
 DPUQYPUbjTY0tPI6guS/MQAq7qEIdMtq3e1mRBXs9Aj0rpVe0EKONtAsNgtrs05w7xBy
 mOAuoW8agiG9vuUu8Vc2ldsrYqTgfs1nGkhco3R3UMJH0lfGkxQCiMFCh9OKfFd0yZ5N
 eYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762364953; x=1762969753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lXNN36xnDiP8tAFeM51P9BC0hLY1MVgx2GJDI54N4Fc=;
 b=SQx1jQW0ANxxi6WfYoICJh8W9AGLB1ySXMBTQrSrPp/guY0Ii3dARv2HS6D7uIL/ZR
 0VyPUA1vqw6gb+Kv1d5fedsbgp3HF8dVTFLZFklOq8btsdCgPkR+z7wPlxxfC62Wcpy1
 ZSWBJMwaK2pT1BNHZ39UF6AHpxBDeDpE7dcBgKAXHCxzhlVfhJ9WwZT0H72ANBmat1rK
 9bnlD2Sa4FPPMZeBq/zpfZDWor5XUu7AvN1KTshsoeRZeZYXnpnMnsuDcXlBkgAOEymo
 izaeoNQp8tR8sLlbEOq7hzXpeBx0MBAgCjypbTpE94IRkEJL+qmshSxCsbWNJtK+aXqa
 sozw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIznU5LPbZq/EOmIqC89AaxOGO3LRywJx7Wm65FxvuwrOL44/ypjaRrbY2GoRoqDusVhVjbTPrQUu3@nongnu.org
X-Gm-Message-State: AOJu0YyV/VdNA6YTJsN26HxmixHBgp+KnjA4/9K1P/sMIb9WPTvxR4NL
 +XYrMYPhjVaBgSqkxRX0b7BVN4ee2aRFyeXByVvhWdMlK9ztx/HU2ra53Tr4n8iTZX4=
X-Gm-Gg: ASbGncvGKV9ppvTWwqTyKsLbjpernaYiNtdL7AceiRsHZM3WhnYfP5Mx1n/OlSl4LuZ
 Vtn4MpUWjXJ6gh66h+DhA1/O8UZGrZyBzkb8jxmnjwLA/L7BJ1pQLZ+uNSBugA/lufX+wew+SSa
 LRw0nPUQvLn+baXbXe7Bx+Y/jB44WHSRLAMlF5zHgdfzrP9nQesqFpDhYAqYHYIEIhtMl2WoBec
 szp7wwqZkHZqSbsOyfEOuCA9pd877ddrW2G9vqTDMIIJjKY4J2m6+/Af1fpwnETT3yTWTyFe2ML
 XFN5SO/v1PLHylUPIiMHyk+950uSTodRKDEh/q/UE2kW4hWCvaHkuub2nvnbKrXEz6C1xNGQ3gP
 YpNrGBFPkgXlK3sPaVA07NFnANIBA89tJf7V7hvGdFodsGUpAGA6CL1Sh6hdv1iiScou6MJ4VIm
 hu2hms54Fk98sjeHr+4aO4/8s=
X-Google-Smtp-Source: AGHT+IFBJC9F2Fs5mgGKwqa8JOU0t2gmPQb/OrwiUBSYjcxBRn1MLtnrd21cpzOMhkJJoSD4gCEgzQ==
X-Received: by 2002:a17:907:948a:b0:b71:df18:9fd6 with SMTP id
 a640c23a62f3a-b72655cdf8bmr415992166b.50.1762364953098; 
 Wed, 05 Nov 2025 09:49:13 -0800 (PST)
Received: from [172.20.148.161] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7289684873sm11957566b.58.2025.11.05.09.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 09:49:12 -0800 (PST)
Message-ID: <9b196058-a0e3-422e-86a6-7c405681bf42@linaro.org>
Date: Wed, 5 Nov 2025 18:49:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: add support for FEAT_MTE_TAGGED_FAR
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20251104-feat-mte-tagged-far-v1-1-cdfd7db40397@gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251104-feat-mte-tagged-far-v1-1-cdfd7db40397@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ej1-x635.google.com
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

Hi Gabriel,

Thanks for your contribution.

On 11/4/25 21:50, Gabriel Brookman wrote:
> FEAT_MTE_TAGGED_FAR is a feature required for MTE4. The feature
> guarantees that the full address (including tag bits) is reported after
> a SEGV_MTESERR, and advertises itself in the ID_AA64PFR2_EL1 system
> register. QEMU was already reporting the full address, so this commit
> simply advertises the feature by setting that register, and unsets the
> register if MTE is disabled.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
> This patch is the first step toward implementing ARM's Enhanced Memory
> Tagging Extension (MTE4). MTE4 guarantees the presence of several
> subfeatures: FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR,
> FEAT_MTE_STORE_ONLY, FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM,
> none of which are currently implemented in QEMU.
> 
> According to the ARM ARM, the presence of any of these features (except
> FEAT_MTE_PERM) implies the presence of all the others. For simplicity
> and ease of review, I plan to introduce them one at a time. This first
> patch focuses on FEAT_MTE_TAGGED_FAR.

I think it's ok to add these "subfeatures" separately.

You need another patch to add FEAT_MTE_TAGGED_FAR to:

docs/system/arm/emulation.rst

Also, please adjust the title to something:

target/arm: Advertise FEAT_MTE_TAGGED_FAR for -cpu max

instead of "add support...", I think it's a better description for
the changes done here.


> FEAT_MTE_TAGGED_FAR guarantees that the full fault address (including
> tag bits) is reported after a SEGV_MTESERR, and exposes itself in the
> ID_AA64PFR2_EL1 register. QEMU already reports the full address in this
> case, so this change only advertises the feature by setting the
> appropriate field in ID_AA64PFR2_EL1. The field is cleared when MTE
> support is disabled or rolled back to instruction-only.
> 
> Testing:
> - Verified in system mode that the MTEFAR field in ID_AA64PFR2_EL1
> is set to 1 when running with mte=on and cleared with mte=off.

If you want to add a test like that it's good, yeah, but we don't usually
test the features this way.


> - Verified in user mode test that SEGV_MTESERR faults report the full
> tagged address as expected.

Yeah, that would be good if you can add a test like that. Maybe use
as a starting point some test in the mte-[1-8].c tests.

  > I didn’t include these checks as formal tests since the functionality is
> simple, but I can add them in follow-up versions if reviewers prefer.
> 
> Follow-up patches will implement the remaining MTE4 subfeatures listed
> above.
> 
> Thanks,
> Gabriel Brookman
> ---
>   target/arm/cpu.c       | 4 +++-
>   target/arm/tcg/cpu64.c | 4 ++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 39292fb9bc..804e70b235 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2020,6 +2020,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>            */
>           if (tcg_enabled() && cpu->tag_memory == NULL) {
>               FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 1);
> +            FIELD_DP64_IDREG(isar, ID_AA64PFR2, MTEFAR, 0);
>           }
>   
>           /*
> @@ -2027,7 +2028,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>            * enabled on the guest (i.e mte=off), clear guest's MTE bits."
>            */
>           if (kvm_enabled() && !cpu->kvm_mte) {
> -                FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 0);
> +            FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 0);
> +            FIELD_DP64_IDREG(isar, ID_AA64PFR2, MTEFAR, 0);
>           }
>   #endif
>       }
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 6871956382..27f0b43256 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1283,6 +1283,10 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
>       SET_IDREG(isar, ID_AA64PFR1, t);
>   
> +    t = GET_IDREG(isar, ID_AA64PFR2);
> +    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
> +    SET_IDREG(isar, ID_AA64PFR2, t);
> +
>       t = GET_IDREG(isar, ID_AA64MMFR0);
>       t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
>       t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */

The changes in code above look good to me.


Cheers,
Gustavo

