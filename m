Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E13CECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAB-0002KV-Rk; Mon, 09 Sep 2024 12:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhA8-00027y-Tz
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhA7-0007gY-9J
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-207115e3056so15648245ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898966; x=1726503766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEDgBGLyOKMOiAFOmQA/J+vXJhhF4dXhuxJpooeaMZw=;
 b=fKrZv7exKRI9kH9ZZjg5CIC8O/3ubVRDsHZYddEK3/oap8A65zhdfvPnSw56yOCiYa
 CeZTjxLD7Y5gJaBjiCciLldDRy5Y4OEsJG/CiZWrW4Ax65j8jPg6/wFI4f9zQkVlE9fO
 R3Bu+V+D2nN8Fnss3PTHbZXs4wqbbOKN6HJMBc7SvDdBeaHl46WlibxwjUMYJo7vItYZ
 YAwnYaDSFmOZ0Uy2dsDtO5tEqnpjQroUHNForFRQkR9bzrHoYofrYr+QLSw3QFeuWz/i
 khdjOP1BITBEgHRv+OSK6POLT94iWxYCGEmb7z8INPfNRii6mLA+9NFjIaDxmIp3dnlC
 z0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898966; x=1726503766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEDgBGLyOKMOiAFOmQA/J+vXJhhF4dXhuxJpooeaMZw=;
 b=SGuiaPqlc7bd0dBdOLmGVZ59E3GRPvOQIx7r1ItpqrPapDrkdsZMqJ0Lg82H0zIkyE
 +9bvXdVklwPLqKxjeFVIpqqC6jaSpDE8trW4E4NAkLayh1qNdz1+jpQ9KR2Gn6+1IrqW
 NFOBjik7iEG1GWy1jb6r8f0O97VCci7OmOgHHyySJHTjMlr97Aah0G1MhwwddSwftP1o
 ryOQf1tk/wih+UaoF3i4Pa7tDtS9Q8JzFdrYi21q5yU9NXlHbUBkhf4FpRjoVvm7bTWZ
 M5DLwETf01XeMtFekKH+t5qQyi0Dxc9djOI89mG5Q6pCQTy/qT4epWz8cLUgGUI99Vps
 /fHA==
X-Gm-Message-State: AOJu0Ywo5kdyHAXXLLdDKMyROHG3rVjEuROv/3soMiL2OweIDd6ZYtX7
 dSMWvI1f4ZG3sn5o7Aua+E0Lwk+Q0djM0KdeWoSkXn3dI/CqYm1V8b6KzmybkjDjpXlPE6dASI+
 8
X-Google-Smtp-Source: AGHT+IHVOw2FOariJTmNMlCzRUYmmjNTq///yNp8EjhdSN2TVgChwWGyIz8w59qr/Ad7kV880D/IeA==
X-Received: by 2002:a17:902:ec89:b0:202:1a0b:7cfd with SMTP id
 d9443c01a7336-206f052e0camr84975085ad.28.1725898965839; 
 Mon, 09 Sep 2024 09:22:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 04/29] target/arm: Use cmpsel in gen_sshl_vec
Date: Mon,  9 Sep 2024 09:22:14 -0700
Message-ID: <20240909162240.647173-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Instead of cmp+and or cmp+andc, use cmpsel.  This will
be better for hosts that use predicate registers for cmp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 3edbf3a262..c5fc1b6cfb 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1160,7 +1160,6 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec rval = tcg_temp_new_vec_matching(dst);
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec tmp = tcg_temp_new_vec_matching(dst);
     TCGv_vec max, zero;
 
     /*
@@ -1180,16 +1179,15 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     /* Bound rsh so out of bound right shift gets -1.  */
     max = tcg_constant_vec_matching(dst, vece, (8 << vece) - 1);
     tcg_gen_umin_vec(vece, rsh, rsh, max);
-    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, max);
 
     tcg_gen_shlv_vec(vece, lval, src, lsh);
     tcg_gen_sarv_vec(vece, rval, src, rsh);
 
     /* Select in-bound left shift.  */
-    tcg_gen_andc_vec(vece, lval, lval, tmp);
+    zero = tcg_constant_vec_matching(dst, vece, 0);
+    tcg_gen_cmpsel_vec(TCG_COND_GT, vece, lval, lsh, max, zero, lval);
 
     /* Select between left and right shift.  */
-    zero = tcg_constant_vec_matching(dst, vece, 0);
     if (vece == MO_8) {
         tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, zero, rval, lval);
     } else {
@@ -1203,7 +1201,7 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 {
     static const TCGOpcode vecop_list[] = {
         INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
-        INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
+        INDEX_op_sarv_vec, INDEX_op_cmpsel_vec, 0
     };
     static const GVecGen3 ops[4] = {
         { .fniv = gen_sshl_vec,
-- 
2.43.0


