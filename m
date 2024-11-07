Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4B4D5AE60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8tqr-0006Bf-QO; Wed, 06 Nov 2024 23:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqp-0006BN-I8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqm-0004xX-HZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so5033325ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952626; x=1731557426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yKQRmFlXQB54R6KSXDPbh6494wRwtiAyZG5t6rtn6mA=;
 b=Mr6as8ClA4I05uRuE86eJmeQui7QJcrwpYA0aTi9+8XMMqQ+uu9GICjq/x4urfuKx9
 uB5bbER3I7JOjG9lOqGMKW3HGOTJGf46Tue3In592jotYomcfqqejl+1sCRU/hbBB0Uc
 Uh7HLQ1Dmy4zg6I7InfLQ7Oj7ymeoeDqpLIgTwQk9tVj3x+8DOIJcj2JYdEKJzlsTOR1
 xOztUiiqLdoX2KSZapb/dnLEM/1lThu7HpWGby037QbOPeVYZtE1HWO58muT+G2E1AWY
 7/UII0IiZvpvaoivczuOq6FvJvSIdJTHMgjt9fGRZ76Xqw1r8uTNt9w9AuviIVH8+2ut
 O7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952626; x=1731557426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yKQRmFlXQB54R6KSXDPbh6494wRwtiAyZG5t6rtn6mA=;
 b=VKXb1US16UcSDNaRNSY/JjuULcp2xEaRPFPa81AnTCYwdL9tn3J/9BhNv7/upu06mh
 TpJHOB0/SVIPy9V/vvaGKzv66znG6R1rk8Wj4fmTG5x5co0Y80mXRJh8LRUvqDxiWIcp
 6g49RL94Pw2p86Ntb3RFZZUni78LpzKZGfFUXPSAs1oe++2OSvZOM7DNEE0dujbgS/pv
 sZdVk4UyIj44L8jY8m0Sit/uL7tWO/fXV2q9zkF+pCePAEmunnaSqh08eKuVhVyLtcd/
 THrvf43hkcXARjrKD1yoloj6Bh58ngCMLgl3iZ4zcXdtglFYJ/h0qGwQVwRdCxJufA4F
 +T/w==
X-Gm-Message-State: AOJu0YxNAqV75iPKVdVWoGFOZ9JTBxGO46CTc8DzLcQWE30HtuQs7oAN
 iKjUdv5keszpLY0gZwBIRO+SDWHAk9m0oZ0rRJC9fBMeYT3CtAu3bCW9ng==
X-Google-Smtp-Source: AGHT+IG32cG57nq/rMdVPrdDONPcqVGePsqJcJ8OpU6DJZU8REJYOpB+kCCOxft7MTqqBHseqnHJfQ==
X-Received: by 2002:a17:902:e5cd:b0:20f:aee9:d8b8 with SMTP id
 d9443c01a7336-2111af419f0mr262875015ad.20.1730952626396; 
 Wed, 06 Nov 2024 20:10:26 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/12] riscv-to-apply queue
Date: Thu,  7 Nov 2024 14:10:04 +1000
Message-ID: <20241107041016.40800-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

The following changes since commit 63dc36944383f70f1c7a20f6104966d8560300fa:

  Merge tag 'hw-misc-20241105' of https://github.com/philmd/qemu into staging (2024-11-06 17:28:45 +0000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241107

for you to fetch changes up to 27652f9ca9d831c67dd447346c6ee953669255f0:

  tests/functional: Convert the RV32-on-RV64 riscv test (2024-11-07 13:12:58 +1000)

----------------------------------------------------------------
RISC-V PR for 9.2

* Fix broken SiFive UART on big endian hosts
* Fix IOMMU Coverity issues
* Improve the performance of vector unit-stride/whole register ld/st instructions
* Update kvm exts to Linux v6.11
* Convert the RV32-on-RV64 riscv test

----------------------------------------------------------------
Daniel Henrique Barboza (2):
      hw/riscv/riscv-iommu: change 'depth' to int
      hw/riscv/riscv-iommu: fix riscv_iommu_validate_process_ctx() check

Max Chou (7):
      target/riscv: Set vdata.vm field for vector load/store whole register instructions
      target/riscv: rvv: Replace VSTART_CHECK_EARLY_EXIT in vext_ldst_us
      target/riscv: rvv: Provide a fast path using direct access to host ram for unmasked unit-stride load/store
      target/riscv: rvv: Provide a fast path using direct access to host ram for unit-stride whole register load/store
      target/riscv: rvv: Provide a fast path using direct access to host ram for unit-stride load-only-first load instructions
      target/riscv: rvv: Provide group continuous ld/st flow for unit-stride ld/st instructions
      target/riscv: Inline unit-stride ld/st and corresponding functions for performance

Quan Zhou (1):
      target/riscv/kvm: Update kvm exts to Linux v6.11

Thomas Huth (2):
      hw/char/sifive_uart: Fix broken UART on big endian hosts
      tests/functional: Convert the RV32-on-RV64 riscv test

 hw/char/sifive_uart.c                   |   3 +-
 hw/riscv/riscv-iommu.c                  |   4 +-
 target/riscv/kvm/kvm-cpu.c              |   7 +
 target/riscv/vector_helper.c            | 598 +++++++++++++++++++++-----------
 target/riscv/insn_trans/trans_rvv.c.inc |   3 +
 tests/avocado/tuxrun_baselines.py       |  16 -
 tests/functional/test_riscv64_tuxrun.py |  13 +
 7 files changed, 424 insertions(+), 220 deletions(-)

