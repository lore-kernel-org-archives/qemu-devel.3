Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6381FC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB9-00035X-E6; Sat, 12 Sep 2026 22:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB5-0002mz-Ph
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:47 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB4-0001vn-2D
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:47 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so670781a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267364; x=1789872164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9BpIbWocc+q+gVfGusICwI/TPJiwGUK4uLCUNOnxvy4=;
 b=uOCa4W+2wEnW3496+P25LsRrpPPqVHNNpNIgO6qa5QWzIX+N1/ThYWNVJLLlfbJSDd
 5pkbcUGQcNO2lkXQicJhRu4XvdrH+Q2LdKfUxDDbHaq0xNo1s19Mo7OG6ikJdZaaTmbz
 5cwf98+HL4/hV+qAXf384YbWGh5+6aZxRPaOEe16FbRx4n4FLX9qMlhMxzUZwnGyheGB
 xFO9smhn7e0BcPAx25Z8CaE0Bzyyhm6mGOmDB/dEtJaDv2xA3taag9U1eBlEPgoGm/FI
 DGpvTM/feRWHMRaeHsxKm/r+wyGdvvakoV8yANx+R/auI1IRBc+wlr44/4Cj878YBQo/
 tViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267364; x=1789872164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9BpIbWocc+q+gVfGusICwI/TPJiwGUK4uLCUNOnxvy4=;
 b=ASe2XpkJvK8BiZmqsSXi6diKIGGvR2B6dQlFzMLpbd7PA+J3PI2xoBkxGZIdibO90y
 SBgrGhF4YWdIo4XbavI7CxxzyxkS2rrEpaf5RtZgh5eNSwl5/dSmH99GR6yMj7VenvE8
 4/hRZDGTTmm8Y9n4TSYq19c6RZJsuajvHtECGsd05EkuLanPgqiA75flJzBwJEKUkNIq
 wFJTHYO9FDbwXAf7FtVIMMEffic8Zr20wxZ02AGhIXSfBeXhq2TMPBEt0ynUM4Fk3zXp
 0Em03nqrhw/5G6h5wnwWab5R+lpJ6cfYbngqaFU/IkEyEhshcH06HXqUSqZJowOSCCyI
 jJ+Q==
X-Gm-Message-State: AFuF++nBzHZ2TXoguyhY7lp7T3bJtDOkbUhpr56yKxro5fjKS7H1f+Vf
 pgmZGkd7BTsQle9i3YJniamGPbukqpX+UUF+P3m4PN84CYQ6bQWjvdY2OHx9dbDryMcHUEwvDLn
 v70rsjLA=
X-Gm-Gg: AYBFou1CKbX5XvWcDT6lH6GMGkQE+hnU8fdYrHKkEnd4JHGhYbTveBhPiKjsdv8L0tL
 hPmGr6297D9vO4OBa/8UaOzvk1g1QbgoPvJRx38QFtJP6ECTQbg45OFY1o/n65mROXzDEH04jNL
 jwv04US4APUTptpVqeCiJhTDikIRyL+DU+6fWCVvlj4rMGfPpJ1d4Un2ahxFUpCCgyu/rCxyyHg
 3qtm/oq9W17apVGDf49sIRGtjBqbnap0r7yxni/eSFyvXW7cYxqolRfMJahrRRai9XfpmE+aiEt
 0xcPN3aY0y0I2engGTfqkb8t8hSNIg65HgZivc+ZA/LyvGRJOV+upirdGp3UjeJGS31qVB5zISF
 qQpRjT091NLNWudyxI7BQeBhk7p3E/Czqt0GDrCjft4I1OmBYckjSx9i5mYoCGOqbwStngT2XFV
 9nqfhzu8gBy0IShetFNrIU/vOi7xVRlP2SdtHNjc3SeFG3IN2bMvG+EomWD4+qQbjPwCiDiGf1d
 OwEY/U=
X-Received: by 2002:a05:6a21:4d02:b0:3d3:ae40:51e2 with SMTP id
 adf61e73a8af0-3db0e485b92mr10487400637.22.1789267364402; 
 Sat, 12 Sep 2026 19:42:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 58/86] tcg: Generic expansion of tcg_gen_rotli_*
Date: Sat, 12 Sep 2026 16:38:09 -1000
Message-ID: <20260913023837.741866-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 39 ++++++++++++++----------------------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 825ba2d3afc..97cb28b7100 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -181,7 +180,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 383a13aa1e9..57d6f07b907 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5034f1a6f0b..023ab2fa7cb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -872,6 +872,21 @@ static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else {
+        gen_rotri(type, dst, src1, width - src2);
+    }
+}
+
 static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
@@ -1013,18 +1028,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
-    } else {
-        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1787,18 +1790,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
-    } else {
-        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


