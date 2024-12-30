Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07638E7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 18:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSKvN-0001i2-MU; Mon, 30 Dec 2024 13:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSKvL-0001he-VP
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 13:55:32 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSKvJ-00075N-AZ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 13:55:31 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so6603357f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 10:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735584927; x=1736189727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qui2Y4KUafW4SCpWVDDOaVkKbTJ56eWr0XZNubRfJRc=;
 b=fHfB+HBMM5Xvazq+T3YIzILLrLTViLCUTVx+2YiJHzFKNE1AwYtA5neaWlW7pHyVMd
 K/eIVMybirba48SKmESty5m/p2Xj+kHRwvNgDzFNbMScDB4q+CGsJq180b8mHncCJoaq
 gbYyFncarXfdib/+xE8nEsHB+JXlgFHbYAl0qYvcUp8aGXaJ4EOacr2GU+dmVWQRmGMX
 IKnumQAz1pD84Q82uRGYDtv1U2KzgjMmBMKB3zSaPKS7cYyV8XtIzO3QYgWxQONWZv0i
 CIfTKzrrCS1jp5p/Vnj1rLGXrNbHpV0yFTKlcdBnGMRp3LaigGVpwzd0QlVb5Y64GU/z
 4kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735584927; x=1736189727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qui2Y4KUafW4SCpWVDDOaVkKbTJ56eWr0XZNubRfJRc=;
 b=t7jl7vsn8gWNRpd5MNY2siLsOEVK0yH68LMvdcViDulzZODnXinF0KWAJr0TFNowEi
 i6J8pPRi4FVaUevtZ0o/LjjKxsegpKrItESuebB/I5mfjBSr8JtOpkVYkMA0Yd7GKwwn
 jqJvfjhhI2LhkRGbPGE1L1pB+Leq3Ng9dOYwJ+d8nm7Lk4EhYhlVKrmGYZyiOu8dP0l0
 Zl4LeiLCSS3AM3sJc8V/Ul17kj2tcnbWSDZ3H/AeUI4ZImOV6TZ31bommJH3mBrWwqKY
 xGMkpb127fFrbLedjuIVWbwc68n1+YVVlRtgXx/TzHX6O3zYDY8RjOwdMoqTLKPxrpjl
 oj3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW64GZN761xeysQGzVNy4ifGyeXYL4RVwPnIE6VjJ8GfkfMMUMUOE3MMz+sOIUhJ2OhUh7APQdDWmcO@nongnu.org
X-Gm-Message-State: AOJu0YzYZb3frWjU86vGdDbZXerHnQqQUmaslcSO/TdzyGRJtwnz11Xu
 7HIlXYfTBGuISfcWinlKNAfKKQzvasvUk/JL34Xe4rNEV4xEL0bsVTjWGAz5wKQ=
X-Gm-Gg: ASbGncvxaNzYeIxBUVK9UaPOyilkly6k2b/9sypze40NdMnucBVSNflIAd2AIUmGZ7F
 /3oRI0AiplmP8acT/LAWEkqaULzh8b15D9KA+GgUVbTEyZ9SGdXgIjqBCkcAoIfPxBJvi6yVHNd
 6cignUDvBdFQa4YgrsfJ5YZIxAIj6XrzJnPGfe5rRj6/VZ7OHHLsWowNWoXQwqsJtRi8s/Sie+C
 D7Bk4I6TZLzsmZI8huJI4hLGYUrQ3VJm/lA9PUjGLnGR19v0JCCAnfMbX6s3igaGfHVu/MUl8JX
 ybtUya6UwujEARKJMfWbRij7
X-Google-Smtp-Source: AGHT+IF+A7uRN0qHdGjNeniPw0A3dVLJLhLh3rZcf5P1DtdbO8Nz+FtXZsISMVxcVx4H/4RLy7QMVQ==
X-Received: by 2002:a05:6000:1864:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38a22a2d914mr27588800f8f.18.1735584926053; 
 Mon, 30 Dec 2024 10:55:26 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acadcsm30403457f8f.105.2024.12.30.10.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 10:55:25 -0800 (PST)
Message-ID: <5aeaca68-50c0-41f4-8cd2-81a931377954@linaro.org>
Date: Mon, 30 Dec 2024 19:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/14] macOS PV Graphics and new vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 Joelle van Dyne <j@getutm.app>
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu
References: <20241223221645.29911-1-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241223221645.29911-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Cc'ing Joelle (FYI https://github.com/utmapp/UTM/issues/3491)

On 23/12/24 23:16, Phil Dennis-Jordan wrote:
> This patch set introduces a new ARM and macOS HVF specific machine type
> called "vmapple", as well as a family of display devices based on the
> ParavirtualizedGraphics.framework in macOS. One of the display adapter
> variants, apple-gfx-mmio, is required for the new machine type, while
> apple-gfx-pci can be used to enable 3D graphics acceleration with x86-64
> macOS guest OSes.
> 
> Previous versions of this patch set were submitted semi-separately:
> the original vmapple patch set by Alexander Graf included a monolithic
> implementation of apple-gfx-mmio. I subsequently reviewed and reworked
> the latter to support the PCI variant of the device as well and submitted
> the result in isolation. As requested in subsequent review, I have now
> recombined this with the original vmapple patch set, which I have updated
> and improved in a few ways as well.
> 
> The vmapple machine type approximates the configuration in macOS's own
> Virtualization.framework when running arm64 macOS guests. In addition to
> generic components such as a GICv3 and an XHCI USB controller, it
> includes nonstandard extensions to the virtio block device, a special
> "hardware" aes engine, a configuration device, a pvpanic variant, a
> "backdoor" interface, and of course the apple-gfx paravirtualised display
> adapter.
> 
> There are currently a few limitations to this which aren't intrinsic,
> just imperfect emulation of the VZF, but it's good enough to be just
> about usable for some purposes:
> 
>   * macOS 12 guests only. Versions 13+ currently fail during early boot.
>   * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differences
>     between Apple M series CPUs and TCG's aarch64 implementation? macOS
>     hosts only because ParavirtualizedGraphics.framework is a black box
>     implementing most of the logic behind the apple-gfx device.)
>   * PCI devices use legacy IRQs, not MSI/MSI-X. As far as I can tell,
>     we'd need to include the GICv3 ITS, but it's unclear to me what
>     exactly needs wiring up.
>   * Due to a quirk (bug?) in the macOS XHCI driver when MSI-X is not
>     available, correct functioning of the USB controller (and thus
>     keyboard/tablet) requires a small workaround in the XHCI controller
>     device. This is part of another patch series:
>     https://patchew.org/QEMU/20241208191646.64857-1-phil@philjordan.eu/
>   * The guest OS must first be provisioned using Virtualization.framework;
>     the disk images can subsequently be used in Qemu. (See docs.)
> 
> The apple-gfx device can be used independently from the vmapple machine
> type, at least in the PCI variant. It mainly targets x86-64 macOS guests
> from version 11 on, but also includes a UEFI bootrom for basic
> framebuffer mode. macOS 11 is also required on the host side, as well
> as a GPU that supports the Metal API. On the guest side, this provides
> 3D acceleration/GPGPU support with a baseline Metal feature set,
> irrespective of the host GPU's feature set. A few limitations in the
> current integration:
> 
>   * Although it works fine with TCG, it does not work correctly
>     cross-architecture: x86-64 guests on arm64 hosts appear to make
>     some boot progress, but rendering is corrupted. I suspect
>     incompatible texture memory layouts; I have no idea if this is
>     fixable.

Zoltan, does that ring a bell?

Phil, should we display a warning in this configuration case? Or only
allow it with some developper option, like:

     -device '{"driver":"apple-gfx-pci", \
               "display-modes":["3840x2160@60"], \
               "x-force-cross-rendering":"true"}'

>   * ParavirtualizedGraphics.framework and the guest driver support
>     multi-headed configurations. The current Qemu integration always
>     connects precisely 1 display.
>   * State serialisation and deserialisation is currently not
>     implemented, though supported in principle by the framework.
>     Both apple-gfx variants thus set up a migration blocker.
>   * Rendering efficiency could be better. The GPU-rendered guest
>     framebuffer is copied to system memory and uses Qemu's usual
>     CPU-based drawing. For maximum efficiency, the Metal texture
>     containing the guest framebuffer could be drawn directly to
>     a Metal view in the host window, staying on the GPU. (Similar
>     to the OpenGL/virgl render path on other platforms.)
> 
> Some of my part of this work has been sponsored by Sauce Labs Inc.
> 
> ---


> Alexander Graf (8):
>    hw: Add vmapple subdir
>    hw/misc/pvpanic: Add MMIO interface
>    gpex: Allow more than 4 legacy IRQs
>    hw/vmapple/aes: Introduce aes engine
>    hw/vmapple/bdif: Introduce vmapple backdoor interface
>    hw/vmapple/cfg: Introduce vmapple cfg region
>    hw/vmapple/virtio-blk: Add support for apple virtio-blk
>    hw/vmapple/vmapple: Add vmapple machine type
> 
> Phil Dennis-Jordan (6):
>    ui & main loop: Redesign of system-specific main thread event handling
>    hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
>      support
>    hw/display/apple-gfx: Adds PCI implementation
>    hw/display/apple-gfx: Adds configurable mode list
>    MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HVF
>    hw/block/virtio-blk: Replaces request free function with g_free
> 
>   MAINTAINERS                         |  15 +
>   contrib/vmapple/uuid.sh             |   9 +
>   docs/system/arm/vmapple.rst         |  63 ++
>   docs/system/target-arm.rst          |   1 +
>   hw/Kconfig                          |   1 +
>   hw/arm/sbsa-ref.c                   |   2 +-
>   hw/arm/virt.c                       |   2 +-
>   hw/block/virtio-blk.c               |  58 +-
>   hw/core/qdev-properties-system.c    |   8 +
>   hw/display/Kconfig                  |  13 +
>   hw/display/apple-gfx-mmio.m         | 288 +++++++++
>   hw/display/apple-gfx-pci.m          | 156 +++++
>   hw/display/apple-gfx.h              |  77 +++
>   hw/display/apple-gfx.m              | 880 ++++++++++++++++++++++++++++
>   hw/display/meson.build              |   7 +
>   hw/display/trace-events             |  30 +
>   hw/i386/microvm.c                   |   2 +-
>   hw/loongarch/virt.c                 |  12 +-
>   hw/meson.build                      |   1 +
>   hw/mips/loongson3_virt.c            |   2 +-
>   hw/misc/Kconfig                     |   4 +
>   hw/misc/meson.build                 |   1 +
>   hw/misc/pvpanic-mmio.c              |  60 ++
>   hw/openrisc/virt.c                  |  12 +-
>   hw/pci-host/gpex.c                  |  43 +-
>   hw/riscv/virt.c                     |  12 +-
>   hw/vmapple/Kconfig                  |  32 +
>   hw/vmapple/aes.c                    | 581 ++++++++++++++++++
>   hw/vmapple/bdif.c                   | 274 +++++++++
>   hw/vmapple/cfg.c                    | 195 ++++++
>   hw/vmapple/meson.build              |   5 +
>   hw/vmapple/trace-events             |  21 +
>   hw/vmapple/trace.h                  |   1 +
>   hw/vmapple/virtio-blk.c             | 204 +++++++
>   hw/vmapple/vmapple.c                | 612 +++++++++++++++++++
>   hw/xen/xen-pvh-common.c             |   2 +-
>   hw/xtensa/virt.c                    |   2 +-
>   include/hw/misc/pvpanic.h           |   1 +
>   include/hw/pci-host/gpex.h          |   7 +-
>   include/hw/pci/pci_ids.h            |   1 +
>   include/hw/qdev-properties-system.h |   5 +
>   include/hw/virtio/virtio-blk.h      |  11 +-
>   include/hw/vmapple/vmapple.h        |  23 +
>   include/qemu-main.h                 |  14 +-
>   include/qemu/cutils.h               |  15 +
>   meson.build                         |   5 +
>   qapi/virtio.json                    |  14 +
>   system/main.c                       |  37 +-
>   ui/cocoa.m                          |  54 +-
>   ui/gtk.c                            |   4 +
>   ui/sdl2.c                           |   4 +
>   util/hexdump.c                      |  18 +
>   52 files changed, 3791 insertions(+), 110 deletions(-)
>   create mode 100755 contrib/vmapple/uuid.sh
>   create mode 100644 docs/system/arm/vmapple.rst
>   create mode 100644 hw/display/apple-gfx-mmio.m
>   create mode 100644 hw/display/apple-gfx-pci.m
>   create mode 100644 hw/display/apple-gfx.h
>   create mode 100644 hw/display/apple-gfx.m
>   create mode 100644 hw/misc/pvpanic-mmio.c
>   create mode 100644 hw/vmapple/Kconfig
>   create mode 100644 hw/vmapple/aes.c
>   create mode 100644 hw/vmapple/bdif.c
>   create mode 100644 hw/vmapple/cfg.c
>   create mode 100644 hw/vmapple/meson.build
>   create mode 100644 hw/vmapple/trace-events
>   create mode 100644 hw/vmapple/trace.h
>   create mode 100644 hw/vmapple/virtio-blk.c
>   create mode 100644 hw/vmapple/vmapple.c
>   create mode 100644 include/hw/vmapple/vmapple.h
> 


