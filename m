Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84732C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJWP-0003pE-P1; Wed, 26 Aug 2026 15:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWI-0003da-2v
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWG-0006Wa-9Z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpkdvipcmAcBa2auSG3J8F5gVm+aKl/kzxuPFWdZfzg=;
 b=YoircPL9DlSE+p4xGBYaefPYHwdhYodJDBZiARChXhe6N0BhQFepna0hwmxS1ceSctUJPQ
 yn8mpvS1AjTdxIWVFWp42sY0HjKVZqMTokVP+4kq7BLQDg1LTxP09Eb9e1W7pwqgZ2ayt2
 PTqp3FwmfaFOzsMhQm8wAZaXJQcvf4M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-9lU4g2X8NkqLcH-6lngtuw-1; Wed,
 26 Aug 2026 15:42:38 -0400
X-MC-Unique: 9lU4g2X8NkqLcH-6lngtuw-1
X-Mimecast-MFC-AGG-ID: 9lU4g2X8NkqLcH-6lngtuw_1787773352
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9382919540D7; Wed, 26 Aug 2026 19:42:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B9A81800577; Wed, 26 Aug 2026 19:42:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 25/43] qapi: convert trivial intro sections for pci.json
Date: Wed, 26 Aug 2026 15:38:22 -0400
Message-ID: <20260826193840.2152000-26-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


