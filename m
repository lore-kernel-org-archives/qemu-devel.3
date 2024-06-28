Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCF0C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9ly-0001vz-Kn; Fri, 28 Jun 2024 07:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sN9lw-0001vT-Kn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sN9ls-0000tg-Le
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719574083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N5XBEASOX2lBEMucV6etf6OdUwdUen5IBmNa7sQaWRA=;
 b=OeQwBzX/n8rId9BfzMi8F43W9cfI6qAUy6CniA6sgbnjuQkOYQyqWUM1GIAuE40fctUo6l
 OhgtYjE1X+7uws+bx11nDlV+8vInWE/sEbsmPFjEOXMGyNKY3sHPmHRy8h04WxWs5SJoj/
 hLyTGjDbX6pQBEjCxbVqry5t9nKOYnI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-nCj9Ngj2MN-KIBgAZYwouA-1; Fri,
 28 Jun 2024 07:28:01 -0400
X-MC-Unique: nCj9Ngj2MN-KIBgAZYwouA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE4F196CDE1; Fri, 28 Jun 2024 11:27:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E95219560B2; Fri, 28 Jun 2024 11:27:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08E4621E5A5E; Fri, 28 Jun 2024 13:27:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, michael.roth@amd.com,
 qemu-stable@nongnu.org
Subject: [PATCH] sphinx/qapidoc: Fix to generate doc for explicit,
 unboxed arguments
Date: Fri, 28 Jun 2024 13:27:56 +0200
Message-ID: <20240628112756.794237-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a command's arguments are specified as an explicit type T,
generated documentation points to the members of T.

Example:

    ##
    # @announce-self:
    #
    # Trigger generation of broadcast RARP frames to update network
    [...]
    ##
    { 'command': 'announce-self', 'boxed': true,
      'data' : 'AnnounceParameters'}

generates

    "announce-self" (Command)
    -------------------------

    Trigger generation of broadcast RARP frames to update network
    [...]

    Arguments
    ~~~~~~~~~

    The members of "AnnounceParameters"

Except when the command takes its arguments unboxed , i.e. it doesn't
have 'boxed': true, we generate *nothing*.  A few commands have a
reference in their doc comment to compensate, but most don't.

Example:

    ##
    # @blockdev-snapshot-sync:
    #
    # Takes a synchronous snapshot of a block device.
    #
    # For the arguments, see the documentation of BlockdevSnapshotSync.
    [...]
    ##
    { 'command': 'blockdev-snapshot-sync',
      'data': 'BlockdevSnapshotSync',
      'allow-preconfig': true }

generates

    "blockdev-snapshot-sync" (Command)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Takes a synchronous snapshot of a block device.

    For the arguments, see the documentation of BlockdevSnapshotSync.
    [...]

Same for event data.

Fix qapidoc.py to generate the reference regardless of boxing.  Delete
now redundant references in the doc comments.

Fixes: 4078ee5469e5 (docs/sphinx: Add new qapi-doc Sphinx extension)
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 12 +++++-------
 qapi/block-core.json   |  7 -------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f270b494f0..aacb2cd721 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -219,15 +219,15 @@ def _nodes_for_enum_values(self, doc):
         section += dlnode
         return [section]
 
-    def _nodes_for_arguments(self, doc, boxed_arg_type):
+    def _nodes_for_arguments(self, doc, arg_type):
         """Return list of doctree nodes for the arguments section"""
-        if boxed_arg_type:
+        if arg_type and not arg_type.is_implicit():
             assert not doc.args
             section = self._make_section('Arguments')
             dlnode = nodes.definition_list()
             dlnode += self._make_dlitem(
                 [nodes.Text('The members of '),
-                 nodes.literal('', boxed_arg_type.name)],
+                 nodes.literal('', arg_type.name)],
                 None)
             section += dlnode
             return [section]
@@ -332,8 +332,7 @@ def visit_command(self, name, info, ifcond, features, arg_type,
                       allow_preconfig, coroutine):
         doc = self._cur_doc
         self._add_doc('Command',
-                      self._nodes_for_arguments(doc,
-                                                arg_type if boxed else None)
+                      self._nodes_for_arguments(doc, arg_type)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
                       + self._nodes_for_if_section(ifcond))
@@ -341,8 +340,7 @@ def visit_command(self, name, info, ifcond, features, arg_type,
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         doc = self._cur_doc
         self._add_doc('Event',
-                      self._nodes_for_arguments(doc,
-                                                arg_type if boxed else None)
+                      self._nodes_for_arguments(doc, arg_type)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
                       + self._nodes_for_if_section(ifcond))
diff --git a/qapi/block-core.json b/qapi/block-core.json
index df5e07debd..c5cb0c5d56 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1675,8 +1675,6 @@
 #
 # Takes a synchronous snapshot of a block device.
 #
-# For the arguments, see the documentation of BlockdevSnapshotSync.
-#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
@@ -1705,8 +1703,6 @@
 # device, the block device changes to using 'overlay' as its new
 # active image.
 #
-# For the arguments, see the documentation of BlockdevSnapshot.
-#
 # Features:
 #
 # @allow-write-only-overlay: If present, the check whether this
@@ -6065,9 +6061,6 @@
 # string, or a snapshot with name already exists, the operation will
 # fail.
 #
-# For the arguments, see the documentation of
-# BlockdevSnapshotInternal.
-#
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #     - If any snapshot matching @name exists, or @name is empty,
-- 
2.45.0


