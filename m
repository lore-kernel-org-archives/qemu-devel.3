Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9189CF588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3SZ-0000Nt-Qp; Tue, 21 Apr 2026 01:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rj-000851-C9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rf-0006bw-8o
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so37326625ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748484; x=1777353284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NN6xt2iu0Bo8EfnYcUGgF0JIURAXR/oqDeZBep1wYU=;
 b=pi2H9zOWQaLJr/dpsFaSjfNvrdRkZMVUw5qCDdZ5TPvyZLYPRllX9OjlRaEZwwVGy8
 qN7bCmAZKd0C0Hp4awmVwkA1coiIaldRuhpcBEgblW3L47xn+KZj+wXIbIV+54lTrj0g
 XXs1lynd9mpx74IO61Tp4rQh17DBo6qHZenMZf7eqCXgWsFqy/QMPI5VY2MY/qxjCKAZ
 HSUdD2r6tGN2/ZxRwf3AS5Uqeh9KrsZTkn29BAIPweSixS8eKk/sG23pgpf2z2PcfeGz
 dh8Y0VtfIe0HgzKbnUyaJ10BznoIYnIkyoavqkpQ1GB5ztiLe+dvkLe0Upn01OH4N/Dq
 rtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748484; x=1777353284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0NN6xt2iu0Bo8EfnYcUGgF0JIURAXR/oqDeZBep1wYU=;
 b=m96KhkzTFE3UekMsiQj9OpKd8SY0LoHhor4k1D9me4HxO82axNrrSJpbMW0Z2h5fOc
 hTaVHQkXIslOrOK9+xfddMzWhGTm7ydOSQPUGY5V+9HWeH8Ylt6DixUyeroGrYk/guDt
 xeDiun4k+rhjbVWN/8YkmIUgLmqagDd8Gn3TO7EWMv+2BcjecqQNcSs+f3hJhEdsQOiU
 Lt7ufXtpfHpG7mNypEk5P/YiZ/Y3Eu9F0FsFyw8dfLAn+MURCIVl+9hjzzcOa0JXinTx
 L4nJYlBw9St6FDMlBaXylwR6iDD5bZ0bYEOEivorOCYp6xkGTLBWSDR5m8nowPbbgFdh
 P4dQ==
X-Gm-Message-State: AOJu0YyV+h1GIjMdLo8CUxM3+w/vw1LtHicljBQ1nFHIXIfIuzWkuyiB
 RIlkHDjseHw7ARUGDWbiuqTamTZjY8fikAoit5ZHvJ+p+dX7EI8jAYUSOFHmnosW3P8O6n5ivW1
 PpgTL5Xk=
X-Gm-Gg: AeBDieuC3RxpYFIO3XJDnyv62uJ06+v4+2euEhO8VrbTpWFyQIHjWMEyBYnGYwymefM
 E51ZMeCqhVEMIQkaXImge8C/O/6r07O2GjIwS13Fw7GVQC56FXLMaF0TShUPJmNFUDfrPlbyNLT
 vpUBqoBaMR3eF9ZDPBWiXinY3tkigBOslh8uts4+Dh95qogN82L6EEIjtDLamUjXGyFSTcpb1UR
 U+guH3mfAopL52QUa1sSihkfeP2KEQmUeE6xUzQo6Q16ayrf/g8JYvHI/7Y0/VJfT1uylAlDi49
 rnXH3IuXOOeC7FTncCjIFa3iNeYrsGdhSyPlyf0OogbyUrvHXt+UB2GUKqzv+0YlMi5IeD0nYP+
 Vo/9S01AEhIypeOOCIQr0Nl3IXeOhzKb85veGU5vOI98bLDwZCN4ZzPDMG1IGU4h23qg0hu1L1z
 jAGMdIY2nxB1p+g6AVQp0WIe3fOm3iDp614zEAe6QF
X-Received: by 2002:a17:902:f08d:b0:2b2:4ded:954e with SMTP id
 d9443c01a7336-2b5f9f2f6ebmr115034335ad.24.1776748484217; 
 Mon, 20 Apr 2026 22:14:44 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 22/37] target/arm: Move vectors_overlap to vec_internal.h
Date: Tue, 21 Apr 2026 15:13:31 +1000
Message-ID: <20260421051346.41106-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 8 ++++++++
 target/arm/tcg/sme_helper.c   | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index b647399b18..dbc098d49a 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_VEC_INTERNAL_H
 
 #include "fpu/softfloat.h"
+#include "vector-type.h"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -461,6 +462,13 @@ static inline void depositn(uint64_t *p, unsigned pos,
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
index ab5999c592..0055e97a2b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -33,12 +33,6 @@
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


