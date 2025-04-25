Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FDC369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 20:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8PDs-0005ox-Nz; Fri, 25 Apr 2025 16:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8PDp-0005jt-Ky
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:00:29 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8PDn-0001q3-HT
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:00:29 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso2442234a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745611226; x=1746216026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jQB1qsjAwLgyga72lwHHSIkPq5Kwrl/TV4SWYx7NVfQ=;
 b=PsCLVFHA0neSPfgcgB9+8SiGnla3nTK2OuBjl75M2hsgeRbdYqQvry1MJWbsRoVYRm
 UX0Q0wXIL+aJuWlYlLKmvv0hc/bcTqOCu2BWRDnunloiXybugesKkFzSbGpfpPivBlaq
 ifXF9tcV63obfKq27+Tc5PQ9eBk7Lqhqi5wV0Ppc+48vSIyHw6BvPw45RLFYF0ew2+hu
 r5c22eQxmuPJB26Hlc0izr5+H/lj86+3a++Y7Sk4Bu6RGduuKX2BULoyIxE66SUqbIzJ
 cUJRzYDEJjMrQ+3NwZ+xbdHxLs8AAAhVe7M5yyvdwD5bfyArJMeu7QVW6ZThRywQTOgI
 5Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745611226; x=1746216026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQB1qsjAwLgyga72lwHHSIkPq5Kwrl/TV4SWYx7NVfQ=;
 b=QcmqzB8bX/Jb4u9501WVgdK0AYH1t9RpUBWyj9Z2whTzoXJNe8ukBmsLVwYEo3LAI/
 +CP6t/Zb2+HhiCFjzAtr9LMn7nhGr6XvzoZ2Ey42FMry2a5+aRdowYHmjug5rbJp4Js+
 MkWZ1pdnNpOeu/uuTcuwpdi8UuV9z0H9SYcazzksD+EAZ/FvHko3uRbz2AABJZUkcq90
 CvvR/Upv/JVJKB95zlaU42neAHJehtCL/hxvnxHCfu2UElI1NvtJnnaYYkAPjuitixIS
 HReaZ1r1anf63C/4gXJdVMELcN8nExgjrPGHtrzl3i1Rj0s8XfH2XQ9WESBeHwAKfvef
 Ts0A==
X-Gm-Message-State: AOJu0Yw1qOtyrL35y6s8FtX3rlgEXLwyxv9ebrAVqgdS+cV+WciYcGNQ
 qA1j5++QbpIVy74LNZjZHdEb2cawBGSJot7FKjoNwxVm4mVy3bqZDyicWVSll8trmUs73mSm5wF
 E
X-Gm-Gg: ASbGnctZurLinamgA/Qral7QhnlQsNGZu/EdViuYa/nZtqbxr4LDzr1h3tloBstEtUJ
 ZRNdAtCQYcmaJCXcOoDnQoCS/V2QBf0SP32ODUyMArzEyC7YVy+N+Nq4kaKdNtliOYD8KkHnMf8
 wV2XrIM0CR4fYjnor8CMU0pbVo+dvI6KJ47knUCR3JjuO8N5PC0tgHZpOgeeLyiHk1JPGi8e4BS
 d6dhgXaDt+2l0kp2BALMWjepJ+xqdT0tnOYCLFnk/BQN/PWvn8VV8/s9Jr7M6vMwCDitjpwDZOn
 536jBekVIy6jqe0Xo5hDIW3p5nQw4YvFkLlZvkZAsQmTUgBnZL+QW6HbPBswS0IfmpLB85G3CF0
 =
X-Google-Smtp-Source: AGHT+IHyjvqUK878GEBccyvSwHtI74ekIUUl/GHkfyebK2tSpc2g3YLrsqTW0KNsJO8falhf3RBeIQ==
X-Received: by 2002:a05:6a21:6d84:b0:1f0:e6db:b382 with SMTP id
 adf61e73a8af0-20445d6f33amr10381839637.8.1745611225865; 
 Fri, 25 Apr 2025 13:00:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7702f70sm3315981a12.10.2025.04.25.13.00.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 13:00:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tcg/sparc64: Unexport use_vis3_instructions
Date: Fri, 25 Apr 2025 13:00:23 -0700
Message-ID: <20250425200024.853260-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425200024.853260-1-richard.henderson@linaro.org>
References: <20250425200024.853260-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

This variable is no longer used outside tcg-target.c.inc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-has.h | 6 ------
 tcg/sparc64/tcg-target.c.inc | 6 ++++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index af6a949da3..b29fd177f6 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -7,12 +7,6 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
-#if defined(__VIS__) && __VIS__ >= 0x300
-#define use_vis3_instructions  1
-#else
-extern bool use_vis3_instructions;
-#endif
-
 /* optional instructions */
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 095b310f2a..d47c1d43b2 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -274,8 +274,10 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define STW_LE     (STWA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 #define STX_LE     (STXA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 
-#ifndef use_vis3_instructions
-bool use_vis3_instructions;
+#if defined(__VIS__) && __VIS__ >= 0x300
+#define use_vis3_instructions  1
+#else
+static bool use_vis3_instructions;
 #endif
 
 static bool check_fit_i64(int64_t val, unsigned int bits)
-- 
2.43.0


