Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C25C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2Yv-0000mt-AO; Sat, 08 Jun 2024 16:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Yu-0000lq-42
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Ys-0006YB-Ay
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f1691b18fso431804f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717878073; x=1718482873;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQEyeeAODBFtgLjJITuW2Z+P+ELVxbNF153Umdt+bWw=;
 b=VmprFHxo8sKtp3kIPz87LyWIp4GiesXKOJ+u4Z7cM/NPnldspl7Svo5gMYxppMBVdk
 ybzkJ/7EseM4VEi1Bwuc2bT6rduKjyB+at8lhuk0BeoL1wJpE4fOVFyftUQNYXgb24kQ
 AmIG7I7eW/D2djYnV7wpcVdHo0z+QzTamQvRK8EKb/WBeFKEP8Uqj1ZEpkOOJchfWvaV
 fmp5SzawaaHfZSceEi+Oss/WR0NfBrZ3dGV82no8fq0WuDhoLfDzZn82uftAQzTtzTOp
 5SsZ4CE0TVmCoFmN9AXpQX8Gocx0FciFh5jI9/BdEJghTzmtyVpneqQW1iIbE6o0uARu
 ZTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717878073; x=1718482873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQEyeeAODBFtgLjJITuW2Z+P+ELVxbNF153Umdt+bWw=;
 b=CT0RAoJPol8dhCCo7RKJhX3ZVNO+2C8DgBpgas+BqgqLIhJRQk+lRryB51dijS5KaR
 4zXjNp+7Q3PNOPxpyab/N91C5v+7mFJC+UTu0NmlgqKdmQW3ZyQERNEJoV2M0hVm2+cy
 4dYKG2MRpCH5hxkB2Z16urAxnOmus7lmkbHrE9oIfeRerlNFLnJBv0bRYon01szmUXGm
 lMIGNW2lYDHRyAz7e4kAuTXsAL5AuqZCpfCmRpgjB6SFUKUYjR/E9vknNP37O4sVIfUm
 TjP57wPKF6RG8014qFcI62IPbuaNqjk/SW0PHziltue3PTHJ95jvydSYS8qjftqooQuX
 9zyg==
X-Gm-Message-State: AOJu0YyhKTFFX7yWsVhpPW28vYxok1wt910BieCoYgixjeQ3XoWjwVlg
 1Ih2rXGwyMy8CpGWK5eRWQ7aU9x2KGuLNezDbCb0Cu1kWosPA37HwFv4okexMIuAx2y8AF/iJec
 =
X-Google-Smtp-Source: AGHT+IGzJf3SDxJxqscgePxLY8aMTTc8fSssrYWrXVN1vWD9XaDv+af18Kwl50hy8hq1hhHqYGwl4A==
X-Received: by 2002:a5d:678e:0:b0:355:77c:3146 with SMTP id
 ffacd0b85a97d-35efed20185mr3946592f8f.14.1717878072968; 
 Sat, 08 Jun 2024 13:21:12 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0ccc5f03sm3803845f8f.88.2024.06.08.13.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 13:21:12 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 marcandre.lureau@redhat.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/3] hw: Moves int_clamp() implementations to header
Date: Sat,  8 Jun 2024 22:20:44 +0200
Message-Id: <20240608202045.2815-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240608202045.2815-1-phil@philjordan.eu>
References: <20240608202045.2815-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::429;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Both hw/input/hid.c and hw/usb/dev-wacom.c define identical versions
(aside from code formatting) of a clamping function, int_clamp().
(marked inline) To avoid duplication and to enable further re-use, this
change moves the function into qemu/cutils.h.

Signed-off-by: Phil Dennis-Jordan<phil@philjordan.eu>
---
 hw/input/hid.c        | 12 +-----------
 hw/usb/dev-wacom.c    | 11 +----------
 include/qemu/cutils.h | 11 +++++++++++
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 76bedc1844..89f37f1bbb 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "ui/console.h"
 #include "qemu/timer.h"
+#include "qemu/cutils.h"
 #include "hw/input/hid.h"
 #include "migration/vmstate.h"
 #include "trace.h"
@@ -336,17 +337,6 @@ static void hid_keyboard_process_keycode(HIDState *hs)
     }
 }
 
-static inline int int_clamp(int val, int vmin, int vmax)
-{
-    if (val < vmin) {
-        return vmin;
-    } else if (val > vmax) {
-        return vmax;
-    } else {
-        return val;
-    }
-}
-
 void hid_pointer_activate(HIDState *hs)
 {
     if (!hs->ptr.mouse_grabbed) {
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 7177c17f03..539581010e 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -32,6 +32,7 @@
 #include "hw/usb/hid.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "qemu/cutils.h"
 #include "desc.h"
 #include "qom/object.h"
 
@@ -215,16 +216,6 @@ static void usb_wacom_event(void *opaque,
     usb_wakeup(s->intr, 0);
 }
 
-static inline int int_clamp(int val, int vmin, int vmax)
-{
-    if (val < vmin)
-        return vmin;
-    else if (val > vmax)
-        return vmax;
-    else
-        return val;
-}
-
 static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
 {
     int dx, dy, dz, b, l;
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index da15547bfb..4394f03326 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -277,6 +277,17 @@ static inline const char *yes_no(bool b)
      return b ? "yes" : "no";
 }
 
+static inline int int_clamp(int val, int vmin, int vmax)
+{
+    if (val < vmin) {
+        return vmin;
+    } else if (val > vmax) {
+        return vmax;
+    } else {
+        return val;
+    }
+}
+
 /*
  * helper to parse debug environment variables
  */
-- 
2.36.1


