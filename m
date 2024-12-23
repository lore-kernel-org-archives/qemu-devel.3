Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77732E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 22:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPrNw-0003BS-WB; Mon, 23 Dec 2024 17:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPrNv-0003B9-2W
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:58:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPrNs-0002s5-Gu
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:58:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so31834085e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 14:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734994723; x=1735599523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YGWkDaqt04ZkiclE3mCSHcf1ELTIIJpcH40F4qJ5MgU=;
 b=tZ4PiwKs52t5NUscZ7en4a5H//2L3hNRH/qHY2aiKmwp4E+/0jr9tKiCBpBimLtKi9
 +EPUTNv/+O/S3wWZ11gwil3b6gGwPRR9+9j5xRntnp5R8w9ZsU15qyslXEuRH6DhiRNV
 HzfJiW2jxJ5SShAlkQYF8qJfyGXsj42/OOrPtWYIrjhjqWNn7eo+8UsWtmXnA2f+kIFu
 RkIe4STkTsMH+D9QxdpMm2KYejT/9/ZImrzIxo5Bdrdsy9eotL+VrtIInhX4bJvF0DOJ
 QllTa5hWcC03BGOqwYazeTK/aVrDKU63VhbFx3KfP46cji7/AhIGpWn5MG3i5u4iSOvd
 MLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734994723; x=1735599523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGWkDaqt04ZkiclE3mCSHcf1ELTIIJpcH40F4qJ5MgU=;
 b=OHimFWCeyPVblcNsixJD0K2ow//JYqfwXgRxP2Xs18qIiZYaKp7mJuH3AFwKzC5WMr
 EqSILcrSkben/8OvwBlITeiC1wqCjzXy9T2IYoIOP9wDHywoPyBGDkiBGcUKY33MrXQA
 4TdxDKdu/MAKG+6sPs3KTFEy+RTVHlNL73Dh2LIPXT7sebBJr0zMTFQszj3E19F0SX6T
 DZHjQbItHJDR9RP/C1/ya3IQp0j1OuBCcmgRooVKf4r5h2/zFQfK4bsFLmcNuwvjKoFB
 4Lmhk8qXxVMfJQBJljeE61ipajhlIHADq7Xc3FmUEhXE4fQRW7bY99iz8dRQIGRIHsSk
 Betg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtheuUuSYQlxB5Di2OiIos2WrGOYMiaWAVvU+kOcyhSkvfB1277edYE0RWHK6dJ5Gc8mp7JHQxDyz@nongnu.org
X-Gm-Message-State: AOJu0YzVjRXxRjhEyAYKNtW1eAFzdvPRWXz63vYAN/UJ2lSo9mw3ys6H
 ZAAPu0Zjy2nTnLrPyJeIPU17TKzYL2JrA1MUgXRa78ECvUDySCFC2wm0oKeZzsk=
X-Gm-Gg: ASbGncvIG2KPVByLmwAVS7l7qOG3WvvSLvMwdzPTUsxII8KltHdQKqIjsvQbgt7HIV6
 khmnAc5P/7ewJU/5nTH1x1+lozkYHiPSPI8u0hHeIPnWKkP8SnvFM4C49f0z4pLH1OlO0zktKNz
 Tgq/VLMU9RVaN5M4LFWMfp8IIpzAtikTj4BKc0Y4pNHxAmY8lFXX2zyBPPnkHlTUzcKwymbj1Cl
 3lQ7X47j8fRkh+eS8x5UW/iGS1JSkHR7h9hm2ruVZt/2rpPPN89gkY5sFka+7v7kAI=
X-Google-Smtp-Source: AGHT+IEoFF/cw13FwWbaqNaSf/tAQVifLX4+vxdzLD2xsUmZ7k5nSwSPbG4CIDBk4eT4R/LDLzYDLQ==
X-Received: by 2002:a05:600c:4f51:b0:436:1b7a:c0b4 with SMTP id
 5b1f17b1804b1-4366854850emr93928925e9.1.1734994722648; 
 Mon, 23 Dec 2024 14:58:42 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289995sm147841595e9.36.2024.12.23.14.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 14:58:41 -0800 (PST)
Message-ID: <8554330d-fd9b-4fa5-b37c-161f70b71f7d@linaro.org>
Date: Mon, 23 Dec 2024 23:58:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/14] macOS PV Graphics and new vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


> v15 -> v16
> 
>   * 14 patches now, as patch 8 has already been pulled. (Thanks Philippe!)
>   * Fixed a bunch of conflicts with upstream code motion:
>      - DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gfx mode list, 7/14 -
>        pvpanic-mmio, 10/14 - bdif, 11/14 - cfg device, and
>        12/14 - vmapple-virtio-blk)
>      - sysemu->system move/rename: (1/14 - ui/qemu-main, 2/14 - apple-gfx,
>        9/14 - aes, 10/14 - bdif, 14/14 - vmapple machine type)
>   * 14/14 (vmapple machine type):
>      - Moved compatibility setting for removing legacy mode from virtio-pci
>        to proper global property table rather than (ab)using sugar property.
>      - Removed a few superfluous #includes during sysemu rename cleanup.
>      - Removed machine type versioning as it's not necessary (yet?)
>      - Made memory map array const

Great.

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

If there are no objection or further comments, I'm taking this
series and will post a PR after xmas & testing.

Thanks all!

Phil.

