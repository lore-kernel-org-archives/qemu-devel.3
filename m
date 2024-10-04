Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBE3CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGA-00057M-3k; Fri, 04 Oct 2024 12:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlG7-0004wK-WD
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlG5-00066M-Ud
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YhRzys9ei3aZSVe+W9ZYNoL5rsQkRBcXJQlaSuHnOTE=;
 b=OxamaeIEkRQwuOWvMxJxZrpFjtQbKO1B/ti4jb4PvgHE4czy9Vi2uQanUJBNYV8F3q0pfI
 4I2afVMjrgMIDgGPJiqWiwPXmDYWqwb9g6LtBe6Q8DeRsm92r0UTWWjJd16fyRFsdwN3wV
 /mS6F8R1b7WmO+/Mw4CoQRc6bz6k/Po=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-cuuv0k9YPGqQhXuBoQvByQ-1; Fri, 04 Oct 2024 12:34:21 -0400
X-MC-Unique: cuuv0k9YPGqQhXuBoQvByQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42f89a68c29so1409015e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059660; x=1728664460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YhRzys9ei3aZSVe+W9ZYNoL5rsQkRBcXJQlaSuHnOTE=;
 b=JKiV7LmMf56m2OcmYTrARb0LD89iJ70Y9X0p5J7ei4+0tfAcXAiwC538Mz/xsdDV4L
 KZ94v6D4aDC/1jpttLa7ORd0q71Wu0JgeaB12iaITxa49IGWyIDGp70wYLbhIXxUpBpt
 YogB3AI/sZaQUbKnDB5R6SPRq0gZh3HwkyTEG+y/ThZAR7GobbfKAiZKd45Svbuc84BK
 S/HyZwTw4acHUnPwMtD3pAyk+TaT3qw77SEYqmopZRAtqagl5Ucnhka3nmqLbiOx08ZX
 g9WtFIAejY7dKSXUp2mRs1bB4ldmVncfNgLX+Sf6HfLTBSlwu3ndVmiQkHvRSYyUaH1j
 vDdA==
X-Gm-Message-State: AOJu0YyNiC/+GkZQbbwHzilLhLV162d0ndJAIPpF2v/PaIKl2f8WarmG
 wG7qH1Xk5tJGEfhpKVPOd+kILJM+t/6rfsWQd80Ej9OmkNtvlSF6QZctzbwUhoCjRza80lF43J9
 qD89i/P8O9NG1Qo0Hi3ymMtSYF1fXbOdU08YfuYkSNMlJSmq4hNKJQrGCjtTWo3TbILjtR/8xW8
 c6UutKCvDVhoDUCfLTwO6Q54kCHeCmvcL9L18WSxg=
X-Received: by 2002:a05:600c:21c4:b0:42c:af06:71b with SMTP id
 5b1f17b1804b1-42f87e4e24amr16377995e9.28.1728059659924; 
 Fri, 04 Oct 2024 09:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2yGh8a703oV6AY0CMGuJ14fSkqNtyPubXuA8m+AIvytS5Vz70BJYgeEvTtA/+9nnT5DlZyA==
X-Received: by 2002:a05:600c:21c4:b0:42c:af06:71b with SMTP id
 5b1f17b1804b1-42f87e4e24amr16377705e9.28.1728059659280; 
 Fri, 04 Oct 2024 09:34:19 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f1cfsm36823f8f.10.2024.10.04.09.34.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] Misc patches for 2024-10-04
Date: Fri,  4 Oct 2024 18:33:52 +0200
Message-ID: <20241004163415.951106-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:

  Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 7cca79fa52128054b02ecbea249aa51e1916ba72:

  qom: update object_resolve_path*() documentation (2024-10-03 22:04:24 +0200)

----------------------------------------------------------------
* pc: Add a description for the i8042 property
* kvm: support for nested FRED
* tests/unit: fix warning when compiling test-nested-aio-poll with LTO
* kvm: refactoring of VM creation
* target/i386: expose IBPB-BRTYPE and SBPB CPUID bits to the guest
* hw/char: clean up serial
* remove virtfs-proxy-helper
* target/i386/kvm: Report which action failed in kvm_arch_put/get_registers
* qom: improvements to object_resolve_path*()

----------------------------------------------------------------
Ani Sinha (6):
      kvm/i386: make kvm_filter_msr() and related definitions private to kvm module
      kvm/i386: fix return values of is_host_cpu_intel()
      kvm: replace fprintf with error_report()/printf() in kvm_init()
      kvm/i386: refactor kvm_arch_init and split it into smaller functions
      kvm: refactor core virtual machine creation into its own function
      accel/kvm: refactor dirty ring setup

Bernhard Beschow (3):
      hw: Remove unused inclusion of hw/char/serial.h
      hw/char/serial.h: Extract serial-isa.h
      hw/char: Extract serial-mm

Fabiano Rosas (1):
      target/i386: Expose IBPB-BRTYPE and SBPB CPUID bits to the guest

Julia Suvorova (2):
      kvm: Allow kvm_arch_get/put_registers to accept Error**
      target/i386/kvm: Report which action failed in kvm_arch_put/get_registers

Kamil Szczęk (1):
      hw/i386/pc: Add a description for the i8042 property

Lei Wang (1):
      target/i386: Raise the highest index value used for any VMCS encoding

Marc-André Lureau (3):
      qom: rename object_resolve_path_type() "ambiguousp"
      qom: set *ambiguous on all paths
      qom: update object_resolve_path*() documentation

Paolo Bonzini (4):
      tests/unit: remove block layer code from test-nested-aio-poll
      kvm/i386: replace identity_base variable with a constant
      9p: remove 'proxy' filesystem backend driver
      minikconf: print error entirely on stderr

Xin Li (Intel) (2):
      target/i386: Delete duplicated macro definition CR4_FRED_MASK
      target/i386: Add VMX control bits for nested FRED support

 MAINTAINERS                         |    8 -
 docs/about/deprecated.rst           |   22 -
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
 include/qom/object.h                |   12 +-
 include/sysemu/kvm.h                |    4 +-
 target/i386/cpu.h                   |    7 +-
 target/i386/kvm/kvm_i386.h          |   11 -
 accel/kvm/kvm-all.c                 |  354 ++++++----
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
 qom/object.c                        |   13 +-
 target/arm/kvm.c                    |    4 +-
 target/i386/cpu.c                   |    8 +-
 target/i386/kvm/kvm.c               |  383 +++++++----
 target/i386/kvm/vmsr_energy.c       |    2 +-
 target/loongarch/kvm/kvm.c          |    4 +-
 target/mips/kvm.c                   |    4 +-
 target/ppc/kvm.c                    |    4 +-
 target/riscv/kvm/kvm-cpu.c          |    4 +-
 target/s390x/kvm/kvm.c              |    4 +-
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
 98 files changed, 827 insertions(+), 3330 deletions(-)
 delete mode 100644 docs/tools/virtfs-proxy-helper.rst
 delete mode 100644 hw/9pfs/9p-proxy.h
 create mode 100644 include/hw/char/serial-isa.h
 create mode 100644 include/hw/char/serial-mm.h
 delete mode 100644 fsdev/virtfs-proxy-helper.c
 delete mode 100644 hw/9pfs/9p-proxy.c
 create mode 100644 hw/char/serial-mm.c
 create mode 100644 scripts/meson-buildoptions.
-- 
2.46.1


