Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E96EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMXp-0004hG-TG; Wed, 11 Sep 2024 08:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXg-00040X-W4
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXd-00010Z-FD
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TxqMjBf0hhsky+HtnVAPJEta79bmURp31k7Ir/mM51U=;
 b=TaaMP1DhQndeYPByM5wbNgwkrOerR7wPJTuCFLyOG0t2Nqe3SU26tq6J6+UORVroe3Uthn
 iWFEBvAWlqQX17P+wgHDtPqmVjMeKriFy1fqBv/Tb0ySgFKzYRAM0Swh7WPrKnCwBXpaxx
 Siw/MhQ/AMcQqF4fakhxCtqCxFO8Q4E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-r62jHO_2MI6kbdwI5Gs0eA-1; Wed, 11 Sep 2024 08:33:47 -0400
X-MC-Unique: r62jHO_2MI6kbdwI5Gs0eA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c3402d93so3586025f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058025; x=1726662825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxqMjBf0hhsky+HtnVAPJEta79bmURp31k7Ir/mM51U=;
 b=AiDVK457IqxcR/D0J0UxVeqAzfAyPegk0ZYbJLy14BKggV1mkU26JVNObe3Dgd48wp
 hR3K9wWs3gthShp85aWxJk0R/n8ZXF+Bk0VMLE6ThMKOklmzqMx7UOAJ70ZPfuZwimc9
 PLUDDtfYotiCwtXhvdid/6sb0FQBtiyipiAkk2d2+d4akOgal5Pr2HA2I763dxgtHQ2O
 w5678zgH9VclBpnrFfpPtM6C2SeaXw05G35tlHW8x47FFqQLaJ0si8oMNVZmiOQjTtn8
 NkwwNCTMSLRzf5+i6xsQJWp5Etp4wZNXUU357yeu/vb/UXSu3d8Z1CvcFSfu8uRiueC/
 GKRw==
X-Gm-Message-State: AOJu0YxlXY5F9Z0aNql+GYaXbcASk++kFI33BtkcCibe5qd+id63b8+e
 4wyjirDV76FIPUM5LZW/nR/1rsq1Qnx02uYbKimVP3uJnEKUoYdBJ1DT1pakuNOZyfF1O4ZvPlR
 SEDNScmpCe7gDhj7erNIAAS+g+9U7MtxgiI+4FgYK5nmrnNsYDu32tEyeQmrQDrPp4o1VJaGlfy
 38vloRmicDjiH7UwIcRDX8+TGxmgA7miHsEZCzLow=
X-Received: by 2002:adf:ed0b:0:b0:374:c1c5:859e with SMTP id
 ffacd0b85a97d-3788967e478mr12118189f8f.42.1726058025439; 
 Wed, 11 Sep 2024 05:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMdjLBTelPMSRSvJiObwLv/V9Uv5OFv36hoJ8uZurTbWb/2JvGExnBvA/1Vr5YZTisvg/uBw==
X-Received: by 2002:adf:ed0b:0:b0:374:c1c5:859e with SMTP id
 ffacd0b85a97d-3788967e478mr12118169f8f.42.1726058024789; 
 Wed, 11 Sep 2024 05:33:44 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21a73sm142142185e9.3.2024.09.11.05.33.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:33:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Misc patches for 2024-09-11
Date: Wed, 11 Sep 2024 14:33:25 +0200
Message-ID: <20240911123342.339482-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 7b87a25f49a301d3377f3e71e0b4a62540c6f6e4:

  Merge tag 'edgar/xen-queue-2024-09-04.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-09-05 13:02:26 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to bcc39835be0c3dfb375172e027cb7b29d08f8abd:

  minikconf: print error entirely on stderr (2024-09-06 10:18:29 +0200)

----------------------------------------------------------------
* pc: Add a description for the i8042 property
* kvm: support for nested FRED
* tests/unit: fix warning when compiling test-nested-aio-poll with LTO
* kvm: refactoring of VM creation
* target/i386: expose IBPB-BRTYPE and SBPB CPUID bits to the guest
* hw/char: clean up serial
* remove virtfs-proxy-helper

----------------------------------------------------------------
Ani Sinha (5):
      kvm/i386: make kvm_filter_msr() and related definitions private to kvm module
      kvm/i386: fix return values of is_host_cpu_intel()
      kvm: replace fprintf with error_report()/printf() in kvm_init()
      kvm/i386: refactor kvm_arch_init and split it into smaller functions
      kvm: refactor core virtual machine creation into its own function

Bernhard Beschow (3):
      hw: Remove unused inclusion of hw/char/serial.h
      hw/char/serial.h: Extract serial-isa.h
      hw/char: Extract serial-mm

Fabiano Rosas (1):
      target/i386: Expose IBPB-BRTYPE and SBPB CPUID bits to the guest

Kamil Szczęk (1):
      hw/i386/pc: Add a description for the i8042 property

Lei Wang (1):
      target/i386: Raise the highest index value used for any VMCS encoding

Paolo Bonzini (4):
      tests/unit: remove block layer code from test-nested-aio-poll
      kvm/i386: replace identity_base variable with a constant
      virtio-9p: remove virtfs-proxy-helper
      minikconf: print error entirely on stderr

Xin Li (Intel) (2):
      target/i386: Delete duplicated macro definition CR4_FRED_MASK
      target/i386: Add VMX control bits for nested FRED support

 MAINTAINERS                         |    8 -
 docs/about/deprecated.rst           |   23 -
 docs/about/removed-features.rst     |   14 +
 docs/conf.py                        |    3 -
 docs/meson.build                    |    1 -
 docs/tools/index.rst                |    1 -
 docs/tools/virtfs-proxy-helper.rst  |   75 --
 meson.build                         |    8 -
 fsdev/qemu-fsdev.h                  |    1 -
 hw/9pfs/9p-proxy.h                  |  101 ---
 include/hw/arm/aspeed_soc.h         |    2 +-
 include/hw/char/mchp_pfsoc_mmuart.h |    2 +-
 include/hw/char/serial-isa.h        |   38 ++
 include/hw/char/serial-mm.h         |   52 ++
 include/hw/char/serial.h            |   28 -
 target/i386/cpu.h                   |    7 +-
 target/i386/kvm/kvm_i386.h          |   11 -
 accel/kvm/kvm-all.c                 |  109 +--
 fsdev/qemu-fsdev.c                  |   19 -
 fsdev/virtfs-proxy-helper.c         | 1193 --------------------------------
 hw/9pfs/9p-proxy.c                  | 1279 -----------------------------------
 hw/arm/allwinner-a10.c              |    2 +-
 hw/arm/allwinner-h3.c               |    2 +-
 hw/arm/allwinner-r40.c              |    2 +-
 hw/arm/aspeed_ast2400.c             |    2 +-
 hw/arm/aspeed_soc_common.c          |    2 +-
 hw/arm/kzm.c                        |    2 +-
 hw/arm/msf2-soc.c                   |    2 +-
 hw/arm/musicpal.c                   |    2 +-
 hw/arm/npcm7xx.c                    |    2 +-
 hw/arm/pxa2xx.c                     |    2 +-
 hw/char/omap_uart.c                 |    2 +-
 hw/char/riscv_htif.c                |    1 -
 hw/char/serial-isa.c                |    1 +
 hw/char/serial-mm.c                 |  157 +++++
 hw/char/serial.c                    |  126 ----
 hw/display/sm501.c                  |    2 +-
 hw/hppa/machine.c                   |    2 +-
 hw/i386/microvm-dt.c                |    2 +-
 hw/i386/microvm.c                   |    2 +-
 hw/i386/pc.c                        |    4 +-
 hw/isa/isa-superio.c                |    2 +-
 hw/isa/vt82c686.c                   |    2 +-
 hw/loongarch/virt.c                 |    2 +-
 hw/microblaze/petalogix_ml605_mmu.c |    2 +-
 hw/mips/boston.c                    |    2 +-
 hw/mips/jazz.c                      |    2 +-
 hw/mips/loongson3_virt.c            |    2 +-
 hw/mips/malta.c                     |    2 +-
 hw/mips/mipssim.c                   |    2 +-
 hw/openrisc/openrisc_sim.c          |    2 +-
 hw/openrisc/virt.c                  |    2 +-
 hw/ppc/e500.c                       |    2 +-
 hw/ppc/pnv.c                        |    2 +-
 hw/ppc/ppc405_uc.c                  |    2 +-
 hw/ppc/ppc440_bamboo.c              |    2 +-
 hw/ppc/prep.c                       |    1 -
 hw/ppc/sam460ex.c                   |    2 +-
 hw/ppc/virtex_ml507.c               |    2 +-
 hw/riscv/sifive_e.c                 |    1 -
 hw/riscv/sifive_u.c                 |    1 -
 hw/riscv/virt.c                     |    2 +-
 hw/sparc64/niagara.c                |    2 +-
 hw/sparc64/sun4u.c                  |    3 +-
 hw/xtensa/xtfpga.c                  |    2 +-
 target/i386/cpu.c                   |    8 +-
 target/i386/kvm/kvm.c               |  366 ++++++----
 target/i386/kvm/vmsr_energy.c       |    2 +-
 fsdev/meson.build                   |    8 -
 hw/9pfs/meson.build                 |    1 -
 hw/arm/Kconfig                      |   20 +-
 hw/char/Kconfig                     |    4 +
 hw/char/meson.build                 |    1 +
 hw/display/Kconfig                  |    2 +-
 hw/hppa/Kconfig                     |    2 +-
 hw/loongarch/Kconfig                |    2 +-
 hw/microblaze/Kconfig               |    2 +-
 hw/mips/Kconfig                     |   10 +-
 hw/openrisc/Kconfig                 |    4 +-
 hw/ppc/Kconfig                      |   10 +-
 hw/riscv/Kconfig                    |    2 +-
 hw/sparc64/Kconfig                  |    1 +
 hw/xtensa/Kconfig                   |    2 +-
 meson_options.txt                   |    2 -
 qemu-options.hx                     |   46 --
 scripts/meson-buildoptions.         |    0
 scripts/meson-buildoptions.sh       |    4 -
 scripts/minikconf.py                |    2 +-
 tests/unit/meson.build              |    2 +-
 89 files changed, 644 insertions(+), 3199 deletions(-)
 delete mode 100644 docs/tools/virtfs-proxy-helper.rst
 delete mode 100644 hw/9pfs/9p-proxy.h
 create mode 100644 include/hw/char/serial-isa.h
 create mode 100644 include/hw/char/serial-mm.h
 delete mode 100644 fsdev/virtfs-proxy-helper.c
 delete mode 100644 hw/9pfs/9p-proxy.c
 create mode 100644 hw/char/serial-mm.c
 create mode 100644 scripts/meson-buildoptions.
-- 
2.46.0


