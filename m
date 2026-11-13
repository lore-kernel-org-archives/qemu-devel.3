Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB483606A899
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G5CWdq4D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwG3-0000mw-Pm; Fri, 13 Nov 2026 13:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFN-0007Op-1K
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFL-0005RL-D8
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiESeApl72vSgn5W5UPS2Hvo26AwlU5CfcvBPLTlOEw=;
 b=G5CWdq4DwHdcxvG3PC08sEMT2N6mm0402qlxokU+Tz+zHJ4c7XTfdzESndLo26hKK5IFX/
 lNmC4b6DXZoxCr7NGMQHAxJZq5Rh+HJWfj6mCsTEGFFhjfV2CE+M+Sqw34QKp4C90ynyZH
 AMaGPQF208zzjHGYMAEhz+LtCMFrT5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-yaD2vRO5NJ2CJh0uKiWkWw-1; Fri,
 13 Nov 2026 13:43:33 -0500
X-MC-Unique: yaD2vRO5NJ2CJh0uKiWkWw-1
X-Mimecast-MFC-AGG-ID: yaD2vRO5NJ2CJh0uKiWkWw_1794595412
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A4CF180054A
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:32 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF9261955DB9; Fri, 13 Nov 2026 18:43:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 19/26] hw/char: mark common serial / console devices as
 secure
Date: Fri, 13 Nov 2026 18:42:47 +0000
Message-ID: <20261113184254.2524253-20-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These are needed as a baseline feature for many virtualization use
cases on x86, PPC64 and s390x.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com> #sclpconsole(-lm)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/char/debugcon.c       | 1 +
 hw/char/sclpconsole-lm.c | 1 +
 hw/char/sclpconsole.c    | 1 +
 hw/char/serial-isa.c     | 1 +
 hw/char/serial-pci.c     | 1 +
 hw/char/serial.c         | 1 +
 hw/char/spapr_vty.c      | 1 +
 7 files changed, 7 insertions(+)

diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index a1b370b90be..f38ce7b765e 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -134,6 +134,7 @@ static const TypeInfo debugcon_isa_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(ISADebugconState),
     .class_init    = debugcon_isa_class_initfn,
+    .secure        = true,
 };
 
 static void debugcon_register_types(void)
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index f6ed282f1bc..42616527356 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -363,6 +363,7 @@ static const TypeInfo sclp_console_info = {
     .instance_size = sizeof(SCLPConsoleLM),
     .class_init    = console_class_init,
     .class_size    = sizeof(SCLPEventClass),
+    .secure        = true,
 };
 
 static void register_types(void)
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 12033e1e466..b938cc3c677 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -346,6 +346,7 @@ static const TypeInfo sclp_console_info = {
     .instance_size = sizeof(SCLPConsole),
     .class_init    = console_class_init,
     .class_size    = sizeof(SCLPEventClass),
+    .secure        = true,
 };
 
 static void register_types(void)
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index eaa4e843c02..5df87590b73 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -147,6 +147,7 @@ static const TypeInfo serial_isa_info = {
     .instance_size = sizeof(ISASerialState),
     .instance_init = serial_isa_initfn,
     .class_init    = serial_isa_class_initfn,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index d8cacc90859..183091ea41a 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -109,6 +109,7 @@ static const TypeInfo serial_pci_info = {
     .instance_size = sizeof(PCISerialState),
     .instance_init = serial_pci_init,
     .class_init    = serial_pci_class_initfn,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4339562ab00..fefd2cf9fcb 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -984,6 +984,7 @@ static const TypeInfo serial_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(SerialState),
     .class_init = serial_class_init,
+    .secure = true,
 };
 
 static void serial_register_types(void)
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 1dd9fb155cb..96a4e58ad9d 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -201,6 +201,7 @@ static const TypeInfo spapr_vty_info = {
     .parent        = TYPE_VIO_SPAPR_DEVICE,
     .instance_size = sizeof(SpaprVioVty),
     .class_init    = spapr_vty_class_init,
+    .secure        = true,
 };
 
 SpaprVioDevice *spapr_vty_get_default(SpaprVioBus *bus)
-- 
2.56.1


