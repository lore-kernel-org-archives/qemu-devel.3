Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3696DD3C54B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4j-000505-VD; Wed, 10 Dec 2025 08:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4O-0004rV-LT
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4L-0003K5-F1
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEDNmPZ0zIXe0E5Sxmqf03jGSC4VsBDfs+3B49NLyGA=;
 b=LBpCfEGVwrGlX0e5LGyWdqJhkjftQc8vMmjhJmsmOAp8h6ULMYI0bmbA5LWHYjODvcV05z
 t5CE4JF7Y1IVzBxUo5CCI16S1i6j4RLPaUSBnIaDg96BiBnuXHOh9oEWqStLdh5Mg4p56T
 Q6sTD5EOIcwi9m+eDc0P2rpzsEGslkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-FbWY5xUsPViswOvIKJBNLA-1; Wed, 10 Dec 2025 08:17:23 -0500
X-MC-Unique: FbWY5xUsPViswOvIKJBNLA-1
X-Mimecast-MFC-AGG-ID: FbWY5xUsPViswOvIKJBNLA_1765372642
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b5556d80bso5004833f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372642; x=1765977442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CEDNmPZ0zIXe0E5Sxmqf03jGSC4VsBDfs+3B49NLyGA=;
 b=fJCV6y2Kt7e5Tshbbvnd5C6tcFFXRX5DYRrTpiyZwJ2WHz8gb+CB7boQc5IsLuzzCO
 vNJ0oMzymCtwGDuCFuXuja6y7cPDNWe1AEfPIoz5eDUVchdhPn4OGVCYsDW8KL1VmZ3Y
 4l2keINIvVKfEDHjpdwWv6FDDCuwYoKo+HGwJ2phV1glzVUmZ52fqqjY0Rc+zyO3dPcR
 af5UA+TGyN2wpTi5qSR3BrBaYxp/kHyN3Xn/WnPpzuaDyYyhwusWfHmARrkMY/Abbnad
 10p3uY8cZ68i/1NMHZu0V1MpvkuOhiKX2iOA8RmWF/RDhPckRqZ+c8vk8NOeVIWvbaDo
 Fw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372642; x=1765977442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CEDNmPZ0zIXe0E5Sxmqf03jGSC4VsBDfs+3B49NLyGA=;
 b=oj1xhd5eWtlhnvKlxWaeJ+Od6M/6m+DaNJ08G4jOoiRfoX2n+UAFCBCF6HCC01yg0Q
 6WSdKZyKHVq9Y51CRUOqEl/J9idPZzIHvch3tQYRGxXQcxFIwDhiQXNflMEkTEOJAJJN
 74v90/sEGsVkHplE9q75zhtwPOhbHA91IHTCGs6osk+ZVx1pvq6SS6aqHpZmLLAKyQNK
 L6hGaQKGc/7ML9K9UtWT7QUNPaIs7AL+e2S4u/JtNA6jMzuLHESJoTI8MQQEV8tcLjg6
 SgbL6ZFec62i3oMtWLFUriLI8U1X63/by8RSc4opZh1dwdvS47vRLEf+edkR9tqUzRGu
 QmmA==
X-Gm-Message-State: AOJu0YzL8Chyumd5NfCUMD7wXvnthyJ3rfSafVWowRHF9waBgtDmqRDV
 XooN8H7v/foPoPi5F7zl8atnY1JTnFE7iuWW5N+Y6kuLNuydEvTqsN8/860/eb6tT15IQhTf79R
 g+K1iDZIHSVPboKi39YMHvhE8WHyj8YLNbqCw11LwzfX0JYNfARSEo0pRDGti/QzkC4zQtJbHkF
 XPdVIIMAFzATEpeCTmGnDK9mNjn1OpU864827KtZs4
X-Gm-Gg: AY/fxX4ItxV/WFFXlt1e/VYDCtQDoGxi0ZK+ZZAg3ENoyOBYfgguSQtFf75CpNsHgyS
 K6eucsX+j3t6Y2szy9GL3FIfruNvdqY/hYFvIm68GOzVw7YJkEHycwROSF9xovx00uD1il/SqVz
 b6hbLVh2nTYUWK2s9c4OkdtUgT1qEq5oZX9VsEpvGo/pOp3j3CLpbhfyTyCQvH2WkdUALkDP7Sg
 3O0eMZuBOyhywt78cyX9yWBv7QCnaFBpKrIAeIU0i5phMn0fnlRLnk2eHPCHbOc1k0UE3m0sleC
 30nHSgFaUQQy3bL4axRzCgsrVfJo4rIYFGUwnDFJ4Q96yadUow28fT0oZAH9YQPX3TWOy+Sy88N
 8GNPf2dkPOHFkRu/hSHxS9mPm8sDy6k1fmRBw0z49OoTkPUZCllSWjZUKZRddZ+sftKAtmdUWvG
 PkLB2qRu7nlQquNoI=
X-Received: by 2002:a05:6000:40dd:b0:427:697:c2db with SMTP id
 ffacd0b85a97d-42fa39d3ca1mr2872679f8f.20.1765372641485; 
 Wed, 10 Dec 2025 05:17:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8TqX94LSiKCRkw7+rkzRTj7wVl2dr4EIB9Nwm+uypfge23RmENtJDQBzCCzGmMPaV+l5iYw==
X-Received: by 2002:a05:6000:40dd:b0:427:697:c2db with SMTP id
 ffacd0b85a97d-42fa39d3ca1mr2872645f8f.20.1765372640896; 
 Wed, 10 Dec 2025 05:17:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2226c5sm38287932f8f.23.2025.12.10.05.17.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/18] target/i386/tcg: kill tmp2_i32
Date: Wed, 10 Dec 2025 14:16:50 +0100
Message-ID: <20251210131653.852163-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/tcg/translate.c | 121 +++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 50 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 108276f4008..e91715af817 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -134,9 +134,6 @@ typedef struct DisasContext {
     TCGv T0;
     TCGv T1;
 
-    /* TCG local register indexes (only used inside old micro ops) */
-    TCGv_i32 tmp2_i32;
-
     sigjmp_buf jmpbuf;
     TCGOp *prev_insn_start;
     TCGOp *prev_insn_end;
@@ -2455,6 +2452,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
         TCGv ea = gen_lea_modrm_1(s, decode->mem, false);
         TCGv last_addr = tcg_temp_new();
         bool update_fdp = true;
+        TCGv_i32 t32;
         TCGv_i64 t64;
 
         tcg_gen_mov_tl(last_addr, ea);
@@ -2462,16 +2460,18 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
 
         switch (op) {
         case 0x00 ... 0x07: /* fxxxs */
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_qemu_ld_i32(t32, s->A0,
                                 s->mem_index, MO_LEUL);
-            gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
+            gen_helper_flds_FT0(tcg_env, t32);
             gen_helper_fp_arith_ST0_FT0(op & 7);
             break;
 
         case 0x10 ... 0x17: /* fixxxl */
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_qemu_ld_i32(t32, s->A0,
                                 s->mem_index, MO_LEUL);
-            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+            gen_helper_fildl_FT0(tcg_env, t32);
             gen_helper_fp_arith_ST0_FT0(op & 7);
             break;
 
@@ -2484,21 +2484,24 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             break;
 
         case 0x30 ... 0x37: /* fixxx */
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_qemu_ld_i32(t32, s->A0,
                                 s->mem_index, MO_LESW);
-            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+            gen_helper_fildl_FT0(tcg_env, t32);
             gen_helper_fp_arith_ST0_FT0(op & 7);
             break;
 
         case 0x08: /* flds */
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_qemu_ld_i32(t32, s->A0,
                                 s->mem_index, MO_LEUL);
-            gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
+            gen_helper_flds_ST0(tcg_env, t32);
             break;
         case 0x18: /* fildl */
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_qemu_ld_i32(t32, s->A0,
                                 s->mem_index, MO_LEUL);
-            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+            gen_helper_fildl_ST0(tcg_env, t32);
             break;
         case 0x28: /* fldl */
             t64 = tcg_temp_new_i64();
@@ -2507,14 +2510,16 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             gen_helper_fldl_ST0(tcg_env, t64);
             break;
         case 0x38: /* filds */
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_qemu_ld_i32(t32, s->A0,
                                 s->mem_index, MO_LESW);
-            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+            gen_helper_fildl_ST0(tcg_env, t32);
             break;
 
         case 0x19: /* fisttpl */
-            gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
-            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            gen_helper_fisttl_ST0(t32, tcg_env);
+            tcg_gen_qemu_st_i32(t32, s->A0,
                                 s->mem_index, MO_LEUL);
             gen_helper_fpop(tcg_env);
             break;
@@ -2526,23 +2531,26 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             gen_helper_fpop(tcg_env);
             break;
         case 0x39: /* fisttps */
-            gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
-            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            gen_helper_fistt_ST0(t32, tcg_env);
+            tcg_gen_qemu_st_i32(t32, s->A0,
                                 s->mem_index, MO_LEUW);
             gen_helper_fpop(tcg_env);
             break;
 
         case 0x0a: case 0x0b: /* fsts, fstps */
-            gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
-            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            gen_helper_fsts_ST0(t32, tcg_env);
+            tcg_gen_qemu_st_i32(t32, s->A0,
                                 s->mem_index, MO_LEUL);
             if ((op & 7) == 3) {
                 gen_helper_fpop(tcg_env);
             }
             break;
         case 0x1a: case 0x1b: /* fistl, fistpl */
-            gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
-            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            gen_helper_fistl_ST0(t32, tcg_env);
+            tcg_gen_qemu_st_i32(t32, s->A0,
                                 s->mem_index, MO_LEUL);
             if ((op & 7) == 3) {
                 gen_helper_fpop(tcg_env);
@@ -2559,8 +2567,9 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             break;
 
         case 0x3a: case 0x3b: /* fists, fistps */
-            gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
-            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            gen_helper_fist_ST0(t32, tcg_env);
+            tcg_gen_qemu_st_i32(t32, s->A0,
                                 s->mem_index, MO_LEUW);
             if ((op & 7) == 3) {
                 gen_helper_fpop(tcg_env);
@@ -2572,9 +2581,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             update_fip = update_fdp = false;
             break;
         case 0x0d: /* fldcw mem */
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_qemu_ld_i32(t32, s->A0,
                                 s->mem_index, MO_LEUW);
-            gen_helper_fldcw(tcg_env, s->tmp2_i32);
+            gen_helper_fldcw(tcg_env, t32);
             update_fip = update_fdp = false;
             break;
         case 0x0e: /* fnstenv mem */
@@ -2583,8 +2593,9 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             update_fip = update_fdp = false;
             break;
         case 0x0f: /* fnstcw mem */
-            gen_helper_fnstcw(s->tmp2_i32, tcg_env);
-            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            gen_helper_fnstcw(t32, tcg_env);
+            tcg_gen_qemu_st_i32(t32, s->A0,
                                 s->mem_index, MO_LEUW);
             update_fip = update_fdp = false;
             break;
@@ -2606,8 +2617,9 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             update_fip = update_fdp = false;
             break;
         case 0x2f: /* fnstsw mem */
-            gen_helper_fnstsw(s->tmp2_i32, tcg_env);
-            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+            t32 = tcg_temp_new_i32();
+            gen_helper_fnstsw(t32, tcg_env);
+            tcg_gen_qemu_st_i32(t32, s->A0,
                                 s->mem_index, MO_LEUW);
             update_fip = update_fdp = false;
             break;
@@ -2638,10 +2650,11 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
         if (update_fdp) {
             int last_seg = s->override >= 0 ? s->override : decode->mem.def_seg;
 
-            tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
+            t32 = tcg_temp_new_i32();
+            tcg_gen_ld_i32(t32, tcg_env,
                            offsetof(CPUX86State,
                                     segs[last_seg].selector));
-            tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
+            tcg_gen_st16_i32(t32, tcg_env,
                              offsetof(CPUX86State, fpds));
             tcg_gen_st_tl(last_addr, tcg_env,
                           offsetof(CPUX86State, fpdp));
@@ -2903,8 +2916,9 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
         case 0x3c: /* df/4 */
             switch (rm) {
             case 0:
-                gen_helper_fnstsw(s->tmp2_i32, tcg_env);
-                tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
+                TCGv_i32 t32 = tcg_temp_new_i32();
+                gen_helper_fnstsw(t32, tcg_env);
+                tcg_gen_extu_i32_tl(s->T0, t32);
                 gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                 break;
             default:
@@ -2940,9 +2954,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
     }
 
     if (update_fip) {
-        tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        tcg_gen_ld_i32(t32, tcg_env,
                        offsetof(CPUX86State, segs[R_CS].selector));
-        tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
+        tcg_gen_st16_i32(t32, tcg_env,
                          offsetof(CPUX86State, fpcs));
         tcg_gen_st_tl(eip_cur_tl(s),
                       tcg_env, offsetof(CPUX86State, fpip));
@@ -2961,6 +2976,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
     int modrm = s->modrm;
     MemOp ot;
     int reg, rm, mod, op;
+    TCGv_i32 t32;
     TCGv_i64 t64;
 
     /* now check op code */
@@ -3027,10 +3043,11 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
+                t32 = tcg_temp_new_i32();
                 gen_svm_check_intercept(s, SVM_EXIT_LDTR_WRITE);
                 gen_ld_modrm(s, decode, MO_16);
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_lldt(tcg_env, s->tmp2_i32);
+                tcg_gen_trunc_tl_i32(t32, s->T0);
+                gen_helper_lldt(tcg_env, t32);
             }
             break;
         case 1: /* str */
@@ -3049,10 +3066,11 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
+                t32 = tcg_temp_new_i32();
                 gen_svm_check_intercept(s, SVM_EXIT_TR_WRITE);
                 gen_ld_modrm(s, decode, MO_16);
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_ltr(tcg_env, s->tmp2_i32);
+                tcg_gen_trunc_tl_i32(t32, s->T0);
+                gen_helper_ltr(tcg_env, t32);
             }
             break;
         case 4: /* verr */
@@ -3153,9 +3171,10 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
+            t32 = tcg_temp_new_i32();
             t64 = tcg_temp_new_i64();
-            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xgetbv(t64, tcg_env, s->tmp2_i32);
+            tcg_gen_trunc_tl_i32(t32, cpu_regs[R_ECX]);
+            gen_helper_xgetbv(t64, tcg_env, t32);
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], t64);
             break;
 
@@ -3168,11 +3187,12 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (!check_cpl0(s)) {
                 break;
             }
+            t32 = tcg_temp_new_i32();
             t64 = tcg_temp_new_i64();
             tcg_gen_concat_tl_i64(t64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xsetbv(tcg_env, s->tmp2_i32, t64);
+            tcg_gen_trunc_tl_i32(t32, cpu_regs[R_ECX]);
+            gen_helper_xsetbv(tcg_env, t32, t64);
             /* End TB because translation flags may change.  */
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
@@ -3332,20 +3352,22 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
+            t32 = tcg_temp_new_i32();
             t64 = tcg_temp_new_i64();
-            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_rdpkru(t64, tcg_env, s->tmp2_i32);
+            tcg_gen_trunc_tl_i32(t32, cpu_regs[R_ECX]);
+            gen_helper_rdpkru(t64, tcg_env, t32);
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], t64);
             break;
         case 0xef: /* wrpkru */
             if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
+            t32 = tcg_temp_new_i32();
             t64 = tcg_temp_new_i64();
             tcg_gen_concat_tl_i64(t64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_wrpkru(tcg_env, s->tmp2_i32, t64);
+            tcg_gen_trunc_tl_i32(t32, cpu_regs[R_ECX]);
+            gen_helper_wrpkru(tcg_env, t32, t64);
             break;
 
         CASE_MODRM_OP(6): /* lmsw */
@@ -3737,7 +3759,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    dc->tmp2_i32 = tcg_temp_new_i32();
     dc->cc_srcT = tcg_temp_new();
 }
 
-- 
2.52.0


