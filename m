Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB73C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeY-0000px-P7; Wed, 26 Aug 2026 13:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe7-0000Dd-IN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe4-0004s3-Lp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:42 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc1cc1b42b5so719225a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766159; x=1788370959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5t9US0/7SeEnGy5DN1l/EIQgUJAowvAVfFVnjj4qO14=;
 b=C3v3cKBChvR4JfCcV9lglSN5EQ78Ipn3TzB9kxq2FT5BbApRC/xIeJT2Ls5Hrjf4Ly
 j+4rg3fENEE5CzO9hVhtfpRL2/nraVVdCac0H4LVxsApF7EHSo6kL9o3NSa5rzTOpTVs
 KJCZl8U08G9Ns+SJWOXwldFzdjHnMxzOcG/46BzZtRWhThgaGc8CJYA4uT01QOnzttlu
 XXW9s5Afv3j0OY5MMEKWBnULwfXdztTOKnVM/otFih+rFTM0QpS5TEV/s6COnbCyb4bv
 6ov11/Fo4efTuhf6IBjceTQ4QYN0jWrH3Ghcc1esptm1+pJUS0aAreZY7+VTgpemhKYS
 65eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766159; x=1788370959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5t9US0/7SeEnGy5DN1l/EIQgUJAowvAVfFVnjj4qO14=;
 b=AO1ZzCXXY+aUA8QQ9I1oyku0AqJP4365YOXdLnA6HfPp0g0WUST2sh1qVwlp4StrIe
 7xN+tJUb87RD7YuPEI/ynJ+lXYLu4JK8Yh2okUfXfsOHCHlrqOe0OZmZPKv3vrE70IrQ
 ry7YJRd+uLGWk+YaTN1rq7Kmv4cFeqWuIJnnHeclgsb0oJH8036hXIxozJi5GECZYJXa
 PZpXb3JFf6cYVpmZ0y5tZ6PTuQE0fJbJMkK1/yj/xuYL0NGrkoI7/ItIDbNdJtvjfU/H
 eM/dgyELHBX7VGdF+jq0jcQQfpAyWW2MTMLrtJIwcYCN5zOPs6JtuQuDKUjDlSGpzUvU
 CCDQ==
X-Gm-Message-State: AFuF++kD8xITcQ1aJAW9XP2CywL8aJjBBOYn42iTK3I/bEylzgSxcwae
 nQSxM+BozLNLaDfRr9ReJ386BQRH+I/FdIlH5gzX3LbodsjZwAgO2DyfCXNkJ+i5fs9Ct53H+Nt
 DqTQipzE=
X-Gm-Gg: AR+sD13TQsuwKto6KIy4hUrzsEnfJqSqVR7AJC0yVyGCGNshRqISVQK5yoV0cEdjoGW
 qiPSKL3r5rUS7eMpeh23dyOYfXb/sct4Lu2sBMDSNRgESniI0rjie6in0DcYziiDAHx/Q57Axuy
 MyG/YoEsFfemuVQwT1itpXAv6v0R3zq1p7ubV+yLMZAYl2Ppq057AFmrsM0mH+Qu4XhdhePwhi/
 tziGU81cpoWPq17DWhuyr4JHe84lpqrtB4OvZqvgYHaHuc7TshdbtVBq3FHzuiUsrVmI+Ugk5Sv
 zrOp4FkFbKCR96jMBzW4RryExWlsRCl26a7sro33Rrwyp/cUN1DtRKqF+BvhkEBBIkSERDJF/Ys
 Zh1BLa56sZoMkLvfhRjEwU1T90Bjmn8Yt86SDgEYP0S1hZNUzzcZLWDC7LzOsl4Q/UUD2c9BKUn
 a5VptT24tCPh8GlVl/q+Ns1E/r5IqSsRobaryAIKNaDd3QT2i1RNbIBw4BC+f7ltlDbwbxGgOLK
 nOd0VT6sTfNl8ZXSQ==
X-Received: by 2002:a05:6a21:9f07:b0:3d0:abdb:de03 with SMTP id
 adf61e73a8af0-3d0abdbefbdmr6646703637.2.1787766159009; 
 Wed, 26 Aug 2026 10:42:39 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 21/25] target/arm: Implement AESD (indexed)
Date: Wed, 26 Aug 2026 10:42:08 -0700
Message-ID: <20260826174213.614571-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/crypto_helper.c | 47 +++++++++++++++++++++++++---------
 target/arm/tcg/translate-sve.c |  2 ++
 target/arm/tcg/sve.decode      |  3 +++
 4 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 9b320b5c97e..1a0e4130aa2 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -462,6 +462,7 @@ DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesd_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 27b5813b6d9..05f193b3d17 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -99,6 +99,23 @@ void HELPER(crypto_aese_idx)(void *vd, void *vn, void *vm, uint32_t desc)
     } while (s > 0);
 }
 
+static void aesd_kernel(AESState *ad, const AESState *st, const AESState *rk)
+{
+    AESState t;
+
+    /* Our uint64_t are in the wrong order for big-endian. */
+    if (HOST_BIG_ENDIAN) {
+        t.d[0] = st->d[1] ^ rk->d[1];
+        t.d[1] = st->d[0] ^ rk->d[0];
+        aesdec_ISB_ISR_AK(&t, &t, &aes_zero, false);
+        ad->d[0] = t.d[1];
+        ad->d[1] = t.d[0];
+    } else {
+        t.v = st->v ^ rk->v;
+        aesdec_ISB_ISR_AK(ad, &t, &aes_zero, false);
+    }
+}
+
 void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -107,23 +124,29 @@ void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
         AESState *ad = (AESState *)(vd + i);
         AESState *st = (AESState *)(vn + i);
         AESState *rk = (AESState *)(vm + i);
-        AESState t;
 
-        /* Our uint64_t are in the wrong order for big-endian. */
-        if (HOST_BIG_ENDIAN) {
-            t.d[0] = st->d[1] ^ rk->d[1];
-            t.d[1] = st->d[0] ^ rk->d[0];
-            aesdec_ISB_ISR_AK(&t, &t, &aes_zero, false);
-            ad->d[0] = t.d[1];
-            ad->d[1] = t.d[0];
-        } else {
-            t.v = st->v ^ rk->v;
-            aesdec_ISB_ISR_AK(ad, &t, &aes_zero, false);
-        }
+        aesd_kernel(ad, st, rk);
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(crypto_aesd_idx)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    intptr_t idx = simd_data(desc);
+    void *vm_idx = vm + idx * 16;
+    intptr_t s = opr_sz - 16;
+
+    do {
+        intptr_t base = ROUND_DOWN(s, 4 * 16);
+        AESState rk = *(AESState *)(vm_idx + base);
+        do {
+            aesd_kernel(vd + s, vn + s, &rk);
+            s -= 16;
+        } while (s >= base);
+    } while (s > 0);
+}
+
 void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9ce172dd939..cb1542f3931 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8344,6 +8344,8 @@ static bool do_aes2_idx(DisasContext *s, arg_rx_n *a, gen_helper_gvec_3 *fn)
 
 TRANS_FEAT_STREAMING_IF(AESE_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aese_idx)
+TRANS_FEAT_STREAMING_IF(AESD_idx, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aesd_idx)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 64e0dd0eae9..1ab1b4042b5 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1985,6 +1985,9 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 AESE_idx        01000101 00 1 .. .10111010 ..... ....0   @aes2_2
 AESE_idx        01000101 00 1 .. .10111010 ..... ...00   @aes2_4
 
+AESD_idx        01000101 00 1 .. .10111011 ..... ....0   @aes2_2
+AESD_idx        01000101 00 1 .. .10111011 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
-- 
2.53.0


