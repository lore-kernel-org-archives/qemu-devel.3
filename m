Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7187DCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZBZ-00014U-44; Tue, 16 Jun 2026 15:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Z-0004my-Vh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8V-0001GM-RZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so53333385e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636866; x=1782241666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=It2pF6sViWJlDXaYTTIEvh4jj09OMY/MajD0dUSjtmM=;
 b=LBy0+z3goQMSg1ba0lzzCO9As4cBvNnXNuaBBS0kMCTLeRATpvvdXHh/YWHKGgSChX
 PtDLTNvT0+Jo50xmc6r2RcF46PAJ6x/brmVX9LPIzXrrciar86258Wx/XPwaP+1VlS4C
 IZlHN3kimDfIHcU2gq+hKhwdNkw2kJFyuovsE+McJSyo9UmmF6Fx9Qp+H9flJnUPvrmk
 N2//Cpxk4rsSxaMxDxfJ8DL3OlqxQcCl8laY5K0/KC/CfIbm+9koDAu4UgX2ARzOZmRE
 MFKfwtETW81OlTfZAjhCAkUKjsOEVkU8PdJ9x+ss0FbTgWLtNr27kluw+ut0JLGiMN5e
 2CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636866; x=1782241666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=It2pF6sViWJlDXaYTTIEvh4jj09OMY/MajD0dUSjtmM=;
 b=Tn8NiZd2pONEMVwuWsT/9MPoDjJMSTkSie88FWLrh2mHjDFEsXRX3oyBotpG3OdOt3
 3KnhYojER5IeUmTHYW5qjS0odJE+jooqZqgTIQ43DBiSTYH0m6ZelFqg4Gr/f7wWFjhS
 PrcoPZUPaWJFdURSyt7GScvs/55B4ci/CuDbw0CYkSQBTQat+ESVeduMGmHfy1HMRndX
 8TnfA+qbJSOZuqNZ4W92De195Oj2iLpXc4PGz2Vov2VEZhB7KBX+TcFWcMLVK10q+x9D
 eCX2ebezQ8dj1PJlb79Oa0XWKFmbRx7iJVUz82XPTFKT/atM7AA9StIXHl0NH9+3IFtB
 SOtA==
X-Gm-Message-State: AOJu0YyKqnH4fJqu6gb8Ltrt+RFfvR2/8LsuC9j8lQS9+aOjq+EBdYMF
 UcLzZbBokFlnu525vSnDs/etRPpK3Z/DHO1v4iBuEL5/9tRQn1VAnZvqXCnxCw5v4SGS6XtsUy7
 OAuPY
X-Gm-Gg: Acq92OFixGRln6MCQxhiIMaYRNGNkQ0OUsF/oINu9l5FU4qQXWOgz9hJrFQdXII6NYF
 KLg38SNHOw3WpuJIdwKlmgvZ5yiADwUL2Xlue8HP3kheZXfbUZuJ2fcolAYdKPJCpsYPXP6soql
 /+Ir+XJmFYIWAaoRva+cQzAtsteF+L8S+OmraWB3OzEa3rhDgzrx3RLlVcfrPonadvgWUJ0/AIP
 ZY/8yQNANZQ5PGy1rDosbA/bVPh1goxmwcLS+lB0wnapywACJ0//6WMSWj2mVjkP7avyWytINHt
 9IDOaNAY8Luu9IcVCVUMyUuVUdl5/QfvodnGjkT5CF9J7AyIhiCFcA/JzeuIIbD9Npsjmk9kQDQ
 7yWikNrFKrOl1U2hFdNkPim+FhJmKTwdidKcuSiPcDM/1GSSCHdIBYD33iai5VNC8LKejfhFD85
 a/+ixTai323Jmw1cen0N6oXbVv+GQ02nTbRC8g0k7+m0cXQMq0aD5qGOhgEHCidbTVbjfDZ87+q
 1Z0zpspzI2+KJtXnx6wRbJV/LQD1im8YnHFdlXIQ3c=
X-Received: by 2002:a05:600c:1e0f:b0:490:e5c1:b88d with SMTP id
 5b1f17b1804b1-492333babfbmr14323085e9.1.1781636866092; 
 Tue, 16 Jun 2026 12:07:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/61] target/arm: Implement FRINT{32,64}{X,Z}
Date: Tue, 16 Jun 2026 20:06:35 +0100
Message-ID: <20260616190639.3462006-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-id: 20260604234852.573178-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  9 ++++++++
 target/arm/tcg/sve.decode        | 20 ++++++++++++++++++
 target/arm/tcg/sve_helper.c      |  5 +++++
 target/arm/tcg/translate-sve.c   | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index f97c31763f..de2254bb19 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -1441,6 +1441,15 @@ DEF_HELPER_FLAGS_5(sve_frintx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_frintx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(sve2p2_frint32_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p2_frint64_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p2_frint32_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p2_frint64_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_frecpx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frecpx_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 7460eee4a9..5c814c7769 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1259,6 +1259,26 @@ FRINTA_z        01100100 .. 011 001 100 ... ..... .....         @rd_pg_rn
 FRINTX_z        01100100 .. 011 001 110 ... ..... .....         @rd_pg_rn
 FRINTI_z        01100100 .. 011 001 111 ... ..... .....         @rd_pg_rn
 
+FRINT32X_s_m    01100101 00 010 001 101 ... ..... .....         @rd_pg_rn_e0
+FRINT32X_d_m    01100101 00 010 011 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_s_m    01100101 00 010 101 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_d_m    01100101 00 010 111 101 ... ..... .....         @rd_pg_rn_e0
+
+FRINT32X_s_z    01100100 00 011 100 101 ... ..... .....         @rd_pg_rn_e0
+FRINT32X_d_z    01100100 00 011 100 111 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_s_z    01100100 00 011 101 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64X_d_z    01100100 00 011 101 111 ... ..... .....         @rd_pg_rn_e0
+
+FRINT32Z_s_m    01100101 00 010 000 101 ... ..... .....         @rd_pg_rn_e0
+FRINT32Z_d_m    01100101 00 010 010 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_s_m    01100101 00 010 100 101 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_d_m    01100101 00 010 110 101 ... ..... .....         @rd_pg_rn_e0
+
+FRINT32Z_s_z    01100100 00 011 100 100 ... ..... .....         @rd_pg_rn_e0
+FRINT32Z_d_z    01100100 00 011 100 110 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_s_z    01100100 00 011 101 100 ... ..... .....         @rd_pg_rn_e0
+FRINT64Z_d_z    01100100 00 011 101 110 ... ..... .....         @rd_pg_rn_e0
+
 # SVE floating-point unary operations
 FRECPX_m        01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
 FSQRT_m         01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 1711444800..f8e62cb11b 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5017,6 +5017,11 @@ DO_ZPZ_FP(sve_frintx_h, uint16_t, H1_2, float16_round_to_int)
 DO_ZPZ_FP(sve_frintx_s, uint32_t, H1_4, float32_round_to_int)
 DO_ZPZ_FP(sve_frintx_d, uint64_t, H1_8, float64_round_to_int)
 
+DO_ZPZ_FP(sve2p2_frint32_s, uint32_t, H1_4, helper_frint32_s)
+DO_ZPZ_FP(sve2p2_frint64_s, uint32_t, H1_4, helper_frint64_s)
+DO_ZPZ_FP(sve2p2_frint32_d, uint64_t, H1_8, helper_frint32_d)
+DO_ZPZ_FP(sve2p2_frint64_d, uint64_t, H1_8, helper_frint64_d)
+
 DO_ZPZ_FP(sve_frecpx_h, uint16_t, H1_2, helper_frecpx_f16)
 DO_ZPZ_FP(sve_frecpx_s, uint32_t, H1_4, helper_frecpx_f32)
 DO_ZPZ_FP(sve_frecpx_d, uint64_t, H1_8, helper_frecpx_f64)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 4ac59664ae..a8d21dedca 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4730,6 +4730,42 @@ TRANS_FEAT(FRINTZ_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
 TRANS_FEAT(FRINTA_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
            FPROUNDING_TIEAWAY, 1, frint_fns[a->esz])
 
+TRANS_FEAT(FRINT32X_s_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_s, a, 0, FPST_A64)
+TRANS_FEAT(FRINT32X_d_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_d, a, 0, FPST_A64)
+TRANS_FEAT(FRINT64X_s_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_s, a, 0, FPST_A64)
+TRANS_FEAT(FRINT64X_d_m, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_d, a, 0, FPST_A64)
+
+TRANS_FEAT(FRINT32X_s_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_s, a, 1, FPST_A64)
+TRANS_FEAT(FRINT32X_d_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint32_d, a, 1, FPST_A64)
+TRANS_FEAT(FRINT64X_s_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_s, a, 1, FPST_A64)
+TRANS_FEAT(FRINT64X_d_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2p2_frint64_d, a, 1, FPST_A64)
+
+TRANS_FEAT(FRINT32Z_s_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint32_s)
+TRANS_FEAT(FRINT32Z_d_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint32_d)
+TRANS_FEAT(FRINT64Z_s_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint64_s)
+TRANS_FEAT(FRINT64Z_d_m, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 0, gen_helper_sve2p2_frint64_d)
+
+TRANS_FEAT(FRINT32Z_s_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint32_s)
+TRANS_FEAT(FRINT32Z_d_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint32_d)
+TRANS_FEAT(FRINT64Z_s_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint64_s)
+TRANS_FEAT(FRINT64Z_d_z, aa64_sme2p2_or_sve2p2, do_frint_mode,
+           a, FPROUNDING_ZERO, 1, gen_helper_sve2p2_frint64_d)
+
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
-- 
2.43.0


