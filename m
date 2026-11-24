Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxvZrjtz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwUz-00028E-JC; Tue, 24 Nov 2026 14:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVwUm-00025q-WB; Tue, 24 Nov 2026 14:48:05 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVwUj-0006Br-IM; Tue, 24 Nov 2026 14:48:04 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CD1B620C3;
 Tue, 24 Nov 2026 19:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46931F000CF;
 Tue, 24 Nov 2026 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795549679;
 bh=h/HYrxuCSKjUlx6UaRDCumwdZDh4sMToNe3c3pgQvts=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HxvZrjtzQeguu1euklmSq85dilquM0OkssFPB5fjyf9dlzej+TX4gDfBMgKNpbhki
 h4fCSdCkDnjsyW4aw8mBKY60JxOvV+SAEqL62lGCRaSzXoWXGRqBDVGHaEnnAjzYfd
 SgL/TjpnOWV50phTSh8r3uw6Kzbnoz+x5dypzNKIj0DLIgXDgq+RD5ZAe1gOdbVSld
 PDLcFV3M9GC//ZClmYUHgj6LR2Db9Hy4FSO0dtUk8IDMN9gDUlPWaNqrXgFUAX1kCu
 Xk2ISpAekvEMeDKzmWJ2tS1K5x3/sxWe7nq9HRxYT7kWQwU1c4zciJ4X/LsAnBBSAS
 1xyioqNqcBw2A==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 24 Nov 2026 11:47:51 -0800
Subject: [PATCH v9 3/7] hw/riscv: define capabilities of CBQRI controllers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-riscv-ssqosid-cbqri-v9-3-73b961a3f1d9@kernel.org>
References: <20261124-riscv-ssqosid-cbqri-v9-0-73b961a3f1d9@kernel.org>
In-Reply-To: <20261124-riscv-ssqosid-cbqri-v9-0-73b961a3f1d9@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3710; i=fustini@kernel.org;
 h=from:subject:message-id; bh=ZZZGHu09BjE+PGMOQWdwhNg1P47qjihq9puSdv7vySE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSzvnwdy9U480nXhpYICZ0sjV/r/kZ9Nbvise9jwJ0ln
 G+b96xR7yhlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMRCuFkWG69w7Lt5wXHidO
 YLX8vFPu5ge7gmU53zdd4Gx/FB7741oDw//41z/mr55+UbArWtL3fNHX6yI1+yJf8nbOUQxU/3q
 o34YHAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicolas Pitre <npitre@baylibre.com>

Define structs to represent the hardware capabilities of capacity and
bandwidth controllers according to the RISC-V Capacity and Bandwidth QoS
Register Interface (CBQRI).

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
[fustini: rebase, update to the ratified spec, add caps_init()]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS              |  7 +++++
 include/hw/riscv/cbqri.h | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47eefdf2c399..3d36a784a3ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -406,6 +406,13 @@ F: target/riscv/XVentanaCondOps.decode
 F: target/riscv/insn_trans/trans_xventanacondops.c.inc
 F: disas/riscv-xventana*
 
+RISC-V QoS (Ssqosid ext and CBQRI spec)
+M: Nicolas Pitre <npitre@baylibre.com>
+M: Drew Fustini <fustini@kernel.org>
+L: qemu-riscv@nongnu.org
+S: Supported
+F: include/hw/riscv/cbqri.h
+
 RISC-V SiFive (Xsf*) extensions
 M: Max Chou <max.chou@sifive.com>
 L: qemu-riscv@nongnu.org
diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
new file mode 100644
index 000000000000..7132e6474fb9
--- /dev/null
+++ b/include/hw/riscv/cbqri.h
@@ -0,0 +1,73 @@
+/*
+ * RISC-V Capacity and Bandwidth QoS Register Interface
+ * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
+ *
+ * Copyright (c) 2023 BayLibre SAS
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_CBQRI_H
+#define HW_RISCV_CBQRI_H
+
+#include "qemu/typedefs.h"
+
+#define RISCV_CBQRI_VERSION_MAJOR   1
+#define RISCV_CBQRI_VERSION_MINOR   0
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
+/*
+ * Set the property defaults in a capability struct. A board changes the
+ * fields it needs and passes the struct to the matching create function.
+ */
+void riscv_cbqri_cc_caps_init(RiscvCbqriCapacityCaps *caps);
+void riscv_cbqri_bc_caps_init(RiscvCbqriBandwidthCaps *caps);
+
+DeviceState *riscv_cbqri_cc_create(hwaddr addr,
+                                   const RiscvCbqriCapacityCaps *caps);
+DeviceState *riscv_cbqri_bc_create(hwaddr addr,
+                                   const RiscvCbqriBandwidthCaps *caps);
+#endif

-- 
2.43.0


