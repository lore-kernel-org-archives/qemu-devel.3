Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4410ACD5BB4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3uC-0000vY-9M; Thu, 21 May 2026 09:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3u8-0000Wx-5Q
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3u6-00010C-4p
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBHFQLtRMrdfnvQtSsd7u7e5jcNyISFb5lV/307G3wI=;
 b=hMtk0qv6PTESz6SUX+lLzXZtzNrP1wu9pmm5f1qoec7SPwIsk0A5ylLpiedjtnI+tQl6Jh
 XSHYjX39iWBagVQXlPs8Z5GG8NRpf1HhucST1MbKk7I7KH+JXgGRzhG/k+t0qPqSnhPMnf
 qSu/4QDcDphPKFS/aP8xsD87blL59Z4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-MYz7K9w1PBKv5Fh5va0kYg-1; Thu,
 21 May 2026 09:57:32 -0400
X-MC-Unique: MYz7K9w1PBKv5Fh5va0kYg-1
X-Mimecast-MFC-AGG-ID: MYz7K9w1PBKv5Fh5va0kYg_1779371851
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7A0618002FA; Thu, 21 May 2026 13:57:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4CF91687; Thu, 21 May 2026 13:57:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Musicpal)
Subject: [PULL v2 16/38] hw/arm/musicpal: Use Linux key codes
Date: Thu, 21 May 2026 17:55:27 +0400
Message-ID: <20260521135551.1752945-17-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-8-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/arm/musicpal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index c8985a58f99..e2630243eb7 100644
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
@@ -1069,40 +1070,39 @@ static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
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


