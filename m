Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABCBCD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdF-0002Li-8Z; Wed, 10 Jun 2026 06:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdD-0002KE-Jt
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdC-00068p-2t
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZlgPeAIzVB8wWelEkToQIEJjMpOuV3QmyJ1I2lAteE=;
 b=Q2pTf7n9tFPeyBJHgADQGv7KqqO2LutiJ/zv+cJFmXLMJ3nOgcpPUIqRw44moXec4/HMGL
 y4vMjKz8cQvHd5dmqs339DyXA1LFS+U7NikRKfXBD4f+TtLQShKpY0o8oazJ6q8LYmKZrM
 zByFvcdABe3A6fCrmJxKPTEsRREm9Xo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-7ICU36GPMfaYphFGHrQoRQ-1; Wed,
 10 Jun 2026 06:57:54 -0400
X-MC-Unique: 7ICU36GPMfaYphFGHrQoRQ-1
X-Mimecast-MFC-AGG-ID: 7ICU36GPMfaYphFGHrQoRQ_1781089072
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8321F1955E9A; Wed, 10 Jun 2026 10:57:52 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1E8E180057F; Wed, 10 Jun 2026 10:57:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:48 +0400
Subject: [PATCH v2 06/22] hw/input: replace fprint with LOG_GUEST_ERROR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-6-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=i64B5wBDWTTS2scXV/L0tAQtJD6TZQuAuNdI7jfExcU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL/6AJ1yQrD7GCYZ51cYnGbDppwSL8lFCmxO
 KrFACrPlgiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/wAKCRDa6OEJdZac
 5SGXEACe1TB6mqtKLP3x9E38DmSPylUivwpA9O6+JHwxZTmQLrMk3lTlxtCgDUTjD7Kzjok+kQ7
 pbucK7YnHY49ybYgf8ZYJNT3f9kRQVQ43INFExRAz4Lq2bBtO7baFxRWCqE/m4t9qm1C9kmsQCG
 uX91aa5FcjLIdwIE+RGFaLgviu5yuR3yWkr9qnhclYTaqc1oXgDwYQ+ua6YrX25IiKwq5I65VJp
 912YG+Sg6Do8I/WwePs26LJ+7G3+dRbMT12I+xwO0BC+w7Zd6O0dX9RT7WUx8r+g5sL74aJ4dM/
 grohUHWhzFhP+LFILn8mH0PdmAqyTb48RTkJexMcl/fGUpMgbVNcUq17A34MzzwqyebqeOdSuiS
 SoxWgsdwWhohnC0i5JzgSONq3WjQR5lKI3OCv4Pfdzk3PzaspYM7NH+qW2/B4YDm6DOalJaWJT0
 PbKsvZTBG68VfmrH/Mf/P0fIMsdFOstxkWVUZqlemlV67m+AXfD4OzdNlFbrx3zBalNMealAofX
 r5oGCmaM1+mpJEe1DZoUsZFQSK3ZGcernrmER3yQdV8qrK+nohmjSicko7bkJgJ8otSBIjf7Nqb
 IHvEbjDcQeTByskTTcbYeFjPS2OXTFT90rjZIHb6xgJF5D7+SrtWjSFnXPwPnU9+5dr1VKt2THD
 TibnEnvW7RlxmXw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input-hid.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 75fe45d89a2..73423ac0c73 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 
 #include "hw/virtio/virtio.h"
@@ -107,9 +108,9 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
             virtio_input_send(vinput, &event);
         } else {
             if (evt->btn.down) {
-                fprintf(stderr, "%s: unmapped button: %d [%s]\n", __func__,
-                        evt->btn.button,
-                        InputButton_str(evt->btn.button));
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: unmapped button: %d [%s]\n", __func__,
+                    evt->btn.button, InputButton_str(evt->btn.button));
             }
         }
         break;
@@ -210,8 +211,9 @@ static void virtio_input_hid_handle_status(VirtIOInput *vinput,
         kbd_put_ledstate(vhid->ledstate);
         break;
     default:
-        fprintf(stderr, "%s: unknown type %d\n", __func__,
-                le16_to_cpu(event->type));
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: unknown type %d\n", __func__,
+            le16_to_cpu(event->type));
         break;
     }
 }

-- 
2.54.0


