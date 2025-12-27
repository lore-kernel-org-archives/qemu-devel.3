Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40CFE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQwz-0001rV-VY; Sat, 27 Dec 2025 04:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwg-0001a7-Dm
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwc-0007Nd-FZ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5I0xhi7xPfrYLsntJee5CeQ2dsdoBMj/DSXi3sRSBhc=;
 b=XUOSQBdgRXCSPB+efVm1iBe6za0ky0fyoPEY7iLibmkOBFm5Drs5qepZEOYwUTIRi+lWGY
 ZwCLnyeebq1YbWz7WVf2LdHaGAG1t0gVD72xPVob5pEvuQr5mWyh8RaK0o1Us5KtIpEZs8
 0ROZswHyPgC9t1XCHymdJWg23mQuKfk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-D6MZhz3wPFK8R1TQtIkLww-1; Sat, 27 Dec 2025 04:50:40 -0500
X-MC-Unique: D6MZhz3wPFK8R1TQtIkLww-1
X-Mimecast-MFC-AGG-ID: D6MZhz3wPFK8R1TQtIkLww_1766829039
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325b81081aso3890060f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829038; x=1767433838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5I0xhi7xPfrYLsntJee5CeQ2dsdoBMj/DSXi3sRSBhc=;
 b=CAho7ysR351nVYiBb2yw3WXK/2OdtnHP8ZFB5tB0W6PuzPq6/5b3/o9VlG+dYYOkfC
 EvB8gboGzjy4/BAEk8W06POJDm5zb+BurHDdQqikygaW06rH+LBLxvfvUnSQGEjhz3QV
 mDV6XbkHB6X3YUpaKT5HgEoAI1wIZ6uloo3izmitWx+qibLzW62eiA47+OzRWbTuYAIs
 vjL9v6U4yHo9Y7tLtGa3Djwgfa910gTTKGDTQCxdeJzliBfv3STSweB6C8/j8AUE8qsy
 kQtSe3cd6/lOgunzK25suOT+oMdD6Us/ehMPwBmXhjLq2UhaiCcWCO6ojkoi3xSN2+ok
 QZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829038; x=1767433838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5I0xhi7xPfrYLsntJee5CeQ2dsdoBMj/DSXi3sRSBhc=;
 b=a1/3XJHV9ato5ydlTu/ro21fthX0FuLygqk0cH6pSXQeopj8YNRuVu2rn7Ll04EWpI
 TMPU7ssDXFpCxjF58vniUnnlmJ5yOwAdfakUa9/A4hnpQDFGGHOkW7YhIR6NVwT+WTge
 ZipLPEs7GiG4bqIQbB02qQIUHzXgUqP15oHO9dAatc7ZjTSC1mIyhveQSatswQh3ZhNk
 zJTHDTsKXQoVds1cxxtyPkiw6udr4hnDjAVZoPN9fBISsOaivgWrC3IQrSThcr0wIlh7
 1hzKrqDoaPqUY/G+nA3I2K9pMokYJIAmOKslFJXALPK5kJ8ebscReIMdfh4Dhtgt3WjY
 ivKw==
X-Gm-Message-State: AOJu0YwhCG/53oPP9Qm4NK+rJnv7xgQMgzt/SqwYHKnOojaDEIQDlF2P
 m3/kbs7+KWdY5LGI+yMLjnOSUiI5qi11Qpwerefa+ihWwADBU+o2u7EsWhcNDouHEJyBiwQn0qY
 vE0JN2HPDfnFHpVOYHYBMT+ONBEo6l7KDGhjpy/hvJkn46XioVNnHXNSCx5g1ARHs+pksYsU+6y
 Dv3SOu2XffNMRmK5JNFHjLiBAcJ96spaNonx9HWUX6
X-Gm-Gg: AY/fxX4IqDjy8hIQq0VMSOvVIT824hvyYohTH2G/HC5xqxunuIAxLKhA8TE2HLj51+O
 NPTxCp7j1BSBrnCTKagDUDUTakHGu5/1rO67mnfDE4g2qdM50HOFfsXLr3KguIREy9FyTTYD6Wt
 QtqtYR0Tu+qr/DFM4lvAEMVx7EJZvl/o1pe8T2X/3Z2FtgXGnrwzvXgscGengJM02bpkWxRjOp5
 p52P8jl8IgiwFqkYkNbwpUFdJ4IgxilAgya28oIfrWKXu6e3Vl4PcoS3LuY8U5SwTXaEp0+mKBA
 sFOOZ3EyLOm/IcnHkYU8tnPnpG7x/1UhN8tltITX0iiuJsSadxeid0J0XDOr+EgQ80rQkzyZAoW
 5bNqm9fX+J2pEQ3GlGlobJbpth6h/5IieQ6g64WlJ4zfVVXLzpwneqVP7XexYoobLViSMjWElCU
 tU8N16Bu89m1I2PTc=
X-Received: by 2002:a05:6000:26d1:b0:430:f463:b6a7 with SMTP id
 ffacd0b85a97d-4324e50ec19mr32696656f8f.45.1766829037800; 
 Sat, 27 Dec 2025 01:50:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn+tVyfg9aBVxb40nwnEzdGsTuptiqJq0rsRAqxUD34bFM/+/k2M24QPqwCMwJjy5PGCw8pg==
X-Received: by 2002:a05:6000:26d1:b0:430:f463:b6a7 with SMTP id
 ffacd0b85a97d-4324e50ec19mr32696620f8f.45.1766829037262; 
 Sat, 27 Dec 2025 01:50:37 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2253csm50809253f8f.14.2025.12.27.01.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 129/153] target/i386/tcg: kill tmp2_i32
Date: Sat, 27 Dec 2025 10:47:34 +0100
Message-ID: <20251227094759.35658-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 122 +++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 50 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index dff7b615ef0..d3e5e4d8edb 100644
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
@@ -2649,6 +2662,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
     } else {
         /* register float ops */
         int opreg = rm;
+        TCGv_i32 t32;
 
         switch (op) {
         case 0x08: /* fld sti */
@@ -2911,8 +2925,9 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
         case 0x3c: /* df/4 */
             switch (rm) {
             case 0:
-                gen_helper_fnstsw(s->tmp2_i32, tcg_env);
-                tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
+                t32 = tcg_temp_new_i32();
+                gen_helper_fnstsw(t32, tcg_env);
+                tcg_gen_extu_i32_tl(s->T0, t32);
                 gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                 break;
             default:
@@ -2948,9 +2963,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
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
@@ -2969,6 +2985,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
     int modrm = s->modrm;
     MemOp ot;
     int reg, rm, mod, op;
+    TCGv_i32 t32;
     TCGv_i64 t64;
 
     /* now check op code */
@@ -3035,10 +3052,11 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
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
@@ -3057,10 +3075,11 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
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
@@ -3161,9 +3180,10 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
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
 
@@ -3176,11 +3196,12 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
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
@@ -3340,20 +3361,22 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
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
@@ -3745,7 +3768,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    dc->tmp2_i32 = tcg_temp_new_i32();
     dc->cc_srcT = tcg_temp_new();
 }
 
-- 
2.52.0


