Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98CECD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 16:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRuxL-0004Lf-I0; Tue, 26 May 2026 12:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wRuxK-0004LX-7B
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wRuxH-0000nc-EP
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779814113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g59XSCruNr9LjT1dXClD0zm3jrAfzyDBDNA+N+F1ixA=;
 b=a1ZQUD7Mdb3CFXXIQ0a2+WPmI2P+v3cDnyVQDlqa4yGqzZByDurhaqGDpSxv5biXE2P9tv
 tKPuUr8HoufnpMEIggDbb1W13a0Gh0CeMpwmK7nAk3r1j3vUwTJdvL/4Hq1r+qaV71VTQW
 val1t2IeSXsO6G4GE/hb3+w1/tclio8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-vxuuvyPxPE29gfRCw5klKg-1; Tue,
 26 May 2026 12:47:20 -0400
X-MC-Unique: vxuuvyPxPE29gfRCw5klKg-1
X-Mimecast-MFC-AGG-ID: vxuuvyPxPE29gfRCw5klKg_1779814039
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B90DD195609F; Tue, 26 May 2026 16:47:19 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.redhat.corp
 (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35CFB1681; Tue, 26 May 2026 16:47:17 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com
Subject: [PATCH] tpm_tis_sysbus: move PPI memory region setup to realizefn
Date: Tue, 26 May 2026 22:17:16 +0530
Message-ID: <20260526164716.689664-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

memory_region_init_ram_device_ptr() requires the target page
size to be finalized, which has not happened during
instance_init. Calling it from tpm_tis_sysbus_initfn() causes
an assertion failure when the device is introspected without
being realized, for example:

  $ qemu-system-aarch64 -device tpm-tis-device,help
  qemu-system-aarch64: ../system/physmem.c:2524:
  qemu_ram_alloc_internal:
  Assertion 'target_page.decided' failed.
  Aborted (core dumped)

Property introspection only calls instance_init, never
realizefn, so moving the memory region setup to realizefn
avoids the crash while keeping the device fully functional
when actually used in a VM.

Move the PPI buffer allocation, memory_region_init_ram_device_ptr()
and the corresponding sysbus_init_mmio() from
tpm_tis_sysbus_initfn() to tpm_tis_sysbus_realizefn(), placing
them just before the existing vmstate_register_ram() call.

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/tpm/tpm_tis_sysbus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 6bec30c36f..33fe9e332c 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -100,7 +100,6 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
-    size_t host_page_size = qemu_real_host_page_size();
 
     memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
@@ -108,18 +107,13 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    s->ppi.buf = qemu_memalign(host_page_size,
-                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
-    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
-                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
 }
 
 static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
     TPMState *s = &sbdev->state;
+    size_t host_page_size = qemu_real_host_page_size();
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -131,6 +125,11 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->ppi.buf = qemu_memalign(host_page_size,
+                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
+                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ppi.ram);
     vmstate_register_ram(&s->ppi.ram, dev);
 }
 
-- 
2.53.0


