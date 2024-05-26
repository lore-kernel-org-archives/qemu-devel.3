Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04291C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlx-0008Hp-M4; Sun, 26 May 2024 15:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlu-0008FG-Ms
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:10 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlt-0007ez-0P
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:10 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-652fd0bb5e6so4470218a12.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752586; x=1717357386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUFdBv3nJ6wuu3KYC28pKJ/A2t0NghmJ6QPIQSbw7kA=;
 b=w8dgQAT6rFGjsajSnWUnuIUjiZcvXBQnUqDglpmerQF/y5VsmVkl5xmxqByl/fTOq0
 DPyYDY/Ii8digxHOUzwMxdDIi0CEENEyBeHOMEgxrlX12OFSzvWkoVpHdpdWcU0C5Mn/
 BBgdE647BFgM8dJ8cyr9hgF2DTqo8A7+fYxx0FS3YlH/4EeqtNfqLtUNp2rdAVHeQtzM
 g2tLTk0VzE88O3L0+Y7D3b/6XFpnqtPj9xjurtmvi2uFo76jrOZU9YZlyEeb+GSlN4CI
 51/8hMnjFyNbQQYKwCEywMDu+c1kwNCm3CZUn7ZbVAIs4ozBIL4QcIWGgIQB0An2G3We
 2sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752586; x=1717357386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUFdBv3nJ6wuu3KYC28pKJ/A2t0NghmJ6QPIQSbw7kA=;
 b=O2pQ41lrwkgImVlwYNqeA+tcyDkPShT0UpRtjKekOW+MPmPEmUML+Tb6i5Ta4ZIeyL
 9PG8iyZLPFGGe3EHf9BgcCIWprjQgyQJZgpAzyFKgoQZ8cs6NRcErRmLTg7WmHGfp9kl
 HoIcAUBXeyyCc7lAXYw9RwIZwOWJ/GqXROz0Om1mhMDfabiLfUXEee0KvitDfSPip9+A
 3NjzT9ZqbnAh3D63vsUwDE1Jb5Fef/noo4agMjgi5kqPQ7bA5brB4pnITf52g2kP8zDM
 AtB37tZ4es5Dh/CYBWfQ7Q20UP/8L8qJPiS18SvH1Aq03lqzstLCoJKzCneADkZH17HU
 30Kw==
X-Gm-Message-State: AOJu0Yxzdiv/kuhdphAxGweH8tvPS60KEl0dVPBUS+rVocEpyD1ZGvkp
 OBQOGx/HcF1wyUIuoesfMkBFFeDd65Nah8m/h9sy4bBCt91SdnAJDiPRTud6RGKEMKt4xGMJacM
 J
X-Google-Smtp-Source: AGHT+IHfJasnV+UcXvlTWvBiXXnBeIfBREiepc4hAsbZkyXF8kbQ8sO8+gP/yJdYDh3+o/lcZl7obQ==
X-Received: by 2002:a17:902:c407:b0:1f3:e8e:d3b7 with SMTP id
 d9443c01a7336-1f4486d50a6mr109533655ad.4.1716752585702; 
 Sun, 26 May 2024 12:43:05 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/37] target/sparc: Implement FCHKSM16
Date: Sun, 26 May 2024 12:42:30 -0700
Message-Id: <20240526194254.459395-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
index 66c6fb6e41..48ee1abd68 100644
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
@@ -4757,6 +4788,7 @@ TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
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


