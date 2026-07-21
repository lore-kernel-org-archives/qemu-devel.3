Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DCAC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFWS-0001Wm-Fh; Tue, 21 Jul 2026 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFV1-00018H-EP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:28 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUx-0006hX-Uc
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:26 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso7850225a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659642; x=1785264442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DcdpeRn0/HAEk3CxOheIPUYZqTxloeiJkVjw0K4nE7M=;
 b=icZCmyq2eADQlLqLIewcw/1DS/OhAxVELYQYo9fAo6EsfGuxqMvsgF3WJXg/QPrNPU
 qLEVdHUtUVoetQQBH9OBRzBlbDwoBky6dTG5B0Q9Gmgu8AQORyimrmXwN/gWkGNCiCiZ
 uz22qV9BtTi2CrSaXFlcAHtbU0efFMiSUHNtHZiG/8cBCHktfLrsuT0yNXi93U6Pmn9V
 XJ9YO9Qr4GnUps0r/kOOVzT3jfoi1OpZhKVfNrZxgD0NzxpcA3X8y0+riAsmaJ1NkdgD
 zRw6FYbajXvMLkaZ1pl/OtUGGyVXIs9FWpf8RATeiNe8YF6F6skRSWOP5CPsvhm1EN7F
 CBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659642; x=1785264442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DcdpeRn0/HAEk3CxOheIPUYZqTxloeiJkVjw0K4nE7M=;
 b=HRR3kIO3NyP6LJWB6+8dC3x5n18Em1mwAPqXigOZzUnFzaF9w58GqYCd2mFMBp4xzT
 MuxBKhJGns2t8+TMo9o/1daqOPKJ2pJNpUEhAH3PTIeLZ04bACK5ARewF004P0fo0OYZ
 CpWjTrdUT0pv+YHMbNw0Gh1hO70KozVaGSseLvYaW3See2svukwzeG0GbxkFdVg6t8Lt
 LL8K8J22KmBn4H7pLJYZiKqETQDj64Cju75t46aLQc9EczzSUF9sXUFQDBs6y+NcTS4o
 Vdr5oMdQaVdzSgE7KXSo7OfSEN4kKoY7mE3n7xE9QJExf8uVKPOGlLJszrdpuFTCGEYD
 5JRA==
X-Gm-Message-State: AOJu0Yx380yME7CE6WMsE3C1epibRDV8HQ+U5Mkq3UaZ4uowChZ0imM9
 dceoeFFXXYjBrblnSnzgBmOXl82BsUt494SvMtw/zvR+gwc15On/O+hdVG5Lu34PwtmiMnl46K0
 Li/Mr
X-Gm-Gg: AfdE7clB9JWaSz0pSNeZ0xurwWclzs2VsteEXN/AWNTpUxH4+pGh2krif6OXH0GVBhQ
 EI1I7JHv2Z9qrTePzkQTWtALr25Sf4VCMYopWat4T3Shm4zu3n3Lqyw0eIg8fdex3i2VPRgEFr4
 O/c/ewqdieMbHy+U3lb8C9OjxbVxy62gpklwR2f9ng11JS89O1t/vct7LbV9tzFRFJn19JqvNLr
 R04+3SQOdpdNQEued8Sv5kVVe5GYXZQQhdbuKvVXoma1nNxs84UCP0/BMF15B6/bq18x3CPMJo0
 /xdOzl2oSkIGLyx1S2/DGWPyZkdaO4f2+M2YLWPrS/Yd8cX6dLXLiQ6HxO+Btcav8M2QcFqNDe0
 TE6HUadW45noYUYgUrSONHgYJf1ZRkwoEZLYNpXbZY1LhPR0soRXGhCbrLTcyYF0MKIW8UrWth4
 nmN2PWSXc=
X-Received: by 2002:a05:6300:6d8a:10b0:3c4:13c:2ed3 with SMTP id
 adf61e73a8af0-3c4013c4b98mr6664400637.69.1784659642377; 
 Tue, 21 Jul 2026 11:47:22 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/20] target/arm: Implement PMULL, PMLAL
Date: Tue, 21 Jul 2026 11:46:55 -0700
Message-ID: <20260721184656.530230-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
 target/arm/tcg/helper-sve-defs.h |  3 +++
 target/arm/tcg/translate-sve.c   |  5 +++++
 target/arm/tcg/vec_helper64.c    | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 43 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index f78e77662d..498468a772 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -3215,3 +3215,6 @@ DEF_HELPER_FLAGS_4(sve_expand_b, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_h, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_s, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_d, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_pmlal_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 14378cf066..b7849b5be5 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8341,6 +8341,11 @@ TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
 TRANS_FEAT_STREAMING_IF(AESDIMC, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesdimc)
 
+TRANS_FEAT_STREAMING_IF(PMULL, aa64_sve_aes2, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_sve_pmull_q, a, 0)
+TRANS_FEAT_STREAMING_IF(PMLAL, aa64_sve_aes2, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_sve_pmlal_q, a, 0)
+
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVTNT_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 8879969350..7d4e21b9c7 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -89,6 +89,36 @@ void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
+void HELPER(sve_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t *n = vn, *m = vm;
+    Int128 *d0 = vd;
+    Int128 *d1 = vd + sizeof(ARMVectorReg);
+
+    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
+        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
+        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
+        d0[i] = rl;
+        d1[i] = rh;
+    }
+}
+
+void HELPER(sve_pmlal_q)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t *n = vn, *m = vm;
+    Int128 *d0 = vd;
+    Int128 *d1 = vd + sizeof(ARMVectorReg);
+
+    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
+        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
+        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
+        d0[i] = int128_xor(d0[i], rl);
+        d1[i] = int128_xor(d1[i], rh);
+    }
+}
+
 DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
 DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
 DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, /**/)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 7030d81db7..42f451ff9f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1994,6 +1994,11 @@ AESEMC          01000101 00 1 .. .11111010 ..... ...00   @aes2_4
 AESDIMC         01000101 00 1 .. .11111011 ..... ....0   @aes2_2
 AESDIMC         01000101 00 1 .. .11111011 ..... ...00   @aes2_4
 
+PMULL           01000101 00 1 rm:5 111110 rn:5 ....0 \
+                &rrr_esz esz=0 rd=%zd_ax2
+PMLAL           01000101 00 1 rm:5 111111 rn:5 ....0 \
+                &rrr_esz esz=0 rd=%zd_ax2
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
-- 
2.43.0


