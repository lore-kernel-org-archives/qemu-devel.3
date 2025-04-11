Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E2EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39IB-0002AN-AB; Fri, 11 Apr 2025 03:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39I8-00028A-Pe
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39I6-0003rP-Rf
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:12 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736c277331eso2667343b3a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358349; x=1744963149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pW3ktPWxZ3GftuE1xtPzSwx/ntzRqF0mx0dzBHfFB40=;
 b=CZ1A+8h4sBqlDdEggoCg+6P6NwNb54P+tNha+iuc6Xd14p0YgH2gIeS3iNa0PtVx+v
 GPhfBljCkEHAsV+8IKtFBKgiwByrJ7Tnb14GOtIdLciPh1xGyVyHPDzT5LUqE1X1KUHO
 yCKZuWHl57Ta7Qg49HNez7VkXl6e2RfUgx546sVQMTJk55YMkOrQsMRtnFDlmxCxq+Xt
 hZ9NVi/F7XJPifnKrVWd6sijUZPq7bKL1lvBSGCZJ9TjIpCD0uV8UzAYcw4MdtRB/+Ak
 yI6vvMdNrN7BJl3sJGHFtmMKXgJdYsQMBH5wewpkFkgWg9Yc9zBxgmPnXlXCkwHrMkCG
 FM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358349; x=1744963149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pW3ktPWxZ3GftuE1xtPzSwx/ntzRqF0mx0dzBHfFB40=;
 b=tsr//i8repCNs3cGHIDMDiGPCar+uzAyJBd/wM09UO2YStJsjxMzR2tQOi9g+Ni5Ld
 Flx/cfiziegzwTsNp/5QizrpeX+4MFA9Nw+jb3cYgn5pSnFCb2T4wp+3StAyOvqvBwEj
 0SBU+cIadFQw0qPwXLcU/qmer5wckG/konKajfPEv/a0B/z2FQiGUU3i7vf6Oz7sxqcd
 LQTxm4KhCe2a3Wf8zjvdw9VtILdk3ndXmo2jjQhlqQJwmDQmdjZ8GtKyRM0ARZE57dpD
 592s0QPDYBB/FhFRTb6wGkx5fa8JHbvoIRMMZURO7d27TFueGA+RPUhtr3q38g6dysq3
 kPAg==
X-Gm-Message-State: AOJu0YwO0gZvVuwA0u4AijZIwRIQ5Etr8nFCvEWrTw58SOnSCW1kqrhJ
 ulrX10A3vLRycIMPNVbvifBBJM28IrlyVCp5cuw0hz33V9rbGMJnYSNbKg==
X-Gm-Gg: ASbGncvKy5pgvN5y25eC7dsz+MdFMyZUE5mdeR8JUXSCW7gVDG4Uz3uSiXeCuHYH87I
 eEpGL6C8qM1YIhOE2W4Zrw+a0BO23CXNTWVwXrud6gQrkJ8UVwcrstcOygOPdJqevgBREP5QnFb
 9ToWlik+FSMTZsKhpreJoavayd8vEHilTZNji1hZdYAfEkGwKo2hGbZXUFbK5u9IBmLLPFQSZkT
 7uvCHDf9X2VFs1usrFH4vHdqs/TLUgFkU1/fpkR1/nQoijEzeqoFBP3wNr7gmqKA3bVSZIXygRM
 yzzQLkoHMzlkkaSrOVMGtn98a6+y3mOLW5dkwaJbNPK+
X-Google-Smtp-Source: AGHT+IGe8PaniikNDMyJPhg50DEA+DDeMQu3i5vDDgiFRIsx0ALrlf6Eu4QIkvc8XnAuqNoCcoWSdA==
X-Received: by 2002:a05:6a00:98b:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-73bd0c23517mr2875750b3a.6.1744358349087; 
 Fri, 11 Apr 2025 00:59:09 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233554asm851687b3a.180.2025.04.11.00.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 00:59:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 2/8] hw/usb/xhci: Rename and move HCD register region
 constants to header
Date: Fri, 11 Apr 2025 17:58:44 +1000
Message-ID: <20250411075851.206995-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411075851.206995-1-npiggin@gmail.com>
References: <20250411075851.206995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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
index ee364efd0ab..20059fcf66c 100644
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
index b57db309b8d..7470db38561 100644
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
 
@@ -2583,7 +2575,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
 
     switch (reg) {
     case XHCI_HCCAP_REG_CAPLENGTH: /* Covers HCIVERSION and CAPLENGTH */
-        ret = 0x01000000 | LEN_CAP;
+        ret = 0x01000000 | XHCI_REGS_LENGTH_CAP;
         break;
     case XHCI_HCCAP_REG_HCSPARAMS1:
         ret = ((xhci->numports_2+xhci->numports_3)<<24)
@@ -2603,10 +2595,10 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
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
@@ -3256,22 +3248,26 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
 
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
2.47.1


