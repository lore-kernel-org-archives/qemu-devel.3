Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D0C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXzQ-0000Ip-JL; Tue, 05 Mar 2024 11:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXzM-0000Hk-NX
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:50:01 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXzL-00026O-45
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:50:00 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d28387db09so71404631fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 08:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709657397; x=1710262197; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVnoPFp+LqdAOXwQUfLL6Hgm7VDLhJWQuyKbgFX/Q34=;
 b=GvNDgq5pwzJ0W8ZIsK6Mn3XjR0dNvtWU1VWsVnNf6Coz5p3jZ9o5H/aMXxkDwsse90
 nU6xOyFmFUZTlU+IDMbS/m9ZAeWu0OfzKup7RZ7kbeB1h2NaKWW6acs6KRa90YCqDot3
 meZEv0YODf/EmlYPeSAX8+BU6dScAZyth7aoEv+0CnJSx4l5TL9wKiSmBYBVXXPpzGcu
 Us7UXFqxO6HhOCKQ8rLNNklpvVz9T/us0iAHLpAYD9wU5ToQgft97lJk3nMHHDYFXO06
 2lcXsnCGrUSjWu1iJZutsdQdF9mM75kHZwUTVc1vKH8JDdh0aoGvS1O+KnXK96CY1NAx
 LYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709657397; x=1710262197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVnoPFp+LqdAOXwQUfLL6Hgm7VDLhJWQuyKbgFX/Q34=;
 b=S20jd/5PwJX0x+5Lvxhvwh2NNrWG4uclEJig4h6oUBSnake8iyrZA7/KR98VP99I1F
 PZybF3E0icvYn+1YOaXfGSmRgfJGBys5zp18a7BuDEIeLYmjqTZW6Q9vdt+nVXpLSFrf
 SN7Fi3MglSFNTjPZ3TaF0p9ImkZ5t+4E8L6YLajGwtT5Exj2K62DgG3pS+DOrXgc30Jf
 Ka5/pFTE9BxhGs/TPQ0rwGTkRZyZ/Gti8vjumTCLUCCl8vORrn9kD0Z03CbN1kbuyr8U
 6zO+XxmjstYpj/TMAmkC/ME2bMi7ROryH1Sh5C/ihm9ZjZ98OJuaM8/l5ZR1CmvN1cMo
 PDCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzrOA/7tLK9V7R40sRtokAXvMidAzOgMt0jPnOrujoCMwFoB0o+4AkQjewpdcRNp7nVxjrQC2/Q3QWU+ufndzTpov2Ox8=
X-Gm-Message-State: AOJu0YzGg3ti0PDsAVy16Yj8Ax0rvNefoBjKLNe94SUWqn9cQ7AmbtPz
 0wc2DOUYkwKaSR659n5jfckh8/Y4UKLBFKDRvH/bMbInR41TeLmD/MlbzhmnF5uVp/V4XBsnYdK
 WVDw03e0f91IdqWmdofomvTUabBTlNDKvOxDG5w==
X-Google-Smtp-Source: AGHT+IFDySA6BaGQ5cLuUSP40P9Gw43XkH9bLNEWJfm9cQ6UVfzeRCp2WQkEhK4TSa0zV3+OybWJ4mrGft4Ox2SONdg=
X-Received: by 2002:a2e:9bca:0:b0:2d2:d3de:44fd with SMTP id
 w10-20020a2e9bca000000b002d2d3de44fdmr1652817ljj.29.1709657396550; Tue, 05
 Mar 2024 08:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <20240209160039.677865-5-eric.auger@redhat.com>
In-Reply-To: <20240209160039.677865-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 16:49:45 +0000
Message-ID: <CAFEAcA_y9uHa5cdtqgyneUSj=DzhDfrWc73xyr9x54tF5MedNg@mail.gmail.com>
Subject: Re: [RFC v2 4/5] target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is
 supported
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, gkulkarni@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Haibo Xu <haibo.xu@linaro.org>
>
> KVM_CAP_ARM_EL2 must be supported by the cpu to enable ARM_FEATURE_EL2.
> In case the host does support NV, expose the feature.
>
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v1 -> v2:
> - remove isar_feature_aa64_aa32_el2 modif in target/arm/cpu.h
>   [Richard] and use el2_supported in kvm_arch_init_vcpu
> ---
>  target/arm/kvm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0996866afe..a08bc68a3f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -238,6 +238,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       */
>      int fdarray[3];
>      bool sve_supported;
> +    bool el2_supported;
>      bool pmu_supported = false;
>      uint64_t features = 0;
>      int err;
> @@ -268,6 +269,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
>      }
>
> +    /*
> +     * Ask for EL2 if supported.
> +     */
> +    el2_supported = kvm_arm_el2_supported();
> +    if (el2_supported) {
> +        init.features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
> +    }
> +
>      /*
>       * Ask for Pointer Authentication if supported, so that we get
>       * the unsanitized field values for AA64ISAR1_EL1.
> @@ -449,6 +458,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      features |= 1ULL << ARM_FEATURE_PMU;
>      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>
> +    if (el2_supported) {
> +        features |= 1ULL << ARM_FEATURE_EL2;
> +    }
> +
>      ahcf->features = features;
>
>      return true;
> @@ -1912,6 +1925,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
>                                        1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>      }
> +    if (kvm_arm_el2_supported()) {
> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
> +    }
>
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cpu);

Am I reading this right that if the kernel supports FEAT_NV
then we will always ask for a vCPU with that feature?
Is that a good idea, or should we arrange to only do it if
the user uses the 'virtualization=on' option to -M virt ?
(Or does that happen already in some way I'm not seeing?)

thanks
-- PMM

