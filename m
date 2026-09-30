Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3F4CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkP-0005Zj-Aq; Wed, 30 Sep 2026 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriy-0001Yi-2L
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrim-0006pn-Rd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fE9nRnE3SyUMzXWM1lzs4VkhYcVJkHMpKSnDhjmSYyE=;
 b=FNZ1aXBRllYl23KLTZohezihQlAjgr1HyIrGcZfxSR51VuBPw9Iq0KvnuTu/bQpQ5/8rPF
 rBYaX4CDt/ooWfkCCRmd8cwtWuD8rhZ303m5/trbWm2f8L871KS1Ntkd3XWWkJew+2v0lu
 jGLdUyFqlZLskc7jCiUTXej5HDnGy/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-4KQIYoAEPD6xpLD12KUgEw-1; Wed,
 30 Sep 2026 06:39:30 -0400
X-MC-Unique: 4KQIYoAEPD6xpLD12KUgEw-1
X-Mimecast-MFC-AGG-ID: 4KQIYoAEPD6xpLD12KUgEw_1790764769
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7497A1955BD6; Wed, 30 Sep 2026 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE43F76D; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D71421E6574; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 093/105] qapi: split intros for qga/qapi-schema.json
Date: Wed, 30 Sep 2026 12:38:58 +0200
Message-ID: <20260930103910.3934848-94-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

These intro section conversions all create a new insertion point that
follow the introduction, but precede what now constitutes the details
text. Like other intro section conversions, the details text will be
moved en-masse in a later patch.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260922205605.501602-7-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 61 +++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 19b0958b84..05fe4ea484 100644
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


