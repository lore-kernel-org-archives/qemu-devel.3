Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9CCD116F7
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 01:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPsx8-0001iH-Lz; Sun, 30 Nov 2025 20:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vPsx3-0001ey-Tn; Sun, 30 Nov 2025 20:43:42 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vPswv-0004p1-Nq; Sun, 30 Nov 2025 20:43:41 -0500
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5B11h37U056811
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Dec 2025 09:43:03 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Dec 2025
 09:43:03 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <vivahavey@gmail.com>, Alvin Chang
 <alvinga@andestech.com>, Yu-Ming Chang <yumin686@andestech.com>
Subject: [PATCH v3 2/2] target/riscv: Simpily support versioning of debug
 trigger module
Date: Mon, 1 Dec 2025 09:42:55 +0800
Message-ID: <20251201014255.230069-3-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201014255.230069-1-alvinga@andestech.com>
References: <20251201014255.230069-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B11h37U056811
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To support multiple versions of debug specification, we have added
"debug-1.0" CPU property. Now the debug trigger module inspects this
property to determine the supported trigger types by the CPU. In this
commit we validate written trigger type with CPU debug version. For
example, the debug specification v0.13 does not support mcontrol6, and
the intended tdata_csr_write() on tdata1 with type=mcontrol6 will be
ignored.

If debug v1.0 is selected, the default trigger type is mcontrol6
instead of legacy mcontrol.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/debug.c | 56 +++++++++++++++++++++++++++++++++++++++++---
 target/riscv/debug.h |  1 +
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466..5163193 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -64,6 +64,26 @@ static tdata_avail tdata_mapping[TRIGGER_TYPE_NUM] = {
     [TRIGGER_TYPE_UNAVAIL] = { true, true, true }
 };
 
+/* Valid trigger types supported by debug specification v0.13 */
+static bool valid_trigger_type_v013[TRIGGER_TYPE_NUM] = {
+    [TRIGGER_TYPE_AD_MATCH] = true,
+    [TRIGGER_TYPE_INST_CNT] = true,
+    [TRIGGER_TYPE_INT] = true,
+    [TRIGGER_TYPE_EXCP] = true,
+    [TRIGGER_TYPE_UNAVAIL] = true
+};
+
+/* Valid trigger types supported by debug specification v1.0 */
+static bool valid_trigger_type_v100[TRIGGER_TYPE_NUM] = {
+    [TRIGGER_TYPE_AD_MATCH] = true,
+    [TRIGGER_TYPE_INST_CNT] = true,
+    [TRIGGER_TYPE_INT] = true,
+    [TRIGGER_TYPE_EXCP] = true,
+    [TRIGGER_TYPE_AD_MATCH6] = true,
+    [TRIGGER_TYPE_EXT_SRC] = true,
+    [TRIGGER_TYPE_DISABLED] = true
+};
+
 /* only breakpoint size 1/2/4/8 supported */
 static int access_size[SIZE_NUM] = {
     [SIZE_ANY] = 0,
@@ -95,6 +115,20 @@ static inline target_ulong get_trigger_type(CPURISCVState *env,
     return extract_trigger_type(env, env->tdata1[trigger_index]);
 }
 
+static inline bool validate_trigger_type(CPURISCVState *env,
+                                         target_ulong trigger_type)
+{
+    if (trigger_type >= TRIGGER_TYPE_NUM) {
+        return false;
+    }
+
+    if (riscv_cpu_cfg(env)->debug_1_00) {
+        return valid_trigger_type_v100[trigger_type];
+    }
+
+    return valid_trigger_type_v013[trigger_type];
+}
+
 static trigger_action_t get_trigger_action(CPURISCVState *env,
                                            target_ulong trigger_index)
 {
@@ -889,6 +923,13 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
         trigger_type = get_trigger_type(env, env->trigger_cur);
     }
 
+    if (!validate_trigger_type(env, trigger_type)) {
+        /* Since the tdada1.type is WARL, we simpily ignore write here. */
+        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n",
+                      trigger_type);
+        return;
+    }
+
     switch (trigger_type) {
     case TRIGGER_TYPE_AD_MATCH:
         type2_reg_write(env, env->trigger_cur, tdata_index, val);
@@ -918,8 +959,11 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
     /* assume all triggers support the same types of triggers */
-    return BIT(TRIGGER_TYPE_AD_MATCH) |
-           BIT(TRIGGER_TYPE_AD_MATCH6);
+    if (riscv_cpu_cfg(env)->debug_1_00) {
+        return BIT(TRIGGER_TYPE_AD_MATCH) | BIT(TRIGGER_TYPE_AD_MATCH6);
+    }
+
+    return BIT(TRIGGER_TYPE_AD_MATCH);
 }
 
 void riscv_cpu_debug_excp_handler(CPUState *cs)
@@ -1056,9 +1100,15 @@ void riscv_trigger_realize(CPURISCVState *env)
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
-    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
+    target_ulong tdata1;
     int i;
 
+    if (riscv_cpu_cfg(env)->debug_1_00) {
+        tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH6, 0, 0);
+    } else {
+        tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
+    }
+
     /* init to type 2 triggers */
     for (i = 0; i < RV_MAX_TRIGGERS; i++) {
         /*
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f9..0127cb9 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -43,6 +43,7 @@ typedef enum {
     TRIGGER_TYPE_AD_MATCH6 = 6,     /* new address/data match trigger */
     TRIGGER_TYPE_EXT_SRC = 7,       /* external source trigger */
     TRIGGER_TYPE_UNAVAIL = 15,      /* trigger exists, but unavailable */
+    TRIGGER_TYPE_DISABLED = 15,     /* trigger exists, but disabled */
     TRIGGER_TYPE_NUM
 } trigger_type_t;
 
-- 
2.43.0


