Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AFEF3381D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QGi-0007jy-8G; Tue, 17 Mar 2026 04:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2QGL-0007bb-70
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2QGJ-00081r-IJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nvo8ZxYpvNESWwYgT308QCI89GUADvG+DHcdOxlYT34=;
 b=H3jYmGZvBK1a+TbAODUe5CxcaOnl/bL8GkVj9XIH5z06tQotKVjivYKHCt1N/Rtcl2ziYa
 4Kd9Tk9MYaO+B1qordYGdZN3BnYV9cx32YdrDRd8/SKTmNDeNha/zDmwBdUHay0wp4vqjo
 F7vA96AkANerngBeWaneLQfOZVx5qqs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-_BfSUI-tNSmIhO-_mbupAQ-1; Tue,
 17 Mar 2026 04:58:46 -0400
X-MC-Unique: _BfSUI-tNSmIhO-_mbupAQ-1
X-Mimecast-MFC-AGG-ID: _BfSUI-tNSmIhO-_mbupAQ_1773737925
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 705BC1956056; Tue, 17 Mar 2026 08:58:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.37])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E07453000223; Tue, 17 Mar 2026 08:58:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH] hw/sparc64/sun4u_iommu: Fix crash when introspecting
 sun4u-iommu from the CLI
Date: Tue, 17 Mar 2026 09:58:39 +0100
Message-ID: <20260317085839.445178-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when introspecting the sun4u-iommu device from the
command line interface:

 $ ./qemu-system-sparc64 -display none -device sun4u-iommu,help
 qemu-system-sparc64: ../../devel/qemu/system/physmem.c:1401:
  register_multipage: Assertion `num_pages' failed.
 Aborted (core dumped)

There does not seem to be a compelling reason for initializing the
memory regions from the instance_init function, so let's simply move
the code into a realize() function instead to fix this issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/sparc64/sun4u_iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index 0188ce35d29..fe9d47b822f 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -290,13 +290,14 @@ static void iommu_reset(DeviceState *d)
     memset(s->regs, 0, IOMMU_NREGS * sizeof(uint64_t));
 }
 
-static void iommu_init(Object *obj)
+static void iommu_realize(DeviceState *ds, Error **errp)
 {
-    IOMMUState *s = SUN4U_IOMMU(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IOMMUState *s = SUN4U_IOMMU(ds);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(ds);
+    Object *obj = OBJECT(ds);
 
     memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
-                             TYPE_SUN4U_IOMMU_MEMORY_REGION, OBJECT(s),
+                             TYPE_SUN4U_IOMMU_MEMORY_REGION, obj,
                              "iommu-sun4u", UINT64_MAX);
     address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "iommu-as");
 
@@ -310,13 +311,13 @@ static void iommu_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, iommu_reset);
+    dc->realize = iommu_realize;
 }
 
 static const TypeInfo iommu_info = {
     .name          = TYPE_SUN4U_IOMMU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IOMMUState),
-    .instance_init = iommu_init,
     .class_init    = iommu_class_init,
 };
 
-- 
2.53.0


