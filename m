Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85CCAC5AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 00:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqi9M-0000A3-1X; Tue, 17 Sep 2024 20:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9G-0008UE-AV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:23 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9D-0006Np-Kd
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=gWSsjX1LZaUqlQr3wzl8g0MVhTupUsNLSrpZVJHlMmI=; b=Em7lRfOfqvKhsYBK
 82I6Fdn0J8E9dz1YpW8JdQlOTZD3PCPVFe+02PzMPSFWSqtNr3iplQal9FEKtnT+cb1RdF9Igbxj6
 k12jzOizp6Y85XrzmR2pzs7zevOhy8jBK70l1nNNqJD4YWo+VKiPx2CVHTEqAf50ZX1xgBRWh+GCi
 JzdIG0zhFa4vOosFhiYpWZVD9jRG7Zvr450zI/en2iqdiD5ZbCPA9H0A0+9eBEG5b1tjGxBB3sA+F
 u3DMaocBMokaPAuUVLliiVachFb7jKgWWayeR+B02Q4ZF8jQ9rlTx4Oqyfw4Lt6AWDD8tBT2Yqrz7
 3lkPxISoAbpxZkdkcw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqi9B-006Dj5-03;
 Wed, 18 Sep 2024 00:02:17 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 2/3] migration: Remove unused zero-blocks capability
Date: Wed, 18 Sep 2024 01:02:06 +0100
Message-ID: <20240918000207.182683-3-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918000207.182683-1-dave@treblig.org>
References: <20240918000207.182683-1-dave@treblig.org>
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

migrate_zero_blocks is unused since
  eef0bae3a7 ("migration: Remove block migration")

Remove it.
That whole zero-blocks capability was just for old-school
block migration anyway.

Remove the capability as well.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 migration/options.c |  8 --------
 migration/options.h |  1 -
 qapi/migration.json | 10 +---------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 9460c5dee9..997e060612 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -177,7 +177,6 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
     DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
     DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
-    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
     DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
     DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
     DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
@@ -339,13 +338,6 @@ bool migrate_xbzrle(void)
     return s->capabilities[MIGRATION_CAPABILITY_XBZRLE];
 }
 
-bool migrate_zero_blocks(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->capabilities[MIGRATION_CAPABILITY_ZERO_BLOCKS];
-}
-
 bool migrate_zero_copy_send(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 36e7b3723f..79084eed0d 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -40,7 +40,6 @@ bool migrate_release_ram(void);
 bool migrate_return_path(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
-bool migrate_zero_blocks(void);
 bool migrate_zero_copy_send(void);
 
 /*
diff --git a/qapi/migration.json b/qapi/migration.json
index b66cccf107..82d0fc962e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -389,13 +389,6 @@
 #     footprint is mlock()'d on demand or all at once.  Refer to
 #     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
 #
-# @zero-blocks: During storage migration encode blocks of zeroes
-#     efficiently.  This essentially saves 1MB of zeroes per block on
-#     the wire.  Enabling requires source and target VM to support
-#     this feature.  To enable it is sufficient to enable the
-#     capability on the source VM.  The feature is disabled by
-#     default.  (since 1.6)
-#
 # @events: generate events for each migration state change (since 2.4)
 #
 # @auto-converge: If enabled, QEMU will automatically throttle down
@@ -483,7 +476,7 @@
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
-  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
+  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
@@ -542,7 +535,6 @@
 #           {"state": false, "capability": "xbzrle"},
 #           {"state": false, "capability": "rdma-pin-all"},
 #           {"state": false, "capability": "auto-converge"},
-#           {"state": false, "capability": "zero-blocks"},
 #           {"state": true, "capability": "events"},
 #           {"state": false, "capability": "postcopy-ram"},
 #           {"state": false, "capability": "x-colo"}
-- 
2.46.0


