Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B81C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbf-0002iC-Fg; Sun, 11 May 2025 23:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJag-0008Lo-Uf; Sun, 11 May 2025 23:12:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaf-0006r9-73; Sun, 11 May 2025 23:12:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c277331eso4294936b3a.1; 
 Sun, 11 May 2025 20:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019547; x=1747624347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvKWlAOv6gqOYnMANheHLFdxZjIYTAVqhgBLtzwasVg=;
 b=XO1HNrZ3svyn/dpU/5sIndVx9XA8ak5ufW0Bes5F11cIP5IAzw3y6HiPoXqz9uaKYv
 DfJyiMWRmA6xG/21KFM/K4S8cDGOU/TKZ/j9lFEFVPEb6N6xLP4HYoU+I2TJ3noSwnbg
 09m5t9e2ecUAPcQBwlHhO3YGO/+RlKKrHzmo6hu7KQizgMJ21Wce/QiCr2jtBKdM/Smn
 BkM0YiQDOtAqpE4VYoLAYHJOtKV58dWUGmQmjYhKit3RJYKuuF1B+V/t1yo3fZxswUKy
 o+urEwpbHZ+4pmJPGzUv9Fv4Q7tVP5/BI8pyvXbIGsYwHFvyLLFNRqigsq01TCuUnnFI
 AVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019547; x=1747624347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvKWlAOv6gqOYnMANheHLFdxZjIYTAVqhgBLtzwasVg=;
 b=wATXxAEtp1iZpGFzIXnxwhD77Pdv6Ov7kV1uhJ6k3MlTYR7a0CcPVUMoiaZeFguTkc
 QhmsT3FdBt8Ffz6uHYaUijCyG2297zAhOf2iGbJ22oB4CE9g2cf9JuzmrOLEMK8ND3cL
 iIvlnFZ9l45KnTOXMRvRG6rpxNlXMdbGbnJ2PgCFiztz6GYJxcvY5rqNMGhhafriO5+L
 YwhmHhuLsTC4PSUbl9d4M4LApPskltwZvofnH9yztMZF2EORYinzmctSUAY9q/mFsjCl
 iw+aVELpb5YFsI2AfalgS10lnbOUlCU0VIdNAP0V5wFIZt22I/a8aJM02h5HyDP1/Rxl
 txEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnigiXtLVs6jQVxGYemiR0I0baH8ZXhr732MmvOFpM9Yhp5L/xFuOgxJm/ZPUC17KCy0k9fVxSp+7A@nongnu.org
X-Gm-Message-State: AOJu0Ywli9VMyD6nTXLpmbwQ9Xw0dg7SO2ZwHGFX469sJnvO1wXsLndp
 U5zC0hE4gJnNynwsQtJRjdQz6bVJSl4ZgpMKIcCi0ch5ctmTAQtS+le+xA==
X-Gm-Gg: ASbGnctXl8JQSefIn1RPsBnRL7Vb4oShnNLzQbpj6z4oSvkcKi96D/XxQdt0Iwpq52Q
 1r6pGFsd3o2jcj7c2nN5rzD8mCwXHDKRVoMv5MDvIpkl/iUorPiCHzt31JVkviMNA137GjdqryQ
 REv6mn+uf3P6YEBVDNLfzCyPti+h8E8s/PrFVqqmksgGn607c7db8YEv3WkxPur79/hi0cqX1bB
 CpRZy4GbECzxntuyTlt/uYwKVjL7AF1OIhjCnUtzSXVXzpMEWKXMoJnljMo5qpJJ13ref96au6b
 ura4jXVIc6egMiqI0VKAicso7Xpdd0UInAZfILQsgiTLdlrDPbqbI8rStA==
X-Google-Smtp-Source: AGHT+IFxnzSkJ2TdGyPjE56rzR0H91u1E65jH6DGz5p4eXhTCDzSrH14ENJ/x+2vFQKW2vComJkgDw==
X-Received: by 2002:a05:6a21:6481:b0:1ee:ba29:d8fa with SMTP id
 adf61e73a8af0-21599fb5cdamr23657763637.6.1747019546888; 
 Sun, 11 May 2025 20:12:26 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 21/50] ppc/xive2: add interrupt priority configuration flags
Date: Mon, 12 May 2025 13:10:30 +1000
Message-ID: <20250512031100.439842-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Glenn Miles <milesg@linux.ibm.com>

Adds support for extracting additional configuration flags from
the XIVE configuration register that are needed for redistribution
of group interrupts.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/pnv_xive2.c      | 16 ++++++++++++----
 hw/intc/pnv_xive2_regs.h |  1 +
 include/hw/ppc/xive2.h   |  8 +++++---
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index c9374f0eee..96b8851b7e 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -605,20 +605,28 @@ static uint32_t pnv_xive2_get_config(Xive2Router *xrtr)
 {
     PnvXive2 *xive = PNV_XIVE2(xrtr);
     uint32_t cfg = 0;
+    uint64_t reg = xive->cq_regs[CQ_XIVE_CFG >> 3];
 
-    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS) {
+    if (reg & CQ_XIVE_CFG_GEN1_TIMA_OS) {
         cfg |= XIVE2_GEN1_TIMA_OS;
     }
 
-    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE) {
+    if (reg & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE) {
         cfg |= XIVE2_VP_SAVE_RESTORE;
     }
 
-    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE,
-              xive->cq_regs[CQ_XIVE_CFG >> 3]) == CQ_XIVE_CFG_THREADID_8BITS) {
+    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE, reg) ==
+                      CQ_XIVE_CFG_THREADID_8BITS) {
         cfg |= XIVE2_THREADID_8BITS;
     }
 
+    if (reg & CQ_XIVE_CFG_EN_VP_GRP_PRIORITY) {
+        cfg |= XIVE2_EN_VP_GRP_PRIORITY;
+    }
+
+    cfg = SETFIELD(XIVE2_VP_INT_PRIO, cfg,
+                   GETFIELD(CQ_XIVE_CFG_VP_INT_PRIO, reg));
+
     return cfg;
 }
 
diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index e8b87b3d2c..d53300f709 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -66,6 +66,7 @@
 #define    CQ_XIVE_CFG_GEN1_TIMA_HYP_BLK0       PPC_BIT(26) /* 0 if bit[25]=0 */
 #define    CQ_XIVE_CFG_GEN1_TIMA_CROWD_DIS      PPC_BIT(27) /* 0 if bit[25]=0 */
 #define    CQ_XIVE_CFG_GEN1_END_ESX             PPC_BIT(28)
+#define    CQ_XIVE_CFG_EN_VP_GRP_PRIORITY       PPC_BIT(32) /* 0 if bit[25]=1 */
 #define    CQ_XIVE_CFG_EN_VP_SAVE_RESTORE       PPC_BIT(38) /* 0 if bit[25]=1 */
 #define    CQ_XIVE_CFG_EN_VP_SAVE_REST_STRICT   PPC_BIT(39) /* 0 if bit[25]=1 */
 
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 2436ddb5e5..760b94a962 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -29,9 +29,11 @@ OBJECT_DECLARE_TYPE(Xive2Router, Xive2RouterClass, XIVE2_ROUTER);
  * Configuration flags
  */
 
-#define XIVE2_GEN1_TIMA_OS      0x00000001
-#define XIVE2_VP_SAVE_RESTORE   0x00000002
-#define XIVE2_THREADID_8BITS    0x00000004
+#define XIVE2_GEN1_TIMA_OS          0x00000001
+#define XIVE2_VP_SAVE_RESTORE       0x00000002
+#define XIVE2_THREADID_8BITS        0x00000004
+#define XIVE2_EN_VP_GRP_PRIORITY    0x00000008
+#define XIVE2_VP_INT_PRIO           0x00000030
 
 typedef struct Xive2RouterClass {
     SysBusDeviceClass parent;
-- 
2.47.1


