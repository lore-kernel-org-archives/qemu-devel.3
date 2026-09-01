Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9C7C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONr-0001aw-Sz; Tue, 01 Sep 2026 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONl-0001V9-Mq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:33 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONj-0007N9-VY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so786176166b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268710; x=1788873510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VMaeH69Hprp/VUhgFGh6Vko72D98c7GFGrcJtyCHWuU=;
 b=F9vLgPPZXNvCnQcHq3Pakqe7m2IsuZ+6oZyjn1nZ5fHOQdyKuXDsV4qi9x39HlkdTD
 2K9P3OmSmYlaDxM3wQ65ftGpwSYDmJsKLr7iKylTz5hwnJAotLo0jDYhTekaUPU2ApKp
 +J3v7o1Dnt2HvBwG5tRtR7uP8qTyd7xEDJZDQr8KTtLSbnoaZi/GmhfR3Hrhtitv8Czz
 vw9M0Uo84vEgn746GsP3V19ptnNqD87ielH8GLHzOMdgqQB+bNVcRkxnHbPYWvA793EO
 2l28/XbO3xsRxFcBxnG674wfvdtUEq0GBAJI1kvVJfeJZByNFsxdrxBTkMj8LlAHPCYq
 /mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268710; x=1788873510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VMaeH69Hprp/VUhgFGh6Vko72D98c7GFGrcJtyCHWuU=;
 b=hPaPnH+kURRDx+HvC4iml/LCUPMbNKdhXvtiTeRca2RrIqfSMHRmNnmc+nlzeHV1ZH
 opd/827mjcNFk5HsnVoP95jwpQqSoG+Zy6tqsF4vilRsOfZZfgtTzg3h48R7d+JGLlB5
 aaB+NTQ/WPZBxWPyFK6dOVMCs2P6bLUKhvLoCvzIGL6sHOmbNZc3Qzel2SKH9RInW1c4
 OxhL4D7aJmHA7vFLnS1pm0iQVBDO/DGswmgVbIW8HCTzlQzSxUELpBuFwg6pGIZuojpu
 YoqVa1CtBvF5RteA47JnE43jiv1nI58/nNniDuSE10GjHgAT2qDv7QAt4swW8W41+ylF
 a+Yw==
X-Gm-Message-State: AFuF++mCPaWY9ZCAKSjGwh5xAEXb0xA59T3rIXY7/+gr15/M2HIH+MZ8
 tB/9CT2VJNVa9VAqxFL/zoCwScw933Txkzt0koqzKzdcdwr875af0Y0dDvlCmiLPnvHdbO0WFzn
 /y/1zGk0=
X-Gm-Gg: AR+sD1303vNUDzN2AeZTTbRshQHY7BEv7RIesab4nkb0wmwfgX8yDdoTqcceY+42B2l
 Dy5cYkkkuOGfVydiH+pgcU75wetZ0EjPlYmKCxdK+sKkKMCKTcnSwCRKoQ6cGgNrM5CjvrM14U/
 bC+BS2oMy3Dj9QbrDUFIgs+dmt7dK1t4/KBA32XHywZu3N5FJVzeqBsBArRtW/4cfjhdNFw7QjB
 A8Qrw6FZQ4D1vgS5H5+RNRqRxFKQb+DNNKcgKTnJ0ERcb84QvqGvR84gAxJXAQbm6YR2R/UbWIb
 UHBmN3VpvqQ0iMZ3TRlLPInOh6yMj53oUzxgOaxpH6Xxzsk1IjToNck6bP7SIqiMHUYArrO9/9W
 TK+1hNRM2gXfez+8bVQ/DlIdhiZ3+KMUNwWEIStHeS7fhEB9nTaxOuGFus2lv0y06OSfzKSrV34
 76MRzJo4208gbgRDpX88Zz1iBaEiQwN1cdsCPAIaOh9Qy2IAQafaltpBFhoG1dZkJvBH60ctOx2
 +nQhsfN2/MUxgwBarjW51pjP06SZB5terBEjjkYu1r1gPMClM4ehGEmxCbHfU6gDNHfPQ==
X-Received: by 2002:a17:906:2545:b0:c25:977e:5377 with SMTP id
 a640c23a62f3a-c25b3bde234mr501920166b.10.1788268710476; 
 Tue, 01 Sep 2026 06:18:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/58] target/arm: Implement PMULL, PMLAL
Date: Tue,  1 Sep 2026 14:17:31 +0100
Message-ID: <20260901131732.2263947-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260826174213.614571-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  3 +++
 target/arm/tcg/sve.decode        |  5 +++++
 target/arm/tcg/translate-sve.c   |  5 +++++
 target/arm/tcg/vec_helper64.c    | 34 ++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index f78e77662de..498468a7723 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -3215,3 +3215,6 @@ DEF_HELPER_FLAGS_4(sve_expand_b, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_h, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_s, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_d, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_pmlal_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 7030d81db7e..42f451ff9f0 100644
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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1098cf0b388..10375577b1e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8351,6 +8351,11 @@ TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
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
index 88799693507..4f43869d9e9 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -89,6 +89,40 @@ void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
+void HELPER(sve_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t *n = vn, *m = vm;
+    uint64_t *d0 = vd;
+    uint64_t *d1 = vd + sizeof(ARMVectorReg);
+
+    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
+        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
+        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
+        d0[2 * i + 0] = int128_getlo(rl);
+        d0[2 * i + 1] = int128_gethi(rl);
+        d1[2 * i + 0] = int128_getlo(rh);
+        d1[2 * i + 1] = int128_gethi(rh);
+    }
+}
+
+void HELPER(sve_pmlal_q)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t *n = vn, *m = vm;
+    uint64_t *d0 = vd;
+    uint64_t *d1 = vd + sizeof(ARMVectorReg);
+
+    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
+        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
+        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
+        d0[2 * i + 0] ^= int128_getlo(rl);
+        d0[2 * i + 1] ^= int128_gethi(rl);
+        d1[2 * i + 0] ^= int128_getlo(rh);
+        d1[2 * i + 1] ^= int128_gethi(rh);
+    }
+}
+
 DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
 DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
 DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, /**/)
-- 
2.43.0


