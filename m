Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF79606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J78N/l6M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT567-0004Is-41; Mon, 16 Nov 2026 17:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55p-0003vX-7L
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55n-00061z-8T
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794867745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQWrbyN03NrE6RccAdvjuCyfjQ0cnSkZs096XP3OYoc=;
 b=J78N/l6MOWnHn41qm3DBsdUztkacxwLtMEKRgiqy1k47EliS8ffvE/hPzGEUsEs6v3TjFW
 DPRCdK56ZlhyViumIJrdb5TYX9xdwfRMrutssic2dJAmhUGDixrspFUY4SMzS4/UBzrPCc
 UStTcjiP6Ddjo7W2IgcZpPsPhL53x10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-FtPRAdtqOy2fjzDoLgO4Rw-1; Mon,
 16 Nov 2026 17:22:24 -0500
X-MC-Unique: FtPRAdtqOy2fjzDoLgO4Rw-1
X-Mimecast-MFC-AGG-ID: FtPRAdtqOy2fjzDoLgO4Rw_1794867743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96D901800378
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:22:23 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A891D30001A2; Mon, 16 Nov 2026 22:22:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 15/26] hw/display: mark bochs, ramfb and VGA as secure
Date: Mon, 16 Nov 2026 22:21:47 +0000
Message-ID: <20261116222158.2840471-16-berrange@redhat.com>
In-Reply-To: <20261116222158.2840471-1-berrange@redhat.com>
References: <20261116222158.2840471-1-berrange@redhat.com>
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

Most of the display adapters are emulating old hardware which is not
relevant to virtualization use cases.

The clear exceptions are the generic, simple devices that should be
considered secure: Bochs, RAMFB, VGA (PCI, not MMIO / ISA).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/bochs-display.c    | 1 +
 hw/display/ramfb-standalone.c | 1 +
 hw/display/vga-pci.c          | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 64e669429c4..5f3ba80f990 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -374,6 +374,7 @@ static const TypeInfo bochs_display_type_info = {
     .instance_size  = sizeof(BochsDisplayState),
     .instance_init  = bochs_display_init,
     .class_init     = bochs_display_class_init,
+    .secure         = true,
     .interfaces     = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 8e8ba37514a..9427009acc8 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -85,6 +85,7 @@ static const TypeInfo ramfb_info = {
     .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(RAMFBStandaloneState),
     .class_init    = ramfb_class_initfn,
+    .secure        = true,
 };
 
 static void ramfb_register_types(void)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index d089847bdae..8559d7aa8f0 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -407,6 +407,7 @@ static const TypeInfo vga_info = {
     .name          = "VGA",
     .parent        = TYPE_PCI_VGA,
     .class_init    = vga_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo secondary_info = {
@@ -414,6 +415,7 @@ static const TypeInfo secondary_info = {
     .parent        = TYPE_PCI_VGA,
     .instance_init = pci_secondary_vga_init,
     .class_init    = secondary_class_init,
+    .secure        = true,
 };
 
 static void vga_register_types(void)
-- 
2.56.1


