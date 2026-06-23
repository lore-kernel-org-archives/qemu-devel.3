Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ED4CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbuRH-00037x-Az; Tue, 23 Jun 2026 02:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wbuRE-000360-44
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 02:16:48 -0400
Received: from [160.191.52.36] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wbuRB-0002Qp-H9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 02:16:47 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 1719E240AE91;
 Tue, 23 Jun 2026 14:16:31 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v2 2/4] target/loongarch: Add guest CSR table and VM-level CSR
 infrastructure
Date: Tue, 23 Jun 2026 14:16:13 +0800
Message-ID: <68fabf6ef402bc029802df929ead0cdd43123950.1782194683.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1782194683.git.prcups@krgm.moe>
References: <cover.1782194683.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 160.191.52.36 (failed)
Received-SPF: pass client-ip=160.191.52.36; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Add gcsr_info table for guest CSR register definitions with
CSRFL_GUEST_READONLY and CSRFL_GSPR flags for sensitive register
trapping. Add get_gcsr() lookup function. Update arch_dump.c
to use host sys_states directly.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/arch_dump.c |   6 +-
 target/loongarch/csr.c       | 120 ++++++++++++++++++++++++++++++++++-
 target/loongarch/csr.h       |   3 +
 3 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef96..13472188ae 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -116,7 +116,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 {
     struct loongarch_note note;
     CPULoongArchState *env = &LOONGARCH_CPU(cs)->env;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
     int ret, i;
 
     loongarch_note_init(&note, s, "CORE", 5, NT_PRSTATUS,
@@ -127,8 +127,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     for (i = 0; i < 32; ++i) {
         note.prstatus.pr_reg.gpr[i] = cpu_to_dump64(s, env->gpr[i]);
     }
-    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, sys->CSR_ERA);
-    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, sys->CSR_BADV);
+    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, host->CSR_ERA);
+    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, host->CSR_BADV);
     ret = f(&note, LOONGARCH_PRSTATUS_NOTE_SIZE, s);
     if (ret < 0) {
         return -1;
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 309b826ca9..2157f55fb5 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -17,11 +17,26 @@
     [LOONGARCH_CSR_##NAME(N)] = {                             \
         .name   = (stringify(NAME##N)),                       \
         .offset = CSR_OFFSET(CSR_##NAME[N]),                  \
-        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
+        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
     }
 
 #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
+#define GCSR_OFF_FUNCS(NAME, FL, RD, WR)                  \
+    [LOONGARCH_CSR_##NAME] = {                            \
+        .name   = (stringify(GCSR_##NAME)),               \
+        .offset = CPU_CSR_OFFSET(CSR_##NAME, 1),          \
+        .flags = FL, .readfn = RD, .writefn = WR          \
+    }
+#define GCSR_OFF_ARRAY(NAME, N)                               \
+    [LOONGARCH_CSR_##NAME(N)] = {                             \
+        .name   = (stringify(GCSR_##NAME##N)),                \
+        .offset = CPU_CSR_OFFSET(CSR_##NAME[N], 1),           \
+        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
+    }
+#define GCSR_OFF_FLAGS(NAME, FL) GCSR_OFF_FUNCS(NAME, FL, NULL, NULL)
+#define GCSR_OFF(NAME) GCSR_OFF_FLAGS(NAME, CSRFL_BASIC)
+#define GCSR_GSPR(NAME) GCSR_OFF_FLAGS(NAME, CSRFL_GSPR)
 
 static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
@@ -35,6 +50,8 @@ static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
     CSR_OFF(EENTRY),
     CSR_OFF(TLBIDX),
+    CSR_OFF(GTLBC),
+    CSR_OFF(TRGP),
     CSR_OFF(TLBEHI),
     CSR_OFF(TLBELO0),
     CSR_OFF(TLBELO1),
@@ -71,6 +88,10 @@ static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
     CSR_OFF(CNTC),
     CSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    CSR_OFF(GSTAT),
+    CSR_OFF(GCFG),
+    CSR_OFF_FLAGS(GINTC, CSRFL_IO),
+    CSR_OFF(GCNTC),
     CSR_OFF(LLBCTL),
     CSR_OFF(IMPCTL1),
     CSR_OFF(IMPCTL2),
@@ -135,6 +156,87 @@ static CSRInfo csr_info[] = {
     CSR_OFF(MSGIR),
 };
 
+static CSRInfo gcsr_info[] = {
+    GCSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
+    GCSR_OFF(PRMD),
+    GCSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
+    GCSR_OFF_FLAGS(MISC, CSRFL_GUEST_READONLY),
+    GCSR_OFF(ECFG),
+    GCSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
+    GCSR_OFF(ERA),
+    GCSR_OFF(BADV),
+    GCSR_OFF_FLAGS(BADI, CSRFL_GUEST_READONLY),
+    GCSR_OFF(EENTRY),
+    GCSR_OFF(TLBIDX),
+    GCSR_GSPR(GTLBC),
+    GCSR_GSPR(TRGP),
+    GCSR_OFF(TLBEHI),
+    GCSR_OFF(TLBELO0),
+    GCSR_OFF(TLBELO1),
+    GCSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
+    GCSR_OFF(PGDL),
+    GCSR_OFF(PGDH),
+    GCSR_OFF_FLAGS(PGD, CSRFL_GUEST_READONLY),
+    GCSR_OFF(PWCL),
+    GCSR_OFF(PWCH),
+    GCSR_OFF(STLBPS),
+    GCSR_OFF(RVACFG),
+    GCSR_OFF_FLAGS(CPUID, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG1, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG2, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG3, CSRFL_GUEST_READONLY),
+    GCSR_OFF_ARRAY(SAVE, 0),
+    GCSR_OFF_ARRAY(SAVE, 1),
+    GCSR_OFF_ARRAY(SAVE, 2),
+    GCSR_OFF_ARRAY(SAVE, 3),
+    GCSR_OFF_ARRAY(SAVE, 4),
+    GCSR_OFF_ARRAY(SAVE, 5),
+    GCSR_OFF_ARRAY(SAVE, 6),
+    GCSR_OFF_ARRAY(SAVE, 7),
+    GCSR_OFF_ARRAY(SAVE, 8),
+    GCSR_OFF_ARRAY(SAVE, 9),
+    GCSR_OFF_ARRAY(SAVE, 10),
+    GCSR_OFF_ARRAY(SAVE, 11),
+    GCSR_OFF_ARRAY(SAVE, 12),
+    GCSR_OFF_ARRAY(SAVE, 13),
+    GCSR_OFF_ARRAY(SAVE, 14),
+    GCSR_OFF_ARRAY(SAVE, 15),
+    GCSR_OFF(TID),
+    GCSR_OFF_FLAGS(TCFG, CSRFL_IO),
+    GCSR_OFF_FLAGS(TVAL, CSRFL_GUEST_READONLY | CSRFL_IO),
+    GCSR_OFF(CNTC),
+    GCSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    GCSR_GSPR(GSTAT),
+    GCSR_GSPR(GCFG),
+    GCSR_GSPR(GINTC),
+    GCSR_GSPR(GCNTC),
+    GCSR_OFF(LLBCTL),
+    GCSR_GSPR(IMPCTL1),
+    GCSR_GSPR(IMPCTL2),
+    GCSR_OFF(TLBRENTRY),
+    GCSR_OFF(TLBRBADV),
+    GCSR_OFF(TLBRERA),
+    GCSR_OFF(TLBRSAVE),
+    GCSR_OFF(TLBRELO0),
+    GCSR_OFF(TLBRELO1),
+    GCSR_OFF(TLBREHI),
+    GCSR_OFF(TLBRPRMD),
+    GCSR_GSPR(MERRCTL),
+    GCSR_GSPR(MERRINFO1),
+    GCSR_GSPR(MERRINFO2),
+    GCSR_GSPR(MERRENTRY),
+    GCSR_GSPR(MERRERA),
+    GCSR_GSPR(MERRSAVE),
+    GCSR_GSPR(CTAG),
+    GCSR_OFF_ARRAY(DMW, 0),
+    GCSR_OFF_ARRAY(DMW, 1),
+    GCSR_OFF_ARRAY(DMW, 2),
+    GCSR_OFF_ARRAY(DMW, 3),
+    GCSR_GSPR(DBG),
+    GCSR_GSPR(DERA),
+    GCSR_GSPR(DSAVE),
+};
+
 CSRInfo *get_csr(unsigned int csr_num)
 {
     CSRInfo *csr;
@@ -151,6 +253,22 @@ CSRInfo *get_csr(unsigned int csr_num)
     return csr;
 }
 
+CSRInfo *get_gcsr(unsigned int csr_num)
+{
+    CSRInfo *csr;
+
+    if (csr_num >= ARRAY_SIZE(gcsr_info)) {
+        return NULL;
+    }
+
+    csr = &gcsr_info[csr_num];
+    if (csr->flags == 0) {
+        return NULL;
+    }
+
+    return csr;
+}
+
 bool set_csr_flag(unsigned int csr_num, int flag)
 {
     CSRInfo *csr;
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index c2b6b882bc..e233338dd3 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -20,6 +20,8 @@ enum {
     CSRFL_IO       = (1 << 2),
     CSRFL_UNUSED   = (1 << 3),
     CSRFL_BASIC    = (1 << 4),
+    CSRFL_GUEST_READONLY = (1 << 5),
+    CSRFL_GSPR     = (1 << 6),
 };
 
 typedef struct {
@@ -31,6 +33,7 @@ typedef struct {
 } CSRInfo;
 
 CSRInfo *get_csr(unsigned int csr_num);
+CSRInfo *get_gcsr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
 static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
 {
-- 
2.52.0


