Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6192CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPo-0008N3-Jq; Sat, 16 May 2026 20:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOv-0007HT-5q
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOs-00058V-0z
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-836ed29d1e5so408870b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977832; x=1779582632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCb2JOKmPFn0zZsJbVtbJgBYvfdpEDHbgFMbx9E3/B4=;
 b=iYatM5clS4pgYmoc+6sW33Bdg259vLC9kkh04PUslN9ZY6AVquTdF2xUxZ/yyHZ7Qk
 8KnKDtNXUZrdHHwhyM/dgFDnLJADVX5usmJeDRtQ1g239hJsN8q8DRnRSE5mEotPw8hL
 qeRPiD7yx3ySLWTDGv9e0b++PrcDqzfalpD4sqIX2QbB0g/DuOmAxl7OHfIsBvD37GTQ
 LI9Wx86aYOrpQOcmfeosE+jPxglbuL7WKazxK/HDLTyngtMRh/UCintCs4nVttjxpx4H
 5QNsBmx2U61llTAKTmqx4JgtO27ONfmgOl51NG7DTRl/7UrkUYhyE6JPQxAD5h9OdOBB
 lBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977832; x=1779582632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YCb2JOKmPFn0zZsJbVtbJgBYvfdpEDHbgFMbx9E3/B4=;
 b=UM6EZyqkiiAxcE8NiYT/+KZhiMFUAtD4QIdRfwEgGCIlXj6PWyDxQBZYbRzdqP9NG1
 Fo+HVBsmM2f/vZ5mbU1UH73HT79z8JOhm/JxXXoO7RD+pcbthEEl4IdzCH3l3iRWicmP
 3tAxZF1rW6WOPUYhkcaLd+8bMprIJa3Yb/37VfDxKyCzS6cnWnOq9Ke2UPY/lovU3ANY
 D0v6ig6PPd6y95Dc0RJ+Ih73iRbWq5fhO8VipVWrNJWvQ98nHZdMEc+u/xJWK8j7ZJg7
 BaWWEUtoLzH33tfOl6RR7d9MS3xCmEPPmOMNtQg/EIuHkV720ARmDlE8fQIo4qUMkiqV
 xg1A==
X-Gm-Message-State: AOJu0Yzr/+vu7iX7sirc/8ZGoody81FJox5drt0A+tbyk144b4lRBsvj
 aqOofJVEG7EwCroTEeecKzDfNtOIouH9o3/ZFXnDoDAzw0BDOp7zhGQk1Rutq4T+YQdMUaypz5Q
 xarql
X-Gm-Gg: Acq92OEyxSgmDh+VKh/B171zuELSTU+QiE3edtX2DA5KHFps2vfRBmEd/yRvBYBz6He
 8zrsPrIKcCgpxJm1Vrc+Mh5y3xK3NdVnckO95AF1ufpqsLfVa97nvrrNohKwoGxJZ6fmllLik3v
 gZcMpR04smfB/aYP5TLndWJugLKI14R2xpAwyM9PmG+KlxOJs+Si1UADHhySmt4zQOfTmGLAfqf
 CP+tkR3kARYq5i6qeGZHMMDd/NI25HSCR5CSUNRKFgyl3UCdRDfy8zXKbrCHAA5WJx1cY6saDv6
 DUV2k1UeDbulNC/6pW8cG2eBPkqAZV6rxjkIN6DHI3EcbK3/dqB2KI8suCck+YriFiBLQbHYuty
 pRCVproham7FGjs/C7lU/Pqd50kBWFuPpREf1W7rhfOSvdXWxmTEwKCAYSnb0j/qJk1Deskyu5K
 ijbxhrUKqLIAUHsuNnmilT9poZPnvA
X-Received: by 2002:a05:6a00:4c0e:b0:838:127d:a16a with SMTP id
 d2e1a72fcca58-83f33c9e636mr10330201b3a.19.1778977832410; 
 Sat, 16 May 2026 17:30:32 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 33/63] target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
Date: Sat, 16 May 2026 17:29:32 -0700
Message-ID: <20260517003002.321430-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  2 ++
 target/arm/tcg/sve.decode        |  1 +
 4 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 023a49e12f..e67fb191c2 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,5 +16,6 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 4689ffa88b..c32577a9e4 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -417,6 +417,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
 
+void HELPER(sve2_fcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, true);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float16 e0 = n0[H2(i)];
+        float16 e1 = n1[H2(i)];
+        d[H1(2 * i + 0)] = fcvt_f16_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(2 * i + 1)] = fcvt_f16_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_finish(env, &ctx);
+}
+
 void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
                              CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7276d9c44a..c7fcf27183 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4099,6 +4099,8 @@ TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
 TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
            gen_helper_sve2_bfcvt, true, true)
 
+TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_bfcvtn_bh, false, false)
 
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b6ef8ed8de..806953bc35 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1101,6 +1101,7 @@ BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
 BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
+FCVTN           01100101 00 001 010 001100 ....0 .....          @rd_rnx2 esz=1
 BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
 
 ### SVE FP Compare with Zero Group
-- 
2.43.0


