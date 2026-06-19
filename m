Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422ACCD98E6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 05:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRuD-0005Vi-1h; Fri, 19 Jun 2026 01:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waRuB-0005VY-G4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 01:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waRu9-0003Fg-UY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 01:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781847397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzpoEAPFv5OA3Buau/xvvnFoyBxxiJ4N44RYgjM+t/o=;
 b=aASLlcPrgjGPX9okdivxc1af0bFDqjpX0dHrHul6gQ0S1dS6wHQkDm8wok4jnXdU5WIZs+
 PVVHzi33J9Me2OnOlGEa11RIsmZshBmDPaQwu8PdwbFiTD/E2VXq+CBaUuh+p8bLsCHvOY
 v7fhb+SIu4pkkO57kJDIfEYqpeheiMM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-TDncEMFOOKKjXB-Cl6Yl1Q-1; Fri,
 19 Jun 2026 01:36:33 -0400
X-MC-Unique: TDncEMFOOKKjXB-Cl6Yl1Q-1
X-Mimecast-MFC-AGG-ID: TDncEMFOOKKjXB-Cl6Yl1Q_1781847392
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C449C1955DAE; Fri, 19 Jun 2026 05:36:31 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3159180058F; Fri, 19 Jun 2026 05:36:28 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/3] hw/tpm: gate PPI support on tpm-tis-device behind a
 device property
Date: Fri, 19 Jun 2026 11:06:21 +0530
Message-ID: <20260619053623.756021-2-mbawa@redhat.com>
In-Reply-To: <20260619053623.756021-1-mbawa@redhat.com>
References: <20260619053623.756021-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
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

Add a "ppi" boolean property (default: true) to tpm-tis-device.
When ppi=off the RAMBlock is never registered and the migration
stream omits "tpm-ppi", restoring backward compatibility.

Move sysbus_init_mmio() calls from instance_init to realizefn so
the memory regions are initialized before being registered.  When
ppi=off, the PPI MMIO region is simply not exposed.

Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/tpm/tpm_tis.h        |  1 +
 hw/tpm/tpm_tis_sysbus.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 1531620bf9..6ac9804050 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -76,6 +76,7 @@ typedef struct TPMState {
     size_t be_buffer_size;
 
     TPMPPI ppi;
+    bool ppi_enabled;
 } TPMState;
 
 extern const VMStateDescription vmstate_locty;
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 16bb17874b..a7b0002d82 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -94,6 +94,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
 };
 
 static void tpm_tis_sysbus_initfn(Object *obj)
@@ -101,9 +102,7 @@ static void tpm_tis_sysbus_initfn(Object *obj)
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
 
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
 }
 
 static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
@@ -122,14 +121,19 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    s->ppi.buf = qemu_memalign(host_page_size,
-                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
     memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
                           TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
-    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
-                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
-    vmstate_register_ram(&s->ppi.ram, dev);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    if (s->ppi_enabled) {
+        s->ppi.buf = qemu_memalign(host_page_size,
+                                   ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+        memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
+                                          TPM_PPI_ADDR_SIZE, s->ppi.buf);
+        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ppi.ram);
+        vmstate_register_ram(&s->ppi.ram, dev);
+    }
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
-- 
2.54.0


