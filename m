Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038D9CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHo9-0006ev-Aa; Thu, 04 Jun 2026 19:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo7-0006cf-LW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo4-0007sG-TU
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0b944f6edso13618515ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616939; x=1781221739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9F9kbLi16+GGnW73s9vC4HTWyng7AeCqWcgF5pO53eI=;
 b=KVuJ6FYMliMf9rLXaKJUyyz9k+FoXW3zZzZHpD5viwjdeCNTqnuBv1qu9eSyuIlx3f
 2dxQJe+80sszr5Qn/BG421Oq08XYw9D0VwhnZlt3b5CvCgt+lQx4AOHK+jMU+OmndUVW
 MItzq8OaJX3914pl1YbGkmECmnXmX52Lx4SG3/+kUO0+rfX9HX5ZJnbuoOiUxQGkqAKK
 TYivQFDUFgNO34qmwOJcnLf4doBhbUuxsBzM4zoqGAHm5jHy4te3jt3F/3+FF9gpbkbf
 vlIdZC8OdXCmzHHhRYrk7BYladTeB3enxiQ0qx82lGsuvlb1Yv0QZOmbxoyRoonq20gp
 U21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616939; x=1781221739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9F9kbLi16+GGnW73s9vC4HTWyng7AeCqWcgF5pO53eI=;
 b=rPR1dRXOc1aGD1GgcYHw4AOP0p3ZdNmO5GOIWP5U29sfLqSperFe2ngzp7pbU6Hhwj
 a7t2mnLLNNpORNiBdDxWH35u5pvi5wnz0kB0Yavj9tf0t1IMKupjzSF/f8bVObm9ayh6
 jUumnJdAZKkuzFSKqc751vVnAgyUQerYPqpKFxi+9hSHnzJ22b1DIy5dMXikcOsJtjof
 dBRwJsaZEpu78scMM+71cyRlPgt5rJZ20STpSKatLyBIOnz0t+dqOns93XASYyGo2k6/
 LKpaS1p7N2Y6NCX6Z2CoKsE6cMRXYHI51S29CTWWNoPtt7O1eBNvTI+vC9Wmq4fJa49j
 CXtw==
X-Gm-Message-State: AOJu0YzCgSQFluXbfngCQ2uJQxDCcjg6x4fyxBKTwTA4BvrN8n5rV0Ib
 TyeJiUOfoxFgeBboNXUONnVacY1mFGrHDxxWboLLYQUgRKk8WwDkVPb8rfd9EqGRDGVMkhAmxt3
 QARaDynM=
X-Gm-Gg: Acq92OEpXSAjU+2Jp7CsfTAw4iAO3YLtlA5pyMjkR2+8mCK9wykN8/mHIu+MVdzw1qW
 NHMS0OCCBEuwtfAZbQlrfNSZg6Ti1aDmQ98Brf7XJ1jYpELNSUi4M3SzZW4uWKPsP5bi/WzrqC5
 5P28x7BUdqNOMMzXxTgW9UO9UaMnOxcm0fWchPQNbtngkh4MgrT6VJ+l84I7WGUw5p3l4fatV+w
 p83B6jZW74DZCi7/IU74Hg4ByZVismuEW4dr6E9q29J8KT3oOx8a3JCbGi16l5JfcCoSlsvZcf6
 Jm65msm/1gT0v/qIcFk5MBpTODKEw4rsRFn2uY9+evOnunz3Osy5JzXR5kBVwtbLy+R66CpDvU1
 FdJCkfjRxmwFY5iw8+OTaHAGLNMf2P+vRHoGMIeBhCULvOrCKnS6q2c76csIz1OucWIZldEzr11
 bb4/qvFv/X5JmNDROFL9k7VBnkw6g4lPxn6ipA5jQ=
X-Received: by 2002:a17:902:da86:b0:2c0:f807:56b6 with SMTP id
 d9443c01a7336-2c1e7b3578cmr6726935ad.4.1780616939307; 
 Thu, 04 Jun 2026 16:48:59 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:48:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/25] target/arm: Implement SVE reverse within elements
 (zeroing)
Date: Thu,  4 Jun 2026 16:48:34 -0700
Message-ID: <20260604234852.573178-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

This includes REVB, REVH, REVW, RBIT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 7 +++++++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2e138f9ac0..c3903d8fcc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -836,6 +836,7 @@ static gen_helper_gvec_3 * const sve_rbit_fns[4] = {
     gen_helper_sve_rbit_s, gen_helper_sve_rbit_d,
 };
 TRANS_FEAT(RBIT_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_rbit_fns[a->esz], a, 0)
+TRANS_FEAT(RBIT_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_rbit_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve2p1_orqv_fns[4] = {
     gen_helper_sve2p1_orqv_b, gen_helper_sve2p1_orqv_h,
@@ -3070,15 +3071,21 @@ static gen_helper_gvec_3 * const revb_fns[4] = {
 };
 TRANS_FEAT(REVB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            revb_fns[a->esz], a, 0)
+TRANS_FEAT(REVB_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           revb_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const revh_fns[4] = {
     NULL, NULL, gen_helper_sve_revh_s, gen_helper_sve_revh_d,
 };
 TRANS_FEAT(REVH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            revh_fns[a->esz], a, 0)
+TRANS_FEAT(REVH_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           revh_fns[a->esz], a, 1)
 
 TRANS_FEAT(REVW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 0)
+TRANS_FEAT(REVW_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 1)
 
 TRANS_FEAT(REVD_m, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
            gen_helper_sme_revd_q, a, 0)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e79b5e84c1..867ae2916e 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -730,6 +730,11 @@ REVW_m          00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
 RBIT_m          00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
 REVD_m          00000101 00 1011 10 100 ... ..... .....         @rd_pg_rn_e0
 
+REVB_z          00000101 .. 1001 00 101 ... ..... .....         @rd_pg_rn
+REVH_z          00000101 .. 1001 01 101 ... ..... .....         @rd_pg_rn
+REVW_z          00000101 .. 1001 10 101 ... ..... .....         @rd_pg_rn
+RBIT_z          00000101 .. 1001 11 101 ... ..... .....         @rd_pg_rn
+
 # SVE vector splice (predicated, destructive)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
 
-- 
2.43.0


