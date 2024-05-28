Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7F8C27C44
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtYB-0008Dk-Hy; Tue, 28 May 2024 05:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtY9-0008CT-IM
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtXw-0001Rh-FI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716890106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSUR6yJIh5CLY06QkHtdoSOCrvKSmrrUkKorZXrTtpo=;
 b=NFlZ4WsUqbivWL4oiXUyzX9K91bWOb3Chk4l4u7Fq3Dk79whBW0R3coEz9GcoKVpiXOwpx
 4of7cAiFwx1XAa2EFRMjnFhBfNwC5Tn8CoCT61E2eaooF9HchZ+CCFvW9qKWKudTbc7HOY
 4EurRCgoaN09FXe4mbFv7CYgjYTpNLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-flxc865FPlaNGVNk2IECuw-1; Tue, 28 May 2024 05:55:03 -0400
X-MC-Unique: flxc865FPlaNGVNk2IECuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 770C081227E;
 Tue, 28 May 2024 09:55:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FBB41C00A8E;
 Tue, 28 May 2024 09:55:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0DDA11800DEB; Tue, 28 May 2024 11:55:00 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/4] usb/ohci-pci: deprecate, don't build by default
Date: Tue, 28 May 2024 11:54:58 +0200
Message-ID: <20240528095459.896594-4-kraxel@redhat.com>
In-Reply-To: <20240528095459.896594-1-kraxel@redhat.com>
References: <20240528095459.896594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

The xhci host adapter is the much better choice.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci-pci.c | 1 +
 hw/usb/Kconfig        | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 33ed9b6f5a52..88de657def71 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -143,6 +143,7 @@ static void ohci_pci_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     dc->vmsd = &vmstate_ohci;
     dc->reset = usb_ohci_reset_pci;
+    klass->deprecation_note = "use qemu-xhci instead";
 }
 
 static const TypeInfo ohci_pci_info = {
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 84bc7fbe36cd..c4a6ea5a687f 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -17,7 +17,6 @@ config USB_OHCI_SYSBUS
 
 config USB_OHCI_PCI
     bool
-    default y if PCI_DEVICES
     depends on PCI
     select USB_OHCI
 
-- 
2.45.1


