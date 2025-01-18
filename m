Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD501C02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ2xS-0003Dc-PZ; Sat, 18 Jan 2025 02:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xG-0003CP-Ru
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:17 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xE-0007oB-Qk
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:14 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2161eb94cceso35890205ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184150; x=1737788950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cx7Pxt/DNCLGhkMoyXvElc9TbIWqgkun0mAfcUqVZM=;
 b=kiuHL/xee5wlwkfNvZbPWQB1y0NuwP9nwuQ08yScfdB4JOYcuoSTGn+fhLgr+YFh4s
 uJBbvBz0XbIlJDLDZeVelO4/ltbuldcFTPORVZPSZ6/O3pbygzcZ7Nu2UVD17BqZRvoT
 o2z70pTShwVVyvcV6oWWPGcuU1tyh8yF9fX+XmFSv+ucJ6WrkrFNTqvbiWJN/kiJwrWa
 SljWqIByAUOEiMNqKTbB9hBIgHkHr27CWZ5ARdoVG+j+NCnQ792unndnduPTeONAEUn0
 2zNQlEJR5MxT+UMex/a8YmthoWmANoKHMvJCOi2KJa3uWU9xfTiyULmEIkCvkp5CbdeN
 zlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184150; x=1737788950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cx7Pxt/DNCLGhkMoyXvElc9TbIWqgkun0mAfcUqVZM=;
 b=U04OkVQhmEjuxCVJOQUAzRHK65Iuzs6eNf0GH9jHa+cfyGOmVFfnhuCBEv8zDCRL4T
 6zUxlAY7Ip38sotZ0FndItFN6t9Q3d7x7dbUb/QKu7KHNEWPFGETunI+OWnq1ZdmlbK9
 tLrklmhIcVbLB4OaRqByRtxo+6CeFTbc5qe/kAuNpI5j9jHb72rrac+HJlbXwGS0PyiK
 W8CrL+01qG6ufBRiWwRyF2vmL+jKKXYsEmZQg6KUjdLI3sIOfTSgqWSZZX/pCivRA+7L
 npZI39CRE2dR2Kmybd5pSA3VahIEmULFMiicNKn6vFypxBe0+D24Dsam4auwqvhK5/kF
 2uig==
X-Gm-Message-State: AOJu0Yy35Nrd5/aX7ct2Ipyld7+UuhW9t+C8J+In7wprDm3e+QgS+qn0
 pg9GrmtCua4wqTIoM3WYdLC3YskeXvk7nTPAgjQxSLXY6Km1+7PfYLIo9g==
X-Gm-Gg: ASbGncsJCPMR9mHavsenpHjnjWHaMWLsWzzU8wa2YlYRoCZUC8w/BSP9+DqZnfBWDfr
 UElV52NLDs1hX26KOx7Ic6L9iE3cfeUKcAEWfeMnR8rE+bZKqGWNvOyJ33dd5n0Id6zbnlfFVYU
 /Bfa3LJ9hjtIvwC5crgdiYsYHTKcy7hqltRGMnPJ1WL4ZipiFKI1Oxfkufkn/r7yzwzHYFFGCdh
 p1LmqjG4umFFCo+JQV9aZkfamccPNYyrGuGBwKycAUpqIs/nFsk9S3v+cIe6OJwHdSqDPhdTQWW
 J3UOGdZxq3ORGa9gzMx2xgKO1czN
X-Google-Smtp-Source: AGHT+IFqOuidF1n+qV3hPTMWqVK5wrAuoYBjE8s6o6zAgBZpsRzpqVXTrXXYo5T7/G3RNeoWw0rybw==
X-Received: by 2002:a05:6a21:164e:b0:1e0:d1c3:97d1 with SMTP id
 adf61e73a8af0-1eb215685b5mr10475199637.29.1737184150547; 
 Fri, 17 Jan 2025 23:09:10 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c95adsm3192880b3a.107.2025.01.17.23.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:09:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 2/8] hw/usb/xhci: Rename and move HCD register region
 constants to header
Date: Sat, 18 Jan 2025 17:08:47 +1000
Message-ID: <20250118070853.653778-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250118070853.653778-1-npiggin@gmail.com>
References: <20250118070853.653778-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

This also adds some missing constants rather than open-coding
offsets and sizes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci.h | 16 ++++++++++++++++
 hw/usb/hcd-xhci.c | 48 ++++++++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index bd1d8e8e81a..8557f59dafe 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -115,6 +115,22 @@ typedef enum TRBCCode {
     CC_SPLIT_TRANSACTION_ERROR
 } TRBCCode;
 
+/* Register regions */
+#define XHCI_REGS_LENGTH_CAP         0x40
+#define XHCI_REGS_LENGTH_OPER        0x400
+#define XHCI_REGS_LENGTH_PORT        (XHCI_PORT_PR_SZ * XHCI_MAXPORTS)
+#define XHCI_REGS_LENGTH_RUNTIME     ((XHCI_MAXINTRS + 1) * XHCI_INTR_IR_SZ)
+/* XXX: Should doorbell length be *4 rather than *32? */
+#define XHCI_REGS_LENGTH_DOORBELL    ((XHCI_MAXSLOTS + 1) * 0x20)
+
+#define XHCI_REGS_OFFSET_CAP         0
+#define XHCI_REGS_OFFSET_OPER        (XHCI_REGS_OFFSET_CAP +   \
+                                      XHCI_REGS_LENGTH_CAP)
+#define XHCI_REGS_OFFSET_PORT        (XHCI_REGS_OFFSET_OPER +  \
+                                      XHCI_REGS_LENGTH_OPER)
+#define XHCI_REGS_OFFSET_RUNTIME     0x1000
+#define XHCI_REGS_OFFSET_DOORBELL    0x2000
+
 /* Register definitions */
 #define XHCI_HCCAP_REG_CAPLENGTH            0x00
 #define XHCI_HCCAP_REG_HCIVERSION           0x02
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d21b0543957..76eb473c150 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -46,22 +46,14 @@
 #define COMMAND_LIMIT   256
 #define TRANSFER_LIMIT  256
 
-#define LEN_CAP         0x40
-#define LEN_OPER        (0x400 + XHCI_PORT_PR_SZ * XHCI_MAXPORTS)
-#define LEN_RUNTIME     ((XHCI_MAXINTRS + 1) * XHCI_INTR_IR_SZ)
-#define LEN_DOORBELL    ((XHCI_MAXSLOTS + 1) * 0x20)
-
-#define OFF_OPER        LEN_CAP
-#define OFF_RUNTIME     0x1000
-#define OFF_DOORBELL    0x2000
-
-#if (OFF_OPER + LEN_OPER) > OFF_RUNTIME
-#error Increase OFF_RUNTIME
+#if (XHCI_REGS_OFFSET_PORT + XHCI_REGS_LENGTH_PORT) > XHCI_REGS_OFFSET_RUNTIME
+#error Increase XHCI_REGS_OFFSET_RUNTIME
 #endif
-#if (OFF_RUNTIME + LEN_RUNTIME) > OFF_DOORBELL
-#error Increase OFF_DOORBELL
+#if (XHCI_REGS_OFFSET_RUNTIME + XHCI_REGS_LENGTH_RUNTIME) >    \
+    XHCI_REGS_OFFSET_DOORBELL
+#error Increase XHCI_REGS_OFFSET_DOORBELL
 #endif
-#if (OFF_DOORBELL + LEN_DOORBELL) > XHCI_LEN_REGS
+#if (XHCI_REGS_OFFSET_DOORBELL + XHCI_REGS_LENGTH_DOORBELL) > XHCI_LEN_REGS
 # error Increase XHCI_LEN_REGS
 #endif
 
@@ -2582,7 +2574,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
 
     switch (reg) {
     case XHCI_HCCAP_REG_CAPLENGTH: /* Covers HCIVERSION and CAPLENGTH */
-        ret = 0x01000000 | LEN_CAP;
+        ret = 0x01000000 | XHCI_REGS_LENGTH_CAP;
         break;
     case XHCI_HCCAP_REG_HCSPARAMS1:
         ret = ((xhci->numports_2+xhci->numports_3)<<24)
@@ -2602,10 +2594,10 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
         }
         break;
     case XHCI_HCCAP_REG_DBOFF:
-        ret = OFF_DOORBELL;
+        ret = XHCI_REGS_OFFSET_DOORBELL;
         break;
     case XHCI_HCCAP_REG_RTSOFF:
-        ret = OFF_RUNTIME;
+        ret = XHCI_REGS_OFFSET_RUNTIME;
         break;
 
     /* extended capabilities */
@@ -3255,22 +3247,26 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
 
     memory_region_init(&xhci->mem, OBJECT(dev), "xhci", XHCI_LEN_REGS);
     memory_region_init_io(&xhci->mem_cap, OBJECT(dev), &xhci_cap_ops, xhci,
-                          "capabilities", LEN_CAP);
+                          "capabilities", XHCI_REGS_LENGTH_CAP);
     memory_region_init_io(&xhci->mem_oper, OBJECT(dev), &xhci_oper_ops, xhci,
-                          "operational", 0x400);
+                          "operational", XHCI_REGS_LENGTH_OPER);
     memory_region_init_io(&xhci->mem_runtime, OBJECT(dev), &xhci_runtime_ops,
-                           xhci, "runtime", LEN_RUNTIME);
+                           xhci, "runtime", XHCI_REGS_LENGTH_RUNTIME);
     memory_region_init_io(&xhci->mem_doorbell, OBJECT(dev), &xhci_doorbell_ops,
-                           xhci, "doorbell", LEN_DOORBELL);
+                           xhci, "doorbell", XHCI_REGS_LENGTH_DOORBELL);
 
-    memory_region_add_subregion(&xhci->mem, 0,            &xhci->mem_cap);
-    memory_region_add_subregion(&xhci->mem, OFF_OPER,     &xhci->mem_oper);
-    memory_region_add_subregion(&xhci->mem, OFF_RUNTIME,  &xhci->mem_runtime);
-    memory_region_add_subregion(&xhci->mem, OFF_DOORBELL, &xhci->mem_doorbell);
+    memory_region_add_subregion(&xhci->mem, XHCI_REGS_OFFSET_CAP,
+                                &xhci->mem_cap);
+    memory_region_add_subregion(&xhci->mem, XHCI_REGS_OFFSET_OPER,
+                                &xhci->mem_oper);
+    memory_region_add_subregion(&xhci->mem, XHCI_REGS_OFFSET_RUNTIME,
+                                &xhci->mem_runtime);
+    memory_region_add_subregion(&xhci->mem, XHCI_REGS_OFFSET_DOORBELL,
+                                &xhci->mem_doorbell);
 
     for (i = 0; i < xhci->numports; i++) {
         XHCIPort *port = &xhci->ports[i];
-        uint32_t offset = OFF_OPER + 0x400 + XHCI_PORT_PR_SZ * i;
+        uint32_t offset = XHCI_REGS_OFFSET_PORT + XHCI_PORT_PR_SZ * i;
         port->xhci = xhci;
         memory_region_init_io(&port->mem, OBJECT(dev), &xhci_port_ops, port,
                               port->name, XHCI_PORT_PR_SZ);
-- 
2.45.2


