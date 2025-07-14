Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6562C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMUq-00076t-Hk; Mon, 14 Jul 2025 12:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZx-00036X-Ir
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZv-0007oa-9a
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso2810930b3a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752508733; x=1753113533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6I/c6izRvO/9YY3k1FhH9eJOO9nj/nIYdH0I7uHsCI=;
 b=iPmtYG6yaiJPi8V4jxExSCyLRLx/zYgc8OSm8GV+mVdgXDLqzavNRoy/8JEW8QtaEE
 +4cspJ76DOtDie4XTjshx+EGiZ8EmWPHAC98FaD7GJpKmEI4k0lu67shon0JpCVOGuTg
 iUJ5LPljhCAlqDEbozk+dwOqirRMpxwJLpdzFL/NGr4RxlmhKk0GJTEWOLAvtW6aemaH
 6UMyBFqxMnKxRLYL90AiOb91P3DkkcBYN5nC5Ub18mO1IornvNka/vxPUwcfRpfcKIU0
 SODLJUM5xKjzHh4xWZBzM7HC1jQ7r2z1Sb4/AeVZIGAADUAtLqsZuqMhrBwvwq04py9u
 frGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752508733; x=1753113533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6I/c6izRvO/9YY3k1FhH9eJOO9nj/nIYdH0I7uHsCI=;
 b=UWxh1r8LNpPQ47ec67eob6x7ulqRkQePm00o+FuMLO+Jjor51XfT7OJ8xFpbMz3tqc
 N58wlDSmctTpEL4KNcp0EipPzUQ0sGudTei1mDezADlScKwrAUgF9B9hls6QDUp8v28G
 TKXOSp573j6MLbLk0NNcbmON5bIaVl6UlQxenApKHMkU9wr68HNKERsIjTBLfGmM8Mc9
 P5nEnyhRthyEEaj7G/61pRMDqHOAwi0vu/EYfsgAZd8He0xBSFywq58iq2ixLLMiqHlo
 iC4A4LLgO79Vq0iqAr1W/4q/q8t1EGvJIrYRiaQ2bQiWtcF6oQ54cTiTdLnyBtIlBTrk
 WcKA==
X-Gm-Message-State: AOJu0YwseOulumm6hIV6rtsG4v3QBnn98Jw2Iymf3WWiCvEVgYwM0OBR
 eQB2eSq3D1HfxgbKhMRqrnE/k1bjc52TvtkiNXzugtNIj/0VTzY2xCJAtM7V/nlkGR6mUVIb+hs
 RMHHC+Ak=
X-Gm-Gg: ASbGncs9/jsaOItfYSOHA1Y7X/QzBp+7WhS5VwdXyzDb8/OX02BbguRTY3VwW5f4gtc
 1bYfK4WlG+nHDZ9DplxYdgCGaeQFUxDp+lUtyWv9AF3x32VOPOYc1Z8YEDM6CNfdlMUj4aeTKoV
 LVI1bHcQ9dgi/wu4V4OGTtte6joca0CXgMZly1HiG5OWpcISyHIioq7bu5mz7XvGxrambSfDWUf
 6+QtgRJP9/W7bWpLDVzX9yEoN+46hV7O3yF2tKGuyug/aPTKVlLfNX+Hn0ErnF73spdjikdHB1r
 vTlbyoLN7i0LteqOKVJXd67XgJRlnI+Xu7/1+Vf0d15jINkHMnZ2CZsTPECpirZKial2Vc53YEF
 JHVPC+nALyUb6V6i297D7m15UoivQfmi9a0IHWjSrEjnc+hDsYXVN
X-Google-Smtp-Source: AGHT+IH20ezN1UVUc+FuyZ9Dfx4u2tKlZQAWOdWwFhvjUf5An4rkD3vtwyzTAMBausztCF3mhl4spw==
X-Received: by 2002:a05:6a00:1741:b0:740:9d7c:aeb9 with SMTP id
 d2e1a72fcca58-74ee3142d2amr19599125b3a.21.1752508732560; 
 Mon, 14 Jul 2025 08:58:52 -0700 (PDT)
Received: from stoup.. ([172.56.179.167]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8f24dsm10265805b3a.156.2025.07.14.08.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:58:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, pierrick.bouvier@linaro.org
Subject: [PATCH v8 4/4] target/arm: Enable FEAT_MEC in -cpu max
Date: Mon, 14 Jul 2025 09:58:35 -0600
Message-ID: <20250714155836.1514748-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714155836.1514748-1-richard.henderson@linaro.org>
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption is supported, but software
stacks that rely on FEAT_MEC should work properly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250711140828.1714666-7-gustavo.romero@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4eb51420ef..c54aa528c6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1250,6 +1250,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1c597d8673..d207a9f266 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,9 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
+
+  * This is a register-only implementation without encryption.
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
-- 
2.43.0


