Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D44CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jtk-0003qb-3L; Fri, 17 Oct 2025 08:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9jth-0003qJ-6t
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:49:29 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9jtY-0001PP-PO
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:49:28 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6353ff1a78dso1826076d50.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760705357; x=1761310157; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GsEAZ2DsKyDisHfi7SKDKedY0mzmq7ky3j+DoY9yFi8=;
 b=JQhhP20noaFi+l7iWt6WA/rw4d3BukR14jm3EeYwVeAQEBLOpJJiXiHEeI0SUkXM7o
 +lwBLBqbwz6LsxYaQTd3ECB2q1/7YDmyuy3HDTH83cdzm6Ro5ExiJRfyp2lHT7JLMj13
 CqWJEJXBN2oqvcrWFOKabEiXV/FbxOPTkTYq8jVy1gKgmn+P6D8NUBed19wXYaOETKrS
 +c2cMXohO3q2snzzn/+MZLESvGCqum9c8hzCwLSQhd9pNvWw601fLN3nGGckrjLRHljH
 88dIaKm4i9F6CBWJLShtUgwfV0ANnjmNd4/MwNcqxq2HlzqYdrcJEM4ZeQyzNr++Plhw
 Hlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760705357; x=1761310157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsEAZ2DsKyDisHfi7SKDKedY0mzmq7ky3j+DoY9yFi8=;
 b=QK4SMElO/7l+zra0qYRdb++CvBXp10/wWOpU4HvUTl2kzDeVleN/5FHemgzYM9wwk8
 2VikHPUoDWEzkCNoHJ9F2f+9Eh/i8p/AAIHNE9ZolPyB4qqbe+63OARjMpWD0tqSE5w7
 3DRLH1TFUX3vltjScl3WJX3YqWK+HX/vvEwe+VnvoTFyn+VmgfM1Y2gSxD6CvZL1wh2V
 +BKBAxss5Y8Ntz2NEpBmxz2diSG2U6FYCEAs5lq/8PPkhzcU/BMaqdBuiV7f9j6IlRXw
 Q2C8cSn/9+c7Er7xpJHNj4h2D8ycdbDx1qfmUbIr76tbpEDfCH6MCsI2SQe2THCFF76z
 OR1A==
X-Gm-Message-State: AOJu0YzmiKbrXz0RNHRxJrkA98KZjcvfCNrwalxVM6/kMM712tKVEmBS
 BWwKjJ6VEr8RD63zqUx9caWGMdE/7mhIWLxRU7BsEI/fQceeaUs9AnCa+agt1kSR7zi2+oU59+5
 wYMIENsLU0RT68uG2eWyZHYQT8o6figyHQ5DuQodvVQ==
X-Gm-Gg: ASbGncvqRga5omo/ntyftEcm1nZIKZv1oHLbcZDXHMr6GAJo6FrLVEew1896yXTuP13
 /bbh9cvmE/MIAOvgXN1S2KgrWYb1x38ZRFRIMu2Ypxp+fEMTATVlUAa+VX0bo0rVPEUk/ErJyqb
 zQFPpb+j+HULTdNXmt/6nx2ZfnfB7asMGX/134RpN3DC0jeJW6UrUXxQb2w0jnuqCE27qsZNc9U
 fLAs2oYVwuyNPZWD0Uqh7cxYnWjbUb6wlSkpFAw+7ipWHN4XUwTxg0b3SnnQA==
X-Google-Smtp-Source: AGHT+IH4g7/Rt0lLFJt/Wnu6hzc78mu7eCFcHBQuuaqw/uGsRD6ATDx7guH2+rYDCeeOseHk6gr4f2Wy24kv2kF5ATo=
X-Received: by 2002:a05:690e:1553:20b0:63e:1943:ce49 with SMTP id
 956f58d0204a3-63e1943d10amr1971887d50.39.1760705357334; Fri, 17 Oct 2025
 05:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-22-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 13:49:06 +0100
X-Gm-Features: AS18NWBmhCSw_IoW6E7nADmkuUEQSEz9iLBGrikMmowV-AdehplNtCwRDWttjMA
Message-ID: <CAFEAcA9J-g1cKTXk_pv1AWLgx5YksvEGyAbL2Z6coB6=wA0dZw@mail.gmail.com>
Subject: Re: [PATCH v2 21/37] target/arm: Extend PAR_EL1 to 128-bit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 14 Oct 2025 at 21:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not yet produce the 128-bit AT format result, but zero the
> high bits whenever the low bits are written.  This corresponds
> to PAR_EL1.D128 = 0, and bits [127:65] as RES0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
> index 0e8f229aa7..9e6af3d974 100644
> --- a/target/arm/tcg/cpregs-at.c
> +++ b/target/arm/tcg/cpregs-at.c
> @@ -353,6 +353,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
>      env->cp15.par_el[1] = do_ats_write(env, value, access_perm, mmu_idx, ss);
> +    env->cp15.par_el1_hi = 0;
>  }
>
>  static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -496,6 +497,7 @@ static void ats_s1e1a(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>      ARMSecuritySpace ss = arm_security_space_below_el3(env);
>
>      env->cp15.par_el[1] = do_ats_write(env, value, 0, mmu_idx, ss);
> +    env->cp15.par_el1_hi = 0;

I guess this is where the downside of not storing the
register as an Int128 shows up -- we have to remember
to explicitly clear the high half everywhere that we
have code that's doing an implicit-write to the 64-bit
version of the register.

thanks
-- PMM

