Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E508C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfKC-0000ua-AB; Fri, 04 Jul 2025 08:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXfJx-0000rQ-LQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:15:15 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXfJq-0001fk-K9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:15:11 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e3980757bso7720747b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751631302; x=1752236102; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yim1rEzPel4pu+PfAZneNAEGt32iL8SSue5oPN+mJR4=;
 b=D5cVoI4mFgq3rON5tErx+NJAf6PLQNRw7RlPAvMFsFREmiPZizhLeS6T9SFpYBbE84
 DuiYdR2Nc6rw49QgkdGQ3Hz83ZJBIG5e/G6SmAHNgRW7VxMAA3oTGL5car3NTMBxTYqc
 2q1k2PF/a3jFzY/mCae3SAu8BbtmQwkQyBwLy6ImT6AQN0y2fP7t03dygyAZLvZtUvV3
 DLF6pdaVGYvgcKCntSX5OIVlIhXpWn2m9WKsFsaBiDQQszz9tETml//7/EzB3CcoJZ35
 4pNQQ1BEAfp3O0o2+jCjSFHRDcgNV3FXKWLNycvTUwN3zmr9OoUJyU6w8KMawp8mZ+Yl
 4uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751631302; x=1752236102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yim1rEzPel4pu+PfAZneNAEGt32iL8SSue5oPN+mJR4=;
 b=Xrs0f4h4T6z3GOwfkCCQ9T20Uyr8702inRvKT5eeOpKZ+kKF2XX06uFIKGeRILSUid
 yYdf5nWSAJGrsOEG7Q/P1EiK4Oq0EgnyDBwIcEX5QWqQA9FY3G7hAFB1P4TD5Aw48VjB
 0eFHmxuIMCrkZEfdMkR1OpEp4occwQPPsAJ77wkjFFMpaLM5vmwOxt9eEDQMpeWji/uo
 bB+Izb+shYa6VgVxqF/xvNyfs5rpw6dSm6myMnsAjERglgxNpT7a11Jk1+r5Fs9iNAl6
 S+36N/VScxt1KhQje8A6khxiHaVx50GnwqLT6u9aH0f7mPPsRYEu+DnXVViQT/BdV1El
 iIkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPDve+IU6TzEKIxq1NbCmomhXEBAFkt11bs063izp5La5EfnwKmuXI9X0P36Q/3T2gvnqXXW8/9Wkq@nongnu.org
X-Gm-Message-State: AOJu0YzBDLlwQ1Yvb7NP7j+/THDD0GsQT8lvtApRQ/hoU85CKBVLBy4i
 N6AGQzw2V30SKq7Yh42iDUASa/cDNxjJxhUfnf/Ho3DvCxaxw3P82ZbNBF83RRLpMkxl2JpM7C/
 WpS6Iz7/LWMgoBZr2lj8cU5OjNycHhlIYidkhDV5JpQ==
X-Gm-Gg: ASbGncuqCc59iGgF1VUcusd0gcSsdK7R6fOFEZ5mY8A/7czSgvSNYXblrNKQzbOcBME
 4bKNpQrH/z1xSglqwY6z2ajcXRH//GAjrsHhMBYy4foVM+glm5QtCHMnw1JqhGVPwzFyepYOs9x
 C2rPM/HFguI5dhWZK9SqXEiI9vIcMtKdARPxqpKQLil46j
X-Google-Smtp-Source: AGHT+IGoBwoaGQVH7nWc7tDC/eJyZ2kBXCEXTZzppq7Asc85tnvKSczyIO6hVwKvOCzuROExznn8VmRm5ylZWfkONE4=
X-Received: by 2002:a05:690c:4491:b0:70e:61b:afed with SMTP id
 00721157ae682-71667e2423emr33546617b3.7.1751631302462; Fri, 04 Jul 2025
 05:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-4-eric.auger@redhat.com>
In-Reply-To: <20250702163115.251445-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 13:14:50 +0100
X-Gm-Features: Ac12FXzlUZA2mdd605D54nUYuLELbwtpcCj1kcW_KBcQ-ibk8gKaJ9TVi0D6mIM
Message-ID: <CAFEAcA_4AAprfa_TV48rwbxx7ndjbFYy74ykQQ8s=Ej-nBe4EA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] target/arm: Enable feature ARM_FEATURE_EL2 if EL2
 is supported
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 2 Jul 2025 at 17:31, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Haibo Xu <haibo.xu@linaro.org>
>
> KVM_CAP_ARM_EL2 must be supported by the cpu to enable ARM_FEATURE_EL2.
> In case the host does support NV, expose the feature.
>
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v2 -> v3:
> - check pmu->has_el2 on kvm_arch_init_vcpu() when setting
>   KVM_ARM_VCPU_HAS_EL2 feature (Peter)
>
> v1 -> v2:
> - remove isar_feature_aa64_aa32_el2 modif in target/arm/cpu.h
>   [Richard] and use el2_supported in kvm_arch_init_vcpu
> ---
>  target/arm/kvm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index e5708e54ae..46e5f19637 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -250,6 +250,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       */
>      int fdarray[3];
>      bool sve_supported;
> +    bool el2_supported;
>      bool pmu_supported = false;
>      uint64_t features = 0;
>      int err;
> @@ -269,6 +270,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
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
> @@ -422,6 +431,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      features |= 1ULL << ARM_FEATURE_AARCH64;
>      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>
> +    if (el2_supported) {
> +        features |= 1ULL << ARM_FEATURE_EL2;
> +    }
> +
>      ahcf->features = features;
>
>      return true;
> @@ -1887,6 +1900,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
>                                        1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>      }
> +    if (cpu->has_el2 && kvm_arm_el2_supported()) {
> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
> +    }
>
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cpu);
> --

How does this interact with creating an aarch32 VM with
"-cpu host,aarch64=off" ?  Looking at the kernel, it will
fail vcpu_init if you ask for a vcpu with both EL1_32BIT
and HAS_EL2. I guess since the virt board will only request
HAS_EL2 if you say virtualization=on this is fine. Do we
give a sensible error message if the user tries
 -accel kvm -M virt,virtualization=on -cpu host,aarch64=off   ?

-- PMM

