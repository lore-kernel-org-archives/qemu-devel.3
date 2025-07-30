Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B4CC87FCE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvDv-0005Gd-Vc; Tue, 29 Jul 2025 21:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCI-0002rl-IS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCG-0004eF-Nt
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:34 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so469130b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837290; x=1754442090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WNm5Zweq7hS6FeLo8CjSOxwcXou65pxZxkillcjgC54=;
 b=nYaX3Xkm+i36ylTrSV2k4HPnEEbzqWdFpkmY2urV/SCYwIKvgg1wMrUrC8PQA3aYvq
 5Xgh2nFXxKYCHbyZHZuzotWYwJ4B7WcPxgt5DnCLgy7o0p1/AnYzuVcQSMVVdC/kMGnh
 9ljlbQ5PN8EhNtlh4tQBMZh54FEIfpcqh+Hnyd7XfHI6q9F2bEKBDffdQzqBWAxbJKRy
 SN8z3WyDtq91RfQvjXPTNSp7Gp+dfQdMNDpns437OmC+oVrDokoR8yT6MDsTM/ilX7Id
 7T63adoIVXci7LrzkrecqFWFxjO2nyC/yJ/+3wPN49EdKcCu5HaWAIID4e4rkREESkna
 uncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837290; x=1754442090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WNm5Zweq7hS6FeLo8CjSOxwcXou65pxZxkillcjgC54=;
 b=ivG3Yc2UubyJFvwA6f0GHC3WVbbcdRjl4MUwsGna0yHJJIKDmlQACIDfVkpQoq2S2c
 yTlrEGkdN+JX1WtXeDadxS1MVuuqW+YwuHjtId0cC1KJQZZtBXfwiygKCmf0dbysOlAP
 KTOr3kUtwX497/lI2yNe6for2hqqH7TL1CTj7BJQGrL5OSwUuieoCTUoDysInP2oo5Tx
 FkFoK2Xnb7FdHzGiK825pBBDSXIn8vUSijzoJXQyzHgSEnMG1QwuvK1uM8TPTLTBwEBU
 omKqP9dTF6+7Vx69OIPuZWngZ51mCi/hQ35GEbxP/7dGOF80qE+QVBHiO1jugK5G2mAu
 MaeQ==
X-Gm-Message-State: AOJu0YzIqdNhwjc4W6n4bJcVEBccx1hAyIKunHLb/c9peMiqvYaWmmT2
 ShbiqmM0GVP0Kkq88pAHIKrgVn8fzUF6KCbCtwFknS4nl6HhkEUyStBlS5zo6Q==
X-Gm-Gg: ASbGnctZBYitWIo6tWXzWkrK7yK5tQz8hKtKbhZP/wJ/7SDriqKUjL5PXtK87LYcTUx
 kLoK7+qqHoJuEvBB/exxctsaIUVON+MLsuK/N6iTvkeTTp1Zn+CsXduLcPuTiPn9PNlY/8YDDK+
 b/8ETtfhQzc6kNfHNAaIIKW0RjGXbSwujDGZjf+obe/itesx0GgfGJ+xTA9+2+/lpvw8DjVATmk
 b8a6BglN6f3F7DFUk5QXkoaQefv5F6jJwq7xu3Cf49tQ1h7yvlaya/b9Vm6zDrdT0qlm+DFO8iC
 ZQLutnAZMrIywRSVaCsk/TCGQERXiEHnigRMG8g7S+T4mjrO1XHZPIkKZ6t7rDw4P5ahcP9NgZ2
 DPlwLOKrWeiL/Wy2ABwZ3lCv5OLw1qBIgUUoX/1o/Meq2m9eTtu90C4gfpPUhnFJxcUeOWGBzkk
 ZLyGG4Q3fQpdsBK/kHW2nWXmowA3M=
X-Google-Smtp-Source: AGHT+IEWcvi55ymxoF5c+hxd+17NJuGX64X8Mw4SptWlpAPpYkSSMRG/lR3jED7+7VPDepK4/otUvg==
X-Received: by 2002:a05:6a21:6da8:b0:233:ab19:794e with SMTP id
 adf61e73a8af0-23dc05227edmr2308832637.8.1753837289937; 
 Tue, 29 Jul 2025 18:01:29 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/11] riscv-to-apply queue
Date: Wed, 30 Jul 2025 11:01:11 +1000
Message-ID: <20250730010122.4193496-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 9b80226ece693197af8a981b424391b68b5bc38e:

  Update version for the v10.1.0-rc1 release (2025-07-29 13:00:41 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250730-2

for you to fetch changes up to 86bc3a0abf10072081cddd8dff25aa72c60e67b8:

  target/riscv: Restrict midelegh access to S-mode harts (2025-07-30 10:59:26 +1000)

----------------------------------------------------------------
Third RISC-V PR for 10.1

* Fix pmp range wraparound on zero
* Update FADT and MADT versions in ACPI tables
* Fix target register read when source is inactive
* Add riscv_hwprobe entry to linux-user strace list
* Do not call GETPC() in check_ret_from_m_mode()
* Revert "Generate strided vector loads/stores with tcg nodes."
* Fix exception type when VU accesses supervisor CSRs
* Restrict mideleg/medeleg/medelegh access to S-mode harts
* Restrict midelegh access to S-mode harts

----------------------------------------------------------------
Daniel Henrique Barboza (3):
      linux-user/strace.list: add riscv_hwprobe entry
      target/riscv: do not call GETPC() in check_ret_from_m_mode()
      riscv: Revert "Generate strided vector loads/stores with tcg nodes."

Jay Chang (2):
      target/riscv: Restrict mideleg/medeleg/medelegh access to S-mode harts
      target/riscv: Restrict midelegh access to S-mode harts

Sunil V L (3):
      bios-tables-test-allowed-diff.h: Allow RISC-V FADT and MADT changes
      hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
      tests/data/acpi/riscv64: Update expected FADT and MADT

Vac Chen (1):
      target/riscv: Fix pmp range wraparound on zero

Xu Lu (1):
      target/riscv: Fix exception type when VU accesses supervisor CSRs

Yang Jialong (1):
      intc/riscv_aplic: Fix target register read when source is inactive

 hw/intc/riscv_aplic.c                   |   6 +-
 hw/riscv/virt-acpi-build.c              |  25 +--
 target/riscv/csr.c                      |  15 +-
 target/riscv/op_helper.c                |  15 +-
 target/riscv/pmp.c                      |   7 +-
 target/riscv/insn_trans/trans_rvv.c.inc | 323 +++++---------------------------
 linux-user/strace.list                  |   3 +
 tests/data/acpi/riscv64/virt/APIC       | Bin 116 -> 116 bytes
 tests/data/acpi/riscv64/virt/FACP       | Bin 276 -> 276 bytes
 9 files changed, 90 insertions(+), 304 deletions(-)

