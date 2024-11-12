Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8EAD42BAF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuIc-0003UN-AU; Tue, 12 Nov 2024 12:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHW-0003Bo-8h; Tue, 12 Nov 2024 12:02:22 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHU-0001SK-IR; Tue, 12 Nov 2024 12:02:21 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so4038401a12.0; 
 Tue, 12 Nov 2024 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430938; x=1732035738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnAhVVFjjEa9AE7qgj063mddus/nht38lXKcvLgTu8c=;
 b=k9R8IPfLQdy5F0tA2ZuMTVRUuW7P0+ouZ/RqL/JyDXzhF3w1gfvD7C+7dTCbEaG0mu
 GDBfbNPpPD3gQYQiWiPdeND1oLE6/MDV/k7YV1sDNyBJBIkwnokfGf04R1JEUUXjOopM
 iBBnoA0F9cjoZ4b8asKMAwMjyEMhuluZN/RIM/pPcTOIgxvmCpbcemGROyS+8IEPNCEc
 rRAl91MR9ANwvv6Xg8FFy2fkslYyUj76Ntyd08cDPSu3DkBNjao2cQILaNlb140pgeh1
 HMXL3tibq1XLyZyaqpgfv5w38HJkQl2i7wLi23MaoWuylXTbJt8CLUftzJX0BF7SSJ8y
 OaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430938; x=1732035738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XnAhVVFjjEa9AE7qgj063mddus/nht38lXKcvLgTu8c=;
 b=RkKX6+3RoIfId0leg+DNFHb6NrE5gIYtCcedwJmRo2Ye9Je+37vUCYF5fZKtE0uEBc
 mDk+rNRv11WPkrFvB9Z5o2vhVEQnKVbC6Tv7H3KDrjeyijC4BtG+NzgDkl4hFmOzm6u0
 0wbY31mVwOi9barRMhjG4+yEEmAf3lQdtEO19gVa3l+e7FvwQlLusxBPE0jH3QIxUuoB
 fuHP/BgseBkUCUExnDaV8ESggf4HvDXJPLputCX64sXYN3v6tP3lnnK32IYX4PjARFoT
 cIf8mVf6BTXESJqqrId8jlcYesgEbrsAytepw9uEhAtCLSsyO8D+fEaXQYZ549EKwKFj
 /HiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF/4Hnkt7L9Y41PeSHs6yRIbsA0AvZhcFNHoovPHe4DS4WDfBAsWmESDREFvzX5fvXaGd1ff8ZsA==@nongnu.org
X-Gm-Message-State: AOJu0Yw1n5SiM9uYMbOcUVBYq1Bt3Y0whFejxpyTcVeqHTqpe1F4SAbg
 D3UJkstWJGptxWHQJAnslJF/MnTMSXkSAcRZ8YxZN/R1AkHiMpvhBULBWQ==
X-Google-Smtp-Source: AGHT+IGgYYQI8KlJMqEzFAH3CsDlipTWZfKiEE/YZFOQ3zPM1bxzLqZ6//cIjp1USr7onKoSw1108w==
X-Received: by 2002:a17:90b:3a90:b0:2e2:cd80:4d44 with SMTP id
 98e67ed59e1d1-2e9b172b03amr22530782a91.28.1731430938259; 
 Tue, 12 Nov 2024 09:02:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9a5f5e57fsm10814294a91.14.2024.11.12.09.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 09:02:17 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RESEND PATCH 02/10] usb/uhci: Introduce and use register defines
Date: Tue, 12 Nov 2024 09:01:44 -0800
Message-ID: <20241112170152.217664-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112170152.217664-1-linux@roeck-us.net>
References: <20241112170152.217664-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce defines for UHCI registers to simplify adding register access
in subsequent patches of the series.

No functional change.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since RFC:
- Rebased to v9.1.0-1673-g134b443512
- Added Reviewed-by: tag

 hw/usb/hcd-uhci.c          | 32 ++++++++++++++++----------------
 include/hw/usb/uhci-regs.h | 11 +++++++++++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 50d488d6fb..bdab9ac37e 100644
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
diff --git a/include/hw/usb/uhci-regs.h b/include/hw/usb/uhci-regs.h
index fd45d29db0..5b81714e5c 100644
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
-- 
2.45.2


