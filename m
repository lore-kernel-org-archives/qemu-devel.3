Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B4CF4484C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBAsy-0005Si-Hf; Fri, 10 Apr 2026 08:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAst-0005Rx-AL
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:22:51 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAsq-0003Yb-Sb
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:22:51 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-650775f427eso2008101d50.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 05:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775823767; cv=none;
 d=google.com; s=arc-20240605;
 b=N+HQLZTLs6aQC+wnPwqbD7tJPHmHl0FTd3PKWoxbBP2p75EG8NkF1KfE08xxBsFmFB
 u5oCPwKQRVtn9lvepWueVa1TpyZCWYePnanRpwoYE/1bgFoNI1QayXglsDjEObLdgbKT
 xyoJ17YY4H5Q1Dq4nqyM1QQYz/k47PUylgoYUp0eKa9AEuASXG13RRV5lbH2oOuveWX+
 07X9NcbyOQc48n6J2nDZVgiH1gx/LS6Acaox8ygIMSN9xT35oFpudyIz5lxmEzLD37yC
 6WlYwBtlu4gSJndM5uEELl0uFywtDzlS5X6kVtxBVf3ZYvvvsA01Z4gxHf6GM0clyGiy
 vPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IQOYafq9DurwFSwBvsJy2WTXL7HCMbbN3tocXrg2ZhM=;
 fh=w0MeEhI6ZaF385icDQf6eSgjxPYrIUt5u2OddUD9FTY=;
 b=J+TJXwv95K2VJp/VBHHvjr5L5dycgocRTkjM3x+su+FqihgGN1/2ZXi3nnc47lCVCE
 7YqdKL1GaCXD+y8GPP7MhNXNE7mfD4pY93uctjLsutLSk/mGghusGoY2gJA3/hPoQmLO
 kdwH8c5M5Kydklose0nOafuvmyr5LLcqMEz0h6Rx9wERdQPXYfpvV1RsuRN8HM/6dIvq
 NPmQ6HMkbhQj71dLo6n32Ivy91QxEC1DXEQC+yGD/xKgfBfvbTzM+T8lkwYouWs2e8yg
 kAfYwg5ymJ+7tFqMgN+EyfttdqTjP3u5JsWGI9UqeDi9f0bfSMJzLzifOJLFIaLKnysO
 LBBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775823767; x=1776428567; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IQOYafq9DurwFSwBvsJy2WTXL7HCMbbN3tocXrg2ZhM=;
 b=OuBkMxCYW+1onYBarzVVpYF4J5k8EHhkixgRhMjJYAXPWtaveSfvvwnKKatUvBZSHe
 I32AdT3bFdFSHF87HqcrVIDtgP8BcjZ+YyX4pUuxLYaaa5erT2t0oOl/a0bKCMP12Z2C
 DOAD6E8KeJUxW45VMXUkuj6jei8zlXLM2sc0eIeMlzlJPLBtRARV5aPDAlMRL4xtaObc
 ysWRVu0b4e9glyiimrUNlnHwHU4I7Hk1ukBQXXMW25XcSgadpN33xP4J/D49iWltaldt
 WpkGCTIOFfMAoTLJMlGLAfMDlz8mi0bNLvPWuuIBUgJQ6htQaUWarJ4+Vb7r3nxqYso4
 L4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775823767; x=1776428567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQOYafq9DurwFSwBvsJy2WTXL7HCMbbN3tocXrg2ZhM=;
 b=RzP3VxF0uxX5zzT3yDq+/oG5G+Ij3i1Nl6Sa/fBBZgBIcMdthMwataNkpM/DeCHzma
 KgyIZr6zDvLNkaw/KYNDeKTrQxpkOxQOHDzmb5rel4gCnD7wTxQQKsfye+sF/FnrDaWG
 FThRRng1binCuxuEMGSfxzxwcKJp0ojgdqRlLSro3z61I/8Qy/VZ0cH/zWr/ET9M9jFG
 8ipP3/Rv37G878Nu+Q1Q2oQCzmFgBUvCCnyh4bAJi9gs/NfmjLNGE6isCVyKx79mjRw0
 9F1G48rM1UHZFXvRZha48dMgWAckFO3E8ZspB4toaxS20vWnSFpeUESD1escJ2wJwzrk
 r/aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR++RWct+IqcvAXd7lqC51aF2uJ+CfXtOwf6ldtTjjSSitRe5J4yLoi0DT1xWi0XXelcgR8ZziZYbH@nongnu.org
X-Gm-Message-State: AOJu0YwZZvzNuibpUx7CLH/tVtVACk8v+/iEyVaTPG4hr0vvoRgjtZJx
 xWaDuJJh2XghMjDGVs3CzAaaiblw7AwELTUUCjh/BNQ3qKX1cB6fuhakY4JxCOurNIas/cjVAxs
 uE+fOEoeVdrlo2VlRZmvryc/VLR1m7gJntsz8+HYwjA==
X-Gm-Gg: AeBDieuPe9E62j+KI1/dlBe1Fz6jFCHoPKQpP0yDLttjvLHG2bpwr0+Zy42Na22Np3q
 21KZvdvmlIT7bRg0VvVNvPcUqwtm2AxN1PnD5HQviOG04IKoMsySrUQKEHKBsbnDK0NNOekPqrY
 9e7vNupGe9zPL/rWazDugxC15m+jwaa0M+/GGlC6q86scThoPSy+nwIJKXW0RccPGzmY1RWI+wV
 LfzdQlf+HtweELSLaH+5WpKyDUrtpIHoNCguOR9RcolmcajaG9Y78OHbZWRfW1snFWVJXRjSbzS
 Y6RL6GrQW73dlRxDiD70+vZWM4d9qbugf6UElIbj3yNk8h9TumCvNgk7vsgjnJmfxzM=
X-Received: by 2002:a53:c443:0:b0:64e:e0fc:a314 with SMTP id
 956f58d0204a3-65198c34e20mr1912312d50.69.1775823767489; Fri, 10 Apr 2026
 05:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150302.203112-1-eric.auger@redhat.com>
 <20260306150302.203112-5-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 13:22:34 +0100
X-Gm-Features: AQROBzDDRqKWiw78YOUoqoxvOlCUrjLNmKtABV0dzE6KNtLiqxEQn1TmmChXFyA
Message-ID: <CAFEAcA_Vd8Uw+Ptdbt+MhYVejcxfcQLGVS_nkJiaACTtftuepg@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] target/arm/cpu64: Define cpreg migration tolerance
 for KVM_REG_ARM_VENDOR_HYP_BMAP_2
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
> from v6.15 onwards. Backward migration from a >= v6.15 to an older
> kernel would fail without cpreg migration tolerance definition
> for this register.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/cpu64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4cfddc6e8c0..abc6b78ef7d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -833,6 +833,14 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
>                                       0, 0, ToleranceNotOnBothEnds);
>      arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
>                                       0, 0, ToleranceNotOnBothEnds);
> +
> +    /*
> +     * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
> +     * from v6.15 onwards. Backward migration from a >= v6.15 to an older
> +     * kernel would fail without cpreg migration tolerance definition
> +     */
> +    arm_register_cpreg_mig_tolerance(cpu, KVM_REG_ARM_FW_FEAT_BMAP_REG(3),
> +                                     0, 0, ToleranceNotOnBothEnds);
>  }

If I understand the intention of this pseudoregister correctly, it's
for userspace control of what firmware features KVM exposes to the
guest. In that regard it's a bit like the KVM_REG_ARM_PSCI_VERSION
register, and as with that register I don't think the right
approach is "disregard any differences on migration". If we
exposed firmware feature X to the guest on the source then we
need to also expose it to the guest on the destination, because
it might be relying on it, and we shouldn't permit migration to
a destination kernel that can't implement X.

But I'm also not entirely sure what the nature of the mismatch
here is: https://docs.kernel.org/virt/kvm/arm/fw-pseudo-registers.html
says both
"By default, these registers are set with the upper limit of the
features that are supported"
but also that for the BMAP_2 bits that
"This is reset to 0".

So does the register reset to 0 such that all we need to handle
is "allow a source without the register as if it is zero, and
allow a source with the register even if the destination doesn't
have the register as long as the value is zero" ? Or is the
"reset to 0" bit wrong, and in fact the kernel defaults to
these bits being set, so we need something like the handling
of kvm-psci-version where the user can suppress the features
they need to give a "lowest common denominator" among the
kernels they want to migrate between ?

thanks
-- PMM

