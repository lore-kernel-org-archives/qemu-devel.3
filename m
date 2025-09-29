Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6515ACAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 02:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v33OO-0006W1-RN; Sun, 28 Sep 2025 22:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v33OM-0006Vk-Pa
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 22:13:30 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v33OE-00086c-3R
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 22:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1759111966; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=YpZ6QTtY2ONFyTvNCUQktFU2agNq/BqFPPoFBaDXkTA=;
 b=KxHkqjqYm1hIitSDpOE/zxHfiaAaEPS0sw0UH8A/6FAToHO5B8uPMXxEbGimInonyRyuewDClabgjQkPFT5hQA/M9KqCYGzVmXi4JqlEq/x/JZf+Ht7Q/roXcesr6dTJXGrqS6uovEsGDIoIAGAN5do7NTQ+UuaCSTfsPKLh79c=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0WozyWq2_1759111933 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 29 Sep 2025 10:12:45 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH] migration: HMP: Adjust the order of output fields
Date: Mon, 29 Sep 2025 10:12:13 +0800
Message-Id: <20250929021213.28369-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Adjust the positions of 'tls-authz' and 'max-postcopy-bandwidth' in
the fields output by the 'info migrate_parameters' command so that
related fields are next to each other.

For clarity only, no functional changes.

Sample output after this commit:
(qemu) info migrate_parameters
...
max-cpu-throttle: 99
tls-creds: ''
tls-hostname: ''
tls-authz: ''
max-bandwidth: 134217728 bytes/second
avail-switchover-bandwidth: 0 bytes/second
max-postcopy-bandwidth: 0 bytes/second
downtime-limit: 300 ms
...

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/migration-hmp-cmds.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0fc21f0647..814221b260 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -353,6 +353,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
             params->tls_hostname);
+        assert(params->tls_authz);
+        monitor_printf(mon, "%s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
+            params->tls_authz);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
@@ -361,6 +365,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
             params->avail_switchover_bandwidth);
+        assert(params->has_max_postcopy_bandwidth);
+        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
+            params->max_postcopy_bandwidth);
         assert(params->has_downtime_limit);
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
@@ -383,12 +391,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
-        monitor_printf(mon, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
-            params->max_postcopy_bandwidth);
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->tls_authz);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
-- 
2.39.5


