Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D18C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarz-0002sX-0H; Thu, 27 Aug 2026 10:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarx-0002qf-Bb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarn-0005sJ-5H
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXXfH76IwMh9/5p8vLCuxmy9aJBgxgL/VPpjBI4iay0=;
 b=NOWrV2BeFsuu9TWYcTnEjKlzuhAHdZNSBTk/KJpJxOBhm/Y/k8RQ/OiYNLlIyVjcRLv+XI
 588KWXcJG2qUoSgNzgH3H9WFLC1/2unGxb1vTkrwzqSkUgdfeXDyfezw/b8H+p5RgWMv/t
 C3PPUYKfe/zo6Uk0f3rSJvQFqeCoSsk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-OcXRKl3rPJeb9u6p31gciQ-1; Thu, 27 Aug 2026 10:14:03 -0400
X-MC-Unique: OcXRKl3rPJeb9u6p31gciQ-1
X-Mimecast-MFC-AGG-ID: OcXRKl3rPJeb9u6p31gciQ_1787840043
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49545071724so19819975e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840042; x=1788444842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NXXfH76IwMh9/5p8vLCuxmy9aJBgxgL/VPpjBI4iay0=;
 b=jdZ5GnfDnH4YaojfZgmMvsp7J3Q8iJgbcD1WKMfYAd0lPKnHSdWY3BcZjD7GUFoaHd
 cccCP7cFNglwWdtpN1+c3S3x7PpwDoZXnNPnvuv825QKzH1wkN0qZ2V4x9hmiAETCB7W
 DD7lm1d+oTxX9NtFJ+MmrAWqnb/0pH2X8woEemBCpeXpfLWy9DwL7MayvAul8Ik69W+L
 k5fgSkMYBtsTiE3Rkk8/MgZkMETUyNVY7n8JJr4LiuBaSDT+e57mHUdxRrIaY2a4AFmM
 2YBTkdnE7pqkSn+M6DURM8fB1qYRVtarl+nziTLteSd6myu7vcZRFmNOVqnasQ2IWzq2
 EoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840042; x=1788444842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NXXfH76IwMh9/5p8vLCuxmy9aJBgxgL/VPpjBI4iay0=;
 b=j+J9mNeam49M136p4kcHetoNs/6qZdfw3Jfyy1+9khe1+XjqF4dYesjGb3FTz/8mb0
 IANVJg5EqhMVt1jBzLuZyFNyp9Y/P87LjbgbFpJO3iQmInWFmHODbrj/1ZfQSYDSd8D3
 CvvD8iq+iTkE9ubLBCuNmPoHI2P0f+JZe117CjfmdRDTZHoObK8w73g0Yssp13tqKK6b
 ObKBYbhf7LARsI7E8w6ze9DZMj0ndaikE7Ksgi6gjEYwcaeD6G19058PX2RVz9FXr/o4
 u9GdB7lNbetdJAZmQYokQhn/gaE4BFsExK6QiOa9KalKjkI5aEtIdIaTljsX0wRffLc4
 4Dbw==
X-Gm-Message-State: AFuF++kV+NVeJBA0plMr3BgfUc+t2duFrsfIQ+Rbu6DX5ObMAapVM5nH
 Lyqvl/DdF/IZLzM97ONLtA+FFM5rxy39NMIh3/StSnq7o53OL7dh5nMw3Skc7LU4+6HaaRSxHVz
 pXKvmwac9e/2myAWxEhL7jS1dxnksPV9yr/ECYQNDWM+59gq2RK3Gki/I3ItMgZT1KqfopmSS1m
 DjBrOIR3zWGdmpZAkeYSu0BNX7DGQTcNNq5/t/tWj8
X-Gm-Gg: AR+sD10FdrXYe0eb3vxBgh9MJcjWXeHDKLj9kRhbtdO0RdVw8b5lMHeBShV9YF9glBQ
 veRxaKGiAnc7tFRH0cEKc7iwR1BBCLjbNf81l8QIWvrz/jr7RVjgFx//apNP0anZGuKyCzRoBEw
 OwN5rIcE+SCRZifBsm0uD+V9ch3J4G8jHi2NED1807z93+H0H0SFP0f4vjld8U25OH7Iws+QJ+W
 tQbH83torbIKjholm7NYY0kthhkkLaGew695So82rruVYQygnPeAQWSF/cPTC54ZyMrri4nvf4r
 gC0izb8OFQy0Wwjdg4kKov8XF+vN9NcUpzdq2FVE5s4vWmY+8JudYNnEHRbNV2kI76euiq50SIb
 C1eQVYAEH4QbXM6vMZOGGgO2MiT1ncT6iBdcEZtHV0Rq0x6PrYuA0ugMKI775+NrTZZLATiCpSO
 YPqy4=
X-Received: by 2002:a05:600c:c172:b0:49b:72e4:6223 with SMTP id
 5b1f17b1804b1-49b72e463bdmr85531545e9.7.1787840042302; 
 Thu, 27 Aug 2026 07:14:02 -0700 (PDT)
X-Received: by 2002:a05:600c:c172:b0:49b:72e4:6223 with SMTP id
 5b1f17b1804b1-49b72e463bdmr85529915e9.7.1787840041662; 
 Thu, 27 Aug 2026 07:14:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b497fa9c5sm53055005e9.4.2026.08.27.07.13.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/23] target/i386/tcg: simplify return value of gen_prepare_cc
Date: Thu, 27 Aug 2026 16:13:03 +0200
Message-ID: <20260827141314.1099352-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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


