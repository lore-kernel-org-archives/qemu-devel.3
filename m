Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0E3C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Yw-0000yZ-Bn; Tue, 22 Sep 2026 16:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97Xg-0000Na-2S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97Xe-00047y-DA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790110601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e74AjzVYAvqbY//GzxliaSnz/JXsu67MDAvHJ55yQ7k=;
 b=bwx1oq05u1yhEmI2ItqfOo/4PIyMZ5e5lfldZZq/lK4U55PR7R96P7i4gB21+iDcKtwZRj
 jha+PGHp3hi/m110uPl/AuiJ8e6kLvIVbJLp2QW0O09sSb7AbjkYdEKipccxNmDqIJKaXG
 28H9GC9ysW5Q0qzZYsTat9PoZR0uNMQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-d3KusHAeOIe10K8ZPyMs-w-1; Tue,
 22 Sep 2026 16:56:38 -0400
X-MC-Unique: d3KusHAeOIe10K8ZPyMs-w-1
X-Mimecast-MFC-AGG-ID: d3KusHAeOIe10K8ZPyMs-w_1790110596
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41035195DE23; Tue, 22 Sep 2026 20:56:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 254FB1956086; Tue, 22 Sep 2026 20:56:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 6/8] qapi: split intros for qga/qapi-schema.json
Date: Tue, 22 Sep 2026 16:56:03 -0400
Message-ID: <20260922205605.501602-7-jsnow@redhat.com>
In-Reply-To: <20260922205605.501602-1-jsnow@redhat.com>
References: <20260922205605.501602-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

These intro section conversions all create a new insertion point that
follow the introduction, but precede what now constitutes the details
text. Like other intro section conversions, the details text will be
moved en-masse in a later patch.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qga/qapi-schema.json | 61 +++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 19b0958b84e..05fe4ea484d 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -48,9 +48,8 @@
 
 ##
 # @guest-sync-delimited:
-#
-# Echo back a unique integer value, and prepend to response a leading
-# sentinel byte (0xFF) the client can check scan for.
+#     Echo back a unique integer value, and prepend to response a
+#     leading sentinel byte (0xFF) the client can check scan for.
 #
 # This is used by clients talking to the guest agent over the wire to
 # ensure the stream is in sync and doesn't contain stale data from
@@ -83,8 +82,7 @@
 
 ##
 # @guest-sync:
-#
-# Echo back a unique integer value
+#     Echo back a unique integer value
 #
 # This is used by clients talking to the guest agent over the wire to
 # ensure the stream is in sync and doesn't contain stale data from
@@ -140,8 +138,7 @@
 
 ##
 # @guest-set-time:
-#
-# Set guest time.
+#     Set guest time.
 #
 # When a guest is paused or migrated to a file then loaded from that
 # file, the guest OS has no idea that there was a big gap in the time.
@@ -415,14 +412,14 @@
 
 ##
 # @guest-fsfreeze-freeze:
+#     Sync and freeze all freezable, local guest filesystems.  If this
+#     command succeeded, you may call `guest-fsfreeze-thaw` later to
+#     unfreeze.
 #
-# Sync and freeze all freezable, local guest filesystems.  If this
-# command succeeded, you may call `guest-fsfreeze-thaw` later to
-# unfreeze.
-#
-# On error, all filesystems will be thawed.  If no filesystems are
-# frozen as a result of this call, then `guest-fsfreeze-status` will
-# remain "thawed" and calling `guest-fsfreeze-thaw` is not necessary.
+#     On error, all filesystems will be thawed.  If no filesystems are
+#     frozen as a result of this call, then `guest-fsfreeze-status`
+#     will remain "thawed" and calling `guest-fsfreeze-thaw` is not
+#     necessary.
 #
 # Returns: Number of file systems currently frozen.
 #
@@ -438,11 +435,10 @@
 
 ##
 # @guest-fsfreeze-freeze-list:
+#     Sync and freeze specified guest filesystems.  See also
+#     `guest-fsfreeze-freeze`.
 #
-# Sync and freeze specified guest filesystems.  See also
-# `guest-fsfreeze-freeze`.
-#
-# On error, all filesystems will be thawed.
+#     On error, all filesystems will be thawed.
 #
 # @mountpoints: an array of mountpoints of filesystems to be frozen.
 #     If omitted, every mounted filesystem is frozen.  Invalid mount
@@ -528,8 +524,7 @@
 
 ##
 # @guest-suspend-disk:
-#
-# Suspend guest to disk.
+#     Suspend guest to disk.
 #
 # This command attempts to suspend the guest using three strategies,
 # in this order:
@@ -558,8 +553,7 @@
 
 ##
 # @guest-suspend-ram:
-#
-# Suspend guest to ram.
+#     Suspend guest to ram.
 #
 # This command attempts to suspend the guest using three strategies,
 # in this order:
@@ -595,8 +589,7 @@
 
 ##
 # @guest-suspend-hybrid:
-#
-# Save guest state to disk and suspend to ram.
+#     Save guest state to disk and suspend to ram.
 #
 # This command attempts to suspend the guest by executing, in this
 # order:
@@ -746,10 +739,9 @@
 
 ##
 # @guest-get-vcpus:
+#     Retrieve the list of the guest's logical processors.
 #
-# Retrieve the list of the guest's logical processors.
-#
-# This is a read-only operation.
+#     This is a read-only operation.
 #
 # Returns: The list of all VCPUs the guest knows about.  Each VCPU is
 #     put on the list exactly once, but their order is unspecified.
@@ -1106,10 +1098,9 @@
 
 ##
 # @guest-get-memory-blocks:
+#     Retrieve the list of the guest's memory blocks.
 #
-# Retrieve the list of the guest's memory blocks.
-#
-# This is a read-only operation.
+#     This is a read-only operation.
 #
 # Returns: The list of all memory blocks the guest knows about.  Each
 #     memory block is put on the list exactly once, but their order is
@@ -1346,12 +1337,12 @@
 
 ##
 # @guest-get-host-name:
+#     Return a name for the machine.
 #
-# Return a name for the machine.
-#
-# The returned name is not necessarily a fully-qualified domain name,
-# or even present in DNS or some other name service at all.  It need
-# not even be unique on your local network or site, but usually it is.
+#     The returned name is not necessarily a fully-qualified domain
+#     name, or even present in DNS or some other name service at all.
+#     It need not even be unique on your local network or site, but
+#     usually it is.
 #
 # Returns: the host name of the machine
 #
-- 
2.55.0


