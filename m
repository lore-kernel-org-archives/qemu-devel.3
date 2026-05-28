Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960FACD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSX5p-00073U-T1; Thu, 28 May 2026 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wSX5Z-0006w6-Jk
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wSX5W-0008SE-HS
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779960696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KrIouwlVTqyWZXqNBYeoMcZ2LrTpA8ND3XKys9iIMiI=;
 b=VLE25qJDdOmcRZaBrbEqI9UtXeLQj1RxdJWrHABlPeC0xHTjdYJsHIPp4FIESj/HpR+cjt
 E8xyvW2SaBdGNpFLUzSPELppV5Mb4Ll3Oc/FUb0kEL8pyIZug1xGHZEzCfhKYIan+wcVkb
 jQDZyeKNohApuj0Nr2CTJPiCkU8ApUw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-ePMOlYo-N5KJAE7ya0t9fA-1; Thu,
 28 May 2026 05:31:31 -0400
X-MC-Unique: ePMOlYo-N5KJAE7ya0t9fA-1
X-Mimecast-MFC-AGG-ID: ePMOlYo-N5KJAE7ya0t9fA_1779960690
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 252DD19560B2; Thu, 28 May 2026 09:31:30 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.redhat.corp
 (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4D9F19560A3; Thu, 28 May 2026 09:31:25 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, philmd@linaro.org,
 peter.maydell@linaro.org
Cc: pbonzini@redhat.com, peterx@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org
Subject: [PATCH v2] tpm_tis_sysbus: defer resource allocation to realizefn
Date: Thu, 28 May 2026 15:01:23 +0530
Message-ID: <20260528093123.55403-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
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

Calling memory_region_init_ram_device_ptr() and
memory_region_init_io() from tpm_tis_sysbus_initfn() crashes
when the device is introspected without being realized, because
the memory subsystem has not been initialized at that point.

So running:
  $ qemu-system-aarch64 -device tpm-tis-device,help

triggers qdev_device_help() which creates the device object
to list its properties, calling instance_init, but never
realizefn. The memory region calls in instance_init then hit
uninitialized subsystems:

With CONFIG_DEBUG_TCG:
  Assertion 'target_page.decided' failed. (physmem.c:2524)

Without CONFIG_DEBUG_TCG:
  Assertion 'mutex->initialized' failed. (qemu-thread-posix.c:107)

Since realizefn is only called when the device is actually
used in a running VM, moving resource allocation there avoids
the crash without breaking introspection.


Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
Changes in v2:
- Also move memory_region_init_io() to realizefn (Philippe)
- Make host_page_size const (Philippe)
- Reword commit message to cover both crash variants

 hw/tpm/tpm_tis_sysbus.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 6bec30c36f..f9cd1c8b5c 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -100,19 +100,9 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
-    size_t host_page_size = qemu_real_host_page_size();
-
-    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
-                          s, "tpm-tis-mmio",
-                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
 
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    s->ppi.buf = qemu_memalign(host_page_size,
-                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
-    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
-                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
 }
 
@@ -120,6 +110,7 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
     TPMState *s = &sbdev->state;
+    const size_t host_page_size = qemu_real_host_page_size();
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -131,6 +122,13 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->ppi.buf = qemu_memalign(host_page_size,
+                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+    memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
+                          s, "tpm-tis-mmio",
+                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
+    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
+                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
     vmstate_register_ram(&s->ppi.ram, dev);
 }
 
-- 
2.53.0


