Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14346C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m8b-0003fL-Jp; Tue, 15 Apr 2025 15:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m2r-0004rw-2v
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:11 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1l-0002vy-2i
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224341bbc1dso55517005ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745568; x=1745350368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hFTn0/X0uRfeHpstN9Rx6I/tEt7TkIA5cSHXPyGNu10=;
 b=FWg+pHBUiYMn8rwz5PnQ5TotuuSey2Fh9EQ+sZ19noWI75AHZDydaKxdqUSXmVW9Aw
 KAMV2tAG9u8PeA5hGFLNOf6UI2nzoDbY+07T/mSuWpTL/e845yhPKYLr5T4d8QIO31yx
 hvoaKAzlbkB2pKRZIwKSS3NBNEIjypDl+tR6QThl6+gZAChfBWDJo1BlfvBZfPke5Sz2
 UO8wQsOG7OYiA8b7z5UcH1izFTCcY/XUGTN+EsfP55o3GZZ48bFDjFzc6rjTIlMa0L8d
 0EvzJ3EqMPptGSPJ9vyT4ygrY2CXtHEF0x02SrTOYS5UIFoShdMtTQ5j8xHbkEzFO9bs
 /00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745568; x=1745350368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFTn0/X0uRfeHpstN9Rx6I/tEt7TkIA5cSHXPyGNu10=;
 b=wvhZg9WXWBeHi9ujMNtjmuvWKoxr/Pj9n7DWpHLhsD9A6grmkG452/5DryqEIE54Po
 MbplRIPw3uxaSP6usaF6HI8YpQGhU0LEbE1W+bD07vjySV4UahIiRaS2xcTx9/djFTIq
 gZ2pC5s2xewOoaFI/P9oafU4LqNC9bHIm3COWTLmzRqP0ZuxDCCYUF59rDS5viNg9+F6
 aQORdhUXCm3KrAjEBt053gUlBKk72aFA/wGscVcTlU8v9qwhhxRug9e3VUEQU2cSVHEX
 Ih/0JDrZKGLrcp008mjvrisr/EzyfMpv7yGoAS/0CqaUQ0SufhLCAFp+0FGXUFXyXDwU
 fc3w==
X-Gm-Message-State: AOJu0Yxy3DgnKx7YXo03PUHxrhymRvlTJgg3uLgIuQF5gVvCfWgxjKTl
 Vju+Ayi4M6HFA+yx+aAzRAnn2DUcC6LX5BnmTA2FEggjIRLOpPesHlYwp+oes/vbHy7Ai/qZl2B
 O
X-Gm-Gg: ASbGncs3qQ+RpTYBVaBWcp5reBN7v4P9VFkzhzXi4F/8wf48KfyxaOZ5mlX+XQt3oz0
 pZSv3rmMC+4xMRLP+/hOtUii+tFOgahUiTA5uu/byHmfJSujz/axD+3atn4sAS8ab+uo1Qm3AVu
 PkuPHnppuS7k6ywHMCoc9HwERIcs73RietMAf1QWQW5gc6ghoMDCwnpwwiBME6wUAKTRfXw//Ce
 pfdXQ11phTZCUckQWtzjB7VcL/uMd9oeTeAmXeFI/mdCiErG7iOwxTbBHFMPTY8bccLjFrroZHH
 qh7kgTq5Oc7IXJ3116OxE9+VzHYpmmBMlbmDNm6/+89+uNdm6+p4mCaqckQ4YSm5Gdx48xSgl1U
 =
X-Google-Smtp-Source: AGHT+IF0SnCJ1XMp01uqzO+ddQNlBaENXZo/zzWY8enBDtcmD+EtYD0Hfh5C9OoNOsAqF4vWrXzAqQ==
X-Received: by 2002:a17:903:1905:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-22c318d1418mr7342885ad.12.1744745567783; 
 Tue, 15 Apr 2025 12:32:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 108/163] tcg: Do not default add2/sub2_i32 for 32-bit hosts
Date: Tue, 15 Apr 2025 12:24:19 -0700
Message-ID: <20250415192515.232910-109-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


