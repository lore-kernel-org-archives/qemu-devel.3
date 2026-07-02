Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C10C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIst-000550-UO; Thu, 02 Jul 2026 10:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIsq-00054W-ER
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIsp-0004OU-2w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783004357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wv8wx84TQJRzPJVFxwH/z7diWzMQXTDkr+aov8OgWc0=;
 b=GiJujcBqwEuz2PK1cKm+pXz5tn5uDq3krrVncJjTcVK6Il8GQXd7o+pejeenR0KFJ9613l
 xiq+2pXGVZvvKFQA16FY1A2UOmVh0L5u4eQh3nzt4CJ0w2nJBoRpjNlF4vmdRUsC2xRX7v
 uuOBbNCXnVQykLxoX9Rl94ke3CmwIr8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-XAGaz92ePWSpa2b8FAUzGA-1; Thu,
 02 Jul 2026 10:59:14 -0400
X-MC-Unique: XAGaz92ePWSpa2b8FAUzGA-1
X-Mimecast-MFC-AGG-ID: XAGaz92ePWSpa2b8FAUzGA_1783004353
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 787E81944AAE; Thu,  2 Jul 2026 14:59:13 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77CCE180056E; Thu,  2 Jul 2026 14:59:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v4 05/13] arm: sbsa-gwdt: add 'wdat' option
Date: Thu,  2 Jul 2026 16:58:48 +0200
Message-ID: <20260702145856.1539572-6-imammedo@redhat.com>
In-Reply-To: <20260702145856.1539572-1-imammedo@redhat.com>
References: <20260702145856.1539572-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

it will be used by arm/virt board, to pick WDAT compatible watchdog impl.
and act as switch over to WDAT ACPI table vesus default GTDT ACPI table.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/watchdog/sbsa_gwdt.h | 1 +
 hw/watchdog/sbsa_gwdt.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
index 8941dcff9e..5ad7c7a798 100644
--- a/include/hw/watchdog/sbsa_gwdt.h
+++ b/include/hw/watchdog/sbsa_gwdt.h
@@ -73,6 +73,7 @@ typedef struct SBSA_GWDTState {
     uint32_t woru;
     uint32_t wcvl;
     uint32_t wcvu;
+    bool wdat;
 } SBSA_GWDTState;
 
 #endif /* WDT_SBSA_GWDT_H */
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 49fdd723c2..330a74798a 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -265,6 +265,14 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
+    /*
+     * WDAT spec: "The clock interval that the WDT uses must be
+     * greater than or equal to 1 millisecond."
+     */
+    if (s->wdat) {
+        s->freq = 1000;
+    }
+
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
                 dev);
 }
@@ -276,6 +284,7 @@ static const Property wdt_sbsa_gwdt_props[] = {
      */
     DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
                        1000000000),
+    DEFINE_PROP_BOOL("wdat", struct SBSA_GWDTState, wdat, false),
 };
 
 static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
-- 
2.47.3


