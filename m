Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A1DC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBH-0003cH-A7; Sat, 12 Sep 2026 22:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBE-0003WH-QU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:56 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBC-0001yR-Nj
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:56 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so670836a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267373; x=1789872173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aWRW6rG6+kMq4bIl2P98IBOUOhRaeHh4N6iEongGS1M=;
 b=a0otqm63R/H9EPgWZbAwj6S3aupJ9zazHBscPpDjnE24VX1R4ThtT7TD5kkLfIjWbc
 6/cqyzJx+cIjO8XxBMLjY/eh7fHCZvHogP8RCiAC+FpxZsL9DgvlmsXkerlsyfmKcjdH
 IBxfXuBMxDj1maIyEPRmxgcNZCpJLykMvrzYolP4CPzDN3iRtJ2nVmdbjT2PkiLSjnur
 AO8zs5kXuR/V2EoPhaaIwdiMHdTVepf7ryapKjaKk4uIVCVvv0izA+DkTUt+SSh/Bjyy
 /sMDlfAWxiT/pBBgJ2VQ/lVolHKPgMfKa3yRbHJyPgk8hZhWzkKn6JGEK5/Wvm9G/Ap0
 OcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267373; x=1789872173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aWRW6rG6+kMq4bIl2P98IBOUOhRaeHh4N6iEongGS1M=;
 b=OHdFHfTsfubTA8/KxBzHnYIXIasIa5Nl3WjH+63p76Xo6oJ8HU4Fwf53tD+7d/70fU
 fD3H0l4wCskKG3GNlnaiI1f2lj219VsU497VGDcXqLrO0Dlzf0N3v+Vpc41/dvUwwn0Q
 Wwyvp/WEB/8PjqHQIepNxzomfYvG0ovWIe2/065q4OIpPAqHAwUDnoefSw0AB/PUJRwg
 rbZ0S2dNWwk4MVojd4PN4neCT2m217N8gA/rY/lg1VBU50BoKS2/PP4KolFqOM0hyUJz
 rC2Bm745fb6qu2Kej38MqimR9iOhoOtMmEli5TuiCoXFgiVJ2YUB9gtgePlM0afLs5bI
 1k7Q==
X-Gm-Message-State: AFuF++lUreew0JcllMvw7i5CiaMzrGWlvthjWkNLnQV+usq4GVbiqWyS
 7KGnIJ0zeJBdFUqikHI4KMggP7x4ACIf/FkvsLeaYQ9gi0o3+VyqJ4ph9E0HVyBvjAamX+uSXC+
 3/jnDHJc=
X-Gm-Gg: AYBFou25O4KckBUfgusVE/ngF6txUugrqmbfkZj+Rhx79ipAYpuiv3bKZ/Q8ehBFY8M
 27zgeXYGnM736v9OcmIS/xboF5jmN58/z9sjuCOfqX6e1nkK9gbBKz4JSQxStjUmgc4Gk3yt7Ge
 aqBw3GlqpDXM3pGufo1p7R2JCAd7LnFdGzKZLnEW/soH/FYyz6V2iTrNjtXPXjpH1bXbvMqVaax
 hUbk/ivqpfkT8iMmkfqpsE14cMyR8vm1HSDb4r61iTHjlUpTTLka2NJV9ai5kcdi94U0C9wxCNq
 UouhRrGK1SkmlKfMDg0BxGmXWDjf+JyzI1WaePZJGUcHL1N21NZQ98tcpQI1b0L8RJ6G6a53BRF
 AdvfG3wOlQzjPhWUmsS9Wt9lgwiyQ7oxmCIp4XpkDVXiD354fWneJHWOMF2yVPWuPy+lNXW8uSB
 DiKvSvpyYo/IH7mcHCq1wcb69HSOZOT5gJU36iB4PIfP9NfNkn9Eqbn7yK0+FdVQkgzwIaMH67M
 QBpgihxUhqIjY+wOw==
X-Received: by 2002:a05:6a20:2587:b0:3cd:9f0b:f788 with SMTP id
 adf61e73a8af0-3db0e1b42ebmr8814414637.12.1789267373266; 
 Sat, 12 Sep 2026 19:42:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 67/86] tcg: Generic expansion of tcg_gen_ext_*
Date: Sat, 12 Sep 2026 16:38:18 -1000
Message-ID: <20260913023837.741866-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
index ce9b5243911..7fad859a284 100644
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
index 5c103bb8e4a..90accdb7714 100644
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


