Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17D9C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Gn6-0006fZ-5a; Thu, 03 Apr 2025 05:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmx-0006cu-Pn
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmv-0007q6-9L
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743672184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgAD8cZCf3gq7+f4Gq1nnJqWiX2k76TNbwDvadtHCKU=;
 b=HcmYGtoXxWrTpVE8Ei+Lt0s6pWuoi3ebqVsr+wujrlUSsiW70PS5VEDZsdA2PG+SHG3Vsh
 Lbrp/HTNsYDhqOgWRjfOVpLpz7RLkGkm0tayMwmDKeWkFKmNKM0ZOkmEI8mIwJmWbdhwuu
 66o8TRnNyQDS22jrJywFHNEpIZWwoSo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-QAT6-gVpPJCCREyaZTpxJw-1; Thu, 03 Apr 2025 05:23:02 -0400
X-MC-Unique: QAT6-gVpPJCCREyaZTpxJw-1
X-Mimecast-MFC-AGG-ID: QAT6-gVpPJCCREyaZTpxJw_1743672182
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so93008266b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743672181; x=1744276981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgAD8cZCf3gq7+f4Gq1nnJqWiX2k76TNbwDvadtHCKU=;
 b=lGOmMNrZByfjBF3X3N1F3pUKI+PM5q9uAeHHbeRH63F+lHcINe6PhJHh/bEjpNGYsL
 /07xpgdKRlTZqJouw6yRITQv6KhRPvTIrUkL/W46b9vMD85QsincmZlQGtVXSM2uxAEH
 vV+pS+tR1M1e0zTUTu1dCVgccMNJsRlNAE+M26RtAyN5ZhCKPvQF28MBvdgbmlNl3f/Q
 PA9FjVK/TnVja0oU1+A9xs2VO02++J0fc419XXeqTMCt6XlKc00ikGCS9BZOXz/qMdxK
 AuM9uEHB7xsom48Yy0pMbin+aPFviEzUmLZxcgrLWA6Nn1OYi2/QZIPMJUnW+1wLEeKy
 iG0g==
X-Gm-Message-State: AOJu0YwxlcZ7dnd7HTbZkfQdHjmCtL9hvYQNyX0dRhaV99OcN1mpN+Mg
 4vIzg3AumzYkDs1o+DBjFhkg+1JsjfLyWW1vAo4VkqLwpBkzrlYam36jbyy/VSy5WiwXSy3+q6G
 Boa0OeLi/JqtTHYOl67Y8tRQoXkqgEySYy5qBTWm4eNQKvBcU2QqVtBIZgFjC5dp43/0o/tHXrU
 bjCWj4o0WKFAJGu5OVOC/k3j62Z9FOuUjOakp9
X-Gm-Gg: ASbGnctp3h+TbGmDLDu1HxwvPDFkL8qxWK+T/LclYP47cx1ZTgAmvXkd6TbjVFRHDyB
 Ymwy7oCjsLKZ8ECrPkXKjpDjLrJHkriPSUA+/c0tTqnXe3mCBKhFUDyDokkDCavtr0W4dPhiyvW
 UsfboCYHmkEcaUethLVX/Dtl66T89dT8Zxfw4Fy1iDCnjkoh6+rFBEA6o6IdyQb+pw2hyj9kg2u
 G2pNoCmcj9EtMXtmO5hs0070pIO1b7puUYoYjd8ZOa4dEzId+j2rPdiysYeuOKiBYmROPgcsVKX
 zbxcfbwlH9vkBGicCBTy
X-Received: by 2002:a17:907:94c1:b0:ac7:9a92:d892 with SMTP id
 a640c23a62f3a-ac7bc0d0e23mr146598266b.21.1743672180805; 
 Thu, 03 Apr 2025 02:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvhrPeUnn0wz0Ly9ZiG0fL+Ki7zClhUfSSHm+OAksJjhGicTxjj8R0RxGYDBKJDlCQud7gDg==
X-Received: by 2002:a17:907:94c1:b0:ac7:9a92:d892 with SMTP id
 a640c23a62f3a-ac7bc0d0e23mr146596066b.21.1743672180200; 
 Thu, 03 Apr 2025 02:23:00 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c0186250sm60861966b.155.2025.04.03.02.22.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 02:22:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/i386: tcg: remove tmp0
Date: Thu,  3 Apr 2025 11:22:50 +0200
Message-ID: <20250403092251.54441-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403092251.54441-1-pbonzini@redhat.com>
References: <20250403092251.54441-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 27 +++++++++++++++------------
 target/i386/tcg/emit.c.inc  | 20 ++++++++++----------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 822dbb2e9ae..5d433f8522e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -134,7 +134,6 @@ typedef struct DisasContext {
     TCGv T1;
 
     /* TCG local register indexes (only used inside old micro ops) */
-    TCGv tmp0;
     TCGv_i32 tmp2_i32;
     TCGv_i32 tmp3_i32;
     TCGv_i64 tmp1_i64;
@@ -2175,14 +2174,17 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     level &= 31;
     if (level != 0) {
         int i;
+        if (level > 1) {
+            TCGv fp = tcg_temp_new();
 
-        /* Copy level-1 pointers from the previous frame.  */
-        for (i = 1; i < level; ++i) {
-            gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], -size * i);
-            gen_op_ld_v(s, d_ot, s->tmp0, s->A0);
+            /* Copy level-1 pointers from the previous frame.  */
+            for (i = 1; i < level; ++i) {
+                gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], -size * i);
+                gen_op_ld_v(s, d_ot, fp, s->A0);
 
-            gen_lea_ss_ofs(s, s->A0, s->T1, -size * i);
-            gen_op_st_v(s, d_ot, s->tmp0, s->A0);
+                gen_lea_ss_ofs(s, s->A0, s->T1, -size * i);
+                gen_op_st_v(s, d_ot, fp, s->A0);
+            }
         }
 
         /* Push the current FrameTemp as the last level.  */
@@ -2405,10 +2407,11 @@ static void gen_ldy_env_A0(DisasContext *s, int offset, bool align)
     int mem_index = s->mem_index;
     TCGv_i128 t0 = tcg_temp_new_i128();
     TCGv_i128 t1 = tcg_temp_new_i128();
+    TCGv a0_hi = tcg_temp_new();
 
     tcg_gen_qemu_ld_i128(t0, s->A0, mem_index, mop | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 16);
-    tcg_gen_qemu_ld_i128(t1, s->tmp0, mem_index, mop);
+    tcg_gen_addi_tl(a0_hi, s->A0, 16);
+    tcg_gen_qemu_ld_i128(t1, a0_hi, mem_index, mop);
 
     tcg_gen_st_i128(t0, tcg_env, offset + offsetof(YMMReg, YMM_X(0)));
     tcg_gen_st_i128(t1, tcg_env, offset + offsetof(YMMReg, YMM_X(1)));
@@ -2419,12 +2422,13 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     MemOp mop = MO_128 | MO_LE | MO_ATOM_IFALIGN_PAIR;
     int mem_index = s->mem_index;
     TCGv_i128 t = tcg_temp_new_i128();
+    TCGv a0_hi = tcg_temp_new();
 
     tcg_gen_ld_i128(t, tcg_env, offset + offsetof(YMMReg, YMM_X(0)));
     tcg_gen_qemu_st_i128(t, s->A0, mem_index, mop | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 16);
+    tcg_gen_addi_tl(a0_hi, s->A0, 16);
     tcg_gen_ld_i128(t, tcg_env, offset + offsetof(YMMReg, YMM_X(1)));
-    tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
+    tcg_gen_qemu_st_i128(t, a0_hi, mem_index, mop);
 }
 
 #include "emit.c.inc"
@@ -3771,7 +3775,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    dc->tmp0 = tcg_temp_new();
     dc->tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
     dc->tmp3_i32 = tcg_temp_new_i32();
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index bb3e76f5110..03b04cadb14 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1710,22 +1710,22 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
     switch (jcc_op) {
     case JCC_O:
         /* (src1 ^ src2) & (src1 ^ dst). newv is only used here for a moment */
+        cmp_lhs = tcg_temp_new(), cmp_rhs = tcg_constant_tl(0);
         tcg_gen_xor_tl(newv, s->cc_srcT, s->T0);
-        tcg_gen_xor_tl(s->tmp0, s->cc_srcT, cmpv);
-        tcg_gen_and_tl(s->tmp0, s->tmp0, newv);
-        tcg_gen_sextract_tl(s->tmp0, s->tmp0, 0, 8 << ot);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        tcg_gen_xor_tl(cmp_lhs, s->cc_srcT, cmpv);
+        tcg_gen_and_tl(cmp_lhs, cmp_lhs, newv);
+        tcg_gen_sextract_tl(cmp_lhs, cmp_lhs, 0, 8 << ot);
         break;
 
     case JCC_P:
-        tcg_gen_ext8u_tl(s->tmp0, s->T0);
-        tcg_gen_ctpop_tl(s->tmp0, s->tmp0);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(1);
+        cmp_lhs = tcg_temp_new(), cmp_rhs = tcg_constant_tl(1);
+        tcg_gen_ext8u_tl(cmp_lhs, s->T0);
+        tcg_gen_ctpop_tl(cmp_lhs, cmp_lhs);
         break;
 
     case JCC_S:
-        tcg_gen_sextract_tl(s->tmp0, s->T0, 0, 8 << ot);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        cmp_lhs = tcg_temp_new(), cmp_rhs = tcg_constant_tl(0);
+        tcg_gen_sextract_tl(cmp_lhs, s->T0, 0, 8 << ot);
         break;
 
     default:
@@ -1876,7 +1876,7 @@ static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
                                       s->mem_index, MO_TEUQ);
     }
 
-    /* Set tmp0 to match the required value of Z. */
+    /* Compute the required value of Z. */
     tcg_gen_setcond_i64(TCG_COND_EQ, cmp, old, cmp);
     Z = tcg_temp_new();
     tcg_gen_trunc_i64_tl(Z, cmp);
-- 
2.49.0


