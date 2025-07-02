Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129D4C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwly-0006e4-QU; Wed, 02 Jul 2025 08:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjA-00049c-Kv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:16 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj5-00022y-RL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:16 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2efc0ed41efso2059763fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459889; x=1752064689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mov827eBi0h/4VGOYMbYzgJ2i7vjXAJOsa9lY7YH0n0=;
 b=nXYhVbY4TB1eMIh388Q9i+XbZLCdeSpbPw8OAr2arih6PSTGj/GakhmQZezEu+IR5y
 NgsXKAmoLSxCI+Ss9gzNWD9ncZRkTlzwCyhfFihtxh04ff5GcYZ4SWi2WBnJKw3TVz46
 EB8/uBxYkxXjS1lJPKiSeYJfqWhNgYIFNGvHoY5dLdXyUG9lmqj35DJ5qC0gCbKkfSyy
 RJ6kn5wZGBXp5iAksGdhEtzDo1AgWMCjtqzqkAFPymWdwGSjAtpC4+LNP7KoJpU9iBDI
 xmdMHM4Al/VioGpHcY1egRvuMGondmSSyQnySiep1ABAj+0+f4jhBSdLmFc3OuOzVsWy
 5pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459889; x=1752064689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mov827eBi0h/4VGOYMbYzgJ2i7vjXAJOsa9lY7YH0n0=;
 b=laL9zGDSXSZwaH9pppYslK8IMRR1OSc4Ur+azba6mIJmyPTRJTg6Moa2WOOiz1amWh
 KrBdypdrYYpqF7IbwKtiMyut2gqdOairNyQqyeLZjS1NGypFjoU4etjY6dp/HNTzHFLx
 t7ZaQU9kE8pIkfFae65+0YuyrZo9Xov0sYRPCICjWuT7Xv0Kk+1XOHA5/WujgtziIXNR
 q8QhdWgWS3qzx7p9uRuVCQpBs1JzWBBbeaZTfhEVABSXkm3n604E24HauR9t4Wt/NAk/
 3Y3QW+iiA6lDkF9/2nkI4ZeI/oc5ImcGFe3kM1VD7EJvl9bQf52mnYue9jUMgrqunzZg
 S3+w==
X-Gm-Message-State: AOJu0YzRQLKOTO6fvqZkcd/Ue4+3uR23BCXNbWrea6WVn0wxinckg3bv
 gZ1VEBMkolPjZBudLHlRHvN6v+7Gj8Vv0Hvegoc/VVeViBfMV7vpoXgSrX5EysS15A0JinqI28k
 bfoDLF7c=
X-Gm-Gg: ASbGnctvumBk+3xjSgSIbJK6iuV97dZiFJ5JkdUbY4273c1+iKXWIGPD3pgxrfkJhrE
 jLFN6X1p8pfy8jC3A88OEqnSmfHyb0MnZng1GPjzUOy+gK7o8LjaWtwYQsflwlhBqWhiA10qyoi
 bWO7Ygx1s4QFG9G4gCFXCdO5j2qWU8MNrN/7VRhnj9Ol1wTUN3TATPIjF0tZyXSvAi7Dai4ca0i
 JByy436nCx9ERBKrj2O9qm35AX9F8o4UTsn61SXHKyhFyCIxPL+3hehmTGej2h+xpFV64xizaZU
 IA5m0W3i8TnU57RH7lWksfSX/RKXHS3rpMjooAnjnQ8KiMOQTDozVx94ZYRddn1Mt/2BJw==
X-Google-Smtp-Source: AGHT+IE4Gu4i6iTC+Aqko5hVLte1ITep8GibJZAU3qS+vvcxpI50FFl7hf9EK9tS+Ji0dO/LDKqNSA==
X-Received: by 2002:a05:6870:70a0:b0:2c1:4146:c556 with SMTP id
 586e51a60fabf-2f5a8cfb3a6mr2061022fac.31.1751459889250; 
 Wed, 02 Jul 2025 05:38:09 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 45/97] target/arm: Implement SME2 SCVTF, UCVTF
Date: Wed,  2 Jul 2025 06:33:18 -0600
Message-ID: <20250702123410.761208-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/sme_helper.c    | 22 ++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  5 +++++
 target/arm/tcg/sme.decode      |  5 +++++
 4 files changed, 34 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index be4621f2d9..6314ad7e01 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -219,3 +219,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_scvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_ucvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index b0e1fe845b..d69d57c4cb 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1629,3 +1629,25 @@ void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d1[H4(i)] = v1;
     }
 }
+
+void HELPER(sme2_scvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    int32_t *d = vd;
+    float32 *s = vs;
+
+    for (i = 0; i < n; ++i) {
+        d[i] = int32_to_float32(s[i], fpst);
+    }
+}
+
+void HELPER(sme2_ucvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    uint32_t *d = vd;
+    float32 *s = vs;
+
+    for (i = 0; i < n; ++i) {
+        d[i] = uint32_to_float32(s[i], fpst);
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3bf2b6935f..dce3b56de2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1370,3 +1370,8 @@ TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fs)
 TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fu)
+
+TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_scvtf)
+TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_ucvtf)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 79df2dcd2b..449d97bd28 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -746,3 +746,8 @@ FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
 FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
 FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
 FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
+
+SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
+SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
+UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
+UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
-- 
2.43.0


