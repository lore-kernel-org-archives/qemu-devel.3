Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D25BCD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYF-000203-3f; Wed, 10 Jun 2026 12:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYA-0001no-Fl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY8-0005mv-Mp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so58103475e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107983; x=1781712783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CCsyYx72Y2y+q+4CS55j2/wvjV1TF5ioEILuC3vwmX0=;
 b=iEd5ylvXDmUGi+Or7aXQO1Q6MJpulAhp05v//XH1Bz2mbDd+/eAfvB6cWDWG7M8pUK
 uh8F909WlbaIY74qJ7yMaexvsa3oLA+bmS/JisSJ1o8aBZet87y7WEszAn7PQcjFDS2n
 HUVFycnZvMhnzDZ2n0i0P+1k3CIfo+PfrDJvHI2+Tw2tjMJns4NtbDMNLOXajo3m9bBV
 38uT0fqvjauweQvIAIiu70ZTJ5iNvn2wvyxguWWBp7DYMPbYh/0sBTgiCuDgnwlXcWzz
 1gjlKZccgVLW7uuNdAhx4fiRcI0XHeF0NcHB1RHUHEGQZEVik0+83nTNQwnepjW6+knQ
 KoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107983; x=1781712783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CCsyYx72Y2y+q+4CS55j2/wvjV1TF5ioEILuC3vwmX0=;
 b=nULvMo3+qKO0jpmhij0sWGNsZF65dyBrrOf+B103p4QjolE1UyIJyT12V8bwlymbKU
 i+0Ng19OudyJVR94KYLrNXr2gRCOEJFAj+cMw30Kk2dDr8DQEqDbym9i40Ay66HB4gxK
 O4UH+ftMLpjXvh/3/3Zms8vzjlHRH2yCm7CIL2zRfljZKAkEhMxUAkm3Jn1ZTck4JDF1
 BGTJdzgxj+x++agq8J22SrY3c8A8w6oN7/Y0HgWAZ855wvM/Y4Xv/fg9k/e7FELqN8Fn
 A1wJbuCUD27uNWFadwGXuS4kAUF+fOYiDGjm+ySnN4AAz7jiL1Bcpyaq0FTxCETmrsYE
 Isag==
X-Gm-Message-State: AOJu0YxxECyuUpF6hW5hxfs+FisCTkVpDwgZGtkKLgCAR9mnxOJoF3aN
 lTeMPHR7WDeuECHva537yMYSH4n9pPzJ2tF2hCaMptRAToLCV0+3OxnVW7KJL66nWR0NvP0qMgc
 CRkqJ
X-Gm-Gg: Acq92OGU5y/d7Vz3Jq6Xwu+PklR84tIs+iNl34DqCaYki6w1McVBUCpDEQ1nlwDH3L2
 hqUa3DJaMG6HBznML3O/PnLqY/laXQBGBM5zhtsI0MaXw91bPUD6ax/5WMRAuODEO96uRFpgp90
 1JeNtHeTXzT5dTWEMX68jHXdXkkvBFHqsqX1hi3K5qBzSxdBHdm8fpCVZ/1wHO5w5P9jV+uehKe
 +JZVrKYyFix0apvEKBvoM/qGiR7GMBdli4HSw+KH7UH3VCMtgDsyidbIn8jJC6va9ZuVG4/+NFo
 iu8XJERXhk1lzHSHHH1P2RRx97CoAmgRwlK7eOHen/efPMGrByNLvikD003JcvtBjjKiun9wVLI
 PZcd6+xBEQGydrAukLe3k/DGACrEtEJZCcHT6GFC00X63Adcb7ZJrKPBWxYshiaybUjG4n+9679
 Le6SQzBVrwgx6wdDbivAKGERf8V/tInvwx2lODIt5Vbl8fRUOjTu8Gga6yjh+Bl7jkIDrQn+US6
 XxY2Wth512/pdbgwq9tWdq23x9uaKvgGfNOa7ITpgwnGrWQJpVAew==
X-Received: by 2002:a05:600c:441a:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490c26e1b8amr275009495e9.25.1781107983193; 
 Wed, 10 Jun 2026 09:13:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/71] target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
Date: Wed, 10 Jun 2026 17:11:34 +0100
Message-ID: <20260610161202.2235298-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/sve.decode        |  1 +
 target/arm/tcg/translate-sve.c   |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0b86ed9eb9..8295725b83 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -414,6 +414,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
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
+    fp8_cvt_finish(env, &ctx);
+}
+
 void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
                              CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 023a49e12f..e67fb191c2 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,5 +16,6 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6b2875a451..446fedb5b9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4100,6 +4100,8 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
 TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
 
+TRANS_FEAT_STREAMING_IF(FCVTN, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT_STREAMING_IF(BFCVTN, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvtn_bh, false, false)
 
-- 
2.43.0


