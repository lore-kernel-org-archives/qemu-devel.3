Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E711CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDM-0008CL-Tk; Sun, 14 Jun 2026 15:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCy-0007Yb-9O
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCw-0002Zl-D0
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMSjzoHh5eLV9v+BiMfQgZHJ14Xa1/fuSL+UsKHzc9Y=;
 b=il5VeGm/WYOsL2EpgvOLPVixM6PQA5/yvEkEB36unkS1LsjZFF1OHH8T7ve3kO8dlVVtiO
 nZ4zVDZDeICCsicdcNmT/pDw0EOcxfhAYh39KsEH8uNKc0XoKu8fJtLdFCWg8OL4crZhWa
 vqGT/k4HSHmZmrychiqy+ySSDe9eqxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ZaU4qouUNmixCiociC3mHg-1; Sun, 14 Jun 2026 15:09:20 -0400
X-MC-Unique: ZaU4qouUNmixCiociC3mHg-1
X-Mimecast-MFC-AGG-ID: ZaU4qouUNmixCiociC3mHg_1781464159
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so22238985e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464159; x=1782068959; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hMSjzoHh5eLV9v+BiMfQgZHJ14Xa1/fuSL+UsKHzc9Y=;
 b=dMVaQoNO++B6JsynkfLuzwIXo/F9P8w75+K8laEGxE3qgdlRt0CqAQjsYTjsRAGdTv
 aVRH8UYaCAhe4AWfcrcc9khAMi171ja/UYJXP1F+FNj1aKKrVes0svXXD/gHWAQHEKeI
 t8Tr16lpG50DQnwwYL/923tbUMeOJ+HSrHuDw6UVIA3xXVILV0i9QeNAp3tz0Rx7/DzS
 nYLAjXssotTm/ucbRdAkJZVcliUW3RJXdNFRFot33KRYo1UtyWAGw/lc82uePont50mn
 hD1lIo4L+uHgIQMhtWz4vvCyf3FJylQOrv2PkTedu5uTRKNNB1/dhu8mhnO/K9+iYc5F
 bwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464159; x=1782068959;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMSjzoHh5eLV9v+BiMfQgZHJ14Xa1/fuSL+UsKHzc9Y=;
 b=XQzlk5MCa7+vx0VeNnsDdb8msrMccC+A4BQs1EbsGsZ60VsDSxvQOSUllq9v8nQ809
 9K38dQKyY2mwX9t9FS5uNJDKKGb/Qa71x5Rl8skFLHpnO3dqVJIH0xO2GJOK8CuJOwUy
 jnG5Z8f8/0HYuSU61Xl03hDYjlAu5jn/kGUP3NO46PHJ+BgXzP2FWem9FRuPxMZcb9n9
 jHiPiKZsUuzciCDsg6Rd8aHg2BSj5JWBclhLZ3TQLRJwm0WEpdFQWUYgbxkN5bQ4X+5b
 TC3k9F0nt9gRtwexVH4TJXdfOMGwz7uBN+olhoRrMaY37EGYxg0TRYzyp+K+miw2WUGd
 2ZDw==
X-Gm-Message-State: AOJu0YxcpgeWU5bbWDv36hnDYn2WttCMATAzLdE9XxJ1sPV0zumf7jWl
 H+HYeHJnzaVX3Ha1A0F2vWbfYkPLk2emwEFC6I53+9jVIi57LSPexSL5BQ0y9z/yerpem5H6MPA
 JKa8rqMHlOi2swhWlh+MMOXXqw3hhrApTtGJ2+lFq1B3zieBf3w5b/BmlpCRYyFI+R86OUpIyRy
 AIiEgrK0GlJ9yZ/ri52LtiH3Zcp4r3kZJq3g==
X-Gm-Gg: Acq92OFR3Op7Lga2AEEpckV08rUC8oQBp+6r0y8QgZkSlQCA7neC7SnNWRg2AFVU0yg
 W+oi1wOZ/I/PFo9L6Gzk0CadAAeTZKKj4akyOXHW6v9oLaqdAJlI1LtnbK8AJpdBf/Bft9yL/69
 hj6o5CZuHKAVZ4SXP3NzehB0CO/m/T2vXy0qGKLaA2O1sxurLUgYFZaRtTc+A0z8Lg20tRBg26L
 eOEgfOtYeaBrAto0o/cu4C+oPuKQseMeuSXOqxarHscj16X3+OMZq65ymXKoMOTFbLTsLZVRtfF
 fwdbf1U4Fq2x/uw1gJrMBd+AHrsBShRNLIf5k7MTjHy3/hJndsZd/9sT72F5OG2EIAh6Jz6v3M9
 PWmUcJ+rOgUqhIGUj5DMkm670jQJCvt8MQ9fIQlAaq6E=
X-Received: by 2002:a05:600c:314a:b0:490:e1a6:261 with SMTP id
 5b1f17b1804b1-490ec5092c8mr137640835e9.26.1781464159186; 
 Sun, 14 Jun 2026 12:09:19 -0700 (PDT)
X-Received: by 2002:a05:600c:314a:b0:490:e1a6:261 with SMTP id
 5b1f17b1804b1-490ec5092c8mr137640545e9.26.1781464158570; 
 Sun, 14 Jun 2026 12:09:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922031b7d2sm197621255e9.5.2026.06.14.12.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:18 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 085/106] acpi: add API to build WDAT instructions
Message-ID: <f793df3dcabab71e794639a794bba1ae1380943c.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Add definitions for WDAT[1] actions/instructions
and build_append_wdat_ins() API to build table entries.

1)
"Hardware Watchdog Timers Design Specification"
  https://uefi.org/acpi 'Watchdog Action Table (WDAT)'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260303092532.2410177-2-imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/aml-build.c    |  14 +++++
 include/hw/acpi/wdat.h | 118 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 include/hw/acpi/wdat.h

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 413d9b6240..9b3cdd3781 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -35,6 +35,7 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "qemu/cutils.h"
 #include "hw/core/cpu.h"
+#include "hw/acpi/wdat.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -2872,3 +2873,16 @@ void qbus_build_aml(BusState *bus, Aml *scope)
         call_dev_aml_func(DEVICE(kid->child), scope);
     }
 }
+
+void build_append_wdat_ins(GArray *table_data,
+                           WDATAction action, uint8_t flags,
+                           struct AcpiGenericAddress as,
+                           uint32_t val, uint32_t mask)
+{
+    build_append_int_noprefix(table_data, action, 1);    /* Watchdog Action */
+    build_append_int_noprefix(table_data, flags, 1);     /* Instruction Flags */
+    build_append_int_noprefix(table_data, 0, 2);         /* Reserved */
+    build_append_gas_from_struct(table_data, &as);       /* Register Region */
+    build_append_int_noprefix(table_data, val, 4);       /* Value */
+    build_append_int_noprefix(table_data, mask, 4);      /* Mask */
+}
diff --git a/include/hw/acpi/wdat.h b/include/hw/acpi/wdat.h
new file mode 100644
index 0000000000..89803eef4b
--- /dev/null
+++ b/include/hw/acpi/wdat.h
@@ -0,0 +1,118 @@
+/*
+ * Watchdog Action Table (WDAT) definitions
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_H
+#define QEMU_HW_ACPI_WDAT_H
+
+#include "hw/acpi/acpi-defs.h"
+
+/*
+ * Watchdog actions as described in
+ *  "Hardware Watchdog Timers Design Specification"
+ * for link to spec see https://uefi.org/acpi
+ *     'Watchdog Action Table (WDAT)'
+ */
+typedef enum {
+    /*
+     * Restarts the watchdog timer's countdown. This action is
+     * required.
+     */
+    WDAT_ACTION_RESET = 0x1,
+    /*
+     * Returns the current countdown value of the watchdog hardware
+     * (in count intervals).
+     */
+    WDAT_ACTION_QUERY_CURRENT_COUNTDOWN_PERIOD = 0x4,
+    /*
+     * Returns the countdown value the watchdog hardware is
+     * configured to use when reset (in count intervals).
+     */
+    WDAT_ACTION_QUERY_COUNTDOWN_PERIOD = 0x5,
+    /*
+     * Sets the countdown value (in count intervals) to be used when
+     * the watchdog timer is reset. This action is required if
+     * WDAT_ACTION_RESET does not explicitly write a new
+     * countdown value to a register during a reset. Otherwise, this
+     * action is optional.
+     */
+    WDAT_ACTION_SET_COUNTDOWN_PERIOD = 0x6,
+    /*
+     * Determines if the watchdog hardware is currently in enabled/
+     * running state. The same result must occur when performed from
+     * both from enabled/stopped state and enabled/running state. If
+     * the watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_QUERY_RUNNING_STATE = 0x8,
+    /*
+     * Starts the watchdog, if not already in running state. If the
+     * watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_SET_RUNNING_STATE = 0x9,
+    /*
+     * Determines if the watchdog hardware is currently in enabled/
+     * stopped state. The same result must occur when performed from
+     * both the enabled/stopped state and enabled/running state. If
+     * the watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_QUERY_STOPPED_STATE = 0xA,
+    /*
+     * Stops the watchdog, if not already in stopped state. If the
+     * watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_SET_STOPPED_STATE = 0xB,
+    /*
+     * Determines if the watchdog hardware is configured to perform a
+     * reboot when the watchdog is fired.
+     */
+    WDAT_ACTION_QUERY_REBOOT = 0x10,
+    /*
+     * Configures the watchdog hardware to perform a reboot when it
+     * is fired.
+     */
+    WDAT_ACTION_SET_REBOOT = 0x11,
+    /*
+     * Determines if the watchdog hardware is configured to perform a
+     * system shutdown when fired.
+     */
+    WDAT_ACTION_QUERY_SHUTDOWN = 0x12,
+    /*
+     * Configures the watchdog hardware to perform a system shutdown
+     * when fired.
+     */
+    WDAT_ACTION_SET_SHUTDOWN = 0x13,
+    /*
+     * Determines if the current boot was caused by the watchdog
+     * firing. The boot status is required to be set if the watchdog
+     * fired and caused a reboot. It is recommended that the
+     * Watchdog Status be set if the watchdog fired and caused a
+     * shutdown. This action is required.
+     */
+    WDAT_ACTION_QUERY_WATCHDOG_STATUS = 0x20,
+    /*
+     * Sets the watchdog's boot status to the default value. This
+     * action is required.
+     */
+    WDAT_ACTION_SET_WATCHDOG_STATUS = 0x21,
+} WDATAction;
+
+#define WDAT_INS_READ_VALUE 0x0
+#define WDAT_INS_READ_COUNTDOWN 0x1
+#define WDAT_INS_WRITE_VALUE 0x2
+#define WDAT_INS_WRITE_COUNTDOWN 0x3
+#define WDAT_INS_PRESERVE_REGISTER 0x80
+
+void build_append_wdat_ins(GArray *table_data,
+                           WDATAction action, uint8_t flags,
+                           struct AcpiGenericAddress as,
+                           uint32_t val, uint32_t mask);
+
+#endif /* QEMU_HW_ACPI_WDAT_H */
-- 
MST


