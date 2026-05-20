Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE83CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPajb-0002zv-Uz; Wed, 20 May 2026 02:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajY-0002vi-G3; Wed, 20 May 2026 02:48:48 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajU-0001Ni-PF; Wed, 20 May 2026 02:48:48 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbi096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:18 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8DrbNDimPytD2Lqd2BsnuvqZLeFlu5Z+sunaR47ICfs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259698; v=1;
 b=fEZCpVFVhWFOlcfUgU330wHIwnRjlASnSlznTTPQonCq7mCkUUWym91W6GVUeTMy
 0Nw4rLBTXb6iyMLQM7fHUEHSIlWObzElByN4CtO0zMSU/e0L2SiIHllPkHe1Lbu0
 QFDc8+YskXp2a0XWwpbLgNMr6/cmyEsVvPLQmv7xa0HPb1z26Z2JfxX8WC9J44kY
 +aWTYCIYNXVOeuOmEy/1X7eyFDVHVsaKxdIu1DA1XBQRmJqG7/ezgBHnl5kbGc/6
 KJq5pSB1iIMPA9PTk2sJHk8nB5n+1jua11bnIphk2Xwc9WksBZhTpQ4Kwr+M4cs3
 YY/X5GCfj5+7ATP5TTwB2g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:48:04 +0900
Subject: [PATCH v3 21/29] ui/input-legacy: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-21-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=Fw4LZt0Zxdxd+pp/aswa6uqQEJsaIMY4eIVuWOuDFDU=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpPq7h+8Ko7SyDlx3N7wcI7LDXd/6298jt8+rxOR2/
 b/8z1Sjo5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCJZeowMO87Or3n+28Jbl/Ft
 5WrxZRnzd+kH3o3fyt17vWLr5NmXbBkZem6cykjxCnxy0vtZ9q+LfpP8d7NVLoisCmS284ye7SX
 AAAA=
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
 ui/input-legacy.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index e2b48dd8f0aa..193c9ae2ef9f 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -71,23 +71,11 @@ int index_from_key(const char *key, size_t key_length)
     return i;
 }
 
-static KeyValue *copy_key_value(KeyValue *src)
-{
-    KeyValue *dst = g_new(KeyValue, 1);
-    memcpy(dst, src, sizeof(*src));
-    if (dst->type == KEY_VALUE_KIND_NUMBER) {
-        QKeyCode code = qemu_input_key_number_to_qcode(dst->u.number.data);
-        dst->type = KEY_VALUE_KIND_QCODE;
-        dst->u.qcode.data = code;
-    }
-    return dst;
-}
-
 void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
                   Error **errp)
 {
     KeyValueList *p;
-    KeyValue **up = NULL;
+    unsigned int *up = NULL;
     int count = 0;
 
     if (!has_hold_time) {
@@ -95,15 +83,15 @@ void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
     }
 
     for (p = keys; p != NULL; p = p->next) {
-        qemu_input_event_send_key(NULL, copy_key_value(p->value), true);
-        qemu_input_event_send_key_delay(hold_time);
         up = g_realloc(up, sizeof(*up) * (count+1));
-        up[count] = copy_key_value(p->value);
+        up[count] = qemu_input_key_value_to_linux(p->value);
+        qemu_input_event_send_key_linux(NULL, up[count], true);
+        qemu_input_event_send_key_delay(hold_time);
         count++;
     }
     while (count) {
         count--;
-        qemu_input_event_send_key(NULL, up[count], false);
+        qemu_input_event_send_key_linux(NULL, up[count], false);
         qemu_input_event_send_key_delay(hold_time);
     }
     g_free(up);

-- 
2.54.0


