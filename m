Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B88CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrlx-0001wM-H9; Wed, 30 Sep 2026 06:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj3-0001ec-3J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrip-0006rx-F8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2WxEy9r9W2fp3krLlN89JvXlw0WspjbK1BrbNbfJ4E=;
 b=b5en1upaDH+gKeK1IpS5q6viEuZl6AnOlr1RLnhkqy7daij6FANAB/ObLTtWQ2uDSpEQ7j
 ies07+ANPCCeLCgKO/hvJNOLuNbKOCEyGJsPBfuSX8e1jWJ0NMgAAdlZS8zJQ+aQvVtDyr
 PUgG/LKnw3gM0+afGJ4+u3hF4x5ROGs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-48BXOIj0OrevrOMbu364Mw-1; Wed,
 30 Sep 2026 06:39:31 -0400
X-MC-Unique: 48BXOIj0OrevrOMbu364Mw-1
X-Mimecast-MFC-AGG-ID: 48BXOIj0OrevrOMbu364Mw_1790764770
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81098195F152; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3971630001BE; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3207A21E64D3; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 098/105] qapi: convert/split intros for block commands
Date: Wed, 30 Sep 2026 12:39:03 +0200
Message-ID: <20260930103910.3934848-99-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: John Snow <jsnow@redhat.com>

Convert, or split off, intro sections for commands defined in
block.json and block-export.json. This does not currently impact the
way these commands are rendered, except:

1. blockdev-open-tray and blockdev-close-tray see their opening
   paragraphs split apart, which is reflected in the rendered output,
   and

2. block_set_io_throttle and nbd-server-add see their argument
   definitions move up to just below the formalized introductory
   section.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260928192557.509157-4-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-export.json |  3 +--
 qapi/block.json        | 33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index e9f7e72c8e..77459f6321 100644
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
index 53f0a623af..0a88d405a2 100644
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


