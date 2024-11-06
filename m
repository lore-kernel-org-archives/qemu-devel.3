Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E01D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8erF-0006LV-BS; Wed, 06 Nov 2024 07:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8er7-0006Ku-Ri
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:09:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8er5-0007Zn-7Z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=soY40EGEZeKmE/qYmAwsNkL7oBcn3zBLS9hlO9tPmhE=; b=QlHaRr4dxTYXwAcHPhVDZCsAio
 685qAqSowZJVvPZ8lj1DGiBAEbuFamoUwmzuaVGtq3qQcMaHzfQpmgCmIrB4VIQLoXmw7ulDjTKG4
 Yeo3aa2xMcM/LPXcp76x74EmS3LEyAX2sJCEXNyTRb4UdUiieLFj+WKrCr9etaVhVprzx0z0eBM+P
 BkJlCbaOzHjfMNhiOJINvAeRHLG+QYVy+k4pDhMfycMMcITjPHJACVmQe2V2KHUw4YDWj3je/2ids
 MiuB4yAmpIkyjYarMeZpItJxuQwLG+ESOfne/PAu/ck+H7U3TiChDMDvRucMxO9E1rxSdTJhvu1v6
 OFVZtuJI6kUxD8UxuVqxswMlsIPK1w55kqOjZ1A8X9H4H9KLaWkPgbkCrpSS3dNBKXgyNp4tG4cyx
 RSxXJ9j/49+zClpGdhwhOLMWK3Z8x0Z39DCbRRJlzYH74FCHXU1biUKtbnZ6sTxyUmBZyvqTqfPei
 I23plc0qLtX2X1Rqz+06IyPaYOfjofY8u47bgb7CJ20o6/ASIF6CCCYHhYMPQ+Zhk6iaE8x4uuBvi
 CxHBWbBzsZy5RegsjKL5aG7oa4P4U6bRAV51/xL/gxW24pzTWZgQw/TknHjKW9tartyBL2O/oagOT
 4v/M6d2pxIgHPTuLgIh0hpIOFgECec436nNfu+Z+0=;
Received: from [2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8eqf-0008sS-IQ; Wed, 06 Nov 2024 12:09:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, huth@tuxfamily.org, berrange@redhat.com,
 qemu-devel@nongnu.org
Date: Wed,  6 Nov 2024 12:09:28 +0000
Message-Id: <20241106120928.242443-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
References: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 2/2] ui/input-legacy.c: remove unused legacy
 qemu_add_kbd_event_handler() function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Since the last keyboard device has now been converted over to use
qemu_input_handler_register(), the legacy qemu_add_kbd_event_handler() function
is now unused and can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/console.h |  2 --
 ui/input-legacy.c    | 37 -------------------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 5832d52a8a..46b3128185 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -70,8 +70,6 @@ typedef struct QEMUPutMouseEntry QEMUPutMouseEntry;
 typedef struct QEMUPutKbdEntry QEMUPutKbdEntry;
 typedef struct QEMUPutLEDEntry QEMUPutLEDEntry;
 
-QEMUPutKbdEntry *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func,
-                                            void *opaque);
 QEMUPutMouseEntry *qemu_add_mouse_event_handler(QEMUPutMouseEvent *func,
                                                 void *opaque, int absolute,
                                                 const char *name);
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 210ae5eaca..ca4bccb411 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -109,43 +109,6 @@ void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
     g_free(up);
 }
 
-static void legacy_kbd_event(DeviceState *dev, QemuConsole *src,
-                             InputEvent *evt)
-{
-    QEMUPutKbdEntry *entry = (QEMUPutKbdEntry *)dev;
-    int scancodes[3], i, count;
-    InputKeyEvent *key = evt->u.key.data;
-
-    if (!entry || !entry->put_kbd) {
-        return;
-    }
-    count = qemu_input_key_value_to_scancode(key->key,
-                                             key->down,
-                                             scancodes);
-    for (i = 0; i < count; i++) {
-        entry->put_kbd(entry->opaque, scancodes[i]);
-    }
-}
-
-static const QemuInputHandler legacy_kbd_handler = {
-    .name  = "legacy-kbd",
-    .mask  = INPUT_EVENT_MASK_KEY,
-    .event = legacy_kbd_event,
-};
-
-QEMUPutKbdEntry *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func, void *opaque)
-{
-    QEMUPutKbdEntry *entry;
-
-    entry = g_new0(QEMUPutKbdEntry, 1);
-    entry->put_kbd = func;
-    entry->opaque = opaque;
-    entry->s = qemu_input_handler_register((DeviceState *)entry,
-                                           &legacy_kbd_handler);
-    qemu_input_handler_activate(entry->s);
-    return entry;
-}
-
 static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
                                InputEvent *evt)
 {
-- 
2.39.5


