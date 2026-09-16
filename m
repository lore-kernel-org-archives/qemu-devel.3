Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E5FC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNm-0007ho-FH; Wed, 16 Sep 2026 09:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNS-0006p4-CN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:44 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNP-0001TT-UX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:41 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0c89e33so552952a34.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564118; x=1790168918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cnwwh2NmhhmsnHifeT9ed9U4UJIzpka2Wgjf67Ch1YQ=;
 b=BE7jjegDQAQIdbqZs/ZK3lKU4sHuV/SoX+YcZPue85zD+azA5w/xSM8bj0j/Dw0k9L
 SiTuO54Cw2/QoT0rZGhhtJm8i+1Ve4tmFRclYOgcn/muHGCKvkB+A1o1L22Onr7HG1gt
 G0zjfY8JlGx1ppUm/BluBtBDQkwVu/c5h0uWEJui9+kHoyyZgqWPN/JrE3yFIkTxcRKR
 Izr94Oce9KmQBSRaaD/schMRJMX2P04A2M53QMIaKXIy4wI6V6612Q6ENG6IbDEzjlnb
 /joHvqmM2R0U4dxNmuPuh/X20RuyVZ1A+8esZlRPTPA/MR7uUZn/8Uup+V+5LJ64m5GF
 by2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564118; x=1790168918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cnwwh2NmhhmsnHifeT9ed9U4UJIzpka2Wgjf67Ch1YQ=;
 b=NsbSYJYStPX9FF2IxmT1kUEb2LLoJYQOuuc0BJOcqhyhyUuBscbEr32SDW3HwZI5x7
 sep/FRAmClvy0g1ZpFg9mHv/10OzX2JS7t4Hm+yExJmOwuUHSMfcNDbZpXs7GUBQynE3
 s7KJPqfTO06GlcZ+8TgR+tLMeIsVRvL7AenrnLZBVoNlFsk/0uBQoDDcqdjaCMz+vmLZ
 ifKtO8JkGjxoCSA0rWUCaBblyxyvj5onPDh4hPxAhP3mLxHcuEvSKNI8HdE8tqyhOFQb
 q1tAFZ/8rcAnB4Qf9aitd5XVmqFHpRXgOKL3BYmVAjKwhrEfMCk91u3PSW1QgHPveiGo
 nlBw==
X-Gm-Message-State: AFuF++mCsvAyjRaqjXiJkmmv8RhNnLAf98QMG32kiamYLslQeR5v3Pa9
 N42aDtzH/oxmEHykhctn2MSljXWrcqxc0pFyEHR8diah8B8MgZ+64xxiodbz1K0W5iwfxDHN7g3
 EgjUDGBs=
X-Gm-Gg: AYBFou2uY6e7D+vVzVD+3N0sAeY3xBxoRPaoEQ1JjLpOMtIZ9JHLgU98WkUOkSU3VD9
 jrf3JppgcbhqtUCvE02HDk5Up8fI3ah1obm8HtJVcXrMiaA1SWYMgnnyKSt76SBUV3yUm2LvTHH
 0fb6ZFYHpqZ4QfT4Yep/JLGniiuhDbdZkEg8IgvX5rKRCQitu05tPAMSZOA30w+gknEJ9Cb0ovh
 V2Cr4S6TrSF/rRs8nja5h0vtoEKXPuNS3oc6il6LD0piXQJNUHQoHOMSCmaZX4KHnFnz4PrpMCH
 BZiAD87AelbqguijTlK2eVUw4NENFwEd+3CvinmLjnDAWjTsEH+WYmbdUaz30I0JVqOzWp0UzoE
 2p6ekAmPXsw7/M0e2zGXM7+/ZqubOEsh0YtD8hGEYWjSnKTmJm3CRR6J6djGViJvBvuGkl2/uZY
 Yf/ESYVdy2XNe53iVwzBhabc226MiA9VOaFwtGBhpd3xbA2HqtXtz9+9f490MUF1Qkvpaivi4vi
 phygDSS+XLGfjYDYw==
X-Received: by 2002:a05:6820:4dc9:b0:6c4:6699:53cf with SMTP id
 006d021491bc7-6c7d45e6be6mr2521624eaf.49.1789564117635; 
 Wed, 16 Sep 2026 06:08:37 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 64/92] tcg: Generic expansion of tcg_gen_sextract_*
Date: Wed, 16 Sep 2026 03:03:39 -1000
Message-ID: <20260916130409.3382710-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0f.google.com
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
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 121 +++++++++++------------------------
 3 files changed, 38 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7973738331a..ceaa4b7fe01 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -134,8 +134,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -181,8 +179,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 856338aa0d4..21a941f5458 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -43,6 +43,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
+DEF4(sextract, TCGV, TCGV, unsigned, unsigned)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1f40f121239..51fda1409c1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -244,20 +244,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I32,
-                       tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
-}
-
-static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I64,
-                       tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -1041,6 +1027,43 @@ static void gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
     gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_sextract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                         unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        gen_sari(type, dst, src, width - len);
+        return;
+    }
+
+    if (TCG_TARGET_sextract_valid(type, ofs, len)) {
+        gen_op_ttii(INDEX_op_sextract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that sign-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_sextract_valid(type, 0, ofs + len)) {
+        gen_op_ttii(INDEX_op_sextract, type, dst, src, 0, ofs + len);
+        gen_sari(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_sextract_valid(type, 0, len)) {
+        gen_shri(type, dst, src, ofs);
+        gen_op_ttii(INDEX_op_sextract, type, dst, dst, 0, len);
+        return;
+    }
+
+    gen_shli(type, dst, src, width - len - ofs);
+    gen_sari(type, dst, dst, width - len);
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -1127,41 +1150,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_sari_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i32(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-    tcg_gen_sari_i32(ret, ret, 32 - len);
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1831,41 +1819,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if sextract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_sari_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i64(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-    tcg_gen_sari_i64(ret, ret, 64 - len);
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0


