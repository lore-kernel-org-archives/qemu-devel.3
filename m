Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FC0C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKpz-0004iN-R2; Mon, 14 Jul 2025 11:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUo-0000Pp-E7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUa-0003dg-KL
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zGpGrJTmtA+mx5uAEeZZATBJAWFYIT7QHHlExSm1UA=;
 b=KRp8otAC5doDHeRuZ9WX0m2IDeJDhW53tWoZi+bJDkMzHeDHpA0wlTjZpMXawmMk5jRmix
 Xwcfx60dxt2/XS+XR+UPM2Bv+CeOI/XLUnny8ya1aqDLAs9O9gNPEbBj4r6WNIuhs9IHLK
 iodpBGRYRcpmsXMOaYMGAwtjOa5WeZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-kMgZ6lk7Mx-mR0lC5Xwerg-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: kMgZ6lk7Mx-mR0lC5Xwerg-1
X-Mimecast-MFC-AGG-ID: kMgZ6lk7Mx-mR0lC5Xwerg_1752500709
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0A8219560B8; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F25430001B5; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30CC221E61A2; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, John Snow <jsnow@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 28/32] qapi: add cross-references to yank.json
Date: Mon, 14 Jul 2025 15:44:54 +0200
Message-ID: <20250714134458.2991097-29-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Acked-by: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20250711054005.60969-18-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/yank.json | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index c14de5229e..f3cd5c15d6 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -11,7 +11,7 @@
 ##
 # @YankInstanceType:
 #
-# An enumeration of yank instance types.  See @YankInstance for more
+# An enumeration of yank instance types.  See `YankInstance` for more
 # information.
 #
 # Since: 6.0
@@ -22,7 +22,7 @@
 ##
 # @YankInstanceBlockNode:
 #
-# Specifies which block graph node to yank.  See @YankInstance for
+# Specifies which block graph node to yank.  See `YankInstance` for
 # more information.
 #
 # @node-name: the name of the block graph node
@@ -35,7 +35,7 @@
 ##
 # @YankInstanceChardev:
 #
-# Specifies which character device to yank.  See @YankInstance for
+# Specifies which character device to yank.  See `YankInstance` for
 # more information.
 #
 # @id: the chardev's ID
@@ -48,7 +48,7 @@
 ##
 # @YankInstance:
 #
-# A yank instance can be yanked with the @yank qmp command to recover
+# A yank instance can be yanked with the `yank` qmp command to recover
 # from a hanging QEMU.
 #
 # @type: yank instance type
@@ -59,9 +59,9 @@
 #   nbd server without attempting to reconnect.
 # - socket chardev: Yanking it will shut down the connected socket.
 # - migration: Yanking it will shut down all migration connections.
-#   Unlike @migrate_cancel, it will not notify the migration process,
+#   Unlike `migrate_cancel`, it will not notify the migration process,
 #   so migration will go into @failed state, instead of @cancelled
-#   state.  @yank should be used to recover from hangs.
+#   state.  `yank` should be used to recover from hangs.
 #
 # Since: 6.0
 ##
@@ -76,7 +76,7 @@
 # @yank:
 #
 # Try to recover from hanging QEMU by yanking the specified instances.
-# See @YankInstance for more information.
+# See `YankInstance` for more information.
 #
 # @instances: the instances to be yanked
 #
@@ -102,7 +102,7 @@
 ##
 # @query-yank:
 #
-# Query yank instances.  See @YankInstance for more information.
+# Query yank instances.  See `YankInstance` for more information.
 #
 # TODO: This line is a hack to separate the example from the body
 #
-- 
2.49.0


