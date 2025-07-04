Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC520C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEt-0001XD-Kd; Fri, 04 Jul 2025 12:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEa-0000jl-56
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEX-0006KI-Oq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a528243636so651575f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646352; x=1752251152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eCojNuQY4P2XhaiS4C7kcU4btBv1spfK7AgG+eFyST4=;
 b=VfOurZWtuKDglnOLckUTYe8G05h7rrz0a9H6E94eHdANMZm9zFaPCKHTkAWHZa8oz+
 PZqsJkB8BsPjhCUWzywOJ4r/1EMuY33tnrqMq4iEiBTB7pEyrr/qXYCZqm1ikR3U0IoX
 NGV9WMcIWF1fYppZjELxh86jFbhhjdLoIEkiUeJViJVO1pZdOkQ7b+DlcrM6Wwc5QhPC
 pXmNzeD3KOz2ldSpVtidmwZPwwJbr/mV/2yIyXTVoPbNq5zycXoJbFuK4rBVKCbrP07M
 zpnGxIjnpLYsc5ypWifVMIRcLS98WL10y6WAyduRP/IvIk7vEPk0xuMg2F0gRCTtN6j1
 /WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646352; x=1752251152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCojNuQY4P2XhaiS4C7kcU4btBv1spfK7AgG+eFyST4=;
 b=TMKStjnS8LSZQB40VsC23lvVW1zLxbyUpjrg18RRdEVfBA9K+yhDn2RAmzWDjVnugV
 ndxBfTZo0JEBHw0Smz9BDSIbzSNx1xOvvYutRsoUoocM+lxcFrtjVABjEQGDoH7x3v9p
 KY5fIeAPeM1PFCnJJl5CM2qplU83V67ezKqH6CsxppOed0PawX33aBFCNlok/5w8axLB
 9MawKWQ5pUMJp7F21zUcEORbd4okgUQjs7TiZnqIuiztMluGiTu50MaXly2hFbEemARj
 BTLRkdH4Mu2n1G/iySmTyZln+BMvSsmE0UUyKfcqUGcJi3ePJj10TmbbfqPxDdEqNR8J
 NLZA==
X-Gm-Message-State: AOJu0Yxvnp3j8UpbnDSde/LzP5lndxyIlpzj9sYwVYcQmbAEypLrdfFj
 wdHdoHuv8aZwlV1qrd8+42WNR/i4/n+IMkDrsnCBpErC0k93oPg6KqbBWOeAU5Chw59vcayoqa+
 P2tkQ
X-Gm-Gg: ASbGncuo8q6OKeLlhX6KOODwF9YYHRvfaW1NgrQKhrgsUADv/HqUAzXv+5TTyAxlwia
 s4Y5prpAA9DfSZjLdn+360opNOmyHPk0NGWvsjJ88U+SASF5I05Bh+yLYWAUfXrHomu1kLGcq3H
 pXSQIVsfVzyKkVMJqgno22FaQNSlwLISuGlvu+4TglBfZ1OT/w4bG5je0Q6GKAk5mZA/KJLOrjG
 MFa7m8FQ6PCSjYgrnGzynURhaxrw3yni97gw9LXHj7m4P4hfydeBDmJB6wghK5QRcuuKiqOHoO4
 rsh247uhctO04ZDsM2eVn4n3nmctIV+glMWdnpr/FVQGL0xPlMIZaaF+jM+fj5AUt3wB
X-Google-Smtp-Source: AGHT+IHdkqBR3O8LjyFvJlls2ZQ9RXC1mnvAPM7gOQvuSunkWaw7d+226fDZKyEjjE7U6IIFvQc7PQ==
X-Received: by 2002:a05:6000:24c6:b0:3a5:7904:b959 with SMTP id
 ffacd0b85a97d-3b4964e9007mr2481020f8f.58.1751646351799; 
 Fri, 04 Jul 2025 09:25:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 053/119] target/arm: Implemement SME2 SDOT, UDOT, USDOT, SUDOT
Date: Fri,  4 Jul 2025 17:23:53 +0100
Message-ID: <20250704162501.249138-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704142112.1018902-42-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h        |  8 ++++
 target/arm/tcg/sme.decode      | 63 ++++++++++++++++++++++++-
 target/arm/tcg/translate-sme.c | 85 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 51 ++++++++++++++++++++
 4 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index a19955b872f..c4a208e3ba8 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -622,6 +622,9 @@ DEF_HELPER_FLAGS_5(gvec_sdot_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_usdot_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_sdot_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_sdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_idx_4b, TCG_CALL_NO_RWG,
@@ -635,6 +638,11 @@ DEF_HELPER_FLAGS_5(gvec_sudot_idx_4b, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_usdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_sdot_idx_2h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_idx_2h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 7c057bcad20..338637decd6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -291,6 +291,26 @@ FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
 BFDOT_n1        11000001 001 0 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=2
 BFDOT_n1        11000001 001 1 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=4
 
+USDOT_n1        11000001 001 0 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=2
+USDOT_n1        11000001 001 1 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=4
+
+SUDOT_n1        11000001 001 0 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=2
+SUDOT_n1        11000001 001 1 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=4
+
+SDOT_n1_4b      11000001 001 0 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=2
+SDOT_n1_4b      11000001 001 1 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=4
+SDOT_n1_4h      11000001 011 0 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=2
+SDOT_n1_4h      11000001 011 1 .... 0 .. 101 ..... 00 ...   @azz_nx1_o3 n=4
+SDOT_n1_2h      11000001 011 0 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=2
+SDOT_n1_2h      11000001 011 1 .... 0 .. 101 ..... 01 ...   @azz_nx1_o3 n=4
+
+UDOT_n1_4b      11000001 001 0 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=2
+UDOT_n1_4b      11000001 001 1 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=4
+UDOT_n1_4h      11000001 011 0 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=2
+UDOT_n1_4h      11000001 011 1 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=4
+UDOT_n1_2h      11000001 011 0 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=2
+UDOT_n1_2h      11000001 011 1 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -334,6 +354,23 @@ FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
 BFDOT_nn        11000001 101 ....0 0 .. 100 ....0 10 ...    @azz_2x2_o3
 BFDOT_nn        11000001 101 ...01 0 .. 100 ...00 10 ...    @azz_4x4_o3
 
+USDOT_nn        11000001 101 ....0 0 .. 101 ....0 01 ...    @azz_2x2_o3
+USDOT_nn        11000001 101 ...01 0 .. 101 ...00 01 ...    @azz_4x4_o3
+
+SDOT_nn_4b      11000001 101 ....0 0 .. 101 ....0 00 ...    @azz_2x2_o3
+SDOT_nn_4b      11000001 101 ...01 0 .. 101 ...00 00 ...    @azz_4x4_o3
+SDOT_nn_4h      11000001 111 ....0 0 .. 101 ....0 00 ...    @azz_2x2_o3
+SDOT_nn_4h      11000001 111 ...01 0 .. 101 ...00 00 ...    @azz_4x4_o3
+SDOT_nn_2h      11000001 111 ....0 0 .. 101 ....0 01 ...    @azz_2x2_o3
+SDOT_nn_2h      11000001 111 ...01 0 .. 101 ...00 01 ...    @azz_4x4_o3
+
+UDOT_nn_4b      11000001 101 ....0 0 .. 101 ....0 10 ...    @azz_2x2_o3
+UDOT_nn_4b      11000001 101 ...01 0 .. 101 ...00 10 ...    @azz_4x4_o3
+UDOT_nn_4h      11000001 111 ....0 0 .. 101 ....0 10 ...    @azz_2x2_o3
+UDOT_nn_4h      11000001 111 ...01 0 .. 101 ...00 10 ...    @azz_4x4_o3
+UDOT_nn_2h      11000001 111 ....0 0 .. 101 ....0 11 ...    @azz_2x2_o3
+UDOT_nn_2h      11000001 111 ...01 0 .. 101 ...00 11 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -367,7 +404,11 @@ BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
 @azx_2x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
                 &azx_n n=2 rv=%mova_rv zn=%zn_ax2
 @azx_4x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
-                &azx_n n=2 rv=%mova_rv zn=%zn_ax4
+                &azx_n n=4 rv=%mova_rv zn=%zn_ax4
+@azx_2x1_i1_o3  ........ .... zm:4 . .. .. idx:1 .... ... off:3 \
+                &azx_n n=2 rv=%mova_rv zn=%zn_ax2
+@azx_4x1_i1_o3  ........ .... zm:4 . .. .. idx:1 .... ... off:3 \
+                &azx_n n=4 rv=%mova_rv zn=%zn_ax4
 
 FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
 FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
@@ -377,3 +418,23 @@ BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
 
 FVDOT           11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
 BFVDOT          11000001 0101 .... 0 .. 0 .. ....0 11 ...   @azx_2x1_i2_o3
+
+SDOT_nx_2h      11000001 0101 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_i2_o3
+SDOT_nx_2h      11000001 0101 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_i2_o3
+SDOT_nx_4b      11000001 0101 .... 0 .. 1 .. ....1 00 ...   @azx_2x1_i2_o3
+SDOT_nx_4b      11000001 0101 .... 1 .. 1 .. ...01 00 ...   @azx_4x1_i2_o3
+SDOT_nx_4h      11000001 1101 .... 0 .. 00 . ....0 01 ...   @azx_2x1_i1_o3
+SDOT_nx_4h      11000001 1101 .... 1 .. 00 . ...00 01 ...   @azx_4x1_i1_o3
+
+UDOT_nx_2h      11000001 0101 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_i2_o3
+UDOT_nx_2h      11000001 0101 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_i2_o3
+UDOT_nx_4b      11000001 0101 .... 0 .. 1 .. ....1 10 ...   @azx_2x1_i2_o3
+UDOT_nx_4b      11000001 0101 .... 1 .. 1 .. ...01 10 ...   @azx_4x1_i2_o3
+UDOT_nx_4h      11000001 1101 .... 0 .. 00 . ....0 11 ...   @azx_2x1_i1_o3
+UDOT_nx_4h      11000001 1101 .... 1 .. 00 . ...00 11 ...   @azx_4x1_i1_o3
+
+USDOT_nx        11000001 0101 .... 0 .. 1 .. ....1 01 ...   @azx_2x1_i2_o3
+USDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 01 ...   @azx_4x1_i2_o3
+
+SUDOT_nx        11000001 0101 .... 0 .. 1 .. ....1 11 ...   @azx_2x1_i2_o3
+SUDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 11 ...   @azx_4x1_i2_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 410a8d037c0..341f4495e92 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -962,3 +962,88 @@ static bool do_vdot(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4_ptr *fn)
 
 TRANS_FEAT(FVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
 TRANS_FEAT(BFVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_bfvdot_idx)
+
+/*
+ * Expand array multi-vector single (n1), array multi-vector (nn),
+ * and array multi-vector indexed (nx), for integer accumulate.
+ *   multi: true for nn, false for n1.
+ *   data: stuff for simd_data, including any index.
+ */
+static bool do_azz_acc(DisasContext *s, int nreg, int nsel,
+                       int rv, int off, int zn, int zm,
+                       int data, int shsel, bool multi,
+                       gen_helper_gvec_4 *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg, nsel);
+        TCGv_ptr t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < nreg; ++r) {
+            TCGv_ptr t_zn = vec_full_reg_ptr(s, zn);
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm);
+
+            for (int i = 0; i < nsel; ++i) {
+                int o_za = (r * vstride + i) * sizeof(ARMVectorReg);
+                int desc = simd_desc(svl, svl, data | (i << shsel));
+
+                tcg_gen_addi_ptr(t, t_za, o_za);
+                fn(t, t_zn, t_zm, t, tcg_constant_i32(desc));
+            }
+
+            /*
+             * For multiple-and-single vectors, Zn may wrap.
+             * For multiple vectors, both Zn and Zm are aligned.
+             */
+            zn = (zn + 1) % 32;
+            zm += multi;
+        }
+    }
+    return true;
+}
+
+static bool do_dot(DisasContext *s, arg_azz_n *a, bool multi,
+                   gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+static void gen_helper_gvec_sudot_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                     TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_gvec_usdot_4b(d, m, n, a, desc);
+}
+
+TRANS_FEAT(USDOT_n1, aa64_sme2, do_dot, a, false, gen_helper_gvec_usdot_4b)
+TRANS_FEAT(SUDOT_n1, aa64_sme2, do_dot, a, false, gen_helper_gvec_sudot_4b)
+TRANS_FEAT(SDOT_n1_2h, aa64_sme2, do_dot, a, false, gen_helper_gvec_sdot_2h)
+TRANS_FEAT(UDOT_n1_2h, aa64_sme2, do_dot, a, false, gen_helper_gvec_udot_2h)
+TRANS_FEAT(SDOT_n1_4b, aa64_sme2, do_dot, a, false, gen_helper_gvec_sdot_4b)
+TRANS_FEAT(UDOT_n1_4b, aa64_sme2, do_dot, a, false, gen_helper_gvec_udot_4b)
+TRANS_FEAT(SDOT_n1_4h, aa64_sme2_i16i64, do_dot, a, false, gen_helper_gvec_sdot_4h)
+TRANS_FEAT(UDOT_n1_4h, aa64_sme2_i16i64, do_dot, a, false, gen_helper_gvec_udot_4h)
+
+TRANS_FEAT(USDOT_nn, aa64_sme2, do_dot, a, true, gen_helper_gvec_usdot_4b)
+TRANS_FEAT(SDOT_nn_2h, aa64_sme2, do_dot, a, true, gen_helper_gvec_sdot_2h)
+TRANS_FEAT(UDOT_nn_2h, aa64_sme2, do_dot, a, true, gen_helper_gvec_udot_2h)
+TRANS_FEAT(SDOT_nn_4b, aa64_sme2, do_dot, a, true, gen_helper_gvec_sdot_4b)
+TRANS_FEAT(UDOT_nn_4b, aa64_sme2, do_dot, a, true, gen_helper_gvec_udot_4b)
+TRANS_FEAT(SDOT_nn_4h, aa64_sme2_i16i64, do_dot, a, true, gen_helper_gvec_sdot_4h)
+TRANS_FEAT(UDOT_nn_4h, aa64_sme2_i16i64, do_dot, a, true, gen_helper_gvec_udot_4h)
+
+static bool do_dot_nx(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                      a->idx, 0, false, fn);
+}
+
+TRANS_FEAT(USDOT_nx, aa64_sme2, do_dot_nx, a, gen_helper_gvec_usdot_idx_4b)
+TRANS_FEAT(SUDOT_nx, aa64_sme2, do_dot_nx, a, gen_helper_gvec_sudot_idx_4b)
+TRANS_FEAT(SDOT_nx_2h, aa64_sme2, do_dot_nx, a, gen_helper_gvec_sdot_idx_2h)
+TRANS_FEAT(UDOT_nx_2h, aa64_sme2, do_dot_nx, a, gen_helper_gvec_udot_idx_2h)
+TRANS_FEAT(SDOT_nx_4b, aa64_sme2, do_dot_nx, a, gen_helper_gvec_sdot_idx_4b)
+TRANS_FEAT(UDOT_nx_4b, aa64_sme2, do_dot_nx, a, gen_helper_gvec_udot_idx_4b)
+TRANS_FEAT(SDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_sdot_idx_4h)
+TRANS_FEAT(UDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_udot_idx_4h)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f18d1675b50..baea6d8b894 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -872,6 +872,57 @@ DO_DOT_IDX(gvec_usdot_idx_4b, int32_t, uint8_t, int8_t, H4)
 DO_DOT_IDX(gvec_sdot_idx_4h, int64_t, int16_t, int16_t, H8)
 DO_DOT_IDX(gvec_udot_idx_4h, uint64_t, uint16_t, uint16_t, H8)
 
+#undef DO_DOT
+#undef DO_DOT_IDX
+
+/* Similar for 2-way dot product */
+#define DO_DOT(NAME, TYPED, TYPEN, TYPEM) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
+{                                                                         \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                \
+    TYPED *d = vd, *a = va;                                               \
+    TYPEN *n = vn;                                                        \
+    TYPEM *m = vm;                                                        \
+    for (i = 0; i < opr_sz / sizeof(TYPED); ++i) {                        \
+        d[i] = (a[i] +                                                    \
+                (TYPED)n[i * 2 + 0] * m[i * 2 + 0] +                      \
+                (TYPED)n[i * 2 + 1] * m[i * 2 + 1]);                      \
+    }                                                                     \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                              \
+}
+
+#define DO_DOT_IDX(NAME, TYPED, TYPEN, TYPEM, HD) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
+{                                                                         \
+    intptr_t i = 0, opr_sz = simd_oprsz(desc);                            \
+    intptr_t opr_sz_n = opr_sz / sizeof(TYPED);                           \
+    intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);                  \
+    intptr_t index = simd_data(desc);                                     \
+    TYPED *d = vd, *a = va;                                               \
+    TYPEN *n = vn;                                                        \
+    TYPEM *m_indexed = (TYPEM *)vm + HD(index) * 2;                       \
+    do {                                                                  \
+        TYPED m0 = m_indexed[i * 2 + 0];                                  \
+        TYPED m1 = m_indexed[i * 2 + 1];                                  \
+        do {                                                              \
+            d[i] = (a[i] +                                                \
+                    n[i * 2 + 0] * m0 +                                   \
+                    n[i * 2 + 1] * m1);                                   \
+        } while (++i < segend);                                           \
+        segend = i + (16 / sizeof(TYPED));                                \
+    } while (i < opr_sz_n);                                               \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                              \
+}
+
+DO_DOT(gvec_sdot_2h, int32_t, int16_t, int16_t)
+DO_DOT(gvec_udot_2h, uint32_t, uint16_t, uint16_t)
+
+DO_DOT_IDX(gvec_sdot_idx_2h, int32_t, int16_t, int16_t, H4)
+DO_DOT_IDX(gvec_udot_idx_2h, uint32_t, uint16_t, uint16_t, H4)
+
+#undef DO_DOT
+#undef DO_DOT_IDX
+
 void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
                          float_status *fpst, uint32_t desc)
 {
-- 
2.43.0


