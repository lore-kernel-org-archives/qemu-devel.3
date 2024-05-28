Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8EDC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UB-0003wE-Nl; Tue, 28 May 2024 16:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Te-00033y-3W
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:22 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TP-0003hf-UG
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:21 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-65c5a29f7f0so1027145a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928264; x=1717533064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZbRVWSAzpXaBOJGm3f2hQ/+OFnj87ZeGyTFdIhlSfw=;
 b=n+Qp007COUk1MdQd+uTEu7pQJx/kCFQhcYyIRfqBEiccS5K7rFcR4tUO6DxLJk8AS7
 8XGjtVTgXVNf21R0y6K+NiAn8FXccFEUGdRJDALJado69+jWqKsZ91ywXAW+VjvgN+Iv
 teo9ZvxFD9EUkLO6zPH0aAb2zz4XJMy/GzNoWBzMoF8rXTfB/j9Xrz934b0yuMSSihSK
 3vVZJtiVIsyikyYK5T6aUjhalTd+MfJp4zDdgzgJdl+nWclbNm8KznUckRpFpGTvkGLh
 JO5BXdlAjmPdFRHeKL5moVWASei0w8ETW0ZD0Fmlci7SELRfrkGtx0WHrps8te9xvUXQ
 W4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928264; x=1717533064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZbRVWSAzpXaBOJGm3f2hQ/+OFnj87ZeGyTFdIhlSfw=;
 b=fX9mzNOdj0qu7Svyy1NNXKUBZ66n4pjVsLrbr65VnId0KqG4lcKHAfF/Nz1cm94UfU
 4fxY1ofFdSdX8xykeQiNpaJ7sQEfmfz1JgyOZo6ZF/5Zd/7VTYh073GFEdvta7CTi5cM
 EHcL9POI8U8Q8tAhhUmAe61xGzWo89/7S+0ONfJh0jKGk9oKfv88ODpQwyBhp3+757OS
 hld9k8xT3bSkwVlnkNl1iF9KWxqp7ji+ZnVVsk73iQd1tTMJBxgVkkGUSSu/bCPpklb1
 Ig2CAodfRSbCrq1wBvFt8TBTye1m79xtOYmYZcdIdQG2amFfpV6p+pQdEdfb46pnobL0
 fc2g==
X-Gm-Message-State: AOJu0Yyxim53ITgvWE5z0nl2hxa7+r6YvrLeO65wszdtFAKwM2PwrdXX
 NY+B5Rg8DkTIKxBVF8MA2T32suypkcoIaSniuYIGTattUgOprjAeVIY03p0mmYe/TcjzXdBPuTO
 l
X-Google-Smtp-Source: AGHT+IG0SVuzNrPkGKUBxnMpFBLXNrhZ/YOgBmdwhkjUG062SOF4bmgLIHUjEonoa0Ua+qfj31gYHQ==
X-Received: by 2002:a05:6a20:438d:b0:1b2:184d:c197 with SMTP id
 adf61e73a8af0-1b2184dc30fmr13256084637.42.1716928264376; 
 Tue, 28 May 2024 13:31:04 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 21/33] target/arm: Convert SHADD, UHADD to decodetree
Date: Tue, 28 May 2024 13:30:32 -0700
Message-Id: <20240528203044.612851-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3061e26242..e33d91fd0a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -912,6 +912,8 @@ CMGE_v          0.00 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
 CMHS_v          0.10 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
 CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
+SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
+UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5f3423513d..00c04425c1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5454,6 +5454,8 @@ TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 
 TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
+TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
+TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10920,7 +10922,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0x0: /* SHADD, UHADD */
     case 0x2: /* SRHADD, URHADD */
     case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
@@ -10946,6 +10947,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         break;
 
+    case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
@@ -10965,13 +10967,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x00: /* SHADD, UHADD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhadd, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shadd, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


