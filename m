Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFA7C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOM-0000S8-KD; Wed, 16 Sep 2026 09:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNX-0006wk-5d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:47 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNU-0001Vj-IQ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:46 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae7166edso731940eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564123; x=1790168923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mj4YDzukAqHAZD+kr7qud+JL0iR+gcVcf8N+HV0aXys=;
 b=OgdZOlhikU1MkX2bZBosZTHYnNFnSnjH5hoysc18lgbQH11e4TdOEpovcwSieZjAFd
 E1GrV6em3JcV9FO35FrWXguGmOIHIgEWJPYyrq7k4fSobICwtXdgGVlMP4V8tUSMkYus
 0JTJ+K3zVa/uNqYotGC6s4JQ4mS7jMOf8Lcz6ypUDDIQff3jZw8xYj6vfFoVHakOQGB8
 eb6Fux6oLFzrWEyl1R986AlzmZNXaAzHTBi1QRWEMea+bdDhEHVyeNiD4QD/MojqhF6k
 U0JbxEqOUAOqNTtwTv3j0dN2JULdeTxGiksL/Yc7JFIrWYzxl1Dgs9mYTkTjgqB4ot1P
 RCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564123; x=1790168923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mj4YDzukAqHAZD+kr7qud+JL0iR+gcVcf8N+HV0aXys=;
 b=QVylWE9d9e7A9V22KaaN8JmxB17T6e0x1X7eEzTaH2CCcKywzH7p6ylJTUzoPWKBJx
 2B3MmyUXobQJEjy5s/NZY/cZVifTzd53VctMzSjmbywFZ9kgm9YYJwrk7mDZ9snvxyU2
 AjijT7iwm6AdGOES+TLIL0adqsScKyhhG4YYL0vwoVYCJgltBNsvxYIbwBi8dgoe8kUz
 Jac/kqw3wyoMDCbPUGdbhbTo4Yjir+k+LfQs1V5OtM6+Lr8Xh8oWTmPG6/8n0Hpy3hgn
 IJmFsoYzzmhZLhvSvb1sXWDW4RvMoXtCVs96T0FHPabOlglSRMx6nLKFbuA8QU/56/d8
 2oxg==
X-Gm-Message-State: AFuF++l/PhYcTfpXXs04K/5oMHZBI5Sn2fo9wT5OMLHwdLmnMT22WE4g
 oVej7ySstWYDXS9j6dx/wfNkzBucQ9GiaLjK3Um4j0lWr2g+RtrEYct6PwRK3YRPP+3pM1xiOJQ
 AQ+WGyLE=
X-Gm-Gg: AYBFou1PY5bo6CxqOHsXiGdKRmIELA26/QsujXb+9b9tYePywzTjM9SMFgXTJ1Pj4SV
 DE1n4QKpuPPF9QmE/NsxAhktWgUDL5PQFWDJHpPwRM8gPZz+KyKbHMwRbcSyCCm/x33YogMl8W9
 etCXkiQ+UIGbFco5YuH5htLtDb9rE1na47LAtDvY3xdJXi0rUoy0kYGvWuuR+WlAbjCHn9WkqL5
 cX2I5RmaQWhqF5m3R0cIvASRNI4KgoGNcjJUGJCceJ8p5CETU+3JmrKzWbztkDez4viV+oAh+4X
 dh94unK0Wit0bInxGU36mUm7/hzMz/AlIGji/j4niCSKUF9Hva8VH7PjKk7cUhUUpEBnU0SxnPZ
 nb1oC4IBOLy/4Ksp2XMOqUlutrCudW38CrVxCrz068CwksF06I+K+xHOZmaX0rhCF3z2vkt85jn
 JjORDHx9VodpDPuk2rSDaREtYfObEyf1NvtAMxnim6RcqWMGLwGewIb+r55KNQPv5kCUb9o36mb
 D5QsSA=
X-Received: by 2002:a05:6820:4c05:b0:6b3:5475:4861 with SMTP id
 006d021491bc7-6c7d17c4d3emr2582405eaf.18.1789564123148; 
 Wed, 16 Sep 2026 06:08:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 70/92] tcg: Generic expansion of tcg_gen_ext_*
Date: Wed, 16 Sep 2026 03:03:45 -1000
Message-ID: <20260916130409.3382710-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
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

Move from tcg-op-ldst.c and compute the width of the
extract instead of using a switch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-ldst.c            | 54 ------------------------------------
 tcg/tcg-op.c                 | 13 +++++++++
 4 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3d01609810a..84902f5ef72 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index dfad7288bb4..c31c819ebdc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(ext, TCGV, TCGV, MemOp)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 22211ccb452..031c5ce926b 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -760,60 +760,6 @@ void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_st_i128_int(val, addr, idx, memop);
 }
 
-void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i32(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i32(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i32(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i32(ret, val);
-        break;
-    case MO_UL:
-    case MO_SL:
-        tcg_gen_mov_i32(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i64(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i64(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i64(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i64(ret, val);
-        break;
-    case MO_SL:
-        tcg_gen_ext32s_i64(ret, val);
-        break;
-    case MO_UL:
-        tcg_gen_ext32u_i64(ret, val);
-        break;
-    case MO_UQ:
-    case MO_SQ:
-        tcg_gen_mov_i64(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 typedef void (*gen_atomic_cx_i32)(TCGv_i32, TCGv_env, TCGv_i64,
                                   TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void (*gen_atomic_cx_i64)(TCGv_i64, TCGv_env, TCGv_i64,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1feb5352648..cb729a07789 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -361,6 +361,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
 #define C_int64_t
+#define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
 #define C_unsigned
@@ -391,6 +392,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_TCGv_i64
 #undef C_int32_t
 #undef C_int64_t
+#undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
 #undef C_unsigned
@@ -694,6 +696,17 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ext(TCGType type, TCGTemp *dst, TCGTemp *src, MemOp mop)
+{
+    unsigned width = memop_size(mop) * 8;
+
+    if (mop & MO_SIGN) {
+        gen_sextract(type, dst, src, 0, width);
+    } else {
+        gen_extract(type, dst, src, 0, width);
+    }
+}
+
 static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_sextract(type, dst, src, 0, 8);
-- 
2.53.0


