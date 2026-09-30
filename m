Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BBCCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrm8-0002DR-TN; Wed, 30 Sep 2026 06:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001cs-Ay
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006qr-RR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OmpqVS/2WY4LnX2gDcxI58J4RW8IRGuDtXwLT2ry4s=;
 b=OyL6QpeoXvx2xzVhJF/EFcaUCage49o8M7ZlPyq8QxXTrJeHVwqgLz/on/N1XB2lIHlPzH
 vKpvJHAhQirlsTbq6ok5Cpv0aJ12cMPw1P18IfJVJcM7kc4Y7FzUS/FyeqdFy3F/Fdt4GK
 qOKSpz2tzXTV28UcbhSWpfHJKes9K5g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-sq_ciqrYNG6NUdgVvjQg2g-1; Wed,
 30 Sep 2026 06:39:29 -0400
X-MC-Unique: sq_ciqrYNG6NUdgVvjQg2g-1
X-Mimecast-MFC-AGG-ID: sq_ciqrYNG6NUdgVvjQg2g_1790764768
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 252041801361; Wed, 30 Sep 2026 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3B9330001BE; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0926D21E6567; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 088/105] qapi: convert/split remaining qapi/qmp intro sections
Date: Wed, 30 Sep 2026 12:38:53 +0200
Message-ID: <20260930103910.3934848-89-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

A few slipped in during the mass conversion, get those too. Mostly
trivial conversion, with the exception of @x-qemu-io which introduces
a new split.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260922205605.501602-2-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block.json         |  5 +++--
 qapi/machine-s390x.json |  3 +--
 qapi/machine.json       |  3 +--
 qapi/net.json           | 24 ++++++++----------------
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index bb222da3e2..53f0a623af 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -598,9 +598,10 @@
 
 ##
 # @x-qemu-io:
+#     Run a qemu-io command on a block device.
 #
-# Run a qemu-io command on a block device.  Take either a block
-# backend name or a qdev ID to identify the device.
+# Take either a block backend name or a qdev ID to identify the
+# device.
 #
 # @device: the block backend name, node-name to run the
 #     command on.
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index dcbad9b403..05716fe247 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -139,8 +139,7 @@
 
 ##
 # @BootCertificates:
-#
-# Boot certificates for secure IPL.
+#     Boot certificates for secure IPL.
 #
 # @path: path to an X.509 certificate file or a directory containing
 #      certificate files.
diff --git a/qapi/machine.json b/qapi/machine.json
index da26be9ea2..89e7acdc1a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1402,8 +1402,7 @@
 
 ##
 # @SpMemDeviceInfo:
-#
-# sp-mem device state information
+#     sp-mem device state information
 #
 # @id: device's ID
 #
diff --git a/qapi/net.json b/qapi/net.json
index d0bacb4dcf..81d1ab1c2f 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1280,8 +1280,7 @@
 
 ##
 # @UsernetInfo:
-#
-# Information about a user-mode network stack (slirp).
+#     Information about a user-mode network stack (slirp).
 #
 # @hub-id: The hub id, if available.
 #
@@ -1300,8 +1299,7 @@
 
 ##
 # @x-query-usernet:
-#
-# Query user-mode network stack connection states.
+#     Query user-mode network stack connection states.
 #
 # Features:
 #
@@ -1324,8 +1322,7 @@
 
 ##
 # @NetFilterInfo:
-#
-# Information about a netfilter attached to a network client.
+#     Information about a netfilter attached to a network client.
 #
 # @name: filter object name (QOM path component)
 #
@@ -1344,8 +1341,7 @@
 
 ##
 # @NetworkClientInfo:
-#
-# Information about a network client.
+#     Information about a network client.
 #
 # @name: unique network client identifier
 #
@@ -1374,8 +1370,7 @@
 
 ##
 # @NetHubPortInfo:
-#
-# Information about a hub port.
+#     Information about a hub port.
 #
 # @name: hub port identifier
 #
@@ -1390,8 +1385,7 @@
 
 ##
 # @NetHubInfo:
-#
-# Information about a network hub.
+#     Information about a network hub.
 #
 # @id: hub identifier
 #
@@ -1406,8 +1400,7 @@
 
 ##
 # @NetworkInfo:
-#
-# Information about the network configuration.
+#     Information about the network configuration.
 #
 # @hubs: network hubs and their ports
 #
@@ -1422,8 +1415,7 @@
 
 ##
 # @x-query-network:
-#
-# Query the network configuration including hubs and clients.
+#     Query the network configuration including hubs and clients.
 #
 # Features:
 #
-- 
2.55.0


