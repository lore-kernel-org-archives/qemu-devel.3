Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3214CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPk-0008Aq-7m; Sat, 16 May 2026 20:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOp-0007FU-4b
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOi-00052d-Mt
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8367df48711so420887b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977823; x=1779582623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWru1QCIwOGhRVfqONB531T6JUAP9Yz4VcrPsm570nM=;
 b=opBm/S535v4Ty+xC7WxtAukQhhjB8CfH0eL1l6AuAIZeqOOs0PvRmmvAW1WyeVNylY
 M+tteDrpU3YrIswcGwH4WXIb1GdkneoXZ2Ss648U9zcuuyA03Clmv6dAQxb1maqZTjFN
 Q4Yr8rtZBEv8SYuGl8/hyavRbHSxvOColzTBsUB8rO0wE1yoJ0eTRWmAjud2nboUgviC
 k2itjvlLpC+k9tEh0PFTko+bTyY1g8OOl6hNPJlCOLl1gXEQR+fDJcijPw0ygWqjrLqm
 Gb7rhWENZD3UE/jX05UkIZyDevCMjc6Cr/jul70RLQHq/9j4NLsmYs70ExJW/m9phmpl
 DrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977823; x=1779582623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWru1QCIwOGhRVfqONB531T6JUAP9Yz4VcrPsm570nM=;
 b=U5ziKID+2qUQWiG8pEi6rM3K+ZAsNFJ8IBbNPhB8tpy5u1LYgelld8NGPjnPgXoaks
 Q8Oo3OEdC4biZ3W9d3KIGHAn1iudLWcgiJ7KWd6Fxx/0jJfvlGfGkGfaTuFojOkGNJHD
 kLJfXWAROhlWCNZG5BLH7KWt7S2gBhKHJmLjsnSlhGWs7mk/fV1Cs969hqq/VmKnWXob
 a0GkSmyfJ7f9MBv4u6/SC/I1bBSTR/McRJvCkEUSO72BHhcBhkzzGsDIiBWMtU0KGkUT
 QqXCL37B8Jg1uZMgkJEvJq8BEd/Lv6bIEsa370CFRuaZ5Kkt3T33Mb3AAhK2Mhn6dBKY
 nsGg==
X-Gm-Message-State: AOJu0YyIfBL4iZHbrdHs8lLYSjsCuuj1IFuaPIIpYxAFKzcfFJoybiNi
 dMH2ZU7qvXlUIYFe+T6mW6TJivnTTT1X0jt1dn8GS/8fnOUtxs7PRsLQRbam2vakiRANG7ckXve
 gBSty
X-Gm-Gg: Acq92OF4qmXVVonnY3MOLRov6NGxzG41O1Dge+juHegP80R0iNk/955NytusGV13UXA
 eduf/+iKfIIHz8GPosdGpkUYBcgsHDDJx3vYANaKokFzdBF7d40Rbm6gd3hoK34AoGdIaw2aN5q
 MaHmnggds9GgCnE5QnTT5dEZ7PaV1E955W/jnQUogY26k0byxZazl5rmkmwUljWsxwqTUwlJw5u
 GH4Le8p91hGN+jU9M9dRxvS4+YAjVc1Ol7F++0sJMj/TSvXbkXxS0VVX/p9EYlASldhWp6zoxiZ
 MEiJWjbeOpqleIJfeGJtXX+JIThXcy5X1xwucbCCXNKLHqeze+KccW97lx1WSjfBCsWxJUq3dom
 yC/tmS2v/HN9s/MNFSk+6Zj064KzNkT6WgI6rfQBL+7CDP2J11cbvpGpIo1sF7WZbpAueKJiSU0
 psZ5BAy9bOLMrugJ3X20ADWaUeR+oW
X-Received: by 2002:a05:6a00:3695:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-83f33c32a19mr9737704b3a.3.1778977822585; 
 Sat, 16 May 2026 17:30:22 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 22/63] target/arm: Move vectors_overlap to vec_internal.h
Date: Sat, 16 May 2026 17:29:21 -0700
Message-ID: <20260517003002.321430-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


