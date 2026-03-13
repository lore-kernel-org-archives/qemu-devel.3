Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44F9105F789
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0zEg-0004TN-Vz; Fri, 13 Mar 2026 05:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0zEf-0004Pp-4t
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 05:55:13 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0zEQ-0001MH-TN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 05:55:01 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so1657962d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 02:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773395696; cv=none;
 d=google.com; s=arc-20240605;
 b=UddQ+n3ymVuTu2aFWD9wneb065uwHN7tcUuXsOyXJF8U4pDMWJ+mEJnP/JAtsN3jdE
 b/K327lHBeLZ9IGf2g/c7GvYGZWYi2gC0zt+7Dz9cY2wQY5wceJykQlE4ATsXbPNnw1s
 8tAX2vzzt82clkeqgketuHZbazMcMnOnMBiRD9kG+9dcrvf9gTCndmwSBWN8jmsraJo0
 f7EYeEpmN6avL0grlWnNodV7KmebUQfcvhM4PC/UvrYc61Pqr/0km9YNw+OEyYZYREt9
 nbISl7sDGFbf7turLkW6rs6QnoNUO/PGyF5huZyz+HYyfGJdR8vH12gZVGwvOkVLuYGw
 gSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LhPiD52RNj6EbcKK9bjjzvDMTUfuYexLC2HZLi5DX0o=;
 fh=sYPJnz1UouyhsoaalKxCjsNUsBe9fuLaxsWqzZBhmkY=;
 b=LlpvsiTieJXVCX3MiHaR7fO+YjOkGgV3/XUqZlEe2s2c8M5oOJhjGbu1Rhd2c+/tVT
 r6rO5lDDyTe4isZHokvXids4TMuMpvwsVPnTlelFOXPp9RnsyeILDYC7WI6KMFku1RBc
 0S75U4B4LMTBZX3+H2IaLc5vA5vmYG6+f08aBJjYeVP32x52MIHTC9ThNyhr8RUDZ8/J
 l/5F7iyxEh3wkyRP2tQUXH90dp6nuJ6RBm0XTNKL3KDySRiKUkZvnNNS/dP1zyvnFrOJ
 vBLDYgEPAwdl7BQnnzKQJJyIZFxvdPEsXrmLH/xoAZg4I125eboyUusLsrWZeN8e+Y9l
 nL9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773395696; x=1774000496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhPiD52RNj6EbcKK9bjjzvDMTUfuYexLC2HZLi5DX0o=;
 b=blOSs3LXLbTr4rMzoueeX0/m0eo6IWPChPfs9zm7YDYnYVxlw9Jr1Ac4Z7+Vco1L/J
 1hQX6kYBgH1Mmkg+JI7N7v7dOfD/pusYLqbaK3b54+rBGJZUIrWWY/87ssWcQ7tGdg3C
 6FeKSbZnGFCiRKiZCt6Gceu3TO2lbjltsYh+rqWicEy26TjOsBx3c45ckf87D4fAnUCF
 Y6Z0KIkwVpZy1e05MwPFv4aPTJpUS47nb+DZPIi3pDPpN1wyH9t/9jq0ANxO9FExVouL
 I1YlNXug4CzW2/uxv+B1/NKB1ntN0qeSjRfIcttdmeTWvy+Rnbcl3v5Zvv1ZCMdI9LSY
 Z9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773395696; x=1774000496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LhPiD52RNj6EbcKK9bjjzvDMTUfuYexLC2HZLi5DX0o=;
 b=h9w1/2rjGxI2+Wiytr4mAIVPZgC6InhprdZYm6iJKJC0IzAzdA9xXTgszkCEi82liN
 AhjYR/c0vkS61t++ICcDPVop+Y8rbYFSdH1fP7JVV9C/jDaZt1JiPoSJiteHQ3ceygMQ
 QmhVBi8aKSoGGVIplH3oem9uBvj8rrCO2tX379HSkSSCAseGhE4cMS08+q5eOFk+Ozc7
 a1ClZosmWyOVtZJ0RHmKkFNa+7RuiZAbWMe2Ls0334V8ZTa80gywc1RdnGut9tA2R1g2
 3vbYPSRLie5ebLdDdSFzNngEUyv320PCVNXrOR89Z0s7MXtCGq3R8XmSaKPay5NNsccF
 1kHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9h3GfZh8QPJZWfGTRXC78x0z/SSkJuH0V5CiU4Hcl19TBVysFR6qeMQmPmKpLJzqLcf5Z622dq/bZ@nongnu.org
X-Gm-Message-State: AOJu0YwD/sBYKfF2Hfl0kXqtxriF0lMsQAKWV9HtVOpZSjzQv9Dg8o2c
 /IoI3c57Nf2ajjXi0QEMVEIjYZqH+G7JbfR+3fsbMupJhgPGPVe4hQ55Cr70sWkOE4pboYRNwYl
 QBRyUTSGpCXzbd/AvI6/g6yynaDrzZEV1kFDTlTNHIw==
X-Gm-Gg: ATEYQzxCgsP8+FqPZAVMSD5XzCaWpLsArnnhwn2ntYNuCIGDeDfD38/j2wMic9KaoKP
 oMX9eux8UhbnGQiWLpotUxeCCcj2oOINH/HmD5abv0ugQYqwpJJZ2BlF8DnZRuSmx7tBkZ/zAQR
 aGr0Mb3vmcR/HZlRHl8qEZkJ56mhN4Ku5ZzrbpUg8jv38uzEKVU6f/ic1Mw8o7JnerSC0oXqKNK
 HkVmWTF1IQKczc7IgcPIdM7jBT4ItukZUdRqk3H4+X+agSSbl3sSNBTSpcbk747gTLhX8emPQFp
 8DfSJZaZtM0Pp0vCZJbDVpSOqmzTZJSGB3YB3XU8xM6FjFWAlCjmVAemdE7ZVDf54+E=
X-Received: by 2002:a05:690e:2058:b0:63f:7de1:7acf with SMTP id
 956f58d0204a3-64e62f5457dmr1915432d50.22.1773395695626; Fri, 13 Mar 2026
 02:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is>
In-Reply-To: <20260311095405.26297-1-hi@alyssa.is>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 09:54:44 +0000
X-Gm-Features: AaiRm53V8rzJfK3MJW8n0DXsZoYKtviPOaIt4_CWlAx8D1oHFxJ5NOaKNR1uC9c
Message-ID: <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
>
> If I create a machine with more CPUs than KVM supports, but specify
> multiple accelerator options, QEMU will fall back to the next
> accelerator.  This is great, because if I've explicitly specified
> multiple accelerators, I've told QEMU I'm fine with any of them being
> used to provide the machine I want.
>
> When I create a machine with nested virtualization enabled, though,
> this doesn't happen.  KVM often doesn't support it, but TCG always
> does.  The nice thing to do would be for QEMU to fall back to TCG if
> KVM can't provide, like it does when too many CPUs are requested.
> This patch adjusts the behaviour to do that.
>
> This is very helpful for OS development scripts that run an OS in QEMU
> =E2=80=94 I want everybody to be able to run the script, always with
> virtualization enabled because the OS requires it, but for it to take
> advantage of KVM acceleration when available.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  hw/arm/virt.c    | 6 ------
>  target/arm/kvm.c | 8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7456614d05..0b63b2eac3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
> -        error_report("mach-virt: host kernel KVM does not support provid=
ing "
> -                     "Virtualization extensions to the guest CPU");
> -        exit(1);
> -    }
> -
>      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled(=
)) {
>          error_report("mach-virt: %s does not support providing "
>                       "Virtualization extensions to the guest CPU",
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index d4a68874b8..20dcc6a820 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -615,6 +615,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          ret =3D -EINVAL;
>      }
>
> +    if (object_property_find(OBJECT(ms), "virtualization") &&
> +        object_property_get_bool(OBJECT(ms), "virtualization", NULL) &&
> +        !kvm_arm_el2_supported()) {
> +        error_report("Using ARM nested virtualization with KVM requires =
"
> +                     "a host kernel with KVM_CAP_ARM_EL2");
> +        ret =3D -EINVAL;
> +    }

Looking a bit closer at this, it's a bit awkward that we're
looking at a machine property in generic target/arm code.
There is no guarantee that the machine is "virt" or that every
KVM-supporting machine has a "virtualization" property, and
the target/ code isn't really supposed to do board-specific stuff.

The board-independent way to say "are we trying to enable EL2" is
to look at the CPU property has_el2. But the CPU isn't created at
this point, so it's too early to do that here.

Similar things where the early accelerator code wants information
from the board we have handled with a method in MachineClass,
like get_physical_address_range. We could do that here, but
maybe it's a bit over-engineered? IDK.

There are other cases also where the virt board will error
out for "KVM and some config we could do with TCG":
 * KVM + EL2 + GICv2
 * KVM + EL2 + kernel-irqchip=3Doff
 * KVM + GICv2 but host hardware doesn't support GICv2 emulation
 * KVM + GICv3 but host hardware doesn't support GICv3 emulation
 * KVM + MTE but host hardware/kernel doesn't support MTE

The first two are "always fails", but if we're going to have
a mechanism for "figure out in kvm_arch_init what KVM features
the board is going to want to enable" then it might be nice
to also be able to use it for the last 3.

-- PMM

