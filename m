Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD4BCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFc-0000OK-KK; Sat, 09 May 2026 06:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfF4-0008Me-3L; Sat, 09 May 2026 06:49:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEy-0001eP-4v; Sat, 09 May 2026 06:49:05 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY28090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:47:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=z/EGey40LOEv17Pvn66VgBRZhGLL4HJQUkguBO+Y1og=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323678; v=1;
 b=GYMIwyk8UNicrCM4cO6ol5CgpiMFcpyJRHEzaB1y5mMJ+e3G+jJD2FY7wc/tdjei
 7uUvvXCo6sKFT+7m2CiA6Sn6VjJdZ6yMVyLdypAGnRE6FR49gnosYvZwSGdD0BNJ
 BLt8KWwisGb+lka6q95XTW5npP71NUeEmPKae8cz2NKD+4z1APN3rVOO8Btis6XC
 2vD9H3TXrYSEtxq+CvV0GYaknE6MAWunPOAB5whuoXeCFzt0P6mwKFQo2swNQX6L
 eR2rCUwiOvOlH3rNFroJPwuT2QqE4ar4Tp8nvmErDCT9a6LIUYdVfCfuDmLGufaz
 yq6BbhtvoCB0m8ld80Q1rQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 May 2026 19:34:19 +0900
Subject: [PATCH RFC 07/28] hw/arm/musicpal: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-input-v1-7-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=RnkN4NRWsDSiP2qNkaQCIyNqKJi7Ny8kXSY3/H4eSpI=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/gYvPjmwQMus5Pi/fPct8to3mcd5pYs93zy5bH+/D+
 b53sfWDjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIlkqzP8M515nLfzurpPbNha
 jc28ofbaTSt2xdss37tO9u5e55n3djL896hgWnhaYVHuhojiOVV1d2OUp01esjVzWnrC7VncsVL
 nWAE=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/arm/musicpal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index bddbfb5d20a3..10722e2f6d07 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -24,6 +24,7 @@
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/block/flash.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/bitbang_i2c.h"
@@ -1068,40 +1069,39 @@ static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     musicpal_key_state *s = MUSICPAL_KEY(dev);
-    int qcode = qemu_input_linux_to_qcode(evt->key.key);
     uint32_t event = 0;
     int i;
 
-    switch (qcode) {
-    case Q_KEY_CODE_UP:
+    switch (evt->key.key) {
+    case KEY_UP:
         event = MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_NAV_INV;
         break;
 
-    case Q_KEY_CODE_DOWN:
+    case KEY_DOWN:
         event = MP_KEY_WHEEL_NAV;
         break;
 
-    case Q_KEY_CODE_LEFT:
+    case KEY_LEFT:
         event = MP_KEY_WHEEL_VOL | MP_KEY_WHEEL_VOL_INV;
         break;
 
-    case Q_KEY_CODE_RIGHT:
+    case KEY_RIGHT:
         event = MP_KEY_WHEEL_VOL;
         break;
 
-    case Q_KEY_CODE_F:
+    case KEY_F:
         event = MP_KEY_BTN_FAVORITS;
         break;
 
-    case Q_KEY_CODE_TAB:
+    case KEY_TAB:
         event = MP_KEY_BTN_VOLUME;
         break;
 
-    case Q_KEY_CODE_RET:
+    case KEY_ENTER:
         event = MP_KEY_BTN_NAVIGATION;
         break;
 
-    case Q_KEY_CODE_M:
+    case KEY_M:
         event = MP_KEY_BTN_MENU;
         break;
     }

-- 
2.54.0


