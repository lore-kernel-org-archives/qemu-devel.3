Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C41CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQJE-0005y2-HW; Mon, 27 Oct 2025 12:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDQJA-0005w8-VX
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:43:01 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDQJ7-0007pj-9S
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:43:00 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-63e1a326253so5215789d50.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761583370; x=1762188170; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iIqSimi39klofHZtZnL5Vj2K3y0rXxrFl3z6jktwTZo=;
 b=ZBqGr22IMs91mfamvtGC9ODmUlayhO2pnq7/qn8v2QOGf2jfQ5MwSYa5fgSgdyy613
 aD6LrxXkQWrlm7dc65Ww64if/n+jRa5hKaFOv+KHSRHRq9dv32tnWdHmUXo0zI+Dnpnb
 IZ5Xcn2czhzFRIbdCHOONvDMmSlrQCEFLUkfsKFI4wYGZ/3djE3Rgj6xZbLS54Nhm1n9
 OryC2OJktoxrGD1eXEScWhpHKijypenldkP2VJrcKmXvxkFam1FF3jCHs59ucWc5kbDP
 +HSWBFnLMk5o+VKeczdQUi2HLodBKYxn3rZZynV5WxjSgyEFORF6B3ZZmXl5wsVBvC6f
 Zs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761583370; x=1762188170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iIqSimi39klofHZtZnL5Vj2K3y0rXxrFl3z6jktwTZo=;
 b=IRJrZISIs5pnCw80rfhxcuwN2uSLv38zofB66rskKMyB5dXUsKmD89y0CaaAUlEA+1
 xWZtd+OgHQi7YAjX6cEkqzBrUQGktpFgcA22WJfatI/7HWhdIMVLdmLtQw4iicTWTyPU
 NUc7I8GwyeF4fPrqo/W9YI+6Tt0MNfIX8a1C8p1ybSnj1GrNSivXlTICsCtkNnr8jF9m
 hnqA46e1+v25Xftv05HgAdFDth4DtFJpw6aHU3jUVZvP6Z2xfFN/yh048Kamc1SjyuvO
 zGIJwVI5p+xdyE0OAzs8oyMT6s0qZw/kj2+bUpm8f4nI8EAIHsUeUt9lvUJgH9xK4fng
 ghyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyHpYd/IhT/AUHlCNsXzl6UyTnpTRDNWrxHEVqXltwJlOI7Ckz//TwbrP2WReahB68hhG5duVaRJK2@nongnu.org
X-Gm-Message-State: AOJu0YzlFEwktntou67eAE+Oya3751srQd2zO2+PemNAEwE0Wjc3Dk1I
 yRCarUxfc+hC6xPTk84B98kFOH4CKTynDfMKZCQzVSKY7n+cuPNt5+BKj6uZ21WMbspfHqyG9GK
 AEaCpBB4a0Lxjm70ruF9lpiFWlLms4cfM6lCt2Qi6Dg==
X-Gm-Gg: ASbGncuoVKEWHDYKERSgrXAM2iTHPdFchVTFSXE14FNXVZqxD0qO69jVuZsqdYtzLiB
 355aQSFkefWsrwweda9ddDbzHXECuCcCihAW5jFXKd6JueywfBPCgYIpWzcOEH2YzqOuVt5F25q
 gD88ClxIOdWQRm0o07l1yBO3qHiGWsOf3y75kJq/UFVJHtE2HuOr8Ca//9nqhXofjp97gehL1qE
 WR9pwINLhD9tloKJPbHs87bbBEg0UXRa1ojk/56Z85CvRpjYIBmF+yroeDdlQ==
X-Google-Smtp-Source: AGHT+IFnTy4GuL39gQqo5cO5/AtjK3ueLANt8SL8mKD6Wd3Al0HmUJPCwVFv88tqthud15vc4T2fVPU5v7ZGG0ZTM0s=
X-Received: by 2002:a05:690c:a90:b0:784:a6d4:dc21 with SMTP id
 00721157ae682-7861838ccc5mr3677497b3.52.1761583370329; Mon, 27 Oct 2025
 09:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250911144923.24259-1-sebott@redhat.com>
 <20250911144923.24259-3-sebott@redhat.com>
In-Reply-To: <20250911144923.24259-3-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 16:42:39 +0000
X-Gm-Features: AWmQ_bnGFe7efhNQOt02HzPY7w4uzHv-6KQOwTPx1B30MSJa7HImhr0NK5nCCdw
Message-ID: <CAFEAcA-urFX=V7kuRA3cRik7PifFQER5eoXC_CZ2jKg7OZz9iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm/kvm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com> wrote:
>
> Provide a kvm specific vcpu property to override the default
> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst |  5 +++
>  target/arm/cpu.h                 |  6 +++
>  target/arm/kvm.c                 | 70 +++++++++++++++++++++++++++++++-
>  3 files changed, 80 insertions(+), 1 deletion(-)
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
> index c15d79a106..44292aab32 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -974,6 +974,12 @@ struct ArchCPU {
>       */
>      uint32_t psci_version;
>
> +    /*
> +     * Intermediate value used during property parsing.
> +     * Once finalized, the value should be read from psci_version.
> +     */
> +    uint32_t prop_psci_version;
> +
>      /* Current power state, access guarded by BQL */
>      ARMPSCIState power_state;
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6672344855..bc6073f395 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -483,6 +483,59 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>
> +static char *kvm_get_psci_version(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    const char *val;
> +
> +    switch (cpu->prop_psci_version) {
> +    case QEMU_PSCI_VERSION_0_1:
> +        val = "0.1";
> +        break;
> +    case QEMU_PSCI_VERSION_0_2:
> +        val = "0.2";
> +        break;
> +    case QEMU_PSCI_VERSION_1_0:
> +        val = "1.0";
> +        break;
> +    case QEMU_PSCI_VERSION_1_1:
> +        val = "1.1";
> +        break;
> +    case QEMU_PSCI_VERSION_1_2:
> +        val = "1.2";
> +        break;
> +    case QEMU_PSCI_VERSION_1_3:
> +        val = "1.3";
> +        break;
> +    default:
> +        val = "0.2";
> +        break;
> +    }
> +    return g_strdup(val);
> +}
> +
> +static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    if (!strcmp(value, "0.1")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_0_1;
> +    } else if (!strcmp(value, "0.2")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_0_2;
> +    } else if (!strcmp(value, "1.0")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_0;
> +    } else if (!strcmp(value, "1.1")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_1;
> +    } else if (!strcmp(value, "1.2")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_2;
> +    } else if (!strcmp(value, "1.3")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_3;

We already have six values here and it's not implausible
we might end up with more in future; maybe we should make the
mapping between string and constant data-driven rather
than having code written out longhand in the get and set
functions?

> +    } else {
> +        error_setg(errp, "Invalid PSCI-version value");
> +        error_append_hint(errp, "Valid values are 0.1, 0.2, 1.0, 1.1, 1.2, 1.3\n");
> +    }
> +}

thanks
-- PMM

