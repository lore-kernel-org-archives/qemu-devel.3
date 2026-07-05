Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E5DC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwu-0006TS-Mj; Sun, 05 Jul 2026 10:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNws-0006HP-QS
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwr-0001Sm-9A
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTnu3PjGzlRsbS7CoAoKXq3Veho6h75memFBiQUlhOk=;
 b=JFCluPdgF02Bws47lDsMpPjypyWDYQfYhE8HHIWJJJDlUtisSjjkqpLicRk72r9hO5ilAH
 byTxig/GtEjRZizs/kc8yKIF4f7d2XnnqcuLR1Ze4rLn6mn+a5gpCucZi4N9//kTsjuIdP
 YnPjd2oQzRFJ8aIdDoY8WdS6Enn9xeI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-N8m50B3EOdW40o-qt17iYg-1; Sun, 05 Jul 2026 10:35:53 -0400
X-MC-Unique: N8m50B3EOdW40o-qt17iYg-1
X-Mimecast-MFC-AGG-ID: N8m50B3EOdW40o-qt17iYg_1783262152
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c526df6bso14963285e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262152; x=1783866952; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BTnu3PjGzlRsbS7CoAoKXq3Veho6h75memFBiQUlhOk=;
 b=XzjyKjd+6HPndr612TOvzKR5z01GgcJ6TC9AxjJsCiInXVJCJauog6vm87frOPIqi3
 WBP/n6vfUK4SW3540z3QEDJxMkEGb9zpLjwiY9M6EFD6lMlBqfzbRVebWXHUJeBBKui0
 ebiX5PgRhqG13IriEVRbM88Vhjck36BUYi1EcHgACj0+YWoific2dFcoCXrzttTnEzvt
 q7hOtox9NAG1cvVWCLJh64bzeoERnoimujzcNjWUcAZ6Na4Lm+uirOBRkcQUyyFhgdyt
 DmV5h6t86XJquan91SwdUzlf3FyQrhP/KJnQnjRe2PqWkQYyZtId9nvQOf9dC6y3kd5a
 +foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262152; x=1783866952;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BTnu3PjGzlRsbS7CoAoKXq3Veho6h75memFBiQUlhOk=;
 b=WEoaG/Nhmuyyz8jMf6g+pCY1xlowyL7/REZgj5tOX8pmMy0kXQ/6sUyk1MagKzLNoS
 2BvD+Rf7mXGOtZAV7yyJdFB9vebK6Db2wx+aaE06bqRwrssK/Yzud0hp3yLgGd5SlRXi
 +0GcTdIcniQPqNb9TaBGW4KDxuAhT8lS3RCvSpnfQzI/E40WsXW2Mdw8cDR5Gl2xYZ6G
 jcFrMkpc91I5oztol2X17Yg2XHdwiEsEHgihRM74PCxkCVBjie69S+BpbAH6wTQcOT0l
 VNuN9O5YUVFCtOXVjbiN/KdU+5zhjqjBcYtgs1AhjOgBhBOY+Boa4DctoDh8jJFPG7Z6
 raIg==
X-Gm-Message-State: AOJu0YzidydZ7PmNvInfd/0CuThGiim75ciU45etTmuFglItQQU0Yv7i
 d0fAx0lH767MYLupBNCyivh+YnvKY0Zgj6WWyTvOJg4EtKvQLRHmMsbhftL/mOAH1YIyBPRLZjY
 eZPd5DTd/SKZtQnznydPKOfa8SqmxATN8tA9JRDz1nvgl5kUwBRJGwvsuTO/OcZZMpmr4HopHVe
 sP7cOn2T8DJr3nG3fRGfsjSJT6rdjnvKJlPQ==
X-Gm-Gg: AfdE7ckDakykMT3/5eLb55dqvUtBQC51viyKNXOTFU5BhnqJMRGQs8+rRiECMw8Hojd
 GcdDR6Q9WttFj7drb6kCDCChM1ET3OJ6RnyC5edkkpz9l+ZJCWEhu+RrKcxoSj6IapcBisy/WDb
 5wI1YLhsXFDAXYTkOkdhd29AIXkNAqDwm5fsCC0Tek9KnMr2RLi+I2hGoUREuhbO1HPS4gB5Pxk
 pGYeevZldDDTPZkyoiSLBFKzB/PCc98DPqVIqNOG2jS4t9qWoqa3WMpJSTIQCzuZCj/aYko0nLW
 prMnS0u/pMA9fewPObV7iEUmWSpT2deZCxh4EFuV0hhkdtZE9dF/1o6j4JU8NNfYF7UPFV7h8f6
 fUH0jFujpTBr7Kkh5+5HXsYuPrLC2g4qC
X-Received: by 2002:a5d:5509:0:b0:478:19e7:22a2 with SMTP id
 ffacd0b85a97d-47aac4eb421mr5845194f8f.25.1783262151774; 
 Sun, 05 Jul 2026 07:35:51 -0700 (PDT)
X-Received: by 2002:a5d:5509:0:b0:478:19e7:22a2 with SMTP id
 ffacd0b85a97d-47aac4eb421mr5845165f8f.25.1783262151150; 
 Sun, 05 Jul 2026 07:35:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm15387892f8f.19.2026.07.05.07.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:50 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PULL 28/44] arm: add tracing events to sbsa_gwdt
Message-ID: <88e1d327fdb73e22479c97139fb237dabf6788ff.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-3-imammedo@redhat.com>
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
MST


