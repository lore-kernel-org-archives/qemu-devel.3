Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BBCCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxY3-0001eY-FA; Tue, 09 Jun 2026 10:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxY1-0001VN-K1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXz-0006vw-Sb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GhlaX9RxVK7BT3mF9ghhLa+4UH1Dr8+DEw6WKys1Uo=;
 b=ScojNPH4f1GbdwcCs22fISzpI7S1gssXsXivDEr0QD7gD8iaAWvNOP8ASFKr6BGlTfCI+X
 lDvOTVqkXRTMoxVh3cgxxUVKFsLCyLy9BhTF4WI/INkWSQWuqxDKPmf/QHNhX78Jte+lWz
 4lYA5weIV7Xel4z6NALeW/MTDojmAz8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-xuKzh9HRNWqysGAeogetVg-1; Tue,
 09 Jun 2026 10:35:15 -0400
X-MC-Unique: xuKzh9HRNWqysGAeogetVg-1
X-Mimecast-MFC-AGG-ID: xuKzh9HRNWqysGAeogetVg_1781015714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFB2318501D0; Tue,  9 Jun 2026 14:35:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20CCB18005B7; Tue,  9 Jun 2026 14:35:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:25 +0400
Subject: [PATCH 06/17] hw/input: replace fprint with LOG_GUEST_ERROR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-6-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tgtAvJxhRyoqqCQ9RJr2DxYeCbtpurFwon7zQ5eSVls=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR3n/GRFUwn9eu3rUrG8G7XSi4xuSVNM6FZz
 xS2yHOu16OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkdwAKCRDa6OEJdZac
 5QoMD/9OM5mssAnNmw/21UHkDEo4vdBzUseqJMVbmfcHPZakRmHsTeYsXIh2QtyGdYISCMzHTMt
 gwVOUjkWdatvO9hT4igq4PDxJWEMfl27SGPwNGxEDwUZ7xqA5PvnJ299iFslM1ZTn+Zle9dyvbd
 /ko72Dnh6T4pdQHNB7pvp70sJXgubvwVg8r/TplQZ4D3PUXpoRQyO82hCsF8UinRI9zbppLIP7o
 SVxaDXHAj395vKEB6YB87wxH04IN+KvOzkSsQy8+qVpm7JBl+HD4VDYq+hlAcesR5Ekh6zOrWfu
 iuuBHvB4TZY6n6xg/PJULLhhcXGjp5p4sVsDoq/RxXKTKue6GEmXlXq+FbHikJjaPsXOlNouKDV
 cnZJEk1sp7gh520aw3NGtKfe5PXECym94hhjR37of76XjJP6OywJYXIOf1iXp/wXnLxWjDFSjuP
 lW1NEtBs0XVXooHDCiUT4RBEqKZRLAPSYz1LnAnKMmH4kRbv6yl9MFGtLaEpL902Dcg1nf3e1w8
 hqMaxhZ2ULtJFKpYggEpuMJ03KTSUyoziVoTmURdeRwyMUSS3518pGuLV7vvb7UCN2Ef33IeCXA
 Yd52kS160UAJSfuN3IvCvctMj/DTPibdW/N6xaiXzRDaqRVMduDFzkrcjAYIETeS3A2ZFfUfbs9
 sptsEfZ679XGHtQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


