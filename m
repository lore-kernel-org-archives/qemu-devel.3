Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31986CA6017
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wN-0004pW-I7; Thu, 08 Oct 2026 23:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vS-0004cZ-W6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:40 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vQ-0005lm-Hb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:38 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 7B8FDE003;
 Fri, 09 Oct 2026 08:35:34 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 04/23] target/loongarch: add LVZ CSR metadata
Date: Fri,  9 Oct 2026 11:05:00 +0800
Message-ID: <d6bde479623e65dfc21d3cfc8e9ff205f1a7358c.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add LVZ host and guest CSR access metadata to the existing CSR table. Mark
guest read-only and unavailable CSRs for later LVZ instruction translation.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-csr.h |  38 ++++++++++++++
 target/loongarch/cpu.h     |   6 +++
 target/loongarch/csr.c     | 102 ++++++++++++++++++++-----------------
 target/loongarch/csr.h     |   1 +
 target/loongarch/disas.c   |   5 ++
 5 files changed, 104 insertions(+), 48 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..e0061e57c3 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -224,4 +224,42 @@ FIELD(CSR_DBG, ECODE, 16, 6)
 #define LOONGARCH_CSR_DERA           0x501 /* Debug era */
 #define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
 
+/* LVZ (LoongArch Virtualization) CSRs */
+#define LOONGARCH_CSR_GTLBC          0x15 /* Guest TLB control */
+FIELD(CSR_GTLBC, GMTLBSZ, 0, 6)
+FIELD(CSR_GTLBC, USETGID, 12, 1)
+FIELD(CSR_GTLBC, TOTI, 13, 1)
+FIELD(CSR_GTLBC, TGID, 16, 8)
+
+#define LOONGARCH_CSR_GSTAT          0x50 /* Guest status */
+FIELD(CSR_GSTAT, VM, 0, 1)
+FIELD(CSR_GSTAT, PVM, 1, 1)
+FIELD(CSR_GSTAT, GIDBITS, 4, 6)
+FIELD(CSR_GSTAT, GID, 16, 8)
+
+#define LOONGARCH_CSR_GCFG           0x51 /* Guest config */
+FIELD(CSR_GCFG, MATP, 0, 4)
+FIELD(CSR_GCFG, MATC, 4, 2)
+FIELD(CSR_GCFG, TOPIP, 6, 1)
+FIELD(CSR_GCFG, TOPI, 7, 1)
+FIELD(CSR_GCFG, TOTIP, 8, 1)
+FIELD(CSR_GCFG, TOTI, 9, 1)
+FIELD(CSR_GCFG, TOEP, 10, 1)
+FIELD(CSR_GCFG, TOE, 11, 1)
+FIELD(CSR_GCFG, TOPP, 12, 1)
+FIELD(CSR_GCFG, TOP, 13, 1)
+FIELD(CSR_GCFG, TOHUP, 14, 1)
+FIELD(CSR_GCFG, TOHU, 15, 1)
+FIELD(CSR_GCFG, TOCIP, 16, 4)
+FIELD(CSR_GCFG, TOCI, 20, 2)
+FIELD(CSR_GCFG, GPMP, 23, 1)
+FIELD(CSR_GCFG, GPMNUM, 24, 3)
+
+#define LOONGARCH_CSR_GINTC          0x52 /* Guest interrupt config */
+FIELD(CSR_GINTC, HWIS, 0, 8)
+FIELD(CSR_GINTC, HWIP, 8, 8)
+FIELD(CSR_GINTC, HWIC, 16, 8)
+
+#define LOONGARCH_CSR_GCNTC          0x53 /* Guest counter compensation */
+
 #endif /* LOONGARCH_CPU_CSR_H */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 918378ee9a..0b7d63d8f3 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -255,6 +255,7 @@ FIELD(TLB_MISC, E, 0, 1)
 FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
+FIELD(TLB_MISC, GID, 54, 8)
 
 /*Msg interrupt registers */
 #define N_MSGIS                4
@@ -381,6 +382,10 @@ typedef struct CPUSysState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    uint64_t CSR_GCFG;
+    uint64_t CSR_GINTC;
+    uint64_t CSR_GCNTC;
+    uint64_t CSR_GTLBC;
     /* Msg interrupt registers */
     uint64_t CSR_MSGIS[N_MSGIS];
     uint64_t CSR_MSGIR;
@@ -389,6 +394,7 @@ typedef struct CPUSysState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
+    uint64_t CSR_GSTAT;
     uint64_t CSR_ASID;
     uint64_t CSR_PRCFG1;
     uint64_t CSR_PRCFG2;
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index d2ac39dee9..1ca9e9580e 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -13,15 +13,16 @@
         .flags = FL, .readfn = RD, .writefn = WR           \
     }
 
-#define CSR_OFF_ARRAY(NAME, N)                                \
-    [LOONGARCH_CSR_##NAME(N)] = {                             \
-        .name   = (stringify(NAME##N)),                       \
-        .offset = CSR_OFFSET(CSR_##NAME[N]),                  \
-        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
-    }
+#define CSR_OFF_ARRAY_FLAGS(NAME, N, FL)                   \
+     [LOONGARCH_CSR_##NAME(N)] = {                         \
+         .name   = (stringify(NAME##N)),                   \
+         .offset = CSR_OFFSET(CSR_##NAME[N]),              \
+         .flags = FL                                       \
+     }
 
 #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
+#define CSR_OFF_ARRAY(NAME, N)    CSR_OFF_ARRAY_FLAGS(NAME, N, CSRFL_BASIC)
 
 static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
@@ -71,9 +72,14 @@ static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
     CSR_OFF(CNTC),
     CSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    CSR_OFF_FLAGS(GTLBC, CSRFL_GSPR),
+    CSR_OFF_FLAGS(GSTAT, CSRFL_GSPR),
+    CSR_OFF_FLAGS(GCFG, CSRFL_GSPR),
+    CSR_OFF_FLAGS(GINTC, CSRFL_IO | CSRFL_GSPR),
+    CSR_OFF_FLAGS(GCNTC, CSRFL_GSPR),
     CSR_OFF(LLBCTL),
-    CSR_OFF(IMPCTL1),
-    CSR_OFF(IMPCTL2),
+    CSR_OFF_FLAGS(IMPCTL1, CSRFL_GSPR),
+    CSR_OFF_FLAGS(IMPCTL2, CSRFL_GSPR),
     CSR_OFF(TLBRENTRY),
     CSR_OFF(TLBRBADV),
     CSR_OFF(TLBRERA),
@@ -87,46 +93,46 @@ static CSRInfo csr_info[] = {
     CSR_OFF_ARRAY(DMW, 1),
     CSR_OFF_ARRAY(DMW, 2),
     CSR_OFF_ARRAY(DMW, 3),
-    CSR_OFF_ARRAY(PERFCTRL, 0),
-    CSR_OFF_ARRAY(PERFCNTR, 0),
-    CSR_OFF_ARRAY(PERFCTRL, 1),
-    CSR_OFF_ARRAY(PERFCNTR, 1),
-    CSR_OFF_ARRAY(PERFCTRL, 2),
-    CSR_OFF_ARRAY(PERFCNTR, 2),
-    CSR_OFF_ARRAY(PERFCTRL, 3),
-    CSR_OFF_ARRAY(PERFCNTR, 3),
-    CSR_OFF_ARRAY(PERFCTRL, 4),
-    CSR_OFF_ARRAY(PERFCNTR, 4),
-    CSR_OFF_ARRAY(PERFCTRL, 5),
-    CSR_OFF_ARRAY(PERFCNTR, 5),
-    CSR_OFF_ARRAY(PERFCTRL, 6),
-    CSR_OFF_ARRAY(PERFCNTR, 6),
-    CSR_OFF_ARRAY(PERFCTRL, 7),
-    CSR_OFF_ARRAY(PERFCNTR, 7),
-    CSR_OFF_ARRAY(PERFCTRL, 8),
-    CSR_OFF_ARRAY(PERFCNTR, 8),
-    CSR_OFF_ARRAY(PERFCTRL, 9),
-    CSR_OFF_ARRAY(PERFCNTR, 9),
-    CSR_OFF_ARRAY(PERFCTRL, 10),
-    CSR_OFF_ARRAY(PERFCNTR, 10),
-    CSR_OFF_ARRAY(PERFCTRL, 11),
-    CSR_OFF_ARRAY(PERFCNTR, 11),
-    CSR_OFF_ARRAY(PERFCTRL, 12),
-    CSR_OFF_ARRAY(PERFCNTR, 12),
-    CSR_OFF_ARRAY(PERFCTRL, 13),
-    CSR_OFF_ARRAY(PERFCNTR, 13),
-    CSR_OFF_ARRAY(PERFCTRL, 14),
-    CSR_OFF_ARRAY(PERFCNTR, 14),
-    CSR_OFF_ARRAY(PERFCTRL, 15),
-    CSR_OFF_ARRAY(PERFCNTR, 15),
-    CSR_OFF(DBG),
-    CSR_OFF(DERA),
-    CSR_OFF(DSAVE),
-    CSR_OFF_ARRAY(MSGIS, 0),
-    CSR_OFF_ARRAY(MSGIS, 1),
-    CSR_OFF_ARRAY(MSGIS, 2),
-    CSR_OFF_ARRAY(MSGIS, 3),
-    CSR_OFF(MSGIR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 0, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 0, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 1, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 1, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 2, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 2, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 3, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 3, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 4, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 4, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 5, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 5, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 6, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 6, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 7, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 7, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 8, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 8, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 9, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 9, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 10, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 10, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 11, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 11, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 12, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 12, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 13, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 13, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 14, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 14, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 15, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 15, CSRFL_GSPR),
+    CSR_OFF_FLAGS(DBG, CSRFL_GSPR),
+    CSR_OFF_FLAGS(DERA, CSRFL_GSPR),
+    CSR_OFF_FLAGS(DSAVE, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 0, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 1, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 2, CSRFL_GSPR),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 3, CSRFL_GSPR),
+    CSR_OFF_FLAGS(MSGIR, CSRFL_GSPR),
 };
 
 CSRInfo *get_csr(unsigned int csr_num)
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index c2b6b882bc..393ac09b61 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -20,6 +20,7 @@ enum {
     CSRFL_IO       = (1 << 2),
     CSRFL_UNUSED   = (1 << 3),
     CSRFL_BASIC    = (1 << 4),
+    CSRFL_GSPR     = (1 << 5),
 };
 
 typedef struct {
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 928b8b94c2..03d1e560dd 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -87,6 +87,11 @@ static const char * const csr_names[] = {
     CSR_NAME(TVAL),
     CSR_NAME(CNTC),
     CSR_NAME(TICLR),
+    CSR_NAME(GTLBC),
+    CSR_NAME(GSTAT),
+    CSR_NAME(GCFG),
+    CSR_NAME(GINTC),
+    CSR_NAME(GCNTC),
     CSR_NAME(LLBCTL),
     CSR_NAME(IMPCTL1),
     CSR_NAME(IMPCTL2),
-- 
2.55.0


