Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C4ACF857D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM1dy-0003nu-61; Thu, 20 Nov 2025 05:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vM1dt-0003ky-OB
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:11:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vM1dq-0006Jq-EM
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763633513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiSt72GIoNCo+Zbs/Mg7U6K+qgO5xzGmnbJap4V+VSA=;
 b=Sjts/tCFd0FeVZrapRZUF85JKPyK40CgjV1UFeebEfj8XW78dOWuSHp8ZeX+Vo1UffNYsI
 M5EDPNRABKZNvf7CMDrhwkeMpZbngChkl7srUa6xfAc9O72zoXc7IyZc5TWnMolUzoZar7
 FbOOQSKfZDr3CcWPS8EpShKZE1txaMc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Er7Ve6cQNcmz6tHgJ6hYAw-1; Thu, 20 Nov 2025 05:11:50 -0500
X-MC-Unique: Er7Ve6cQNcmz6tHgJ6hYAw-1
X-Mimecast-MFC-AGG-ID: Er7Ve6cQNcmz6tHgJ6hYAw_1763633509
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47754e6bddbso4782695e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 02:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763633509; x=1764238309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiSt72GIoNCo+Zbs/Mg7U6K+qgO5xzGmnbJap4V+VSA=;
 b=lmN4IQCcx2+0gIjafqPAm/7rWcYdI88ZfsAbKBp2qQs/IzJ3iZWUQ2+1VhGu50dO3p
 uC7lM+oduc4TydHLspPAYlojF/0uyXe6wDcWBTEYZ+1YzcloLKUVcLjuT0H/Ak05MZMk
 A3nKAUNkJqgpB2JESplSbUwne46ppTeUuqIayCnYW7WUxeX5YpotVGfPgdxa5/WGeD1I
 1a5m+KID1kWqaWbavuONV5turpzyPl6eHFQKGMWkeGZkgeks0ziNwOt+Tc+OTssZTgtp
 tV6aHFAn7gF578sBg20VYEhaBhTEZzQyQKkZh2qHFCbsEVSC/O7ADA06xCYm8ICo663j
 eJiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDIONZjdq72KqCmKGSTWlXtEEs26cA807xF9thA0s9pZ1kNF/FhAsKBS0KPQAsMzmKCvlMLnBg0XSy@nongnu.org
X-Gm-Message-State: AOJu0YxwiXRm+tX1/pxoDmUFUTcwrfwS3VcUoImuYwGwbB4VgsHnX565
 Zk2rVhQX4k5Dj3niehJCpDBcjY/ovGnIl3HFrwPJwQTm7v2EEt0R7B4PJYlb5X9Dt6yvlRLDrr1
 sX4NSyHWI8R182Qjt+epXol8rwIxz0nTyJlhD9kBPoJ8SO/XZdkQs/QBf
X-Gm-Gg: ASbGnctj7aNrxyrwGODfLO/sDm/oSvEjNiqFDWixL8joRgSx1Wx8/R+CGw/HyQdQmFJ
 rdiLdfNPxWh+GpxX72b9BmekY3VHM6b5sqKafxu71Zzm51LE4Nz16qJaLestQdTf7Oa4AjrGlbN
 +zAyKk8zeJQVrebXwRoyBykU3rgfPrdEc495dUOO+bJXBdsqnyQwW0TmBwhMmtplqv6AgesZNi1
 R2T/r9IxDo1lSGVtQniVVRLBvEr0n5RzSubLobQbXAfveRbx9EaaGzurdHJvyl4mM5lUNaAd3QX
 uW9YSKckAs2T7KbbW9Fpmcob7m3IJtPz68ybvWDHjKiBcbthz8V6MF8kcg/inq9udVPUJClycHR
 xV65l5gZ/LD6xzzCFgErvPicTaWnX87HxSQzsLL7sbccPf8mARM6GziqwoQ==
X-Received: by 2002:a05:600c:4f4c:b0:477:7479:f081 with SMTP id
 5b1f17b1804b1-477b895aff7mr32256075e9.12.1763633508833; 
 Thu, 20 Nov 2025 02:11:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyZsKxZ7eOZkXPyWcc4qYqZdgL9i/jMwKRrzVg9ugodScsHxJKDhP2GIBuvHdk1RA9oxypdg==
X-Received: by 2002:a05:600c:4f4c:b0:477:7479:f081 with SMTP id
 5b1f17b1804b1-477b895aff7mr32255505e9.12.1763633508319; 
 Thu, 20 Nov 2025 02:11:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1025707sm95706595e9.6.2025.11.20.02.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 02:11:47 -0800 (PST)
Message-ID: <a4e05081-df69-4183-a585-f4bb1d0a6256@redhat.com>
Date: Thu, 20 Nov 2025 11:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/arm/kvm: add kvm-psci-version vcpu property
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20251112181357.38999-1-sebott@redhat.com>
 <20251112181357.38999-3-sebott@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251112181357.38999-3-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Sebastian,

On 11/12/25 7:13 PM, Sebastian Ott wrote:
> Provide a kvm specific vcpu property to override the default
> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>
> Note: in order to support PSCI v0.1 we need to drop vcpu
> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst |  5 +++
>  target/arm/cpu.h                 |  6 +++
>  target/arm/kvm.c                 | 64 +++++++++++++++++++++++++++++++-
>  3 files changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 37d5dfd15b..1d32ce0fee 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -204,6 +204,11 @@ the list of KVM VCPU features and their descriptions.
>    the guest scheduler behavior and/or be exposed to the guest
>    userspace.
>  
> +``kvm-psci-version``
> +  Override the default (as of kernel v6.13 that would be PSCI v1.3)
> +  PSCI version emulated by the kernel. Current valid values are:
> +  0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
> +
>  TCG VCPU Features
>  =================
>  
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39f2b2e54d..c2032070b7 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -981,6 +981,12 @@ struct ArchCPU {
>       */
>      uint32_t psci_version;
>  
> +    /*
> +     * Intermediate value used during property parsing.
> +     * Once finalized, the value should be read from psci_version.
> +     */
> +    uint32_t prop_psci_version;
nit: as it is a kvm only thingy, could could rename it with kvm_ prefix
and move this along with the other kvm_* elements
> +
>      /* Current power state, access guarded by BQL */
>      ARMPSCIState power_state;
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69..e91b1abfb8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -484,6 +484,49 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>  
> +struct psci_version {
> +    uint32_t number;
> +    const char *str;
> +};
> +
> +static const struct psci_version psci_versions[] = {
> +    { QEMU_PSCI_VERSION_0_1, "0.1" },
> +    { QEMU_PSCI_VERSION_0_2, "0.2" },
> +    { QEMU_PSCI_VERSION_1_0, "1.0" },
> +    { QEMU_PSCI_VERSION_1_1, "1.1" },
> +    { QEMU_PSCI_VERSION_1_2, "1.2" },
> +    { QEMU_PSCI_VERSION_1_3, "1.3" },
> +    { -1, NULL },
> +};
> +
> +static char *kvm_get_psci_version(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    const struct psci_version *ver;
> +
> +    for (ver = psci_versions; ver->number != -1; ver++) {
> +        if (ver->number == cpu->psci_version)
> +            return g_strdup(ver->str);
> +    }
> +
> +    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
> +}
> +
> +static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    const struct psci_version *ver;
> +
> +    for (ver = psci_versions; ver->number != -1; ver++) {
> +        if (!strcmp(value, ver->str)) {
> +            cpu->prop_psci_version = ver->number;
> +            return;
> +        }
> +    }
> +
> +    error_setg(errp, "Invalid PSCI-version value");
> +}
> +
>  /* KVM VCPU properties should be prefixed with "kvm-". */
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>  {
> @@ -505,6 +548,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>                               kvm_steal_time_set);
>      object_property_set_description(obj, "kvm-steal-time",
>                                      "Set off to disable KVM steal time.");
> +
> +    object_property_add_str(obj, "kvm-psci-version", kvm_get_psci_version,
> +                            kvm_set_psci_version);
> +    object_property_set_description(obj, "kvm-psci-version",
> +                                    "Set PSCI version. "
> +                                    "Valid values are 0.1, 0.2, 1.0, 1.1, 1.2, 1.3");
>  }
>  
>  bool kvm_arm_pmu_supported(void)
> @@ -1959,7 +2008,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      if (cs->start_powered_off) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
>      }
> -    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
> +    if (cpu->prop_psci_version != QEMU_PSCI_VERSION_0_1 &&
> +        kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
> +        /*
> +         * Versions >= v0.2 are backward compatible with v0.2
> +         * omit the feature flag for v0.1 .
> +         */
>          cpu->psci_version = QEMU_PSCI_VERSION_0_2;
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
>      }
> @@ -1998,6 +2052,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
>  
> +    if (cpu->prop_psci_version) {
> +        psciver = cpu->prop_psci_version;
> +        ret = kvm_set_one_reg(cs, KVM_REG_ARM_PSCI_VERSION, &psciver);
> +        if (ret) {
> +            error_report("PSCI version %"PRIx64" is not supported by KVM", psciver);
> +            return ret;
> +        }
> +    }
>      /*
>       * KVM reports the exact PSCI version it is implementing via a
>       * special sysreg. If it is present, use its contents to determine
Besides it looks good to me.
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric


