Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E23C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuS-0004a0-Up; Sun, 16 Feb 2025 18:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntL-0002wX-Q1
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:41 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntJ-00064H-DO
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:39 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220c2a87378so51961795ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747855; x=1740352655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hFTn0/X0uRfeHpstN9Rx6I/tEt7TkIA5cSHXPyGNu10=;
 b=qUSVSUsO/YNpWVq6HoHBWyDRrG72O1SIIhqez0/NOpLcTyARzoVGp4mi1x/HLrs9T/
 MT0OPLvrUCkj7bsOwMuU3osVSoZ4+4A32DlTDGlevVfaTNUNr1N5IHKaCLpofWC3IGR+
 8ERCeOimWrjRSISgY4F1Rg6BRcGTElWaKJsAY+BX1CJT7Jq0gebfrAfjYi8vMwdYKdL9
 MZfUPc2521N4QQM4XE6k+INZXZqU/1YPAToR0508dQs67VIbbxDPo/fMijjGXQ2xiCoq
 lo9q7Im4dhnCxuneYKsjzWbE4FyP9QI87qB9qmJImMKE+3UCKK5BzHZMzbJXKgr3JH3f
 dwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747855; x=1740352655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFTn0/X0uRfeHpstN9Rx6I/tEt7TkIA5cSHXPyGNu10=;
 b=TmTtlL6VcpUuLq+6NAD1VB3Atl+PJPJ5LI0/96jS9S7MNkr8I4Y/9vyDZWuVQYTtv4
 Bl/pL8X3qCPUSO3qBYqnZXsjYwyCSqZYL0q0aMX8Ehkr8PdpNmJsZ3wW0OZcugWpkC9L
 s3hxPX7X/uN2Lq1wdoDdB5LnNlIjCS9XL+S1oKeH0YXWpwucVIgx4SEC8IHI824pQT6E
 dlpJo4Req/ijX3q4dHHMzQVs2hOD6NqEvwHakDKIaj8/sy5zwup32U3Ag9EZE69lxjtB
 w6HuOINy21CZ1/vvpldP7qqax9484RtFoBZxaFBdeFP4DpKlf7mCT3BsChVsk3LGygYQ
 r5dA==
X-Gm-Message-State: AOJu0YwREQdrpUO7zv71yVBFLeuDRhNSc57Vd+XLnhSjYfezbC5OODkf
 ZazbWBI074ThHzwW+Jvq2jFP26tJKdnM9vqaewATN+dHmJlHDKzkkDr8to6DNw7C2KozguBvVvY
 1
X-Gm-Gg: ASbGncsG1bohHR8JhSyLRsDCUezRV2G9cz1dxpEEbNKjJ7ZQVt15ALEDFV5ldUzD7Td
 q+UcX2+d9fNA3Np8GeWj5QEyi8unjUSVXE6CXIt8wC9qP2wFEcaEUIs1HRXsRhXmfzLkDylk4Sy
 RiQBUoblteL0LBOtD6DFE1V72TDMoJpWQR4IWxAIPd5ige6LxD8LUM2YFZh6NTzxowE2WjpOlg4
 k4c0mui1lzwlF0Dg9n29GLyilzvaB9a1QgV0gomf1RI2A/r6zEaito9BZkwXEl/AMD50HMQ8c6m
 bqSi/SOYRONgutMRLCoYRdEzVuGbhS3zawsQuODMEZzXeEQ=
X-Google-Smtp-Source: AGHT+IFPL/fybdpKqmGElJGMz2RkRyhMD2lSkHsNxWlUGDzpvCHQ3dLL97e0zuAxORtUQygKJI6gvA==
X-Received: by 2002:a17:902:f54e:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-221040d75a0mr129558115ad.44.1739747854831; 
 Sun, 16 Feb 2025 15:17:34 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 107/162] tcg: Do not default add2/sub2_i32 for 32-bit hosts
Date: Sun, 16 Feb 2025 15:09:16 -0800
Message-ID: <20250216231012.2808572-108-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Require TCG_TARGET_HAS_{add2,sub2}_i32 be defined,
one way or another.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-has.h  | 2 ++
 tcg/mips/tcg-target-has.h | 3 +++
 tcg/ppc/tcg-target-has.h  | 3 +++
 tcg/tcg-has.h             | 3 ---
 tcg/tci/tcg-target-has.h  | 4 ++--
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 0d6a785542..3973df1f12 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,6 +24,8 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 48a1e68fbe..9f6fa194b9 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -48,6 +48,9 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
+#else
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 033d58e095..8d832ce99c 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -25,6 +25,9 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
+#else
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 6125ac677c..50e8d0cda4 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -14,9 +14,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
-/* Turn some undef macros into true macros.  */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 #if !defined(TCG_TARGET_HAS_v64) \
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 4cb2b529ae..6063f32f7b 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,11 +8,11 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_qemu_st8_i32     0
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #endif /* TCG_TARGET_REG_BITS == 64 */
-- 
2.43.0


