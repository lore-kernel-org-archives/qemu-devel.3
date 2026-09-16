Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDE2C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNk-0007bJ-Jd; Wed, 16 Sep 2026 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNI-0006kG-NZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:39 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNE-0001Qz-7A
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:30 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cebad4afso894859a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564105; x=1790168905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uw33vFrpnQVm7BsmlQfhOrzsbXCh8z/lnCOUlk8pdZw=;
 b=w46YHGrW6i6xDJVPCfyLBvEmwp3iE6bcxKwWLzs1SJw91yXQQx/dK50jTpkoDvpoCJ
 Jz3ee0rZx8GRYZEd7q2PMacI5qrrzsU+eU2wSqND0nt+s6QqHeS+zmnCosDVZQHb0nqt
 qjdWkHa/j8i4m+ji94pLqknlqttUfu8syEayJzjjFO2UNk54wZQF7c0vMch2/sJ5ers1
 7YNrwcpQuGTu5YR81+7T99NypIWt8C0KYHGMjcBFrVChEXX4phQOpjCJK0Ki1iOD+q0V
 rTJ9ulBqvf5uyT5HgNHjqkVy5J123MW6+WicjLOG1yKNG1VwIUKq8tAUTHS7PqE/2L8w
 2KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564105; x=1790168905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uw33vFrpnQVm7BsmlQfhOrzsbXCh8z/lnCOUlk8pdZw=;
 b=nBSIYFWkuCE5HbqEpH6VTmattKHWIQ4XS12P81EJWEOOg/ua5IV2g9AyM1fddVy1ui
 5wLk3WVz+XS0bwCghBB5a2FKThZ+ELzOnDTaRzwsdaix37dKlPArZskp98m0zmrKOuzX
 iKHGoGNkfFEcShtpUE58IoOl1efG0r0xtX3XYm2pb5uZsguM8cGHePjht1fRAs85X/GJ
 RCL7DPFuuyVyM1AJUXCxPdvWu5ZGRjuYgNT0QiGk7AGCWQPH/EjOCyXyfI0uSkWXBEYE
 0hM26D6HKekiTtsLIvpIBTfDVUjQdAmrTfWRRPR1G2y4jOcncQ9Ov/qvUyALXPzICJqW
 rBhg==
X-Gm-Message-State: AFuF++kHc3m8UphYWE6vVyMmdy8TQBeeKcbzmBcRlTLrUQaUvqbPaRur
 M1DLjAXyuoepaTLWT0TYezvl6bAjSiGFTYIk8YHs7wI9o6Qpldr1ZMbMjMOszBIAuUJvqBg7pdh
 +W4ex
X-Gm-Gg: AYBFou2wveP2JeaGOUYpdhqTsCbX3HjcAUsupBFWu/OQrQWwWYoBzn0nb9LQSqKGkk7
 TJ/A2hAkEMNJDPfjX5Zmu56sSzgPwXiBSwsXd+EH4qPUD6nLVS1/hXu3inDZrmneRmgPXDVldtM
 m6LhTiVIS16QZUxW3yI3ucufKN+hIFNkeaHy0LPnhUVESIIsFtk2ncAjGaWydXES6/QjO5880QP
 SI3+IpeN63ukN6R5Hvzzg/x1x10QinwEUj3j2Phmucr1adRhH3uFEv2ZKESjcy49YjWfIBS+h64
 fLboP+SS/w1hLkFDfT8FLyhn903oRrsMccjT+ajax7+bbY2VV961A2BeTQIBOojC8YurYMkximc
 +IDogZe0jCt+qUna3wfkVGyTZfoagnlFx3F/skGQ3TbenIK+OqyXFwOwEMaTSvkzX6j0SVvp0Kq
 ZQYWvjNOujPJzHbswnxcFBjshv6P8TFZ2Q0qg4OuWFxLG/77EJ4TJBxI4MX2cw5FEKU/Z0lcA2D
 R4rev4=
X-Received: by 2002:a17:90b:4a81:b0:39d:f773:37b5 with SMTP id
 98e67ed59e1d1-39e1df6193cmr6158599a91.0.1789564105091; 
 Wed, 16 Sep 2026 06:08:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 51/92] tcg: Generic expansion of tcg_gen_clz_*
Date: Wed, 16 Sep 2026 03:03:26 -1000
Message-ID: <20260916130409.3382710-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 54 +++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4d660ca2db8..d882bf5d0fc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 26583254111..202df7a62a8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(clz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6c106122f6c..714e279a453 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -496,6 +496,31 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        gen_op_ttt(INDEX_op_clz, type, dst, src1, src2);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_clz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_extu_i32_i64(t1, src1);
+        gen_extu_i32_i64(t2, src2);
+        gen_addi(TCG_TYPE_I64, t2, t2, 32);
+        gen_op_ttt(INDEX_op_clz, TCG_TYPE_I64, t1, t1, t2);
+        gen_extrl_i64_i32(dst, t1);
+        tcg_temp_free_internal(t1);
+        tcg_temp_free_internal(t2);
+        gen_subi(TCG_TYPE_I32, dst, dst, 32);
+    } else {
+        gen_helper_clz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -828,26 +853,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_clz, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t1, arg1);
-        tcg_gen_extu_i32_i64(t2, arg2);
-        tcg_gen_addi_i64(t2, t2, 32);
-        tcg_gen_clz_i64(t1, t1, t2);
-        tcg_gen_extrl_i64_i32(ret, t1);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_gen_subi_i32(ret, ret, 32);
-    } else {
-        gen_helper_clz_i32(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
@@ -1769,15 +1774,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_clz, ret, arg1, arg2);
-    } else {
-        gen_helper_clz_i64(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-- 
2.53.0


