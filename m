Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5837E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniA-0006vH-S0; Sun, 29 Dec 2024 02:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhh-0006d1-F8
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:16 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhe-0002B9-7E
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:11 -0500
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so1492559766b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457229; x=1736062029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwMuN75c9NjsqQ/BaCCQ0FGhDQvIu13vYaZ8NeniCDw=;
 b=oogBPqWikHQCSmH4oPtNw41VVCmhCqCydgM5gDwdP8yWgBcne+8Rt1i8/lURIl6RZx
 qpaBEPrlKj86ZyYdF6E5uLogrDMzspnnbLVwYIf5DUApaeOpS4rRzxUnq+JvUO2jrvdt
 r3YPiMPWhmUeLC8po9TKdf1d3Ojhpkl0Pw36EPanhLgIFnyM796hHV4EkWJsWM6+wH2f
 B6/Gzr0oBCqi7NhYvUckRCW8wdB4lVg+8s/zgJeHwt6Z0f7iI8ClHG9zHy5zYlcBLz5v
 LUVrq3C3059qCw7F5faQshomp/DQWXbF+Wg0bK9x7UMMtknFXVfaPngRtU5ui/Bb9cUy
 AT3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjDTY79T0DHAdDQgRfm7Rvj1RHof1R+ILrDP4zsp6Zl6LbdR46PCbbFYa01WE/GTj69t0rEWbSKO5D@nongnu.org
X-Gm-Message-State: AOJu0Yz1jUomYRglaj6Aub7JkFD4kzVmSEWbprox9ZU/z7SeFG+jcExP
 CuW6+JsYJ1+F6gmdOlFL0/CnNpS9rgrIrkXpT3cmPQeZ73J0XWzO
X-Gm-Gg: ASbGnctB3IV4CKfe1PiGCa4+i9SEyBvqoTb4bHT6gsth8+uX8+PFbDgXx73pPIfiEw/
 a75rfN8UX+byuFShsvYnHpad8svuVyAMdi3QXsMGxikH9FgATWkpguYzYXmrdzmvZWXb8SYC8XY
 0qB/HAAbgywZ+yBLbYE9aAgG33AH0ny9ZG93lPeRv9nBzF2MI4SkcbxHT+FMPrTOVWtsrRx7YCI
 mi7cX/KgPC4SphCnQQshfVSayrU9U+DB1gbaZy1TU35tsovH+G0URp6ad6sAyNh2wplossNLfhE
 Emg=
X-Google-Smtp-Source: AGHT+IE/fRKGol2OR7aC/FD+P5mFMGTcUbXsBdfVWglPWKCo8Lk9ZXPAwrPwuFEWfNdUdv8XASO8Jg==
X-Received: by 2002:a17:907:9689:b0:aae:ee49:e000 with SMTP id
 a640c23a62f3a-aaeee49e11dmr1441065966b.18.1735457228453; 
 Sat, 28 Dec 2024 23:27:08 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:07 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 18/35] next-cube: rearrange NeXTState declarations to improve
 readability
Date: Sun, 29 Dec 2024 08:25:09 +0100
Message-ID: <20241229072526.166555-19-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.43; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f43.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Move the NeXTState, next_dma and TYPE_NEXT_MACHINE definition to the same area
at the top of next-cube.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241222130012.1013374-17-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 73c4d4ea9c..0cf4470ce8 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -38,30 +38,10 @@
 #define DPRINTF(fmt, ...) do { } while (0)
 #endif
 
-#define TYPE_NEXT_MACHINE MACHINE_TYPE_NAME("next-cube")
-OBJECT_DECLARE_SIMPLE_TYPE(NeXTState, NEXT_MACHINE)
-
 #define ENTRY       0x0100001e
 #define RAM_SIZE    0x4000000
 #define ROM_FILE    "Rev_2.5_v66.bin"
 
-typedef struct next_dma {
-    uint32_t csr;
-
-    uint32_t saved_next;
-    uint32_t saved_limit;
-    uint32_t saved_start;
-    uint32_t saved_stop;
-
-    uint32_t next;
-    uint32_t limit;
-    uint32_t start;
-    uint32_t stop;
-
-    uint32_t next_initbuf;
-    uint32_t size;
-} next_dma;
-
 typedef struct NextRtc {
     int8_t phase;
     uint8_t ram[32];
@@ -72,18 +52,6 @@ typedef struct NextRtc {
     uint8_t retval;
 } NextRtc;
 
-struct NeXTState {
-    MachineState parent;
-
-    MemoryRegion rom;
-    MemoryRegion rom2;
-    MemoryRegion dmamem;
-    MemoryRegion bmapm1;
-    MemoryRegion bmapm2;
-
-    next_dma dma[10];
-};
-
 #define TYPE_NEXT_SCSI "next-scsi"
 OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
 
@@ -132,6 +100,38 @@ struct NeXTPC {
     NextRtc rtc;
 };
 
+typedef struct next_dma {
+    uint32_t csr;
+
+    uint32_t saved_next;
+    uint32_t saved_limit;
+    uint32_t saved_start;
+    uint32_t saved_stop;
+
+    uint32_t next;
+    uint32_t limit;
+    uint32_t start;
+    uint32_t stop;
+
+    uint32_t next_initbuf;
+    uint32_t size;
+} next_dma;
+
+#define TYPE_NEXT_MACHINE MACHINE_TYPE_NAME("next-cube")
+OBJECT_DECLARE_SIMPLE_TYPE(NeXTState, NEXT_MACHINE)
+
+struct NeXTState {
+    MachineState parent;
+
+    MemoryRegion rom;
+    MemoryRegion rom2;
+    MemoryRegion dmamem;
+    MemoryRegion bmapm1;
+    MemoryRegion bmapm2;
+
+    next_dma dma[10];
+};
+
 /* Thanks to NeXT forums for this */
 /*
 static const uint8_t rtc_ram3[32] = {
-- 
2.47.1


