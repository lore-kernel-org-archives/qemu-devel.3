Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C83BE77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhd-0006ak-BI; Sun, 29 Dec 2024 02:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnha-0006aQ-Rn
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:06 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhZ-0002Al-EE
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:06 -0500
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so11449643a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457224; x=1736062024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jN7K7JNEyg0RRrGevmD5fTXXIIKMk8NZp3aW6mH533I=;
 b=eMKIFkDApHOahmF3lRBnDY3Ex1vkS2wnebfRGiFRioh888+NEB0yzfEVQkb+NT7sJK
 u+ZuLb0OjfdhZGMiUS6cogv6i5j0y/9f1vIlhOwXoL0C7L8OgjvBfHl0KBwKdXFiOfAo
 HB/I05MrOLbMiJpbGO5ml27h8hq1/mEV2FrdFWuiPPVujuWft4oV7OtIcl/zp5Qv7EsT
 R1bhCJlYr2vs7D+jlGXLQgyvOaFimD6uhtGqzan+9ufQLwh4w44ISX7g3pacgI3sspak
 Xi/BaUjoyxVa34hj2MBkIvbGZpPEFdEbrVavkkCHJLgP/D2SrSL4fLXE6gsdccfx0OHd
 BLYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUcXX0xmTdE1R2R4qVZ+MEaisYiFI3lOfsnjS2ajusozmG0gCaA4h7o7R5p8fExytehB6voMv/9lhP@nongnu.org
X-Gm-Message-State: AOJu0YyyCfP34b5sJoTpfY2DZJppfRJyBPiW9I7ULaksNIe1LNOVSsIP
 kwu2y1pt2meKru821xx2X35n5kR5pWh1Hms8KU59XRzsGfI/TC4AyPMTKA==
X-Gm-Gg: ASbGncuvlKUoGlGbn6q/x3sKzwmOUo0Wx56a+oMnkHWdDXltx8ON1A1n3hSIijpBrsv
 e2DRL1ohl0KOv1o2qnZEc+OM7JWv2OhMbvlsmNhqRq9yTaHBgc3JvODAr52Hkp+et7Bj9unhGMB
 kPuRQGqd2SKiJIgBGjkGrgnd1dOV6X06csQubPv0qUrahnj2ntGxipbRV2SATx/ASE/jN1xfk8K
 6HaVg3soEF9VHFLQtn3FVYVPNGcir2riso8ZvG9GtKgrSqcGdwvWdVkwEnkjRxeEPaGKSKk/tJV
 kwc=
X-Google-Smtp-Source: AGHT+IEgVZFU+wJ5r1umzxmfRlBXncVdS2bZXXLTlAS0nls6KVQ45ikJzGj+0NkQUWTu9+YGIw+VSA==
X-Received: by 2002:a05:6402:540b:b0:5d6:48ef:c19f with SMTP id
 4fb4d7f45d1cf-5d81de1c28fmr75252062a12.29.1735457223852; 
 Sat, 28 Dec 2024 23:27:03 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:02 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 16/35] next-cube: add empty slots for unknown accesses to
 next.scr memory region
Date: Sun, 29 Dec 2024 08:25:07 +0100
Message-ID: <20241229072526.166555-17-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.45; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f45.google.com
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

The next.scr memory is now effectively unused, however there are 3 separate region
accesses still logged that occur when booting a NeXTStep disk image. Use the
empty_slot device to capture and ignore memory accesses to these 3 memory regions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-15-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/Kconfig     | 1 +
 hw/m68k/next-cube.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 0092cda4e9..aff769b30f 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -18,6 +18,7 @@ config NEXTCUBE
     depends on M68K
     select FRAMEBUFFER
     select ESCC
+    select EMPTY_SLOT
 
 config Q800
     bool
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 97a6f6c472..6ca9170108 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -22,6 +22,7 @@
 #include "qom/object.h"
 #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
 #include "hw/block/fdc.h"
+#include "hw/misc/empty_slot.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -1238,6 +1239,13 @@ static void next_cube_init(MachineState *machine)
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
+    /* unknown: Brightness control register? */
+    empty_slot_init("next.unknown.0", 0x02110000, 0x10);
+    /* unknown: Magneto-Optical drive controller? */
+    empty_slot_init("next.unknown.1", 0x02112000, 0x10);
+    /* unknown: Serial clock configuration register? */
+    empty_slot_init("next.unknown.2", 0x02118004, 0x10);
+
     /* BMAP memory */
     memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
                                            64, RAM_SHARED, &error_fatal);
-- 
2.47.1


