Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256FFEC047B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM1L-0004C9-5y; Tue, 03 Mar 2026 04:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1E-00042d-M2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1D-0004SV-0x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I89jagiyUTSdR4ox4hiKhJe39qI0yX7MnHEPNLVHs48=;
 b=cllwJdmAUnfsoibUPvIeY0OqlITpCUTP+9xqdgoEOsvbZtu3y+UeyO9MB2B2mh8lGCy/66
 NeRmZdiQfoD6TPR7XDbhLYBAGCVShvHMHOxIPRb+/AXAiu0bHg/3pnVLtxkJ0ujedJ3nd/
 KhZr6WbtoFqfEg9U/GEENHm1jWKfF3Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-0am4qaREMBqulAtSmUoQiQ-1; Tue,
 03 Mar 2026 04:26:14 -0500
X-MC-Unique: 0am4qaREMBqulAtSmUoQiQ-1
X-Mimecast-MFC-AGG-ID: 0am4qaREMBqulAtSmUoQiQ_1772529972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B6DF1800473; Tue,  3 Mar 2026 09:26:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6E9230001B9; Tue,  3 Mar 2026 09:26:09 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 10/21] arm: sbsa_gwdt: add 'wdat' option
Date: Tue,  3 Mar 2026 10:25:21 +0100
Message-ID: <20260303092532.2410177-11-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 include/hw/watchdog/sbsa_gwdt.h | 1 +
 hw/watchdog/sbsa_gwdt.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
index 307a4f291a..dc77e6be60 100644
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
index c4dd8005b7..40d80f7f2b 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -265,6 +265,13 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
+    /*
+     * WDAT supports only upto 1KHz resolution,
+     */
+    if (s->wdat) {
+        s->freq = 1000;
+    }
+
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
                 dev);
 }
@@ -276,6 +283,7 @@ static const Property wdt_sbsa_gwdt_props[] = {
      */
     DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
                        1000000000),
+    DEFINE_PROP_BOOL("wdat", struct SBSA_GWDTState, wdat, false),
 };
 
 static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
-- 
2.47.3


