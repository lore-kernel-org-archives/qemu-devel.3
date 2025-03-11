Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15EFC35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzGR-0007yv-8D; Tue, 11 Mar 2025 09:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzD0-0003Hr-21; Tue, 11 Mar 2025 08:59:46 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCx-00081L-UP; Tue, 11 Mar 2025 08:59:45 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso9409631a91.0; 
 Tue, 11 Mar 2025 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697981; x=1742302781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRjGMMyN8Fta0GJMwT6WyLidcFv71ZTmFrwphwzXpVk=;
 b=KBSbvW9mT9ddb5wFaCIzW/+Zb9g1GsHjFds+0t2c5SIH2RWh/0D4B2xZhrp9KSlSVD
 NfuRJ4Gu0bvWgHnTIQLBlx+kMgFCV3MfuZYdHKdJ+Zv1Q5TicN8giEr4ZrDoWnbySjI5
 FJKyCKoey6++0Zb9Cp3x0UA4kVamRxXUHHEQwzZR9rqgRPNfGVKcieO9fLC2qRIpw5+S
 Is6/Aj/rI82CTPynBVtmeOcWkZWjc0FTkgbdViyn/AMRbHRC4XASYnUaRcqwzUyPZf7o
 g3KUvHl781TFsu6v3TgCFHXF4kQKwsijXFmJ7rZmZGzDIIv/D7Tb7msR5fE7/kIcdZDp
 XGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697981; x=1742302781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRjGMMyN8Fta0GJMwT6WyLidcFv71ZTmFrwphwzXpVk=;
 b=NgBS38ndc0cKDmdy6q8Wo4vlQBEk8zqKMUlMPk51FzAGPFRsJQ8ols/95zp+PbBjpe
 32bQwVOdY9G+3qZFyZI8y/TaUgutq7x2VT7ERme3XpGcke7EU5mYLkjO88x4dSfBoZ5v
 aWyFePsgDdkrWKgWUrzjU0gScw+4Qy0YVnGY0TDKHU5VWCkGEqw2xsjHoqrvzGP+jDQn
 om/D8x8BcFAaspb8w0s1meltv/GFHWzEKX3R2TrOzmEMw2KaAFV0Lmyotz9XbqzIjj9D
 dezy6P2iABSSCeeG807RbqzV33Q3WkCCDrc1VnC0zs9KvUV3gV/NxCPxYVyMg0Nlj9FS
 N10g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOjYk6hxWTBjGMRozhQsfvztFxL6SUgPUIA1K3Fn+LctEONhq9zwdQZoVfsXzwXDpudHYAapLusw==@nongnu.org
X-Gm-Message-State: AOJu0YxOMt7iAbfiDfSh1EmU6hth9GZHSLti7o4v4auFOx1UzwLAdrFd
 HvN5aJh5YBtRv9wdBYkKJGx1zlmCXFyUjw4yebnycbEyZHq0rxlKWlVwFQ==
X-Gm-Gg: ASbGncsZ1FTJ7lQqDYA3C/z/oLoZ9Qiejw3J0hLLIXiRlvAfj4f6Vi02rryQHBsnKGr
 oTkwWD3BYqF5kEw6xL0PfXsNKGu1BtuE2TMtKeHGWhmkFJscMa+eacIcnv+lAhyVbfvkngbdjs6
 F6RqoqsBRwcr1J6NLez1YtZfusVdkDr18CB70aecpVBhXwE/GQhMk3yg/G63bVENVIvEJQEmv4o
 fIAQgR/0Oz3Z7jh7DOEx8UHdwJDRxynZHtIfeEjVxE7NpdLP16Eu32Xa4urEe911EjHyPyhSBas
 IYUpD6f8n7p969GM7gpyNOcIRztI8FtZgxybh8UGwRnY+bZKi9c=
X-Google-Smtp-Source: AGHT+IGlDc6s3YJsqfn76XrlHsjEZ1RPr/bFxF9kUztMEsytOBLmIYr82HlGHywm0x4NR18qXrtByA==
X-Received: by 2002:a17:90b:384a:b0:2ee:9661:eafb with SMTP id
 98e67ed59e1d1-30100546828mr4565682a91.12.1741697981420; 
 Tue, 11 Mar 2025 05:59:41 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 24/72] ppc/xive: Rename ipb_to_pipr() to xive_ipb_to_pipr()
Date: Tue, 11 Mar 2025 22:57:18 +1000
Message-ID: <20250311125815.903177-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Michael Kowal <kowal@linux.ibm.com>

Rename to follow the convention of the other function names.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c        | 22 ++++++----------------
 include/hw/ppc/xive.h | 16 ++++++++++++----
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 139cfdf9bf..f603d9f1a5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -3,8 +3,7 @@
  *
  * Copyright (c) 2017-2018, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -27,15 +26,6 @@
  * XIVE Thread Interrupt Management context
  */
 
-/*
- * Convert an Interrupt Pending Buffer (IPB) register to a Pending
- * Interrupt Priority Register (PIPR), which contains the priority of
- * the most favored pending notification.
- */
-static uint8_t ipb_to_pipr(uint8_t ibp)
-{
-    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
-}
 
 static uint8_t exception_mask(uint8_t ring)
 {
@@ -159,7 +149,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
      * Recompute the PIPR based on local pending interrupts.  The PHYS
      * ring must take the minimum of both the PHYS and POOL PIPR values.
      */
-    pipr_min = ipb_to_pipr(regs[TM_IPB]);
+    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
     ring_min = ring;
 
     /* PHYS updates also depend on POOL values */
@@ -169,7 +159,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         /* POOL values only matter if POOL ctx is valid */
         if (pool_regs[TM_WORD2] & 0x80) {
 
-            uint8_t pool_pipr = ipb_to_pipr(pool_regs[TM_IPB]);
+            uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
 
             /*
              * Determine highest priority interrupt and
@@ -193,7 +183,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
     uint8_t *regs = &tctx->regs[ring];
 
     regs[TM_IPB] |= ipb;
-    regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
+    regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
     xive_tctx_notify(tctx, ring);
 }
 
@@ -841,9 +831,9 @@ void xive_tctx_reset(XiveTCTX *tctx)
      * CPPR is first set.
      */
     tctx->regs[TM_QW1_OS + TM_PIPR] =
-        ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
+        xive_ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
     tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =
-        ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
+        xive_ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
 }
 
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ea5d03a346..75276b9ba6 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -130,11 +130,9 @@
  *   TCTX   Thread interrupt Context
  *
  *
- * Copyright (c) 2017-2018, IBM Corporation.
- *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * Copyright (c) 2017-2024, IBM Corporation.
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef PPC_XIVE_H
@@ -510,6 +508,16 @@ static inline uint8_t xive_priority_to_ipb(uint8_t priority)
         0 : 1 << (XIVE_PRIORITY_MAX - priority);
 }
 
+/*
+ * Convert an Interrupt Pending Buffer (IPB) register to a Pending
+ * Interrupt Priority Register (PIPR), which contains the priority of
+ * the most favored pending notification.
+ */
+static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
 /*
  * XIVE Thread Interrupt Management Aera (TIMA)
  *
-- 
2.47.1


