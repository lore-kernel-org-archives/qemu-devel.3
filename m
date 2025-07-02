Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0C8C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwwb-0003Ll-MZ; Wed, 02 Jul 2025 08:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnD-00008Y-LK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:29 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn0-0003Cu-Tw
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:26 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ea080f900cso1191446fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460131; x=1752064931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUPjujs2ctqi58ILd1hUc6Jdxb9x5Tq6Mi0XLmcQqpM=;
 b=ULvTg3cCkrwUCUJ2y9Ri3oZN4vgz9y1/X/HpTOqOlyWxhUviKviMsUjKRqBp7O5SzN
 cwkjaTKkn1EMMqjEwOmHqx1feeBUoXiXwNj5UvCAKf7uShk8zxa/QjOsnlLxZQMmmoRx
 T15zawWUW/l3OUI/S/wQ+N76YBWzBzvltzubpqHA+efEMoGHoMrpC+IIMShhI53PZROe
 EPCCItGKOH142HYeBYUfjcdZ3kRfByLYZOtSbvi9c042RG888ndYw+XzDcPvDAARDGtt
 aWyGT115LcL8EtvOS7roLWKsTJd1DpUocNUfYwuZzz0DTqj7SEqCucgCG6+uxlmIcuvC
 6JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460131; x=1752064931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUPjujs2ctqi58ILd1hUc6Jdxb9x5Tq6Mi0XLmcQqpM=;
 b=wQ/JUxpSm1MYJVNOU4/mkMz0BTYfYqYNNfDZD75zFW67CkbaU8z7m6oL0hnTjUXrLz
 4Ey1QFi9iJhltlWfPniVLJecPqW4KaSXx9+X55ux5KL0A40iJeONOAEt3rf7Qu61d9Yf
 uJxnWK0OuE1XmKdoWkWAOKJdkgUQNhhuEiR0nyMLifRQQhkAxbRzSyaZsy9uKcE8S1zv
 GL03j8kk1y08GbbYlSElADtAM4R5c0J9Plp9PbEP2gXURuSPW9JbcRvuHGx9pPuDXvvh
 GG9Q7o66/cutmDP0sRntSwPV2e3enI/3iFrWYoff92GrvhTRCmH7veOzJM3kNbL6Jk7q
 t+6g==
X-Gm-Message-State: AOJu0YwPBytbUu76Uoegps1vIKBxLIM7AEhD6ZvaN+HpPUvOkeX4Xbyt
 euy5HOjN+AJHs51YRxzF3mU3zI81U0IEU5DgepydckJTTB+pTdWJHQpW+2kThpXvNXEVMYsVDWy
 B/rQzH1g=
X-Gm-Gg: ASbGncuzyD40atMI4TJ1GZ0uVUN2u1gIoJ/RZG4w0Jk4FLXLuecSOTfqzN231x+hRFm
 4PlbovlagIfdMJyzgT1oNIDY5/mUzbPDNb3wQEhXZwKKdKWMOWZeQbVWErnKZ6GEDvKgTTisT9f
 fAYGWkESj2MpnF0/BT+alxLUixYamf0+HlQZ0P1Rc5Wp8qcZw7POTlWI4N91D6RG0SAw1+b9QEV
 3pxaiGFkH4vcQCWv+m41gzdb79q3Os6dKjWWiVSzzG+RO4cJqBJyUnYSWqt9iokfvRbzATcJX4t
 33hkviWXFEP/TxSSSvav4Uh6H8t1d8bjZA7YwkNBtVa8YKvUIAhsu1B7ut8xBWW/jcrfIg==
X-Google-Smtp-Source: AGHT+IFpvUjrCoj0lTO/jE68WK9mnJGlumSIBTlJIHflW3xZRCG06rUq9vbPyklzIpqEY8g+xsZhLw==
X-Received: by 2002:a05:6870:9602:b0:2a3:c5fe:29b9 with SMTP id
 586e51a60fabf-2f5c7d5790amr2176765fac.29.1751460131386; 
 Wed, 02 Jul 2025 05:42:11 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 91/97] target/arm: Rename BFMOPA to BFMOPA_w
Date: Wed,  2 Jul 2025 06:34:04 -0600
Message-ID: <20250702123410.761208-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Our current BFMOPA opcode pattern is the widening version
of the insn. Rename it to BFMOPA_w, to make way for
the non-widening version added in SME2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 2 +-
 target/arm/tcg/sme_helper.c    | 4 ++--
 target/arm/tcg/translate-sme.c | 2 +-
 target/arm/tcg/sme.decode      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 67d620e456..16083660e2 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -141,7 +141,7 @@ DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 00ff4b4c15..b6d1adbbf2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1254,8 +1254,8 @@ void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
     }
 }
 
-void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
-                        void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
+void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
+                          void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 1167aa4964..38d0231b0a 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -572,7 +572,7 @@ TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
            MO_64, FPST_ZA, gen_helper_sme_fmopa_d)
 
-TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
+TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa_w)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 77744eef4f..8ad86f707e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -189,7 +189,7 @@ ADDVA_d         11000000 11 01000 1 ... ... ..... 00 ...        @adda_64
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
-BFMOPA          10000001 100 ..... ... ... ..... . 00 ..        @op_32
+BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
-- 
2.43.0


