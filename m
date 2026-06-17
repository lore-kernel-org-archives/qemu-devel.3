Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48339CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs7k-0005vN-P8; Wed, 17 Jun 2026 11:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7a-0005dF-8s
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7Y-00048P-Qj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZlgPeAIzVB8wWelEkToQIEJjMpOuV3QmyJ1I2lAteE=;
 b=AyAhmLwpJPhmwcWFH9wG7dJFp5zGO5iYnnzD67QFu4qGXgvNHXHKx7ZZqR0+gxnJdxqev8
 aYTXauS2iIADjTEWUuceV/AMHmmCJNKWfPBv0HvXPjXKgcjEyMSNb+QES6+yKoiATQnKsi
 ZJRH53QIAYSgxz7gTRPscgNkbWZH8GA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-H75bhh-rPQmqBSQPq5cMUg-1; Wed,
 17 Jun 2026 11:24:00 -0400
X-MC-Unique: H75bhh-rPQmqBSQPq5cMUg-1
X-Mimecast-MFC-AGG-ID: H75bhh-rPQmqBSQPq5cMUg_1781709839
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C50BF1955EBE
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:23:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A1801800595; Wed, 17 Jun 2026 15:23:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:03 +0400
Subject: [GIT PULL 06/27] hw/input: replace fprint with LOG_GUEST_ERROR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-6-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=i64B5wBDWTTS2scXV/L0tAQtJD6TZQuAuNdI7jfExcU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvocJIEOFbtJBj9ftad25y8tqhfzEe4FP04L
 DmnbkYMUzaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5SmVD/0TSBc9ICLKyGlLvxUuz+FA/qoKkYWOt5Phu4UC6gc1USxEtMC7F7KVdudcfi/H0gAzJoy
 kbQBWZROXpYJeWRLwZ1W8Ch10kIk+V1wuoaB9mZU4JpzTTXyo8ZxhicZH2Ej2rDBMhvTCd3WnPD
 qcVJnk3jSKnV8D6kCf2m0RQhf2RYupEVP4u7sxXvXOK/65lNVdwq+UbPdoxybpG6cwFp575BA6I
 B6cPL8SRsYYw+LQgkLKNMDmDXwzVvCBgfbDao6gB77UX27Han0SQaUjAgIHYRDuRxNeuuIn8BIH
 bszzwO2ZUAVGKnIhe6STDri5lbkfrhl/nqPhZQ/XQrN2q+Iy6OqaX+mZoeT1nqNlMN+Rfh5kIB9
 nTQMwBTXAgO20yZLdIyaASBcL3vOz9r0rPOLegMReviuKdJM72Urqi9NeamRVYEEdteMVBq/Mq/
 paz9GtLhRgjlTIZHGvRfVUux7FT2jugcd6fm/yAIQ6lCNQ+ABqpJPW1pFGnjsKnPG6lh2WuyA/J
 8sA+ZUi2F3mQXyg0MXxb/GuGDxz8g71PfAcvtq1y378420ieTzturlDaW4OXD1YlQDGPFbLr/08
 gM40mem+TzyYoET+0L2192mvXnK6OJr3Rcw1BlDHfZuu0N1dYZy3vcHK/rvd3G+7dXS1Oes4KUo
 ql5O1kYEricMipg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


