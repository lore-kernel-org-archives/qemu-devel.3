Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9437CC531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlQf-00038P-HI; Thu, 23 Jul 2026 00:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlQO-0002vr-2P
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlQL-0004jM-SR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784782365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvnZrfXGzB4HFIplW/5U/ErhFdiu8ZVe2fFge+4xFIc=;
 b=YBFZryQ/7f8WBFb+SgYeYmeVHjEaNHmeF9DUw5nULXxUBlWqhV0/qAHIA62hWSQtkOPLfX
 z9A4rVMQJzFmgjfl3njJPY7pMrXvl5EwWnSDFiNZtH5lV3e4pOBESifB8oXWqHiLNhwQHB
 WS2kI6tEn5w0fO74OlOKXKMFiABShpo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-wd4iwakjORKRG7QDMyIIYw-1; Thu,
 23 Jul 2026 00:52:41 -0400
X-MC-Unique: wd4iwakjORKRG7QDMyIIYw-1
X-Mimecast-MFC-AGG-ID: wd4iwakjORKRG7QDMyIIYw_1784782359
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D070D190C40C; Thu, 23 Jul 2026 04:52:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C3AB18002B6; Thu, 23 Jul 2026 04:52:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 26/44] qapi: convert intro sections for pci.json
Date: Thu, 23 Jul 2026 00:47:47 -0400
Message-ID: <20260723044805.527643-27-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/pci.json | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/qapi/pci.json b/qapi/pci.json
index 694c741e420..a6a79f91afc 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -13,8 +13,7 @@
 
 ##
 # @PciMemoryRange:
-#
-# A PCI device memory region
+#     A PCI device memory region
 #
 # @base: the starting address (guest physical)
 #
@@ -26,8 +25,7 @@
 
 ##
 # @PciMemoryRegion:
-#
-# Information about a PCI device I/O region.
+#     Information about a PCI device I/O region.
 #
 # @bar: the index of the Base Address Register for this region
 #
@@ -51,8 +49,7 @@
 
 ##
 # @PciBusInfo:
-#
-# Information about a bus of a PCI Bridge device
+#     Information about a bus of a PCI Bridge device
 #
 # @number: primary bus interface number.  This should be the number of
 #     the bus the device resides on.
@@ -80,8 +77,7 @@
 
 ##
 # @PciBridgeInfo:
-#
-# Information about a PCI Bridge device
+#     Information about a PCI Bridge device
 #
 # @bus: information about the bus the device resides on
 #
@@ -94,8 +90,7 @@
 
 ##
 # @PciDeviceClass:
-#
-# Information about the Class of a PCI device
+#     Information about the Class of a PCI device
 #
 # @desc: a string description of the device's class (not stable, and
 #     should only be treated as informational)
@@ -109,8 +104,7 @@
 
 ##
 # @PciDeviceId:
-#
-# Information about the Id of a PCI device
+#     Information about the Id of a PCI device
 #
 # @device: the PCI device id
 #
@@ -128,8 +122,7 @@
 
 ##
 # @PciDeviceInfo:
-#
-# Information about a PCI device
+#     Information about a PCI device
 #
 # @bus: the bus number of the device
 #
@@ -161,8 +154,7 @@
 
 ##
 # @PciInfo:
-#
-# Information about a PCI bus
+#     Information about a PCI bus
 #
 # @bus: the bus index
 #
@@ -174,8 +166,7 @@
 
 ##
 # @query-pci:
-#
-# Return information about the PCI bus topology of the guest.
+#     Return information about the PCI bus topology of the guest.
 #
 # Returns: a list of info for each PCI bus.  Each bus is
 #     represented by a json-object, which has a key with a json-array
-- 
2.55.0


