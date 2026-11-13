Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BEA606A89B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CIV0ylmI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFi-0007ef-Rh; Fri, 13 Nov 2026 13:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFG-0007Ig-6n
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFC-0005Pg-TY
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4ZD7xYNBwqWrvlwlE06AH+xSVkUJoPB2zEmQLM7JkM=;
 b=CIV0ylmIGGL9dCiJUpkmwQZTAQ+eCKz/94y0hW39M42lwDSjrkNqUs2nGuTOl19F7yGZba
 zgbvEoX7y5KsJK4/Jozq2IrIP+cIRORlNK5/2g25EzWYavBUh8RmNkVBYgUpwsnAcf4UEs
 dncG24gAt4nroSjOS9FX1aLbzvIQQPI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-_Qu4fF2bPk6IbNeNiIxahw-1; Fri,
 13 Nov 2026 13:43:23 -0500
X-MC-Unique: _Qu4fF2bPk6IbNeNiIxahw-1
X-Mimecast-MFC-AGG-ID: _Qu4fF2bPk6IbNeNiIxahw_1794595400
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A0C91955F10
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:20 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFB2019634E9; Fri, 13 Nov 2026 18:43:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 12/26] hw/ide: mark ICH9 and ide-hd/ide-cd as secure
Date: Fri, 13 Nov 2026 18:42:40 +0000
Message-ID: <20261113184254.2524253-13-berrange@redhat.com>
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

These have a long history of usage in virtualization scenarios on
x86, for OS which lack modern virtio drivers for storage, and thus
must be considered secure.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/ide/ich.c     | 1 +
 hw/ide/ide-dev.c | 2 ++
 hw/ide/piix.c    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b00987f08d4..c7d50a15c1a 100644
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
index 94b91478928..3e9ca6e340f 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -215,6 +215,7 @@ static const TypeInfo ide_hd_info = {
     .parent        = TYPE_IDE_DEVICE,
     .instance_size = sizeof(IDEDrive),
     .class_init    = ide_hd_class_init,
+    .secure        = true,
 };
 
 static const Property ide_cd_properties[] = {
@@ -237,6 +238,7 @@ static const TypeInfo ide_cd_info = {
     .parent        = TYPE_IDE_DEVICE,
     .instance_size = sizeof(IDEDrive),
     .class_init    = ide_cd_class_init,
+    .secure        = true,
 };
 
 static void ide_device_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a8472f3e581..9b7b5e98c8c 100644
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
2.56.1


