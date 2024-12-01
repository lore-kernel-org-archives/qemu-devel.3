Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB7AD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlaw-00011w-Vt; Sun, 01 Dec 2024 10:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaJ-00080H-R1
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:10 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaF-00059I-IZ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:06 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f1dfb0b44dso999024eaf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065802; x=1733670602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13TTeB57GF3aDCoJALaGqt5AgpHPFXwUQPIcEqJXoVM=;
 b=T090tf0LmCFhSQCvuxdiSFGD3Y+oM4MjGOt/O5O6tz1uOmFbByorVnD5fNrrFxM7mJ
 Tz5J1n9mabBqFMOacR3FvQCmDamrX8RtgVp7+NVEqYJaCpHG1RUBDQElo6QPujpQm9Ip
 Jn1SpQCVzcqxFaq9z7msaw+IpW+dbjZuQelDFAB79NGPfjoqn3neb5rsabXzmOcUIH0M
 EG5yfzMkRIFPhJ4vcBdF3QQwuuqHLs8mpNbDOqwebiA+dbiA4FDsGChHurfhWYGLnVWs
 sllhfFrhU8+nuyutTN+c4zcpmkOLqFh+6jlbnfvlye3qWi+tfH9HI+viyIAs4pxwYxjG
 UIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065802; x=1733670602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13TTeB57GF3aDCoJALaGqt5AgpHPFXwUQPIcEqJXoVM=;
 b=Gxl5YcnZLNRx4rZUJ7ftVNDOYwZFaJQeo/C4JRAgzAVRVKKiiTOhPV2a0jtM86pZTu
 0bXengMu2YggRKm8IedSWW1XbxnzNRDDet8kkE+68qUKxa7y6TZzmo8dxFG0INOM8dGa
 4MypNsPdWB7vdAk9sptRKXRzJSaGP/I4y8Msvec2GmoXaLOG8X5z+LhuOTShoJ4nS1fX
 nAIgCRzbfTpMHMCe74l6ff/SmUSXWBX+CK0zH+JdBfYfdudl+dPJXTKB23bwBnDRZRLR
 GD345PF1DNd2Yxk+77CAtQZVFZgl/bcMIvnyOndZ24RDXaGMAFRlP1ixpF8K2PVy2/YA
 /p9w==
X-Gm-Message-State: AOJu0Yyv/1Sg3003JlHkekhZvl6O7JyhWHmZP2DYon6m5xJFcwxP5MRs
 i8ESIgwVbei/FObZMIqiezMSOY76HlK6bH7bof1D45kNWbWCl41tFxJFvKsFsDZ9yr1nCvBd2aB
 yhn0=
X-Gm-Gg: ASbGnctalXmtVNWh1luhh8NJLYSusLl1BYj2/NyCyYzUlhE8IUI19ceXQ3uuy7GzALL
 Ws0YpJpGMW5zTNOssvORSdfvIUwokSl9pHirGOiP/nOCBrV5hpEkLO2hFzibkFDDwpZWDHGbVnE
 Z8aRrQMlBq/CxvN1UhVBeGb21XOw0m4HuMIJhYZdl45dowjdZYA0KZeA8nXsGD1wMiMCIM9+sF4
 cXNGa8cpf1jx+r49NmDVegVvtVf72mG0quw/01eIarnGSVQqE2natxoTlJEsuflgiNcwkflq6rD
 19LAAwSfCOjhKiZGSK+h9bAD4H5XS7odDRJV
X-Google-Smtp-Source: AGHT+IHr8AcHjIG9hzrKF2UGqbPcqe1uwpaVJijtgMRDZ/ys/Yt0SFxrsFP1RrPKTZlkmubKL4nlvw==
X-Received: by 2002:a05:6830:2aa8:b0:71d:4196:d92e with SMTP id
 46e09a7af769-71d65cc2d84mr13831383a34.18.1733065802362; 
 Sun, 01 Dec 2024 07:10:02 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 47/67] target/arm: Introduce clear_vec
Date: Sun,  1 Dec 2024 09:05:46 -0600
Message-ID: <20241201150607.12812-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

In a couple of places, clearing the entire vector before storing one
element is the easiest solution.  Wrap that into a helper function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c6cc1c9e09..9b2ff20413 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -628,7 +628,16 @@ static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
     return v;
 }
 
-/* Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
+static void clear_vec(DisasContext *s, int rd)
+{
+    unsigned ofs = fp_reg_offset(s, rd, MO_64);
+    unsigned vsz = vec_full_reg_size(s);
+
+    tcg_gen_gvec_dup_imm(MO_64, ofs, vsz, vsz, 0);
+}
+
+/*
+ * Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
  * If SVE is not enabled, then there are only 128 bits in the vector.
  */
 static void clear_vec_high(DisasContext *s, bool is_q, int rd)
@@ -4851,7 +4860,6 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
         TCGv_i32 tcg_op2 = tcg_temp_new_i32();
         TCGv_i32 tcg_op3 = tcg_temp_new_i32();
         TCGv_i32 tcg_res = tcg_temp_new_i32();
-        unsigned vsz, dofs;
 
         read_vec_element_i32(s, tcg_op1, a->rn, 3, MO_32);
         read_vec_element_i32(s, tcg_op2, a->rm, 3, MO_32);
@@ -4863,9 +4871,7 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
         tcg_gen_rotri_i32(tcg_res, tcg_res, 25);
 
         /* Clear the whole register first, then store bits [127:96]. */
-        vsz = vec_full_reg_size(s);
-        dofs = vec_full_reg_offset(s, a->rd);
-        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        clear_vec(s, a->rd);
         write_vec_element_i32(s, tcg_res, a->rd, 3, MO_32);
     }
     return true;
@@ -6307,7 +6313,6 @@ static bool do_scalar_muladd_widening_idx(DisasContext *s, arg_rrx_e *a,
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
-        unsigned vsz, dofs;
 
         if (acc) {
             read_vec_element(s, t0, a->rd, 0, a->esz + 1);
@@ -6317,9 +6322,7 @@ static bool do_scalar_muladd_widening_idx(DisasContext *s, arg_rrx_e *a,
         fn(t0, t1, t2);
 
         /* Clear the whole register first, then store scalar. */
-        vsz = vec_full_reg_size(s);
-        dofs = vec_full_reg_offset(s, a->rd);
-        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        clear_vec(s, a->rd);
         write_vec_element(s, t0, a->rd, 0, a->esz + 1);
     }
     return true;
-- 
2.43.0


