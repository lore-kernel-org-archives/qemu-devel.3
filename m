Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5976AC25B7D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmO-0000kO-Pq; Sun, 26 May 2024 15:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmB-0000Or-Dt
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm7-0007lK-F1
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f480624d04so6904295ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752600; x=1717357400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JS2sXItrx1lQjyr/YyxaEv+gYLkHZMhSUN20mnS6HsM=;
 b=TkijZ/gpevzlTaRaWcFlLkXj096vGh7YGKKojRLviull7Pw0iKW4vnG5Pw9maN33PT
 H/hv9qXBFDjSTD4BXUCZlK3rg9q54ZJufTdOm0SnMBOM0Fyhn6YJy5vPkIlCs4QDA5e1
 6AbPx944PlGiGFqCMue//Pv4kwIZXJM2g+m+IKwqoTW5b0gwa2eop/j7IuuImpGXln7f
 +SyulvxWwxQefXsLQxoFgNu3k6B/tnFj6UZrVK3HvEpxtuDzMd7RMylVVzNsw494zg7D
 e0TYHK2MPtBZMRcsFJJFel0X6zRPOZ77eBhOldrKvJHiKo+HFExee0S0ESP/DUzgF1gP
 Dr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752600; x=1717357400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JS2sXItrx1lQjyr/YyxaEv+gYLkHZMhSUN20mnS6HsM=;
 b=PPvUhxFfeyNQfAwB9pL0oZl6J10Sfk9PxK1pXnDQCBSLa4thMQqizbM7f7BhPTVNqg
 Ri7I8tulhdNxEi3j+hUOgEuAeJ7pADEAA8FJaBcdjs+KVdL7PQ9YQDDcJ3jEdJLJ5bTB
 G+FOpNh8J/lHcMF11T698GJrhmZhi+LVv4W7R1NIg9ArXgUCecxX40X9CGZnre9yry3/
 jrYqg5ufSOf0BNMzf/q9pGZwUF/+KdDW6PadmzbYDzGYI14E/5pSiH7bgiCHjfWJfLnK
 75NeD9Iuq/Szr9bLiGcLgcBD1xLUmKZnGWe0sq/E7C64PHtJZLtNYrSKoy4pmMyld2vg
 q1tg==
X-Gm-Message-State: AOJu0YxkXX6pgBMqrBrRyD6rjh7wlksFgFwbn2JUPhN7tHLylzqIeLd9
 uMLVJmXX03Tc381ZUb7wnf0s3+2ClMTRCUNkcLMwQz6gUgv7GBCQWklLbys0J5C6YNgn2rNbe3H
 P
X-Google-Smtp-Source: AGHT+IFgKxTXj1JiORd0n72dTdfd4bjRQLXmrX7cHURUy+5ekMZeDQPsldrbU+1quHC37smRTEYPUQ==
X-Received: by 2002:a17:902:ec85:b0:1f2:fcc3:5b5 with SMTP id
 d9443c01a7336-1f44870df72mr85720225ad.20.1716752600381; 
 Sun, 26 May 2024 12:43:20 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 32/37] target/sparc: Implement VIS4 comparisons
Date: Sun, 26 May 2024 12:42:49 -0700
Message-Id: <20240526194254.459395-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

VIS4 completes the set, adding missing signed 8-bit ops
and missing unsigned 16 and 32-bit ops.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  12 +--
 target/sparc/insns.decode |   6 ++
 target/sparc/translate.c  |  12 +++
 target/sparc/vis_helper.c | 170 +++++++++++++++++++++++++++++---------
 4 files changed, 153 insertions(+), 47 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index fe0d8bc593..134e519a37 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -122,19 +122,19 @@ DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmean16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fslas16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fslas32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-#define VIS_CMPHELPER(name)                                              \
+#define VIS_CMPHELPER(name)                                  \
+    DEF_HELPER_FLAGS_2(f##name##8, TCG_CALL_NO_RWG_SE,       \
+                       i64, i64, i64)                        \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
-                       i64, i64, i64)                                    \
+                       i64, i64, i64)                        \
     DEF_HELPER_FLAGS_2(f##name##32, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)
 VIS_CMPHELPER(cmpgt)
 VIS_CMPHELPER(cmpeq)
 VIS_CMPHELPER(cmple)
 VIS_CMPHELPER(cmpne)
-DEF_HELPER_FLAGS_2(fcmpeq8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fcmpne8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fcmpule8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fcmpugt8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+VIS_CMPHELPER(cmpugt)
+VIS_CMPHELPER(cmpule)
 DEF_HELPER_FLAGS_2(xmulx, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(xmulxhi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #endif
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 80579642d1..be591171ad 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -425,6 +425,12 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPCMPUGT8   10 ..... 110110 ..... 1 0010 1000 .....    @r_d_d
     FPCMPNE8    10 ..... 110110 ..... 1 0010 0010 .....    @r_d_d
     FPCMPEQ8    10 ..... 110110 ..... 1 0010 1010 .....    @r_d_d
+    FPCMPLE8    10 ..... 110110 ..... 0 0011 0100 .....    @r_d_d
+    FPCMPGT8    10 ..... 110110 ..... 0 0011 1100 .....    @r_d_d
+    FPCMPULE16  10 ..... 110110 ..... 1 0010 1110 .....    @r_d_d
+    FPCMPUGT16  10 ..... 110110 ..... 1 0010 1011 .....    @r_d_d
+    FPCMPULE32  10 ..... 110110 ..... 1 0010 1111 .....    @r_d_d
+    FPCMPUGT32  10 ..... 110110 ..... 1 0010 1100 .....    @r_d_d
 
     FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @d_r_d
     FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @d_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0f7f0260c4..a952a990cc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -67,15 +67,21 @@
 # define gen_helper_fcmpeq8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpgt8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmple8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmple16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmple32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpule8             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpule16            ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpule32            ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpugt8             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpugt16            ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpugt32            ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
@@ -5115,16 +5121,22 @@ TRANS(FPCMPLE16, VIS1, do_rdd, a, gen_helper_fcmple16)
 TRANS(FPCMPNE16, VIS1, do_rdd, a, gen_helper_fcmpne16)
 TRANS(FPCMPGT16, VIS1, do_rdd, a, gen_helper_fcmpgt16)
 TRANS(FPCMPEQ16, VIS1, do_rdd, a, gen_helper_fcmpeq16)
+TRANS(FPCMPULE16, VIS4, do_rdd, a, gen_helper_fcmpule16)
+TRANS(FPCMPUGT16, VIS4, do_rdd, a, gen_helper_fcmpugt16)
 
 TRANS(FPCMPLE32, VIS1, do_rdd, a, gen_helper_fcmple32)
 TRANS(FPCMPNE32, VIS1, do_rdd, a, gen_helper_fcmpne32)
 TRANS(FPCMPGT32, VIS1, do_rdd, a, gen_helper_fcmpgt32)
 TRANS(FPCMPEQ32, VIS1, do_rdd, a, gen_helper_fcmpeq32)
+TRANS(FPCMPULE32, VIS4, do_rdd, a, gen_helper_fcmpule32)
+TRANS(FPCMPUGT32, VIS4, do_rdd, a, gen_helper_fcmpugt32)
 
 TRANS(FPCMPEQ8, VIS3B, do_rdd, a, gen_helper_fcmpeq8)
 TRANS(FPCMPNE8, VIS3B, do_rdd, a, gen_helper_fcmpne8)
 TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
+TRANS(FPCMPLE8, VIS4, do_rdd, a, gen_helper_fcmple8)
+TRANS(FPCMPGT8, VIS4, do_rdd, a, gen_helper_fcmpgt8)
 
 TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
 TRANS(XMULX, VIS3, do_rrr, a, gen_helper_xmulx)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index c927a054b8..371f5445a1 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -66,6 +66,7 @@ target_ulong helper_array8(target_ulong rs1, target_ulong rs2)
 #define VIS_W64(n) w[3 - (n)]
 #define VIS_SW64(n) sw[3 - (n)]
 #define VIS_L64(n) l[1 - (n)]
+#define VIS_SL64(n) sl[1 - (n)]
 #define VIS_B32(n) b[3 - (n)]
 #define VIS_W32(n) w[1 - (n)]
 #else
@@ -74,6 +75,7 @@ target_ulong helper_array8(target_ulong rs1, target_ulong rs2)
 #define VIS_W64(n) w[n]
 #define VIS_SW64(n) sw[n]
 #define VIS_L64(n) l[n]
+#define VIS_SL64(n) sl[n]
 #define VIS_B32(n) b[n]
 #define VIS_W32(n) w[n]
 #endif
@@ -84,6 +86,7 @@ typedef union {
     uint16_t w[4];
     int16_t sw[4];
     uint32_t l[2];
+    int32_t sl[2];
     uint64_t ll;
     float64 d;
 } VIS64;
@@ -198,47 +201,6 @@ uint64_t helper_fexpand(uint32_t src2)
     return d.ll;
 }
 
-#define VIS_CMPHELPER(name, F)                                    \
-    uint64_t name##16(uint64_t src1, uint64_t src2)               \
-    {                                                             \
-        VIS64 s, d;                                               \
-                                                                  \
-        s.ll = src1;                                              \
-        d.ll = src2;                                              \
-                                                                  \
-        d.VIS_W64(0) = F(s.VIS_W64(0), d.VIS_W64(0)) ? 1 : 0;     \
-        d.VIS_W64(0) |= F(s.VIS_W64(1), d.VIS_W64(1)) ? 2 : 0;    \
-        d.VIS_W64(0) |= F(s.VIS_W64(2), d.VIS_W64(2)) ? 4 : 0;    \
-        d.VIS_W64(0) |= F(s.VIS_W64(3), d.VIS_W64(3)) ? 8 : 0;    \
-        d.VIS_W64(1) = d.VIS_W64(2) = d.VIS_W64(3) = 0;           \
-                                                                  \
-        return d.ll;                                              \
-    }                                                             \
-                                                                  \
-    uint64_t name##32(uint64_t src1, uint64_t src2)               \
-    {                                                             \
-        VIS64 s, d;                                               \
-                                                                  \
-        s.ll = src1;                                              \
-        d.ll = src2;                                              \
-                                                                  \
-        d.VIS_L64(0) = F(s.VIS_L64(0), d.VIS_L64(0)) ? 1 : 0;     \
-        d.VIS_L64(0) |= F(s.VIS_L64(1), d.VIS_L64(1)) ? 2 : 0;    \
-        d.VIS_L64(1) = 0;                                         \
-                                                                  \
-        return d.ll;                                              \
-    }
-
-#define FCMPGT(a, b) ((a) > (b))
-#define FCMPEQ(a, b) ((a) == (b))
-#define FCMPLE(a, b) ((a) <= (b))
-#define FCMPNE(a, b) ((a) != (b))
-
-VIS_CMPHELPER(helper_fcmpgt, FCMPGT)
-VIS_CMPHELPER(helper_fcmpeq, FCMPEQ)
-VIS_CMPHELPER(helper_fcmple, FCMPLE)
-VIS_CMPHELPER(helper_fcmpne, FCMPNE)
-
 uint64_t helper_fcmpeq8(uint64_t src1, uint64_t src2)
 {
     uint64_t a = src1 ^ src2;
@@ -260,6 +222,25 @@ uint64_t helper_fcmpne8(uint64_t src1, uint64_t src2)
     return helper_fcmpeq8(src1, src2) ^ 0xff;
 }
 
+uint64_t helper_fcmple8(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 8; ++i) {
+        r |= (s1.VIS_SB64(i) <= s2.VIS_SB64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpgt8(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmple8(src1, src2) ^ 0xff;
+}
+
 uint64_t helper_fcmpule8(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
@@ -279,6 +260,113 @@ uint64_t helper_fcmpugt8(uint64_t src1, uint64_t src2)
     return helper_fcmpule8(src1, src2) ^ 0xff;
 }
 
+uint64_t helper_fcmpeq16(uint64_t src1, uint64_t src2)
+{
+    uint64_t a = src1 ^ src2;
+    uint64_t m = 0x7fff7fff7fff7fffULL;
+    uint64_t c = ~(((a & m) + m) | a | m);
+
+    /* a...............b...............c...............d............... */
+    c |= c << 15;
+    /* ab..............bc..............cd..............d............... */
+    c |= c << 30;
+    /* abcd............bcd.............cd..............d............... */
+    return c >> 60;
+}
+
+uint64_t helper_fcmpne16(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpeq16(src1, src2) ^ 0xf;
+}
+
+uint64_t helper_fcmple16(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 4; ++i) {
+        r |= (s1.VIS_SW64(i) <= s2.VIS_SW64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpgt16(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmple16(src1, src2) ^ 0xf;
+}
+
+uint64_t helper_fcmpule16(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 4; ++i) {
+        r |= (s1.VIS_W64(i) <= s2.VIS_W64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpugt16(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpule16(src1, src2) ^ 0xf;
+}
+
+uint64_t helper_fcmpeq32(uint64_t src1, uint64_t src2)
+{
+    uint64_t a = src1 ^ src2;
+    return ((uint32_t)a == 0) | (a >> 32 ? 0 : 2);
+}
+
+uint64_t helper_fcmpne32(uint64_t src1, uint64_t src2)
+{
+    uint64_t a = src1 ^ src2;
+    return ((uint32_t)a != 0) | (a >> 32 ? 2 : 0);
+}
+
+uint64_t helper_fcmple32(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 2; ++i) {
+        r |= (s1.VIS_SL64(i) <= s2.VIS_SL64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpgt32(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmple32(src1, src2) ^ 3;
+}
+
+uint64_t helper_fcmpule32(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 2; ++i) {
+        r |= (s1.VIS_L64(i) <= s2.VIS_L64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpugt32(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpule32(src1, src2) ^ 3;
+}
+
 uint64_t helper_pdist(uint64_t sum, uint64_t src1, uint64_t src2)
 {
     int i;
-- 
2.34.1


