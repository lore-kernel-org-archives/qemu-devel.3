Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB500C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzFa-000704-Up; Tue, 11 Mar 2025 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCy-000364-Fu; Tue, 11 Mar 2025 08:59:45 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCw-00080x-3m; Tue, 11 Mar 2025 08:59:44 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso9001086a91.3; 
 Tue, 11 Mar 2025 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697979; x=1742302779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqPpSFq/0fdsjmu5dGyUqROl/b/bn7/APbML/SqYVto=;
 b=kYojWAGgc5DUc8wymJqbAQxpCVfgANWwY8UHbfUXVHeI9sEYo4H1AIkLuyNiq8tA31
 PwR0/HEDKb1ysDov1/fUKt+Kaeofe23Sgd/4I1ou9sktkp8n5CtbNKitf8WUngHUlpN+
 UFS0UZz8BU4bpHRZX2uVqK8oN1D7U+QcjCwAxYkG28X6TFxO5x4+WSSJA62FcVkrl2/N
 +7b3pdZ5LKJNq3P5KYEPIicUe3oBayJ0xEWzkls/KFXjtu2NJKTx5MOkl0BV4JXfW5gf
 VrqDapPDucgvPb/2JHCHFUrbGRHuur462IjdGGHsf6+3otRpAJ1hSlXI4ZHgC9bdBsSX
 xeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697979; x=1742302779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqPpSFq/0fdsjmu5dGyUqROl/b/bn7/APbML/SqYVto=;
 b=cnLI6NzE7MKpqmUanOOw15ELF2vROwOQvW+uTBwjAO/6T5WJOwD4BFwoAmVGshm9Bq
 eJ6HpuoNOoH1UCwNYBEdSlx0X5DKisu1zr+J+as89pOR8oK5SJ/ML4z+AJj3gto93dUd
 CBnUNdWSI5PHmFF1GQ66o0eaKkQ7rD05Sj2iPpyHaqmUl7qMEuo0AGQ/XwB8lwkkAR4D
 eDj0ZqCNByNGQNRBZAXstjjsI/iAZBS5yRSDaK/eYdzdi8mu2JFd5o+UH/nASgcdcQz9
 /9GGiLOILvooJutqrKDIN/odG9xoz7nUtZ9SYHd4B8LNePi0edbK9uf1rjPz8TbvehV/
 39Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOYtMj0mcsT5o4QyHkmzyZzMwkvh1NCjjz8/e6cR8NelRX36BKWH8CPn0lOktgGh+FT5lOGE3qpg==@nongnu.org
X-Gm-Message-State: AOJu0Ywm5Jfl8VYFyVpXGk+zrmFv2RyCbN1Q8THxoFBPhkHTG97X6lx/
 WGTjC5Y2uV6WUw+JrlZKyJjSGvkbPRC8ULz1skX0k/uD+4Due0csXMFjEQ==
X-Gm-Gg: ASbGncvEYmqQrrwerTHgloAypKsReViBX6RWQNrnktbEwBIf8fAbned1rkyCV5XMYDH
 80uiWNBOU41miCYogdBlvAnXlTEp0UIAsWzfBicSNQTjpEWszvpRj2gBpBx2Cxn7EVMPKvC7GRO
 /Ritfk5N+zMJkL5XiXTg/08yL0sVeJuZZ2NOJzHOcVR75H2/ltB4Vp9DQiWGw+ARDKbR/LpM/gi
 6J791SmUvS969SN0yGC544KFVYVyegAYQ9nA5DoV7OZt0yfzoBjPMfOkkl6k0mbTDoGrZvx6Nl9
 sNVSr+T6m5NbnltgkxRv77OvqSo0eQ8EimrhKkazy9bEYD8hRJYDYVTof5fBpg==
X-Google-Smtp-Source: AGHT+IFCLboP2NEYVER6Ia/nktt0alb7IBxusg86yBWU41313CNd0zQswT6vFclWJ+klo6cKjlNAzw==
X-Received: by 2002:a17:90b:1a8c:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-2ff7ce524ebmr25368424a91.6.1741697978701; 
 Tue, 11 Mar 2025 05:59:38 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 23/72] ppc/xive2: Update NVP save/restore for group attributes
Date: Tue, 11 Mar 2025 22:57:17 +1000
Message-ID: <20250311125815.903177-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

If the 'H' attribute is set on the NVP structure, the hardware
automatically saves and restores some attributes from the TIMA in the
NVP structure.

The group-specific attributes LSMFB, LGS and T have an extra flag to
individually control what is saved/restored.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c             | 23 ++++++++++++++++++-----
 include/hw/ppc/xive2_regs.h | 10 +++++++---
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index fc5aed3315..cd075e4db9 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 interrupt controller model (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation..
+ * Copyright (c) 2019-2024, IBM Corporation..
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -313,7 +312,19 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
 
     nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
     nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
-    nvp.w2 = xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB]);
+    if (nvp.w0 & NVP2_W0_L) {
+        /*
+         * Typically not used. If LSMFB is restored with 0, it will
+         * force a backlog rescan
+         */
+        nvp.w2 = xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB]);
+    }
+    if (nvp.w0 & NVP2_W0_G) {
+        nvp.w2 = xive_set_field32(NVP2_W2_LGS, nvp.w2, regs[TM_LGS]);
+    }
+    if (nvp.w0 & NVP2_W0_T) {
+        nvp.w2 = xive_set_field32(NVP2_W2_T, nvp.w2, regs[TM_T]);
+    }
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
 
     nvp.w1 = xive_set_field32(NVP2_W1_CO, nvp.w1, 0);
@@ -527,7 +538,9 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
 
     tctx->regs[TM_QW1_OS + TM_CPPR] = cppr;
-    /* we don't model LSMFB */
+    tctx->regs[TM_QW1_OS + TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
+    tctx->regs[TM_QW1_OS + TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
+    tctx->regs[TM_QW1_OS + TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
 
     nvp->w1 = xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
     nvp->w1 = xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 1d00c8df64..e88d6eab1e 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 internal structure definitions (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation.
+ * Copyright (c) 2019-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef PPC_XIVE2_REGS_H
@@ -152,6 +151,9 @@ typedef struct Xive2Nvp {
         uint32_t       w0;
 #define NVP2_W0_VALID              PPC_BIT32(0)
 #define NVP2_W0_HW                 PPC_BIT32(7)
+#define NVP2_W0_L                  PPC_BIT32(8)
+#define NVP2_W0_G                  PPC_BIT32(9)
+#define NVP2_W0_T                  PPC_BIT32(10)
 #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
 #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
         uint32_t       w1;
@@ -163,6 +165,8 @@ typedef struct Xive2Nvp {
 #define NVP2_W2_CPPR               PPC_BITMASK32(0, 7)
 #define NVP2_W2_IPB                PPC_BITMASK32(8, 15)
 #define NVP2_W2_LSMFB              PPC_BITMASK32(16, 23)
+#define NVP2_W2_T                  PPC_BIT32(27)
+#define NVP2_W2_LGS                PPC_BITMASK32(28, 31)
         uint32_t       w3;
         uint32_t       w4;
 #define NVP2_W4_ESC_ESB_BLOCK      PPC_BITMASK32(0, 3)  /* N:0 */
-- 
2.47.1


