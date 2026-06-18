Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C8ACD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCGp-0002o0-3v; Thu, 18 Jun 2026 08:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waCGm-0002n1-TU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waCGl-0004er-Am
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781787294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8V6oosldVkwdbhJtONeAJrAbQFwuyqm/fwmCeMxuFE=;
 b=Ap/bWVjcLynQ01zfPRoFoXSNUYTOUlkWeVGj85axFql7/BNsRqrjuadqtV0Ay2GzSXBdSu
 nwfqlcRJXehb6opu9S9GofA2Rx7I0sGw4rlXkpX/sG8t6qWrEOYVhjmsR50pLPh6XBunkv
 ftYVjhveteXnpIdJy8GqCpI3AWwJotc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-2gGtNTu8OsO-Zs5wDCQSrQ-1; Thu,
 18 Jun 2026 08:54:51 -0400
X-MC-Unique: 2gGtNTu8OsO-Zs5wDCQSrQ-1
X-Mimecast-MFC-AGG-ID: 2gGtNTu8OsO-Zs5wDCQSrQ_1781787290
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7301180266F; Thu, 18 Jun 2026 12:54:49 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C289F1956087; Thu, 18 Jun 2026 12:54:47 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] hw/tpm: gate PPI support on tpm-tis-device behind a
 device property
Date: Thu, 18 Jun 2026 18:24:41 +0530
Message-ID: <20260618125442.641532-2-mbawa@redhat.com>
In-Reply-To: <20260618125442.641532-1-mbawa@redhat.com>
References: <20260618125442.641532-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a "ppi" boolean property (default: true) to tpm-tis-device.
When ppi=off the RAMBlock is never registered and the migration
stream omits "tpm-ppi", restoring backward compatibility.

When disabled, realizefn initializes the region with zero size so
the platform bus skips it and ACPI PPI tables are omitted.

Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/tpm/tpm_tis.h        |  1 +
 hw/tpm/tpm_tis_sysbus.c | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

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
index 16bb17874b..54691ac272 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -94,6 +94,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
 };
 
 static void tpm_tis_sysbus_initfn(Object *obj)
@@ -122,14 +123,19 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
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
+
+    if (s->ppi_enabled) {
+        s->ppi.buf = qemu_memalign(host_page_size,
+                                   ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+        memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
+                                          TPM_PPI_ADDR_SIZE, s->ppi.buf);
+        vmstate_register_ram(&s->ppi.ram, dev);
+    } else {
+        memory_region_init(&s->ppi.ram, OBJECT(dev), "tpm-ppi", 0);
+    }
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
-- 
2.54.0


