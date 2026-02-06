Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F9AEE20A7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLle-0007A7-F7; Fri, 06 Feb 2026 08:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLlG-00075m-RL
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLlD-0005fW-S7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770384033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cN48x5XkNz+ZzFX0W6F6K3Vu3WSZy7lhhgSSh6sYPt0=;
 b=OhFKQNF3xD3Df9xOx+OV6EkrQFJdjNE+wlgA9NXk1z5i2jM0/hzk7aExIlr+c2962EC4I/
 umFPMRp8lnTX2Dkfe9pPyrh4hJACw0QT6H3Pl4sgmwWOH5aQAnDPsYP/WhWzqazpuj/hzb
 sruVYnLWNkyI4TwtBzlMCn7pMwm69LE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-LPDhQSCxPwyfH8BjdzNMzg-1; Fri,
 06 Feb 2026 08:15:22 -0500
X-MC-Unique: LPDhQSCxPwyfH8BjdzNMzg-1
X-Mimecast-MFC-AGG-ID: LPDhQSCxPwyfH8BjdzNMzg_1770383720
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B80818608EB; Fri,  6 Feb 2026 13:15:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A930818003F5; Fri,  6 Feb 2026 13:15:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: [PATCH 07/11] arm: add tracing events to sbsa_gwdt
Date: Fri,  6 Feb 2026 14:14:34 +0100
Message-ID: <20260206131438.1857182-8-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-1-imammedo@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c  | 8 ++++++++
 hw/watchdog/trace-events | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 7ade5c6f18..d159e61c34 100644
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
index ad3be1e9bd..5be430fb9e 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -33,3 +33,12 @@ spapr_watchdog_expired(uint64_t num, unsigned action) "num=%" PRIu64 " action=%u
 # watchdog.c
 watchdog_perform_action(unsigned int action) "action=%u"
 watchdog_set_action(unsigned int action) "action=%u"
+
+#sbsa_gwdt.c
+sbsa_gwdt_refresh_read(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] -> 0x%" PRIu32
+sbsa_gwdt_refresh_write(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] <- 0x%" PRIu32
+sbsa_gwdt_control_read(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] -> 0x%" PRIu32
+sbsa_gwdt_control_write(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] <- 0x%" PRIu32
+sbsa_gwdt_ws0_asserted(void) "WS0 signal is asserted"
+sbsa_gwdt_ws1_asserted(void) "WS1 signal is asserted"
+sbsa_gwdt_reset(void) "reset watchdog to defaut state"
-- 
2.47.3


