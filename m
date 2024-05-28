Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62492C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtY8-0008CD-SI; Tue, 28 May 2024 05:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtY7-0008Bt-Sm
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtXv-0001Rf-TH
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716890106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFTCmUFTq0etV9FkONdvPeX/q8fDJcblUNNL6MpibeY=;
 b=MMNFU/smj8uo1A5y5p9MWraxea7WcojCeH3xko0dS6N2NWBrEfd5EfXRwI/CtetjMJ5gjm
 FNk4nid7MNqyt3GkcFONw/lLbh+l6uSAga5gGW0x6Yz4fILOcuUuvRQJWB+OxynmbOPz+M
 JiHODrCP+5oeE6uhFELmkwk/Sq8v4mY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-yqYPJChMNLa2NlmKynpSsg-1; Tue, 28 May 2024 05:55:03 -0400
X-MC-Unique: yqYPJChMNLa2NlmKynpSsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 949D7101A525;
 Tue, 28 May 2024 09:55:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EF6FC15BB9;
 Tue, 28 May 2024 09:55:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EDC2C1800DDA; Tue, 28 May 2024 11:54:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] usb: add config options for the hub and hid devices
Date: Tue, 28 May 2024 11:54:57 +0200
Message-ID: <20240528095459.896594-3-kraxel@redhat.com>
In-Reply-To: <20240528095459.896594-1-kraxel@redhat.com>
References: <20240528095459.896594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/Kconfig     | 10 ++++++++++
 hw/usb/meson.build |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index f569ed7eeaa1..84bc7fbe36cd 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -65,6 +65,16 @@ config TUSB6010
     bool
     select USB_MUSB
 
+config USB_HUB
+    bool
+    default y
+    depends on USB
+
+config USB_HID
+    bool
+    default y
+    depends on USB
+
 config USB_TABLET_WACOM
     bool
     default y
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 23f7f7acb50b..d7de1003e3db 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -35,8 +35,8 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-ctrl-
 system_ss.add(when: 'CONFIG_XLNX_USB_SUBSYS', if_true: files('xlnx-usb-subsystem.c'))
 
 # emulated usb devices
-system_ss.add(when: 'CONFIG_USB', if_true: files('dev-hub.c'))
-system_ss.add(when: 'CONFIG_USB', if_true: files('dev-hid.c'))
+system_ss.add(when: 'CONFIG_USB_HUB', if_true: files('dev-hub.c'))
+system_ss.add(when: 'CONFIG_USB_HID', if_true: files('dev-hid.c'))
 system_ss.add(when: 'CONFIG_USB_TABLET_WACOM', if_true: files('dev-wacom.c'))
 system_ss.add(when: 'CONFIG_USB_STORAGE_CORE', if_true: files('dev-storage.c'))
 system_ss.add(when: 'CONFIG_USB_STORAGE_BOT', if_true: files('dev-storage-bot.c'))
-- 
2.45.1


