Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F1FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAB-0006tN-0t; Wed, 29 Apr 2026 20:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9v-0006nI-NT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9u-0006Ls-1F
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:39 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82f431c0ab6so189541b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508496; x=1778113296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWru1QCIwOGhRVfqONB531T6JUAP9Yz4VcrPsm570nM=;
 b=PO+VjProXmd4LEkzPinzT5kScRz3RgqsEuTGNk+2rlfb0voYr/NawWV05+AMDVd52l
 bPRibzsbPlURP7QyAWLfEz2JdLpJx/+MdZRfd3hKHYciBlSoMaufpbUneVl9Mq/+tlRG
 76IL2vcLp/SgeJyyJhHYwi/4fZfqnXUJ3y7w7qwThADRDHgP0UoJ2W6jhToYdAXgMlJU
 1VJpjZC2EMPavneiuT/2lKfVWfbpuOAQlB171p5Hz/61PsTbSG5NSecTkR7g4HBfi5aJ
 nBThL+jqz9TmiiOpEz0gBzU9o3pahALEVdmbB4f+g+dmoR/kZGiJHZ3tB1PwxHO6D2pT
 2+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508496; x=1778113296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWru1QCIwOGhRVfqONB531T6JUAP9Yz4VcrPsm570nM=;
 b=oauxTIxi5d8GURGc4dD5vRejCX+PRLlhg8RZeJCwFQu5LXxXpU03cUAQiG/PMZVl2g
 M2djGn3tPF6BZ3P6nkgEjZC/g33axJsg8U1U0P1ldjaPTyE6DpSR6HGZhz7uda5OnsQa
 gvOCknOmIcTttDd12IocFADalFSAs37VJhzAGvS32miwq84ZTFffyPE69Fu+C41XULi2
 kr0Uq/wgCKi1XiPaNkGgc5/hl5FSlOzxgudVOXphP/i4tzXvr0OlFmgZM5pTchVfyqF9
 60a5utIqRUbqm2CF7FXX0Bzb9BYxH8HyrCfORd0HkP95Rx0x7zwZ4N7se1NjNsb2j/Dc
 gxvw==
X-Gm-Message-State: AOJu0Yy7/ELyKFAr5Pmk3zVE9WTJl4TEMpW0mh3Kop0Qbts5PST90RYR
 PqV5FXXNcsRZwgSBHw6hpXQiZC2y/G/1V3EMlyNeIN9Ge8yVNQreLVSdMacQtAw3DdJzG8dUiXN
 9DkUdgw0=
X-Gm-Gg: AeBDieufS1/KVXkUVvQWuwHFqFEDWrLtaelOQP2LpAIS6gHPkVQCi+RZnZUCa1jD4LK
 TEMAf2c3+prEkBsqLLEHLgcAqKgL2Snhv4pvFWYV8uLdoAOyNy9PzWW0p+RZ1m1ooStq8CnyEXn
 Q8GF4aG2HBTP4FWH6lTBWvFclgCMkLrdUoj1CRj15kf34Ki/WqcAjJeS2GGfdmgluLwVRECAtFK
 cc9bZF8NzB6u2jZ4us8fDrJGSa89K9ooOLPp8R1Yjz8nNAUSZ3S1S8u2KYDbxBayCDNrn4aAhr/
 xxoYhn+o6bg5/Z4cLLJES9gtknQO/kUeBYChkXtPHja5r4dDNh8L/lRoOyvTGY6y5Mu07Vk5+Df
 JMjBpXiFxdZdL3hzvW2ux+ubwedd+yjLaCUP6pv1xUYfjbJujahG7HPnL++L+tGtF7taBahDwGK
 tGu6LJi02toa8vH239ZPTMnI2120yvomixd0zr8lVs
X-Received: by 2002:a05:6a00:27a4:b0:82c:7767:5bb2 with SMTP id
 d2e1a72fcca58-834fdc40e50mr749879b3a.21.1777508496409; 
 Wed, 29 Apr 2026 17:21:36 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 20/47] target/arm: Move vectors_overlap to vec_internal.h
Date: Thu, 30 Apr 2026 10:20:19 +1000
Message-ID: <20260430002046.59739-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

We will shortly need this outside of sme_helper.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 8 ++++++++
 target/arm/tcg/sme_helper.c   | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 68b1116171..b906d2a2e6 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_VEC_INTERNAL_H
 
 #include "fpu/softfloat.h"
+#include "vector-type.h"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -457,6 +458,13 @@ static inline void depositn(uint64_t *p, unsigned pos,
     }
 }
 
+/* Determine if [x, x+nx) overlaps [y, y+ny). */
+static inline bool vectors_overlap(ARMVectorReg *x, unsigned nx,
+                                   ARMVectorReg *y, unsigned ny)
+{
+    return !(x + nx <= y || y + ny <= x);
+}
+
 #define DO_3OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
                   float_status * stat, uint32_t desc)                      \
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 16b96890cc..7ef6f5d71b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -34,12 +34,6 @@
 #define HELPER_H "tcg/helper-sme-defs.h"
 #include "exec/helper-info.c.inc"
 
-static bool vectors_overlap(ARMVectorReg *x, unsigned nx,
-                            ARMVectorReg *y, unsigned ny)
-{
-    return !(x + nx <= y || y + ny <= x);
-}
-
 void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
-- 
2.43.0


