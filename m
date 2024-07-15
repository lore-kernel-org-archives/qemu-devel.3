Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD477C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 07:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGQW-00054w-8q; Mon, 15 Jul 2024 03:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTGQT-0004uJ-4Z; Mon, 15 Jul 2024 03:47:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTGQR-0007kP-DG; Mon, 15 Jul 2024 03:47:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 010737A4F0;
 Mon, 15 Jul 2024 10:47:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 25B94108BA8;
 Mon, 15 Jul 2024 10:47:01 +0300 (MSK)
Received: (nullmailer pid 567680 invoked by uid 1000);
 Mon, 15 Jul 2024 07:47:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.6 22/23] sphinx/qapidoc: Fix to generate doc for explicit,
 unboxed arguments
Date: Mon, 15 Jul 2024 10:46:58 +0300
Message-Id: <20240715074700.567643-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.6-20240715074957@cover.tls.msk.ru>
References: <qemu-stable-8.2.6-20240715074957@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Markus Armbruster <armbru@redhat.com>

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
Message-ID: <20240628112756.794237-1-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
(cherry picked from commit e389929d19a543ea5b34d02553b355f9f1c03162)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixups in qapi/block-core.json due to missing
 v8.2.0-1951-g2746f060be18 "qapi: Move error documentation to new "Errors" sections"
 v8.2.0-1952-g53d5c36d8de3 "qapi: Delete useless "Returns" sections")

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 658c288f8f..3d19853444 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -229,15 +229,15 @@ def _nodes_for_enum_values(self, doc):
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
@@ -341,8 +341,7 @@ def visit_command(self, name, info, ifcond, features, arg_type,
                       allow_preconfig, coroutine):
         doc = self._cur_doc
         self._add_doc('Command',
-                      self._nodes_for_arguments(doc,
-                                                arg_type if boxed else None)
+                      self._nodes_for_arguments(doc, arg_type)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
                       + self._nodes_for_if_section(ifcond))
@@ -350,8 +349,7 @@ def visit_command(self, name, info, ifcond, features, arg_type,
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
index ca390c5700..36f527882d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1660,8 +1660,6 @@
 #
 # Takes a synchronous snapshot of a block device.
 #
-# For the arguments, see the documentation of BlockdevSnapshotSync.
-#
 # Returns:
 #     - nothing on success
 #     - If @device is not a valid block device, DeviceNotFound
@@ -1691,8 +1689,6 @@
 # device, the block device changes to using 'overlay' as its new
 # active image.
 #
-# For the arguments, see the documentation of BlockdevSnapshot.
-#
 # Features:
 #
 # @allow-write-only-overlay: If present, the check whether this
@@ -6029,9 +6025,6 @@
 # string, or a snapshot with name already exists, the operation will
 # fail.
 #
-# For the arguments, see the documentation of
-# BlockdevSnapshotInternal.
-#
 # Returns:
 #     - nothing on success
 #     - If @device is not a valid block device, GenericError
-- 
2.39.2


