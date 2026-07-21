Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834D0C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFWh-0001sy-WA; Tue, 21 Jul 2026 14:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUo-00011v-AB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUm-0006da-NZ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:14 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so9515481a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659631; x=1785264431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJWOSYXRXrcK3TYmLUpBxwKeLPW6HbyV5XuewiFAFJI=;
 b=XjUk278oGG2PK3VCQhVJH5mJuJtslJweZxp4VUSdVDiDnMbubCurZT0tupyJGNaFer
 dQ1aa0JqjKobGk1yPfdazB+lF4jovBiv6IunC14ip0uKE+2lKSMnQGh76X2rqMfBNrgy
 dsZy0b3KIiDZdzWr3nO+pezfch2J9aXSDnLAUx6KEPLtzhdFecoU0kdKLkC6SZzRVzzA
 fEJfV/dN38z5R/q+O+dAp9M/3N4nPmnQXUCZJXMgI63hkXjKUsVDoU4dJ1N5I31QRm52
 Q4DerC7GMBcVwd9+nwm7u/TrZpscdnNFqLxP0hyjwrxv7v7dpDe5qBmHnzT14mp/cqah
 ni+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659631; x=1785264431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FJWOSYXRXrcK3TYmLUpBxwKeLPW6HbyV5XuewiFAFJI=;
 b=qAJqs5UmuF5RhiabSq1y/32Yu+wYH3/ylq03Wu0Z7nYQrTatkEEh/Qg5bBL6oZR7je
 UQh7EZX8MREnOGUVj+X6dg+pav8urKBPsDqI4LqP/QBz/CpfA3nttpipmHm/w5HIcMjB
 6hFJd+FwVOLL1NKRkcmSUKbKS713MROnN7cXGEpEJRMCTkAvGCH46QtORb7c5EYHeJ7S
 k6n5R0xEdRTC9RbHVGY3qC1fmai7UztGAjwisLIFzfeqYS66zfB5SUd9xDAZg+6ohr6A
 JtB/NlUexugxeQCqAIVxTe+Cnfk4dmCS0IYe+fn85nXQRYa6iinuPopWESmgp8Cxbvsc
 hwpg==
X-Gm-Message-State: AOJu0YylhmF4Ne3wQOIxN/4hwpeBI14NX8F/3bKCKJEhxRKXDvGIrmrs
 lfOotQ0dpwUdh53hmJYM1MNcLldpp+6VueMit87/pKYc3dOS0eSQi/omppmejiFwAgjUBp9QrVx
 VfnUX
X-Gm-Gg: AR+sD10KKCR0/idf/6XUMgjIVIMc0XIrC2aiYSXNDLe7QD8+/V/fx/cvLg4zkL0ZIjt
 gHZR8VsfcCKmlzIPdfTbgqtJYHGehyhjKtbHZbJhcxOQe939H8guG5BeLCicSaX7bxG65HijFz4
 XoMVWliMZqLxfMTujxcswJZ1soQNyiJWPfWbYkrctmTy3qWnrNcmbp8oY8jmKUzfTzlSL0awFRR
 92sVeZ534PRKKvGuWgL8Hic82fwkwpBXOSP0G6ePRQuY9Sd38PZ7Mtb6JwEKtB1OQzjb7Q9yXnz
 OrMQwrtHndLPL1y6XfVCgDCBFslT0wTCnwg1VDIMHYzOmBAboM4jtRQlvVjKqCKkjIIkdr8kKf5
 BKd5Rd8oEMm9Yg8iJ9MPaj5bjgU04yU+jMRXsu8ZVUS9wpexBZWU2zEpwSXghT9i52QVQiyqxYS
 K6FloVpYPbjdQtta2HmQ==
X-Received: by 2002:a17:90b:5543:b0:382:1aaf:4bab with SMTP id
 98e67ed59e1d1-38e4b516631mr19334867a91.27.1784659631066; 
 Tue, 21 Jul 2026 11:47:11 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/20] target/arm: Enable FEAT_SVE_BFSCALE for -cpu max
Date: Tue, 21 Jul 2026 11:46:45 -0700
Message-ID: <20260721184656.530230-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 3 ++-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index c086548f7f..bcf2e6b9c1 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -180,6 +180,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sme_tmop, ARM_HWCAP_A64_SME_STMOP);
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
+    GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 33eafb467d..4a44d148e2 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1370,7 +1370,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
+    /* FEAT_SVE_B16B16, FEAT_SVE_BFSCALE */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 2);
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4d33be615f..4c91bb45c8 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -198,6 +198,7 @@ the following architecture extensions:
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
+- FEAT_SVE_BFSCALE (BFloat16 Floating-Point Adjust Exponent)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
 - FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
 - FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
-- 
2.43.0


