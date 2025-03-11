Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD1C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzUI-0007t3-W0; Tue, 11 Mar 2025 09:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trzUD-0007oO-Q9
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trzUB-0003Ti-Q1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2kiww0yvo5e1hJ6zykfCHYUfWvttW0QdbQwBaLaOwII=;
 b=N3HUfdS3ozvNJFDn6ze7WPG3NUP+zERbx/wAIH8Zc27a6te2DG7AM5Z68igdNRZI8b2+r1
 igICvu/ZIGZKsC7d4VM71Oko7b8SLlj1nKf+zx7Dhrc1EOxkuD2H0IGvG8QjLe97zNPOkf
 czmEKeQabSw7euJqQKEf1Q9zow20p40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-4HLArxLqMs2ZiLcBV3fbRA-1; Tue,
 11 Mar 2025 09:17:22 -0400
X-MC-Unique: 4HLArxLqMs2ZiLcBV3fbRA-1
X-Mimecast-MFC-AGG-ID: 4HLArxLqMs2ZiLcBV3fbRA_1741699041
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A24951800265; Tue, 11 Mar 2025 13:17:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E893F1800268; Tue, 11 Mar 2025 13:17:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C3BF21E66C1; Tue, 11 Mar 2025 14:17:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: wencongyang2@huawei.com, zhanghailiang@xfusion.com,
 arei.gonglei@huawei.com, xiechanglong.d@gmail.com, hreitz@redhat.com,
 berto@igalia.com, kwolf@redhat.com
Subject: [PATCH] qapi/block-core: Improve x-blockdev-change documentation
Date: Tue, 11 Mar 2025 14:17:15 +0100
Message-ID: <20250311131715.1296101-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The description of feature @unstable is three paragraphs.  The second
and third became part of the description by accident in commit
9fb49daabfb (qapi: Mark unstable QMP parts with feature 'unstable').

The second paragraph describes a defect in terms of the
implementation.  Fine, but doesn't belong into user-facing
documentation.  Turn it into a TODO section.

Rewrite everything else for clarity and completeness.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ee6eccc68c..b1937780e1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5913,35 +5913,31 @@
 ##
 # @x-blockdev-change:
 #
-# Dynamically reconfigure the block driver state graph.  It can be
-# used to add, remove, insert or replace a graph node.  Currently only
-# the Quorum driver implements this feature to add or remove its
-# child.  This is useful to fix a broken quorum child.
+# Dynamically reconfigure the block driver state graph.
 #
-# If @node is specified, it will be inserted under @parent.  @child
-# may not be specified in this case.  If both @parent and @child are
-# specified but @node is not, @child will be detached from @parent.
+# Currently only supports adding and deleting quorum children.  A
+# child will be added at the end of the list of children.  Its
+# contents *must* be consistent with the other childrens' contents.
+# Deleting a child that is not last in the list of children is
+# problematic, because it "renumbers" the children following it.
 #
 # @parent: the id or name of the parent node.
 #
-# @child: the name of a child under the given parent node.
+# @child: the name of a child to be deleted.  Mutually exclusive with
+#     @node.
 #
-# @node: the name of the node that will be added.
+# @node: the name of the node to be added.  Mutually exclusive with
+#     @child.
 #
 # Features:
 #
-# @unstable: This command is experimental, and its API is not stable.
-#     It does not support all kinds of operations, all kinds of
-#     children, nor all block drivers.
+# @unstable: This command is experimental.
 #
-#     FIXME Removing children from a quorum node means introducing
+# TODO: Removing children from a quorum node means introducing
 #     gaps in the child indices.  This cannot be represented in the
 #     'children' list of BlockdevOptionsQuorum, as returned by
 #     .bdrv_refresh_filename().
 #
-#     Warning: The data in a new quorum child MUST be consistent with
-#     that of the rest of the array.
-#
 # Since: 2.7
 #
 # .. qmp-example::
-- 
2.48.1


