Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD67C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Gn4-0006ex-AX; Thu, 03 Apr 2025 05:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmy-0006dR-NN
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gms-0007pT-Of
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743672180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9it+dbGjHPQhJx2g2te9B2/y9Eh+k2lxoD9stIBovM=;
 b=a2ycAKP2+Hl1yWLfvNdeKX2Zv/6tX9TpEnP1ISqgputtC+L2kCXpvGnOpyqElZaOYyHaih
 S2gxJBepfxheY03ob+aSQ+F0nPIBr10lPc31jCqBsInnRd1GnvJswKjb/Ag60SX2kwFEKD
 RgrlY/8VCr1UjGgiU8UhJ2AWIfa1hBo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-LTMGOlnGN0idy2_6dtAq8g-1; Thu, 03 Apr 2025 05:22:58 -0400
X-MC-Unique: LTMGOlnGN0idy2_6dtAq8g-1
X-Mimecast-MFC-AGG-ID: LTMGOlnGN0idy2_6dtAq8g_1743672177
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac737973c9bso52187766b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 02:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743672177; x=1744276977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9it+dbGjHPQhJx2g2te9B2/y9Eh+k2lxoD9stIBovM=;
 b=YKlpLcVic8yxaVjiH53TNopF5+MeY5/Dpb0MfBj/nC43LQsXqmtQQVFtxUzrnhIzMk
 VDpG76Lq64LtV3HNDi0ErcMPL+wkwZadAQoWowE2zlf5WVE6CdBVH3cfoZRSJXOsST5/
 CPNY38j2PrSlsQx99teYc3ztyltJGHC59e+op5f7SlPXBLq749nLs+V6PqZ/QSUogIA8
 BxFQ4tlq8OIEJX8BEmgqeVMnms/acREFvGcKUiAlKZczXKNbd/a+bR65bq65UJTOOOaA
 DdNEeX2NBDzNgd2cL978mas769ejnJVmH3eKOVkFLu0G/YKc7z55zS4wVh5aTVleeHDH
 LxnA==
X-Gm-Message-State: AOJu0YwFn31L5gCabzqjnWj6nBMZ8blApJN0Fkih+eKiBX+RrF9U39hU
 V7grMFncT4Uaeh/oetMEq9LFjs++ATwzh1ov5tuOGR6RTub8mr64s1DtFFn7oya8lG57amih6fm
 Sf0ZhJCOkkcyaaY0xPVcRrkAiewH6zutlDO7dUuHTM3viszyTJSLgb5iARljl8yi2nEkYua4ys/
 9GDplwcLJk8rP88MVRTiFKIYgljB3GEhvNzx47
X-Gm-Gg: ASbGncvmwm03RpUN+94HpjJgaOxfBRdh3jvtLu9ynDWhVVBZulT5lQmE6AWPo0cKiKH
 3wnuIUXOX61w3sVz/DCHGxUNUptbBIam3EjVXVtB3BvdAES7wetf+dFcJj6WL4tBPIeGla2fabA
 ZMesoDRonlxCgys2wlh46Ik6FTCrl6REuLCOmLTLdKcAqUXw4i16REvHqr3J1FsM/9f7iu89AAW
 VF/ruRJ6JhfKaLDtv5jvgc9wFjX/6rEYp7up8hdFx9tad+EG7ZMVthFaxOqXrRnUy/0E9Ts0YJH
 7VsnV9zBo6/MbSMkiR1b
X-Received: by 2002:a17:907:2d27:b0:ac7:391b:e685 with SMTP id
 a640c23a62f3a-ac7bc272e2fmr158848066b.59.1743672176797; 
 Thu, 03 Apr 2025 02:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz59ZU1heNLgZEOviLvRiZ+nA9NSMNiYfJyEGd9JZ3ueltlidOUixYYqyysE+DX3/6XWslfQ==
X-Received: by 2002:a17:907:2d27:b0:ac7:391b:e685 with SMTP id
 a640c23a62f3a-ac7bc272e2fmr158845666b.59.1743672176232; 
 Thu, 03 Apr 2025 02:22:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5c5e9sm62964066b.5.2025.04.03.02.22.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 02:22:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/i386: tcg: remove tmp0 and tmp4 from SHLD/SHRD
Date: Thu,  3 Apr 2025 11:22:48 +0200
Message-ID: <20250403092251.54441-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403092251.54441-1-pbonzini@redhat.com>
References: <20250403092251.54441-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Apply some of the simplifications used for RCL and RCR.  tmp4 is not
used anywhere else, so remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 51 +++++++++++++++++++++----------------
 target/i386/tcg/emit.c.inc  |  6 ++---
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index aee33428989..5529327680d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -135,7 +135,6 @@ typedef struct DisasContext {
 
     /* TCG local register indexes (only used inside old micro ops) */
     TCGv tmp0;
-    TCGv tmp4;
     TCGv_i32 tmp2_i32;
     TCGv_i32 tmp3_i32;
     TCGv_i64 tmp1_i64;
@@ -1580,10 +1579,13 @@ static bool check_cpl0(DisasContext *s)
 }
 
 /* XXX: add faster immediate case */
-static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
+static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
                              bool is_right, TCGv count)
 {
     target_ulong mask = (ot == MO_64 ? 63 : 31);
+    TCGv cc_src = tcg_temp_new();
+    TCGv tmp = tcg_temp_new();
+    TCGv hishift;
 
     switch (ot) {
     case MO_16:
@@ -1591,9 +1593,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
            This means "shrdw C, B, A" shifts A:B:A >> C.  Build the B:A
            portion by constructing it as a 32-bit value.  */
         if (is_right) {
-            tcg_gen_deposit_tl(s->tmp0, s->T0, s->T1, 16, 16);
+            tcg_gen_deposit_tl(tmp, s->T0, s->T1, 16, 16);
             tcg_gen_mov_tl(s->T1, s->T0);
-            tcg_gen_mov_tl(s->T0, s->tmp0);
+            tcg_gen_mov_tl(s->T0, tmp);
         } else {
             tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
         }
@@ -1604,47 +1606,53 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
     case MO_32:
 #ifdef TARGET_X86_64
         /* Concatenate the two 32-bit values and use a 64-bit shift.  */
-        tcg_gen_subi_tl(s->tmp0, count, 1);
+        tcg_gen_subi_tl(tmp, count, 1);
         if (is_right) {
             tcg_gen_concat_tl_i64(s->T0, s->T0, s->T1);
-            tcg_gen_shr_i64(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shr_i64(cc_src, s->T0, tmp);
             tcg_gen_shr_i64(s->T0, s->T0, count);
         } else {
             tcg_gen_concat_tl_i64(s->T0, s->T1, s->T0);
-            tcg_gen_shl_i64(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shl_i64(cc_src, s->T0, tmp);
             tcg_gen_shl_i64(s->T0, s->T0, count);
-            tcg_gen_shri_i64(s->tmp0, s->tmp0, 32);
+            tcg_gen_shri_i64(cc_src, cc_src, 32);
             tcg_gen_shri_i64(s->T0, s->T0, 32);
         }
         break;
 #endif
     default:
-        tcg_gen_subi_tl(s->tmp0, count, 1);
+        hishift = tcg_temp_new();
+        tcg_gen_subi_tl(tmp, count, 1);
         if (is_right) {
-            tcg_gen_shr_tl(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shr_tl(cc_src, s->T0, tmp);
 
-            tcg_gen_subfi_tl(s->tmp4, mask + 1, count);
+            /* mask + 1 - count = mask - tmp = mask ^ tmp */
+            tcg_gen_xori_tl(hishift, tmp, mask);
             tcg_gen_shr_tl(s->T0, s->T0, count);
-            tcg_gen_shl_tl(s->T1, s->T1, s->tmp4);
+            tcg_gen_shl_tl(s->T1, s->T1, hishift);
         } else {
-            tcg_gen_shl_tl(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shl_tl(cc_src, s->T0, tmp);
+
             if (ot == MO_16) {
                 /* Only needed if count > 16, for Intel behaviour.  */
-                tcg_gen_subfi_tl(s->tmp4, 33, count);
-                tcg_gen_shr_tl(s->tmp4, s->T1, s->tmp4);
-                tcg_gen_or_tl(s->tmp0, s->tmp0, s->tmp4);
+                tcg_gen_subfi_tl(tmp, 33, count);
+                tcg_gen_shr_tl(tmp, s->T1, tmp);
+                tcg_gen_or_tl(cc_src, cc_src, tmp);
             }
 
-            tcg_gen_subfi_tl(s->tmp4, mask + 1, count);
+            /* mask + 1 - count = mask - tmp = mask ^ tmp */
+            tcg_gen_xori_tl(hishift, tmp, mask);
             tcg_gen_shl_tl(s->T0, s->T0, count);
-            tcg_gen_shr_tl(s->T1, s->T1, s->tmp4);
+            tcg_gen_shr_tl(s->T1, s->T1, hishift);
         }
-        tcg_gen_movi_tl(s->tmp4, 0);
-        tcg_gen_movcond_tl(TCG_COND_EQ, s->T1, count, s->tmp4,
-                           s->tmp4, s->T1);
+        tcg_gen_movcond_tl(TCG_COND_EQ, s->T1,
+                           count, tcg_constant_tl(0),
+                           tcg_constant_tl(0), s->T1);
         tcg_gen_or_tl(s->T0, s->T0, s->T1);
         break;
     }
+
+    return cc_src;
 }
 
 #define X86_MAX_INSN_LENGTH 15
@@ -3768,7 +3776,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
     dc->tmp3_i32 = tcg_temp_new_i32();
-    dc->tmp4 = tcg_temp_new();
     dc->cc_srcT = tcg_temp_new();
 }
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 76cd7f00308..bb3e76f5110 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4011,8 +4011,7 @@ static void gen_SHLD(DisasContext *s, X86DecodedInsn *decode)
     }
 
     decode->cc_dst = s->T0;
-    decode->cc_src = s->tmp0;
-    gen_shiftd_rm_T1(s, ot, false, count);
+    decode->cc_src = gen_shiftd_rm_T1(s, ot, false, count);
     if (can_be_zero) {
         gen_shift_dynamic_flags(s, decode, count, CC_OP_SHLB + ot);
     } else {
@@ -4064,8 +4063,7 @@ static void gen_SHRD(DisasContext *s, X86DecodedInsn *decode)
     }
 
     decode->cc_dst = s->T0;
-    decode->cc_src = s->tmp0;
-    gen_shiftd_rm_T1(s, ot, true, count);
+    decode->cc_src = gen_shiftd_rm_T1(s, ot, true, count);
     if (can_be_zero) {
         gen_shift_dynamic_flags(s, decode, count, CC_OP_SARB + ot);
     } else {
-- 
2.49.0


