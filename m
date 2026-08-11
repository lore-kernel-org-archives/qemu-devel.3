Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DCCC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpN3-0007wN-0D; Tue, 11 Aug 2026 12:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMc-0007SF-Ho
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMU-0000AC-Bi
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8GW0wRrBuxDuS7Kd1nZw/Cmv+y0TCQKKNutjE5mSqw=;
 b=a0YSbpe8z1azzFK+TG1GEoagtrx4m2o5wMv1QuCCB0uiRivXvGkpdVzTkM1kUF7bzU6+Ui
 vem/D115Z6b0PlA0v4rl+jEZT4sA0ll/nWTwIXaLn/ALYbEoxxBg5OJnRIM/tGCfsS6gGM
 +nGtX6p4CFNLurreos7CgjuWIfqY67E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-8n9z2yMYP6qc8YecrZzEag-1; Tue,
 11 Aug 2026 12:29:55 -0400
X-MC-Unique: 8n9z2yMYP6qc8YecrZzEag-1
X-Mimecast-MFC-AGG-ID: 8n9z2yMYP6qc8YecrZzEag_1786465794
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 177671800145; Tue, 11 Aug 2026 16:29:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58122195DF96; Tue, 11 Aug 2026 16:29:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/83] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Date: Tue, 11 Aug 2026 18:28:20 +0200
Message-ID: <20260811162938.1403216-6-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce a new boolean property, "caps-64bit-addr", to control
HCCPARAMS[0] (64-bit Addressing Capability).

When enabled, the EHCI controller advertises support for 64-bit
address memory pointers as defined in the EHCI specification
(Table 2-7, HCCPARAMS). This allows software to use the 64-bit
data structure formats described in Appendix B.

When disabled (default), the controller reports 32-bit addressing
capability and uses the standard 32-bit data structures.

The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to
form 64-bit addresses for EHCI control data structures. Per EHCI 1.0
spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit
is zero, CTRLDSSEGMENT is not used: software cannot write it and reads
must return zero.

Add a capability check in the operational register write handler and
reject guest writes to CTRLDSSEGMENT when 64-bit addressing is
not enabled.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.h |  5 ++++-
 hw/usb/hcd-ehci.c | 14 +++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index cbc32c296df6..f739e6371b23 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -261,6 +261,7 @@ struct EHCIState {
      * Old machine types only transfer 32-bit fetch addresses.
      */
     bool migrate_fetch_addr_64bit;
+    bool caps_64bit_addr;
 
     /*
      *  EHCI spec version 1.0 Section 2.3
@@ -324,7 +325,9 @@ struct EHCIState {
 #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \
     DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
-                     ehci.migrate_fetch_addr_64bit, true)
+                     ehci.migrate_fetch_addr_64bit, true), \
+    DEFINE_PROP_BOOL("caps-64bit-addr", _state, \
+                     ehci.caps_64bit_addr, false)
 
 extern const VMStateDescription vmstate_ehci;
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 1a0c58011539..e65ea825b021 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1109,6 +1109,15 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
         }
         break;
 
+    case CTRLDSSEGMENT:
+        if (!s->caps_64bit_addr) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ehci: write to CTRLDSSEGMENT while "
+                          "64-bit addressing capability is disabled\n");
+            return;
+        }
+        break;
+
     case ASYNCLISTADDR:
         if (ehci_async_enabled(s)) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -2554,6 +2563,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
                    s->maxframes);
         return;
     }
+    if (s->caps_64bit_addr) {
+        s->caps[0x08] |= BIT(0);
+    }
 
     memory_region_add_subregion(&s->mem, s->capsbase, &s->mem_caps);
     memory_region_add_subregion(&s->mem, s->opregbase, &s->mem_opreg);
@@ -2613,7 +2625,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)
     s->caps[0x05] = 0x00;        /* No companion ports at present */
     s->caps[0x06] = 0x00;
     s->caps[0x07] = 0x00;
-    s->caps[0x08] = 0x80;        /* We can cache whole frame, no 64-bit */
+    s->caps[0x08] = 0x80;        /* We can cache whole frame */
     s->caps[0x0a] = 0x00;
     s->caps[0x0b] = 0x00;
 
-- 
2.55.0


