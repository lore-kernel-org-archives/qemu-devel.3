Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E15C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdwT-0006OR-Ix; Thu, 30 May 2024 07:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwP-0006Lv-Tp
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwN-0003fH-SC
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717068447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7uIuKWn4SHAdlR3t/cPDp5v3iQEMcXdr2vtmVBXePk=;
 b=IQBvvNMPv3Nk1noL+CDgLRKwMXI5Q+dz/ecYbX78GBpv4zl4jSgWbTSquQ/auxeq61bIdQ
 uiAL/C2qvPiTM0ucvlYTTDhMpMdNpq17vbbabVAEDojmhQW+MtyTb1i0yJw72T1+1uRTCw
 9ApdJzgbML41xg/M3W31DYr7tS4zaQw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-n--zxzSuPDOVVs3_i0Vx-w-1; Thu, 30 May 2024 07:27:24 -0400
X-MC-Unique: n--zxzSuPDOVVs3_i0Vx-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF99E812296;
 Thu, 30 May 2024 11:27:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CA062026D68;
 Thu, 30 May 2024 11:27:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 83D8D18009B8; Thu, 30 May 2024 13:27:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
Date: Thu, 30 May 2024 13:27:17 +0200
Message-ID: <20240530112718.1752905-5-kraxel@redhat.com>
In-Reply-To: <20240530112718.1752905-1-kraxel@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

stdvga is the much better option.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c     | 1 +
 hw/display/cirrus_vga_isa.c | 1 +
 hw/display/Kconfig          | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 150883a97166..81421be1f89d 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_cirrus_vga;
     device_class_set_props(dc, pci_vga_cirrus_properties);
     dc->hotpluggable = false;
+    klass->deprecation_note = "use stdvga instead";
 }
 
 static const TypeInfo cirrus_vga_info = {
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 84be51670ed8..3abbf4dddd90 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->realize = isa_cirrus_vga_realizefn;
     device_class_set_props(dc, isa_cirrus_vga_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    klass->deprecation_note = "use stdvga instead";
 }
 
 static const TypeInfo isa_cirrus_vga_info = {
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index a4552c8ed78d..cd0779396890 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -11,7 +11,6 @@ config FW_CFG_DMA
 
 config VGA_CIRRUS
     bool
-    default y if PCI_DEVICES
     depends on PCI
     select VGA
 
-- 
2.45.1


