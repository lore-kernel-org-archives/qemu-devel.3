Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8B5E77192
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniF-0007X9-US; Sun, 29 Dec 2024 02:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhn-0006jM-4N
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:22 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhj-0002Bu-4v
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:17 -0500
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso1340222966b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457233; x=1736062033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+X3ya5rXN39/mO09hGL80z1v7BeQ/OkCOt3Wnid8T5s=;
 b=HtTZeDSyThy2r9LE3CObeXTxb/ECNrRWURMhdoRTA6jJs8lM1KyLBh8K1fzxccSc9N
 loojxxOU/ipVRjhx8x5f9Vy3C1ckB5ftqUt/rDdlaJA96Vy12/QwuocAL1fr5cDsdyQf
 kADpHVdxFEUTbQmYjnWCzTHQcr0lEaf0TaM2TeR2SfUUi40HSaBmN1r/VJ07tGnvdQnP
 ACPTk1itwyrgXv64Q44nk9iNSIwUHowcis9mTT/zPBCmuxibRZSj0/+TtWk7m1ra9E30
 TqCyIoyLiIr7V4jllgBNSKVrqbnZQbfcU7vyIVfjFwrecsSAnQR/ZqPiTbMUQXMDX2u6
 iL8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzKGsYIHtf6Z7L1ulCbKRf1yMb7hUdbqUTxjd4Cs0fk2KfHnodvwJZSSVeaLxEIM8kSDZZKB+gfzDb@nongnu.org
X-Gm-Message-State: AOJu0Yx8tp9ZwRgbHZqoj1txqF1LoGz89iJgghrGFlhKW0yZOPfFSUYa
 aigy72Vp5HF2+2z8AYW5D/1F13cMG0iF/PePwsPtVxlqoP0A82MiNTCSQg==
X-Gm-Gg: ASbGncuQo1tM0b/o1r9od9lGmXkvN+1jKi66V+pPB4q22uMN1pm+OX0HInnwEBaXtTL
 Xqg0dPeiSK53XJIk69CnlxL1hDXedYvqtmriSs3jP8KC29mH/RNYWhVg6LkE/FclCwH+OE/MfZ0
 KQ7peomuJMsb8LcL3smph4Sc7MObAdjH4d9TqqrqM1ubXbeUrn86xo5s2Solgp/PGxHt0PTKxs+
 6qXM/SwnQFSxkr0y2ki1KB+svkHFY1cb0IAD9ZVbOUShIBpJNMdiXBNaU8R/dDGIl6LXyBf5Pg6
 JDs=
X-Google-Smtp-Source: AGHT+IEf3RvAXH84sVIcbuXTAyGkk3DbkuGZNU3gylLckm2xgb204IqdYv7VUd8ZBny1s5bedv2qug==
X-Received: by 2002:a17:907:728c:b0:aa6:6c08:dc79 with SMTP id
 a640c23a62f3a-aac2cf50e65mr2583230766b.35.1735457233314; 
 Sat, 28 Dec 2024 23:27:13 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:12 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 20/35] next-cube: rename typedef struct NextRtc to NeXTRTC
Date: Sun, 29 Dec 2024 08:25:11 +0100
Message-ID: <20241229072526.166555-21-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
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

This brings the capitalisation in line with the other NeXTCube definitions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-19-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 091e05465e..19b9100094 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -42,7 +42,7 @@
 #define RAM_SIZE    0x4000000
 #define ROM_FILE    "Rev_2.5_v66.bin"
 
-typedef struct NextRtc {
+typedef struct NeXTRTC {
     int8_t phase;
     uint8_t ram[32];
     uint8_t command;
@@ -50,7 +50,7 @@ typedef struct NextRtc {
     uint8_t status;
     uint8_t control;
     uint8_t retval;
-} NextRtc;
+} NeXTRTC;
 
 #define TYPE_NEXT_SCSI "next-scsi"
 OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
@@ -97,7 +97,7 @@ struct NeXTPC {
 
     ESCCState escc;
 
-    NextRtc rtc;
+    NeXTRTC rtc;
 };
 
 typedef struct next_dma {
@@ -167,7 +167,7 @@ static void next_scr2_led_update(NeXTPC *s)
 static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
-    NextRtc *rtc = &s->rtc;
+    NeXTRTC *rtc = &s->rtc;
 
     old_scr2 = extract32(s->old_scr2, 8, 8);
     scr2_2 = extract32(s->scr2, 8, 8);
@@ -1110,13 +1110,13 @@ static const VMStateDescription next_rtc_vmstate = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT8(phase, NextRtc),
-        VMSTATE_UINT8_ARRAY(ram, NextRtc, 32),
-        VMSTATE_UINT8(command, NextRtc),
-        VMSTATE_UINT8(value, NextRtc),
-        VMSTATE_UINT8(status, NextRtc),
-        VMSTATE_UINT8(control, NextRtc),
-        VMSTATE_UINT8(retval, NextRtc),
+        VMSTATE_INT8(phase, NeXTRTC),
+        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
+        VMSTATE_UINT8(command, NeXTRTC),
+        VMSTATE_UINT8(value, NeXTRTC),
+        VMSTATE_UINT8(status, NeXTRTC),
+        VMSTATE_UINT8(control, NeXTRTC),
+        VMSTATE_UINT8(retval, NeXTRTC),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1132,7 +1132,7 @@ static const VMStateDescription next_pc_vmstate = {
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
         VMSTATE_UINT32(led, NeXTPC),
-        VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
+        VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NeXTRTC),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.47.1


