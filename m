Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2649ECFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqZ-0002Zz-4J; Thu, 27 Nov 2025 08:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqO-0002YD-03
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqI-0001Ai-Oj
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xgHbRJ7YGNgbZGuXshF+CO40i+GQEIFpYI3VCF/2Pi8=;
 b=C0ASU8SbgjQQv8ivWezYWS0p06kx4VHEDeKyBzSAIyPDE/0zzdkM+TMWWRpDSmw0ZNV0Ar
 G1fdHoq6mqSnEeYC6tSd+nzk9m0egPqbsuqn262+BWR5kJSE95jCx0fJFE34aMZCW5loit
 wEyHWR6S2bp8Zugu1El3SzXFlIp7/4A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-lvCgwwuINGSkT6UBN8y7MA-1; Thu, 27 Nov 2025 08:15:23 -0500
X-MC-Unique: lvCgwwuINGSkT6UBN8y7MA-1
X-Mimecast-MFC-AGG-ID: lvCgwwuINGSkT6UBN8y7MA_1764249322
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6408222225eso1045598a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249321; x=1764854121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xgHbRJ7YGNgbZGuXshF+CO40i+GQEIFpYI3VCF/2Pi8=;
 b=t3qN3SMxffKkQYrE0ZAn+Xz7YG05NOjM6jXU/HLzeduDETc4ufo0ML0mj6fPz9Y1sQ
 4TZA6eEYC2XORkIAyBTJ+bsEsTZvnw6az1G0Z1dBTaDoeSA6KCxsqr/LCwqcoHSdLrou
 CYFnSudjTCcFCUFPVyeT854/LF+nygQmxsXg4lOMluC+prLI/st7Jl8RQFvLyHf8zea5
 RcwrtOWKQUUyv+pxiRwnIKQL/tu/Kkf7iXXLVyI1xkFd1HH0/VgkJt5aIjEiibrEM/TV
 FRo7xTmctNuIoUqzGQ2VC6MfSKRomu4lAZ1396LAEWqNJvEZmltUtwPgtHcyRBylDANV
 nI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249321; x=1764854121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xgHbRJ7YGNgbZGuXshF+CO40i+GQEIFpYI3VCF/2Pi8=;
 b=H2OCoJb+Q3pxsJExUlT1w7pvIuwS6yLoNuYfM4u4929niuqqNdnkGoad54BRW17m6F
 cegbxq0/xIqW5kDxIT22RW2SriMDMqnVDfpIrpJ36lueB+yuPAQqa1zNXildT3fpsV5c
 xLw7uHVv9s5JcVgRIC+vA35mht7P25GudzPW9cORw5aR/gX5chfFWo3hM4WyZqvcy7U7
 P9EqRWU42O/e2LL3jwP87EYuuiZq1DkUMnwqEpKqclVbzTtxrA447i59LMTrr+5olEqX
 7He19p36YuszMICrycxsyD+V/NVdYN59m0B2WfaJPTY98iMCsFiIr1+ASW/ahFNfOHbn
 Y6zw==
X-Gm-Message-State: AOJu0Ywu+cFYYe3Rt99VisjL6sBX4s2m7d5mxP+meHgqdrL3QKEAXLPD
 mpXpiLziJQuxWOExmvL/g0fAlsraKfnaXRb0RLY73t5fak0+5555sxeRya11+ynbK1EdH/4rdhJ
 aHoTKFmzGRjOliEnj9JK8hX64fT1DThxQpdVMQZeInY0vS0uzws9u7wDLVZ59w3aBTJpJ8Mpyjj
 h08vTi/TBd8JtsHrvkRTkYRS2LPcB2KpEtz8C9DbRl
X-Gm-Gg: ASbGncvXir621h7BRY2Wjo0lncNsHNQIbcdBOAl0clTkZcFG5nt39u6N64Ng4DEUZxF
 sJuJ+32NgUYCEYaB370v/H/Sddsql5C5pOBOGXSU/p+VCzM2Lhsrm5++KB5hM0rHIFv2G1yOKCM
 dJd8yesdtp4sOai2/mP8h24uEiYtHa7vEfhEVdJpN0Tf7dWDmotpvuKxeLDp7l4064b9HwaRzD9
 45my8tRiuh8pX4FclAz08/rnh+a8CSyKHmhxL3jmc3rbo/n1nop/2k+biOA9lNs39gOJ3Q1y3tr
 2QXW1NqS+NbT0J5fk9a3wAJWEMMfSvksC0pi8jPftYxSfOkVJeRhEscjnt6Vm3HVsg/48Btq5at
 U/l4UbE86Wm01tiN2xd7P9uTdmO3d1twA8cU4QVLrE/nEzSNC15p1e9THHoUHUC2JssHKfUMte7
 zJMZTA4aO+tlExrsk=
X-Received: by 2002:a05:6402:510b:b0:640:ccb0:f4da with SMTP id
 4fb4d7f45d1cf-6455469bf9fmr19246312a12.29.1764249320242; 
 Thu, 27 Nov 2025 05:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcCntocNAK2KL2zcaUczbhij5BXmxV77LnOboWkaabY6zVi48HgFlR58cbAKfoNx3BDj4gMw==
X-Received: by 2002:a05:6402:510b:b0:640:ccb0:f4da with SMTP id
 4fb4d7f45d1cf-6455469bf9fmr19246190a12.29.1764249318314; 
 Thu, 27 Nov 2025 05:15:18 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647510510easm1689749a12.25.2025.11.27.05.15.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/28] include: cleanup cross-subsystem inclusions,
 empty include/hw/
Date: Thu, 27 Nov 2025 14:14:47 +0100
Message-ID: <20251127131516.80807-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The big part of this is emptying include/hw of .h files, moving them
to include/hw/core.  There are three other cleanups in front; the
thing they have in common is that they initially came to mind while
looking (in collaboration with Marc-André) at which headers are used
by each Rust crate.  However, the changes are all independent of Rust
and they're nice to have (I won't say it's "useful", of course).

It was done mostly with a script:

  for i in $(cd include/hw/ && ls -1 *.h); do
    s=hw/${i%.h}'\.h'
    d=hw/core/$i
    test $i = hw.h && d=hw/core/hw-error.h
    test $i = qdev-core.h && d=hw/core/qdev.h
    test $i = usb.h && d=hw/usb/usb.h
    git grep -l "$s" | xargs sed -i "s,$s,$d,g"
    git mv include/hw/$i include/$d
    git commit -m"include: move hw/$i to hw/core/" -s -a
  done

with subsequent tweaks to the commit message of the three files
that are special cased.

The other change is a cleanup to memory.h to isolate better the
ram_addr_t and RAMBlock APIs.  Right now, including memory.h brings in
exec/cpu-common.h and exec/ramlist.h even though only a small part of
the build needs it.

Paolo

Paolo Bonzini (28):
  include: move qemu_irq_handler out of typedefs.h
  include: name the MemReentrancyGuard struct
  include: move memory_ldst* to include/system
  include: move hw/usb.h to hw/usb/
  include: move hw/boards.h to hw/core/
  include: move hw/clock.h to hw/core/
  include: move hw/fw-path-provider.h to hw/core/
  include: move hw/hotplug.h to hw/core/
  include: move hw/irq.h to hw/core/
  include: move hw/loader-fit.h to hw/core/
  include: move hw/loader.h to hw/core/
  include: move hw/nmi.h to hw/core/
  include: move hw/or-irq.h to hw/core/
  include: move hw/platform-bus.h to hw/core/
  include: move hw/ptimer.h to hw/core/
  include: move hw/qdev-clock.h to hw/core/
  include: move hw/qdev-core.h to hw/core/, rename
  include: move hw/qdev-dma.h to hw/core/
  include: move hw/qdev-properties.h to hw/core/
  include: move hw/qdev-properties-system.h to hw/core/
  include: move hw/registerfields.h to hw/core/
  include: move hw/register.h to hw/core/
  include: move hw/resettable.h to hw/core/
  include: move hw/stream.h to hw/core/
  include: move hw/sysbus.h to hw/core/
  include: move hw/vmstate-if.h to hw/core/
  include: move hw/hw.h to hw/core/, rename
  include: reorganize memory API headers

 MAINTAINERS                                   |  20 +--
 docs/conf.py                                  |   2 +-
 docs/devel/clocks.rst                         |   6 +-
 docs/devel/migration/compatibility.rst        |   2 +-
 docs/devel/qdev-api.rst                       |   2 +-
 docs/devel/reset.rst                          |   2 +-
 docs/devel/style.rst                          |   2 +-
 hw/alpha/alpha_sys.h                          |   2 +-
 hw/arm/smmuv3-internal.h                      |   2 +-
 hw/audio/intel-hda.h                          |   2 +-
 hw/avr/boot.h                                 |   2 +-
 hw/core/guest-loader.h                        |   2 +-
 hw/display/apple-gfx.h                        |   2 +-
 hw/i386/acpi-common.h                         |   2 +-
 hw/i386/fw_cfg.h                              |   2 +-
 hw/i386/kvm/xen_evtchn.h                      |   2 +-
 hw/intc/gic_internal.h                        |   2 +-
 hw/intc/gicv3_internal.h                      |   2 +-
 hw/intc/ioapic_internal.h                     |   2 +-
 hw/loongarch/fw_cfg.h                         |   2 +-
 hw/mips/fw_cfg.h                              |   2 +-
 hw/net/fsl_etsec/etsec.h                      |   4 +-
 hw/net/pcnet.h                                |   2 +-
 hw/ppc/e500-ccsr.h                            |   2 +-
 hw/ppc/e500.h                                 |   4 +-
 hw/riscv/riscv-iommu.h                        |   2 +-
 hw/s390x/ccw-device.h                         |   2 +-
 hw/s390x/ipl.h                                |   2 +-
 hw/scsi/lasi_ncr710.h                         |   2 +-
 hw/scsi/ncr53c710.h                           |   4 +-
 hw/sd/sdhci-internal.h                        |   2 +-
 hw/tpm/tpm_prop.h                             |   2 +-
 hw/usb/canokey.h                              |   2 +-
 hw/usb/ccid.h                                 |   2 +-
 hw/usb/hcd-dwc2.h                             |   6 +-
 hw/usb/hcd-ehci.h                             |   4 +-
 hw/usb/hcd-ohci.h                             |   4 +-
 hw/usb/hcd-uhci.h                             |   2 +-
 hw/usb/hcd-xhci-pci.h                         |   2 +-
 hw/usb/hcd-xhci-sysbus.h                      |   4 +-
 hw/usb/hcd-xhci.h                             |   2 +-
 hw/usb/u2f.h                                  |   2 +-
 include/block/aio.h                           |   2 +-
 include/block/nvme.h                          |   2 +-
 include/block/ufs.h                           |   2 +-
 include/exec/cpu-common.h                     |  76 +--------
 include/fpu/softfloat-types.h                 |   2 +-
 include/hw/acpi/acpi_aml_interface.h          |   2 +-
 include/hw/acpi/acpi_dev_interface.h          |   2 +-
 include/hw/acpi/cpu.h                         |   6 +-
 include/hw/acpi/cpu_hotplug.h                 |   2 +-
 include/hw/acpi/generic_event_device.h        |   2 +-
 include/hw/acpi/memory_hotplug.h              |   2 +-
 include/hw/acpi/pcihp.h                       |   2 +-
 include/hw/acpi/tpm.h                         |   2 +-
 include/hw/acpi/vmclock.h                     |   2 +-
 include/hw/acpi/vmgenid.h                     |   2 +-
 include/hw/adc/aspeed_adc.h                   |   2 +-
 include/hw/adc/npcm7xx_adc.h                  |   6 +-
 include/hw/adc/stm32f2xx_adc.h                |   2 +-
 include/hw/adc/zynq-xadc.h                    |   2 +-
 include/hw/arm/armsse.h                       |   6 +-
 include/hw/arm/armv7m.h                       |   4 +-
 include/hw/arm/aspeed.h                       |   2 +-
 include/hw/arm/bcm2835_peripherals.h          |   4 +-
 include/hw/arm/exynos4210.h                   |   4 +-
 include/hw/arm/fsl-imx6.h                     |   2 +-
 include/hw/arm/fsl-imx7.h                     |   2 +-
 include/hw/arm/fsl-imx8mp.h                   |   4 +-
 include/hw/arm/machines-qom.h                 |   2 +-
 include/hw/arm/max78000_soc.h                 |   2 +-
 include/hw/arm/msf2-soc.h                     |   2 +-
 include/hw/arm/npcm7xx.h                      |   2 +-
 include/hw/arm/nrf51_soc.h                    |   4 +-
 include/hw/arm/raspi_platform.h               |   2 +-
 include/hw/arm/smmu-common.h                  |   2 +-
 include/hw/arm/stm32f100_soc.h                |   2 +-
 include/hw/arm/stm32f205_soc.h                |   4 +-
 include/hw/arm/stm32f405_soc.h                |   2 +-
 include/hw/arm/stm32l4x5_soc.h                |   2 +-
 include/hw/arm/virt.h                         |   2 +-
 include/hw/arm/xlnx-versal.h                  |   2 +-
 include/hw/arm/xlnx-zynqmp.h                  |   2 +-
 include/hw/audio/asc.h                        |   2 +-
 include/hw/block/block.h                      |   2 +-
 include/hw/block/swim.h                       |   2 +-
 include/hw/char/avr_usart.h                   |   2 +-
 include/hw/char/bcm2835_aux.h                 |   2 +-
 include/hw/char/cadence_uart.h                |   4 +-
 include/hw/char/cmsdk-apb-uart.h              |   2 +-
 include/hw/char/digic-uart.h                  |   2 +-
 include/hw/char/escc.h                        |   2 +-
 include/hw/char/goldfish_tty.h                |   2 +-
 include/hw/char/ibex_uart.h                   |   2 +-
 include/hw/char/imx_serial.h                  |   2 +-
 include/hw/char/max78000_uart.h               |   2 +-
 include/hw/char/mchp_pfsoc_mmuart.h           |   2 +-
 include/hw/char/nrf51_uart.h                  |   4 +-
 include/hw/char/parallel.h                    |   2 +-
 include/hw/char/pl011.h                       |   2 +-
 include/hw/char/renesas_sci.h                 |   2 +-
 include/hw/char/serial-mm.h                   |   2 +-
 include/hw/char/shakti_uart.h                 |   2 +-
 include/hw/char/sifive_uart.h                 |   4 +-
 include/hw/char/stm32f2xx_usart.h             |   2 +-
 include/hw/char/stm32l4x5_usart.h             |   2 +-
 include/hw/{ => core}/boards.h                |   2 +-
 include/hw/{ => core}/clock.h                 |   0
 include/hw/core/cpu.h                         |   2 +-
 include/hw/{ => core}/fw-path-provider.h      |   0
 include/hw/core/generic-loader.h              |   2 +-
 include/hw/{ => core}/hotplug.h               |   0
 include/hw/{hw.h => core/hw-error.h}          |   0
 include/hw/{ => core}/irq.h                   |   2 +
 include/hw/{ => core}/loader-fit.h            |   0
 include/hw/{ => core}/loader.h                |   0
 include/hw/{ => core}/nmi.h                   |   0
 include/hw/{ => core}/or-irq.h                |   2 +-
 include/hw/{ => core}/platform-bus.h          |   2 +-
 include/hw/{ => core}/ptimer.h                |   0
 include/hw/{ => core}/qdev-clock.h            |   2 +-
 include/hw/{ => core}/qdev-dma.h              |   0
 .../hw/{ => core}/qdev-properties-system.h    |   3 +-
 include/hw/{ => core}/qdev-properties.h       |   2 +-
 include/hw/{qdev-core.h => core/qdev.h}       |   7 +-
 include/hw/{ => core}/register.h              |   4 +-
 include/hw/{ => core}/registerfields.h        |   0
 include/hw/{ => core}/resettable.h            |   0
 include/hw/core/split-irq.h                   |   2 +-
 include/hw/{ => core}/stream.h                |   0
 include/hw/{ => core}/sysbus.h                |   2 +-
 include/hw/{ => core}/vmstate-if.h            |   0
 include/hw/cpu/a15mpcore.h                    |   2 +-
 include/hw/cpu/a9mpcore.h                     |   2 +-
 include/hw/cpu/arm11mpcore.h                  |   2 +-
 include/hw/cpu/cluster.h                      |   2 +-
 include/hw/cpu/core.h                         |   2 +-
 include/hw/cxl/cxl_component.h                |   2 +-
 include/hw/cxl/cxl_device.h                   |   2 +-
 include/hw/cxl/cxl_host.h                     |   2 +-
 include/hw/display/bcm2835_fb.h               |   2 +-
 include/hw/display/dm163.h                    |   2 +-
 include/hw/display/macfb.h                    |   4 +-
 include/hw/display/xlnx_dp.h                  |   4 +-
 include/hw/dma/bcm2835_dma.h                  |   2 +-
 include/hw/dma/pl080.h                        |   2 +-
 include/hw/dma/sifive_pdma.h                  |   2 +-
 include/hw/dma/xlnx-zdma.h                    |   4 +-
 include/hw/dma/xlnx-zynq-devcfg.h             |   4 +-
 include/hw/dma/xlnx_csu_dma.h                 |   8 +-
 include/hw/dma/xlnx_dpdma.h                   |   2 +-
 include/hw/fsi/aspeed_apb2opb.h               |   2 +-
 include/hw/fsi/fsi-master.h                   |   2 +-
 include/hw/fsi/fsi.h                          |   2 +-
 include/hw/fsi/lbus.h                         |   2 +-
 include/hw/gpio/aspeed_gpio.h                 |   2 +-
 include/hw/gpio/bcm2835_gpio.h                |   2 +-
 include/hw/gpio/bcm2838_gpio.h                |   2 +-
 include/hw/gpio/imx_gpio.h                    |   2 +-
 include/hw/gpio/npcm7xx_gpio.h                |   2 +-
 include/hw/gpio/nrf51_gpio.h                  |   2 +-
 include/hw/gpio/sifive_gpio.h                 |   2 +-
 include/hw/gpio/stm32l4x5_gpio.h              |   2 +-
 include/hw/hyperv/vmbus-bridge.h              |   2 +-
 include/hw/hyperv/vmbus.h                     |   2 +-
 include/hw/i2c/allwinner-i2c.h                |   2 +-
 include/hw/i2c/arm_sbcon_i2c.h                |   2 +-
 include/hw/i2c/aspeed_i2c.h                   |   4 +-
 include/hw/i2c/bcm2835_i2c.h                  |   2 +-
 include/hw/i2c/i2c.h                          |   2 +-
 include/hw/i2c/imx_i2c.h                      |   2 +-
 include/hw/i2c/microbit_i2c.h                 |   2 +-
 include/hw/i2c/npcm7xx_smbus.h                |   4 +-
 include/hw/i2c/ppc4xx_i2c.h                   |   2 +-
 include/hw/i2c/smbus_eeprom.h                 |   2 +-
 include/hw/i386/microvm.h                     |   2 +-
 include/hw/i386/pc.h                          |   4 +-
 include/hw/i386/sgx-epc.h                     |   2 +-
 include/hw/i386/x86-iommu.h                   |   2 +-
 include/hw/i386/x86.h                         |   2 +-
 include/hw/ide/ahci-pci.h                     |   2 +-
 include/hw/ide/ahci-sysbus.h                  |   2 +-
 include/hw/ide/ide-dev.h                      |   2 +-
 include/hw/input/adb.h                        |   2 +-
 include/hw/input/i8042.h                      |   2 +-
 include/hw/input/lasips2.h                    |   2 +-
 include/hw/input/pl050.h                      |   4 +-
 include/hw/input/ps2.h                        |   2 +-
 include/hw/input/stellaris_gamepad.h          |   2 +-
 include/hw/intc/allwinner-a10-pic.h           |   2 +-
 include/hw/intc/arm_gic_common.h              |   2 +-
 include/hw/intc/arm_gicv3_common.h            |   2 +-
 include/hw/intc/arm_gicv3_its_common.h        |   2 +-
 include/hw/intc/armv7m_nvic.h                 |   2 +-
 include/hw/intc/aspeed_intc.h                 |   4 +-
 include/hw/intc/aspeed_vic.h                  |   2 +-
 include/hw/intc/bcm2835_ic.h                  |   2 +-
 include/hw/intc/bcm2836_control.h             |   2 +-
 include/hw/intc/exynos4210_combiner.h         |   2 +-
 include/hw/intc/exynos4210_gic.h              |   2 +-
 include/hw/intc/goldfish_pic.h                |   2 +-
 include/hw/intc/grlib_irqmp.h                 |   2 +-
 include/hw/intc/heathrow_pic.h                |   2 +-
 include/hw/intc/imx_avic.h                    |   2 +-
 include/hw/intc/imx_gpcv2.h                   |   2 +-
 include/hw/intc/loongarch_dintc.h             |   2 +-
 include/hw/intc/loongarch_extioi_common.h     |   2 +-
 include/hw/intc/loongarch_pch_msi.h           |   2 +-
 include/hw/intc/loongarch_pic_common.h        |   2 +-
 include/hw/intc/loongson_ipi.h                |   2 +-
 include/hw/intc/loongson_ipi_common.h         |   2 +-
 include/hw/intc/loongson_liointc.h            |   2 +-
 include/hw/intc/m68k_irqc.h                   |   2 +-
 include/hw/intc/mips_gic.h                    |   2 +-
 include/hw/intc/realview_gic.h                |   2 +-
 include/hw/intc/riscv_aclint.h                |   2 +-
 include/hw/intc/riscv_aplic.h                 |   2 +-
 include/hw/intc/riscv_imsic.h                 |   2 +-
 include/hw/intc/rx_icu.h                      |   2 +-
 include/hw/intc/sifive_plic.h                 |   2 +-
 include/hw/intc/xlnx-pmu-iomod-intc.h         |   4 +-
 include/hw/intc/xlnx-zynqmp-ipi.h             |   4 +-
 include/hw/ipack/ipack.h                      |   4 +-
 include/hw/ipmi/ipmi.h                        |   2 +-
 include/hw/isa/isa.h                          |   2 +-
 include/hw/loongarch/virt.h                   |   2 +-
 include/hw/m68k/q800-glue.h                   |   2 +-
 include/hw/m68k/q800.h                        |   4 +-
 include/hw/mem/memory-device.h                |   2 +-
 include/hw/mem/npcm7xx_mc.h                   |   2 +-
 include/hw/mem/pc-dimm.h                      |   2 +-
 include/hw/mips/cps.h                         |   4 +-
 include/hw/misc/a9scu.h                       |   2 +-
 include/hw/misc/allwinner-a10-ccm.h           |   2 +-
 include/hw/misc/allwinner-a10-dramc.h         |   4 +-
 include/hw/misc/allwinner-cpucfg.h            |   2 +-
 include/hw/misc/allwinner-h3-ccu.h            |   2 +-
 include/hw/misc/allwinner-h3-dramc.h          |   2 +-
 include/hw/misc/allwinner-h3-sysctrl.h        |   2 +-
 include/hw/misc/allwinner-r40-ccu.h           |   2 +-
 include/hw/misc/allwinner-r40-dramc.h         |   2 +-
 include/hw/misc/allwinner-sid.h               |   2 +-
 include/hw/misc/allwinner-sramc.h             |   2 +-
 include/hw/misc/arm11scu.h                    |   2 +-
 include/hw/misc/armsse-cpu-pwrctrl.h          |   2 +-
 include/hw/misc/armsse-cpuid.h                |   2 +-
 include/hw/misc/armsse-mhu.h                  |   2 +-
 include/hw/misc/armv7m_ras.h                  |   2 +-
 include/hw/misc/aspeed_hace.h                 |   2 +-
 include/hw/misc/aspeed_i3c.h                  |   2 +-
 include/hw/misc/aspeed_lpc.h                  |   2 +-
 include/hw/misc/aspeed_peci.h                 |   2 +-
 include/hw/misc/aspeed_sbc.h                  |   2 +-
 include/hw/misc/aspeed_scu.h                  |   2 +-
 include/hw/misc/aspeed_sdmc.h                 |   2 +-
 include/hw/misc/aspeed_sli.h                  |   2 +-
 include/hw/misc/aspeed_xdma.h                 |   2 +-
 include/hw/misc/auxbus.h                      |   2 +-
 include/hw/misc/avr_power.h                   |   2 +-
 include/hw/misc/bcm2835_cprman.h              |   4 +-
 include/hw/misc/bcm2835_cprman_internals.h    |   2 +-
 include/hw/misc/bcm2835_mbox.h                |   2 +-
 include/hw/misc/bcm2835_mphi.h                |   4 +-
 include/hw/misc/bcm2835_powermgt.h            |   2 +-
 include/hw/misc/bcm2835_property.h            |   2 +-
 include/hw/misc/bcm2835_rng.h                 |   2 +-
 include/hw/misc/bcm2835_thermal.h             |   2 +-
 include/hw/misc/djmemc.h                      |   2 +-
 include/hw/misc/imx6_src.h                    |   2 +-
 include/hw/misc/imx7_gpr.h                    |   2 +-
 include/hw/misc/imx7_snvs.h                   |   2 +-
 include/hw/misc/imx7_src.h                    |   2 +-
 include/hw/misc/imx8mp_analog.h               |   2 +-
 include/hw/misc/imx_ccm.h                     |   2 +-
 include/hw/misc/imx_rngc.h                    |   2 +-
 include/hw/misc/iotkit-secctl.h               |   2 +-
 include/hw/misc/iotkit-sysctl.h               |   2 +-
 include/hw/misc/iotkit-sysinfo.h              |   2 +-
 include/hw/misc/ivshmem-flat.h                |   2 +-
 include/hw/misc/lasi.h                        |   4 +-
 include/hw/misc/led.h                         |   2 +-
 include/hw/misc/mac_via.h                     |   2 +-
 include/hw/misc/macio/gpio.h                  |   2 +-
 include/hw/misc/max78000_aes.h                |   2 +-
 include/hw/misc/max78000_gcr.h                |   2 +-
 include/hw/misc/max78000_icc.h                |   2 +-
 include/hw/misc/max78000_trng.h               |   2 +-
 include/hw/misc/mchp_pfsoc_dmc.h              |   2 +-
 include/hw/misc/mchp_pfsoc_ioscb.h            |   2 +-
 include/hw/misc/mchp_pfsoc_sysreg.h           |   2 +-
 include/hw/misc/mips_cmgcr.h                  |   2 +-
 include/hw/misc/mips_cpc.h                    |   2 +-
 include/hw/misc/mips_itu.h                    |   2 +-
 include/hw/misc/mos6522.h                     |   2 +-
 include/hw/misc/mps2-fpgaio.h                 |   2 +-
 include/hw/misc/mps2-scc.h                    |   2 +-
 include/hw/misc/msf2-sysreg.h                 |   2 +-
 include/hw/misc/npcm7xx_mft.h                 |   6 +-
 include/hw/misc/npcm7xx_pwm.h                 |   6 +-
 include/hw/misc/npcm7xx_rng.h                 |   2 +-
 include/hw/misc/npcm_clk.h                    |   4 +-
 include/hw/misc/npcm_gcr.h                    |   2 +-
 include/hw/misc/nrf51_rng.h                   |   2 +-
 include/hw/misc/sifive_e_aon.h                |   2 +-
 include/hw/misc/sifive_e_prci.h               |   2 +-
 include/hw/misc/sifive_test.h                 |   2 +-
 include/hw/misc/sifive_u_otp.h                |   2 +-
 include/hw/misc/sifive_u_prci.h               |   2 +-
 include/hw/misc/stm32_rcc.h                   |   2 +-
 include/hw/misc/stm32f2xx_syscfg.h            |   2 +-
 include/hw/misc/stm32f4xx_exti.h              |   2 +-
 include/hw/misc/stm32f4xx_syscfg.h            |   2 +-
 include/hw/misc/stm32l4x5_exti.h              |   2 +-
 include/hw/misc/stm32l4x5_rcc.h               |   2 +-
 include/hw/misc/stm32l4x5_rcc_internals.h     |   2 +-
 include/hw/misc/stm32l4x5_syscfg.h            |   2 +-
 include/hw/misc/tz-mpc.h                      |   2 +-
 include/hw/misc/tz-msc.h                      |   2 +-
 include/hw/misc/tz-ppc.h                      |   2 +-
 include/hw/misc/unimp.h                       |   4 +-
 include/hw/misc/virt_ctrl.h                   |   2 +-
 include/hw/misc/vmcoreinfo.h                  |   2 +-
 include/hw/misc/xlnx-versal-cframe-reg.h      |   4 +-
 include/hw/misc/xlnx-versal-cfu.h             |   4 +-
 include/hw/misc/xlnx-versal-crl.h             |   4 +-
 include/hw/misc/xlnx-versal-pmc-iou-slcr.h    |   4 +-
 include/hw/misc/xlnx-versal-trng.h            |   6 +-
 include/hw/misc/xlnx-versal-xramc.h           |   4 +-
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h        |   4 +-
 include/hw/misc/xlnx-zynqmp-crf.h             |   4 +-
 include/hw/net/allwinner-sun8i-emac.h         |   2 +-
 include/hw/net/allwinner_emac.h               |   2 +-
 include/hw/net/cadence_gem.h                  |   2 +-
 include/hw/net/dp8393x.h                      |   2 +-
 include/hw/net/ftgmac100.h                    |   2 +-
 include/hw/net/imx_fec.h                      |   4 +-
 include/hw/net/lan9118_phy.h                  |   2 +-
 include/hw/net/lance.h                        |   2 +-
 include/hw/net/lasi_82596.h                   |   2 +-
 include/hw/net/msf2-emac.h                    |   2 +-
 include/hw/net/ne2000-isa.h                   |   2 +-
 include/hw/net/npcm7xx_emc.h                  |   4 +-
 include/hw/net/npcm_gmac.h                    |   4 +-
 include/hw/net/npcm_pcs.h                     |   2 +-
 include/hw/net/xlnx-versal-canfd.h            |   6 +-
 include/hw/net/xlnx-zynqmp-can.h              |   8 +-
 include/hw/nubus/nubus.h                      |   4 +-
 include/hw/nvram/bcm2835_otp.h                |   2 +-
 include/hw/nvram/fw_cfg.h                     |   2 +-
 include/hw/nvram/mac_nvram.h                  |   2 +-
 include/hw/nvram/npcm7xx_otp.h                |   2 +-
 include/hw/nvram/nrf51_nvm.h                  |   2 +-
 include/hw/nvram/xlnx-bbram.h                 |   8 +-
 include/hw/nvram/xlnx-efuse.h                 |   2 +-
 include/hw/nvram/xlnx-versal-efuse.h          |   6 +-
 include/hw/nvram/xlnx-zynqmp-efuse.h          |   6 +-
 include/hw/openrisc/boot.h                    |   2 +-
 include/hw/pci-host/aspeed_pcie.h             |   2 +-
 include/hw/pci-host/designware.h              |   2 +-
 include/hw/pci-host/fsl_imx8m_phy.h           |   2 +-
 include/hw/pci-host/gpex.h                    |   2 +-
 include/hw/pci-host/xilinx-pcie.h             |   2 +-
 include/hw/pci/pci_host.h                     |   2 +-
 include/hw/pci/pcie.h                         |   2 +-
 include/hw/pci/pcie_doe.h                     |   2 +-
 include/hw/pci/shpc.h                         |   2 +-
 include/hw/ppc/mac_dbdma.h                    |   2 +-
 include/hw/ppc/openpic.h                      |   2 +-
 include/hw/ppc/pnv.h                          |   4 +-
 include/hw/ppc/pnv_adu.h                      |   2 +-
 include/hw/ppc/pnv_chip.h                     |   2 +-
 include/hw/ppc/pnv_lpc.h                      |   2 +-
 include/hw/ppc/pnv_occ.h                      |   2 +-
 include/hw/ppc/pnv_pnor.h                     |   2 +-
 include/hw/ppc/pnv_psi.h                      |   4 +-
 include/hw/ppc/pnv_sbe.h                      |   2 +-
 include/hw/ppc/ppc4xx.h                       |   2 +-
 include/hw/ppc/spapr.h                        |   2 +-
 include/hw/ppc/spapr_cpu_core.h               |   2 +-
 include/hw/ppc/spapr_drc.h                    |   2 +-
 include/hw/ppc/spapr_numa.h                   |   2 +-
 include/hw/ppc/spapr_tpm_proxy.h              |   2 +-
 include/hw/ppc/spapr_vio.h                    |   2 +-
 include/hw/ppc/xics.h                         |   2 +-
 include/hw/ppc/xive.h                         |   2 +-
 include/hw/ppc/xive2.h                        |   2 +-
 include/hw/remote/machine.h                   |   2 +-
 include/hw/riscv/boot.h                       |   2 +-
 include/hw/riscv/microchip_pfsoc.h            |   2 +-
 include/hw/riscv/numa.h                       |   4 +-
 include/hw/riscv/opentitan.h                  |   2 +-
 include/hw/riscv/riscv_hart.h                 |   2 +-
 include/hw/riscv/shakti_c.h                   |   2 +-
 include/hw/riscv/sifive_e.h                   |   2 +-
 include/hw/riscv/sifive_u.h                   |   2 +-
 include/hw/riscv/spike.h                      |   4 +-
 include/hw/riscv/virt.h                       |   4 +-
 include/hw/riscv/xiangshan_kmh.h              |   2 +-
 include/hw/rtc/allwinner-rtc.h                |   2 +-
 include/hw/rtc/aspeed_rtc.h                   |   2 +-
 include/hw/rtc/goldfish_rtc.h                 |   2 +-
 include/hw/rtc/pl031.h                        |   2 +-
 include/hw/rtc/xlnx-zynqmp-rtc.h              |   4 +-
 include/hw/s390x/3270-ccw.h                   |   2 +-
 include/hw/s390x/ap-device.h                  |   2 +-
 include/hw/s390x/cpu-topology.h               |   2 +-
 include/hw/s390x/css-bridge.h                 |   2 +-
 include/hw/s390x/event-facility.h             |   2 +-
 include/hw/s390x/s390-virtio-ccw.h            |   2 +-
 include/hw/s390x/s390_flic.h                  |   2 +-
 include/hw/s390x/sclp.h                       |   2 +-
 include/hw/s390x/storage-attributes.h         |   2 +-
 include/hw/s390x/storage-keys.h               |   2 +-
 include/hw/s390x/tod.h                        |   2 +-
 include/hw/scsi/esp.h                         |   2 +-
 include/hw/scsi/scsi.h                        |   2 +-
 include/hw/sd/allwinner-sdhost.h              |   2 +-
 include/hw/sd/bcm2835_sdhost.h                |   2 +-
 include/hw/sd/sd.h                            |   2 +-
 include/hw/sd/sdhci.h                         |   2 +-
 include/hw/sparc/sparc32_dma.h                |   2 +-
 include/hw/sparc/sun4m_iommu.h                |   2 +-
 include/hw/sparc/sun4u_iommu.h                |   2 +-
 include/hw/ssi/allwinner-a10-spi.h            |   2 +-
 include/hw/ssi/aspeed_smc.h                   |   2 +-
 include/hw/ssi/bcm2835_spi.h                  |   2 +-
 include/hw/ssi/ibex_spi_host.h                |   2 +-
 include/hw/ssi/imx_spi.h                      |   2 +-
 include/hw/ssi/mss-spi.h                      |   2 +-
 include/hw/ssi/npcm7xx_fiu.h                  |   2 +-
 include/hw/ssi/npcm_pspi.h                    |   2 +-
 include/hw/ssi/pl022.h                        |   2 +-
 include/hw/ssi/pnv_spi.h                      |   2 +-
 include/hw/ssi/sifive_spi.h                   |   2 +-
 include/hw/ssi/ssi.h                          |   2 +-
 include/hw/ssi/stm32f2xx_spi.h                |   2 +-
 include/hw/ssi/xilinx_spips.h                 |   4 +-
 include/hw/ssi/xlnx-versal-ospi.h             |   2 +-
 include/hw/timer/a9gtimer.h                   |   2 +-
 include/hw/timer/allwinner-a10-pit.h          |   4 +-
 include/hw/timer/arm_mptimer.h                |   2 +-
 include/hw/timer/armv7m_systick.h             |   6 +-
 include/hw/timer/avr_timer16.h                |   2 +-
 include/hw/timer/bcm2835_systmr.h             |   4 +-
 include/hw/timer/cadence_ttc.h                |   2 +-
 include/hw/timer/cmsdk-apb-dualtimer.h        |   6 +-
 include/hw/timer/cmsdk-apb-timer.h            |   6 +-
 include/hw/timer/digic-timer.h                |   4 +-
 include/hw/timer/i8254.h                      |   2 +-
 include/hw/timer/ibex_timer.h                 |   2 +-
 include/hw/timer/imx_epit.h                   |   4 +-
 include/hw/timer/imx_gpt.h                    |   4 +-
 include/hw/timer/mss-timer.h                  |   4 +-
 include/hw/timer/npcm7xx_timer.h              |   2 +-
 include/hw/timer/nrf51_timer.h                |   2 +-
 include/hw/timer/renesas_cmt.h                |   2 +-
 include/hw/timer/renesas_tmr.h                |   2 +-
 include/hw/timer/sifive_pwm.h                 |   2 +-
 include/hw/timer/sse-counter.h                |   2 +-
 include/hw/timer/sse-timer.h                  |   2 +-
 include/hw/timer/stellaris-gptm.h             |   6 +-
 include/hw/timer/stm32f2xx_timer.h            |   2 +-
 include/hw/tricore/tc27x_soc.h                |   2 +-
 include/hw/tricore/triboard.h                 |   2 +-
 include/hw/tricore/tricore_testdevice.h       |   2 +-
 include/hw/usb/hcd-dwc3.h                     |   2 +-
 include/hw/usb/imx-usb-phy.h                  |   2 +-
 include/hw/usb/msd.h                          |   2 +-
 include/hw/{ => usb}/usb.h                    |   2 +-
 include/hw/usb/xlnx-usb-subsystem.h           |   4 +-
 include/hw/usb/xlnx-versal-usb2-ctrl-regs.h   |   4 +-
 include/hw/virtio/vhost-scsi-common.h         |   2 +-
 include/hw/virtio/virtio-balloon.h            |   2 +-
 include/hw/virtio/virtio-bus.h                |   2 +-
 include/hw/virtio/virtio-mem.h                |   2 +-
 include/hw/virtio/virtio-mmio.h               |   2 +-
 include/hw/virtio/virtio.h                    |   2 +-
 include/hw/watchdog/allwinner-wdt.h           |   4 +-
 include/hw/watchdog/cmsdk-apb-watchdog.h      |   6 +-
 include/hw/watchdog/sbsa_gwdt.h               |   4 +-
 include/hw/watchdog/wdt_aspeed.h              |   2 +-
 include/hw/watchdog/wdt_diag288.h             |   2 +-
 include/hw/watchdog/wdt_imx2.h                |   6 +-
 include/hw/xen/xen-bus.h                      |   2 +-
 include/hw/xen/xen-hvm-common.h               |   1 +
 include/hw/xen/xen-pvh-common.h               |   2 +-
 include/hw/xen/xen_pvdev.h                    |   2 +-
 include/migration/register.h                  |   2 +-
 include/migration/vmstate.h                   |   2 +-
 include/monitor/qdev.h                        |   2 +-
 include/net/net.h                             |   2 +-
 include/qemu/audio.h                          |   2 +-
 include/qemu/typedefs.h                       |   1 -
 include/system/balloon.h                      |   2 +-
 include/system/block-ram-registrar.h          |   2 +-
 include/system/iommufd.h                      |   2 +-
 include/system/kvm_int.h                      |   2 +-
 include/system/memory.h                       |  30 +++-
 include/system/memory_mapping.h               |   4 +-
 include/system/physmem.h                      |   2 +-
 include/system/ram_addr.h                     | 136 ++-------------
 include/system/ramblock.h                     | 160 +++++++++++++++++-
 include/{exec => system}/ramlist.h            |  10 +-
 include/system/reset.h                        |   2 +-
 include/system/xen-mapcache.h                 |   1 -
 include/system/xen.h                          |   3 +-
 migration/migration.h                         |   5 +-
 migration/options.h                           |   4 +-
 rust/hw/core/wrapper.h                        |  12 +-
 target/arm/cpregs.h                           |   2 +-
 target/arm/cpu-features.h                     |   2 +-
 target/arm/cpu.h                              |   2 +-
 target/arm/internals.h                        |   2 +-
 target/arm/mmuidx-internal.h                  |   2 +-
 target/hexagon/cpu.h                          |   2 +-
 target/hppa/cpu.h                             |   2 +-
 target/loongarch/cpu-csr.h                    |   2 +-
 target/loongarch/cpu.h                        |   2 +-
 target/mips/cpu.h                             |   2 +-
 target/ppc/cpu.h                              |   2 +-
 target/ppc/internal.h                         |   2 +-
 target/riscv/cpu.h                            |   4 +-
 target/riscv/internals.h                      |   2 +-
 target/riscv/vector_internals.h               |   2 +-
 target/rx/cpu.h                               |   2 +-
 target/tricore/cpu.h                          |   2 +-
 target/xtensa/cpu.h                           |   2 +-
 include/{exec => system}/memory_ldst.h.inc    |   0
 .../{exec => system}/memory_ldst_cached.h.inc |   0
 .../{exec => system}/memory_ldst_phys.h.inc   |   0
 accel/accel-system.c                          |   2 +-
 accel/hvf/hvf-all.c                           |   2 +-
 accel/kvm/kvm-all.c                           |   4 +-
 accel/mshv/mshv-all.c                         |   3 +-
 accel/tcg/cputlb.c                            |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c               |   3 +-
 accel/tcg/tcg-all.c                           |   2 +-
 accel/xen/xen-all.c                           |   2 +-
 backends/hostmem.c                            |   5 +-
 backends/spdm-socket.c                        |   4 +-
 backends/tpm/tpm_util.c                       |   2 +-
 block/blkio.c                                 |   2 +-
 block/block-backend.c                         |   2 +-
 block/monitor/block-hmp-cmds.c                |   2 +-
 chardev/baum.c                                |   2 +-
 dump/dump.c                                   |   1 +
 gdbstub/gdbstub.c                             |   2 +-
 gdbstub/system.c                              |   2 +-
 hw/9pfs/virtio-9p-device.c                    |   2 +-
 hw/acpi/acpi-nvdimm-stub.c                    |   2 +-
 hw/acpi/aml-build.c                           |   2 +-
 hw/acpi/core.c                                |   2 +-
 hw/acpi/cxl.c                                 |   2 +-
 hw/acpi/erst.c                                |   4 +-
 hw/acpi/generic_event_device.c                |   4 +-
 hw/acpi/ghes.c                                |   1 +
 hw/acpi/memory_hotplug.c                      |   4 +-
 hw/acpi/nvdimm.c                              |   1 +
 hw/acpi/pci.c                                 |   2 +-
 hw/acpi/piix4.c                               |   6 +-
 hw/acpi/utils.c                               |   2 +-
 hw/acpi/vmclock.c                             |   4 +-
 hw/acpi/vmgenid.c                             |   5 +-
 hw/adc/aspeed_adc.c                           |   4 +-
 hw/adc/npcm7xx_adc.c                          |   6 +-
 hw/adc/stm32f2xx_adc.c                        |   2 +-
 hw/adc/zynq-xadc.c                            |   2 +-
 hw/alpha/dp264.c                              |   2 +-
 hw/alpha/typhoon.c                            |   2 +-
 hw/arm/allwinner-a10.c                        |   6 +-
 hw/arm/allwinner-h3.c                         |   6 +-
 hw/arm/allwinner-r40.c                        |   8 +-
 hw/arm/armsse.c                               |   8 +-
 hw/arm/armv7m.c                               |   8 +-
 hw/arm/aspeed.c                               |   2 +-
 hw/arm/aspeed_ast10x0.c                       |   2 +-
 hw/arm/aspeed_ast10x0_evb.c                   |   2 +-
 hw/arm/aspeed_ast27x0-fc.c                    |   6 +-
 hw/arm/aspeed_ast27x0-ssp.c                   |   2 +-
 hw/arm/aspeed_ast27x0-tsp.c                   |   2 +-
 hw/arm/aspeed_coprocessor_common.c            |   2 +-
 hw/arm/aspeed_soc_common.c                    |   4 +-
 hw/arm/b-l475e-iot01a.c                       |   4 +-
 hw/arm/bananapi_m2u.c                         |   4 +-
 hw/arm/bcm2836.c                              |   2 +-
 hw/arm/bcm2838.c                              |   2 +-
 hw/arm/boot.c                                 |   4 +-
 hw/arm/collie.c                               |   4 +-
 hw/arm/cubieboard.c                           |   4 +-
 hw/arm/digic.c                                |   2 +-
 hw/arm/digic_boards.c                         |   4 +-
 hw/arm/exynos4210.c                           |   8 +-
 hw/arm/exynos4_boards.c                       |   8 +-
 hw/arm/fby35.c                                |   4 +-
 hw/arm/fsl-imx25.c                            |   2 +-
 hw/arm/fsl-imx31.c                            |   2 +-
 hw/arm/fsl-imx6.c                             |   4 +-
 hw/arm/fsl-imx6ul.c                           |   2 +-
 hw/arm/fsl-imx7.c                             |   2 +-
 hw/arm/fsl-imx8mp.c                           |   2 +-
 hw/arm/highbank.c                             |   6 +-
 hw/arm/imx25_pdk.c                            |   4 +-
 hw/arm/imx8mp-evk.c                           |   4 +-
 hw/arm/integratorcp.c                         |   8 +-
 hw/arm/kzm.c                                  |   2 +-
 hw/arm/max78000_soc.c                         |   2 +-
 hw/arm/max78000fthr.c                         |   6 +-
 hw/arm/mcimx6ul-evk.c                         |   4 +-
 hw/arm/mcimx7d-sabre.c                        |   4 +-
 hw/arm/microbit.c                             |   4 +-
 hw/arm/mps2-tz.c                              |   8 +-
 hw/arm/mps2.c                                 |   8 +-
 hw/arm/mps3r.c                                |   8 +-
 hw/arm/msf2-soc.c                             |   2 +-
 hw/arm/msf2-som.c                             |   6 +-
 hw/arm/musca.c                                |   4 +-
 hw/arm/musicpal.c                             |  12 +-
 hw/arm/netduino2.c                            |   6 +-
 hw/arm/netduinoplus2.c                        |   6 +-
 hw/arm/npcm7xx.c                              |   6 +-
 hw/arm/npcm7xx_boards.c                       |   6 +-
 hw/arm/npcm8xx.c                              |   8 +-
 hw/arm/npcm8xx_boards.c                       |   8 +-
 hw/arm/nrf51_soc.c                            |   4 +-
 hw/arm/olimex-stm32-h405.c                    |   6 +-
 hw/arm/omap1.c                                |   9 +-
 hw/arm/omap_sx1.c                             |   2 +-
 hw/arm/orangepi.c                             |   4 +-
 hw/arm/raspi.c                                |   6 +-
 hw/arm/raspi4b.c                              |   6 +-
 hw/arm/realview.c                             |   8 +-
 hw/arm/sabrelite.c                            |   4 +-
 hw/arm/sbsa-ref.c                             |   8 +-
 hw/arm/smmu-common.c                          |   2 +-
 hw/arm/smmuv3.c                               |   8 +-
 hw/arm/stellaris.c                            |   8 +-
 hw/arm/stm32f100_soc.c                        |   4 +-
 hw/arm/stm32f205_soc.c                        |   4 +-
 hw/arm/stm32f405_soc.c                        |   2 +-
 hw/arm/stm32l4x5_soc.c                        |   4 +-
 hw/arm/stm32vldiscovery.c                     |   6 +-
 hw/arm/strongarm.c                            |   8 +-
 hw/arm/versatilepb.c                          |   6 +-
 hw/arm/vexpress.c                             |   6 +-
 hw/arm/virt-acpi-build.c                      |   2 +-
 hw/arm/virt.c                                 |  10 +-
 hw/arm/xen-pvh.c                              |   2 +-
 hw/arm/xen-stubs.c                            |   2 +-
 hw/arm/xilinx_zynq.c                          |   8 +-
 hw/arm/xlnx-versal-virt.c                     |   4 +-
 hw/arm/xlnx-versal.c                          |   4 +-
 hw/arm/xlnx-zcu102.c                          |   2 +-
 hw/arm/xlnx-zynqmp.c                          |   2 +-
 hw/audio/ac97.c                               |   2 +-
 hw/audio/adlib.c                              |   2 +-
 hw/audio/asc.c                                |   6 +-
 hw/audio/cs4231.c                             |   2 +-
 hw/audio/cs4231a.c                            |   4 +-
 hw/audio/gus.c                                |   4 +-
 hw/audio/hda-codec.c                          |   2 +-
 hw/audio/intel-hda.c                          |   2 +-
 hw/audio/lm4549.c                             |   2 +-
 hw/audio/marvell_88w8618.c                    |   7 +-
 hw/audio/model.c                              |   4 +-
 hw/audio/pl041.c                              |   6 +-
 hw/audio/sb16.c                               |   4 +-
 hw/avr/atmega.c                               |   4 +-
 hw/avr/boot.c                                 |   2 +-
 hw/block/fdc-isa.c                            |   6 +-
 hw/block/fdc-sysbus.c                         |   2 +-
 hw/block/fdc.c                                |   6 +-
 hw/block/m25p80.c                             |   4 +-
 hw/block/pflash_cfi01.c                       |   6 +-
 hw/block/pflash_cfi02.c                       |   6 +-
 hw/block/swim.c                               |   4 +-
 hw/block/vhost-user-blk.c                     |   6 +-
 hw/block/virtio-blk.c                         |   2 +-
 hw/block/xen-block.c                          |   2 +-
 hw/char/avr_usart.c                           |   6 +-
 hw/char/bcm2835_aux.c                         |   6 +-
 hw/char/cadence_uart.c                        |   8 +-
 hw/char/cmsdk-apb-uart.c                      |   8 +-
 hw/char/debugcon.c                            |   4 +-
 hw/char/digic-uart.c                          |   6 +-
 hw/char/diva-gsp.c                            |   6 +-
 hw/char/escc.c                                |   8 +-
 hw/char/exynos4210_uart.c                     |   8 +-
 hw/char/goldfish_tty.c                        |   6 +-
 hw/char/grlib_apbuart.c                       |   8 +-
 hw/char/ibex_uart.c                           |  10 +-
 hw/char/imx_serial.c                          |   6 +-
 hw/char/ipoctal232.c                          |   6 +-
 hw/char/max78000_uart.c                       |   6 +-
 hw/char/mcf_uart.c                            |   8 +-
 hw/char/mchp_pfsoc_mmuart.c                   |   2 +-
 hw/char/nrf51_uart.c                          |   6 +-
 hw/char/parallel-isa.c                        |   2 +-
 hw/char/parallel.c                            |   4 +-
 hw/char/pl011.c                               |  10 +-
 hw/char/renesas_sci.c                         |   8 +-
 hw/char/riscv_htif.c                          |   1 +
 hw/char/sclpconsole-lm.c                      |   4 +-
 hw/char/sclpconsole.c                         |   4 +-
 hw/char/serial-isa.c                          |   2 +-
 hw/char/serial-mm.c                           |   2 +-
 hw/char/serial-pci-multi.c                    |   6 +-
 hw/char/serial-pci.c                          |   4 +-
 hw/char/serial.c                              |   6 +-
 hw/char/sh_serial.c                           |  10 +-
 hw/char/shakti_uart.c                         |   4 +-
 hw/char/sifive_uart.c                         |   4 +-
 hw/char/spapr_vty.c                           |   4 +-
 hw/char/stm32f2xx_usart.c                     |   6 +-
 hw/char/stm32l4x5_usart.c                     |  12 +-
 hw/char/terminal3270.c                        |   4 +-
 hw/char/virtio-console.c                      |   4 +-
 hw/char/virtio-serial-bus.c                   |   2 +-
 hw/char/xen_console.c                         |   4 +-
 hw/char/xilinx_uartlite.c                     |   8 +-
 hw/core/bus.c                                 |   2 +-
 hw/core/clock-vmstate.c                       |   2 +-
 hw/core/clock.c                               |   2 +-
 hw/core/cpu-common.c                          |   5 +-
 hw/core/cpu-system.c                          |   4 +-
 hw/core/cpu-user.c                            |   4 +-
 hw/core/fw-path-provider.c                    |   2 +-
 hw/core/generic-loader.c                      |   6 +-
 hw/core/gpio.c                                |   4 +-
 hw/core/guest-loader.c                        |   6 +-
 hw/core/hotplug.c                             |   2 +-
 hw/core/irq.c                                 |   2 +-
 hw/core/loader-fit.c                          |   4 +-
 hw/core/loader.c                              |   6 +-
 hw/core/machine-hmp-cmds.c                    |   2 +-
 hw/core/machine-qmp-cmds.c                    |   3 +-
 hw/core/machine-smp.c                         |   2 +-
 hw/core/machine.c                             |   4 +-
 hw/core/nmi.c                                 |   2 +-
 hw/core/null-machine.c                        |   2 +-
 hw/core/numa.c                                |   5 +-
 hw/core/or-irq.c                              |   6 +-
 hw/core/platform-bus.c                        |   4 +-
 hw/core/ptimer.c                              |   4 +-
 hw/core/qdev-clock.c                          |   4 +-
 hw/core/qdev-fw.c                             |   4 +-
 hw/core/qdev-hotplug.c                        |   4 +-
 hw/core/qdev-properties-system.c              |   4 +-
 hw/core/qdev-properties.c                     |   2 +-
 hw/core/qdev-user.c                           |   2 +-
 hw/core/qdev.c                                |  10 +-
 hw/core/register.c                            |   2 +-
 hw/core/reset.c                               |   2 +-
 hw/core/resetcontainer.c                      |   2 +-
 hw/core/resettable.c                          |   2 +-
 hw/core/split-irq.c                           |   4 +-
 hw/core/stream.c                              |   2 +-
 hw/core/sysbus-fdt.c                          |   2 +-
 hw/core/sysbus.c                              |   2 +-
 hw/core/vm-change-state-handler.c             |   2 +-
 hw/core/vmstate-if.c                          |   2 +-
 hw/cpu/a15mpcore.c                            |   4 +-
 hw/cpu/a9mpcore.c                             |   4 +-
 hw/cpu/arm11mpcore.c                          |   4 +-
 hw/cpu/cluster.c                              |   2 +-
 hw/cpu/core.c                                 |   2 +-
 hw/cpu/realview_mpcore.c                      |   2 +-
 hw/cxl/cxl-host.c                             |   2 +-
 hw/cxl/switch-mailbox-cci.c                   |   2 +-
 hw/display/artist.c                           |   8 +-
 hw/display/ati.c                              |   2 +-
 hw/display/bcm2835_fb.c                       |   6 +-
 hw/display/bochs-display.c                    |   2 +-
 hw/display/cg3.c                              |   8 +-
 hw/display/cirrus_vga.c                       |   2 +-
 hw/display/cirrus_vga_isa.c                   |   4 +-
 hw/display/dm163.c                            |   4 +-
 hw/display/exynos4210_fimd.c                  |   9 +-
 hw/display/g364fb.c                           |   8 +-
 hw/display/i2c-ddc.c                          |   2 +-
 hw/display/jazz_led.c                         |   2 +-
 hw/display/macfb.c                            |   4 +-
 hw/display/next-fb.c                          |   2 +-
 hw/display/omap_lcdc.c                        |   3 +-
 hw/display/pl110.c                            |   6 +-
 hw/display/qxl.c                              |   2 +-
 hw/display/ramfb-standalone.c                 |   4 +-
 hw/display/ramfb.c                            |   3 +-
 hw/display/sm501.c                            |   4 +-
 hw/display/tcx.c                              |   6 +-
 hw/display/vga-isa.c                          |   4 +-
 hw/display/vga-mmio.c                         |   4 +-
 hw/display/vga-pci.c                          |   4 +-
 hw/display/vga.c                              |   1 +
 hw/display/vhost-user-gpu.c                   |   2 +-
 hw/display/virtio-gpu-gl.c                    |   2 +-
 hw/display/virtio-gpu-pci-gl.c                |   2 +-
 hw/display/virtio-gpu-pci-rutabaga.c          |   2 +-
 hw/display/virtio-gpu-pci.c                   |   2 +-
 hw/display/virtio-gpu.c                       |   2 +-
 hw/display/virtio-vga-gl.c                    |   2 +-
 hw/display/virtio-vga-rutabaga.c              |   2 +-
 hw/display/virtio-vga.c                       |   2 +-
 hw/display/vmware_vga.c                       |   4 +-
 hw/display/xlnx_dp.c                          |   2 +-
 hw/dma/bcm2835_dma.c                          |   2 +-
 hw/dma/i82374.c                               |   2 +-
 hw/dma/i8257.c                                |   3 +-
 hw/dma/omap_dma.c                             |   3 +-
 hw/dma/pl080.c                                |   8 +-
 hw/dma/pl330.c                                |   6 +-
 hw/dma/rc4030.c                               |   5 +-
 hw/dma/sifive_pdma.c                          |   7 +-
 hw/dma/sparc32_dma.c                          |   6 +-
 hw/dma/xilinx_axidma.c                        |  12 +-
 hw/dma/xlnx-zdma.c                            |   4 +-
 hw/dma/xlnx-zynq-devcfg.c                     |   2 +-
 hw/dma/xlnx_csu_dma.c                         |  12 +-
 hw/dma/xlnx_dpdma.c                           |   2 +-
 hw/fsi/aspeed_apb2opb.c                       |   2 +-
 hw/fsi/cfam.c                                 |   2 +-
 hw/fsi/lbus.c                                 |   2 +-
 hw/gpio/aspeed_gpio.c                         |   4 +-
 hw/gpio/bcm2835_gpio.c                        |   4 +-
 hw/gpio/bcm2838_gpio.c                        |   4 +-
 hw/gpio/gpio_key.c                            |   4 +-
 hw/gpio/gpio_pwr.c                            |   2 +-
 hw/gpio/imx_gpio.c                            |   4 +-
 hw/gpio/mpc8xxx.c                             |   4 +-
 hw/gpio/npcm7xx_gpio.c                        |   4 +-
 hw/gpio/nrf51_gpio.c                          |   2 +-
 hw/gpio/omap_gpio.c                           |   6 +-
 hw/gpio/pca9552.c                             |   4 +-
 hw/gpio/pca9554.c                             |   4 +-
 hw/gpio/pcf8574.c                             |   2 +-
 hw/gpio/pl061.c                               |   6 +-
 hw/gpio/sifive_gpio.c                         |   4 +-
 hw/gpio/stm32l4x5_gpio.c                      |   8 +-
 hw/gpio/zaurus.c                              |   4 +-
 hw/hppa/machine.c                             |   6 +-
 hw/hyperv/hv-balloon.c                        |   6 +-
 hw/hyperv/hyperv.c                            |   1 +
 hw/hyperv/syndbg.c                            |   5 +-
 hw/hyperv/vmbus.c                             |   7 +-
 hw/i2c/allwinner-i2c.c                        |   2 +-
 hw/i2c/arm_sbcon_i2c.c                        |   2 +-
 hw/i2c/aspeed_i2c.c                           |   8 +-
 hw/i2c/bcm2835_i2c.c                          |   2 +-
 hw/i2c/bitbang_i2c.c                          |   4 +-
 hw/i2c/core.c                                 |   2 +-
 hw/i2c/exynos4210_i2c.c                       |   4 +-
 hw/i2c/i2c_mux_pca954x.c                      |   6 +-
 hw/i2c/imx_i2c.c                              |   2 +-
 hw/i2c/mpc_i2c.c                              |   4 +-
 hw/i2c/omap_i2c.c                             |   6 +-
 hw/i2c/pm_smbus.c                             |   2 +-
 hw/i2c/ppc4xx_i2c.c                           |   2 +-
 hw/i2c/smbus_eeprom.c                         |   4 +-
 hw/i386/amd_iommu.c                           |   2 +-
 hw/i386/intel_iommu.c                         |   4 +-
 hw/i386/kvm/clock.c                           |   5 +-
 hw/i386/kvm/i8254.c                           |   2 +-
 hw/i386/kvm/i8259.c                           |   2 +-
 hw/i386/kvm/ioapic.c                          |   2 +-
 hw/i386/kvm/xen_evtchn.c                      |   4 +-
 hw/i386/kvm/xen_gnttab.c                      |   2 +-
 hw/i386/kvm/xen_overlay.c                     |   2 +-
 hw/i386/kvm/xen_primary_console.c             |   2 +-
 hw/i386/kvm/xen_xenstore.c                    |   2 +-
 hw/i386/microvm-dt.c                          |   2 +-
 hw/i386/microvm.c                             |   4 +-
 hw/i386/multiboot.c                           |   2 +-
 hw/i386/nitro_enclave.c                       |   2 +-
 hw/i386/pc.c                                  |   4 +-
 hw/i386/pc_piix.c                             |   6 +-
 hw/i386/pc_q35.c                              |   6 +-
 hw/i386/pc_sysfw.c                            |   6 +-
 hw/i386/port92.c                              |   2 +-
 hw/i386/sgx-epc.c                             |   2 +-
 hw/i386/vapic.c                               |   5 +-
 hw/i386/vmmouse.c                             |   2 +-
 hw/i386/vmport.c                              |   4 +-
 hw/i386/x86-common.c                          |   4 +-
 hw/i386/x86-cpu.c                             |   2 +-
 hw/i386/x86-iommu.c                           |   4 +-
 hw/i386/x86.c                                 |   2 +-
 hw/i386/xen/xen-hvm.c                         |   4 +-
 hw/i386/xen/xen-pvh.c                         |   2 +-
 hw/i386/xen/xen_pvdevice.c                    |   2 +-
 hw/ide/ahci-sysbus.c                          |   2 +-
 hw/ide/ahci.c                                 |   2 +-
 hw/ide/cmd646.c                               |   2 +-
 hw/ide/core.c                                 |   2 +-
 hw/ide/isa.c                                  |   2 +-
 hw/ide/macio.c                                |   4 +-
 hw/ide/mmio.c                                 |   4 +-
 hw/ide/pci.c                                  |   2 +-
 hw/ide/via.c                                  |   2 +-
 hw/input/adb.c                                |   2 +-
 hw/input/lasips2.c                            |   6 +-
 hw/input/pckbd.c                              |   4 +-
 hw/input/pl050.c                              |   4 +-
 hw/input/ps2.c                                |   4 +-
 hw/input/stellaris_gamepad.c                  |   4 +-
 hw/input/virtio-input-hid.c                   |   2 +-
 hw/input/virtio-input-host.c                  |   2 +-
 hw/input/virtio-input.c                       |   2 +-
 hw/intc/allwinner-a10-pic.c                   |   4 +-
 hw/intc/apic.c                                |   1 +
 hw/intc/apic_common.c                         |   6 +-
 hw/intc/arm_gic.c                             |   4 +-
 hw/intc/arm_gic_common.c                      |   2 +-
 hw/intc/arm_gicv2m.c                          |   6 +-
 hw/intc/arm_gicv3_common.c                    |   2 +-
 hw/intc/arm_gicv3_cpuif.c                     |   2 +-
 hw/intc/arm_gicv3_its.c                       |   2 +-
 hw/intc/arm_gicv3_its_kvm.c                   |   2 +-
 hw/intc/armv7m_nvic.c                         |   6 +-
 hw/intc/aspeed_intc.c                         |   4 +-
 hw/intc/aspeed_vic.c                          |   2 +-
 hw/intc/bcm2835_ic.c                          |   2 +-
 hw/intc/bcm2836_control.c                     |   2 +-
 hw/intc/exynos4210_combiner.c                 |   8 +-
 hw/intc/exynos4210_gic.c                      |   6 +-
 hw/intc/goldfish_pic.c                        |   6 +-
 hw/intc/grlib_irqmp.c                         |   6 +-
 hw/intc/heathrow_pic.c                        |   2 +-
 hw/intc/i8259.c                               |   2 +-
 hw/intc/i8259_common.c                        |   2 +-
 hw/intc/imx_avic.c                            |   2 +-
 hw/intc/ioapic.c                              |   2 +-
 hw/intc/ioapic_common.c                       |   2 +-
 hw/intc/loongarch_dintc.c                     |   6 +-
 hw/intc/loongarch_extioi.c                    |   2 +-
 hw/intc/loongarch_extioi_common.c             |   2 +-
 hw/intc/loongarch_ipi.c                       |   4 +-
 hw/intc/loongarch_pch_msi.c                   |   4 +-
 hw/intc/loongarch_pch_pic.c                   |   2 +-
 hw/intc/loongarch_pic_common.c                |   2 +-
 hw/intc/loongarch_pic_kvm.c                   |   2 +-
 hw/intc/loongson_ipi.c                        |   2 +-
 hw/intc/loongson_ipi_common.c                 |   4 +-
 hw/intc/loongson_liointc.c                    |   4 +-
 hw/intc/m68k_irqc.c                           |   4 +-
 hw/intc/mips_gic.c                            |   6 +-
 hw/intc/omap_intc.c                           |   6 +-
 hw/intc/ompic.c                               |   6 +-
 hw/intc/openpic.c                             |   6 +-
 hw/intc/openpic_kvm.c                         |   4 +-
 hw/intc/pl190.c                               |   4 +-
 hw/intc/pnv_xive.c                            |   2 +-
 hw/intc/pnv_xive2.c                           |   2 +-
 hw/intc/ppc-uic.c                             |   4 +-
 hw/intc/realview_gic.c                        |   4 +-
 hw/intc/riscv_aclint.c                        |   6 +-
 hw/intc/riscv_aplic.c                         |   8 +-
 hw/intc/riscv_imsic.c                         |   8 +-
 hw/intc/rx_icu.c                              |   6 +-
 hw/intc/s390_flic.c                           |   4 +-
 hw/intc/sh_intc.c                             |   2 +-
 hw/intc/sifive_plic.c                         |   6 +-
 hw/intc/slavio_intctl.c                       |   4 +-
 hw/intc/spapr_xive.c                          |   2 +-
 hw/intc/xics.c                                |   4 +-
 hw/intc/xilinx_intc.c                         |   8 +-
 hw/intc/xive.c                                |   4 +-
 hw/intc/xive2.c                               |   3 +-
 hw/intc/xlnx-pmu-iomod-intc.c                 |   8 +-
 hw/intc/xlnx-zynqmp-ipi.c                     |   6 +-
 hw/ipack/ipack.c                              |   4 +-
 hw/ipack/tpci200.c                            |   2 +-
 hw/ipmi/ipmi.c                                |   4 +-
 hw/ipmi/ipmi_bmc_extern.c                     |   4 +-
 hw/ipmi/ipmi_bmc_sim.c                        |   6 +-
 hw/ipmi/isa_ipmi_bt.c                         |   4 +-
 hw/ipmi/isa_ipmi_kcs.c                        |   4 +-
 hw/isa/i82378.c                               |   2 +-
 hw/isa/isa-bus.c                              |   2 +-
 hw/isa/isa-superio.c                          |   2 +-
 hw/isa/lpc_ich9.c                             |   4 +-
 hw/isa/pc87312.c                              |   2 +-
 hw/isa/piix.c                                 |   4 +-
 hw/isa/vt82c686.c                             |   4 +-
 hw/loongarch/boot.c                           |   2 +-
 hw/loongarch/virt-acpi-build.c                |   2 +-
 hw/loongarch/virt-fdt-build.c                 |   2 +-
 hw/loongarch/virt.c                           |   8 +-
 hw/m68k/an5206.c                              |   4 +-
 hw/m68k/mcf5206.c                             |  10 +-
 hw/m68k/mcf5208.c                             |  10 +-
 hw/m68k/mcf_intc.c                            |   6 +-
 hw/m68k/next-cube.c                           |  11 +-
 hw/m68k/next-kbd.c                            |   2 +-
 hw/m68k/q800-glue.c                           |   8 +-
 hw/m68k/q800.c                                |   8 +-
 hw/m68k/virt.c                                |   8 +-
 hw/mem/cxl_type3.c                            |   4 +-
 hw/mem/memory-device.c                        |   2 +-
 hw/mem/nvdimm.c                               |   2 +-
 hw/mem/pc-dimm.c                              |   4 +-
 hw/mem/sparse-mem.c                           |   4 +-
 hw/microblaze/boot.c                          |   5 +-
 hw/microblaze/petalogix_ml605_mmu.c           |   8 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |   4 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |   2 +-
 hw/mips/boston.c                              |  10 +-
 hw/mips/cps.c                                 |   4 +-
 hw/mips/fuloong2e.c                           |   8 +-
 hw/mips/jazz.c                                |   8 +-
 hw/mips/loongson3_virt.c                      |   4 +-
 hw/mips/malta.c                               |  12 +-
 hw/mips/mips_int.c                            |   2 +-
 hw/misc/a9scu.c                               |   2 +-
 hw/misc/allwinner-a10-ccm.c                   |   2 +-
 hw/misc/allwinner-a10-dramc.c                 |   2 +-
 hw/misc/allwinner-cpucfg.c                    |   2 +-
 hw/misc/allwinner-h3-ccu.c                    |   2 +-
 hw/misc/allwinner-h3-dramc.c                  |   4 +-
 hw/misc/allwinner-h3-sysctrl.c                |   2 +-
 hw/misc/allwinner-r40-ccu.c                   |   2 +-
 hw/misc/allwinner-r40-dramc.c                 |   4 +-
 hw/misc/allwinner-sid.c                       |   6 +-
 hw/misc/allwinner-sramc.c                     |   6 +-
 hw/misc/applesmc.c                            |   2 +-
 hw/misc/arm11scu.c                            |   2 +-
 hw/misc/arm_integrator_debug.c                |   2 +-
 hw/misc/arm_l2x0.c                            |   4 +-
 hw/misc/arm_sysctl.c                          |   6 +-
 hw/misc/armsse-cpu-pwrctrl.c                  |   4 +-
 hw/misc/armsse-cpuid.c                        |   6 +-
 hw/misc/armsse-mhu.c                          |   6 +-
 hw/misc/aspeed_hace.c                         |   4 +-
 hw/misc/aspeed_i3c.c                          |   4 +-
 hw/misc/aspeed_lpc.c                          |   4 +-
 hw/misc/aspeed_peci.c                         |   4 +-
 hw/misc/aspeed_sbc.c                          |   2 +-
 hw/misc/aspeed_scu.c                          |   2 +-
 hw/misc/aspeed_sdmc.c                         |   2 +-
 hw/misc/aspeed_sli.c                          |   2 +-
 hw/misc/aspeed_xdma.c                         |   2 +-
 hw/misc/avr_power.c                           |   4 +-
 hw/misc/bcm2835_cprman.c                      |   2 +-
 hw/misc/bcm2835_mbox.c                        |   2 +-
 hw/misc/bcm2835_property.c                    |   4 +-
 hw/misc/bcm2835_thermal.c                     |   2 +-
 hw/misc/debugexit.c                           |   2 +-
 hw/misc/djmemc.c                              |   2 +-
 hw/misc/eccmemctl.c                           |   6 +-
 hw/misc/empty_slot.c                          |   4 +-
 hw/misc/exynos4210_clk.c                      |   2 +-
 hw/misc/exynos4210_pmu.c                      |   2 +-
 hw/misc/exynos4210_rng.c                      |   2 +-
 hw/misc/grlib_ahb_apb_pnp.c                   |   2 +-
 hw/misc/imx6ul_ccm.c                          |   2 +-
 hw/misc/imx7_src.c                            |   2 +-
 hw/misc/imx_rngc.c                            |   2 +-
 hw/misc/iosb.c                                |   2 +-
 hw/misc/iotkit-secctl.c                       |   8 +-
 hw/misc/iotkit-sysctl.c                       |   6 +-
 hw/misc/iotkit-sysinfo.c                      |   6 +-
 hw/misc/ivshmem-flat.c                        |   6 +-
 hw/misc/ivshmem-pci.c                         |   4 +-
 hw/misc/lasi.c                                |   2 +-
 hw/misc/led.c                                 |   2 +-
 hw/misc/mac_via.c                             |   8 +-
 hw/misc/macio/cuda.c                          |   4 +-
 hw/misc/macio/gpio.c                          |   6 +-
 hw/misc/macio/mac_dbdma.c                     |   2 +-
 hw/misc/macio/macio.c                         |   2 +-
 hw/misc/macio/pmu.c                           |   4 +-
 hw/misc/max78000_aes.c                        |   2 +-
 hw/misc/max78000_gcr.c                        |   4 +-
 hw/misc/max78000_icc.c                        |   2 +-
 hw/misc/max78000_trng.c                       |   2 +-
 hw/misc/mchp_pfsoc_dmc.c                      |   2 +-
 hw/misc/mchp_pfsoc_ioscb.c                    |   4 +-
 hw/misc/mchp_pfsoc_sysreg.c                   |   4 +-
 hw/misc/mips_cmgcr.c                          |   4 +-
 hw/misc/mips_cpc.c                            |   4 +-
 hw/misc/mips_itu.c                            |   2 +-
 hw/misc/mos6522.c                             |   4 +-
 hw/misc/mps2-fpgaio.c                         |   6 +-
 hw/misc/mps2-scc.c                            |   8 +-
 hw/misc/msf2-sysreg.c                         |   2 +-
 hw/misc/npcm7xx_mft.c                         |   8 +-
 hw/misc/npcm7xx_pwm.c                         |   8 +-
 hw/misc/npcm_clk.c                            |   2 +-
 hw/misc/npcm_gcr.c                            |   2 +-
 hw/misc/nrf51_rng.c                           |   4 +-
 hw/misc/omap_clk.c                            |   4 +-
 hw/misc/pc-testdev.c                          |   3 +-
 hw/misc/pci-testdev.c                         |   2 +-
 hw/misc/pvpanic-isa.c                         |   2 +-
 hw/misc/pvpanic-mmio.c                        |   4 +-
 hw/misc/pvpanic-pci.c                         |   2 +-
 hw/misc/pvpanic.c                             |   2 +-
 hw/misc/sbsa_ec.c                             |   2 +-
 hw/misc/sifive_e_aon.c                        |   6 +-
 hw/misc/sifive_e_prci.c                       |   2 +-
 hw/misc/sifive_test.c                         |   2 +-
 hw/misc/sifive_u_otp.c                        |   6 +-
 hw/misc/sifive_u_prci.c                       |   2 +-
 hw/misc/slavio_misc.c                         |   4 +-
 hw/misc/stm32_rcc.c                           |   2 +-
 hw/misc/stm32f4xx_exti.c                      |   2 +-
 hw/misc/stm32f4xx_syscfg.c                    |   2 +-
 hw/misc/stm32l4x5_exti.c                      |   2 +-
 hw/misc/stm32l4x5_rcc.c                       |  12 +-
 hw/misc/stm32l4x5_syscfg.c                    |   6 +-
 hw/misc/tz-mpc.c                              |   8 +-
 hw/misc/tz-msc.c                              |   8 +-
 hw/misc/tz-ppc.c                              |   8 +-
 hw/misc/unimp.c                               |   2 +-
 hw/misc/virt_ctrl.c                           |   4 +-
 hw/misc/xlnx-versal-cframe-reg.c              |  10 +-
 hw/misc/xlnx-versal-cfu.c                     |  10 +-
 hw/misc/xlnx-versal-crl.c                     |  10 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c            |   8 +-
 hw/misc/xlnx-versal-trng.c                    |   2 +-
 hw/misc/xlnx-versal-xramc.c                   |   8 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c                |   8 +-
 hw/misc/xlnx-zynqmp-crf.c                     |   6 +-
 hw/misc/zynq_slcr.c                           |   8 +-
 hw/net/allwinner-sun8i-emac.c                 |   6 +-
 hw/net/allwinner_emac.c                       |   6 +-
 hw/net/cadence_gem.c                          |   6 +-
 hw/net/can/can_kvaser_pci.c                   |   4 +-
 hw/net/can/can_mioe3680_pci.c                 |   4 +-
 hw/net/can/can_pcm3680_pci.c                  |   4 +-
 hw/net/can/can_sja1000.c                      |   2 +-
 hw/net/can/ctucan_core.c                      |   2 +-
 hw/net/can/ctucan_pci.c                       |   4 +-
 hw/net/can/xlnx-versal-canfd.c                |   8 +-
 hw/net/can/xlnx-zynqmp-can.c                  |   8 +-
 hw/net/dp8393x.c                              |   6 +-
 hw/net/e1000.c                                |   2 +-
 hw/net/e1000e.c                               |   4 +-
 hw/net/eepro100.c                             |   2 +-
 hw/net/fsl_etsec/etsec.c                      |   8 +-
 hw/net/fsl_etsec/rings.c                      |   1 +
 hw/net/ftgmac100.c                            |   4 +-
 hw/net/i82596.c                               |   4 +-
 hw/net/igb.c                                  |   4 +-
 hw/net/igbvf.c                                |   2 +-
 hw/net/imx_fec.c                              |   4 +-
 hw/net/lan9118.c                              |   8 +-
 hw/net/lan9118_phy.c                          |   4 +-
 hw/net/lance.c                                |   2 +-
 hw/net/lasi_i82596.c                          |   4 +-
 hw/net/mcf_fec.c                              |   7 +-
 hw/net/msf2-emac.c                            |   6 +-
 hw/net/mv88w8618_eth.c                        |   6 +-
 hw/net/ne2000-pci.c                           |   4 +-
 hw/net/ne2000.c                               |   2 +-
 hw/net/npcm7xx_emc.c                          |   6 +-
 hw/net/npcm_gmac.c                            |   2 +-
 hw/net/npcm_pcs.c                             |   2 +-
 hw/net/opencores_eth.c                        |   7 +-
 hw/net/pcnet-pci.c                            |   4 +-
 hw/net/pcnet.c                                |   4 +-
 hw/net/rocker/rocker.c                        |   4 +-
 hw/net/rtl8139.c                              |   2 +-
 hw/net/smc91c111.c                            |   8 +-
 hw/net/spapr_llan.c                           |   2 +-
 hw/net/stellaris_enet.c                       |   6 +-
 hw/net/sungem.c                               |   2 +-
 hw/net/sunhme.c                               |   2 +-
 hw/net/tulip.c                                |   4 +-
 hw/net/virtio-net.c                           |   2 +-
 hw/net/vmxnet3.c                              |   4 +-
 hw/net/xen_nic.c                              |   4 +-
 hw/net/xgmac.c                                |   7 +-
 hw/net/xilinx_axienet.c                       |  10 +-
 hw/net/xilinx_ethlite.c                       |   8 +-
 hw/nubus/mac-nubus-bridge.c                   |   2 +-
 hw/nubus/nubus-bridge.c                       |   2 +-
 hw/nubus/nubus-device.c                       |   4 +-
 hw/nvram/aspeed_otp.c                         |   2 +-
 hw/nvram/ds1225y.c                            |   4 +-
 hw/nvram/eeprom_at24c.c                       |   4 +-
 hw/nvram/fw_cfg.c                             |   8 +-
 hw/nvram/mac_nvram.c                          |   4 +-
 hw/nvram/nrf51_nvm.c                          |   2 +-
 hw/nvram/spapr_nvram.c                        |   5 +-
 hw/nvram/xlnx-bbram.c                         |   4 +-
 hw/nvram/xlnx-efuse.c                         |   4 +-
 hw/nvram/xlnx-versal-efuse-cache.c            |   2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c             |   2 +-
 hw/nvram/xlnx-zynqmp-efuse.c                  |   2 +-
 hw/openrisc/boot.c                            |   2 +-
 hw/openrisc/openrisc_sim.c                    |   8 +-
 hw/openrisc/virt.c                            |   8 +-
 hw/pci-bridge/cxl_downstream.c                |   4 +-
 hw/pci-bridge/cxl_root_port.c                 |   6 +-
 hw/pci-bridge/cxl_upstream.c                  |   4 +-
 hw/pci-bridge/gen_pcie_root_port.c            |   4 +-
 hw/pci-bridge/pci_bridge_dev.c                |   4 +-
 hw/pci-bridge/pci_expander_bridge.c           |   4 +-
 hw/pci-bridge/pcie_pci_bridge.c               |   2 +-
 hw/pci-bridge/pcie_root_port.c                |   2 +-
 hw/pci-bridge/xio3130_downstream.c            |   2 +-
 hw/pci-host/articia.c                         |   2 +-
 hw/pci-host/aspeed_pcie.c                     |   6 +-
 hw/pci-host/astro.c                           |   4 +-
 hw/pci-host/bonito.c                          |   4 +-
 hw/pci-host/designware.c                      |   4 +-
 hw/pci-host/dino.c                            |   4 +-
 hw/pci-host/fsl_imx8m_phy.c                   |   2 +-
 hw/pci-host/gpex.c                            |   4 +-
 hw/pci-host/grackle.c                         |   4 +-
 hw/pci-host/gt64120.c                         |   6 +-
 hw/pci-host/i440fx.c                          |   4 +-
 hw/pci-host/mv64361.c                         |   6 +-
 hw/pci-host/pnv_phb.c                         |   2 +-
 hw/pci-host/pnv_phb3.c                        |   4 +-
 hw/pci-host/pnv_phb3_msi.c                    |   4 +-
 hw/pci-host/pnv_phb4.c                        |   4 +-
 hw/pci-host/pnv_phb4_pec.c                    |   2 +-
 hw/pci-host/ppc440_pcix.c                     |   2 +-
 hw/pci-host/ppc4xx_pci.c                      |   2 +-
 hw/pci-host/ppce500.c                         |   4 +-
 hw/pci-host/q35.c                             |   2 +-
 hw/pci-host/raven.c                           |   6 +-
 hw/pci-host/remote.c                          |   2 +-
 hw/pci-host/sabre.c                           |   6 +-
 hw/pci-host/sh_pci.c                          |   4 +-
 hw/pci-host/uninorth.c                        |   4 +-
 hw/pci-host/versatile.c                       |   6 +-
 hw/pci-host/xilinx-pcie.c                     |   4 +-
 hw/pci/pci.c                                  |  12 +-
 hw/pci/pci_bridge.c                           |   2 +-
 hw/pci/pci_host.c                             |   2 +-
 hw/pci/pcie_port.c                            |   4 +-
 hw/pci/pcie_sriov.c                           |   2 +-
 hw/ppc/amigaone.c                             |   5 +-
 hw/ppc/e500.c                                 |  11 +-
 hw/ppc/e500plat.c                             |   2 +-
 hw/ppc/mac_newworld.c                         |  12 +-
 hw/ppc/mac_oldworld.c                         |   8 +-
 hw/ppc/mpc8544_guts.c                         |   2 +-
 hw/ppc/pegasos.c                              |  15 +-
 hw/ppc/pnv.c                                  |   7 +-
 hw/ppc/pnv_adu.c                              |   2 +-
 hw/ppc/pnv_chiptod.c                          |   4 +-
 hw/ppc/pnv_core.c                             |   2 +-
 hw/ppc/pnv_homer.c                            |   4 +-
 hw/ppc/pnv_i2c.c                              |   4 +-
 hw/ppc/pnv_lpc.c                              |   4 +-
 hw/ppc/pnv_n1_chiplet.c                       |   2 +-
 hw/ppc/pnv_nest_pervasive.c                   |   2 +-
 hw/ppc/pnv_occ.c                              |   4 +-
 hw/ppc/pnv_pnor.c                             |   6 +-
 hw/ppc/pnv_psi.c                              |   4 +-
 hw/ppc/pnv_sbe.c                              |   4 +-
 hw/ppc/pnv_xscom.c                            |   2 +-
 hw/ppc/ppc.c                                  |   2 +-
 hw/ppc/ppc440_bamboo.c                        |   8 +-
 hw/ppc/ppc440_uc.c                            |   5 +-
 hw/ppc/ppc4xx_devs.c                          |   2 +-
 hw/ppc/ppc4xx_sdram.c                         |   4 +-
 hw/ppc/ppc_booke.c                            |   2 +-
 hw/ppc/ppce500_spin.c                         |   4 +-
 hw/ppc/ppe42_machine.c                        |   2 +-
 hw/ppc/prep.c                                 |   6 +-
 hw/ppc/prep_systemio.c                        |   4 +-
 hw/ppc/rs6000_mc.c                            |   2 +-
 hw/ppc/sam460ex.c                             |   8 +-
 hw/ppc/spapr.c                                |  11 +-
 hw/ppc/spapr_cpu_core.c                       |   2 +-
 hw/ppc/spapr_drc.c                            |   1 +
 hw/ppc/spapr_events.c                         |   3 +-
 hw/ppc/spapr_hcall.c                          |   1 +
 hw/ppc/spapr_irq.c                            |   4 +-
 hw/ppc/spapr_nvdimm.c                         |   2 +-
 hw/ppc/spapr_pci.c                            |   6 +-
 hw/ppc/spapr_rng.c                            |   2 +-
 hw/ppc/spapr_rtas.c                           |   1 +
 hw/ppc/spapr_tpm_proxy.c                      |   3 +-
 hw/ppc/spapr_vio.c                            |   4 +-
 hw/ppc/virtex_ml507.c                         |   9 +-
 hw/remote/machine.c                           |   2 +-
 hw/remote/proxy-memory-listener.c             |   1 +
 hw/remote/proxy.c                             |   2 +-
 hw/remote/remote-obj.c                        |   2 +-
 hw/remote/vfio-user-obj.c                     |   4 +-
 hw/riscv/boot.c                               |   4 +-
 hw/riscv/microblaze-v-generic.c               |   4 +-
 hw/riscv/microchip_pfsoc.c                    |   6 +-
 hw/riscv/numa.c                               |   4 +-
 hw/riscv/opentitan.c                          |   2 +-
 hw/riscv/riscv-iommu-pci.c                    |   2 +-
 hw/riscv/riscv-iommu-sys.c                    |   6 +-
 hw/riscv/riscv-iommu.c                        |   2 +-
 hw/riscv/riscv_hart.c                         |   4 +-
 hw/riscv/shakti_c.c                           |   4 +-
 hw/riscv/sifive_e.c                           |   6 +-
 hw/riscv/sifive_u.c                           |   8 +-
 hw/riscv/spike.c                              |   6 +-
 hw/riscv/virt.c                               |  10 +-
 hw/riscv/xiangshan_kmh.c                      |   4 +-
 hw/rtc/allwinner-rtc.c                        |   4 +-
 hw/rtc/exynos4210_rtc.c                       |   6 +-
 hw/rtc/goldfish_rtc.c                         |   6 +-
 hw/rtc/ls7a_rtc.c                             |   8 +-
 hw/rtc/m48t59-isa.c                           |   2 +-
 hw/rtc/m48t59.c                               |   6 +-
 hw/rtc/mc146818rtc.c                          |   6 +-
 hw/rtc/pl031.c                                |   6 +-
 hw/rtc/rs5c372.c                              |   4 +-
 hw/rtc/sun4v-rtc.c                            |   2 +-
 hw/rtc/xlnx-zynqmp-rtc.c                      |   6 +-
 hw/rx/rx-gdbsim.c                             |   4 +-
 hw/rx/rx62n.c                                 |   6 +-
 hw/s390x/3270-ccw.c                           |   2 +-
 hw/s390x/ap-bridge.c                          |   2 +-
 hw/s390x/ccw-device.c                         |   2 +-
 hw/s390x/cpu-topology.c                       |   4 +-
 hw/s390x/css-bridge.c                         |   6 +-
 hw/s390x/css.c                                |   3 +-
 hw/s390x/ipl.c                                |   7 +-
 hw/s390x/s390-pci-bus.c                       |   5 +-
 hw/s390x/s390-pci-inst.c                      |   2 +-
 hw/s390x/s390-skeys.c                         |   2 +-
 hw/s390x/s390-stattrib.c                      |   2 +-
 hw/s390x/s390-virtio-ccw.c                    |   6 +-
 hw/s390x/sclp.c                               |   2 +-
 hw/s390x/vhost-scsi-ccw.c                     |   2 +-
 hw/s390x/vhost-user-fs-ccw.c                  |   2 +-
 hw/s390x/vhost-vsock-ccw.c                    |   2 +-
 hw/s390x/virtio-ccw-9p.c                      |   2 +-
 hw/s390x/virtio-ccw-balloon.c                 |   2 +-
 hw/s390x/virtio-ccw-blk.c                     |   2 +-
 hw/s390x/virtio-ccw-crypto.c                  |   2 +-
 hw/s390x/virtio-ccw-gpu.c                     |   2 +-
 hw/s390x/virtio-ccw-input.c                   |   2 +-
 hw/s390x/virtio-ccw-mem.c                     |   2 +-
 hw/s390x/virtio-ccw-net.c                     |   2 +-
 hw/s390x/virtio-ccw-rng.c                     |   2 +-
 hw/s390x/virtio-ccw-scsi.c                    |   2 +-
 hw/s390x/virtio-ccw-serial.c                  |   2 +-
 hw/s390x/virtio-ccw.c                         |   1 +
 hw/scsi/esp-pci.c                             |   2 +-
 hw/scsi/esp.c                                 |   4 +-
 hw/scsi/lasi_ncr710.c                         |   2 +-
 hw/scsi/lsi53c895a.c                          |   2 +-
 hw/scsi/megasas.c                             |   2 +-
 hw/scsi/mptsas.c                              |   2 +-
 hw/scsi/ncr53c710.c                           |   4 +-
 hw/scsi/scsi-bus.c                            |   2 +-
 hw/scsi/scsi-disk.c                           |   4 +-
 hw/scsi/scsi-generic.c                        |   4 +-
 hw/scsi/spapr_vscsi.c                         |   2 +-
 hw/scsi/vhost-scsi-common.c                   |   2 +-
 hw/scsi/vhost-scsi.c                          |   4 +-
 hw/scsi/vhost-user-scsi.c                     |   8 +-
 hw/scsi/virtio-scsi.c                         |   2 +-
 hw/scsi/vmw_pvscsi.c                          |   3 +-
 hw/sd/allwinner-sdhost.c                      |   4 +-
 hw/sd/aspeed_sdhci.c                          |   4 +-
 hw/sd/bcm2835_sdhost.c                        |   2 +-
 hw/sd/core.c                                  |   2 +-
 hw/sd/omap_mmc.c                              |   4 +-
 hw/sd/pl181.c                                 |   4 +-
 hw/sd/sd.c                                    |   8 +-
 hw/sd/sdhci-pci.c                             |   4 +-
 hw/sd/sdhci.c                                 |   4 +-
 hw/sd/ssi-sd.c                                |   2 +-
 hw/sensor/adm1266.c                           |   2 +-
 hw/sensor/adm1272.c                           |   2 +-
 hw/sensor/isl_pmbus_vr.c                      |   2 +-
 hw/sensor/max31785.c                          |   2 +-
 hw/sensor/max34451.c                          |   2 +-
 hw/sensor/tmp105.c                            |   4 +-
 hw/sh4/r2d.c                                  |  12 +-
 hw/sh4/sh7750.c                               |   8 +-
 hw/smbios/smbios.c                            |   4 +-
 hw/sparc/leon3.c                              |  11 +-
 hw/sparc/sun4m.c                              |  12 +-
 hw/sparc/sun4m_iommu.c                        |   6 +-
 hw/sparc64/niagara.c                          |   4 +-
 hw/sparc64/sparc64.c                          |   2 +-
 hw/sparc64/sun4u.c                            |  12 +-
 hw/sparc64/sun4u_iommu.c                      |   2 +-
 hw/ssi/allwinner-a10-spi.c                    |   2 +-
 hw/ssi/aspeed_smc.c                           |   6 +-
 hw/ssi/bcm2835_spi.c                          |   2 +-
 hw/ssi/ibex_spi_host.c                        |   8 +-
 hw/ssi/imx_spi.c                              |   2 +-
 hw/ssi/mss-spi.c                              |   2 +-
 hw/ssi/npcm7xx_fiu.c                          |   4 +-
 hw/ssi/npcm_pspi.c                            |   4 +-
 hw/ssi/pl022.c                                |   4 +-
 hw/ssi/pnv_spi.c                              |   4 +-
 hw/ssi/sifive_spi.c                           |   6 +-
 hw/ssi/ssi.c                                  |   2 +-
 hw/ssi/xilinx_spi.c                           |   8 +-
 hw/ssi/xilinx_spips.c                         |  10 +-
 hw/ssi/xlnx-versal-ospi.c                     |   6 +-
 hw/timer/a9gtimer.c                           |   6 +-
 hw/timer/allwinner-a10-pit.c                  |   6 +-
 hw/timer/arm_mptimer.c                        |   8 +-
 hw/timer/arm_timer.c                          |   8 +-
 hw/timer/armv7m_systick.c                     |   6 +-
 hw/timer/aspeed_timer.c                       |   6 +-
 hw/timer/avr_timer16.c                        |   4 +-
 hw/timer/bcm2835_systmr.c                     |   2 +-
 hw/timer/cadence_ttc.c                        |   4 +-
 hw/timer/cmsdk-apb-dualtimer.c                |  10 +-
 hw/timer/cmsdk-apb-timer.c                    |   8 +-
 hw/timer/digic-timer.c                        |   4 +-
 hw/timer/exynos4210_mct.c                     |   6 +-
 hw/timer/exynos4210_pwm.c                     |   6 +-
 hw/timer/grlib_gptimer.c                      |   8 +-
 hw/timer/hpet.c                               |   6 +-
 hw/timer/i8254.c                              |   2 +-
 hw/timer/ibex_timer.c                         |   4 +-
 hw/timer/imx_epit.c                           |   2 +-
 hw/timer/imx_gpt.c                            |   2 +-
 hw/timer/mss-timer.c                          |   4 +-
 hw/timer/npcm7xx_timer.c                      |   6 +-
 hw/timer/nrf51_timer.c                        |   4 +-
 hw/timer/pxa2xx_timer.c                       |   6 +-
 hw/timer/renesas_cmt.c                        |   6 +-
 hw/timer/renesas_tmr.c                        |   6 +-
 hw/timer/sh_timer.c                           |   4 +-
 hw/timer/sifive_pwm.c                         |   6 +-
 hw/timer/slavio_timer.c                       |   8 +-
 hw/timer/sse-counter.c                        |   8 +-
 hw/timer/sse-timer.c                          |  12 +-
 hw/timer/stellaris-gptm.c                     |   2 +-
 hw/timer/stm32f2xx_timer.c                    |   4 +-
 hw/timer/xilinx_timer.c                       |  10 +-
 hw/tpm/tpm_crb.c                              |   2 +-
 hw/tpm/tpm_ppi.c                              |   2 +-
 hw/tpm/tpm_spapr.c                            |   2 +-
 hw/tpm/tpm_tis_common.c                       |   4 +-
 hw/tpm/tpm_tis_i2c.c                          |   2 +-
 hw/tpm/tpm_tis_isa.c                          |   2 +-
 hw/tpm/tpm_tis_sysbus.c                       |   4 +-
 hw/tricore/tc27x_soc.c                        |   4 +-
 hw/tricore/triboard.c                         |   4 +-
 hw/tricore/tricore_testboard.c                |   4 +-
 hw/tricore/tricore_testdevice.c               |   4 +-
 hw/uefi/ovmf-log.c                            |   2 +-
 hw/uefi/var-service-sysbus.c                  |   4 +-
 hw/ufs/ufs.c                                  |   2 +-
 hw/usb/bus-stub.c                             |   2 +-
 hw/usb/bus.c                                  |   4 +-
 hw/usb/canokey.c                              |   4 +-
 hw/usb/ccid-card-emulated.c                   |   2 +-
 hw/usb/ccid-card-passthru.c                   |   4 +-
 hw/usb/combined-packet.c                      |   2 +-
 hw/usb/core.c                                 |   2 +-
 hw/usb/desc-msos.c                            |   2 +-
 hw/usb/desc.c                                 |   2 +-
 hw/usb/dev-audio.c                            |   4 +-
 hw/usb/dev-hid.c                              |   4 +-
 hw/usb/dev-hub.c                              |   4 +-
 hw/usb/dev-mtp.c                              |   4 +-
 hw/usb/dev-network.c                          |   4 +-
 hw/usb/dev-serial.c                           |   6 +-
 hw/usb/dev-smartcard-reader.c                 |   4 +-
 hw/usb/dev-storage-bot.c                      |   2 +-
 hw/usb/dev-storage-classic.c                  |   2 +-
 hw/usb/dev-storage.c                          |   4 +-
 hw/usb/dev-uas.c                              |   4 +-
 hw/usb/dev-wacom.c                            |   2 +-
 hw/usb/hcd-dwc2.c                             |   2 +-
 hw/usb/hcd-dwc3.c                             |   6 +-
 hw/usb/hcd-ehci-pci.c                         |   2 +-
 hw/usb/hcd-ehci-sysbus.c                      |   2 +-
 hw/usb/hcd-ehci.c                             |   2 +-
 hw/usb/hcd-ohci-pci.c                         |   8 +-
 hw/usb/hcd-ohci-sysbus.c                      |  10 +-
 hw/usb/hcd-ohci.c                             |  10 +-
 hw/usb/hcd-uhci.c                             |   6 +-
 hw/usb/hcd-xhci-nec.c                         |   4 +-
 hw/usb/hcd-xhci-pci.c                         |   2 +-
 hw/usb/hcd-xhci-sysbus.c                      |   4 +-
 hw/usb/hcd-xhci.c                             |   2 +-
 hw/usb/host-libusb.c                          |   4 +-
 hw/usb/libhw.c                                |   2 +-
 hw/usb/pcap.c                                 |   2 +-
 hw/usb/quirks.c                               |   2 +-
 hw/usb/redirect.c                             |   6 +-
 hw/usb/u2f-emulated.c                         |   4 +-
 hw/usb/u2f-passthru.c                         |   4 +-
 hw/usb/u2f.c                                  |   2 +-
 hw/usb/vt82c686-uhci-pci.c                    |   2 +-
 hw/usb/xen-usb.c                              |   2 +-
 hw/usb/xlnx-usb-subsystem.c                   |   6 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c           |   6 +-
 hw/vfio-user/container.c                      |   1 +
 hw/vfio-user/pci.c                            |   2 +-
 hw/vfio/ap.c                                  |   2 +-
 hw/vfio/ccw.c                                 |   2 +-
 hw/vfio/container.c                           |   2 +-
 hw/vfio/device.c                              |   2 +-
 hw/vfio/helpers.c                             |   3 +-
 hw/vfio/igd.c                                 |   4 +-
 hw/vfio/iommufd.c                             |   2 +-
 hw/vfio/listener.c                            |   2 +-
 hw/vfio/migration.c                           |   4 +-
 hw/vfio/pci-quirks.c                          |   2 +-
 hw/vfio/pci.c                                 |   6 +-
 hw/vfio/region.c                              |   2 +-
 hw/vfio/spapr.c                               |   2 +-
 hw/virtio/vdpa-dev-pci.c                      |   2 +-
 hw/virtio/vdpa-dev.c                          |   6 +-
 hw/virtio/vhost-scsi-pci.c                    |   2 +-
 hw/virtio/vhost-user-base.c                   |   2 +-
 hw/virtio/vhost-user-blk-pci.c                |   2 +-
 hw/virtio/vhost-user-fs-pci.c                 |   2 +-
 hw/virtio/vhost-user-fs.c                     |   4 +-
 hw/virtio/vhost-user-gpio-pci.c               |   2 +-
 hw/virtio/vhost-user-gpio.c                   |   2 +-
 hw/virtio/vhost-user-i2c-pci.c                |   2 +-
 hw/virtio/vhost-user-i2c.c                    |   2 +-
 hw/virtio/vhost-user-rng-pci.c                |   2 +-
 hw/virtio/vhost-user-rng.c                    |   2 +-
 hw/virtio/vhost-user-scmi-pci.c               |   2 +-
 hw/virtio/vhost-user-scsi-pci.c               |   4 +-
 hw/virtio/vhost-user-snd-pci.c                |   2 +-
 hw/virtio/vhost-user-snd.c                    |   2 +-
 hw/virtio/vhost-user-test-device-pci.c        |   2 +-
 hw/virtio/vhost-user-test-device.c            |   2 +-
 hw/virtio/vhost-user-vsock-pci.c              |   2 +-
 hw/virtio/vhost-user-vsock.c                  |   4 +-
 hw/virtio/vhost-vsock-common.c                |   2 +-
 hw/virtio/vhost-vsock-pci.c                   |   2 +-
 hw/virtio/vhost-vsock.c                       |   2 +-
 hw/virtio/vhost.c                             |   1 +
 hw/virtio/virtio-9p-pci.c                     |   2 +-
 hw/virtio/virtio-balloon-pci.c                |   2 +-
 hw/virtio/virtio-balloon.c                    |   4 +-
 hw/virtio/virtio-blk-pci.c                    |   2 +-
 hw/virtio/virtio-crypto-pci.c                 |   2 +-
 hw/virtio/virtio-crypto.c                     |   2 +-
 hw/virtio/virtio-input-pci.c                  |   2 +-
 hw/virtio/virtio-iommu-pci.c                  |   6 +-
 hw/virtio/virtio-iommu.c                      |   2 +-
 hw/virtio/virtio-mem.c                        |   4 +-
 hw/virtio/virtio-mmio.c                       |   6 +-
 hw/virtio/virtio-net-pci.c                    |   2 +-
 hw/virtio/virtio-nsm-pci.c                    |   2 +-
 hw/virtio/virtio-pci.c                        |   6 +-
 hw/virtio/virtio-pmem.c                       |   2 +-
 hw/virtio/virtio-rng-pci.c                    |   2 +-
 hw/virtio/virtio-rng.c                        |   2 +-
 hw/virtio/virtio-scsi-pci.c                   |   2 +-
 hw/virtio/virtio-serial-pci.c                 |   2 +-
 hw/virtio/virtio.c                            |   2 +-
 hw/vmapple/aes.c                              |   4 +-
 hw/vmapple/bdif.c                             |   2 +-
 hw/vmapple/cfg.c                              |   2 +-
 hw/vmapple/vmapple.c                          |  12 +-
 hw/watchdog/allwinner-wdt.c                   |   4 +-
 hw/watchdog/cmsdk-apb-watchdog.c              |  10 +-
 hw/watchdog/sbsa_gwdt.c                       |   2 +-
 hw/watchdog/watchdog.c                        |   2 +-
 hw/watchdog/wdt_aspeed.c                      |   4 +-
 hw/watchdog/wdt_imx2.c                        |   2 +-
 hw/xen/xen-bus.c                              |   4 +-
 hw/xen/xen-hvm-common.c                       |   4 +-
 hw/xen/xen-legacy-backend.c                   |   6 +-
 hw/xen/xen-mapcache.c                         |   1 +
 hw/xen/xen-pvh-common.c                       |   4 +-
 hw/xen/xen_pt.c                               |   4 +-
 hw/xen/xen_pt_graphics.c                      |   1 +
 hw/xen/xen_pt_load_rom.c                      |   2 +-
 hw/xen/xen_pvdev.c                            |   2 +-
 hw/xenpv/xen_machine_pv.c                     |   2 +-
 hw/xtensa/mx_pic.c                            |   2 +-
 hw/xtensa/pic_cpu.c                           |   2 +-
 hw/xtensa/sim.c                               |   4 +-
 hw/xtensa/virt.c                              |   4 +-
 hw/xtensa/xtfpga.c                            |   9 +-
 migration/migration.c                         |   2 +-
 migration/postcopy-ram.c                      |   2 +-
 migration/ram.c                               |   4 +-
 migration/savevm.c                            |   2 +-
 monitor/hmp.c                                 |   2 +-
 monitor/qemu-config-qmp.c                     |   2 +-
 net/net.c                                     |   2 +-
 plugins/api-system.c                          |   2 +-
 plugins/system.c                              |   2 +-
 qom/object.c                                  |   2 +-
 qom/qom-hmp-cmds.c                            |   2 +-
 qom/qom-qmp-cmds.c                            |   2 +-
 semihosting/arm-compat-semi.c                 |   4 +-
 stubs/hotplug-stubs.c                         |   2 +-
 stubs/physmem.c                               |   2 +-
 stubs/ram-block.c                             |   4 +-
 stubs/sysbus.c                                |   2 +-
 system/bootdevice.c                           |   4 +-
 system/cpus.c                                 |   6 +-
 system/device_tree.c                          |   4 +-
 system/dirtylimit.c                           |   2 +-
 system/globals.c                              |   2 +-
 system/ioport.c                               |   1 +
 system/memory.c                               |   4 +-
 system/physmem.c                              |   8 +-
 system/qdev-monitor.c                         |   8 +-
 system/qtest.c                                |   4 +-
 system/runstate.c                             |   4 +-
 system/vl.c                                   |   6 +-
 target-info-stub.c                            |   2 +-
 target/arm/arm-qmp-cmds.c                     |   2 +-
 target/arm/cpregs-gcs.c                       |   2 +-
 target/arm/cpregs-pmu.c                       |   2 +-
 target/arm/cpu.c                              |   6 +-
 target/arm/cpu64.c                            |   2 +-
 target/arm/helper.c                           |   2 +-
 target/arm/hvf/hvf.c                          |   4 +-
 target/arm/kvm.c                              |   5 +-
 target/arm/tcg/cpu32.c                        |   2 +-
 target/arm/tcg/cpu64.c                        |   2 +-
 target/avr/cpu.c                              |   2 +-
 target/hexagon/cpu.c                          |   2 +-
 target/i386/cpu-apic.c                        |   2 +-
 target/i386/cpu.c                             |   4 +-
 target/i386/hvf/hvf-cpu.c                     |   2 +-
 target/i386/kvm/kvm-cpu.c                     |   2 +-
 target/i386/kvm/kvm.c                         |   1 +
 target/i386/kvm/vmsr_energy.c                 |   2 +-
 target/i386/sev.c                             |   1 +
 target/i386/tcg/system/fpu_helper.c           |   2 +-
 target/i386/whpx/whpx-all.c                   |   2 +-
 target/loongarch/cpu.c                        |   2 +-
 target/loongarch/kvm/kvm.c                    |   6 +-
 target/loongarch/tcg/csr_helper.c             |   2 +-
 target/m68k/m68k-semi.c                       |   2 +-
 target/microblaze/cpu.c                       |   2 +-
 target/mips/cpu.c                             |   4 +-
 target/mips/kvm.c                             |   2 +-
 target/mips/system/cp0_timer.c                |   2 +-
 target/openrisc/interrupt.c                   |   2 +-
 target/openrisc/mmu.c                         |   2 +-
 target/openrisc/sys_helper.c                  |   2 +-
 target/ppc/cpu_init.c                         |   4 +-
 target/ppc/kvm.c                              |   4 +-
 target/ppc/mmu-hash64.c                       |   2 +-
 target/riscv/cpu.c                            |   2 +-
 target/riscv/kvm/kvm-cpu.c                    |   6 +-
 target/riscv/tcg/tcg-cpu.c                    |   2 +-
 target/rx/cpu.c                               |   2 +-
 target/rx/helper.c                            |   2 +-
 target/s390x/cpu-system.c                     |   2 +-
 target/s390x/cpu.c                            |   6 +-
 target/s390x/kvm/kvm.c                        |   2 +-
 target/s390x/mmu_helper.c                     |   4 +-
 target/s390x/sigp.c                           |   2 +-
 target/s390x/tcg/excp_helper.c                |   2 +-
 target/s390x/tcg/mem_helper.c                 |   2 +-
 target/s390x/tcg/misc_helper.c                |   2 +-
 target/sparc/cpu.c                            |   2 +-
 target/tricore/helper.c                       |   2 +-
 target/xtensa/cpu.c                           |   2 +-
 tests/qtest/fuzz/generic_fuzz.c               |   4 +-
 tests/qtest/sdhci-test.c                      |   2 +-
 tests/qtest/sifive-e-aon-watchdog-test.c      |   2 +-
 tests/qtest/stm32l4x5_rcc-test.c              |   2 +-
 tests/qtest/stm32l4x5_usart-test.c            |   2 +-
 tests/unit/ptimer-test.c                      |   2 +-
 tests/unit/test-qdev-global-props.c           |   2 +-
 tests/unit/test-smp-parse.c                   |   2 +-
 ui/console.c                                  |   2 +-
 ui/vdagent.c                                  |   2 +-
 ui/vnc.c                                      |   2 +-
 util/vfio-helpers.c                           |   2 +-
 hw/display/apple-gfx-mmio.m                   |   4 +-
 scripts/analyze-inclusions                    |  10 +-
 scripts/compare-machine-types.py              |   2 +-
 1672 files changed, 3100 insertions(+), 3034 deletions(-)
 rename include/hw/{ => core}/boards.h (99%)
 rename include/hw/{ => core}/clock.h (100%)
 rename include/hw/{ => core}/fw-path-provider.h (100%)
 rename include/hw/{ => core}/hotplug.h (100%)
 rename include/hw/{hw.h => core/hw-error.h} (100%)
 rename include/hw/{ => core}/irq.h (98%)
 rename include/hw/{ => core}/loader-fit.h (100%)
 rename include/hw/{ => core}/loader.h (100%)
 rename include/hw/{ => core}/nmi.h (100%)
 rename include/hw/{ => core}/or-irq.h (98%)
 rename include/hw/{ => core}/platform-bus.h (98%)
 rename include/hw/{ => core}/ptimer.h (100%)
 rename include/hw/{ => core}/qdev-clock.h (99%)
 rename include/hw/{ => core}/qdev-dma.h (100%)
 rename include/hw/{ => core}/qdev-properties-system.h (98%)
 rename include/hw/{ => core}/qdev-properties.h (99%)
 rename include/hw/{qdev-core.h => core/qdev.h} (99%)
 rename include/hw/{ => core}/register.h (99%)
 rename include/hw/{ => core}/registerfields.h (100%)
 rename include/hw/{ => core}/resettable.h (100%)
 rename include/hw/{ => core}/stream.h (100%)
 rename include/hw/{ => core}/sysbus.h (99%)
 rename include/hw/{ => core}/vmstate-if.h (100%)
 rename include/hw/{ => usb}/usb.h (99%)
 rename include/{exec => system}/ramlist.h (94%)
 rename include/{exec => system}/memory_ldst.h.inc (100%)
 rename include/{exec => system}/memory_ldst_cached.h.inc (100%)
 rename include/{exec => system}/memory_ldst_phys.h.inc (100%)

-- 
2.51.1


