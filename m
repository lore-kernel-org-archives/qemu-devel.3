Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B70C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Tt-0002VI-QI; Fri, 11 Sep 2026 10:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NV-0002q1-12
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NI-000841-PJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNUd+bMGXY0z0prDdK4igFxO8NCpyH4B4dmoUC/5P5c=;
 b=SoX7pZ0gFbIf6NzF9fnz+c89NQezHqUGCDmV+RpkKr4Ps+y3O49TShC1UV2X73ALO5b9HA
 wC67GPyvIrWrRoTbMzJ7sTDUH8FAtvLccHyCrkyRQY1wsAtffGvBS4CR2yY+apSZl+NYHm
 +6ZnLXKqIC9b3cMmbYuX/Z7YWVJkkKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-tWO8hnOQMNmj-gNz7OkuIg-1; Fri,
 11 Sep 2026 10:37:03 -0400
X-MC-Unique: tWO8hnOQMNmj-gNz7OkuIg-1
X-Mimecast-MFC-AGG-ID: tWO8hnOQMNmj-gNz7OkuIg_1789137422
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34FB81955BC6; Fri, 11 Sep 2026 14:37:02 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 624253000229; Fri, 11 Sep 2026 14:37:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/28] hw/ide: mark ICH9 and ide-hd/ide-cd as secure
Date: Fri, 11 Sep 2026 15:36:13 +0100
Message-ID: <20260911143627.2743803-15-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These have a long history of usage in virtualization scenarios on
x86, for OS which lack modern virtio drivers for storage, and thus
must be considered secure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/ide/ich.c     | 1 +
 hw/ide/ide-dev.c | 3 +++
 hw/ide/piix.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b00987f08d..c7d50a15c1 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -198,6 +198,7 @@ static const TypeInfo ich_ahci_info = {
     .instance_size = sizeof(AHCIPCIState),
     .instance_init = pci_ich9_ahci_init,
     .class_init    = ich_ahci_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 5d478588c6..f555d0fb04 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -214,6 +214,7 @@ static const TypeInfo ide_hd_info = {
     .parent        = TYPE_IDE_DEVICE,
     .instance_size = sizeof(IDEDrive),
     .class_init    = ide_hd_class_init,
+    .secure        = true,
 };
 
 static const Property ide_cd_properties[] = {
@@ -236,6 +237,7 @@ static const TypeInfo ide_cd_info = {
     .parent        = TYPE_IDE_DEVICE,
     .instance_size = sizeof(IDEDrive),
     .class_init    = ide_cd_class_init,
+    .secure        = true,
 };
 
 static void ide_device_class_init(ObjectClass *klass, const void *data)
@@ -252,6 +254,7 @@ static const TypeInfo ide_device_type_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(IDEDevice),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(IDEDeviceClass),
     .class_init = ide_device_class_init,
     .instance_init = ide_dev_instance_init,
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a8472f3e58..9b7b5e98c8 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -198,6 +198,7 @@ static const TypeInfo piix3_ide_info = {
     .name          = TYPE_PIIX3_IDE,
     .parent        = TYPE_PCI_IDE,
     .class_init    = piix3_ide_class_init,
+    .secure        = true,
 };
 
 /* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
@@ -221,6 +222,7 @@ static const TypeInfo piix4_ide_info = {
     .name          = TYPE_PIIX4_IDE,
     .parent        = TYPE_PCI_IDE,
     .class_init    = piix4_ide_class_init,
+    .secure        = true,
 };
 
 static void piix_ide_register_types(void)
-- 
2.55.0


