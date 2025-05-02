Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A58C3ABA5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7d-0004AW-Aa; Thu, 01 May 2025 23:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7K-00048P-3s
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:14 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7G-0001Em-H2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:12 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af28bc68846so1535986a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156668; x=1746761468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UUbXDpliZ02/3N9O1HJ431XFTCG4rNlhV3yHnCyQ4g=;
 b=gX6kRNMrvsJQCvil+CB2CSqG/khnclgcAJfkcJOzHeF9pM2lkOdnP7rwkI9v97DI/g
 MBdTgTI++hi44A7KPsCDNhVCDHjGfgdQcynpsCTX2l4OQqsCbONrTqfLI+i7q262e82u
 XOIXgaOhATMlGjFQ7R4hxIULETOAx8+Qk7s5waxJkJ8zAL0ziNDJA2KayN20I3AmUjPY
 Ns1OYcvoR0yKZJ/bEERncgIwDX3blOlOy5vxWepLsT9Uc+16iR1sSdKTF/8YDVRm0bvV
 q4QoHA7KfzicV7+p80K1iXShw0qq+gdzcXQZ4Bk2dtnAfS35pbGOkK1YkkNrIK3LyocG
 JeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156668; x=1746761468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UUbXDpliZ02/3N9O1HJ431XFTCG4rNlhV3yHnCyQ4g=;
 b=L3+qwZGkah6SpJg1ttyg3V7PD8x6jAfpGw5juas/DXHaD1Rtwp7rhKdx+W/2wqrgLH
 l2wI9MUaYXWNwmmnLuQuM+m0FSS4BC3E0ebHqfIOMSnFFZOYcVJy+9+tMkxc0ccwqOjb
 r8X0WjrA9zPk+CbUZZUBcWqnoD7Zrgu+cxRYVhz8LckLcp+fHQLTfnx3/xg/HfENzQaX
 qrZUN4GbmgmvLe1mYC61Z/j7N6+ufSDii5lhRUs4XiP5uMPATR0rXQxVXSY/kV9xbbCW
 ia4w1RzDUyxqO3IQcAm/0BU+TrycE8PGHkHudhVNUbg5vVPR38+I4wIzADc2GynLahh5
 6bmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMnn9zizn3BEyjkA/teNHJ8ZXeEGhgq5Mel49pbrN0q3+pFg1qnnIGqK3V04VDihXJRdridcVMVfWz@nongnu.org
X-Gm-Message-State: AOJu0YxrWUn5eYu3mjlv2U2p52J2QkqoXaUUcyoweWsCu9RxD5f2AzI6
 l1m7gsVATYZQdq/HJ5vewchQVZ0Y6B6wW+l45Dc/jFuuC+Cz7vUW
X-Gm-Gg: ASbGnctnpcYp2a+MzOyOKKlvo6142Wud1fpUM+Od8HXcEk3e2HE7klnOnDhETwpFXOP
 7kG8xy4kpIZdZeme4bq+vIWtU5TfzmiOlZZtxWLSsb2FLA0moTDOc5fv/jNLZzu7DNIWMQhsV1L
 Hr1b4FCTcKC+4i0n8suXcs7LSOvgbdm/EHTQbtK2wyj9zf3IqdNURAO7QqWQXplrTVY566ljkf+
 REyfQceCSNRxIgZOELw6jNoBsFP82zJvt/YxVajqPgG8vs+aWh1K3+A44vRVc5BHFJJDbY+FOgj
 z05AsfcghotuPe23m0eN5Et5CAyIITdAlg6+qLEBX3yE
X-Google-Smtp-Source: AGHT+IHDYq3D43eOemzMYdrUBEugVRG7wda6TnW1nbgMUrLTU8rwJPmfotAxALoi75Sz/b7gQYGxpA==
X-Received: by 2002:a05:6a20:2d26:b0:20c:92ea:1c0b with SMTP id
 adf61e73a8af0-20ce03e9377mr2173462637.35.1746156668341; 
 Thu, 01 May 2025 20:31:08 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 02/22] hw/usb/xhci: Rename and move HCD register region
 constants to header
Date: Fri,  2 May 2025 13:30:26 +1000
Message-ID: <20250502033047.102465-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
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
index abd2002d2c0..c12b72cb9d8 100644
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
 
@@ -2584,7 +2576,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
 
     switch (reg) {
     case XHCI_HCCAP_REG_CAPLENGTH: /* Covers HCIVERSION and CAPLENGTH */
-        ret = 0x01000000 | LEN_CAP;
+        ret = 0x01000000 | XHCI_REGS_LENGTH_CAP;
         break;
     case XHCI_HCCAP_REG_HCSPARAMS1:
         ret = ((xhci->numports_2+xhci->numports_3)<<24)
@@ -2604,10 +2596,10 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
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
@@ -3257,22 +3249,26 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
 
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


