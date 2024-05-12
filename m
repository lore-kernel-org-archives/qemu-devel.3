Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA13FC25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66n0-0003Ua-7i; Sun, 12 May 2024 06:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mv-0003SS-6f
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mt-00068K-I0
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAHqvDmQEO8OjvPeuVb2SeO24+Gk9qiK1aHJ9DoYPm4=;
 b=Gsu4/sPBsgg58KWkgP1lMxsEhJU5KQr2vecWzc8qYOta25y/X/XV3shRmV9erC1V/W9S7z
 nUO0r+yHDXsr+xITRXU+O6amuId93bwffPq6accRDBNxBQcT4zB56FV8R25siBnur1gZ8G
 9SalRXD33LKbd3ifV590xsVWqFE+n7g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-AyBj_kZkPai6yPn7PT55LA-1; Sun, 12 May 2024 06:50:36 -0400
X-MC-Unique: AyBj_kZkPai6yPn7PT55LA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a5a5fdd6185so23514366b.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511034; x=1716115834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAHqvDmQEO8OjvPeuVb2SeO24+Gk9qiK1aHJ9DoYPm4=;
 b=AQVY17aN54KMB5hbVWsXNfbY1SW6ldf3PxntaflUv1sTG+JrhXjT2k8NZDxte7sTmE
 UVbKhl54cjctMtEu/rtUmnddTxtp/29g5yZUeTHOSq06iYH2LyyJALaow7F2k+7EfwHF
 6FDvbOXJKrYD6hEMc8SbDjZ2McntqpnSmAG+PhHJwZXkZsaS65oAnbFAB49EUElOqjnB
 9ScUnqduSx0+O3UtPd7BK0PilbNUNx1KV9RSm+R6xffsq/eWNF2RyI7hgauOR6Ms2PNA
 iCtuo9MH+U48JtojRLc9dJdWTT2pUa7E7sPGndreOd2HA/js6voY2ad4O8bS5JBxbKdq
 TIXw==
X-Gm-Message-State: AOJu0YxGTKirXAtGCwaCj43dyG/veQdN8DK57RAfhc5DqECKfXP55GgY
 a/FKQSDweYmnzdZXMuU8wXtIrfBatFQKaZK0Bm+s+4AgTN4qfCTha8C+8CDLgN9CvulZAca0l0z
 +Cy5R05A9N1w2YVZ9aZhRnpet7xXSL/bcYZspxecOg1NbvPZG6UQph0lwKDLfkN56RAEJrXcCfn
 iKHqOwm5bOMM6JmAzgFnAJitBEQZmHJjsZEoky
X-Received: by 2002:a17:906:260e:b0:a59:c944:de4 with SMTP id
 a640c23a62f3a-a5a2d18b383mr516305266b.2.1715511034371; 
 Sun, 12 May 2024 03:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEVV9bn9kgj9xV5Bw/FhiAHZvmoC1R1y+Qct6mwG+FN/j+nT4303fnGe+Jtptt6a42yF0NSQ==
X-Received: by 2002:a17:906:260e:b0:a59:c944:de4 with SMTP id
 a640c23a62f3a-a5a2d18b383mr516304366b.2.1715511034058; 
 Sun, 12 May 2024 03:50:34 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b014besm442466966b.161.2024.05.12.03.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 19/27] hw/i386: move rtc-reset-reinjection command out of hw/rtc
Date: Sun, 12 May 2024 12:49:37 +0200
Message-ID: <20240512104945.130198-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The rtc-reset-reinjection QMP command is specific to x86, other boards do not
have the ACK tracking functionality that is needed for RTC interrupt
reinjection.  Therefore the QMP command is only included in x86, but
qmp_rtc_reset_reinjection() is implemented by hw/rtc/mc146818rtc.c
and requires tracking of all created RTC devices.  Move the implementation
to hw/i386, so that 1) it is available even if no RTC device exist
2) the only RTC that exists is easily found in x86ms->rtc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240509170044.190795-12-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/rtc/mc146818rtc.h |  2 +-
 hw/i386/monitor.c            | 46 ++++++++++++++++++++++++++++++++++++
 hw/rtc/mc146818rtc.c         | 12 ++--------
 hw/i386/meson.build          |  1 +
 4 files changed, 50 insertions(+), 11 deletions(-)
 create mode 100644 hw/i386/monitor.c

diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 97cec0b3e84..64893be1515 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -55,6 +55,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
                                     qemu_irq intercept_irq);
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
-void qmp_rtc_reset_reinjection(Error **errp);
+void rtc_reset_reinjection(MC146818RtcState *rtc);
 
 #endif /* HW_RTC_MC146818RTC_H */
diff --git a/hw/i386/monitor.c b/hw/i386/monitor.c
new file mode 100644
index 00000000000..1ebd3564bf2
--- /dev/null
+++ b/hw/i386/monitor.c
@@ -0,0 +1,46 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-target.h"
+#include "hw/i386/x86.h"
+#include "hw/rtc/mc146818rtc.h"
+
+#include CONFIG_DEVICES
+
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    X86MachineState *x86ms = X86_MACHINE(qdev_get_machine());
+
+#ifdef CONFIG_MC146818RTC
+    if (x86ms->rtc) {
+        rtc_reset_reinjection(MC146818_RTC(x86ms->rtc));
+    }
+#else
+    assert(!x86ms->rtc);
+#endif
+}
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 3379f92748b..8ccee9a385d 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -104,16 +104,9 @@ static void rtc_coalesced_timer_update(MC146818RtcState *s)
     }
 }
 
-static QLIST_HEAD(, MC146818RtcState) rtc_devices =
-    QLIST_HEAD_INITIALIZER(rtc_devices);
-
-void qmp_rtc_reset_reinjection(Error **errp)
+void rtc_reset_reinjection(MC146818RtcState *rtc)
 {
-    MC146818RtcState *s;
-
-    QLIST_FOREACH(s, &rtc_devices, link) {
-        s->irq_coalesced = 0;
-    }
+    rtc->irq_coalesced = 0;
 }
 
 static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
@@ -941,7 +934,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     object_property_add_tm(OBJECT(s), "date", rtc_get_date);
 
     qdev_init_gpio_out(dev, &s->irq, 1);
-    QLIST_INSERT_HEAD(&rtc_devices, s, link);
 }
 
 MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 3437da0aad1..03aad10df7a 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -2,6 +2,7 @@ i386_ss = ss.source_set()
 i386_ss.add(files(
   'fw_cfg.c',
   'e820_memory_layout.c',
+  'monitor.c',
   'multiboot.c',
   'x86.c',
   'x86-cpu.c',
-- 
2.45.0


