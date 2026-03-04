Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21AFEF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmvr-00033v-8B; Wed, 04 Mar 2026 09:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vxl4U-0003z6-L3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:23 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vxl4S-0005yY-1L
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:22 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so2207209f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 04:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1772626277; x=1773231077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=evG91mDXXm2KIXJefdQAMtzpLE2N7OrQgLHa+Na8298=;
 b=ipejcRtPYFJYTRks9h72wOR4K95h6yaxWvYQAYr2866rtbuc5pHGqN4PO9LuCAF14R
 YP5d7axpQH0NWiAxlqgrbCiGCZjQGkBAMIuHTLM55H1qJryrrndL2Gb0NIW767ezG80O
 ElrhWyVCBPmc7WssgrwJOJFoInZn/Xolyb+R0wcwEi4FR12lJVftRMSGO+9Vm1hzEX1z
 bAZVfKey5dPtpnEZTXwy2d/sLcAn8z8O3kVVx4EWQgTv8TdnpZjC4fw0WrCk9B9L3eNW
 bHDD6gFzDS86WwXYkHhG7BgnOiKCBf2678/R0A3W/Vs8xhEEBR/WM5eJGbb/tIXzmykn
 bVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772626277; x=1773231077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evG91mDXXm2KIXJefdQAMtzpLE2N7OrQgLHa+Na8298=;
 b=rErO4NcVkt7QbhEe0uAjYjSJG/SFfmNBenfICiimVvJE7qQnnou5kVgycFFB9qIgPB
 AUpzazTTmhDqFAfvHBj9WJb4792nSZnGNYJKE8EXvVqQMnpgAjjWczDLf//hAHaLz2AQ
 iN4Fa4AJ/DlKeL675SFcYjnRgUKCp7gOG1KSd4cuhoDqEpTmmmel0yBND4DPGnVPXNBb
 KcuBBLK/wDu9SP5E+nmsMRRyvRKHfGD2OVXoV2TgelxWI7gyiLXfDdeSwLLQ9QBkFk9y
 G8wyo4cImCD1bG1uh6Z8659QgnWtci5dIivI8/eyfVfkhkkViTYKfqnvQel4gG+hJZBz
 3s7A==
X-Gm-Message-State: AOJu0Yxr7Aa3sJE+8+JTkmTDZbzxinjOw5X+xrhih6jezXtugc0jEc6V
 aQ/7X9ZA1Ym9zSE4pSt7qx+CDTf91HUT3vgZo/PMyvjixCzMTECISSJBW26i60S68bY=
X-Gm-Gg: ATEYQzzBTFM9DVWWZDyUeOVnYA8yNrchrNpT5W5hZyaTS4iSegloNUNfvYZdg5zCzwL
 klaRj//ZqdYDtp7oiKq89F0SaqZMH5WtIPJq/53o3Uq9YDimBumK4QlAdiB9kM0rV0HKwA7caIg
 izC8y9Z2GKDiIL9SPkYzp6/ky2xj2IN+Lqx0x/dAMFhrMKcfp2/AnWToNX7wZ9W76kMWeS57y7a
 hdQjspRqg5JJbgfPbi1si9CdT2eKacksQwgdtv+c1KIynIaIqxXDltcC32OiVI59b1SfA9eB2HR
 tUjZaPKAU6AELW/i2GxCThmOzVvX41DR76HqtC+7xK0qZTB6IfOGj4uZyV7KcN/mMjfbWlj2r35
 d1jKrQpiF6wyyTmmmA+Y1GAQx5+52dQicNL+AN8z426RnmG4ppP47Kw3AtpydQzHpowx/0qeB/o
 Gj2ExGrhXfgI+7lkzoCHvP9WUgpnqjV4fPzk2RtkBXgzE0oCiWHne0+C0PSuVsTAyPBHU1n4ROG
 19e8rjzpfcUv49jnGTl
X-Received: by 2002:a05:6000:178d:b0:439:9812:35ea with SMTP id
 ffacd0b85a97d-439c108ceb8mr9778672f8f.3.1772626276788; 
 Wed, 04 Mar 2026 04:11:16 -0800 (PST)
Received: from jw-ThinkPad-T14-Gen-3.home (128.70.159.143.dyn.plus.net.
 [143.159.70.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm28217570f8f.35.2026.03.04.04.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 04:11:16 -0800 (PST)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH 0/3] RISC-V Zbr0p93 extension
Date: Wed,  4 Mar 2026 12:11:10 +0000
Message-ID: <20260304121113.117299-1-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Mar 2026 09:09:21 -0500
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

This patch series adds support for the unratified RISC-V Zbr0p93
extension which is implemented by the Ibex core and used in the (now
taped-out) OpenTitan mask ROM.

Because this extension uses the standard reserved encoding space, it's
possible that it could conflict with a ratified extension in the future.

These patches were written by Rivos for the OpenTitan fork of QEMU, but
lowRISC is choosing to upstream them.

Emmanuel Blot (3):
  util: export CRC32[C] lookup tables
  target/riscv: add unratified RISC-V Zbr0p93 ext
  disas: diassemble RISC-V Zbr0p93 instructions

 MAINTAINERS                               |  2 +-
 disas/meson.build                         |  3 +-
 disas/riscv-zbr.c                         | 78 +++++++++++++++++++++
 disas/riscv-zbr.h                         | 18 +++++
 disas/riscv.c                             |  4 ++
 include/qemu/crc32.h                      | 18 +++++
 include/qemu/crc32c.h                     |  1 +
 target/riscv/bitmanip_helper.c            | 20 ++++++
 target/riscv/cpu.c                        |  4 +-
 target/riscv/cpu_cfg.h                    |  3 +
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/helper.h                     |  2 +
 target/riscv/insn32.decode                | 12 ++++
 target/riscv/insn_trans/trans_rvb.c.inc   | 37 ++++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++
 util/crc32.c                              | 85 +++++++++++++++++++++++
 util/crc32c.c                             |  4 +-
 util/meson.build                          |  1 +
 19 files changed, 357 insertions(+), 5 deletions(-)
 create mode 100644 disas/riscv-zbr.c
 create mode 100644 disas/riscv-zbr.h
 create mode 100644 include/qemu/crc32.h
 create mode 100644 tests/tcg/riscv64/test-crc32.S
 create mode 100644 util/crc32.c

-- 
2.48.1


