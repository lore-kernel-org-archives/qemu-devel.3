Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84558D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmhKk-0005fO-2x; Sun, 01 Feb 2026 18:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vmhKi-0005ez-Ve; Sun, 01 Feb 2026 18:58:24 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vmhKh-0007l6-2u; Sun, 01 Feb 2026 18:58:24 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AFFE441D3;
 Sun,  1 Feb 2026 23:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF2AC2BC86;
 Sun,  1 Feb 2026 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769990294;
 bh=87yUqJH6aCJ3Tzr0TY4MD9gaivxrl+oPobd3+WA3yRw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BJXJifkLslSVQ0VsnL+UdtbLc+hFJNuWn+fvdD2tCJsaQfZfwF3FZzqDUoYdLsuZq
 H8MnpikJcH9o+IhvSiyOlxjgd8Rh1FoNVrve5EGtP1xFSY+4wBKtYvvyEYX3VpK9gY
 X1k2Zb5k04uqpkx0x3xFnmBtV2LX3J1QDZ76PIqtM6PTG87ZcRCc1EZiVy0sOGH+Um
 DyBEYUuK5i8Ft43V7BtVnWSeS4QOsnRiuqz6bOYpmYIHHk/jprL53S5Zo9ZeWyudTk
 e1x9qzdPaw62Jw3KJyvkAOxwf01bKyFqCWv3Ln7WL3TSa5vrexdR3QUNriZ3l92EAf
 CUitUHaHecHJQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 01 Feb 2026 15:58:08 -0800
Subject: [PATCH v5 2/6] hw/riscv: define capabilities of CBQRI controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-riscv-ssqosid-cbqri-v5-2-273ea4a21703@kernel.org>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
In-Reply-To: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086; i=fustini@kernel.org;
 h=from:subject:message-id; bh=DEQYQbjVSlboGU+BOdVfGwtVHZcRjAKo5oA3AsVDxuE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTWv5hSaP7dwFihdc6M1WafWQyOfpryVSP6zWXXZ3I9m
 2NW2C1S6ihlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMZH8vw38np46naa157mUB
 JmedVI9XPIt0O1ZRaev0pjb8zPMI/wcM/zTvWj0uqfognl8Qq7Nlh+6PXVc/LRRpXXPs9s6fYoU
 qZowA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicolas Pitre <npitre@baylibre.com>

Define structs to represent the hardware capabilities of capacity and
bandwidth controllers according to the RISC-V Capacity and Bandwidth QoS
Register Interface (CBQRI).

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS              |  7 +++++
 include/hw/riscv/cbqri.h | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cbae7c26f83e..9d1b2b411010 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -357,6 +357,13 @@ F: target/riscv/XVentanaCondOps.decode
 F: target/riscv/insn_trans/trans_xventanacondops.c.inc
 F: disas/riscv-xventana*
 
+RISC-V QoS (Ssqosid ext and CBQRI spec)
+M: Nicolas Pitre <npitre@baylibre.com>
+M: Drew Fustini <fustini@kernel.org>
+L: qemu-riscv@nongnu.org
+S: Supported
+F: include/hw/riscv/cbqri.h
+
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
new file mode 100644
index 000000000000..a07f1e3a2dde
--- /dev/null
+++ b/include/hw/riscv/cbqri.h
@@ -0,0 +1,82 @@
+/*
+ * RISC-V Capacity and Bandwidth QoS Register Interface
+ * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
+ *
+ * Copyright (c) 2023 BayLibre SAS
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RISCV_CBQRI_H
+#define HW_RISCV_CBQRI_H
+
+#include "qemu/typedefs.h"
+
+#define RISCV_CBQRI_VERSION_MAJOR   0
+#define RISCV_CBQRI_VERSION_MINOR   1
+
+#define TYPE_RISCV_CBQRI_CC         "riscv.cbqri.capacity"
+#define TYPE_RISCV_CBQRI_BC         "riscv.cbqri.bandwidth"
+
+/* Capacity Controller hardware capabilities */
+typedef struct RiscvCbqriCapacityCaps {
+    uint16_t nb_mcids;
+    uint16_t nb_rcids;
+
+    uint16_t ncblks;
+
+    bool supports_at_data:1;
+    bool supports_at_code:1;
+
+    bool supports_alloc_op_config_limit:1;
+    bool supports_alloc_op_read_limit:1;
+    bool supports_alloc_op_flush_rcid:1;
+
+    bool supports_mon_op_config_event:1;
+    bool supports_mon_op_read_counter:1;
+
+    bool supports_mon_evt_id_none:1;
+    bool supports_mon_evt_id_occupancy:1;
+} RiscvCbqriCapacityCaps;
+
+/* Bandwidth Controller hardware capabilities */
+typedef struct RiscvCbqriBandwidthCaps {
+    uint16_t nb_mcids;
+    uint16_t nb_rcids;
+
+    uint16_t nbwblks;
+    uint16_t mrbwb;
+
+    bool supports_at_data:1;
+    bool supports_at_code:1;
+
+    bool supports_alloc_op_config_limit:1;
+    bool supports_alloc_op_read_limit:1;
+
+    bool supports_mon_op_config_event:1;
+    bool supports_mon_op_read_counter:1;
+
+    bool supports_mon_evt_id_none:1;
+    bool supports_mon_evt_id_rdwr_count:1;
+    bool supports_mon_evt_id_rdonly_count:1;
+    bool supports_mon_evt_id_wronly_count:1;
+} RiscvCbqriBandwidthCaps;
+
+DeviceState *riscv_cbqri_cc_create(hwaddr addr,
+                                   const RiscvCbqriCapacityCaps *caps,
+                                   const char *target_name);
+DeviceState *riscv_cbqri_bc_create(hwaddr addr,
+                                   const RiscvCbqriBandwidthCaps *caps,
+                                   const char *target_name);
+#endif

-- 
2.43.0


