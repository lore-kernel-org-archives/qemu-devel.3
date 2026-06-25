Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E721CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfn-0005Er-UZ; Thu, 25 Jun 2026 18:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsf5-0004ax-5Y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsev-0002Km-Nf
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-845a3c05e40so144415b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426730; x=1783031530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4A9Ap27XbbVolHxaR32K8uSrPV73tTCewHI2hJj05w=;
 b=ey/bi03BBjbEcpVJa5QfMrux8Xpn2ZRCX8zbo0JQAZhIKfQQGX+zWjFG0rBiLUME/N
 RjnRcaFy/LUz3+EJ1bqmID3+2IVlxRVkkOWPYCL+3HNWRkWhhazcEByyqRXhSK2Xdb+7
 yyqDfQfF9PVVrIqEUAStoPcTzvHL3hn+H3rqISM2+qlEDLOs6fLEOSMLwAeWTWb43+EN
 8swwJwyrd9u+4LFGaGWguJwdXaCjlueM/Xgx0VwmLhIjjS+U+zvq34OFfMqgKFeW3JKu
 guknr1ZRPON6omUN+lZevSorEAN3XHfYddOQqWSpZ74+kYUe3T/+HuPsDduzu1K4cbLF
 qgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426730; x=1783031530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R4A9Ap27XbbVolHxaR32K8uSrPV73tTCewHI2hJj05w=;
 b=n95twRr2ITaEV34jUjytJAk+j7LqZjoLonSAnJlrVI2HUqTTxa7AH09yu0V7s9Yvhn
 0Y4FtppQtNSTyYvMilbks/DO8yXz2Ol3pkwcwbC9B0s5q33kDiDq+LB7yEw5o0VbOjRo
 0Z9KUijCrPphR23B3Cj4KXGJBsPBlx6u5gbdjIznPNVyG6pmSokaYj174mCsZCP5SEA6
 dTtVQxk/2QA9rs+uUkB1XrLHTeM/bpmrnFc1PTzGjFAkZI0Me3QYANMfAkLeQtXrng/d
 e3IOUahfA7TU2IqSKfybJGLjLd+gc3qcsn9i0M28RZh9+Xdgg4jGrPbRT7D7g/5dwdoO
 rX5g==
X-Gm-Message-State: AOJu0YwWASsFY6qXfK4WyhnfLgd21H0jYhrzxMp2altjMr0VvverjI8m
 YIop+gtYwF6QnV80ZaFK79/ISGKLaqkcM3vQjSky+KelzfC/Fp+HzAaRrIIdP0jAU1PXucVlBmO
 524Bp
X-Gm-Gg: AfdE7cnws6n4yfrIcVa/w5u2FVmgShL7iNWba14/gk6rG9Px3rzU+vqChohkH8o0yjO
 AglNt2xDZsSUG0f4l05/dVLwK3Y/Lx50hxgzz7Sh74XedFt/2cKki8iyBNUFGMC0HaGty0ipB5J
 tFd/me/gv8fHFhFgxCoRcd/YwR5SnvKLFBLgLU+2P0sbQILHV5nk4WMJwpSJQPbICmHBQeY2yrn
 BWg5HMyevKGR4eDurrEtW6Gc4netas2y0o/Ne5KsTfEvozHTZUH2lqhRDX01VODZRundT+w+6/k
 e2VW25NuAofVc4mcjBjXsEzBKyzAptBDFYysx9L4IVfwemCLkYBC/3Lm05zQpLGJpSG7ESuhRDv
 jysPHJ4kZlr/y/5TbV0xyDuVc0WEhm6mpJGfZDASVugx9ejqzv9/zJk+RueEvX/wiYdLdB/shC/
 ngYXK7wJiLuRlBdODi5ztimJCozwn0GJKUXHWuT+bNFNLjL8M5eT7pdxMrWQjP
X-Received: by 2002:a05:6a00:ccc:b0:845:3fea:965 with SMTP id
 d2e1a72fcca58-845b3b71200mr5198212b3a.23.1782426730200; 
 Thu, 25 Jun 2026 15:32:10 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/15] target/arm: Implement UMOP4[AS] (2-way)
Date: Thu, 25 Jun 2026 15:31:57 -0700
Message-ID: <20260625223200.763198-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 3 +++
 target/arm/tcg/sme_helper.c      | 3 +++
 target/arm/tcg/translate-sme.c   | 3 +++
 target/arm/tcg/sme.decode        | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 3da40d9f33..38b23690d1 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -382,6 +382,9 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_4(sme_smop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sme_smop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5a9e3b8398..fd085850ed 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2953,6 +2953,9 @@ void HELPER(sme_##NAME)(void *vza, void *vzn, void *vzm, uint32_t desc) \
 IMOP4_2WAY(smop4a_sh, +, int32_t, int16_t, int16_t)
 IMOP4_2WAY(smop4s_sh, -, int32_t, int16_t, int16_t)
 
+IMOP4_2WAY(umop4a_sh, +, int32_t, uint16_t, uint16_t)
+IMOP4_2WAY(umop4s_sh, -, int32_t, uint16_t, uint16_t)
+
 #undef IMOP4_2WAY
 
 #define IMOP4_4WAY(NAME, OP, TYPED, TYPEN, TYPEM)                       \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index fce07b2565..a8fcb0630d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2110,6 +2110,9 @@ static bool do_mop4_int(DisasContext *s, arg_mop4 *a, MemOp esz,
 
 TRANS_FEAT(SMOP4_sh, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_smop4s_sh : gen_helper_sme_smop4a_sh)
+TRANS_FEAT(UMOP4_sh, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_umop4s_sh : gen_helper_sme_umop4a_sh)
+
 TRANS_FEAT(SMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_smop4s_sb : gen_helper_sme_smop4a_sb)
 TRANS_FEAT(SMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e3ba15bad8..9c761f1934 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1118,6 +1118,8 @@ FMOP4A_sb       1000 0000 011. ...0 0000 00.. ..00 00..         @mop4_o2_s0
 FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
 
 SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
+UMOP4_sh        1000 0001 000. ...0 1000 00.. ..0. 10..         @mop4_o2
+
 SMOP4_sb        1000 0000 000. ...0 1000 00.. ..0. 00..         @mop4_o2
 SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
-- 
2.43.0


