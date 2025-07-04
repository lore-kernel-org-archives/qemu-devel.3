Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1294BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjH8-0002F6-3T; Fri, 04 Jul 2025 12:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFW-00055r-PS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFT-0006xo-5v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so12234125e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646410; x=1752251210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rWosasfNf2wqBh/OQOVO0cuyunlck4/a010xI3ZiaXQ=;
 b=UoTB9VVVXttWHDesju8YNblSBMZs6jp+oM6jqlaJkQJseHGW9UMEp5sAbMJC0rBaDY
 5fgB6aX6klgJeKFHFNT6bb5IT/XOEjitKJKitPceHWSQH0yh0zN0dplFn8rApn1Vi7gz
 muBC7wd/xm7f5eVglOi55cTEq3q3hheXtDNKY4zFrnOcH+pX2Onz1bXl3XgNDQEihYpR
 LrJlDVDVgrW9AFb5Y8XZZADXa24ldDO22d1o2GXqWxYDiP8ApWZO8LUpOdAna+pgdWzJ
 O6YRU5xpRrE/s+QPtQU5fJ/FG9Ku5aFjwJEjzeKCWLGzigUQhy3hHC2FD7XveYpv/qRU
 1hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646410; x=1752251210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWosasfNf2wqBh/OQOVO0cuyunlck4/a010xI3ZiaXQ=;
 b=S3+q2cAlZcYUm0Gpf9qfU/kmcn12pr6XLvu3Zju4zvLS3HFT7oIDVVdqTLvcTnt2Yq
 jx6ycADNYMw/IC/xtgZekPuIgF0DQD8H7v1CWx8PGoByWsxoWpq8xFiwntQbEvZLEL4Y
 IkqDswNRVGfzLaEL3F8pbG2C9PkfriNqZwEG0BWdv2ab/Skx6v0K+jkxvMT+spuJxlDU
 MVZ/boMyQf0yqcDnPerqFqN6HSesmM0dHC3AO/3ZQM2lBq9ugXI4URZx0TdQgBimsxpD
 FhJDFSSA6VwwvjwPj1MaRVNvDY+aNGmJjsEoUpV2wJgDTxVWMHWMpme/GPdPNaMd6Ko5
 MfYw==
X-Gm-Message-State: AOJu0Ywa6luhIuro3ttBHtPIHD3Up7hM0htdo/IZ5A7ZALvgGbYwAbOT
 7CNFSfu54FXJQd1fe4RWZcN3ozZExyorkAcCHcNDujGrisIIE4YbT6E29NnYMTvovzlXOaK0/39
 BdHBR
X-Gm-Gg: ASbGncu7HezCl5Nxpp0m5tg8kLWLuQ6428PR3yGTXL74vBiSKTZy3UYM5dA+IODh+Qa
 x/VptQNwEqmcTWZ4yLi4AUOjLaAUIQ6iQE4AahdX0gSLNw6j0+TQrkf/WKxb96f1j3ivd5QDg0a
 joAreiPdpKOkcRBavaImbESL+01P4uHlrfAJpMuTlHB57Sjjq32etzb0853EYeYAlkBWK8bBkKY
 vN7NCQkiYRaGQadaGW/nd01qYFG40C9curQPiWYUAlluM67bN6MQLrrYBTf0zZGcKkL2n7Pn/cj
 iTTQwor82AGTeCIrq2DOG7jxvIp5npcJ4VtBpHqZkP6Z6jyJr87QPJcESwpF85s25Mmk
X-Google-Smtp-Source: AGHT+IEDLYx2ZIybV02huAca28UIn9mWDNWwBY178aI9ZqCCVi1V/qwmv5VTBgrs2nc8C9hofzDPSg==
X-Received: by 2002:a05:600c:8b0d:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-454b4e79652mr35307555e9.10.1751646409608; 
 Fri, 04 Jul 2025 09:26:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 113/119] target/arm: Rename FMOPA_h to FMOPA_w_h
Date: Fri,  4 Jul 2025 17:24:53 +0100
Message-ID: <20250704162501.249138-114-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The pattern we currently have as FMOPA_h is the "widening" insn
that takes fp16 inputs and produces single-precision outputs.
This is unlike FMOPA_s and FMOPA_d, which are non-widening
produce outputs the same size as their inputs.

SME2 introduces a non-widening fp16 FMOPA operation; rename
FMOPA_h to FMOPA_w_h (for 'widening'), so we can use FMOPA_h
for the non-widening version, giving it a name in line with
the other non-widening ops FMOPA_s and FMOPA_d.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-102-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 2 +-
 target/arm/tcg/sme.decode      | 2 +-
 target/arm/tcg/sme_helper.c    | 4 ++--
 target/arm/tcg/translate-sme.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index c9961d6b7ff..67d620e456c 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -135,7 +135,7 @@ DEF_HELPER_FLAGS_5(sme_addva_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addha_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_7(sme_fmopa_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5a5b8ff8a5a..77744eef4fd 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -190,7 +190,7 @@ FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
 BFMOPA          10000001 100 ..... ... ... ..... . 00 ..        @op_32
-FMOPA_h         10000001 101 ..... ... ... ..... . 00 ..        @op_32
+FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
 SUMOPA_s        1010000 0 10 1 ..... ... ... ..... . 00 ..      @op_32
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 424fc006be4..1575a2f20c5 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1146,8 +1146,8 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
     return float32_add(sum, t32, s_std);
 }
 
-void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, CPUARMState *env, uint32_t desc)
+void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                           void *vpm, CPUARMState *env, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d38b8a5ca23..1167aa4964c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -565,8 +565,8 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
     return true;
 }
 
-TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
-           MO_32, gen_helper_sme_fmopa_h)
+TRANS_FEAT(FMOPA_w_h, aa64_sme, do_outprod_env, a,
+           MO_32, gen_helper_sme_fmopa_w_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
            MO_32, FPST_ZA, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-- 
2.43.0


