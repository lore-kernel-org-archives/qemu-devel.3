Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD00CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 11:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZCd-00071s-Jh; Thu, 28 May 2026 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZCb-00071R-SI
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:47:05 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZCY-0000Bt-OL
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:47:05 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660390acd71so891787d50.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 04:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779968811; cv=none;
 d=google.com; s=arc-20240605;
 b=fPk60tEWJbWjKlOWsBlxyiBpPnzO0gDCL0e88r5cceP2ib9H2kpZbONDdKwftAH00x
 0aJgTWk/RFO1yOhV/c+tlwGHRoXKD5Rsd4e90mYnocPabI/UC/uDppADWhafji6LtG4I
 VXqTUFXaF+oSWQLoh6XMFkGZ55G6AoPb0kmc45TbYY5fqRP164W852TSijlExacJrFyT
 NI4JWdUjmDhCc/V2iLLmYVBB1abgNzJkYjQyqlfUU2nx8DEPDDU9Hwzew5Vz27P5YThW
 3XXnBXYe7yA2vtL9uPEBk4Zxsgbu/ffg7qRYVvi5rc0cm32rMnYhpUlUnT3eWsEn66k9
 qDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AARFfInjdTq1HjFa+4wPYDxz7bx/3pycCU0DkHnctkI=;
 fh=2hOIVVY9vsSR5Jcyq5CVLuIMJSviI2SHiNyK7aF62cw=;
 b=kw01glik+Vs2GrGeMcODdDgC7kexr/M1H1bcYPxlR2tawXsRjCB1i8nEY1K721afHv
 G0dwZbKJXHvzAqitRflENv98ivXofA3W8SlTLJynPYTtPJlaRw5yuN4S0WgjVTxlEQ0X
 Naq573VUSE9Zi6ShFaJ1/takoSreWHyQH1vKuKkBmK6oMld0pIdf4RenooCfx6i7J+t5
 kjaamVWqT2dfI84izS2y1gMti1rMV1h98uVfybbt5gy+KANopOWyFE5QTBM2QavUJ3yO
 3D350qhEmONlweAdZyf+5Xkzyn6mq5wv3zhuau1aUKNKy3vxPAduJhKakjG7rIy9VSah
 MIcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779968811; x=1780573611; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AARFfInjdTq1HjFa+4wPYDxz7bx/3pycCU0DkHnctkI=;
 b=lfdquFq9N7FVRPxhuzNK2Q0EeEWI1s1ijHMf7rTco+eYIVyWS0T07itjAzS+XjLYvC
 wNJ0I876KNmteVktLbnSSqAVFVUyMY9Z4t4+wdXhx/fKclJQtj3AgDLwOXQu93NzJZwx
 a3Qw0P4S4behqmyrYBGvG1iXsP2GaycSOVA1cJn2pRig9ns2wGqaRj5OjjPoAnggeE+A
 z2BtR/7dRnnD1tabg1gdG5JCXFt2iHuFbPm5gfZddbhRGjqhBQwE4BG5BB0+YzP1eoyB
 rxOwqKkQZnK9SEXPsc982T9biaKBMpjNiBYFREmIgIXkZ/vG7rQndFj7Y0Cuqec2kzQD
 gWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779968811; x=1780573611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AARFfInjdTq1HjFa+4wPYDxz7bx/3pycCU0DkHnctkI=;
 b=DP5KV9MUGYGXz1IQnNE3uHw2Yn3Qbn0DGFWa3qOYUJZpa0b2GfUaTEdmlgEBC+yEgn
 DDwS8K1E6RLlTx27frPtW/D0axHK05JS3s25a6QsHdzI237ViHp+BQTvroEyOWSjfn3w
 QvPiiskN23FNHShUI1SUZ+zFnEEpbNQK33aB9rfUxCBH2+tYAH9dp7HUQDK3Kik/WKdz
 mc5isVxwSOUzkIHum+lzWtp8BZEEQ5VG0axQ1JlCQUpap+Vn2mmEEnvOlX2h7NcVvhaX
 jZNbgNw23LXra1kEz7feCFm/4+QzRxjya0skM+VsZDG8KYnV1FaTuPEEN19siLLEDvQo
 Tf6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gGbamIZngnlhWeFNJuicKd3Nbvu1Kx2g+5gkkOiTwU8cBa9Fio73Oo7j/IGVqJlVsAZLBMAv5/qk/@nongnu.org
X-Gm-Message-State: AOJu0YyQSbcHJOEJtG7Wbs2nJqnIH0reD+bQqM+znQkbRM69RJBmpKLu
 aO8qAgBlIKdwfZZPlsDc0TU4Qb20wPGH58KRaL4w89IeSEp11SIW01nKS0OSWWc6zCbjLjFusIQ
 O732UGD0JWEg8BUAUfYAYQ343pjre4C8HP2dj9Y1TEw==
X-Gm-Gg: Acq92OGIHfdEfFKKbHpf7ZXo2f2qHU0LX16Drs2fSpc+QAIwfZWzDWbjkCII5gloqZ/
 /M3VoRAntXzyPILYuK9IdpBe01UJFYofHqGrxbvwGVLtUkAW9Rd69lB+TImImClHZmvLJMqdbvW
 vghV0j03ctLyInYy21BjOmJoq8cDOHNeDCW1e3Z2Ud+eIVjbqMvUQ0uuFxEFR6LYTDqrk+keiOV
 ZV2NXf3ozuUGcZnhYHfmZpM/OmESuO2zbjaUXa7jloJsJh7yxrKmf8Evqpom7aI07idzWYrwf22
 F2wbVSZsnLVZGc2X+FbfN6vc7YIRoRgK2oHq7VU9qdDOHJx/okf0jyHa7sPjsXCgzBr7AQ1vaMr
 CRw==
X-Received: by 2002:a05:690e:1402:b0:65e:275b:1631 with SMTP id
 956f58d0204a3-66044afb97bmr687241d50.31.1779968810851; Thu, 28 May 2026
 04:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <0de640a2-8807-69cf-4429-672263e3e759@redhat.com>
 <CAFEAcA-PkO3aeGoaAzpbJGrrE-_-RjJy9Q4D4MnQ=9W61--3hA@mail.gmail.com>
 <582348f6-c128-96b6-4d40-1c078e24038d@redhat.com>
In-Reply-To: <582348f6-c128-96b6-4d40-1c078e24038d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 12:46:39 +0100
X-Gm-Features: AVHnY4I7X5T_EJWO9GlJLEK8RGBwGR3P7tOAmWG3FLq7bR_-cf5BfBbXBWaYg9U
Message-ID: <CAFEAcA-vidfEaZ=CO_68JmGNmVSsasMGJzppS4mkpAvYL9Yydg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
To: Sebastian Ott <sebott@redhat.com>
Cc: mst@redhat.com, Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Shameer Kolothum <skolothumtho@nvidia.com>, 
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 28 May 2026 at 12:23, Sebastian Ott <sebott@redhat.com> wrote:
>
> On Thu, 28 May 2026, Peter Maydell wrote:
> > On Thu, 28 May 2026 at 10:23, Sebastian Ott <sebott@redhat.com> wrote:
> >>
> >> ACPI PCI hotplug of a PCI device using a bar > 2M fails on ARM
> >> with a resource allocation failure in the guest kernel (Linux):
> >>
> >> qemu-system-aarch64 [..] -device pcie-root-port,id=rp1,bus=pcie.0 \
> >>                     -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on \
> >>                     -pflash /usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.qcow2
> >>
> >> (qemu) device_add pci-testdev,bus=rp1,membar=4M
> >>
> >> [   55.106283] pci 0000:01:00.0: [1b36:0005] type 00 class 0x00ff00 conventional PCI endpoint
> >> [   55.107627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> >> [   55.107864] pci 0000:01:00.0: BAR 1 [io  0x0000-0x00ff]
> >> [   55.108015] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x003fffff 64bit pref]
> >> [   55.118609] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
> >> [   55.118653] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
> >> [   55.118671] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
> >> [   55.122828] pci 0000:01:00.0: BAR 1 [io  0x1000-0x10ff]: assigned
> >> [   55.127090] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: releasing
> >> [   55.127098] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
> >> [   55.127102] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
> >> [   55.127106] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
> >>
> >> This behavior is exactly the same on x86 - except the busses are created
> >> with a default window size of 256M there. If the PCI devices being
> >> hotplugged use a bar > 256M you get the same failure like on ARM.
> >>
> >> The workaround on x86 is to specify "pref64-reserve=" for the PCIe
> >> root-port. On ARM this is currently ignored.
> >
> > From the perspective of somebody who doesn't know much about
> > ACPI or PCI, this commit message doesn't really tell me why
> > QEMU needs to change. The above reads like "this is a kernel
> > problem" to me. Why is the kernel unable to allocate this BAR?
>
> DSM #5 defaults to 1 on ARM which tells the OS that it could
> ignore the firmwares PCI configuration at boot time. Linux is
> just doing that. The acpi pci hotplug controller can't find a
> sufficient resource window of the parent bus and resource
> allocation fails. DSM #5 == 0 tells the OS to not ignore the
> boot time config from firmware.

OK, but if the firmware can find a working PCI configuration,
why can't the kernel also do that?

> >> The following patch changes ACPI DSM #5 to return 0 (only when
> >> ACPI HP is used) which basically tells the guest kernel to keep
> >> all PCI resource allocations.
> >
> > If this makes things work why isn't it the default for all ACPI?
> > Why doesn't the kernel ignore the ACPI table setting and do
> > the thing that works all the time? Do we break some other use
> > case by setting it to 0 ?
>
> From what I was able to find in the archives this has been tried
> before but led to regressions for legacy devices:
> https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net

> It was recently selectively enabled for accel SMMU - I guess the
> rational was that you don't use accel SMMU with legacy devices:
> 45c57eaefd hw/arm/virt: Set PCI preserve_config for accel SMMUv3

    /*
     * Accel SMMU requires RMRs for MSI 1-1 mapping, which require _DSM
     * function 5 (_DSM for Preserving PCI Boot Configurations).
     */

This isn't really very informative to me either... (I have cc'd
some people involved in the smmu-accel stuff.)

The quote of the spec from that other thread on what the values mean is:

# 0: No (The operating system shall not ignore the PCI configuration
#  that firmware has done at boot time. However, the operating system
# is free to configure the devices in this hierarchy that have not
# been configured by the firmware. There may be a reduced level of
# hot plug capability support in this hierarchy due to resource
# constraints. This situation is the same as the legacy situation
# where this _DSM is not provided.)
# 1: Yes (The operating system may ignore the PCI configuration that
# the firmware has done at boot time, and reconfigure/rebalance the
# resources in the hierarchy.)

For "1", that's a "may", not a "must". So that sounds to me like
QEMU should always report 1, and the OS can choose whether it wants
to use the existing PCI config from the firmware, wipe it and start
afresh, or some mixture of the two.

Similarly, it's not clear to me either why the accel SMMU stuff
needs this to be set to 0.

To me this all sounds like it's a guest kernel problem, and we
should drop all the preserve_config handling and let the guest
OS sort out what it wants to do.

thanks
-- PMM

