Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059C5E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnip-0001TU-8n; Sun, 29 Dec 2024 02:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni3-0006o6-GL
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:37 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni1-0002Dg-97
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:34 -0500
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-aa67333f7d2so1218086566b.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457251; x=1736062051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yT/I4StE3NBO0rAz2NgqzeKWrPklbWt2SCG7OJpykKQ=;
 b=WNP/CPONxY/OA5D/3mH2nfZ7XK7u874vwgSNn2sEA1Ftr57eyNqYmlWXslX3HpKKD1
 C8WiOcDf/gGu3meQJ4ETlnYvNdhh/+RUcZIQLV0+CWYEKEAdYH2/y8CRaux5OORg/VoJ
 qmCJhuLhkd+LkSAZKXEQZfIMBJXJGYX/xp3Zt1QymBtvnMGvrz5d5GD3J12HP88i1oVW
 90b6867spV+raAsb+jAbn27usMxd0FtZIJk4ZXJdU0/uLSbzX2VfFw9ebGxchDVu5Zmo
 DxvK+sa5K6hj8ypweTzSKy9LhDbEip8E0hMkvl4NalDsGbKU6EcbR6hq+fN+XFyhn7x6
 MbZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYoUmYml9TKDdjKVgBloXqZp5B5FK46Vi0b0qtiumQ3/+AoRF/B+pOkQsWjtrbVTMY5LZjqw3FktRJ@nongnu.org
X-Gm-Message-State: AOJu0YyX5oP5dcLQ0uXZeP+rj2cDYkl3oCPhq3aIcjseMWyR5VfkrraY
 1YCoYRiggWf42j40boXwftIianYLTSoma0/f6pvKmyGf7EVNoAAIpgNtAA==
X-Gm-Gg: ASbGnct0uPElxYeEDxEIs9PzKkDYIBp9ujz/3ZOqyyiD6vzX1/Qdv+jYxNoBQFoUSz6
 zCaBJWtdbXlx9IFA/nfmRW9+4qbQxZ6BaRf1zTn5rHdnXmMzaa0iztz1QFMybL/KZRyfa/18LHq
 6tCiBA1euMjAB8j79H8lGU+7GbtcRgkKvBCZolQpT28SrG+R4qbf73hbB/O78RNgNpLyjTn1UaY
 s0cJfDLZSMtyiNOTB+pil0WZ+wYKO4SNRpqGISYZNn6a+N64Xfo4wv5d9814N836yLNhtYEbEPk
 WyY=
X-Google-Smtp-Source: AGHT+IG3/QcRP8cvxsWg0sXUI3MsXFwrehsL/pQpxugWE7/rag4AShFWNomYTCHp/KTKNZhIG8EE+Q==
X-Received: by 2002:a17:906:6a15:b0:aab:d8e4:2062 with SMTP id
 a640c23a62f3a-aac3366b549mr2497360566b.56.1735457250589; 
 Sat, 28 Dec 2024 23:27:30 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:30 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 28/35] next-cube: move reset of next-rtc fields from next-pc to
 next-rtc
Date: Sun, 29 Dec 2024 08:25:19 +0100
Message-ID: <20241229072526.166555-29-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.41; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f41.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-27-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 883891ce6b..bd7c76c35e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1018,6 +1018,16 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_rtc_reset_hold(Object *obj, ResetType type)
+{
+    NeXTRTC *rtc = NEXT_RTC(obj);
+
+    rtc->status = 0x90;
+
+    /* Load RTC RAM - TODO: provide possibility to load contents from file */
+    memcpy(rtc->ram, rtc_ram2, 32);
+}
+
 static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 3,
@@ -1037,9 +1047,11 @@ static const VMStateDescription next_rtc_vmstate = {
 static void next_rtc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "NeXT RTC";
     dc->vmsd = &next_rtc_vmstate;
+    rc->phases.hold = next_rtc_reset_hold;
 }
 
 static const TypeInfo next_rtc_info = {
@@ -1072,11 +1084,6 @@ static void next_pc_reset_hold(Object *obj, ResetType type)
     s->scr1 = 0x00011102;
     s->scr2 = 0x00ff0c80;
     s->old_scr2 = s->scr2;
-
-    s->rtc.status = 0x90;
-
-    /* Load RTC RAM - TODO: provide possibility to load contents from file */
-    memcpy(s->rtc.ram, rtc_ram2, 32);
 }
 
 static void next_pc_realize(DeviceState *dev, Error **errp)
-- 
2.47.1


