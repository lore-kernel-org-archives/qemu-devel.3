Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2F8D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqd-0002cu-8H; Thu, 27 Nov 2025 08:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqY-0002a9-BD
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqT-0001DI-3R
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8xE7C50uep1HO0OGrq08ca9egkIaGRyDMovXvqDJDg=;
 b=Y+qabNWW9N5EeZ4kNwQsW+IZCXbdwoeF0WawZm+NKwahUb/99f5AHuPOSUuS0G1HLpNbLX
 RaTKIJOaQ0E+ecTcq3rQeAph+mEC7UcfD4Cpe4Nf6L9eIGRn1TNRL3w7SIMEo6xrz2AEm2
 5f92M2Xbb8NJ81+uYUPRZG7l0GW7tYM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-2Y5JlkvFNEShsO2U51CHBw-1; Thu, 27 Nov 2025 08:15:33 -0500
X-MC-Unique: 2Y5JlkvFNEShsO2U51CHBw-1
X-Mimecast-MFC-AGG-ID: 2Y5JlkvFNEShsO2U51CHBw_1764249332
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b71043a0e4fso81253166b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249331; x=1764854131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K8xE7C50uep1HO0OGrq08ca9egkIaGRyDMovXvqDJDg=;
 b=BaGkEjVGZ9xNUK1T/Xxp6Br8PniF8IYxy7DW3DJhLUtc62CH7iy9RB3XD6fJ0zp3VS
 JkpRxdeBzYqOtPj5IEn/yziBjOmQV8NIlf9eMForlQS9wEV6m4z8ABEcKj1vkZDXeI0N
 7AfRqceMJnUQEEYVZcqUCNGFGqCiaIZY+HdeNbcD8AFn36wPOHawJaJ6usZQB++biUhm
 Kt9I63/0ApKYbLqLdjF9oxJZf4QPw0FhgKp8WyWvq97RD6QW9+YgoX25fKVZRPOA8t6I
 Ex09qVcy2WFHshUyZPPVzhacQQMjFp8qhBEIyJIJhbS/SX6Nvd/N5jyJtg/I2WqGi9wz
 +FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249331; x=1764854131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K8xE7C50uep1HO0OGrq08ca9egkIaGRyDMovXvqDJDg=;
 b=dA2YnymUDI4qjxRAnfhZ+Ll7dgZu75LTDYV5/oGqclI3cLYSpTNiDhAjEimBRGHfov
 HPnVa9l0N8U8vq140gXao29qXPM/j9Wt6IkUObweON10OK49hPIpsAhDNG2VMYMf4NMy
 VO0Rhonvx3ifgFdtjpfsWd1eoHgxhjXtmWGNuyCm2k+40ODS98yk5hv/nXcV+sof4EHy
 3zblErQsP+qmjPtPu9zI5pQPpnNMYXWOd//W6H6WFar1B/yCCJExgfnrEzNbhfIumuF1
 O4tu2lZ+pdSkk5XONdb+hFEGSi2GGFT2zO+SZ8jkI6aBhxEo6ImzkK2cvHFd8v4NHGzC
 Ryqw==
X-Gm-Message-State: AOJu0YwagtvjVqF0NZVdrkKVQb3gbdf+iQW4yhzUuhj0WQbpOstu1py/
 j41KL6JjtQa0+QAjr7J8/EP1CN9fXI03AfP2fvT95d5fgQrJ/BDBIRJeakB/XrjXcVj9o2Or67V
 CVhVUPM80OSsa9c9OEK3i0qGa9pFBSVwZpukuWjgbJr79xreH00wc9ByGwOyzMrY94ZhSvxvQLp
 3uCzAUH0u8n9nfZLCDH8qxm1Sxe2ZR1kP5dFtTUHws
X-Gm-Gg: ASbGncutzdfS/vvB9ycn64KLFX2hFiIRcudDEwJDhUBFryrfmYzghL6eaHx9u+s5uvl
 OpUH4IrfS1xSP02RxQH4F1H0iE2ajCm1ZA9HGaDIljZUcoTlqEN5yz1O0J0HQflDFMSfDdDNsUo
 SQ6xUv2q0Ag7i+aS736THzV2Pp3LVFukXIhU4VGspTltz+j36fYaC/UqcC9b7w8UR/WGDCkqkIi
 D459kxkNniLS/vRMHgLJbTUNb7KTkt18HgE9nUVgdhrUllYgFaKd9gTE3ih0GlN8PHN7uhFdJYs
 5hUgB4aKXoHYeV9dym50MM6bvziSRLfho7dEwbgiliapUIvyMiFLJA9QVx3uuHhdyhAMqMaJpV6
 4mgv8dl/r2fL1UOCUKq7Qyh3FaWoEtFgs2HsTBAly/DU7KnOrO91ovJwY1YNriQ8TNXO1wWJ6Im
 rhgHfQEi6S3CUJbMY=
X-Received: by 2002:a17:907:60cd:b0:b73:5f5e:574d with SMTP id
 a640c23a62f3a-b76718ab1e0mr2378573366b.59.1764249329640; 
 Thu, 27 Nov 2025 05:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYkGbY3iGyikUWFXAEc6wDE2OeFjkk9+tMqBUVV5duW8cRLtDx60WxKeuMUO74wUBn50Ro/g==
X-Received: by 2002:a17:907:60cd:b0:b73:5f5e:574d with SMTP id
 a640c23a62f3a-b76718ab1e0mr2378555066b.59.1764249326816; 
 Thu, 27 Nov 2025 05:15:26 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59a6a67sm156665766b.34.2025.11.27.05.15.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/28] include: move hw/boards.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:52 +0100
Message-ID: <20251127131516.80807-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                              | 2 +-
 docs/conf.py                             | 2 +-
 hw/alpha/alpha_sys.h                     | 2 +-
 hw/avr/boot.h                            | 2 +-
 hw/i386/acpi-common.h                    | 2 +-
 hw/i386/fw_cfg.h                         | 2 +-
 hw/loongarch/fw_cfg.h                    | 2 +-
 hw/mips/fw_cfg.h                         | 2 +-
 hw/ppc/e500.h                            | 2 +-
 include/hw/acpi/cpu.h                    | 2 +-
 include/hw/arm/aspeed.h                  | 2 +-
 include/hw/arm/machines-qom.h            | 2 +-
 include/hw/arm/npcm7xx.h                 | 2 +-
 include/hw/arm/raspi_platform.h          | 2 +-
 include/hw/arm/virt.h                    | 2 +-
 include/hw/{ => core}/boards.h           | 0
 include/hw/cxl/cxl_host.h                | 2 +-
 include/hw/i386/microvm.h                | 2 +-
 include/hw/i386/pc.h                     | 2 +-
 include/hw/i386/x86.h                    | 2 +-
 include/hw/loongarch/virt.h              | 2 +-
 include/hw/m68k/q800.h                   | 2 +-
 include/hw/misc/lasi.h                   | 2 +-
 include/hw/openrisc/boot.h               | 2 +-
 include/hw/ppc/pnv.h                     | 2 +-
 include/hw/ppc/spapr.h                   | 2 +-
 include/hw/ppc/spapr_numa.h              | 2 +-
 include/hw/remote/machine.h              | 2 +-
 include/hw/riscv/microchip_pfsoc.h       | 2 +-
 include/hw/riscv/numa.h                  | 2 +-
 include/hw/riscv/opentitan.h             | 2 +-
 include/hw/riscv/shakti_c.h              | 2 +-
 include/hw/riscv/sifive_e.h              | 2 +-
 include/hw/riscv/sifive_u.h              | 2 +-
 include/hw/riscv/spike.h                 | 2 +-
 include/hw/riscv/virt.h                  | 2 +-
 include/hw/riscv/xiangshan_kmh.h         | 2 +-
 include/hw/s390x/cpu-topology.h          | 2 +-
 include/hw/s390x/s390-virtio-ccw.h       | 2 +-
 include/hw/tricore/triboard.h            | 2 +-
 include/hw/xen/xen-pvh-common.h          | 2 +-
 include/system/kvm_int.h                 | 2 +-
 accel/accel-system.c                     | 2 +-
 accel/hvf/hvf-all.c                      | 2 +-
 accel/kvm/kvm-all.c                      | 2 +-
 accel/mshv/mshv-all.c                    | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c          | 2 +-
 accel/tcg/tcg-all.c                      | 2 +-
 accel/xen/xen-all.c                      | 2 +-
 backends/hostmem.c                       | 2 +-
 block/monitor/block-hmp-cmds.c           | 2 +-
 gdbstub/gdbstub.c                        | 2 +-
 gdbstub/system.c                         | 2 +-
 hw/acpi/aml-build.c                      | 2 +-
 hw/acpi/memory_hotplug.c                 | 2 +-
 hw/acpi/pci.c                            | 2 +-
 hw/arm/allwinner-a10.c                   | 2 +-
 hw/arm/allwinner-r40.c                   | 2 +-
 hw/arm/aspeed_ast27x0-fc.c               | 2 +-
 hw/arm/b-l475e-iot01a.c                  | 2 +-
 hw/arm/bananapi_m2u.c                    | 2 +-
 hw/arm/boot.c                            | 2 +-
 hw/arm/collie.c                          | 2 +-
 hw/arm/cubieboard.c                      | 2 +-
 hw/arm/digic_boards.c                    | 2 +-
 hw/arm/exynos4_boards.c                  | 2 +-
 hw/arm/fby35.c                           | 2 +-
 hw/arm/fsl-imx6.c                        | 2 +-
 hw/arm/fsl-imx6ul.c                      | 2 +-
 hw/arm/fsl-imx7.c                        | 2 +-
 hw/arm/fsl-imx8mp.c                      | 2 +-
 hw/arm/highbank.c                        | 2 +-
 hw/arm/imx25_pdk.c                       | 2 +-
 hw/arm/imx8mp-evk.c                      | 2 +-
 hw/arm/integratorcp.c                    | 2 +-
 hw/arm/kzm.c                             | 2 +-
 hw/arm/max78000fthr.c                    | 2 +-
 hw/arm/mcimx6ul-evk.c                    | 2 +-
 hw/arm/mcimx7d-sabre.c                   | 2 +-
 hw/arm/microbit.c                        | 2 +-
 hw/arm/mps2-tz.c                         | 2 +-
 hw/arm/mps2.c                            | 2 +-
 hw/arm/mps3r.c                           | 2 +-
 hw/arm/msf2-som.c                        | 2 +-
 hw/arm/musca.c                           | 2 +-
 hw/arm/musicpal.c                        | 2 +-
 hw/arm/netduino2.c                       | 2 +-
 hw/arm/netduinoplus2.c                   | 2 +-
 hw/arm/npcm8xx.c                         | 2 +-
 hw/arm/npcm8xx_boards.c                  | 2 +-
 hw/arm/olimex-stm32-h405.c               | 2 +-
 hw/arm/omap_sx1.c                        | 2 +-
 hw/arm/orangepi.c                        | 2 +-
 hw/arm/raspi.c                           | 2 +-
 hw/arm/raspi4b.c                         | 2 +-
 hw/arm/realview.c                        | 2 +-
 hw/arm/sabrelite.c                       | 2 +-
 hw/arm/sbsa-ref.c                        | 2 +-
 hw/arm/stellaris.c                       | 2 +-
 hw/arm/stm32vldiscovery.c                | 2 +-
 hw/arm/versatilepb.c                     | 2 +-
 hw/arm/vexpress.c                        | 2 +-
 hw/arm/xen-pvh.c                         | 2 +-
 hw/arm/xilinx_zynq.c                     | 2 +-
 hw/arm/xlnx-versal-virt.c                | 2 +-
 hw/arm/xlnx-zcu102.c                     | 2 +-
 hw/arm/xlnx-zynqmp.c                     | 2 +-
 hw/core/cpu-common.c                     | 2 +-
 hw/core/generic-loader.c                 | 2 +-
 hw/core/guest-loader.c                   | 2 +-
 hw/core/loader.c                         | 2 +-
 hw/core/machine-hmp-cmds.c               | 2 +-
 hw/core/machine-qmp-cmds.c               | 2 +-
 hw/core/machine-smp.c                    | 2 +-
 hw/core/machine.c                        | 2 +-
 hw/core/null-machine.c                   | 2 +-
 hw/core/numa.c                           | 2 +-
 hw/core/qdev-hotplug.c                   | 2 +-
 hw/core/qdev.c                           | 2 +-
 hw/cpu/core.c                            | 2 +-
 hw/cxl/cxl-host.c                        | 2 +-
 hw/hyperv/hv-balloon.c                   | 2 +-
 hw/i2c/pm_smbus.c                        | 2 +-
 hw/i2c/smbus_eeprom.c                    | 2 +-
 hw/i386/vapic.c                          | 2 +-
 hw/i386/vmport.c                         | 2 +-
 hw/i386/xen/xen-pvh.c                    | 2 +-
 hw/intc/apic_common.c                    | 2 +-
 hw/intc/loongarch_ipi.c                  | 2 +-
 hw/intc/loongarch_pic_kvm.c              | 2 +-
 hw/intc/riscv_aplic.c                    | 2 +-
 hw/intc/riscv_imsic.c                    | 2 +-
 hw/loongarch/virt.c                      | 2 +-
 hw/m68k/an5206.c                         | 2 +-
 hw/m68k/mcf5206.c                        | 2 +-
 hw/m68k/mcf5208.c                        | 2 +-
 hw/m68k/next-cube.c                      | 2 +-
 hw/m68k/q800-glue.c                      | 2 +-
 hw/m68k/q800.c                           | 2 +-
 hw/m68k/virt.c                           | 2 +-
 hw/mem/memory-device.c                   | 2 +-
 hw/mem/pc-dimm.c                         | 2 +-
 hw/microblaze/boot.c                     | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          | 2 +-
 hw/mips/boston.c                         | 2 +-
 hw/mips/fuloong2e.c                      | 2 +-
 hw/mips/jazz.c                           | 2 +-
 hw/mips/malta.c                          | 2 +-
 hw/nvram/fw_cfg.c                        | 2 +-
 hw/openrisc/openrisc_sim.c               | 2 +-
 hw/openrisc/virt.c                       | 2 +-
 hw/pci-bridge/pci_expander_bridge.c      | 2 +-
 hw/pci/pci.c                             | 2 +-
 hw/ppc/amigaone.c                        | 2 +-
 hw/ppc/mac_newworld.c                    | 2 +-
 hw/ppc/mac_oldworld.c                    | 2 +-
 hw/ppc/pegasos.c                         | 2 +-
 hw/ppc/ppc440_bamboo.c                   | 2 +-
 hw/ppc/ppe42_machine.c                   | 2 +-
 hw/ppc/prep.c                            | 2 +-
 hw/ppc/sam460ex.c                        | 2 +-
 hw/ppc/virtex_ml507.c                    | 2 +-
 hw/remote/vfio-user-obj.c                | 2 +-
 hw/riscv/boot.c                          | 2 +-
 hw/riscv/microblaze-v-generic.c          | 2 +-
 hw/riscv/microchip_pfsoc.c               | 2 +-
 hw/riscv/numa.c                          | 2 +-
 hw/riscv/opentitan.c                     | 2 +-
 hw/riscv/shakti_c.c                      | 2 +-
 hw/riscv/sifive_e.c                      | 2 +-
 hw/riscv/sifive_u.c                      | 2 +-
 hw/riscv/spike.c                         | 2 +-
 hw/riscv/virt.c                          | 2 +-
 hw/riscv/xiangshan_kmh.c                 | 2 +-
 hw/rx/rx-gdbsim.c                        | 2 +-
 hw/s390x/cpu-topology.c                  | 2 +-
 hw/s390x/ipl.c                           | 2 +-
 hw/s390x/s390-pci-bus.c                  | 2 +-
 hw/s390x/s390-pci-inst.c                 | 2 +-
 hw/s390x/s390-virtio-ccw.c               | 2 +-
 hw/s390x/sclp.c                          | 2 +-
 hw/sh4/r2d.c                             | 2 +-
 hw/smbios/smbios.c                       | 2 +-
 hw/sparc/leon3.c                         | 2 +-
 hw/sparc/sun4m.c                         | 2 +-
 hw/sparc64/niagara.c                     | 2 +-
 hw/sparc64/sparc64.c                     | 2 +-
 hw/sparc64/sun4u.c                       | 2 +-
 hw/tricore/tricore_testboard.c           | 2 +-
 hw/uefi/ovmf-log.c                       | 2 +-
 hw/vfio/igd.c                            | 2 +-
 hw/virtio/virtio-balloon.c               | 2 +-
 hw/virtio/virtio-iommu-pci.c             | 2 +-
 hw/virtio/virtio-mem.c                   | 2 +-
 hw/virtio/virtio-pci.c                   | 2 +-
 hw/vmapple/vmapple.c                     | 2 +-
 hw/xen/xen-hvm-common.c                  | 2 +-
 hw/xen/xen-legacy-backend.c              | 2 +-
 hw/xen/xen-pvh-common.c                  | 2 +-
 hw/xenpv/xen_machine_pv.c                | 2 +-
 hw/xtensa/sim.c                          | 2 +-
 hw/xtensa/virt.c                         | 2 +-
 hw/xtensa/xtfpga.c                       | 2 +-
 migration/migration.c                    | 2 +-
 migration/postcopy-ram.c                 | 2 +-
 migration/ram.c                          | 2 +-
 migration/savevm.c                       | 2 +-
 monitor/qemu-config-qmp.c                | 2 +-
 plugins/api-system.c                     | 2 +-
 plugins/system.c                         | 2 +-
 semihosting/arm-compat-semi.c            | 2 +-
 system/bootdevice.c                      | 2 +-
 system/cpus.c                            | 2 +-
 system/device_tree.c                     | 2 +-
 system/dirtylimit.c                      | 2 +-
 system/memory.c                          | 2 +-
 system/physmem.c                         | 2 +-
 system/qdev-monitor.c                    | 2 +-
 system/runstate.c                        | 2 +-
 target-info-stub.c                       | 2 +-
 target/arm/arm-qmp-cmds.c                | 2 +-
 target/arm/cpu.c                         | 2 +-
 target/arm/hvf/hvf.c                     | 2 +-
 target/arm/kvm.c                         | 2 +-
 target/arm/tcg/cpu32.c                   | 2 +-
 target/i386/cpu.c                        | 2 +-
 target/i386/hvf/hvf-cpu.c                | 2 +-
 target/i386/kvm/kvm-cpu.c                | 2 +-
 target/i386/kvm/vmsr_energy.c            | 2 +-
 target/i386/whpx/whpx-all.c              | 2 +-
 target/loongarch/kvm/kvm.c               | 2 +-
 target/m68k/m68k-semi.c                  | 2 +-
 target/mips/kvm.c                        | 2 +-
 target/openrisc/sys_helper.c             | 2 +-
 target/ppc/cpu_init.c                    | 2 +-
 target/riscv/kvm/kvm-cpu.c               | 2 +-
 target/riscv/tcg/tcg-cpu.c               | 2 +-
 target/s390x/cpu-system.c                | 2 +-
 target/s390x/mmu_helper.c                | 2 +-
 target/s390x/sigp.c                      | 2 +-
 target/s390x/tcg/excp_helper.c           | 2 +-
 target/s390x/tcg/mem_helper.c            | 2 +-
 target/s390x/tcg/misc_helper.c           | 2 +-
 tests/qtest/fuzz/generic_fuzz.c          | 2 +-
 tests/unit/test-smp-parse.c              | 2 +-
 scripts/compare-machine-types.py         | 2 +-
 248 files changed, 247 insertions(+), 247 deletions(-)
 rename include/hw/{ => core}/boards.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10f74e97fa4..4c3cfbc81a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1994,7 +1994,7 @@ F: hw/core/numa.c
 F: hw/cpu/cluster.c
 F: qapi/machine.json
 F: qapi/machine-common.json
-F: include/hw/boards.h
+F: include/hw/core/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
 F: include/system/numa.h
diff --git a/docs/conf.py b/docs/conf.py
index 0c9ec74097f..bc4e9622dc8 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -136,7 +136,7 @@
 
 # These thresholds must match the constants
 # MACHINE_VER_DELETION_MAJOR  & MACHINE_VER_DEPRECATION_MAJOR
-# defined in include/hw/boards.h and the introductory text in
+# defined in include/hw/core/boards.h and the introductory text in
 # docs/about/deprecated.rst
 ver_machine_deprecation_version = "%d.%d.0" % (major - 3, minor)
 ver_machine_deletion_version = "%d.%d.0" % (major - 6, minor)
diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index a303c584383..6e6691d116a 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -5,7 +5,7 @@
 
 #include "target/alpha/cpu-qom.h"
 #include "hw/pci/pci.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/intc/i8259.h"
 
 
diff --git a/hw/avr/boot.h b/hw/avr/boot.h
index 684d553322b..9eed2055591 100644
--- a/hw/avr/boot.h
+++ b/hw/avr/boot.h
@@ -11,7 +11,7 @@
 #ifndef HW_AVR_BOOT_H
 #define HW_AVR_BOOT_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "cpu.h"
 
 /**
diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
index e305aaac158..57ef024cd37 100644
--- a/hw/i386/acpi-common.h
+++ b/hw/i386/acpi-common.h
@@ -1,7 +1,7 @@
 #ifndef HW_I386_ACPI_COMMON_H
 #define HW_I386_ACPI_COMMON_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/i386/x86.h"
 
diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index e560fd7be82..e7e70ff2373 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -9,7 +9,7 @@
 #ifndef HW_I386_FW_CFG_H
 #define HW_I386_FW_CFG_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i386/pc.h"
 #include "hw/nvram/fw_cfg.h"
 
diff --git a/hw/loongarch/fw_cfg.h b/hw/loongarch/fw_cfg.h
index 27ee68286ed..809b06c545e 100644
--- a/hw/loongarch/fw_cfg.h
+++ b/hw/loongarch/fw_cfg.h
@@ -8,7 +8,7 @@
 #ifndef HW_LOONGARCH_FW_CFG_H
 #define HW_LOONGARCH_FW_CFG_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 
 FWCfgState *virt_fw_cfg_init(ram_addr_t ram_size, MachineState *ms);
diff --git a/hw/mips/fw_cfg.h b/hw/mips/fw_cfg.h
index e317d5b9a3e..8a42d98cdf5 100644
--- a/hw/mips/fw_cfg.h
+++ b/hw/mips/fw_cfg.h
@@ -9,7 +9,7 @@
 #ifndef HW_MIPS_FW_CFG_H
 #define HW_MIPS_FW_CFG_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 
 /* Data for BIOS to identify machine */
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 00f490519c2..cda539bda18 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -1,7 +1,7 @@
 #ifndef PPCE500_H
 #define PPCE500_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/platform-bus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274f..95dc58b5adb 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -16,7 +16,7 @@
 #include "hw/qdev-core.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/hotplug.h"
 
 #define ACPI_CPU_HOTPLUG_REG_LEN 12
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 714bbd326c4..a00238ed74a 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -9,7 +9,7 @@
 #ifndef ARM_ASPEED_H
 #define ARM_ASPEED_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qom/object.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 3f64d5eb024..3ed39384e59 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -9,7 +9,7 @@
 #ifndef HW_ARM_MACHINES_QOM_H
 #define HW_ARM_MACHINES_QOM_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 #define TYPE_TARGET_ARM_MACHINE \
         "target-info-arm-machine"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 56536565b74..eef7cc5332b 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_H
 #define NPCM7XX_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/adc/npcm7xx_adc.h"
 #include "hw/core/split-irq.h"
 #include "hw/cpu/a9mpcore.h"
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 7bc4807fa51..c52b9e298d5 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -28,7 +28,7 @@
 #ifndef HW_ARM_RASPI_PLATFORM_H
 #define HW_ARM_RASPI_PLATFORM_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/arm/boot.h"
 
 /* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c77a33f6df2..8694aaa4e2a 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -32,7 +32,7 @@
 
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/acpi/ghes.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
diff --git a/include/hw/boards.h b/include/hw/core/boards.h
similarity index 100%
rename from include/hw/boards.h
rename to include/hw/core/boards.h
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index cd3c368c86a..21619bb748a 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -8,7 +8,7 @@
  */
 
 #include "hw/cxl/cxl.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 #ifndef CXL_HOST_H
 #define CXL_HOST_H
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index e73d1e65de8..6b9a5065272 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -21,7 +21,7 @@
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i386/x86.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/pci-host/gpex.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e83157ab358..ade2da92bad 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -4,7 +4,7 @@
 #include "qemu/notify.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/uuid.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/block/fdc.h"
 #include "hw/block/flash.h"
 #include "hw/i386/x86.h"
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 8755cad50a3..0dffba95f9a 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -20,7 +20,7 @@
 #include "exec/hwaddr.h"
 #include "system/memory.h"
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i386/topology.h"
 #include "hw/intc/ioapic.h"
 #include "hw/isa/isa.h"
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 27b17558020..8a04dd83146 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -8,7 +8,7 @@
 #ifndef HW_LOONGARCH_H
 #define HW_LOONGARCH_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/queue.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 9caaed9692b..c92da2e2ac7 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -23,7 +23,7 @@
 #ifndef HW_Q800_H
 #define HW_Q800_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qom/object.h"
 #include "target/m68k/cpu-qom.h"
 #include "system/memory.h"
diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 0e95be1c32a..5e40c6aebdf 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -13,7 +13,7 @@
 #define LASI_H
 
 #include "system/address-spaces.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/sysbus.h"
 
 #define TYPE_LASI_CHIP "lasi-chip"
diff --git a/include/hw/openrisc/boot.h b/include/hw/openrisc/boot.h
index 9b4d88072c4..3c481bdea68 100644
--- a/include/hw/openrisc/boot.h
+++ b/include/hw/openrisc/boot.h
@@ -20,7 +20,7 @@
 #define OPENRISC_BOOT_H
 
 #include "exec/cpu-defs.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 hwaddr openrisc_load_kernel(ram_addr_t ram_size,
                             const char *kernel_filename,
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index cbdddfc73cd..a8c1968f281 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -21,7 +21,7 @@
 #define PPC_PNV_H
 
 #include "cpu.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/sysbus.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_pnor.h"
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 28cf2723d84..5476ac7ce7b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -3,7 +3,7 @@
 
 #include "qemu/units.h"
 #include "system/dma.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
index 7cb33674006..e07edf2ee67 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -13,7 +13,7 @@
 #ifndef HW_SPAPR_NUMA_H
 #define HW_SPAPR_NUMA_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/ppc/spapr.h"
 
 /*
diff --git a/include/hw/remote/machine.h b/include/hw/remote/machine.h
index ac32fda3875..748b69c6fc7 100644
--- a/include/hw/remote/machine.h
+++ b/include/hw/remote/machine.h
@@ -12,7 +12,7 @@
 #define REMOTE_MACHINE_H
 
 #include "qom/object.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci-host/remote.h"
 #include "io/channel.h"
 #include "hw/remote/iohub.h"
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 7ca9b976c10..a30b944afa9 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -22,7 +22,7 @@
 #ifndef HW_MICROCHIP_PFSOC_H
 #define HW_MICROCHIP_PFSOC_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/mchp_pfsoc_mmuart.h"
 #include "hw/cpu/cluster.h"
 #include "hw/dma/sifive_pdma.h"
diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
index 147f01619b9..2d9c41ba818 100644
--- a/include/hw/riscv/numa.h
+++ b/include/hw/riscv/numa.h
@@ -19,7 +19,7 @@
 #ifndef RISCV_NUMA_H
 #define RISCV_NUMA_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/sysbus.h"
 #include "system/numa.h"
 
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 609473d07b4..5b9016e1d89 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -24,7 +24,7 @@
 #include "hw/char/ibex_uart.h"
 #include "hw/timer/ibex_timer.h"
 #include "hw/ssi/ibex_spi_host.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qom/object.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
diff --git a/include/hw/riscv/shakti_c.h b/include/hw/riscv/shakti_c.h
index 539fe1156de..f90a3bca8df 100644
--- a/include/hw/riscv/shakti_c.h
+++ b/include/hw/riscv/shakti_c.h
@@ -20,7 +20,7 @@
 #define HW_SHAKTI_C_H
 
 #include "hw/riscv/riscv_hart.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/shakti_uart.h"
 
 #define TYPE_RISCV_SHAKTI_SOC "riscv.shakti.cclass.soc"
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 31180a680e6..4cf902ebc0d 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -23,7 +23,7 @@
 #include "hw/riscv/sifive_cpu.h"
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_e_aon.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
 #define RISCV_E_SOC(obj) \
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0696f859427..e4c9860d501 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,7 +19,7 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/cpu/cluster.h"
 #include "hw/dma/sifive_pdma.h"
 #include "hw/net/cadence_gem.h"
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 0c2a2237630..acd41e90583 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -19,7 +19,7 @@
 #ifndef HW_RISCV_SPIKE_H
 #define HW_RISCV_SPIKE_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7b4c2c8b7de..806b78cc639 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -19,7 +19,7 @@
 #ifndef HW_RISCV_VIRT_H
 #define HW_RISCV_VIRT_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
diff --git a/include/hw/riscv/xiangshan_kmh.h b/include/hw/riscv/xiangshan_kmh.h
index c5dc6b1a9a7..5a5af93dffd 100644
--- a/include/hw/riscv/xiangshan_kmh.h
+++ b/include/hw/riscv/xiangshan_kmh.h
@@ -10,7 +10,7 @@
 #ifndef HW_XIANGSHAN_KMH_H
 #define HW_XIANGSHAN_KMH_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define XIANGSHAN_KMH_MAX_CPUS 16
diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index d5e9aa43f8f..2d5a5fa3646 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -12,7 +12,7 @@
 #ifndef CONFIG_USER_ONLY
 
 #include "qemu/queue.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qapi/qapi-types-machine-s390x.h"
 
 #define S390_TOPOLOGY_CPU_IFL   0x03
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 526078a4e2b..f1f06119d6d 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -11,7 +11,7 @@
 #ifndef HW_S390X_S390_VIRTIO_CCW_H
 #define HW_S390X_S390_VIRTIO_CCW_H
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qom/object.h"
 #include "hw/s390x/sclp.h"
 
diff --git a/include/hw/tricore/triboard.h b/include/hw/tricore/triboard.h
index ca49a0c7520..c6be4dc3f34 100644
--- a/include/hw/tricore/triboard.h
+++ b/include/hw/tricore/triboard.h
@@ -19,7 +19,7 @@
  */
 
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index 5db83d88ecc..0ed07c56947 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -11,7 +11,7 @@
 
 #include "system/memory.h"
 #include "qom/object.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/xen/xen-hvm-common.h"
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 9247493b029..baeb166d393 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -15,7 +15,7 @@
 #include "qemu/queue.h"
 #include "system/kvm.h"
 #include "accel/accel-ops.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i386/topology.h"
 #include "io/channel-socket.h"
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 1e97c64fdca..150af05bf5b 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -27,7 +27,7 @@
 #include "qemu/accel.h"
 #include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/core/cpu.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e836..77f4e4e4f30 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -16,7 +16,7 @@
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "trace.h"
 
 bool hvf_allowed;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9254ae6546..4cb2ea6c84a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -53,7 +53,7 @@
 #include "system/dirtylimit.h"
 #include "qemu/range.h"
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/stats.h"
 
 /* This check must be after config-host.h is included */
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 80428d130d5..47c67ef8cc9 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -19,7 +19,7 @@
 #include "qemu/event_notifier.h"
 #include "qemu/module.h"
 #include "qemu/main-loop.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 #include "hw/hyperv/hvhdk.h"
 #include "hw/hyperv/hvhdk_mini.h"
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index cf1ee7ac258..89299829c3a 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -30,7 +30,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 18ea0c58b0b..8eb4a6b89e8 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -37,7 +37,7 @@
 #include "qemu/units.h"
 #include "qemu/target-info.h"
 #ifndef CONFIG_USER_ONLY
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "exec/tb-flush.h"
 #include "system/runstate.h"
 #endif
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 97377d67d1c..bb2d02cb221 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -26,7 +26,7 @@
 #include "system/runstate.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 bool xen_allowed;
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 35734d6f4d1..d5834916648 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "system/hostmem.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 3640d1f3dce..3391cee4d21 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -36,7 +36,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 #include "qapi/qapi-commands-block.h"
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index dd5fb5667cc..c362d56bcde 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -38,7 +38,7 @@
 #include "gdbstub/user.h"
 #else
 #include "hw/cpu/cluster.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #endif
 #include "hw/core/cpu.h"
 
diff --git a/gdbstub/system.c b/gdbstub/system.c
index e2220c1ae48..79f80256e3a 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -25,7 +25,7 @@
 #include "system/replay.h"
 #include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2d5826a8f13..dad4cfcc7d8 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -25,7 +25,7 @@
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "system/numa.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 9b974b7274a..2f17d45907d 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/mem/pc-dimm.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-core.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 2228f1245e2..8c7ed104796 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index dc910d4177b..1886df03839 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -24,7 +24,7 @@
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/loader.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index c8eda39957c..313bd21fad8 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-core.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index b96ef3f97ab..a0cbe50d78d 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -15,7 +15,7 @@
 #include "system/block-backend.h"
 #include "system/system.h"
 #include "hw/arm/aspeed.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/loader.h"
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index f1fbc774e52..a724b5fdb20 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 0f6d98684b9..fd347e18d26 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -22,7 +22,7 @@
 #include "system/address-spaces.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index b91660208f5..9b6eaf642e9 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -22,7 +22,7 @@
 #include "system/system.h"
 #include "system/memory.h"
 #include "system/numa.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/reset.h"
 #include "hw/loader.h"
 #include "hw/mem/memory-device.h"
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 5a80b7a2238..73c40bc57da 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -12,7 +12,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "hw/sysbus.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "strongarm.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index aa51c0a7034..9fe282342ab 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 23b596d0c81..d986e8f7a24 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "hw/arm/digic.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 89f0e944632..66af0e2376d 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -33,7 +33,7 @@
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "target/arm/cpu-qom.h"
 
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 70d3a99d79e..9d976c3d142 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "system/system.h"
 #include "system/block-backend.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f3a60022d84..50b34139fa2 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -24,7 +24,7 @@
 #include "hw/arm/fsl-imx6.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "system/system.h"
 #include "chardev/char.h"
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 883c7fc534f..225e1791263 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -21,7 +21,7 @@
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 02f7602077f..9a230d222fd 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/misc/unimp.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index ee6f3e42d23..79f91427772 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -13,7 +13,7 @@
 #include "hw/arm/bsa.h"
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/misc/unimp.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/kvm.h"
 #include "system/system.h"
 #include "target/arm/cpu.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index bd60ab26898..82fa9647119 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -28,7 +28,7 @@
 #include "net/net.h"
 #include "system/runstate.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
 #include "hw/ide/ahci-sysbus.h"
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 71a46062032..21860ed14d3 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -29,7 +29,7 @@
 #include "hw/arm/fsl-imx25.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 44e06019670..ed8c52e1bd2 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -11,7 +11,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b030710b29d..436fcdd5101 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -11,7 +11,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/misc/arm_integrator_debug.h"
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index b446dc15470..168ecf35d09 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -18,7 +18,7 @@
 #include "hw/arm/fsl-imx31.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
 #include "net/net.h"
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index c4f6b5b1b04..e4ceb7efcd5 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index f47a265650e..5fe6526ba0a 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -15,7 +15,7 @@
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index fc8f35c5810..b1b56b920d4 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -17,7 +17,7 @@
 #include "hw/arm/fsl-imx7.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 0f3161fd931..cd035fffc76 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "system/system.h"
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 55dd68c57e1..3188caf2228 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -54,7 +54,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/or-irq.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
 #include "system/reset.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index fa4b200577f..bf5e07019ff 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -33,7 +33,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/or-irq.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index fcb8777cafd..b63002f4835 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -31,7 +31,7 @@
 #include "system/address-spaces.h"
 #include "cpu.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/or-irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index c26feccb15b..78d98c4a407 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -29,7 +29,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index a3494c96bf4..7b30d9bd446 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -27,7 +27,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/armsse.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/pl011.h"
 #include "hw/core/split-irq.h"
 #include "hw/misc/tz-mpc.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 675707691c0..3e624540960 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -18,7 +18,7 @@
 #include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index bce0d6f87a9..1657612fe77 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 8594081fe47..746a3deef8e 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index a276fea6985..3ad7643b4bd 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/npcm8xx.h"
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index b179eadef53..f775b324027 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "chardev/char.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/arm/npcm8xx.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index c5f60383335..d15545ff07a 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 730525be2dc..d858dab3253 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "ui/console.h"
 #include "hw/arm/omap.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 3e237e78fa1..c0dd32f13ce 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -22,7 +22,7 @@
 #include "system/address-spaces.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 81d2fa1b67d..910c18213a5 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -22,7 +22,7 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 0422ae0f00b..058df2c4c96 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -17,7 +17,7 @@
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
 #include "qom/object.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index d8327a50d23..97008490f6a 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -21,7 +21,7 @@
 #include "hw/qdev-core.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 5b4ab7d77a5..99cbd5e2fea 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -15,7 +15,7 @@
 #include "hw/arm/fsl-imx6.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 3ba69d37d79..32d4c52bf50 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -37,7 +37,7 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/ide/ide-bus.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 8113bbd5d8b..d1cbf43777e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -19,7 +19,7 @@
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/log.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index c11029f8bd4..4843c5565b6 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index c3c99a2da68..dd1047f6c62 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -20,7 +20,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/irq.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 3492e03a656..2f61ad0dd62 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -32,7 +32,7 @@
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/block/flash.h"
 #include "system/device_tree.h"
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 86a02966161..10cac28a910 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-migration.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index c82edd3bed1..a6dc644d0bd 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -23,7 +23,7 @@
 #include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/block/flash.h"
 #include "hw/loader.h"
 #include "hw/adc/zynq-xadc.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 5e05521a572..e82ac8e3538 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -16,7 +16,7 @@
 #include "system/device_tree.h"
 #include "system/address-spaces.h"
 #include "hw/block/flash.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/sysbus.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/xlnx-versal.h"
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 06a3d7dfe7f..3ba2736bab3 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -20,7 +20,7 @@
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "system/device_tree.h"
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ffed6e5126e..5f0e34ccecf 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -21,7 +21,7 @@
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/intc/arm_gic_common.h"
 #include "hw/misc/unimp.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c306c89e45..fb8421184d5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -31,7 +31,7 @@
 #include "exec/log.h"
 #include "exec/gdbstub.h"
 #include "system/tcg.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #ifdef CONFIG_PLUGIN
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 433efb73872..be4fe867e4d 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -33,7 +33,7 @@
 #include "qemu/osdep.h"
 #include "system/dma.h"
 #include "system/reset.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 618455e5566..07c36464047 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -33,7 +33,7 @@
 #include "qemu/module.h"
 #include "guest-loader.h"
 #include "system/device_tree.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 /*
  * Insert some FDT nodes for the loaded blob.
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 590c5b02aa1..385730e8ef5 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -61,7 +61,7 @@
 #include "hw/loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "system/memory.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/cutils.h"
 #include "system/runstate.h"
 #include "tcg/debuginfo.h"
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 74a56600be8..46846f741a2 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -24,7 +24,7 @@
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
 #include "system/numa.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 {
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 28dfd3e15bd..d23466177d8 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/vmgenid.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 0be0ac044c2..189c70015fd 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 06e0c9a179b..dea257c3086 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -14,7 +14,7 @@
 #include "qemu/units.h"
 #include "qemu/accel.h"
 #include "system/replay.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 67b769bd3e0..c52b022d3aa 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 218576f7455..fa78dacb6be 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -35,7 +35,7 @@
 #include "system/qtest.h"
 #include "hw/core/cpu.h"
 #include "hw/mem/pc-dimm.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index ff176dc1bb3..d2c39806c53 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qapi/error.h"
 
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index fab42a72705..423a3a1d660 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -34,7 +34,7 @@
 #include "qemu/option.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 5cb2e9a7f54..26e488f3d8e 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/cpu/core.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 0d891c651df..f3479b19914 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -11,7 +11,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/qtest.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 2d6d7db4ee0..ac024accfcd 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -13,7 +13,7 @@
 #include "system/address-spaces.h"
 #include "exec/cpu-common.h"
 #include "system/ramblock.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/hyperv/dynmem-proto.h"
 #include "hw/hyperv/hv-balloon.h"
 #include "hw/hyperv/vmbus.h"
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 4e685fd26e7..ead53d2724d 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus_master.h"
 #include "migration/vmstate.h"
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 26e211b31ad..ce3723e1483 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index f1089f0a7c8..3a4254638b2 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -20,7 +20,7 @@
 #include "system/address-spaces.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 6d93457c526..32e02e1eeb0 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -32,7 +32,7 @@
 #include "hw/isa/isa.h"
 #include "hw/i386/vmport.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "system/hw_accel.h"
 #include "system/qtest.h"
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 067f73e9773..ab90c83a830 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "hw/xen/arch_hvm.h"
 #include <xen/hvm/hvm_info_table.h>
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index ec9e978b0b4..83e1bc2d759 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -27,7 +27,7 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "trace.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/kvm.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index fc8005c9444..2a4557a8baa 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
index 6cfddf45206..7a8b4e7b666 100644
--- a/hw/intc/loongarch_pic_kvm.c
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/loongarch/virt.h"
 #include "system/kvm.h"
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a2041e70224..a559664c40b 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -25,7 +25,7 @@
 #include "system/address-spaces.h"
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/irq.h"
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 6174e1a05d4..513e38d9c12 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -25,7 +25,7 @@
 #include "system/address-spaces.h"
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/irq.h"
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 49434ad1828..a78a9bc03d8 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -9,7 +9,7 @@
 #include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "exec/target_page.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index ff21d7779e1..f67611ba0b2 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/m68k/mcf.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "qemu/error-report.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a25e782403f..6359aa81d0e 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -11,7 +11,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "hw/m68k/mcf.h"
 #include "qemu/timer.h"
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 4a585b231db..c1067435bf8 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -29,7 +29,7 @@
 #include "system/system.h"
 #include "system/qtest.h"
 #include "net/net.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "elf.h"
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index cfb2b319e5e..d7c460bcd4b 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -17,7 +17,7 @@
 #include "system/qtest.h"
 #include "hw/irq.h"
 #include "hw/m68k/next-cube.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/scsi/esp.h"
 #include "hw/sysbus.h"
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 36de67c328e..d663d124fce 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/m68k/q800-glue.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "hw/nmi.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b8676feb418..1aaaada3465 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -27,7 +27,7 @@
 #include "exec/target_page.h"
 #include "system/system.h"
 #include "cpu.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/or-irq.h"
 #include "elf.h"
 #include "hw/loader.h"
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 3f65d915561..6f2b7bb5a08 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -13,7 +13,7 @@
 #include "exec/target_page.h"
 #include "system/system.h"
 #include "cpu.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "elf.h"
 #include "hw/loader.h"
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 1a432e9bd22..9cf82b84cf4 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -13,7 +13,7 @@
 #include "qemu/error-report.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
 #include "system/kvm.h"
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index f701d5b5f9b..33e5a376ffa 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index ec38107f503..39eb2386e8f 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -33,7 +33,7 @@
 #include "qemu/guest-random.h"
 #include "system/device_tree.h"
 #include "system/reset.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "qemu/cutils.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 6e923c49cfc..f5b9b2e8904 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -33,7 +33,7 @@
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/qdev-properties.h"
 #include "system/address-spaces.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index e8d0ddfdf86..266ecf9e8ab 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -31,7 +31,7 @@
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/misc/unimp.h"
 #include "system/address-spaces.h"
 #include "hw/char/xilinx_uartlite.h"
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index e909802bb74..f4c55589b7f 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "cpu.h"
 #include "boot.h"
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 6a4fcdd9ca7..dc9da0b0401 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -21,7 +21,7 @@
 #include "qemu/units.h"
 
 #include "elf.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 5fe40eee65a..e777863703d 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "hw/clock.h"
 #include "net/net.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 1d6bdc00917..1708cec3f8c 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -33,7 +33,7 @@
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "net/net.h"
 #include "hw/scsi/esp.h"
 #include "hw/loader.h"
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index a4e2ea98ade..f39e56d2798 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -34,7 +34,7 @@
 #include "hw/isa/superio.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index aa240504935..b696bf39e12 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -28,7 +28,7 @@
 #include "system/dma.h"
 #include "system/reset.h"
 #include "system/address-spaces.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index b7d9cdd9007..769107e835e 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/irq.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "hw/openrisc/boot.h"
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index a98071c9365..3cfd1c0b5ce 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -13,7 +13,7 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "hw/irq.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/core/split-irq.h"
 #include "hw/openrisc/boot.h"
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4d..b3a5f16e22a 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -24,7 +24,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/numa.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qom/object.h"
 
 enum BusType { PCI, PCIE, CXL };
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b1eba348e06..e03953813c2 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -46,7 +46,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/hotplug.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 74a1fa3b635..3df4724a72b 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/ppc/ppc.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/pci-host/articia.h"
 #include "hw/isa/vt82c686.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 739f1af3e18..bdc6c7ed7fe 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -54,7 +54,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
 #include "hw/nvram/mac_nvram.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci-host/uninorth.h"
 #include "hw/input/adb.h"
 #include "hw/ppc/mac_dbdma.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index cd2bb46442f..8d35080b9d1 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -31,7 +31,7 @@
 #include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/input/adb.h"
 #include "system/system.h"
 #include "net/net.h"
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 8ce185de3ea..3b48a54e7a0 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -24,7 +24,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/qtest.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7e739a21147..824dd91ed5e 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -18,7 +18,7 @@
 #include "exec/page-protection.h"
 #include "net/net.h"
 #include "hw/pci/pci.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/kvm.h"
 #include "system/device_tree.h"
 #include "hw/loader.h"
diff --git a/hw/ppc/ppe42_machine.c b/hw/ppc/ppe42_machine.c
index f14a91b4e4d..6c9bc89e2d6 100644
--- a/hw/ppc/ppe42_machine.c
+++ b/hw/ppc/ppe42_machine.c
@@ -10,7 +10,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/ppc/ppc.h"
 #include "system/system.h"
 #include "system/reset.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 5654a60c595..0d5e1f604e6 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -31,7 +31,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/ppc.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 038b98d0b81..992bfe39a36 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -16,7 +16,7 @@
 #include "qemu/datadir.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "system/device_tree.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 43a6d505a84..8221a01639d 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -32,7 +32,7 @@
 #include "hw/block/flash.h"
 #include "system/system.h"
 #include "system/reset.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/device_tree.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 216b4876e24..13cda2f4813 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -44,7 +44,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "system/runstate.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/remote/machine.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 75f34287ff1..4f207dee287 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -22,7 +22,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/boot_opensbi.h"
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index e863c50cbc9..8a461a0dd56 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -20,7 +20,7 @@
 #include "hw/sysbus.h"
 #include "system/system.h"
 #include "net/net.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "system/address-spaces.h"
 #include "hw/char/xilinx_uartlite.h"
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index a17f62cd082..4398f7b1825 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -40,7 +40,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "chardev/char.h"
diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index 7a7b0120077..726df2daf1f 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -20,7 +20,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/riscv/numa.h"
 #include "system/device_tree.h"
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index d369a8a7dcd..309125e854b 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -23,7 +23,7 @@
 #include "hw/riscv/opentitan.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "qemu/units.h"
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 3e7f4411727..d309ea2e39e 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -17,7 +17,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/shakti_c.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 7baed1958e0..abe411e305e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -32,7 +32,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a7492aa27a4..6839a2635e8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -39,7 +39,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b0bab3fe008..6aa688acf30 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7e..45a845318e7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index a95fd6174fd..e831954cb36 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -32,7 +32,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index ed91c631788..1a33082857c 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -27,7 +27,7 @@
 #include "system/qtest.h"
 #include "system/device_tree.h"
 #include "system/reset.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qom/object.h"
 
 /* Same address of GDB integrated simulator */
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index b513f8936e4..9182ddb628d 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "target/s390x/cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/cpu-topology.h"
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 3843d2a8505..f1c2af15f75 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -21,7 +21,7 @@
 #include "elf.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/s390x/virtio-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 52820894fa1..3eea2f0c9d9 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -20,7 +20,7 @@
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 5841dfc4fec..6b67c3c109f 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "qemu/bswap.h"
 #include "system/hw_accel.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci/pci_device.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 64b81345f1e..29d95be2c64 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "system/confidential-guest-support.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "virtio-ccw.h"
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index c9a9c4bb375..b9c3983df19 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/memory.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index c29ee690690..bccd40f5712 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -33,7 +33,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "net/net.h"
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 7558b2ad839..071c3b5e629 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -26,7 +26,7 @@
 #include "qemu/uuid.h"
 #include "hw/firmware/smbios.h"
 #include "hw/loader.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 631c6113b5c..367beecf192 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -37,7 +37,7 @@
 #include "system/system.h"
 #include "system/qtest.h"
 #include "system/reset.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "trace.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 53d7ae08ae9..b0d2d6f8bc8 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -40,7 +40,7 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "net/net.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/scsi/esp.h"
 #include "hw/nvram/sun_nvram.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 1ffe92060ad..334bec14ba3 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -26,7 +26,7 @@
 #include "block/block_int-common.h"
 #include "qemu/units.h"
 #include "cpu.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/loader.h"
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 9cffc92aa3b..ce7eded143b 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
 #include "system/reset.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 82c3e7c855b..961d599f48d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -46,7 +46,7 @@
 #include "qemu/timer.h"
 #include "system/runstate.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/nvram/sun_nvram.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/sparc/sparc64.h"
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 3facfdfd611..21b119712c5 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "net/net.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/tricore/tricore.h"
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 850ef21f885..3a24afd9417 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/target-info-qapi.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i386/x86.h"
 #include "hw/arm/virt.h"
 #include "system/dma.h"
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4bfa2e0fcd2..cff413c16f5 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -15,7 +15,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 02cdd807d77..bcf6ab64432 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -21,7 +21,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/balloon.h"
 #include "system/ramblock.h"
 #include "hw/virtio/virtio-balloon.h"
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 8123c6f83a3..dd4100033f1 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -16,7 +16,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "qom/object.h"
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ae7c13e33cf..5d1d90edc52 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "migration/misc.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/acpi/acpi.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 99cb30fe595..263e112a5cb 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -20,7 +20,7 @@
 #include "exec/memop.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
 #include "hw/pci/pci.h"
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 62d33525bab..5da28cf72b2 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -25,7 +25,7 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "monitor/qdev.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index b40ae0b3af0..5d11b50db9c 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -11,7 +11,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/xen-bus.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/xen/arch_hvm.h"
 #include "system/memory.h"
 #include "system/runstate.h"
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 5ed53f8943e..da9a8e5213a 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/sysbus.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index b93ff80c859..c3fc501fe6e 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -10,7 +10,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "qapi/visitor.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "system/tpm.h"
 #include "system/tpm_backend.h"
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 99c02492ef9..c406821c34c 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen-bus.h"
 #include "system/block-backend.h"
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 49d17e7bb29..37acc562d21 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "system/memory.h"
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index b10866ccd85..b9e324c2850 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "system/reset.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "net/net.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index db3b0155495..694456aa0a1 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "elf.h"
diff --git a/migration/migration.c b/migration/migration.c
index b316ee01ab2..697f460c4aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -54,7 +54,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-tls.h"
 #include "migration/colo.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "monitor/monitor.h"
 #include "net/announce.h"
 #include "qemu/queue.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7c9fe61041f..74e925af05a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -30,7 +30,7 @@
 #include "system/system.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/ramblock.h"
 #include "socket.h"
 #include "yank_functions.h"
diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb258..6b469238ad2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -64,7 +64,7 @@
 #include "system/dirtylimit.h"
 #include "system/kvm.h"
 
-#include "hw/boards.h" /* for machine_dump_guest_core() */
+#include "hw/core/boards.h" /* for machine_dump_guest_core() */
 
 #if defined(__linux__)
 #include "qemu/userfaultfd.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index 62cc2ce25cb..73e185caf59 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "net/net.h"
 #include "migration.h"
 #include "migration/snapshot.h"
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
index 8bd28fc2328..29801023564 100644
--- a/monitor/qemu-config-qmp.c
+++ b/monitor/qemu-config-qmp.c
@@ -6,7 +6,7 @@
 #include "qobject/qlist.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 static CommandLineParameterInfoList *query_option_descs(const QemuOptDesc *desc)
 {
diff --git a/plugins/api-system.c b/plugins/api-system.c
index cc190b167ea..9a70b9caa6c 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -14,7 +14,7 @@
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/plugin-memory.h"
 #include "qemu/plugin.h"
 
diff --git a/plugins/system.c b/plugins/system.c
index b3ecc33ba52..88ff60ee2b3 100644
--- a/plugins/system.c
+++ b/plugins/system.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 #include "plugin.h"
 
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index c5a07cb947b..2e9fa5842f6 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -48,7 +48,7 @@
 #else
 #include "qemu/cutils.h"
 #include "hw/loader.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #endif
 
 #define TARGET_SYS_OPEN        0x01
diff --git a/system/bootdevice.c b/system/bootdevice.c
index 1845be4507e..8acdbfb0a57 100644
--- a/system/bootdevice.c
+++ b/system/bootdevice.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "system/reset.h"
 #include "hw/qdev-core.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 typedef struct FWBootEntry FWBootEntry;
 
diff --git a/system/cpus.c b/system/cpus.c
index ef2d2f241fa..0b1eabd3c4b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -44,7 +44,7 @@
 #include "system/runstate.h"
 #include "system/cpu-timers.h"
 #include "system/whpx.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/hw.h"
 #include "trace.h"
 
diff --git a/system/device_tree.c b/system/device_tree.c
index 7850b90fa72..3ccdf33374c 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -25,7 +25,7 @@
 #include "qemu/guest-random.h"
 #include "system/device_tree.h"
 #include "hw/loader.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index b48c0d4b3da..a0c327533c3 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -21,7 +21,7 @@
 #include "monitor/monitor.h"
 #include "system/memory.h"
 #include "exec/target_page.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/kvm.h"
 #include "trace.h"
 #include "migration/misc.h"
diff --git a/system/memory.c b/system/memory.c
index 8b84661ae36..b65219c2e49 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -32,7 +32,7 @@
 #include "system/tcg.h"
 #include "qemu/accel.h"
 #include "accel/accel-ops.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
 
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049f..edc384f4fa1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -38,7 +38,7 @@
 #include "exec/translation-block.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/xen.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index f2aa400a775..3babf81e330 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -42,7 +42,7 @@
 #include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "hw/clock.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
diff --git a/system/runstate.c b/system/runstate.c
index e3ec16ab74d..89bbfe7fbf9 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -31,7 +31,7 @@
 #include "crypto/init.h"
 #include "exec/cpu-common.h"
 #include "gdbstub/syscalls.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/resettable.h"
 #include "migration/misc.h"
 #include "migration/postcopy-ram.h"
diff --git a/target-info-stub.c b/target-info-stub.c
index d96d8249c1d..8392d81e8f8 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-impl.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "cpu.h"
 
 /* Validate correct placement of CPUArchState. */
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index d292c974c44..45df15de782 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "kvm_arm.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc1..7720d27a3c0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -37,7 +37,7 @@
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #ifdef CONFIG_TCG
 #include "hw/intc/armv7m_nvic.h"
 #endif /* CONFIG_TCG */
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de1e8fb8a05..93806fa8005 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -25,7 +25,7 @@
 
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "qemu/main-loop.h"
 #include "system/cpus.h"
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69f..c7ea6fc2f62 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -33,7 +33,7 @@
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
 #include "gdbstub/enums.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index f0761410ad0..0b0bc96bac2 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -14,7 +14,7 @@
 #include "internals.h"
 #include "target/arm/idau.h"
 #if !defined(CONFIG_USER_ONLY)
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #endif
 #include "cpregs.h"
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 64177757863..4216ca9ec1d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -42,7 +42,7 @@
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
 #include "system/address-spaces.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
 #include "system/qtest.h"
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 94ee096ecf7..316c1b0ba07 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -12,7 +12,7 @@
 #include "host-cpu.h"
 #include "qapi/error.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/hvf.h"
 #include "accel/accel-cpu-target.h"
 #include "hvf-i386.h"
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c25b558395..33a8c26bc27 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -12,7 +12,7 @@
 #include "host-cpu.h"
 #include "qapi/error.h"
 #include "system/system.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/i386/x86.h"
 
 #include "kvm_i386.h"
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 890322ae372..d24e827a214 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -16,7 +16,7 @@
 #include "vmsr_energy.h"
 #include "io/channel.h"
 #include "io/channel-socket.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "cpu.h"
 #include "host-cpu.h"
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6bf8d5f4bbb..db184e1b0d0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -19,7 +19,7 @@
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "hw/i386/apic_internal.h"
 #include "qemu/error-report.h"
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 26e40c9bdc0..6412584e1bd 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -19,7 +19,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "hw/loongarch/virt.h"
 #include "qemu/log.h"
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 6fbbd140f32..578a08dfee8 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -28,7 +28,7 @@
 #include "gdbstub/helpers.h"
 #include "semihosting/syscalls.h"
 #include "semihosting/uaccess.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "qemu/log.h"
 
 #define HOSTED_EXIT  0
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 912cd5dfa0e..a85e162409c 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -22,7 +22,7 @@
 #include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "kvm_mips.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "fpu_helper.h"
 
 #define DEBUG_KVM 0
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 7ad908b6322..ca627bd7194 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -25,7 +25,7 @@
 #include "exec/helper-proto.h"
 #include "exception.h"
 #ifndef CONFIG_USER_ONLY
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #endif
 #include "tcg/insn-start-words.h"
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 86ead740eec..a3b14cceada 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -46,7 +46,7 @@
 #include "spr_common.h"
 #include "power8-pmu.h"
 #ifndef CONFIG_USER_ONLY
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/intc/intc.h"
 #include "kvm_ppc.h"
 #endif
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 47e672c7aac..301d8de67fd 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -37,7 +37,7 @@
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/irq.h"
 #include "hw/intc/riscv_imsic.h"
 #include "qemu/log.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d3968251fad..bb03f8dc0ca 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -34,7 +34,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
 #endif
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index f3a9ffb2a27..c7a6fd7e751 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -34,7 +34,7 @@
 #include "system/hw_accel.h"
 
 #include "target/s390x/kvm/pv.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/system.h"
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 3b1e75f7833..7a7b3810590 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -28,7 +28,7 @@
 #include "exec/target_page.h"
 #include "hw/hw.h"
 #include "hw/s390x/storage-keys.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 /* Fetch/store bits in the translation exception code: */
 #define FS_READ  0x800
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index f5d7bc0fa22..b6d44c5c31b 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/runstate.h"
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index c6641280bc6..54f051ae9e1 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -33,7 +33,7 @@
 #include "system/memory.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #endif
 #include "qemu/plugin.h"
 
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 24675fc818d..9e5bd3ed07f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -40,7 +40,7 @@
 #include "user/page-protection.h"
 #else
 #include "hw/s390x/storage-keys.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #endif
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 215b5b9d933..1fd900fbbf0 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -42,7 +42,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390-pci-inst.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/s390x/tod.h"
 #include CONFIG_DEVICES
 #endif
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index f12080eda49..c848eec3b93 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -25,7 +25,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "generic_fuzz_configs.h"
 #include "hw/mem/sparse-mem.h"
 
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 326045ecbb3..28ea9158e7a 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 
 #define T true
 #define F false
diff --git a/scripts/compare-machine-types.py b/scripts/compare-machine-types.py
index 2af3995eb82..b4f899082a7 100755
--- a/scripts/compare-machine-types.py
+++ b/scripts/compare-machine-types.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Script to compare machine type compatible properties (include/hw/boards.h).
+# Script to compare machine type compatible properties (include/hw/core/boards.h).
 # compat_props are applied to the driver during initialization to change
 # default values, for instance, to maintain compatibility.
 # This script constructs table with machines and values of their compat_props
-- 
2.51.1


