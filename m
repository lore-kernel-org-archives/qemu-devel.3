Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F62CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKqm-0006ne-UG; Wed, 24 Jun 2026 06:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKql-0006mq-Be
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKqj-0007BH-TE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782296933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBQRWE3oHz4dQwe/0gi4IuXipiKYKp8N64q0brpREPc=;
 b=MkZrVx1ygQo4axYXFGDtOswbxJnKMVux4afKG2/5UgadcU15TF9h8hns3P8vt3UtwLPASc
 Bs20Cl4Y8nt7ghoWGSjXfIYhvIYK6EJXpLOpE7iqC9pk3tbDVAvuO2uITEkrmMnUD+sUG7
 QNNFpITgvr73u8aQTqtmXmwhsOHq4aU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-t-Li1XW8OV6icPko2dbp_Q-1; Wed,
 24 Jun 2026 06:28:44 -0400
X-MC-Unique: t-Li1XW8OV6icPko2dbp_Q-1
X-Mimecast-MFC-AGG-ID: t-Li1XW8OV6icPko2dbp_Q_1782296921
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A27519560AF; Wed, 24 Jun 2026 10:28:41 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10EBC30001A7; Wed, 24 Jun 2026 10:28:38 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3 02/17] arm: add tracing events to sbsa_gwdt
Date: Wed, 24 Jun 2026 12:28:15 +0200
Message-ID: <20260624102830.1355552-3-imammedo@redhat.com>
In-Reply-To: <20260624102830.1355552-1-imammedo@redhat.com>
References: <20260624102830.1355552-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c  | 8 ++++++++
 hw/watchdog/trace-events | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index b739a3ce3c..acb970e8b3 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 static const VMStateDescription vmstate_sbsa_gwdt = {
     .name = "sbsa-gwdt",
@@ -62,6 +63,7 @@ static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int size)
         qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame read :"
                         " 0x%x\n", (int)addr);
     }
+    trace_sbsa_gwdt_refresh_read(addr, ret);
     return ret;
 }
 
@@ -93,6 +95,7 @@ static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int size)
         qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame read :"
                         " 0x%x\n", (int)addr);
     }
+    trace_sbsa_gwdt_control_read(addr, ret);
     return ret;
 }
 
@@ -127,6 +130,7 @@ static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size) {
     SBSA_GWDTState *s = SBSA_GWDT(opaque);
 
+    trace_sbsa_gwdt_refresh_write(offset, data);
     if (offset == SBSA_GWDT_WRR) {
         s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
 
@@ -141,6 +145,7 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size) {
     SBSA_GWDTState *s = SBSA_GWDT(opaque);
 
+    trace_sbsa_gwdt_control_write(offset, data);
     switch (offset) {
     case SBSA_GWDT_WCS:
         s->wcs = data & SBSA_GWDT_WCS_EN;
@@ -180,6 +185,7 @@ static void wdt_sbsa_gwdt_reset(DeviceState *dev)
 {
     SBSA_GWDTState *s = SBSA_GWDT(dev);
 
+    trace_sbsa_gwdt_reset();
     timer_del(s->timer);
 
     s->wcs  = 0;
@@ -196,10 +202,12 @@ static void sbsa_gwdt_timer_sysinterrupt(void *opaque)
 
     if (!(s->wcs & SBSA_GWDT_WCS_WS0)) {
         s->wcs |= SBSA_GWDT_WCS_WS0;
+        trace_sbsa_gwdt_ws0_asserted();
         sbsa_gwdt_update_timer(s, TIMEOUT_REFRESH);
         qemu_set_irq(s->irq, 1);
     } else {
         s->wcs |= SBSA_GWDT_WCS_WS1;
+        trace_sbsa_gwdt_ws1_asserted();
         qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
         /*
          * Reset the watchdog only if the guest gets notified about
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index d85b3ca769..b388f7b250 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -42,3 +42,12 @@ k230_wdt_interrupt(void) "K230 WDT interrupt"
 k230_wdt_reset(void) "K230 WDT system reset"
 k230_wdt_restart(void) "K230 WDT restart"
 k230_wdt_reset_device(void) "K230 WDT device reset"
+
+#sbsa_gwdt.c
+sbsa_gwdt_refresh_read(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] -> 0x%" PRIx32
+sbsa_gwdt_refresh_write(uint64_t addr, uint64_t value) "[0x%" PRIx64 "] <- 0x%" PRIx64
+sbsa_gwdt_control_read(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] -> 0x%" PRIx32
+sbsa_gwdt_control_write(uint64_t addr, uint64_t value) "[0x%" PRIx64 "] <- 0x%" PRIx64
+sbsa_gwdt_ws0_asserted(void) "WS0 signal is asserted"
+sbsa_gwdt_ws1_asserted(void) "WS1 signal is asserted"
+sbsa_gwdt_reset(void) "reset watchdog to default state"
-- 
2.47.3


