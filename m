Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4177DEE20AC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNJI-0004Rt-Gi; Fri, 06 Feb 2026 09:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNIw-00047T-MZ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:59:33 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNIu-0000BZ-3i
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:59:30 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79456d5ebf9so8758417b3.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 06:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770389967; cv=none;
 d=google.com; s=arc-20240605;
 b=Z/MatQ/eoZpOIhymUSl+7boAWhv57v8b+qQf4Vng5L4j0IOQefFyL+SUyP/AgSJli8
 HYUYUjHdxcifAEeENrp/Pn2mSIclyDBUYMqNhdudBGfYmFzguDSsVwgR+iEei7gRIQiW
 RXd+5vasS2cq69k1ca+bvNtcPyPWYYqMJ8HyfJ/Q6ID/E2+m0iQEFL6v640H9wpn9svo
 DcJAzmeu5vu9cib5apGkJNxiWQ3xqDc9qjJZj1iJBSP1rw9US6xvqMHij/lG/yHF2B6S
 OmFChrHCUZ+fFu1YGZvQydrhuJ9agphTrJNCK/1C2e9Yv878SbPbkByiJ7isHqZnTgY5
 RJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Djjd+78eL/gLTndXMnYafFf7JN6pIz42e4sPAJ7o4XM=;
 fh=EQxqgLWoW3xrRuA0t22tcEV7rqDjFpaH8wIk1fjO7wU=;
 b=N56Au+jjFUJlwCr/dzYdzZ73CCe536gM9HPYmXtQkFwrC9N7UUXOQ1hoNO3yzUkzWL
 cKYTjJE0KXOlrNdVvQJJrD66H84RfjL6doF3FjpJhcZTHoprspqYSS2zYu69R1OZe8L8
 ER6qOTH4lRyG2b33/AfrYki9LUGMyQxSs+g9uFhypWeFDZ5gSCWi23OKa8Qmz1lgvTzr
 yOPFl3oTJ24mQhzSw43DxWVoO3Kqbdb0yskHK9IQ0GovmAQE9Zaukns/rJBJISLHIQ64
 p4QUhkqsHVpy9N/R/YYmG8tGU6f5yHdoFHosYvyOmsz9ZPoTS/GbLkQjyQI3Wz4EjNNe
 fM1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770389967; x=1770994767; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Djjd+78eL/gLTndXMnYafFf7JN6pIz42e4sPAJ7o4XM=;
 b=zO5J7aIkjGdjVnYht3yp5JypW3O2H4v0yBkwgKEo9dquR9w4JNqyttrBo40UGSe3De
 Lvy+oJJ47//0sEV8E0eO5DBh4Mxit0tojq+d3ll29P85zDkNlvLm783NNFWlfcZX6buU
 sWNW+xS8HMhnVaVhC1g8b7F4ts7qUoTgDdHwt5HcXpzxzt4HETUCwkdzZf8ZfJp695mA
 okdsnjJ6Xe5S1JLap1sRFRm/sSaDu8lws/xYtOPxkDVu4YEB5kNV8kFjuzE1SBb1t8Al
 nixt+wewHy+49jGVcBEssfwn5sKKx511rizjsfSZIJx0G/7mFa6cZ4cTZ7DBtsX46YJr
 4+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770389967; x=1770994767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Djjd+78eL/gLTndXMnYafFf7JN6pIz42e4sPAJ7o4XM=;
 b=RA2XH/fRGPEl1kp/1jt/JAgyB5qGo1rn0/Ra7fn8EXdYhon1MBvfplVE/+uglQi48J
 hm2wUJFMP+tBURT5ipyjNZ39M2as5ZawV/UileyMRuaq3nu/Ey0HsZ6+/52UTNebanw0
 3iSVVKI0oTp6Ebv/VCF+HUN1figQKXFaqbrLGwUMX3MsspPSSKF82o88KEJrmiqGzMNS
 tnPyQyINLjNYIvbJximBrikyJBcd/VkhZ3L+fUK+hk8TkjFFRwUBPEIjVIi2I62tvvuH
 tk9FHy7iEDJMKih963PKgr9uFnjMIGEuwWU3AkfnrAulXn05K0XfEnJuYRku3YCatH4w
 81bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx2Nf8h5jCaLrgFnBFXrBL/uT2WO2xiadbaPvNd1mqSv4XzUk0JfMoOp8UkHWk135AoYg4/OYrmnXy@nongnu.org
X-Gm-Message-State: AOJu0Yz2KNe36ihei2JMH7nnL/Xo5Fo9j2IY8mTM3Osq4eAZecMSwpP5
 oL2bSenK5FysIdru6Ajo+rhoOAk7fgsY4zuu4/eR/I9zx7t7gZPmYtsMUpefBHgepyScn4R2c0b
 SxZVB974F4dDZl3QWvQ+uatRX7QvnpBuw+u9r9rKoPw==
X-Gm-Gg: AZuq6aLocYjPveRaX/xQL9nFv9/IklV7gR52kC0pw/iAqMihWVqxv5dVhQXtUrwNo8I
 7Z5shqtr0b2Z6QCaHyVqIftJTip06YTck3dBtTFMov4Zjo3XGw5yBoYJGArDvmowA21KouMiCKA
 WHLWYh82PfQuN0+cRSrzgWP3boyr5efhSXs9Vu4wfRknKeQtdRbCjF3dVb4xPXWKNexlRALd6PG
 uXFeAQMZsu3JbpkLL4rNRw2cSQBvrlGO6mYWUXOu53xaXygRJKEQ7SFTS9Mkcvyzp4C+/v7oGpw
 nyosdnpDMHiGKOkUE3Gq/Rri1bd6QIpFp48GDk+IUhMyvSNkl+a8iR8=
X-Received: by 2002:a05:690c:88a:b0:796:2976:a452 with SMTP id
 00721157ae682-7962976ac35mr4095557b3.23.1770389966783; Fri, 06 Feb 2026
 06:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20251202160853.22560-1-sebott@redhat.com>
 <20251202160853.22560-3-sebott@redhat.com>
In-Reply-To: <20251202160853.22560-3-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 14:59:14 +0000
X-Gm-Features: AZwV_QgieJzeeTFJCFpBW88yIXQg35x305xf0x9-4d4AF9icH8OLR1uAx6S_ojM
Message-ID: <CAFEAcA8oi1Xs2kv66dFV9NZore+Q2vHUsgMikveVdN1c+3SBJQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm/kvm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 2 Dec 2025 at 16:09, Sebastian Ott <sebott@redhat.com> wrote:
>
> Provide a kvm specific vcpu property to override the default
> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>
> Note: in order to support PSCI v0.1 we need to drop vcpu
> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst |  5 +++
>  target/arm/cpu.h                 |  6 +++
>  target/arm/kvm.c                 | 64 +++++++++++++++++++++++++++++++-
>  3 files changed, 74 insertions(+), 1 deletion(-)

Hi; this patch seems generally reasonable to me as a way to handle
this kind of "control" register; for more discussion I wrote a
longer email in reply to Eric's series handling other kinds of
migration failure:
https://lore.kernel.org/qemu-devel/CAFEAcA-gi42JObOjLuPudABX8WRdWf5SzSbkzU-bd06ecF1Vog@mail.gmail.com/T/#me03ebff8dbd8f58189cd98c3a21812781693277e

Unless discussion in that thread reveals that we have so many of
this kind of "control" knob that we would prefer a generic
solution rather than per-knob user-friendly names and values,
I'm OK with taking this patch without completely resolving the
design discussion on that other series first.

My review comments below are fairly minor, and patch 1 of
this series has already been applied upstream now.

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

I think we could be a little more detailed here.


``kvm-psci-version``

  Set the Power State Coordination Interface (PSCI) firmware ABI version
  that KVM provides to the guest. By default KVM will use the newest
  version that it knows about (which is PSCI v1.3 in Linux v6.13).

  You only need to set this if you want to be able to migrate this
  VM to a host machine running an older kernel that does not
  recognize the PSCI version that this host's kernel defaults to.

  Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3.


> +
>  TCG VCPU Features
>  =================
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39f2b2e54d..e2b6b587ea 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1035,6 +1035,12 @@ struct ArchCPU {
>      bool kvm_vtime_dirty;
>      uint64_t kvm_vtime;
>
> +    /*
> +     * Intermediate value used during property parsing.
> +     * Once finalized, the value should be read from psci_version.
> +     */
> +    uint32_t kvm_prop_psci_version;
> +
>      /* KVM steal time */
>      OnOffAuto kvm_steal_time;
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69..cf2de87287 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -484,6 +484,49 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>
> +struct psci_version {

Nit: our coding style says struct type names should be in
CamelCase, and structs should have a typedef rather than
being used as "struct foo".

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

Using ARRAY_SIZE() to set the loop bound is nicer than requiring
a sentinel value at the end of the array.

> +        if (ver->number == cpu->psci_version)
> +            return g_strdup(ver->str);
> +    }
> +
> +    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);

Is this ever possible?

> +}
> +
> +static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    const struct psci_version *ver;
> +
> +    for (ver = psci_versions; ver->number != -1; ver++) {
> +        if (!strcmp(value, ver->str)) {
> +            cpu->kvm_prop_psci_version = ver->number;
> +            return;
> +        }
> +    }
> +
> +    error_setg(errp, "Invalid PSCI-version value");

"PSCI version".

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
> +    if (cpu->kvm_prop_psci_version != QEMU_PSCI_VERSION_0_1 &&
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
> +    if (cpu->kvm_prop_psci_version) {
> +        psciver = cpu->kvm_prop_psci_version;
> +        ret = kvm_set_one_reg(cs, KVM_REG_ARM_PSCI_VERSION, &psciver);
> +        if (ret) {
> +            error_report("PSCI version %"PRIx64" is not supported by KVM", psciver);

Could we make the PSCI version human-readable rather than hex here?
If hex, we need the leading 0x.

We can also suggest to the user the solution to this problem:

  error_report("KVM in this kernel does not support PSCI version 0x%" PRIx64 ");
  error_printf("Consider setting the kvm-psci-version property on the
migration source.\n")

(watch out that error_report() strings end without a trailing \n
but error_printf() ones must have a \n.)

thanks
-- PMM

