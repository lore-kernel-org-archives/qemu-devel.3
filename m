Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74389C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdwR-0006N2-CY; Thu, 30 May 2024 07:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwP-0006Lu-TZ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwK-0003cL-Uz
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717068444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bp3NLg4mJW6CGazd17f+zK4QsMU0vLkfWwofjE4kNU4=;
 b=iSa3YQnru3bXrM5IVCUmddwTWZ7wqdiUHcZhy7adcTgHNgeg97KTqSzlg3cN5wuI3hN2kk
 T9KRayDS+YNVg9NODDHS7VljHrYJzZ3jvTaq52pEs5OlwFa8M4QcWw19/l2GY1TRGPqjaY
 2JlVHDThvOGEg7jn95vLeFPzK1fYiTs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-iysZqDT0PiSbvaQCCNJsww-1; Thu,
 30 May 2024 07:27:22 -0400
X-MC-Unique: iysZqDT0PiSbvaQCCNJsww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5761029AA381;
 Thu, 30 May 2024 11:27:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F36AB103A3AA;
 Thu, 30 May 2024 11:27:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7118018009A8; Thu, 30 May 2024 13:27:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/4] usb/hub: deprecate, don't build by default
Date: Thu, 30 May 2024 13:27:16 +0200
Message-ID: <20240530112718.1752905-4-kraxel@redhat.com>
In-Reply-To: <20240530112718.1752905-1-kraxel@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

The hub supports only USB 1.1.  When running out of usb ports it is in
almost all cases the much better choice to add another usb host adapter
(or increase the number of root ports when using xhci) instead of using
the usb hub.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-hub.c | 1 +
 hw/usb/Kconfig   | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 06e9537d0356..68444d39534f 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -686,6 +686,7 @@ static void usb_hub_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "hub";
     dc->vmsd = &vmstate_usb_hub;
+    klass->deprecation_note = "use more root ports or additional hostadapters instead";
     device_class_set_props(dc, usb_hub_properties);
 }
 
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 84bc7fbe36cd..b583f5c25d05 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -67,7 +67,6 @@ config TUSB6010
 
 config USB_HUB
     bool
-    default y
     depends on USB
 
 config USB_HID
-- 
2.45.1


