Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A8ACA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGzV-0003ge-JW; Mon, 28 Sep 2026 15:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzT-0003gB-KR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzR-00034t-Of
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790623576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cD0t//bNODY+/iMm3VJoVYoc25lQvoobQuE2w++IqZA=;
 b=WKbTmA9xEiJtUE3bQ/XMRJxmLTaMV8r+EdzRmUOvDGRmzZmT2HLrvHzVSFRjGnJWaGFx9f
 s9ugRcwOYC1JX7P0t6vpZr1nRTi6wfBwUDY0Fw+eL1Pm4Sx8SkbbwQh8wWSN8lUhZRRiXY
 UQgGLYTwPfEHwwC3sWLT1WDw9X2mJzI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-7-rytmdIM6mpkKTveGsjVg-1; Mon,
 28 Sep 2026 15:26:15 -0400
X-MC-Unique: 7-rytmdIM6mpkKTveGsjVg-1
X-Mimecast-MFC-AGG-ID: 7-rytmdIM6mpkKTveGsjVg_1790623573
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 566851800BDB; Mon, 28 Sep 2026 19:26:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 471B5768; Mon, 28 Sep 2026 19:26:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 03/10] qapi: convert/split intros for block commands
Date: Mon, 28 Sep 2026 15:25:50 -0400
Message-ID: <20260928192557.509157-4-jsnow@redhat.com>
In-Reply-To: <20260928192557.509157-1-jsnow@redhat.com>
References: <20260928192557.509157-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert, or split off, intro sections for commands defined in
block.json and block-export.json. In general, this does not currently
impact the way these commands are rendered, except:

1. blockdev-open-tray and blockdev-close-tray see their opening
   paragraphs split apart, which is reflected in the rendered output,
   and

2. block_set_io_throttle and nbd-server-add see their argument
   definitions move up to just below the formalized introductory
   section.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json |  3 +--
 qapi/block.json        | 33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index e9f7e72c8ee..77459f6321b 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -235,8 +235,7 @@
 
 ##
 # @nbd-server-add:
-#
-# Export a block node to QEMU's embedded NBD server.
+#     Export a block node to QEMU's embedded NBD server.
 #
 # The export name will be used as the id for the resulting block
 # export.
diff --git a/qapi/block.json b/qapi/block.json
index 53f0a623afa..0a88d405a26 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -128,11 +128,12 @@
 
 ##
 # @blockdev-open-tray:
+#     Opens a block device's tray.
 #
-# Opens a block device's tray.  If there is a block driver state tree
-# inserted as a medium, it will become inaccessible to the guest (but
-# it will remain associated to the block device, so closing the tray
-# will make it accessible again).
+# If there is a block driver state tree inserted as a medium, it will
+# become inaccessible to the guest (but it will remain associated to
+# the block device, so closing the tray will make it accessible
+# again).
 #
 # If the tray was already open before, this will be a no-op.
 #
@@ -181,10 +182,11 @@
 
 ##
 # @blockdev-close-tray:
+#     Closes a block device's tray.
 #
-# Closes a block device's tray.  If there is a block driver state tree
-# associated with the block device (which is currently ejected), that
-# tree will be loaded as the medium.
+# If there is a block driver state tree associated with the block
+# device (which is currently ejected), that tree will be loaded as the
+# medium.
 #
 # If the tray was already closed before, this will be a no-op.
 #
@@ -218,13 +220,12 @@
 
 ##
 # @blockdev-remove-medium:
+#     Removes a medium (a block driver state tree) from a block
+#     device.  That block device's tray must currently be open
+#     (unless there is no attached guest device).
 #
-# Removes a medium (a block driver state tree) from a block device.
-# That block device's tray must currently be open (unless there is no
-# attached guest device).
-#
-# If the tray is open and there is no medium inserted, this will be a
-# no-op.
+# If the tray is open and there is no medium inserted, this will
+# be a no-op.
 #
 # @id: The name or QOM path of the guest device
 #
@@ -429,8 +430,7 @@
 
 ##
 # @block_set_io_throttle:
-#
-# Change I/O throttle limits for a block drive.
+#     Change I/O throttle limits for a block drive.
 #
 # Since QEMU 2.4, each device with I/O limits is member of a throttle
 # group.
@@ -504,8 +504,7 @@
 
 ##
 # @block-latency-histogram-set:
-#
-# Manage read, write and flush latency histograms for the device.
+#     Manage read, write and flush latency histograms for the device.
 #
 # If only @id parameter is specified, remove all present latency
 # histograms for the device.  Otherwise, add/reset some of (or all)
-- 
2.55.0


