Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8CAC35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20L-0006KI-Js; Fri, 14 Mar 2025 06:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20B-0006I5-Mt
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt208-00021v-C4
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DM5gO/mHUWf4r2tQdDbJnbbTizjhichNpsmghIv8zE=;
 b=T9eJ4SIQHP6zu2DYbD+aeaVRTH7BwPoC9eHeXvPCM1z0LmJAPQYRw7ZuAqzuk8Tl/SjEwS
 3HPb3TQsXjod8tV7j4inBxaxoUPz36//HNyRqR7NnIOSfUlihNq9awx51soxzAvFhk8KZ3
 KdDjZsQ95gmOZ1/Yv10KOFeqTQdPSCA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-WKNsrGDkMpKaTVJU0JLGFA-1; Fri,
 14 Mar 2025 06:10:46 -0400
X-MC-Unique: WKNsrGDkMpKaTVJU0JLGFA-1
X-Mimecast-MFC-AGG-ID: WKNsrGDkMpKaTVJU0JLGFA_1741947045
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21F1419560B6; Fri, 14 Mar 2025 10:10:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BE7918001DE; Fri, 14 Mar 2025 10:10:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9A0521E669B; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Alberto Garcia <berto@igalia.com>
Subject: [PULL 01/12] qapi/block-core: Improve x-blockdev-change documentation
Date: Fri, 14 Mar 2025 11:10:27 +0100
Message-ID: <20250314101038.2408751-2-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The description of feature @unstable is three paragraphs.  The second
and third became part of the description by accident in commit
9fb49daabfb (qapi: Mark unstable QMP parts with feature 'unstable').

The second paragraph describes a defect in terms of the
implementation.  Fine, but doesn't belong into user-facing
documentation.  Turn it into a TODO section.

Rewrite everything else for clarity and completeness.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250311131715.1296101-1-armbru@redhat.com>
Acked-by: Alberto Garcia <berto@igalia.com>
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


