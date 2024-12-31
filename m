Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D22E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSila-0002LB-Ci; Tue, 31 Dec 2024 15:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilX-0002L1-8B
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:00 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilV-0000pw-Lw
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:22:59 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so5601584f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676575; x=1736281375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXQtPIRMHtqCLfqXYGaOwpsFtz/fcVXJzzd8RkMtGSE=;
 b=gsV8Hq7STBVOh+0BpR82gIL7Gtja3O5OIVFkFW93VNchvVPmLfmdmuvf/dtIYLExlV
 AzOC0HEE18Uu7L0X8eeSQwI2p9fJoZWy8SFeYEh9SexUGaXyWs0czJdVRmTbDVPhgWcZ
 jIRD8Gje7OaDIseAteRvk2nBtMtALPkPBhHMQQiumGCouGOm+adq0t3MHbUIoTPp/jUW
 0Rj9Ab1sm7UvqF1k6Sk2EY4e55X2/N8PS8XV+3+SD3bkjtf6gkAMxdTQOyj17JYvIA7y
 P0GNAEVaRsQhnyIkXeh1bJFaGY9uOWIn40l0oTYcqGM7PfG3EyiKVaLPXwwtZkMx77lq
 wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676575; x=1736281375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXQtPIRMHtqCLfqXYGaOwpsFtz/fcVXJzzd8RkMtGSE=;
 b=G31n5gxAl2CSJpXUrsr/9NvaQqsFNGrqqeUgzdvbElW6o9oafjEvhEiMEiGK2ULrYi
 oRGfRSDbqVQxWge8ak+GFI4lQZL1WrXAREgLYLjeRwRDj3gwE30gX3l7TFRqOg4Fkb3w
 XrjNG27yKInwsdHoNqMwONp16FjsPeOGgRgUtbHR4TjYZ0mWsYNN1kCz0u1QsMY9tTdg
 uvG2e1hEoWUeR6H8X1DimPEjEX2FomanTw6gvdnZFnzgPkom3pbEM/81SzGtd23g8oiZ
 ZFtWnKJJmkJxBvY5e+9w7DkDvU/t7p1JGXrB/qD8MCKBMpVuk1bwVFJ4BDxpT0Yb58B1
 k37A==
X-Gm-Message-State: AOJu0Yw7Iqpytb5f8/Rinq6MjkBl1Dqf9y78gnvilOafNPsesUTjl/G8
 8iEEr4LJh1ykYsZwZGgnn5gEJrNHFsn5CN14/88QeUyM8LUfb6tOFgw3fgloEl+TH1C9ogvxeRM
 W4B8=
X-Gm-Gg: ASbGncvice4+dILTjSzHZ5maqSat/pgfVQ8Yx8VS4g5i3+YhG2NYYtDLcFe4fFiZ+JO
 BgXqEabgd8LrQcZOcLERbf6SN9p1RHDlU/6cfnhQpqx6XKaUoz2otQRIXx2CF0xqCZcCyXDXZWu
 8BI1LLDJ7flVYJMwOIjgLAkPf9sk6FXrvQ3TB5heRtdjRV5uumBR1Xp+LKLlqaXeSCFBJE276zl
 yYYm9VPHtSg7rDvbdhoqAyqrUjA3abWX0n7p98Qhp/qQEW07LWdm/s8GnH5u5m9J/RwyReQqeaB
 bLisocUj4xdMJHm9tq0sQyi50HQ10OM=
X-Google-Smtp-Source: AGHT+IE7Hw9AOljtJZ1KiGBa8gQVgvby+n22i7k5ppQqvyA4LBc18cvj/+qurDXMKfHhD/scbUDeDA==
X-Received: by 2002:a05:6000:188e:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-38a223fd729mr35020802f8f.46.1735676574781; 
 Tue, 31 Dec 2024 12:22:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm431645315e9.0.2024.12.31.12.22.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:22:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/29] hw/usb/uhci: Introduce and use register defines
Date: Tue, 31 Dec 2024 21:22:04 +0100
Message-ID: <20241231202228.28819-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Guenter Roeck <linux@roeck-us.net>

Introduce defines for UHCI registers to simplify adding register access
in subsequent patches of the series.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20240906122542.3808997-3-linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/usb/uhci-regs.h | 11 +++++++++++
 hw/usb/hcd-uhci.c          | 32 ++++++++++++++++----------------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/include/hw/usb/uhci-regs.h b/include/hw/usb/uhci-regs.h
index fd45d29db0f..5b81714e5c2 100644
--- a/include/hw/usb/uhci-regs.h
+++ b/include/hw/usb/uhci-regs.h
@@ -1,6 +1,17 @@
 #ifndef HW_USB_UHCI_REGS_H
 #define HW_USB_UHCI_REGS_H
 
+#define UHCI_USBCMD       0
+#define UHCI_USBSTS       2
+#define UHCI_USBINTR      4
+#define UHCI_USBFRNUM     6
+#define UHCI_USBFLBASEADD 8
+#define UHCI_USBSOF       0x0c
+#define UHCI_USBPORTSC1   0x10
+#define UHCI_USBPORTSC2   0x12
+#define UHCI_USBPORTSC3   0x14
+#define UHCI_USBPORTSC4   0x16
+
 #define UHCI_CMD_FGR      (1 << 4)
 #define UHCI_CMD_EGSM     (1 << 3)
 #define UHCI_CMD_GRESET   (1 << 2)
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 7c0cc694554..8528d493d63 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -389,7 +389,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
     trace_usb_uhci_mmio_writew(addr, val);
 
     switch (addr) {
-    case 0x00:
+    case UHCI_USBCMD:
         if ((val & UHCI_CMD_RS) && !(s->cmd & UHCI_CMD_RS)) {
             /* start frame processing */
             trace_usb_uhci_schedule_start();
@@ -424,7 +424,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             }
         }
         break;
-    case 0x02:
+    case UHCI_USBSTS:
         s->status &= ~val;
         /*
          * XXX: the chip spec is not coherent, so we add a hidden
@@ -435,27 +435,27 @@ static void uhci_port_write(void *opaque, hwaddr addr,
         }
         uhci_update_irq(s);
         break;
-    case 0x04:
+    case UHCI_USBINTR:
         s->intr = val;
         uhci_update_irq(s);
         break;
-    case 0x06:
+    case UHCI_USBFRNUM:
         if (s->status & UHCI_STS_HCHALTED) {
             s->frnum = val & 0x7ff;
         }
         break;
-    case 0x08:
+    case UHCI_USBFLBASEADD:
         s->fl_base_addr &= 0xffff0000;
         s->fl_base_addr |= val & ~0xfff;
         break;
-    case 0x0a:
+    case UHCI_USBFLBASEADD + 2:
         s->fl_base_addr &= 0x0000ffff;
         s->fl_base_addr |= (val << 16);
         break;
-    case 0x0c:
+    case UHCI_USBSOF:
         s->sof_timing = val & 0xff;
         break;
-    case 0x10 ... 0x1f:
+    case UHCI_USBPORTSC1 ... UHCI_USBPORTSC4:
         {
             UHCIPort *port;
             USBDevice *dev;
@@ -493,28 +493,28 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
     uint32_t val;
 
     switch (addr) {
-    case 0x00:
+    case UHCI_USBCMD:
         val = s->cmd;
         break;
-    case 0x02:
+    case UHCI_USBSTS:
         val = s->status;
         break;
-    case 0x04:
+    case UHCI_USBINTR:
         val = s->intr;
         break;
-    case 0x06:
+    case UHCI_USBFRNUM:
         val = s->frnum;
         break;
-    case 0x08:
+    case UHCI_USBFLBASEADD:
         val = s->fl_base_addr & 0xffff;
         break;
-    case 0x0a:
+    case UHCI_USBFLBASEADD + 2:
         val = (s->fl_base_addr >> 16) & 0xffff;
         break;
-    case 0x0c:
+    case UHCI_USBSOF:
         val = s->sof_timing;
         break;
-    case 0x10 ... 0x1f:
+    case UHCI_USBPORTSC1 ... UHCI_USBPORTSC4:
         {
             UHCIPort *port;
             int n;
-- 
2.47.1


