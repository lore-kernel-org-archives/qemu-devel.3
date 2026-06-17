Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BD2CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8m-00014G-D0; Wed, 17 Jun 2026 11:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8d-0000Kr-EB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8c-0004WG-2j
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2jo5NzPSf0WlbFoDkYEqqTSBWztZUWwmeVeb0hOwvg=;
 b=M19SGgjiHnqoE3YzwSuCrML8zJj0pD+Fl7rKmzm/OHi6wtV5AEGNiozcc0YjLrs5UBWRYh
 j8ZY/kRfBeXryP96H3onflakU84VAj+pDerUN1Yvr7QeR+8oBEd8MIcMkvkELkxsdRkM72
 cLYPKLNSrkQzTeheUUaNW3DT4ivHLrU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-2mh1zV6QP3GNLzj2K1RIyA-1; Wed,
 17 Jun 2026 11:25:05 -0400
X-MC-Unique: 2mh1zV6QP3GNLzj2K1RIyA-1
X-Mimecast-MFC-AGG-ID: 2mh1zV6QP3GNLzj2K1RIyA_1781709905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 061CF19539AB
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D837019540C9; Wed, 17 Jun 2026 15:25:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:15 +0400
Subject: [GIT PULL 18/27] hw/input/virtio-input-hid: use
 qemu_input_handler_set_leds_mask() for LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-18-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=947;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=U/+2C6Maw3rGE3j6JafFp5i8L1ADiWudqdjvruBnowI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvp0GtnyQY1gwQOElWFXE2aCLDSv9eZHDAaL
 4dkOU025q2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5U9qD/9dvRSlGYDqwMjNxuGsP8ScfbSCzgVTY9sIA9TWfgBvxTkJoUqVeIOr0aI6dnbhwfE8Af+
 CePR3ZEMI3mMGxb/B7RzLhuoLmFwCyE1dENRMtq/0W4Llm+uYWuYmzaGY8EPAUz9HVCEoJbbJBE
 1fDwqHuCm4OgW9VSarFyWR6SFyhq6bQNkRn0rqWPSpPa6AKwqLmhfisUuGieB5lE36mRm9sHkx1
 uqttAqv4erBz5fcVvbEcHX0D7/cRTpe8gsifeLtzafYy6/ENTwnELpdHXigOxDs5JJMyoiB9ZUH
 saThGAW36t2aJyo/+MqbQVbfDMM9BTGcEMWWUCJlm8YmTkZJvvvankZmnc3wwyIWWLEYLarUlMH
 g3ogvxfE7tUwSOocdGn9/pRJm6P9X8oOWdbK/6CkV6dSSXUyu2/AEtTizlrwwJJbp6DvNVZLFPR
 kw4GZ0Y5cFeQkadIWUgRaZZeDndqCHR5WorGOKKPvBqajbdP5d3giAYsxrjXVvtAgyOVfL+7JEG
 wZEOUl4RmQxgtLbhw1xJ4UFNS7DGUUjVaS8Bi/iF7MYjmkPbZ9LnILjotJosyH1ZrWbmcUzYscU
 v8rursXzgDLJqY+mGdCdFNUmYvYNFsxe1e7nO7E+HxDI3/Tmuortq00ewrYI5wdDVHPpGZLEKog
 R6qKa1osaWLdmXw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
 hw/input/virtio-input-hid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 73423ac0c73..1019d6b2e53 100644
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
+        qemu_input_handler_set_leds_mask(vhid->hs, vhid->ledstate);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,

-- 
2.54.0


