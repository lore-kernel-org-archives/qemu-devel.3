Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1650EC01BE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cXV-00030J-3Y; Mon, 23 Mar 2026 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXQ-0002zq-PR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXP-0008E0-9g
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774261773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnROsTNxHyES9AurHPzCrNFn6wWU4LohssBPpErdJYY=;
 b=WLIXD5L7sOonIcZSS0Zu5R9duHaJymhy6kDeWCIf3EqUoXtTPkxBRiSd8JwIlNQ5V8ntZs
 eAc1uvS2w90Z2Dv1rFHnA2Zf6bbUWzzeu1Vlx850XJ12uPgWnI1d0EyAsLtmpeFBTO+r/N
 ZoWTxlW/kH4cJGM+8Dv5ElFYDosD9lE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103--VSlaN-ZOOuzU4MovGzuXA-1; Mon,
 23 Mar 2026 06:29:32 -0400
X-MC-Unique: -VSlaN-ZOOuzU4MovGzuXA-1
X-Mimecast-MFC-AGG-ID: -VSlaN-ZOOuzU4MovGzuXA_1774261771
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42A79195608D; Mon, 23 Mar 2026 10:29:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A92C3300019F; Mon, 23 Mar 2026 10:29:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 3/6] hw/sparc/sun4m_iommu: Fix crash when introspecting
 sun4m-iommu from the CLI
Date: Mon, 23 Mar 2026 11:29:17 +0100
Message-ID: <20260323102920.25170-4-thuth@redhat.com>
In-Reply-To: <20260323102920.25170-1-thuth@redhat.com>
References: <20260323102920.25170-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when introspecting the sun4m-iommu device from the
command line interface:

 $ ./qemu-system-sparc -display none -device sun4m-iommu,help
 qemu-system-sparc: ../../devel/qemu/system/physmem.c:1401:
  register_multipage: Assertion `num_pages' failed.
 Aborted (core dumped)

There does not seem to be a compelling reason for initializing the
memory regions from the instance_init function, so let's simply move
the code into a realize() function instead to fix this issue.

Reported-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260317084450.442071-1-thuth@redhat.com>
---
 hw/sparc/sun4m_iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index ab5eb67072a..1534445992b 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -351,13 +351,14 @@ static void iommu_reset(DeviceState *d)
     s->regs[IOMMU_MASK_ID] = IOMMU_TS_MASK;
 }
 
-static void iommu_init(Object *obj)
+static void iommu_realize(DeviceState *ds, Error **errp)
 {
-    IOMMUState *s = SUN4M_IOMMU(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    IOMMUState *s = SUN4M_IOMMU(ds);
+    SysBusDevice *dev = SYS_BUS_DEVICE(ds);
+    Object *obj = OBJECT(ds);
 
     memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
-                             TYPE_SUN4M_IOMMU_MEMORY_REGION, OBJECT(dev),
+                             TYPE_SUN4M_IOMMU_MEMORY_REGION, obj,
                              "iommu-sun4m", UINT64_MAX);
     address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "iommu-as");
 
@@ -377,6 +378,7 @@ static void iommu_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, iommu_reset);
+    dc->realize = iommu_realize;
     dc->vmsd = &vmstate_iommu;
     device_class_set_props(dc, iommu_properties);
 }
@@ -385,7 +387,6 @@ static const TypeInfo iommu_info = {
     .name          = TYPE_SUN4M_IOMMU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IOMMUState),
-    .instance_init = iommu_init,
     .class_init    = iommu_class_init,
 };
 
-- 
2.53.0


