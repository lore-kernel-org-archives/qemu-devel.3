Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82C0C27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLx-0005w3-DZ; Wed, 05 Jun 2024 13:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLv-0005uS-JE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:11 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLt-0003qO-QL
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:11 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c21d7de619so46986a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608188; x=1718212988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beguJUoSFFdVi2mRlnibzIyTiqohzf3HoFh6eO7lEKM=;
 b=yho5f8HAZzHFkdkTEYPbljAMfwwycwO69pSzRwQLrcnoWHCf57qY8oG1lELvq0j5m1
 jWXuSWeqjHDk67a+/enq8vS74tg6PxLzOSTbh2DxQWmKERT6n4LMWbynKCRgS5HlW4K0
 CudErnirJuwfkBXl9W72KIkUitkgvg2C7U4cWLXKuuKR8CFnGUv1AKLamDfZVM3PxCYY
 e/dd20ZT/4JXYkJnJE7rs87bE9M+GJORTj5fFTpCuoiBMN6okmfbxxxGWvTTQNa7VcGq
 T/m3fSt9MM/1sV0B/cyVyXtt88AWlWvL3NK7cfgzVzDhfmf3m/sPqr2nuc96C16pV0Fe
 eHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608188; x=1718212988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beguJUoSFFdVi2mRlnibzIyTiqohzf3HoFh6eO7lEKM=;
 b=s2wFc2TLDaOuBVPk1AWY/qzfz8GwzWIj81lSB7eCiOVRzSHVnrIyTr++uQiSan4jmP
 xPY0qgmlY7vocU2xag/WFR4GHbGPcTM2Cmbg9ITc8HIwFYYs1daYAGkcdomlOylycYQ3
 by+HX5trIO3v+/Ew72eC/zqxdrDxpTSH657HMTRs9fEkLl6/Vy2FS2kelhgGZPfrxz84
 0LPfdhv/4IcO1e27jq25p3SWb6rOKqOpfhe6jjcxYik2EInEWFhUbert9KUArS1IWTyC
 C8vq5V9SDrfA5xUGxoQngrdcxdJFrMVheZlect2kE2itG2mD+pceW8WB+4e7ZegNjikY
 +4TQ==
X-Gm-Message-State: AOJu0YxpzT5US7SQ3i7Lp9I/WUrguLtzWSvDoFNn2h84M6+SMHGW24tI
 OZmwxtXoCIr4n8bcNkjNsSB7N8NVoD4m4SpI9n4Ipbp+jud07NYJ5Vs8It8lynX2l3XUBx9SLaa
 7
X-Google-Smtp-Source: AGHT+IGXOT6usKaMRysF2Yk5QcERyhfl5SrQJFBL2VNVuuXMsrtZS0VhOWCHrgTpCvr0P4T2SCH4Vw==
X-Received: by 2002:a17:90b:f8c:b0:2bd:fa57:b35c with SMTP id
 98e67ed59e1d1-2c27db1b5d7mr2921868a91.28.1717608188139; 
 Wed, 05 Jun 2024 10:23:08 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/38] target/sparc: Implement FCHKSM16
Date: Wed,  5 Jun 2024 10:22:29 -0700
Message-Id: <20240605172253.356302-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  1 +
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 32 ++++++++++++++++++++++++++++++++
 target/sparc/vis_helper.c | 23 +++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 84435b0932..e59307efc2 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -110,6 +110,7 @@ DEF_HELPER_FLAGS_3(bshuffle, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8be808d065..18d068d2af 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -410,6 +410,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
                 &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
 
+    FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @d_d_d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2b0a1f5a9a..b8ba8eea74 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -788,6 +788,37 @@ static void gen_op_fmuld8sux16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
     tcg_gen_concat_i32_i64(dst, t0, t1);
 }
 
+#ifdef TARGET_SPARC64
+static void gen_vec_fchksm16(unsigned vece, TCGv_vec dst,
+                             TCGv_vec src1, TCGv_vec src2)
+{
+    TCGv_vec a = tcg_temp_new_vec_matching(dst);
+    TCGv_vec c = tcg_temp_new_vec_matching(dst);
+
+    tcg_gen_add_vec(vece, a, src1, src2);
+    tcg_gen_cmp_vec(TCG_COND_LTU, vece, c, a, src1);
+    /* Vector cmp produces -1 for true, so subtract to add carry. */
+    tcg_gen_sub_vec(vece, dst, a, c);
+}
+
+static void gen_op_fchksm16(unsigned vece, uint32_t dofs, uint32_t aofs,
+                            uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_cmp_vec, INDEX_op_add_vec, INDEX_op_sub_vec,
+    };
+    static const GVecGen3 op = {
+        .fni8 = gen_helper_fchksm16,
+        .fniv = gen_vec_fchksm16,
+        .opt_opc = vecop_list,
+        .vece = MO_16,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &op);
+}
+#else
+#define gen_op_fchksm16   ({ qemu_build_not_reached(); NULL; })
+#endif
+
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -4761,6 +4792,7 @@ TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
 TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
 TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
 TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
 
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 20baa4ff71..fa607375d2 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -389,3 +389,26 @@ uint64_t helper_cmask32(uint64_t gsr, uint64_t src)
 
     return deposit64(gsr, 32, 32, mask);
 }
+
+static inline uint16_t do_fchksm16(uint16_t src1, uint16_t src2)
+{
+    uint16_t a = src1 + src2;
+    uint16_t c = a < src1;
+    return a + c;
+}
+
+uint64_t helper_fchksm16(uint64_t src1, uint64_t src2)
+{
+    VIS64 r, s1, s2;
+
+    s1.ll = src1;
+    s2.ll = src2;
+    r.ll = 0;
+
+    r.VIS_W64(0) = do_fchksm16(s1.VIS_W64(0), s2.VIS_W64(0));
+    r.VIS_W64(1) = do_fchksm16(s1.VIS_W64(1), s2.VIS_W64(1));
+    r.VIS_W64(2) = do_fchksm16(s1.VIS_W64(2), s2.VIS_W64(2));
+    r.VIS_W64(3) = do_fchksm16(s1.VIS_W64(3), s2.VIS_W64(3));
+
+    return r.ll;
+}
-- 
2.34.1


