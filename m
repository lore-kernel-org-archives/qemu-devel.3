Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE13C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlx-0008Gi-6n; Sun, 26 May 2024 15:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlv-0008Fq-R5
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlt-0007fk-Rx
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f32b1b5429so29454635ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752588; x=1717357388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuEEN+loJsKuiusYvJ/Q1u1Kx+6cEs2QGFqDhZY42NY=;
 b=gi7T/BeHxJtOcOgc8Af1527oXfvOvvvx2GLmy9akVF/05JIw+otx/mAixqIVptgKZE
 NyEleFoo7BIXmtWbS9mCzsOxAwh83cbzXaw7MF6Vvf2aa7ih4hUc7fO8ztoN0GmDcI9E
 GMPmO/A/1oW7eSuoQzTjftx91MGxEx59PdGqvvMuNUFr0dy1iF7u39CoZs+szuaHPwp/
 kEm0q52QkjAtiMk1QdlQNvnj2vnWcqMRYbo9SgR2IAp+q5gc/atf70L7zU20jkMKB/rR
 B7wST4tm4++hScxlwdILhTn52SHztWZ/toWUffu5IeG6Ck3ormefVZvJW10BX3IIYw8d
 Rw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752588; x=1717357388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuEEN+loJsKuiusYvJ/Q1u1Kx+6cEs2QGFqDhZY42NY=;
 b=YbNN1pOwtSdnGpetB+Wzg679SB1NRO9fmjxcgA2GTCSE0L+x94Icv/pwocBikKGS+p
 ipJY7dUuw1MRIeSotZRhIviS6AOe96GZxECZUZY59aBlOYetHEMvd3YLVo1nCDkfacYH
 MFxXFiPMTSaxh184x6oZIbNM2nKext1BhCJU56Z54t2Q6EiFMkMQ6pZMRxfkaObUYkyF
 gx7iAQ9cz9XJIYCC+sqimRjxARPYR1E7PujlMhpynB+V8QjUTA1vmTdoCln+GSghDVQQ
 sFyIGujrV+sr+zpWPQBkTCSadV42C9fR3HyH/NhhOGE+7hns5VYo6Ue14sR7ipMkfFdw
 2ZPA==
X-Gm-Message-State: AOJu0YyWjeXl9bo6tXDfxDmrwWGvO9osj0/55vfbSsDOmmTzg52N/Fg4
 N41Ypt554FBWb8CFrUihXkJBg1OWK2KMymrVnc+zzzrPwZ9FaKT1qSvvywu60GuSjfCJ4Nuj7aH
 p
X-Google-Smtp-Source: AGHT+IGuYjNc1I6wBfq5s9KCplo1sbZyPqYhyYCKu9rZOxtFl0Uaiymh6NGQLtooo9T3T3vEYl2yEQ==
X-Received: by 2002:a17:903:2290:b0:1f4:5b00:3fa with SMTP id
 d9443c01a7336-1f45b0008d1mr106177975ad.58.1716752588558; 
 Sun, 26 May 2024 12:43:08 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 16/37] target/sparc: Implement FMEAN16
Date: Sun, 26 May 2024 12:42:33 -0700
Message-Id: <20240526194254.459395-17-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  1 +
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 30 ++++++++++++++++++++++++++++++
 target/sparc/vis_helper.c | 21 +++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index ab79954bb5..f1b84dc9b3 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -118,6 +118,7 @@ DEF_HELPER_FLAGS_2(cmask8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmean16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index de29996304..febd1a4a13 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -421,6 +421,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
                 &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
 
+    FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f53ecf7c41..cf5f1ea4d0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -815,8 +815,37 @@ static void gen_op_fchksm16(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &op);
 }
+
+static void gen_vec_fmean16(unsigned vece, TCGv_vec dst,
+                            TCGv_vec src1, TCGv_vec src2)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(dst);
+
+    tcg_gen_or_vec(vece, t, src1, src2);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(dst, vece, 1));
+    tcg_gen_sari_vec(vece, src1, src1, 1);
+    tcg_gen_sari_vec(vece, src2, src2, 1);
+    tcg_gen_add_vec(vece, dst, src1, src2);
+    tcg_gen_add_vec(vece, dst, dst, t);
+}
+
+static void gen_op_fmean16(unsigned vece, uint32_t dofs, uint32_t aofs,
+                           uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_add_vec, INDEX_op_sari_vec,
+    };
+    static const GVecGen3 op = {
+        .fni8 = gen_helper_fmean16,
+        .fniv = gen_vec_fmean16,
+        .opt_opc = vecop_list,
+        .vece = MO_16,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &op);
+}
 #else
 #define gen_op_fchksm16   ({ qemu_build_not_reached(); NULL; })
+#define gen_op_fmean16    ({ qemu_build_not_reached(); NULL; })
 #endif
 
 static void finishing_insn(DisasContext *dc)
@@ -4840,6 +4869,7 @@ TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
 TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
 TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
 TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
+TRANS(FMEAN16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fmean16)
 
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index fa607375d2..6ef36755c3 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -412,3 +412,24 @@ uint64_t helper_fchksm16(uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+static inline int16_t do_fmean16(int16_t src1, int16_t src2)
+{
+    return (src1 + src2 + 1) / 2;
+}
+
+uint64_t helper_fmean16(uint64_t src1, uint64_t src2)
+{
+    VIS64 r, s1, s2;
+
+    s1.ll = src1;
+    s2.ll = src2;
+    r.ll = 0;
+
+    r.VIS_SW64(0) = do_fmean16(s1.VIS_SW64(0), s2.VIS_SW64(0));
+    r.VIS_SW64(1) = do_fmean16(s1.VIS_SW64(1), s2.VIS_SW64(1));
+    r.VIS_SW64(2) = do_fmean16(s1.VIS_SW64(2), s2.VIS_SW64(2));
+    r.VIS_SW64(3) = do_fmean16(s1.VIS_SW64(3), s2.VIS_SW64(3));
+
+    return r.ll;
+}
-- 
2.34.1


