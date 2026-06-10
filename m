Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B87CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGeb-0005um-QR; Wed, 10 Jun 2026 06:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeS-0005jc-7M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeN-0000Al-Jf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/g5jfTi2AD+hzkWtUUyAkv+WqHTfhObwkFPbXFeULU=;
 b=EfO/yg5B0lEwO2sXPNCc3kf0YGdDvy7bTipAe7bWIfIAHgdUXuxEypEIZwH8sSxTqaTtoN
 faR8iKbQdMboT7PHaz4G68J05/bgtkaiGHv3Qywvry1ZR5a0cTNQ3fndzl/fUcjvHdnK0J
 V6EDM2v/THuttOifEXVy9J2CFvybGcE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-OgAhiXmnM1OdayB5g7ISIw-1; Wed,
 10 Jun 2026 06:59:04 -0400
X-MC-Unique: OgAhiXmnM1OdayB5g7ISIw-1
X-Mimecast-MFC-AGG-ID: OgAhiXmnM1OdayB5g7ISIw_1781089143
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E67301800D9F; Wed, 10 Jun 2026 10:59:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47359414; Wed, 10 Jun 2026 10:59:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:57:00 +0400
Subject: [PATCH v2 18/22] hw/input/virtio-input-hid: use
 qemu_input_handler_set_led() for LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-18-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=877;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FxrGAwrXr2ksjrfGyAaKoh9XtsL3mW3yFUW3RWHGSfA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMBz9ffM6aA0FJXHn0z0skUON0T+m7CTRgHY
 dTiozAR1g6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAQAKCRDa6OEJdZac
 5YHMD/96MdKXukgMZzsVd2DozlfLB5BTGOVrDUuhQ78MTgBTgmVQs2tOJVDRfhFG3qBQd759/h4
 WRX5oeJmG/VMlPtrJp6hcwm7+Vex+q0AukJMUb9AUrQTtmbN5TFNfreIxrlhnLmcMod+K8q6PFa
 3flmt/c5Blj0Nwm4951JH/3CqzHDWkB2Iwwr72+b9cscKmBpsBJlCq7JztU2n3bMMbvR76njdT+
 YfQv3LwcUcV5TkV6gxsvW0741Np2sW0mD1ew4p7KOojPFRfYLR5yQYq8Flq276vKlU0n1WY534I
 8Q8hkfa8iRWaTilUxQCxALh4YyjEo6njknZl+HMzHLdbOnN/5/1r58TVAP63NAaZ3709UuNh2yN
 YX3A+HgYeePYR0THTVobBuXojVK0/DbSKdXeeaulklH9Iz/2cr/mYIqHN8TrN42XakRnxC5zcIH
 0AIkG5ZNFCX5+Dag69YETGtU5IhdRdgKWXvFRpXwa3c17MrZNmklSps8ddX1ts4vFKII6TWBgGn
 mTZXRT4pqaUAgxc2+6Z9LcyUB5Fd/uFcWCmSpzUIOcBIxpbuiXM8RlMoCZDCiRkN+8j10XKVDFl
 jCnIwWfDbjHXAeoOjjrmhsJWxsIQf8XUMydohdQGjFcQe2bILylJ216Gj34xxyMNIb/+71fhAjj
 aqGXr7M6h6QfLiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input-hid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 73423ac0c73..d3062809a13 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -12,6 +12,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
+#include "ui/input.h"
 
 #include "ui/console.h"
 
@@ -208,7 +209,7 @@ static void virtio_input_hid_handle_status(VirtIOInput *vinput,
         } else {
             vhid->ledstate &= ~ledbit;
         }
-        kbd_put_ledstate(vhid->ledstate);
+        qemu_input_handler_set_led(vhid->hs, vhid->ledstate);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,

-- 
2.54.0


