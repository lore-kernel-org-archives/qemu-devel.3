Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B33C9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksG-0006s8-Sw; Sun, 27 Sep 2026 05:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrT-0002Ei-1L
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:58 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrP-0008Gu-LL
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:53 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2df4aa80a73so11766685ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500070; x=1791104870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiL/W+aVYvVi37G+y8gfUdyGZ/lxujHcsa9u0ASXM4k=;
 b=IJZryVyhf/MNJD+a80piMRgTr/sO2rnDe+TRrXjVFw+8mlkGTTS3NkN6FEdl7inxnw
 RJo4ilIM3kipwGIiTY8Jw3L20cYDAtihFmj4x6/KqAJgvkkB+WDS1z14R//9pYTwH4Gu
 UqvPcvNWZ/t7dE2YWXn/EB+vYMZLf1pfZswKvxcSe8SrVYE0PNPTJ3aytNuspsf3QwBl
 NDn/KYoivx79HI67aHGVWKs1g+KqRXvzvtRz5pTr6jHtVT5lpS/UrHHgZnrXhyTtR1L0
 AhBlwzLhJAfgSonRDW4kVFSPagGst49yFbGcmFJqwr1WahhmbF8iD6lUFe8rHySJpm4W
 NS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500070; x=1791104870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiL/W+aVYvVi37G+y8gfUdyGZ/lxujHcsa9u0ASXM4k=;
 b=g5WGO04FqkYdOBfMRISjBcJU1ZM2ToxQynyaMV4YQVErhVKc50GtGwmZ/Z/4VfcigZ
 CJLJTwunA3fzLV1jj5s0jc4wJU2k25XGLJWc8HtsI/mqFTBKTvlUBtBcakf6RruyfTlp
 aDqdiHQ9l46FvximIGg3mzQJ70v4mtCuwRRTxvDcvh8YkFarOOWWQGvDrI/BMyrIlE6/
 ARszFSgDUJAJGCgZwxRkPAadz1omQBrNDqZ3UuF2V/tj8buY8nATIukE4xknxcYjzN/M
 lS7luCXWPBzKHRxcuoZfhFvdCgNdn8Al6qYA3LuFl7GsQOSNCW421SCRrIWqOcIxbDN6
 FOcw==
X-Gm-Message-State: AFq9FYIhjNs2fPYaU6b6zdDuRaFM12LwxupsNsEFdEMrml4irAPkFo0q
 fasRjVToY9ENBlVBuEvMiI9YBN3p0Tv+MblLN5/crQ+d0yF2W5P5qNSuLsPOsKLSQMZGI5esKbl
 af9uU
X-Gm-Gg: AYBFou2YNbDunvrvbBguNikxB8lD9mhWVnYlPkGMChFLEY7m7mF2JmjBgQnZ/6+Hcu+
 YuQUBprWzlu1wwgfq3Pxu4l1kJ1s3hUPQy+G3H/UuOdhCF314tkFPH2V8+dQHO0Zy7ipigm/1YX
 mIfcTRReeXdA+RcWZVea+DG3ZeS3q/QIiJIiuuUP6/OCZweEHi6jiiEBW6OAdLSGl5b241LBHb5
 JkvC+JQzjBB/3L7Hts4WMrnAyy+qPdC5JpTalYTc6ohroTdyKHEy1sMfame7Bb7BkWC4/eg/m5d
 YJxNEE3/c75vGvApEhP/8zepFBmdc7z6EBKHYIJfh7ewmRRxjU212oxrjWuQh2xn6El7CGedkLw
 bQEqxx/iFCvf/VzgDX5Mzm2/kfWdS3/lJJX4H23M0OkXpjLj/rjkzfqwACp/Fv3kTnejhvpWr0c
 CVK40mKrK4Fpmnj7vQ8UgwpSk9LIXA96CVZ7SObXaXi7lp4lBezP8j+4Rp+HAEjWgqPPH96M5AI
 DLlBtMcRGnGrk+cO4NT90dMyJnp1w==
X-Received: by 2002:a17:90b:3b4e:b0:3a1:ef0b:5a0a with SMTP id
 98e67ed59e1d1-3a1ef0b5e90mr1288856a91.23.1790500070183; 
 Sun, 27 Sep 2026 02:07:50 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 088/101] tcg: Generic expansion of tcg_gen_ld_*
Date: Sun, 27 Sep 2026 01:59:58 -0700
Message-ID: <20260927090011.10724-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 tcg/tcg-internal.h           |  6 ++++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 19 +++++++++----------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ed503462a2e..b7c31ad6c8c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -176,7 +175,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d6ea11d8fcd..bfd34905ee7 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -191,13 +191,15 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
-#define TCGV  TCGTemp *
-#define TINT  int64_t
+#define TCGV      TCGTemp *
+#define TINT      int64_t
+#define TCGv_ptr  TCGTemp *
 
 #include "tcg/tcg-op-def.h.inc"
 
 #undef TINT
 #undef TCGV
+#undef TCGv_ptr
 
 #undef DEF1
 #undef DEF2
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ab1bf259296..6284358a132 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -31,6 +31,7 @@ DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
+DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 17f323b1b72..4d6838e8dc3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -240,11 +240,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
+#define C_TCGv_ptr      tcgv_ptr_temp
 #define C_int32_t
 #define C_int64_t
 #define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_tcg_target_long
 #define C_unsigned
 
 #define TCGV  glue(TCGv,TExt)
@@ -271,11 +273,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef C_TCGv_i32
 #undef C_TCGv_i64
+#undef C_TCGv_ptr
 #undef C_int32_t
 #undef C_int64_t
 #undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_tcg_target_long
 #undef C_unsigned
 
 #undef DEF1
@@ -767,6 +771,11 @@ void tcg_gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *hi,
     }
 }
 
+void tcg_gen_ld(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1392,11 +1401,6 @@ void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1445,11 +1449,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
-- 
2.53.0


