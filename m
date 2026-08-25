Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF308C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHd-0004gf-26; Tue, 25 Aug 2026 08:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHZ-0004gH-QI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHX-0000Hs-GM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXXfH76IwMh9/5p8vLCuxmy9aJBgxgL/VPpjBI4iay0=;
 b=DUk/OWOhj+osmxrcsCAj3A1fdoMa/2K+d9zDdxxU+CJaECmTSlkEcY5AZZjcrz8AaQSJUI
 dWgc80+KZwzjCAP3c1Mlis8kBgEcoaapMIdDgJFdxYb476QBqljfFA3UfExqlCLWVVw5qL
 x4NXsXe4vKrVP7AWUrAo90lpUhRIEhs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-GvL2vzI0NpiBNDO4Y4xQ2Q-1; Tue, 25 Aug 2026 08:29:31 -0400
X-MC-Unique: GvL2vzI0NpiBNDO4Y4xQ2Q-1
X-Mimecast-MFC-AGG-ID: GvL2vzI0NpiBNDO4Y4xQ2Q_1787660971
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c20e5890680so229685166b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660971; x=1788265771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NXXfH76IwMh9/5p8vLCuxmy9aJBgxgL/VPpjBI4iay0=;
 b=RR3VWqhJethtmCTCfjYvcbuOYMUz4c1kLgt187gOropZe6weaGwzPJTSYgAJdBNemL
 +CU3/UCnJ1Mx7kE/MZdSKjfmTZ4wn0R1kptJBCwc+qYYTHPHZQ4peBfFPrYejajiFrro
 Htqrl9RSJKmkFx8s9ucGKjB0aAWMe3cX7w2R0XINBACTnKVC3M1e+2/EfLeQkWy5pTHd
 9hTw7+VdE1PjsB30oYrsErE8TR1UZhfnA2x6UZ2x4XhVg6SOW0cG5ssq63/88Ccndc+r
 tgEWrZM0HL0SDgLhCbJ2j7mF1XcfePJGDqcIAu20KbTtXI1d3fEF7w6qc5Km57NTC+8s
 3WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660971; x=1788265771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NXXfH76IwMh9/5p8vLCuxmy9aJBgxgL/VPpjBI4iay0=;
 b=l3t9+wi5kcAjnVR/8oDhyCY7Qb1PHRC5R1mzIHTrtpVFXhgVHgbkShXKQplJvruzM0
 7mHZpdR9+A0KfAX/i5lNaBQ1/1uwFu0EJwHVLyP7nwiASMLnOR/Vigv9FtmJtOAV6EXN
 pYGH+3qd3Kdc57PCmJ8asXN12ID3lGiHXjMfhCyeJ02biN6fTzYbmA07nta7FHKTOPoj
 TcZayVqAfMxSMeNfxj3bSGHT8aOTC0Fsns2b63vO1aWuFI+WT2eQ2MBnMipZ5OsJ5qBM
 xatL9yKCPpMC6s/ha58KgpVqfB60Hd40OyvX0+KvWmvrOpAOCGYgUIS8W6Ymc67Rvsol
 x8JA==
X-Gm-Message-State: AFuF++nLIOpyvbtlyVi8M3xS+2r6hD3SdKum73mlGHl1KuQOahxkLQEW
 swZXR1K3iJ4M42n8n+ZtzYZHR1HFGunrojOh9b3FO3E2oM73U0LnyhFn9MTTGW0kfshuoO0sc3P
 lSwlAGMMtBt3L2PKTXHvwPr9WCThg+vPu4zkc7gkF3ldYdAUh8s5qHvDyjLp29nQL5vvS1oN78K
 Hkn9QjL7bGMBS5MRSDYDNnVILhjVC8jhAKRWB6LoEy
X-Gm-Gg: AR+sD12osmyh4NKR9RnW46uHzi/zR4NSclYyMdop+iPteCIxJYjlZl2h7ljektdCtZy
 jNNFMFl3Cfx809NsFuiioDqwGGiR6IXmNORhXcQ654x8qSx9ZhsxcTglzJEwQ4+uA9LKAIPIqAi
 dmHL/c/dnTISngRMfTNoHd4pK9803Y/H0qzYHnIa3aQ20i5rqOGn3ZQZFPXFIQYU5nqWfCenrCl
 Sl90T85P68WzQpUtALW1+6fz1UXKHywA7Y/Y6AgkHoiquC/8SXFMeag9s+awCSq9RiAUKcWg397
 3KGMMtQDYA2oXWvZ3Pl3e9j4gmfQsqRxe6K4b9yU76SJgMLJ2uSvXfSL1Mh7xFIAZDE/zndlucF
 Y6Aihxf1mCpZjzLosn6Tfjt9SpL0eQgT6PgbBV07sLvLMs0HyptNzQDVYKeO1voetF5ec4WInIF
 N1AC8=
X-Received: by 2002:a17:907:948a:b0:c1f:922d:34c3 with SMTP id
 a640c23a62f3a-c24926a1c3dmr2492011766b.14.1787660970457; 
 Tue, 25 Aug 2026 05:29:30 -0700 (PDT)
X-Received: by 2002:a17:907:948a:b0:c1f:922d:34c3 with SMTP id
 a640c23a62f3a-c24926a1c3dmr2492005266b.14.1787660969889; 
 Tue, 25 Aug 2026 05:29:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24967459aesm1682765266b.48.2026.08.25.05.29.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/20] target/i386/tcg: simplify return value of gen_prepare_cc
Date: Tue, 25 Aug 2026 14:29:04 +0200
Message-ID: <20260825122921.431739-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Always make reg2 valid, unify .use_reg2 and .no_setcond now
that .use_reg2 is a misnomer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 63 ++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 70f9bb42209..bbd1c3b7893 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -828,13 +828,21 @@ static void gen_compute_eflags(DisasContext *s)
     set_cc_op(s, CC_OP_EFLAGS);
 }
 
+typedef enum {
+    /* imm is valid and reg2 is a constant */
+    CC_PREPARE_IMM,
+    /* imm is invalid */
+    CC_PREPARE_REG,
+    /* imm and reg2 are 0, and reg is known to be 0/1 */
+    CC_PREPARE_DIRECT,
+} CCPrepareRHS;
+
 typedef struct CCPrepare {
     TCGCond cond;
     TCGv reg;
     TCGv reg2;
     target_ulong imm;
-    bool use_reg2;
-    bool no_setcond;
+    CCPrepareRHS rhs_type;
 } CCPrepare;
 
 static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
@@ -871,7 +879,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
         tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
-                             .reg2 = cpu_cc_src, .use_reg2 = true };
+                             .reg2 = cpu_cc_src, .rhs_type = CC_PREPARE_REG };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
@@ -879,7 +887,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size);
         tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
-                             .reg2 = cpu_cc_src, .use_reg2 = true };
+                             .reg2 = cpu_cc_src, .rhs_type = CC_PREPARE_REG };
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
@@ -888,7 +896,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_INCB ... CC_OP_INCQ:
     case CC_OP_DECB ... CC_OP_DECQ:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .no_setcond = true };
+                             .rhs_type = CC_PREPARE_DIRECT };
 
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
@@ -913,7 +921,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst,
-                             .no_setcond = true };
+                             .rhs_type = CC_PREPARE_DIRECT };
 
     case CC_OP_EFLAGS:
     case CC_OP_SARB ... CC_OP_SARQ:
@@ -931,7 +939,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
        gen_helper_cc_compute_c(reg, cpu_cc_dst, cpu_cc_src,
                                cpu_cc_src2, cpu_cc_op);
        return (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
-                            .no_setcond = true };
+                            .rhs_type = CC_PREPARE_DIRECT };
     }
 }
 
@@ -970,7 +978,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
-                             .no_setcond = true };
+                             .rhs_type = CC_PREPARE_DIRECT };
     case CC_OP_SBB_SELF:
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
@@ -1032,7 +1040,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
             tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
-                               .reg2 = cpu_cc_src, .use_reg2 = true };
+                               .reg2 = cpu_cc_src, .rhs_type = CC_PREPARE_REG };
             break;
         case JCC_L:
             cond = TCG_COND_LT;
@@ -1043,7 +1051,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size | MO_SIGN);
             tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size | MO_SIGN);
             cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
-                               .reg2 = cpu_cc_src, .use_reg2 = true };
+                               .reg2 = cpu_cc_src, .rhs_type = CC_PREPARE_REG };
             break;
 
         default:
@@ -1128,6 +1136,9 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         break;
     }
 
+    if (cc.rhs_type != CC_PREPARE_REG) {
+        cc.reg2 = tcg_constant_tl(cc.imm);
+    }
     if (inv) {
         cc.cond = tcg_invert_cond(cc.cond);
     }
@@ -1138,7 +1149,7 @@ static void gen_neg_setcc(DisasContext *s, int b, TCGv reg)
 {
     CCPrepare cc = gen_prepare_cc(s, b, reg);
 
-    if (cc.no_setcond) {
+    if (cc.rhs_type == CC_PREPARE_DIRECT) {
         if (cc.cond == TCG_COND_EQ) {
             tcg_gen_addi_tl(reg, cc.reg, -1);
         } else {
@@ -1147,18 +1158,14 @@ static void gen_neg_setcc(DisasContext *s, int b, TCGv reg)
         return;
     }
 
-    if (cc.use_reg2) {
-        tcg_gen_negsetcond_tl(cc.cond, reg, cc.reg, cc.reg2);
-    } else {
-        tcg_gen_negsetcondi_tl(cc.cond, reg, cc.reg, cc.imm);
-    }
+    tcg_gen_negsetcond_tl(cc.cond, reg, cc.reg, cc.reg2);
 }
 
 static void gen_setcc(DisasContext *s, int b, TCGv reg)
 {
     CCPrepare cc = gen_prepare_cc(s, b, reg);
 
-    if (cc.no_setcond) {
+    if (cc.rhs_type == CC_PREPARE_DIRECT) {
         if (cc.cond == TCG_COND_EQ) {
             tcg_gen_xori_tl(reg, cc.reg, 1);
         } else {
@@ -1167,11 +1174,7 @@ static void gen_setcc(DisasContext *s, int b, TCGv reg)
         return;
     }
 
-    if (cc.use_reg2) {
-        tcg_gen_setcond_tl(cc.cond, reg, cc.reg, cc.reg2);
-    } else {
-        tcg_gen_setcondi_tl(cc.cond, reg, cc.reg, cc.imm);
-    }
+    tcg_gen_setcond_tl(cc.cond, reg, cc.reg, cc.reg2);
 }
 
 static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
@@ -1185,11 +1188,7 @@ static inline void gen_jcc_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
-    if (cc.use_reg2) {
-        tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
-    } else {
-        tcg_gen_brcondi_tl(cc.cond, cc.reg, cc.imm, l1);
-    }
+    tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
 }
 
 /* Generate a conditional jump to label 'l1' according to jump opcode
@@ -1206,11 +1205,7 @@ static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
      * it's cheaper to just compute the flags)!
      */
     gen_update_cc_op(s);
-    if (cc.use_reg2) {
-        tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
-    } else {
-        tcg_gen_brcondi_tl(cc.cond, cc.reg, cc.imm, l1);
-    }
+    tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
 }
 
 static void gen_stos(DisasContext *s, MemOp ot, TCGv dshift)
@@ -1717,10 +1712,6 @@ static void gen_cmovcc(DisasContext *s, int b, TCGv dest, TCGv src)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
-    if (!cc.use_reg2) {
-        cc.reg2 = tcg_constant_tl(cc.imm);
-    }
-
     tcg_gen_movcond_tl(cc.cond, dest, cc.reg, cc.reg2, src, dest);
 }
 
-- 
2.55.0


