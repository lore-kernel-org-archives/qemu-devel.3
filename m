Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9D606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHInhJiM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xS0TA-0000TG-Bu; Fri, 13 Nov 2026 18:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xS0T6-0000P7-8w; Fri, 13 Nov 2026 18:14:04 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xS0T2-00027x-OA; Fri, 13 Nov 2026 18:14:03 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D137742DC8;
 Fri, 13 Nov 2026 23:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732CF1F000C7;
 Fri, 13 Nov 2026 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794611631;
 bh=3VJ5VKKHRksAaEHKGJL9GJuFhNx/L3ly7jYl1xcj/1M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YHInhJiM36dCD4Th9g/MJ8X35hirbqXVXKqU/WSEikePU5ombWT/jufL1FVHrOXKl
 4E4QraGvmBeRz7pBeogrXEUNAbKXojgETN2qO3bZxeFK0sen3cnNEKEvyWrysZHboE
 JPVKLloW/GMu69FKNNJZlLVRf0oS3kqSTzZkUi+D1/z5uEF1IAtNPJ0JlLS2P/AMsi
 j0h5cq386tiXVfPLEHLmXKuBMyERhFQsvBKhEnMdEEP5t1+AWNL1us8zDwn5is+q1z
 ME8Srt5sKmrhccOnkjVKIv/yGXBS6tn+wigydkHaYp0VnGGELAzyp/njT8H2Dn/5yD
 xZhv9uyhqmH8w==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 13 Nov 2026 15:12:39 -0800
Subject: [PATCH v2 1/2] hw/riscv: add cache_level and node properties to
 CBQRI controllers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-riscv-rqsc-v2-1-34d47fa4141e@kernel.org>
References: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
In-Reply-To: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
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
 Jinjie Ruan <ruanjinjie@huawei.com>, Jinjie Ruan <2118537295@qq.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3686; i=fustini@kernel.org;
 h=from:subject:message-id; bh=C8GjMMtR0kTO2e1y7gN/VjOKEDesqqxWM7KvRC87P9Q=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWR9n7nuYfuE1DnLduZLeHk88lrnsoPpl8HE4iO6VpMiP
 wVesQ2d0lHKwiDGxSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYiMhdRoaF3xh+WP6ZNae/
 W2rzkyKp2WvZZB753LD6WnspM71cSD2d4b83C89a3g87ut8sZ91YGGcyM9nzqJhu5WTxDCnb6Bd
 X0xgB
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ACPI RQSC table specifies which cache a capacity controller backs
and which proximity domain a bandwidth controller serves.

Add a cache_level property to the capacity controller. It accepts 2 or
3, the unified cache levels that the smp-cache option can place and the
PPTT can describe, and defaults to 2. Add a node property to the
bandwidth controller. It defaults to 0 and rejects a node the machine
does not have.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/cbqri_bandwidth.c | 13 +++++++++++++
 hw/riscv/cbqri_capacity.c  |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
index bd8cf2b50e4c..6c33d1738d27 100644
--- a/hw/riscv/cbqri_bandwidth.c
+++ b/hw/riscv/cbqri_bandwidth.c
@@ -17,7 +17,9 @@
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "target/riscv/cpu.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/cbqri.h"
+#include "system/numa.h"
 
 /* Property defaults, shared with riscv_cbqri_bc_caps_init() */
 #define BC_DEFAULT_MAX_MCIDS    256
@@ -139,6 +141,7 @@ typedef struct RiscvCbqriBandwidthState {
 
     uint16_t nbwblks;
     uint16_t mrbwb;
+    uint32_t node;
 
     bool supports_at_code;
 
@@ -542,12 +545,21 @@ static const MemoryRegionOps riscv_cbqri_bc_ops = {
 static void riscv_cbqri_bc_realize(DeviceState *dev, Error **errp)
 {
     RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(dev);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
 
     if (!bc->mmio_base) {
         error_setg(errp, "mmio_base property not set");
         return;
     }
 
+    /* Without -numa there is a single implicit node 0. */
+    if (bc->node >= MAX(nb_nodes, 1)) {
+        error_setg(errp, "node %u out of range, %u NUMA node(s)",
+                   bc->node, MAX(nb_nodes, 1));
+        return;
+    }
+
     if (bc->nb_rcids == 0) {
         error_setg(errp, "max_rcids must be at least 1");
         return;
@@ -638,6 +650,7 @@ static const Property riscv_cbqri_bc_properties[] = {
                        BC_DEFAULT_NBWBLKS),
     DEFINE_PROP_UINT16("mrbwb", RiscvCbqriBandwidthState, mrbwb,
                        BC_DEFAULT_MRBWB),
+    DEFINE_PROP_UINT32("node", RiscvCbqriBandwidthState, node, 0),
 
     DEFINE_PROP_BOOL("at_code", RiscvCbqriBandwidthState,
                      supports_at_code, true),
diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
index 0c572aa8b02f..1585cad1d073 100644
--- a/hw/riscv/cbqri_capacity.c
+++ b/hw/riscv/cbqri_capacity.c
@@ -127,6 +127,7 @@ typedef struct RiscvCbqriCapacityState {
     uint16_t nb_rcids;
 
     uint16_t ncblks;
+    uint8_t cache_level;
 
     bool supports_at_code;
 
@@ -591,6 +592,11 @@ static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (cc->cache_level != 2 && cc->cache_level != 3) {
+        error_setg(errp, "cache_level must be 2 or 3");
+        return;
+    }
+
     if (cc->nb_rcids == 0) {
         error_setg(errp, "max_rcids must be at least 1");
         return;
@@ -666,6 +672,8 @@ static const Property riscv_cbqri_cc_properties[] = {
                        CC_DEFAULT_MAX_RCIDS),
     DEFINE_PROP_UINT16("ncblks", RiscvCbqriCapacityState, ncblks,
                        CC_DEFAULT_NCBLKS),
+    DEFINE_PROP_UINT8("cache_level", RiscvCbqriCapacityState,
+                      cache_level, 2),
 
     DEFINE_PROP_BOOL("at_code", RiscvCbqriCapacityState,
                      supports_at_code, true),

-- 
2.43.0


