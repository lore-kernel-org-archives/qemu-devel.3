Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE472CF3941
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHUk-00086I-6c; Thu, 19 Sep 2024 09:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUg-0007qG-Bw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:50 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUQ-0005zr-UV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=l4UyVNwJ4yMa4BuDM6CsK36HOowHp3U5Yt7uEmfutOk=; b=rNny+XlTXCax2NqA
 gfjwzh442GvmLcUjFCtnnDmU8KU/rCFg1dddE07Q2OZB55/mJeQbL6ePWKR0RB8wetjJjHkqvYbFW
 TU16MJvJtAhsOHHEQEKl2MPeM8q2TnY+9McRCB2DwDsGmM6dakPp46aO2zMMDIDpAhKs6b/Pc8nG8
 6wxOfYwL1w8xTjUlbQ+JyFvpB9O7a/h4wiKu+oPkC3Va+vSpD818xhA5CtsExa6Y8ngiWlPLQ0JMG
 hWJutBqOI8u0uAtrIgH6iy8C34weoARaQJUd7StEzqTp8VT/EofDUbNTEGHbJz0iFBwdP17dPPfr/
 OMIv0JG10UVAWD9Frw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srHUM-006QOJ-0B;
 Thu, 19 Sep 2024 13:46:30 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] migration: Deprecate zero-blocks capability
Date: Thu, 19 Sep 2024 14:46:22 +0100
Message-ID: <20240919134626.166183-4-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919134626.166183-1-dave@treblig.org>
References: <20240919134626.166183-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The zero-blocks capability was meant to be used along with the block
migration, which has been removed already in commit eef0bae3a7
("migration: Remove block migration").

Setting zero-blocks is currently a noop, but the outright removal of
the capability would cause and error in case some users are still
setting it. Put the capability through the deprecation process.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst | 6 ++++++
 migration/options.c       | 4 ++++
 qapi/migration.json       | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ed31d4b0b2..47cabb6fcc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -476,3 +476,9 @@ usage of providing a file descriptor to a plain file has been
 deprecated in favor of explicitly using the ``file:`` URI with the
 file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
 command documentation for details on the ``fdset`` usage.
+
+``zero-blocks`` capability (since 9.2)
+''''''''''''''''''''''''''''''''''''''
+
+The ``zero-blocks`` capability was part of the block migration which
+doesn't exist anymore since it was removed in QEMU v9.1.
diff --git a/migration/options.c b/migration/options.c
index 6f549984cb..ad8d6989a8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -450,6 +450,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
+        warn_report("zero-blocks capability is deprecated");
+    }
+
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
diff --git a/qapi/migration.json b/qapi/migration.json
index b66cccf107..3af6aa1740 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -479,11 +479,14 @@
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
+# @deprecated: Member @zero-blocks is deprecated as being part of
+#     block migration which was already removed.
 #
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
-  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
+  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
+           { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
-- 
2.46.1


