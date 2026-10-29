Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8C606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FTzimTfY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPyw-00021G-1G; Thu, 29 Oct 2026 09:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwg-00081A-8q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwd-0006H2-0X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wy+ZDp5dzDVZ6sxRIGeq9UYQIQZUvhG9hVA2dStB+54=;
 b=FTzimTfYhtHUegDbLopSBFNCPOMHY4ZqJWNSGf2IA2NgE1Gjt6julWxyPQIauVgcY7XMUz
 IFjrEn+/7PfNU7DCKJhKEm7DBx5yCByA1rhW4N1d6DH+WaANeIOqnNqHOxa1z+8+6Kw02B
 yAREIYddv05ds4F/bqSFKhUMUrcN1SQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-leAb_tA9MMedaIjMLUwlGA-1; Thu,
 29 Oct 2026 09:13:20 -0400
X-MC-Unique: leAb_tA9MMedaIjMLUwlGA-1
X-Mimecast-MFC-AGG-ID: leAb_tA9MMedaIjMLUwlGA_1793279599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6435C180065D; Thu, 29 Oct 2026 13:13:19 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 117473000B7A; Thu, 29 Oct 2026 13:13:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 12/28] hw/ide: mark ICH9 and ide-hd/ide-cd as secure
Date: Thu, 29 Oct 2026 13:12:25 +0000
Message-ID: <20261029131241.2275706-13-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These have a long history of usage in virtualization scenarios on
x86, for OS which lack modern virtio drivers for storage, and thus
must be considered secure.

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
index 5d478588c61..da7b6aa5bcc 100644
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
2.56.0


