Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8033BF30930
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6L6-0004wC-Uy; Thu, 05 Mar 2026 05:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6L3-0004mH-FT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6L1-0005n7-9Z
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772708030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZS5GEbGChHfsF72+DUHakymxE4PqwSLiq+7AF0ynGI=;
 b=DSUG+NH8QqMkwUbTShsZbqny4fmTEYSzi1tDyCpN5lMOe4fYVF8jWk38FCVPr2/bggQsGT
 Ra58kqjkpdY06DobAGRHWMTWdEtIBdZIdJyrFm0Vm9X7iVhDthmCUtzYNcLvmESzOthzux
 jC+8qsh/kAZV3OwDxX/aLsL13TJQiBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-_Ii9oJJNMIuOrBalDCrl5A-1; Thu,
 05 Mar 2026 05:53:49 -0500
X-MC-Unique: _Ii9oJJNMIuOrBalDCrl5A-1
X-Mimecast-MFC-AGG-ID: _Ii9oJJNMIuOrBalDCrl5A_1772708028
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B3E6195609D; Thu,  5 Mar 2026 10:53:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A4A43003E98; Thu,  5 Mar 2026 10:53:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/28] hw/display/vga-pci: Do not expose the 'global-vmstate'
 property
Date: Thu,  5 Mar 2026 11:52:15 +0100
Message-ID: <20260305105215.302571-29-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The "global-vmstate" property is 'false' by default, and was only
set to 'true' in the hw_compat_2_12[] array. We removed all machines
using that array. Stop exposing that property on the PCI devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501230129.2596-11-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/cirrus_vga.c | 2 --
 hw/display/qxl.c        | 1 -
 hw/display/vga-pci.c    | 1 -
 hw/display/vmware_vga.c | 2 --
 4 files changed, 6 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 37228ff1345..629b34fc68d 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2987,8 +2987,6 @@ static const Property pci_vga_cirrus_properties[] = {
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
                      cirrus_vga.enable_blitter, true),
-    DEFINE_PROP_BOOL("global-vmstate", struct PCICirrusVGAState,
-                     cirrus_vga.vga.global_vmstate, false),
 };
 
 static void cirrus_vga_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 0551b38230b..3d4b5635568 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2476,7 +2476,6 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_UINT16("max_outputs", PCIQXLDevice, max_outputs, 0),
         DEFINE_PROP_UINT32("xres", PCIQXLDevice, xres, 0),
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
-        DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmstate, false),
 };
 
 static void qxl_pci_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index d0f9de1ab35..4e68dd57a17 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -338,7 +338,6 @@ static const Property vga_pci_properties[] = {
     DEFINE_PROP_BIT("edid",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
     DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
-    DEFINE_PROP_BOOL("global-vmstate", PCIVGAState, vga.global_vmstate, false),
 };
 
 static const Property secondary_pci_properties[] = {
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index ea7a9fca04e..c2c6bc76e90 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1335,8 +1335,6 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
 static const Property vga_vmware_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct pci_vmsvga_state_s,
                        chip.vga.vram_size_mb, 16),
-    DEFINE_PROP_BOOL("global-vmstate", struct pci_vmsvga_state_s,
-                     chip.vga.global_vmstate, false),
 };
 
 static void vmsvga_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


