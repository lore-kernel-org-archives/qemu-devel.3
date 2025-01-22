Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6368C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVUi-00082z-G2; Wed, 22 Jan 2025 02:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1taVUJ-0007uP-Hr
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1taVUF-0002bb-UF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:23 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxvnP7opBnLBxnAA--.16011S3;
 Wed, 22 Jan 2025 15:49:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxYMb5opBneEIqAA--.26608S5;
 Wed, 22 Jan 2025 15:49:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] target/loongarch: Add generic csr function type
Date: Wed, 22 Jan 2025 15:49:09 +0800
Message-Id: <20250122074913.534050-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250122074913.534050-1-maobibo@loongson.cn>
References: <20250122074913.534050-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxYMb5opBneEIqAA--.26608S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Parameter type TCGv and TCGv_ptr for function GenCSRRead and GenCSRWrite
is not used in non-TCG mode. Generic csr function type is added here
with parameter void type, so that it passes to compile with non-TCG mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../tcg/insn_trans/trans_privileged.c.inc     | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index b90e14cd2a..0513cac577 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -44,12 +44,13 @@ GEN_FALSE_TRANS(idle)
 
 typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
 typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
+typedef void (*GenCSRFunc)(void);
 
 typedef struct {
     int offset;
     int flags;
-    GenCSRRead readfn;
-    GenCSRWrite writefn;
+    GenCSRFunc readfn;
+    GenCSRFunc writefn;
 } CSRInfo;
 
 enum {
@@ -184,8 +185,8 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
         return false;
     }
 
-    csr->readfn = readfn;
-    csr->writefn = writefn;
+    csr->readfn = (GenCSRFunc)readfn;
+    csr->writefn = (GenCSRFunc)writefn;
     return true;
 }
 
@@ -222,6 +223,7 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
 {
     TCGv dest;
     const CSRInfo *csr;
+    GenCSRRead readfn;
 
     if (check_plv(ctx)) {
         return false;
@@ -233,8 +235,9 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
     } else {
         check_csr_flags(ctx, csr, false);
         dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        if (csr->readfn) {
-            csr->readfn(dest, tcg_env);
+        readfn = (GenCSRRead)csr->readfn;
+        if (readfn) {
+            readfn(dest, tcg_env);
         } else {
             tcg_gen_ld_tl(dest, tcg_env, csr->offset);
         }
@@ -247,6 +250,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
 {
     TCGv dest, src1;
     const CSRInfo *csr;
+    GenCSRWrite writefn;
 
     if (check_plv(ctx)) {
         return false;
@@ -262,9 +266,10 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
         return false;
     }
     src1 = gpr_src(ctx, a->rd, EXT_NONE);
-    if (csr->writefn) {
+    writefn = (GenCSRWrite)csr->writefn;
+    if (writefn) {
         dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        csr->writefn(dest, tcg_env, src1);
+        writefn(dest, tcg_env, src1);
     } else {
         dest = tcg_temp_new();
         tcg_gen_ld_tl(dest, tcg_env, csr->offset);
@@ -278,6 +283,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
 {
     TCGv src1, mask, oldv, newv, temp;
     const CSRInfo *csr;
+    GenCSRWrite writefn;
 
     if (check_plv(ctx)) {
         return false;
@@ -308,8 +314,9 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
 
-    if (csr->writefn) {
-        csr->writefn(oldv, tcg_env, newv);
+    writefn = (GenCSRWrite)csr->writefn;
+    if (writefn) {
+        writefn(oldv, tcg_env, newv);
     } else {
         tcg_gen_st_tl(newv, tcg_env, csr->offset);
     }
-- 
2.39.3


