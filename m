Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F503606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqOxk9+a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ0z-0006JL-Ab; Thu, 29 Oct 2026 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwz-0008JS-0b
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwx-0006QI-97
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZxw4M4gDY5tKHQioN+bGUmjv78GhfFNRK3LJmr5w4M=;
 b=AqOxk9+ajhkUVyI+Y6Fr+TdSyzxiGtL6y83fz8TtBjAGZEbbGsXwxD1dIZrDCida6Su7te
 2l7swvrNpCn2wvN+ufS6SePFVIKFD2tpbc5Sz9o6VVlJfmSwQu1cfNSBJTDJH0UIC1R2BA
 ZRLmRdcuu1uB3qKQtzuzEN2pafFQUXg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-JZDKrbBfOS6BoxhK62Whug-1; Thu,
 29 Oct 2026 09:13:35 -0400
X-MC-Unique: JZDKrbBfOS6BoxhK62Whug-1
X-Mimecast-MFC-AGG-ID: JZDKrbBfOS6BoxhK62Whug_1793279613
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C23DC180065C; Thu, 29 Oct 2026 13:13:33 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 464123000723; Thu, 29 Oct 2026 13:13:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 17/28] hw/misc: mark pvpanic, vmcoreinfo as secure
Date: Thu, 29 Oct 2026 13:12:30 +0000
Message-ID: <20261029131241.2275706-18-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.56.0


