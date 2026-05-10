Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D190FCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx4-0005AA-CR; Sun, 10 May 2026 16:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwy-00058Z-Hm
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:34 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAww-00045C-Ce
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:31 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-48270ea6dd1so168869b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445629; x=1779050429; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B3UNL1/6n/lzjlvUSFATnbJbKsAbf3lnMtixzSUB/jE=;
 b=Bv81dCV7QnFtq3o2DMTJ8QuoLTG5FbDTvN+CtmSq6Y5cW+GMY8qnEYe1MAjtfW1XhN
 BGymP/aHQN2/p70XQ5abnefWT0YnEnoG+2c7EdT4yR+pAwS0S6q4EAO1K3iujjngdG7y
 frDT9fbZx+Vz0rzUdHSz6GB1hqW4IoX9X/W1Ad4Oy18QRpVoD1jNs434LswC0crWBhAN
 ocKSy3hBepGjf65sCCJay8zcvcoF9G2zdN/bU07l3hSzmSiCMGhpO/xUodKZjGr0/is5
 NPgaJREAKupsvxFQ+g7IQLB0j738bS92jewFIiVY5FluUjStJgp4FnFKVK5GW9e22xFA
 ETyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445629; x=1779050429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B3UNL1/6n/lzjlvUSFATnbJbKsAbf3lnMtixzSUB/jE=;
 b=QNsqN/vqCh/j7wxMXlOmlaystFxdfuvTehhSKJfCzAJwwD4byUeg+5pHMV1gUzvoEZ
 Tn+rvFhCQ74g4I8mK1aqGgy29TVmzScQJPVfmMsQ73TNXrLxE8ndFnm3oQFRUYFZtPyL
 LXGGPij3I9X24opfcZcJDTynR+V+tU/cr3K/zeR3RD38fsDRLUHPEX4MESkCTD4zd9nQ
 js0WahbWC3ocu1SDLpxSGEh2fQ9ZI/mk7q2jvz7ggyMG7rJwvF0Zc8MMRZhOaBFKD7hG
 ThKoWL8zcnE1HLE5+8ZUgZEN2Jb8aSGdZyE6vBE0CTg/zxlDQWqCi7HoC+RxnZhAwIqL
 hqlQ==
X-Gm-Message-State: AOJu0YwDMP/PDKoqOF51hKTPQrmlPtY7XMS7kPNAnEoPjlTEFE4VAgtQ
 +dSGQRfPeyEOCSZ+Tb6SbhAMVjSpPjRz+yEhughoc7P/7bDUzINPV0rW
X-Gm-Gg: Acq92OF3HxCDjnA5XpmRkJUN36Okoo/Z4EzGRDJ14cNpMJ9D1mwVffW6KcNte/tVzl7
 vfSDo9tAOEaMaBAAdOpTeFdjsWcJK2rbib3epYhAkNzDA4H9Azycue5v49L2fKVqpktFH3+KM2r
 QAWFj1acyE8vFEtD+x1uLh4CcisFPDnb9Vv/2U6qgjl46qfm3p+aXhXfa7AFHJ8mTzTXlEXinpB
 C3MVoOBeIEwvnU6QQ5Bl0l73Q1sQn8cF6RqPmUj/0qY6jdVwcf14s11SDDqXzSXamjyu4A/vMcQ
 5R0Mr4meC4+EP5OReSJh4ohwfBK8mBcNcd03hbXaOSLjY5Xqd4yqlL3Zs0Q8L696i0sL5byaqYX
 IOJSx7I9uTH5CizbD05T9hVTpEWCS7/hWTdv+9b0DViWuygUHH6CDo0hg8QCaHllzA+n6KtZyPh
 YzRLPlF47xr1pn1ynuSWDo3BCLjzHkqP7Av/qtco5P+WtLtz9RuzEzjnQNvjD3pj0YAiXI10Kum
 B9Iju2F0C1tGLCngLBwJar4O6NSvOVvHYRWInMpVaY=
X-Received: by 2002:a05:6809:2d0:20b0:482:6b8a:33a6 with SMTP id
 5614622812f47-4826b8a34e6mr1192858b6e.23.1778445628741; 
 Sun, 10 May 2026 13:40:28 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:53 -0600
Subject: [PATCH v5 23/32] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-23-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

V3MULU extends VMULU across the full Octeon3 multiplier state, adding rt
and queued partial products.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split V3MULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MPL3-MPL5/P3-P5 high lanes used by the two-source
    MTM/MTP forms and Cavium SDK/runtime code.
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c |  1 +
 target/mips/tcg/op_helper.c        | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 46ccad95c3..08fda55ae1 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -26,6 +26,7 @@ DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
 DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
+DEF_HELPER_3(octeon_v3mulu, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index c60af2d39a..9c1fe8f4f1 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -52,6 +52,7 @@ MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 63e2719b1f..11a15a3cff 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -298,3 +298,4 @@ TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
 TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
+TRANS(V3MULU, trans_vmul, gen_helper_octeon_v3mulu);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 124855d4dc..f565aaea20 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -192,6 +192,52 @@ uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return lo;
 }
 
+uint64_t helper_octeon_v3mulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[OCTEON_MULTIPLIER_REGS + 1] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 1);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 2);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[2], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 2);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 3);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[3], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 3);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 4);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[4], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 4);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 5);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[5], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 5);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 6);
+
+    octeon_add_limb(sum, ARRAY_SIZE(sum), rt, 0);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[1], 1);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[2], 2);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[3], 3);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[4], 4);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[5], 5);
+
+    env->active_tc.octeon.P[0] = sum[1];
+    env->active_tc.octeon.P[1] = sum[2];
+    env->active_tc.octeon.P[2] = sum[3];
+    env->active_tc.octeon.P[3] = sum[4];
+    env->active_tc.octeon.P[4] = sum[5];
+    env->active_tc.octeon.P[5] = sum[6];
+    return sum[0];
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


