Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA40ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sninL-00048G-CS; Mon, 09 Sep 2024 14:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninK-00041j-Dj
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:22 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninI-0001x6-80
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso4030058b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725905239; x=1726510039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ0Im01ChiVkI224aNYB6IdOScm3+XFT2X0U0HEizfM=;
 b=zqe8XYeUv1iEHtOWOoAGjS1wdqrGL4h6cg8u1/EPKIplwxYqOFTXrpIxOEh52ObewJ
 f7261LaoiLaCr0YQUuyU++3mO+OjPH21ekeNr7bUpFjHM9JUaSn8NnyQgMS1ArTmSHV1
 UsXBqfUNpIsYVqU0ab9g8yIgfbB/uTS21fJV9uMW7Wi7InPAYyFN5RIGFFNO1UzZjztX
 onTTSuG4CuAXN+jDNSZpvaYkE9kUeVazdFt2HC9szOL0AMpC/MUIeGV9P1ofCgIL/4f1
 NG2XE3n3RcltkkGfy4qu/yZeZ+Kvjsgw2+7VNOZTTpph06mKaUx5h6KdgHJTgOMz5KVA
 7lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725905239; x=1726510039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZ0Im01ChiVkI224aNYB6IdOScm3+XFT2X0U0HEizfM=;
 b=Q/MQa4HDwFKtOqz3bqrbdorjhHbmAtHkpCDDKWVRvz/iPAluW906UUzx6kYajdczJh
 Z4sofNSIVN4W8UY5Glfv8WrbKSm0PLOxx1iRNSqnwjtBcxfB81X0JpCQmT/QFuTGVChg
 zf23rycabWi1//sOyFKoyOeg4YRWwgHjmCS9tlFBziSYG9Jw3YCQutVfCB5SmbxY/Mpa
 0gOIXzfRLEonN0grevw+QSea6RPDuEpqPIoPi+iF7wb6Hh0v5wP7MGHNa/Yd7yJU3/ST
 ZDqnYyoa9heDXWw6KMYjwwkebBlUU2T4fUqdNUpJ4vzGTVH7CRGHmt339M2twDEeUX3K
 KziQ==
X-Gm-Message-State: AOJu0YymF0ByD8aDP6wWTbvzfr2p1cXj5BKZ46Jsx2wiNHUHk4312JfD
 zKTYgdL8lV2ndNG7hQlstbyVoK/6p0ZVgR5DDWsOACeDmi5y/VsT2NQponGmNcmDSQY/hQ0fukU
 p
X-Google-Smtp-Source: AGHT+IFpfk9Y6uBYltpVm4D8gh8DAcS6Buw2HqEkzLQfQpJ3VXBzvUvobNxvPtG0hFoH2VLR2WFGyw==
X-Received: by 2002:a05:6a00:139d:b0:706:6af8:e08a with SMTP id
 d2e1a72fcca58-718d5ded05emr19017290b3a.2.1725905238526; 
 Mon, 09 Sep 2024 11:07:18 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc84efsm25431b3a.8.2024.09.09.11.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 11:07:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	chauser@pullman.com
Subject: [PATCH v4 5/5] target/sparc: Add gen_trap_if_nofpu_fpexception
Date: Mon,  9 Sep 2024 11:07:12 -0700
Message-ID: <20240909180712.651651-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909180712.651651-1-richard.henderson@linaro.org>
References: <20240909180712.651651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Model fp_exception state, in which only fp stores are allowed
until such time as the FQ has been flushed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 90 +++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b80f071533..cdd0a95c03 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1465,15 +1465,48 @@ static void gen_op_fpexception_im(DisasContext *dc, int ftt)
     gen_exception(dc, TT_FP_EXCP);
 }
 
-static int gen_trap_ifnofpu(DisasContext *dc)
+static bool gen_trap_ifnofpu(DisasContext *dc)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!dc->fpu_enabled) {
         gen_exception(dc, TT_NFPU_INSN);
-        return 1;
+        return true;
     }
 #endif
-    return 0;
+    return false;
+}
+
+static bool gen_trap_iffpexception(DisasContext *dc)
+{
+#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+    /*
+     * There are 3 states for the sparc32 fpu:
+     * Normally the fpu is in fp_execute, and all insns are allowed.
+     * When an exception is signaled, it moves to fp_exception_pending state.
+     * Upon seeing the next FPop, the fpu moves to fp_exception state,
+     * populates the FQ, and generates an fp_exception trap.
+     * The fpu remains in fp_exception state until FQ becomes empty
+     * after execution of a STDFQ instruction.  While the fpu is in
+     * fp_exception state, and FPop, fp load or fp branch insn will
+     * return to fp_exception_pending state, set FSR.FTT to sequence_error,
+     * and the insn will not be entered into the FQ.
+     *
+     * In QEMU, we do not model the fp_exception_pending state and
+     * instead populate FQ and raise the exception immediately.
+     * But we can still honor fp_exception state by noticing when
+     * the FQ is not empty.
+     */
+    if (dc->fsr_qne) {
+        gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
+        return true;
+    }
+#endif
+    return false;
+}
+
+static bool gen_trap_if_nofpu_fpexception(DisasContext *dc)
+{
+    return gen_trap_ifnofpu(dc) || gen_trap_iffpexception(dc);
 }
 
 /* asi moves */
@@ -2643,7 +2676,7 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
 {
     DisasCompare cmp;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     gen_fcompare(&cmp, a->cc, a->cond);
@@ -4482,7 +4515,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (addr == NULL) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (sz == MO_128 && gen_trap_float128(dc)) {
@@ -4510,6 +4543,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (addr == NULL) {
         return false;
     }
+    /* Store insns are ok in fp_exception_pending state. */
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4576,7 +4610,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
     if (addr == NULL) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4600,7 +4634,7 @@ static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri *a, bool entire)
     if (addr == NULL) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4637,6 +4671,7 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
     if (addr == NULL) {
         return false;
     }
+    /* Store insns are ok in fp_exception_pending state. */
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4679,7 +4714,7 @@ static bool do_ff(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i32 tmp;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4720,7 +4755,7 @@ static bool do_env_ff(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i32 tmp;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4740,7 +4775,7 @@ static bool do_env_fd(DisasContext *dc, arg_r_r *a,
     TCGv_i32 dst;
     TCGv_i64 src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4760,7 +4795,7 @@ static bool do_dd(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i64 dst, src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4782,7 +4817,7 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i64 dst, src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4822,7 +4857,7 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
     TCGv_i64 dst;
     TCGv_i32 src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4865,7 +4900,7 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i128 t;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4886,7 +4921,7 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
     TCGv_i128 src;
     TCGv_i32 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4909,7 +4944,7 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     TCGv_i128 src;
     TCGv_i64 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4932,7 +4967,7 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
     TCGv_i32 src;
     TCGv_i128 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4955,10 +4990,7 @@ static bool do_env_qd(DisasContext *dc, arg_r_r *a,
     TCGv_i64 src;
     TCGv_i128 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
-        return true;
-    }
-    if (gen_trap_float128(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5015,7 +5047,7 @@ static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
 {
     TCGv_i32 src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5224,7 +5256,7 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
 {
     TCGv_i64 dst, src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5248,7 +5280,7 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
     TCGv_i64 dst;
     TCGv_i32 src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (!(dc->def->features & CPU_FEATURE_FSMULD)) {
@@ -5357,7 +5389,7 @@ static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
 {
     TCGv_i128 src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -5381,7 +5413,7 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
     TCGv_i64 src1, src2;
     TCGv_i128 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -5471,7 +5503,7 @@ static bool do_fcmps(DisasContext *dc, arg_FCMPs *a, bool e)
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5495,7 +5527,7 @@ static bool do_fcmpd(DisasContext *dc, arg_FCMPd *a, bool e)
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5519,7 +5551,7 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
-- 
2.43.0


