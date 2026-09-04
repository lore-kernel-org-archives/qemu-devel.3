Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E47C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLU-0005SA-9W; Fri, 04 Sep 2026 01:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLS-0005RW-Tx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLQ-0001FM-Un
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:10 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-855d2bfae95so2126318b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499208; x=1789104008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpndKwhnQ/QApBv4oYosESPfmN2G7PQoPHCQtoERl00=;
 b=Jc46G2Bf05O1QBrq1p1G2SoFR5l5/NV6o4FnjlDCWZK4C+ft/D7kBm8EhszhazlzLR
 CLdRs4UoDoIjrkVbNqET41UoASWDn4gJPcgzM9AaUvZDbma/q6mKARhKlk/BE/STuM95
 acVnLNWCkrbxsKHccoJ+/U9zYG9nOte7UgWMf4RPC5sA5qiTf4w+D8HSSJsylFN2rmcU
 oPhaQCUYc68sL3pRcRp5ex5oa4IFIHddYKZQlLzxRrY599rvnOeWaKT9X40wDwTXPgqy
 tydHE26KMwYwc6OKJ3IDrudOxAoM7sCKAi+aSkn4EuJ+BWwavTsM7mgqoWJqclR/4zL4
 AR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499208; x=1789104008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpndKwhnQ/QApBv4oYosESPfmN2G7PQoPHCQtoERl00=;
 b=X+tzoptFcKf51CimtRQQzlByRRQp8GYykxmpqNd7jLcgGX6ut6bgJQIlsjxN7+FkJG
 WIkFDbJgN/nfUtJwL+5/zi+/wRUqcJUT6TqqUOqLOH/FjUoko7CfMY49xWZ08L6YpMVi
 OH8OXbibpBxAy2WRPhaCLkyLU9s8SNER9ajvDlvRUHpu0BUQBj1VT/qPQIYLJPtZNX3+
 AayloM+NdQ1LzSVi2UqZvJpmchXfb6mqc7AQuur6jvH4R0ZHNq6SRjOSk1e/31jw+99X
 M1+vEUoDEVNvZiWbcIPAWogfvWUEtVdGOb0Flp0MTQgZ9TXssNxhotWXL2VaFQ9H4ZHY
 mo4w==
X-Gm-Message-State: AFuF++kEw84ahfKoqyNog2K0MDWpnzXD9h/w10ectJveG7kFSHDJQjSe
 /w4VDWZaLsaVRFsY9+UUwHn1+eYhBgzhZTmNVC36ovaL5OReKB/lUDEH/PKuFA==
X-Gm-Gg: AYBFou0ZCm+iAHIkjPZUzl0MUpyuF5VRfeAJNJRBCJT04ffjJCMRSLzNP2ln8UcEC4Z
 ZZynE4n+cOmghbqi1BekfD8MLIglPiAQVniPuHQphPhGCjih3bRy5BS6+U5LFUt9WRwVDBDWxRi
 3HMlj0vwjC6pGHmkb8jXFdWPNHRb1UnpwufGWUT2ttbxIUvHlUXcfXZCzAqSadHhgO0k5dsKjYZ
 pacVZX1uNQ/0yLl+OAMhdUjMDacXY3SClxAxIO/GPwHClVjDACMv9gd1fNA8YXlc8nkPU2FbsS7
 tshuWpGX3tS9nOUJ3C4YnHx1HHAIfNmspnbO98srLNWmayb2RNjDmlXa5wyiCTlJJBp/H4g0RuP
 XWTFBk5+A3DwgyZBFNqUxAEg/qbsjgkROUfH8DFMZQwlYhYHGCPjHoWaTvPfGq6Bt2z+ObLPrPu
 WB/al0ykcKW/l3N3V3Kp5F4gthRwHc74/5r6Qzur0K2t07H/LbkyP5+y1CIckaRoUrwWcSArKHh
 Sythw==
X-Received: by 2002:a05:6a20:9383:b0:3d8:effe:34f2 with SMTP id
 adf61e73a8af0-3da3c01052dmr2561190637.12.1788499207542; 
 Thu, 03 Sep 2026 22:20:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/47] docs/specs: add RISC-V CPU Debug support info
Date: Fri,  4 Sep 2026 15:19:01 +1000
Message-ID: <20260904051943.799041-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Add documentation regarding how QEMU handles Debug versions 0.13 and
1.0.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260805182506.2943757-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-debug.rst | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 docs/specs/riscv-debug.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 7c7282b425..44e108db02 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -39,6 +39,7 @@ guest hardware that is specific to QEMU.
    rocker
    riscv-iommu
    riscv-aia
+   riscv-debug
    aspeed-intc
    iommu-testdev
    s390x-secure-ipl
diff --git a/docs/specs/riscv-debug.rst b/docs/specs/riscv-debug.rst
new file mode 100644
index 0000000000..e6dcad7d38
--- /dev/null
+++ b/docs/specs/riscv-debug.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _riscv-debug:
+
+RISC-V Debug support for RISC-V CPUs
+====================================
+
+Up until QEMU version 11.1 RISC-V CPUs historically supports Debug version
+0.13 via a "debug" flag that is enabled by default in the default rv64
+CPU.
+
+Starting on QEMU 11.2, RISC-V CPUs supports also Debug version 1.0, enabled
+via the "sdtrig" flag like a regular extension.  The default setting for rv64
+is still Debug 0.13 (debug = on, sdtrig = off),
+
+The "sdtrig" flag precedes "debug", i.e. if both are enabled the CPU will
+implement Debug 1.0.  In short:
+
+.. list-table:: "debug" and "sdtrig" flags and enabled Debug version
+   :widths: 25 25 25
+   :header-rows: 1
+
+   * - debug
+     - sdtrig
+     - Enabled Debug version
+   * - on
+     - off
+     - 0.13
+   * - on
+     - on
+     - 1.0
+   * - off
+     - on
+     - 1.0
+   * - off
+     - off
+     - All Debug versions disabled
+
+
+Debug 0.13 to 1.0 code/design changes
+-------------------------------------
+
+The effort done in QEMU version 11.2 to support Debug versions 0.13 and
+1.0 together was based in section 1.2.1.2 "Incompatible Changes from 0.13
+to 1.0" from the ratified `1.0 spec`_.  Here's how the proposed changes in
+that section were implemented in QEMU 11.2:
+
+Changes that aren't applicable due to either being SBI related or not present/supported in QEMU:
+    * "Make haltsum0 optional if there is only one hart."
+    * "System bus autoincrement only happens if an access actually takes place (sbdata0)."
+    * "Require debugger to poll dmactive after lowering it."
+
+Already implemented in the legacy Debug 0.13 base code:
+    * "When a selected trigger is disabled, tdata2 and tdata3 can be written with any value supported by any of the types this trigger supports."
+    * "tcontrol fields only apply to breakpoint traps, not any trap."
+
+All "hitN" fields are hardwired 0 thus no changes made:
+    * "If version is greater than 0, then hit0 (previously called mcontrol6.hit) now contains 0 when a trigger fires more than one instruction after the instruction that matched. (This information is now reflected in hit1.)"
+
+QEMU doesn't support encoding sizes greater than 64 bit so no change made:
+    * "If version is greater than 0, then the encodings of size for sizes greater than 64 bit have changed."
+
+Changes made in the 0.13 codebase to support Debug 1.0:
+    * "Add pending to icount."
+    * "If version is greater than 0, then bit 20 of mcontrol6 is no longer used for timing information. (Previously the bit was called mcontrol6.timing.)"
+
+
+.. _1.0 spec: https://docs.riscv.org/reference/debug/v1.0/_attachments/riscv-debug-specification.pdf
-- 
2.55.0


