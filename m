Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAE7C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwE-0004wP-VZ; Thu, 27 Jun 2024 06:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwD-0004vz-Pc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:09 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwB-0001Yz-PE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:09 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-711b1512aeaso5991947a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482466; x=1720087266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EQMM3dJNYgiJ/LuYfS4K3d1zvGG58kQZ/cnQ3svCEaM=;
 b=GJR2leb4XqtCFHluLYwTvHJXc5EI4LGoIwdtpfQQB6wIV8pg2A3nDcBMEYRe8GGAlj
 o71WMdu304rM7HqPGgZw6wf7JJU1AfKws/jRSE0mW9bHpW7LFm7W72e5E/sln3+ybIdn
 LqYoGrbmORBOzjcI+YIYU8eWHoyhapCNGbNKultvGXw+Tse8asMo0YT4Xh0lvs87sBNC
 O4ZnmAa8E5c8xO84EmugIA4dlxjiXAawT3+CtoPrTme21tAyWYdjd0GUQzEqBpwv/zB+
 gVJjWuVIhhKxro5GQHhpYygdiKVBoNON+UlYJUb3DyrrxwRe0e5v6HdxDSxo8ZlsJkeX
 9e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482466; x=1720087266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQMM3dJNYgiJ/LuYfS4K3d1zvGG58kQZ/cnQ3svCEaM=;
 b=kFe+aeQESCLa6mzB6cpgYx1OHj5oUIN4a361zvq6sr1ROzp9f/Hh4t2sOEazX0IMS7
 CSsKOyeDvN7vf6Q8SRurOGmgNLs2e5mUNFquXwh6rLdg9SzbdDMW2GOfzKTyM+ApcUHh
 y11AdygWlCSQ95is/O62Mpt+UH4/NQHQCaCQE7ACoVhuesYsoXaz2swMDQTFG+fXN599
 hgXYX6aA1cbwZxgwEL476W/oAVtsSII6ai4jq1tR2wG5K5e+X24hoY/doI+XzU36YEdh
 PLo4VKChNogJF6O8IxHz6+DAI9xcL3YTENchjce+D0bj2o/Xzhm5H3fBp7EFNQiAuXtn
 9zsQ==
X-Gm-Message-State: AOJu0YwIK7rz7S6cb7p4N4fJcTVxSLQO9g+a8oQ5qGTJCkDTArCsQibQ
 ga6Xl7kQ28+UqzC8NXmChHlvIPxD2PoWiQZBPceV2TXzbAbrJp27K+tDmmz+
X-Google-Smtp-Source: AGHT+IH0mu14DFAD+qbD9danpKu6QYZNRVmBhRE6re161O/oYtT5cNv3NGa0hOHofbOOimhjuLNKng==
X-Received: by 2002:a05:6a20:b128:b0:1be:c3ca:bc30 with SMTP id
 adf61e73a8af0-1bec3cad395mr3217237637.2.1719482465574; 
 Thu, 27 Jun 2024 03:01:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/32] riscv-to-apply queue
Date: Thu, 27 Jun 2024 20:00:21 +1000
Message-ID: <20240627100053.150937-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 3f044554b94fc0756d5b3cdbf84501e0eea0e629:

  Merge tag 'pull-vfio-20240624' of https://github.com/legoater/qemu into staging (2024-06-24 21:30:34 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240627-1

for you to fetch changes up to 2f5a2315b84a9b1f089ecfc3f31b29813609a7b7:

  target/riscv: Apply modularized matching conditions for icount trigger (2024-06-27 13:09:16 +1000)

----------------------------------------------------------------
RISC-V PR for 9.1

* Extend virtual irq csrs masks to be 64 bit wide
* Move Guest irqs out of the core local irqs range
* zvbb implies zvkb
* virt: add address-cells in create_fdt_one_aplic()
* virt: add aplic nodename helper
* virt: rename aplic nodename to 'interrupt-controller'
* virt: aplic DT: add 'qemu, aplic' to 'compatible'
* virt: aplic DT: rename prop to 'riscv, delegation'
* virt: change imsic nodename to 'interrupt-controller'
* virt: imsics DT: add 'qemu, imsics' to 'compatible'
* virt: imsics DT: add '#msi-cells'
* QEMU support for KVM Guest Debug on RISC-V
* Support RISC-V privilege 1.13 spec
* Add support for RISC-V ACPI tests
* Modularize common match conditions for trigger

----------------------------------------------------------------
Alvin Chang (3):
      target/riscv: Add functions for common matching conditions of trigger
      target/riscv: Apply modularized matching conditions for watchpoint
      target/riscv: Apply modularized matching conditions for icount trigger

Branislav Brzak (1):
      target/riscv: Fix froundnx.h nanbox check

Chao Du (3):
      target/riscv/kvm: add software breakpoints support
      target/riscv/kvm: handle the exit with debug reason
      target/riscv/kvm: define TARGET_KVM_HAVE_GUEST_DEBUG

Clément Léger (1):
      target/riscv: fix instructions count handling in icount mode

Daniel Henrique Barboza (8):
      hw/riscv/virt.c: add address-cells in create_fdt_one_aplic()
      hw/riscv/virt.c: add aplic nodename helper
      hw/riscv/virt.c: rename aplic nodename to 'interrupt-controller'
      hw/riscv/virt.c: aplic DT: add 'qemu, aplic' to 'compatible'
      hw/riscv/virt.c: aplic DT: rename prop to 'riscv, delegation'
      hw/riscv/virt.c: change imsic nodename to 'interrupt-controller'
      hw/riscv/virt.c: imsics DT: add 'qemu, imsics' to 'compatible'
      hw/riscv/virt.c: imsics DT: add '#msi-cells'

Fea.Wang (5):
      target/riscv: Define macros and variables for ss1p13
      target/riscv: Add 'P1P13' bit in SMSTATEEN0
      target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
      target/riscv: Reserve exception codes for sw-check and hw-err
      target/riscv: Support the version for ss1p13

Frank Chang (6):
      target/riscv: Introduce extension implied rules definition
      target/riscv: Introduce extension implied rule helpers
      target/riscv: Add MISA extension implied rules
      target/riscv: Add multi extension implied rules
      target/riscv: Add Zc extension implied rule
      target/riscv: Remove extension auto-update check statements

Jerry Zhang Jian (1):
      target/riscv: zvbb implies zvkb

Jim Shu (1):
      target/riscv: Reuse the conversion function of priv_spec

Rajnesh Kanwal (2):
      target/riscv: Extend virtual irq csrs masks to be 64 bit wide.
      target/riscv: Move Guest irqs out of the core local irqs range.

Sunil V L (1):
      hw/riscv/virt.c: Make block devices default to virtio

 configs/targets/riscv64-softmmu.mak |   1 +
 include/hw/riscv/virt.h             |   1 +
 target/riscv/cpu.h                  |  28 ++-
 target/riscv/cpu_bits.h             |   8 +-
 target/riscv/cpu_cfg.h              |   1 +
 hw/riscv/virt.c                     |  38 +++-
 target/riscv/cpu.c                  | 404 +++++++++++++++++++++++++++++++++++-
 target/riscv/csr.c                  |  92 ++++++--
 target/riscv/debug.c                | 129 ++++++++----
 target/riscv/fpu_helper.c           |   2 +-
 target/riscv/kvm/kvm-cpu.c          |  89 ++++++++
 target/riscv/tcg/tcg-cpu.c          | 287 ++++++++++++++-----------
 12 files changed, 877 insertions(+), 203 deletions(-)

