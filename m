Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE58C04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjFX-0001pO-Tu; Tue, 16 Apr 2024 09:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFV-0001ol-BG
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFS-0001hk-0z
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-346359c8785so3413448f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275600; x=1713880400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r03IbH4Q5jukHMDYRNDrIPnxYvDkdnR4utG+Rvdo7L0=;
 b=yRF1JSc9vOfeMJXY1dkhAcfTue6ucH2vX1XanashF2GYd98VwW5NZ5vQ+tjcRPmfgr
 kV9qq9CuKPIJKecDs0CvQLckdBu5WVQs6kzeMYgp+H02DbDZbUNJ/Q4yaybLs+WRqUfH
 GQ2B6iWApyQkXwVEl2FGJV3WlWY80W1qPcsy57QCVaeIjfyWq5FOCxAbzE5AcoOkVEqq
 wNm1pXanch2iOHScqF/uda4mfr7IKbTk/3ZGCW3KubmWxHgvKWTdzssYZii1q4npcu1T
 K7JCzz4/6UiUbUhuYjUZRnUXPYs4VH/NZHv1TOKtC2f3ZicylHHAal43yfUfNzmVqejg
 kAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275600; x=1713880400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r03IbH4Q5jukHMDYRNDrIPnxYvDkdnR4utG+Rvdo7L0=;
 b=Os5OSNqygklt64WripaVDVtt5Ih8/QgIVZGQmuHPE+IU417so3pbfykQB0W3Cbzsgj
 kxjR++C4ibGYn7PqpaeNKLMSWI/ViXd/+9q+Cyvj4C/t7HCmlZHxplhARSRxvHpYUYik
 x7wgispPmyK4nxqxKMwTm7DQ4V3MoPMXKG4HKsH7vmDy79Be18MVqMh2p4I00X8zBxaq
 QhoxuTZo5eKTRmuEbYaT7R04mBAE649vVbzKUghBhkCby2s5sH5HWvWhpWbvpJGUsqkl
 DevreJ7/NV2YuxS34qzTDleHPgqq7c2Us6YFQm5aPZufhiCtkw3aZdtOm358dVdyO5rR
 le5w==
X-Gm-Message-State: AOJu0YzRpyu3PcVcnEBMvfp8NehYP1GX00z4RA/HCeQJcinIiqLg8WYY
 0k3PV6uUM6pyGjD3ZmfNADzB5Yh9HKXu4zJUAf4u+LyZH1C9caiAhlByRsYDFpXdlqymICVqdbK
 A
X-Google-Smtp-Source: AGHT+IGJ2uGSR6KqQln7hRaQZa1PHMjIwlEBSzUIgzuLKKApN96nfJTrfhuAZdzCvzv0Ihnv1ZAsZA==
X-Received: by 2002:a5d:69c5:0:b0:349:8fa4:1839 with SMTP id
 s5-20020a5d69c5000000b003498fa41839mr924704wrw.1.1713275600053; 
 Tue, 16 Apr 2024 06:53:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 df10-20020a5d5b8a000000b003437799a373sm14861606wrb.83.2024.04.16.06.53.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:53:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 04/22] hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
Date: Tue, 16 Apr 2024 15:52:33 +0200
Message-ID: <20240416135252.8384-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

XHCI_FLAG_SS_FIRST was only used by the pc-i440fx-2.0 machine,
which got removed. Remove it and simplify various functions in
hcd-xhci.c.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/usb/hcd-xhci.h     |  3 +--
 hw/usb/hcd-xhci-nec.c |  2 --
 hw/usb/hcd-xhci-pci.c |  1 -
 hw/usb/hcd-xhci.c     | 42 ++++++++----------------------------------
 4 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 1efa4858fb..fe16d7ad05 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -36,8 +36,7 @@ typedef struct XHCIStreamContext XHCIStreamContext;
 typedef struct XHCIEPContext XHCIEPContext;
 
 enum xhci_flags {
-    XHCI_FLAG_SS_FIRST = 1,
-    XHCI_FLAG_ENABLE_STREAMS,
+    XHCI_FLAG_ENABLE_STREAMS = 1,
 };
 
 typedef enum TRBType {
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 5d5b069cf9..0c063b3697 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -41,8 +41,6 @@ struct XHCINecState {
 static Property nec_xhci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_BIT("superspeed-ports-first", XHCINecState, flags,
-                    XHCI_FLAG_SS_FIRST, true),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index cbad96f393..264d7ebb77 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -242,7 +242,6 @@ static void qemu_xhci_instance_init(Object *obj)
     s->msix     = ON_OFF_AUTO_AUTO;
     xhci->numintrs = XHCI_MAXINTRS;
     xhci->numslots = XHCI_MAXSLOTS;
-    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
 }
 
 static const TypeInfo qemu_xhci_info = {
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ad40232eb6..b6411f0bda 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -541,18 +541,10 @@ static XHCIPort *xhci_lookup_port(XHCIState *xhci, struct USBPort *uport)
     case USB_SPEED_LOW:
     case USB_SPEED_FULL:
     case USB_SPEED_HIGH:
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            index = uport->index + xhci->numports_3;
-        } else {
-            index = uport->index;
-        }
+        index = uport->index + xhci->numports_3;
         break;
     case USB_SPEED_SUPER:
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            index = uport->index;
-        } else {
-            index = uport->index + xhci->numports_2;
-        }
+        index = uport->index;
         break;
     default:
         return NULL;
@@ -2779,11 +2771,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
         ret = 0x20425355; /* "USB " */
         break;
     case 0x28: /* Supported Protocol:08 */
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            ret = (xhci->numports_2<<8) | (xhci->numports_3+1);
-        } else {
-            ret = (xhci->numports_2<<8) | 1;
-        }
+        ret = (xhci->numports_2 << 8) | (xhci->numports_3 + 1);
         break;
     case 0x2c: /* Supported Protocol:0c */
         ret = 0x00000000; /* reserved */
@@ -2795,11 +2783,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
         ret = 0x20425355; /* "USB " */
         break;
     case 0x38: /* Supported Protocol:08 */
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            ret = (xhci->numports_3<<8) | 1;
-        } else {
-            ret = (xhci->numports_3<<8) | (xhci->numports_2+1);
-        }
+        ret = (xhci->numports_3 << 8) | 1;
         break;
     case 0x3c: /* Supported Protocol:0c */
         ret = 0x00000000; /* reserved */
@@ -3349,13 +3333,8 @@ static void usb_xhci_init(XHCIState *xhci)
     for (i = 0; i < usbports; i++) {
         speedmask = 0;
         if (i < xhci->numports_2) {
-            if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-                port = &xhci->ports[i + xhci->numports_3];
-                port->portnr = i + 1 + xhci->numports_3;
-            } else {
-                port = &xhci->ports[i];
-                port->portnr = i + 1;
-            }
+            port = &xhci->ports[i + xhci->numports_3];
+            port->portnr = i + 1 + xhci->numports_3;
             port->uport = &xhci->uports[i];
             port->speedmask =
                 USB_SPEED_MASK_LOW  |
@@ -3366,13 +3345,8 @@ static void usb_xhci_init(XHCIState *xhci)
             speedmask |= port->speedmask;
         }
         if (i < xhci->numports_3) {
-            if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-                port = &xhci->ports[i];
-                port->portnr = i + 1;
-            } else {
-                port = &xhci->ports[i + xhci->numports_2];
-                port->portnr = i + 1 + xhci->numports_2;
-            }
+            port = &xhci->ports[i];
+            port->portnr = i + 1;
             port->uport = &xhci->uports[i];
             port->speedmask = USB_SPEED_MASK_SUPER;
             assert(i < XHCI_MAXPORTS);
-- 
2.41.0


