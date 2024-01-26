Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6AEC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 06:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTFhB-0005LE-BD; Fri, 26 Jan 2024 01:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgz-0005Cb-Ar
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgv-0001lj-8W
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706250472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySQDf5g9/v0nPnqbT6JK80hLcsPNam4RWz2L61QyP7M=;
 b=XGQ8PIcydo9pRVM5QbU5v0qmKD0nOlQYj0hp4Fq+wR/8qCsAxf7g3CyhK9CfCwUIcKOGIT
 MFlvrnvgDKl7KCnzqqRKn43WfaPTn20T+/JGeQykoru68Tkyq9mkoBzY4IbXIv4bsyAofe
 dMvkTribqq81ALHPrNN3BvKXlgI9g6E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-TKwtHDiIN7K_idxUrUT-KA-1; Fri,
 26 Jan 2024 01:27:47 -0500
X-MC-Unique: TKwtHDiIN7K_idxUrUT-KA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 397113C13A90;
 Fri, 26 Jan 2024 06:27:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17BE61121313;
 Fri, 26 Jan 2024 06:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C54D521E64CD; Fri, 26 Jan 2024 07:27:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 6/8] qapi: Fix mangled "Returns" sections in documentation
Date: Fri, 26 Jan 2024 07:27:42 +0100
Message-ID: <20240126062744.265588-7-armbru@redhat.com>
In-Reply-To: <20240126062744.265588-1-armbru@redhat.com>
References: <20240126062744.265588-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

Commit e050e426782e (qapi: Use explicit bulleted lists) added list
markup to correct bad rendering:

    A JSON block comment like this:
         Returns: nothing on success
                  If @node is not a valid block device, DeviceNotFound
                  If @name is not found, GenericError with an explanation

    renders like this:

         Returns: nothing on success If node is not a valid block device,
         DeviceNotFound If name is not found, GenericError with an explanation

    because whitespace is not significant.

    Use an actual bulleted list, so that the formatting is correct.

It missed a few instances.  Commit a937b6aa739 (qapi: Reformat doc
comments to conform to current conventions) then reflowed them.

Revert the reflowing, and add list markup.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240120095327.666239-6-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/net.json  | 15 +++++++++------
 qapi/qdev.json |  5 +++--
 qapi/qom.json  | 10 ++++++----
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 8095b68fa8..68493d6ac9 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -18,8 +18,9 @@
 #
 # @up: true to set the link status to be up
 #
-# Returns: Nothing on success If @name is not a valid network device,
-#     DeviceNotFound
+# Returns:
+#     - Nothing on success
+#     - If @name is not a valid network device, DeviceNotFound
 #
 # Since: 0.14
 #
@@ -44,8 +45,9 @@
 #
 # Since: 0.14
 #
-# Returns: Nothing on success If @type is not a valid network backend,
-#     DeviceNotFound
+# Returns:
+#     - Nothing on success
+#     - If @type is not a valid network backend, DeviceNotFound
 #
 # Example:
 #
@@ -64,8 +66,9 @@
 #
 # @id: the name of the network backend to remove
 #
-# Returns: Nothing on success If @id is not a valid network backend,
-#     DeviceNotFound
+# Returns:
+#     - Nothing on success
+#     - If @id is not a valid network backend, DeviceNotFound
 #
 # Since: 0.14
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 6bc5a733b8..25bac5e611 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -89,8 +89,9 @@
 #
 # @id: the device's ID or QOM path
 #
-# Returns: Nothing on success If @id is not a valid device,
-#     DeviceNotFound
+# Returns:
+#     - Nothing on success
+#     - If @id is not a valid device, DeviceNotFound
 #
 # Notes: When this command completes, the device may not be removed
 #     from the guest.  Hot removal is an operation that requires guest
diff --git a/qapi/qom.json b/qapi/qom.json
index 95516ba325..84af23fe24 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1056,8 +1056,9 @@
 #
 # Create a QOM object.
 #
-# Returns: Nothing on success Error if @qom-type is not a valid class
-#     name
+# Returns:
+#     - Nothing on success
+#     - Error if @qom-type is not a valid class name
 #
 # Since: 2.0
 #
@@ -1078,8 +1079,9 @@
 #
 # @id: the name of the QOM object to remove
 #
-# Returns: Nothing on success Error if @id is not a valid id for a QOM
-#     object
+# Returns:
+#     - Nothing on success
+#     - Error if @id is not a valid id for a QOM object
 #
 # Since: 2.0
 #
-- 
2.43.0


