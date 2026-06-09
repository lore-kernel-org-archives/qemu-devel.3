Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C860CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxYY-0002vr-Ow; Tue, 09 Jun 2026 10:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYX-0002sK-2r
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYV-0007BC-Fk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwVwvbSd0OrB/pLvMzG/RW2SPdBdDyZxlIjg2PbK6wY=;
 b=QNebKaOT0/bZFd5xX4Vc2v3ezA7b3oIhyKlg0D8LA9bldlOhVeuWsbctR763gNWjrQehXB
 CkTbmT80qGmmUzfyNEIp0+lHRNRy6QWvOPc/rovmWWTH344mT4TKvV4j1BUeWROzAHVeHJ
 55NdIXNNeWbQ0ca/tEYfMOCaxmy7Ey8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-VpvkWvGLMuu9w710SvSgSA-1; Tue,
 09 Jun 2026 10:35:45 -0400
X-MC-Unique: VpvkWvGLMuu9w710SvSgSA-1
X-Mimecast-MFC-AGG-ID: VpvkWvGLMuu9w710SvSgSA_1781015744
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0B3F197701C; Tue,  9 Jun 2026 14:35:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E665E1954102; Tue,  9 Jun 2026 14:35:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:31 +0400
Subject: [PATCH 12/17] hw/input/hid: use qemu_input_handler_set_led() for
 LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-12-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=788;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZtFjNPqtjzK8POC7BkT2jb6wYCgMKEiur3NINOMCbNk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR41W/w9tcAnQ8VN+RLY5V6N0GpmN5NZY6mQ
 +4NKjqcZtCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeAAKCRDa6OEJdZac
 5T14D/wIw10YHHw0zlVmjMpZKJ3xXlJ4Ojx4RaLUtarsV7+Zi6SdidbHQFW8+x9znWhsD11HUv8
 4sdo4yAWKQ7pfXUiz5Q8/+xF2k1t4I7RFTzoUahAhN8UNhdZWuNaqd3GCFEQMOcK9rRNs+cAuqU
 a0+TIK8ny3yjI/97xOvYYAEzf9C9qi16Miqc7gM0ylWLwZt+gdVg3T4+nH8T1ttutZkL/U4sx9P
 KEEFAL+GWvipycL4Z2hQqGs4KGxvht+5Aez2ZB1QLUaVKlN5Hp8W1PqtgwBKYRACm9svr3OVvct
 +u7R2MonGnq/2geL5mmsG6pMBe+LNOmjOt9vUUK+zTLo5LA6sCq5fliRAzhtBNIAI9C6KP+1jSM
 Qh6XUzYUfg44HtkTl9hY7ymwuLBRavYMT/XBCzDbHPCkOhDAL3erJM0lM2NSziMvW/zlpkOLDh3
 FXnzZIulzY+eY0XZcxCncuM4fo5TVG95nOu+Yx/rStFaoO0ne/7WOYcAF+KbTcCO6g7L/dnWpd4
 pfDyEpcEXf9K61QYiAN4bSI7MMLPcG1tVjJN6A4BmHJWodflWQuH3h2MGSyuSVOir+2LPLA+VVY
 p/sHP6gchAT1DwWhboMRrLAEvOcHJXaCcA+9z2KITLgUPO2jKcIYMMdnSBRasD+ccs1Ij2RhXZe
 tX1zzSS7N3nsXHQ==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/hid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 467ba8f14f3..d386e52585c 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
+#include "ui/input.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
 #include "migration/vmstate.h"
@@ -470,7 +471,7 @@ int hid_keyboard_write(HIDState *hs, uint8_t *buf, int len)
         if (hs->kbd.leds & 0x02) {
             ledstate |= QEMU_CAPS_LOCK_LED;
         }
-        kbd_put_ledstate(ledstate);
+        qemu_input_handler_set_led(hs->s, ledstate);
         return 1;
     }
     return 0;

-- 
2.54.0


