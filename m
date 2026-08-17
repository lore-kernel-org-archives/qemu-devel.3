Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A3BC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtIO-0003bb-Su; Mon, 17 Aug 2026 05:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtI1-0003Hx-Qp; Mon, 17 Aug 2026 05:05:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHy-0001ea-BC; Mon, 17 Aug 2026 05:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=ge8N1mhUBtGrfH8fbPczuinkt2zg5e5u3BhzpvPbcPk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Mv1tJOJXRE9hGpo0/xxcOR233RN4xWLM+z/iE+mBm9KGWfrex3a+fepyDKXxC9Dzt
 UmiJ6VkzRNfN/tIL1FTHnw30g3zottRE56kj/kzvEqHax4EvUKain/3tY1YDzWypSt
 UKvYf4PeVV12tcm9q8UJrCJpExBREFJKFwP0H3W8G/prZlWsPH/koXAU219WTrGRFE
 m75+ZPlA6m45GGgM5x7CBgIDtHJs7MnddsF3T3j9EBy1XNUxspdi1rVjtVtyi851FS
 r97O2oR2q89t/vLnSLhyA+tMHQM1g9vtYK2AcRDt+GRwHK4OSGOTU8dmt+CHyelmov
 V1+LKbXMBwLIA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1EB961CBA3B;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EFDB340D01D;
 Mon, 17 Aug 2026 12:05:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B2BDF30CEE; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 07/42] target/hexagon: don't let an idef-parser dest
 clobber its own source
Date: Mon, 17 Aug 2026 12:04:12 +0300
Message-ID: <20260817090453.2034156-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

The idef-parser emitters write the destination in place, so when a packet
is short-circuited and get_result_gpr() returns hex_gpr[] itself, an
instruction naming one register as both source and destination reads back
a value it already overwrote.

`Rd32=cmpy(Rs32,Rt32):<<1:rnd:sat` with Rs == Rd is an example.

Give a source reg that aliases a destination its own copy of the
register value.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
(cherry picked from commit 8f5bf4fa0aa2f5648f016b8265d86d4b05b42307)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 6d5d99cee3a..43e68077495 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -75,6 +75,21 @@ def gen_tcg_func(f, tag, regs, imms):
         f.write(f"    int {hex_common.imm_name(immlett)} = insn->immed[{i}];\n")
 
     if hex_common.is_idef_parser_enabled(tag):
+        gpr_operands = [
+            hex_common.get_register(tag, regtype, regid)
+            for regtype, regid in regs
+            if hex_common.get_register(tag, regtype, regid).may_alias_gpr()
+        ]
+        dests = [reg for reg in gpr_operands if reg.is_written()]
+        for reg in gpr_operands:
+            if reg.is_written() or not reg.is_read():
+                continue
+            src = reg.reg_tcg()
+            for dest in dests:
+                f.write(hex_common.code_fmt(f"""\
+                    {src} = gen_unalias_gpr_src({src}, {dest.reg_tcg()});
+                """))
+
         declared = []
         ## Handle registers
         for regtype, regid in regs:
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 3f310377097..12813f48bf9 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -91,6 +91,17 @@ TCGv get_result_gpr(DisasContext *ctx, int rnum)
     }
 }
 
+TCGv gen_unalias_gpr_src(TCGv src, TCGv dst)
+{
+    if (src != dst) {
+        return src;
+    }
+
+    TCGv tmp = tcg_temp_new();
+    tcg_gen_mov_tl(tmp, src);
+    return tmp;
+}
+
 static TCGv_i64 get_result_gpr_pair(DisasContext *ctx, int rnum)
 {
     TCGv_i64 result = tcg_temp_new_i64();
diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
index 45ee038ca94..5d096774102 100644
--- a/target/hexagon/genptr.h
+++ b/target/hexagon/genptr.h
@@ -36,6 +36,7 @@ void gen_store8i(TCGv_env cpu_env, TCGv vaddr, int64_t src, uint32_t slot);
 TCGv gen_read_reg(TCGv result, int num);
 TCGv gen_read_preg(TCGv pred, uint8_t num);
 TCGv get_result_gpr(DisasContext *ctx, int rnum);
+TCGv gen_unalias_gpr_src(TCGv src, TCGv dst);
 TCGv get_result_pred(DisasContext *ctx, int pnum);
 void gen_pred_write(DisasContext *ctx, int pnum, TCGv val);
 void gen_set_usr_field(DisasContext *ctx, int field, TCGv val);
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index d91a653c3d4..09a025ba13e 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -388,6 +388,8 @@ def decl_reg_num(self, f, regno):
         """))
     def idef_arg(self, declared):
         declared.append(self.reg_tcg())
+    def may_alias_gpr(self):
+        return False
     def helper_arg(self):
         return HelperArg(
             self.helper_proto_type(),
@@ -495,6 +497,8 @@ def is_new(self):
         return False
 
 class GprDest(Register, Single, Dest):
+    def may_alias_gpr(self):
+        return True
     def decl_tcg(self, f, tag, regno):
         self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
@@ -510,6 +514,8 @@ def analyze_write(self, f, tag, regno):
         """))
 
 class GprSource(Register, Single, OldSource):
+    def may_alias_gpr(self):
+        return True
     def decl_tcg(self, f, tag, regno):
         self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
@@ -531,6 +537,8 @@ def analyze_read(self, f, regno):
         """))
 
 class GprReadWrite(Register, Single, ReadWrite):
+    def may_alias_gpr(self):
+        return True
     def decl_tcg(self, f, tag, regno):
         self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
@@ -557,6 +565,8 @@ def analyze_write(self, f, tag, regno):
         """))
 
 class ControlDest(Register, Single, Dest):
+    def may_alias_gpr(self):
+        return True
     def decl_reg_num(self, f, regno):
         f.write(code_fmt(f"""\
             const int {self.reg_num} = insn->regno[{regno}]  + HEX_REG_SA0;
@@ -593,6 +603,8 @@ def analyze_read(self, f, regno):
         """))
 
 class ModifierSource(Register, Single, OldSource):
+    def may_alias_gpr(self):
+        return True
     def decl_reg_num(self, f, regno):
         f.write(code_fmt(f"""\
             const int {self.reg_num} = insn->regno[{regno}] + HEX_REG_M0;
diff --git a/tests/tcg/hexagon/read_write_overlap.c b/tests/tcg/hexagon/read_write_overlap.c
index 95c54ccd63c..7eaf75f545a 100644
--- a/tests/tcg/hexagon/read_write_overlap.c
+++ b/tests/tcg/hexagon/read_write_overlap.c
@@ -115,12 +115,59 @@ static void test_swiz(void)
     check32(swiz(0x11223344), 0x44332211);
 }
 
+#define CMPY(NAME, ASM) \
+static inline uint32_t NAME##_rd_eq_rs(uint32_t x, uint32_t y) \
+{ \
+    uint32_t res; \
+    asm("r7 = %1\n\t" \
+        ASM("r7", "%2") "\n\t" \
+        "%0 = r7\n\t" \
+        : "=r"(res) : "r"(x), "r"(y) : "r7"); \
+    return res; \
+} \
+static inline uint32_t NAME##_rd_eq_rt(uint32_t x, uint32_t y) \
+{ \
+    uint32_t res; \
+    asm("r7 = %2\n\t" \
+        ASM("%1", "r7") "\n\t" \
+        "%0 = r7\n\t" \
+        : "=r"(res) : "r"(x), "r"(y) : "r7"); \
+    return res; \
+}
+
+#define CMPY_RND_SAT(RS, RT)     "r7 = cmpy(" RS "," RT "):rnd:sat"
+#define CMPY_S1_RND_SAT(RS, RT)  "r7 = cmpy(" RS "," RT "):<<1:rnd:sat"
+#define CMPYC_RND_SAT(RS, RT)    "r7 = cmpy(" RS "," RT "*):rnd:sat"
+#define CMPYC_S1_RND_SAT(RS, RT) "r7 = cmpy(" RS "," RT "*):<<1:rnd:sat"
+
+CMPY(cmpyrs_s0, CMPY_RND_SAT)
+CMPY(cmpyrs_s1, CMPY_S1_RND_SAT)
+CMPY(cmpyrsc_s0, CMPYC_RND_SAT)
+CMPY(cmpyrsc_s1, CMPYC_S1_RND_SAT)
+
+static void test_cmpy(void)
+{
+    check32(cmpyrs_s0_rd_eq_rs(0x32195ce2, 0xef862430), 0x011b105b);
+    check32(cmpyrs_s0_rd_eq_rt(0x32195ce2, 0xef862430), 0x011b105b);
+    check32(cmpyrs_s1_rd_eq_rs(0x32195ce2, 0xef862430), 0x023520b5);
+    check32(cmpyrs_s1_rd_eq_rt(0x32195ce2, 0xef862430), 0x023520b5);
+    check32(cmpyrsc_s0_rd_eq_rs(0x32195ce2, 0xef862430), 0x0d0f09e8);
+    check32(cmpyrsc_s0_rd_eq_rt(0x32195ce2, 0xef862430), 0x0d0f09e8);
+    check32(cmpyrsc_s1_rd_eq_rs(0x32195ce2, 0xef862430), 0x1a1f13d0);
+    check32(cmpyrsc_s1_rd_eq_rt(0x32195ce2, 0xef862430), 0x1a1f13d0);
+
+    /* Both halves saturate */
+    check32(cmpyrs_s1_rd_eq_rs(0x80008000, 0x80008000), 0x7fff0000);
+    check32(cmpyrsc_s1_rd_eq_rs(0x7fff8001, 0x80017fff), 0x00008000);
+}
+
 int main()
 {
     test_insert();
     test_insert_rp();
     test_asr_r_svw_trun();
     test_swiz();
+    test_cmpy();
 
     puts(err ? "FAIL" : "PASS");
     return err ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.47.3


