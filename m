Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BDD606BDFC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aDBU2ZQU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFq-00080x-0f; Fri, 13 Nov 2026 13:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFJ-0007KG-3B
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFH-0005Qa-Il
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uc9i6UZjVBLhmLRxZHZTdpLbwO6skXQXvUwvpI8SoVY=;
 b=aDBU2ZQUnxY3D5/Bu73RWgvz5nZ6kD1WWE9LgjA+PeWQna6W1v4F1Zgi7NBCsCBkCc9dwD
 7cH2O6M+dl3lybl4JbI58i1o/eAa2fHxSewkEIsotfEwgSz4oJkLFtgDx1Ri2DqgWIRhKI
 B+SRfawkbuA4o8GqhV55VOGd5mJXm0M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-bKDjgLBsPOOmyywIZW6BoQ-1; Fri,
 13 Nov 2026 13:43:29 -0500
X-MC-Unique: bKDjgLBsPOOmyywIZW6BoQ-1
X-Mimecast-MFC-AGG-ID: bKDjgLBsPOOmyywIZW6BoQ_1794595408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 944F11955F7E
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:28 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F78619634E9; Fri, 13 Nov 2026 18:43:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 17/26] hw/misc: mark pvpanic, vmcoreinfo as secure
Date: Fri, 13 Nov 2026 18:42:45 +0000
Message-ID: <20261113184254.2524253-18-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These devices are common debug aids for virtualized
guests so must be marked secure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/misc/pvpanic-isa.c  | 1 +
 hw/misc/pvpanic-mmio.c | 1 +
 hw/misc/pvpanic-pci.c  | 1 +
 hw/misc/vmcoreinfo.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index 85fb7da5e5c..bb0a7ff6f8e 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -121,6 +121,7 @@ static const TypeInfo pvpanic_isa_info = {
     .instance_size = sizeof(PVPanicISAState),
     .instance_init = pvpanic_isa_initfn,
     .class_init    = pvpanic_isa_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
index a173a1a9a58..161e8fc59b4 100644
--- a/hw/misc/pvpanic-mmio.c
+++ b/hw/misc/pvpanic-mmio.c
@@ -50,6 +50,7 @@ static const TypeInfo pvpanic_mmio_info = {
     .instance_size = sizeof(PVPanicMMIOState),
     .instance_init = pvpanic_mmio_initfn,
     .class_init    = pvpanic_mmio_class_init,
+    .secure        = true,
 };
 
 static void pvpanic_register_types(void)
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 5509f70a3e5..7d1f99d564b 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -80,6 +80,7 @@ static const TypeInfo pvpanic_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PVPanicPCIState),
     .class_init    = pvpanic_pci_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 9c2e9005ad3..90f361b05f1 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -101,6 +101,7 @@ static const TypeInfo vmcoreinfo_types[] = {
         .parent         = TYPE_DEVICE,
         .instance_size  = sizeof(VMCoreInfoState),
         .class_init     = vmcoreinfo_device_class_init,
+        .secure         = true,
     }
 };
 
-- 
2.56.1


