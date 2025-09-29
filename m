Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D189CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 08:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v38rA-0004sD-SC; Mon, 29 Sep 2025 04:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v38pm-0004dl-RQ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:02:13 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v38pS-0002ci-NE
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1759132885; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=35YsRLIzqfWT6Rz5F7DY1fnB12isAT2RdCstv+znKAk=;
 b=KRHsfbANFApeFVcyYZitXQrHbTg9d8qqR8RKyWGwjTQU0OSEgiaS5i6jqc4bVSsygJ+iAy37m1EbofkqLDrhoQIIUYui7X5itUBt3wI7ENpIMOXz8+MNHmnXzBsSBTe+vTPEuk6CptrVjUeV86rvbQAQsTfC61h9q60jeAB0zTo=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0Wp0tOIt_1759132876 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 29 Sep 2025 16:01:24 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH] migration: Use QAPI_CLONE() instead of duplicating it inline
Date: Mon, 29 Sep 2025 16:01:15 +0800
Message-Id: <20250929080115.98072-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=guobin@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
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

It's better to use QAPI_CLONE() in qmp_query_migrate_parameters so that
the code is cleaner.

No functional changes intended.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/options.c | 70 ++-------------------------------------------
 1 file changed, 3 insertions(+), 67 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 4e923a2e07..347d762b03 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -892,81 +892,16 @@ AnnounceParameters *migrate_announce_params(void)
 
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
-    MigrationParameters *params;
     MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
-    params = g_malloc0(sizeof(*params));
-    params->has_throttle_trigger_threshold = true;
-    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
-    params->has_cpu_throttle_initial = true;
-    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
-    params->has_cpu_throttle_increment = true;
-    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->has_cpu_throttle_tailslow = true;
-    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = g_strdup(s->parameters.tls_creds);
-    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
-    params->tls_authz = g_strdup(s->parameters.tls_authz ?
-                                 s->parameters.tls_authz : "");
-    params->has_max_bandwidth = true;
-    params->max_bandwidth = s->parameters.max_bandwidth;
-    params->has_avail_switchover_bandwidth = true;
-    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
-    params->has_downtime_limit = true;
-    params->downtime_limit = s->parameters.downtime_limit;
-    params->has_x_checkpoint_delay = true;
-    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->has_multifd_channels = true;
-    params->multifd_channels = s->parameters.multifd_channels;
-    params->has_multifd_compression = true;
-    params->multifd_compression = s->parameters.multifd_compression;
-    params->has_multifd_zlib_level = true;
-    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
-    params->has_multifd_qatzip_level = true;
-    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
-    params->has_multifd_zstd_level = true;
-    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
-    params->has_xbzrle_cache_size = true;
-    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
-    params->has_max_postcopy_bandwidth = true;
-    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
-    params->has_max_cpu_throttle = true;
-    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
-    params->has_announce_initial = true;
-    params->announce_initial = s->parameters.announce_initial;
-    params->has_announce_max = true;
-    params->announce_max = s->parameters.announce_max;
-    params->has_announce_rounds = true;
-    params->announce_rounds = s->parameters.announce_rounds;
-    params->has_announce_step = true;
-    params->announce_step = s->parameters.announce_step;
-
-    if (s->parameters.has_block_bitmap_mapping) {
-        params->has_block_bitmap_mapping = true;
-        params->block_bitmap_mapping =
-            QAPI_CLONE(BitmapMigrationNodeAliasList,
-                       s->parameters.block_bitmap_mapping);
-    }
-
-    params->has_x_vcpu_dirty_limit_period = true;
-    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-    params->has_vcpu_dirty_limit = true;
-    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
-    params->has_mode = true;
-    params->mode = s->parameters.mode;
-    params->has_zero_page_detection = true;
-    params->zero_page_detection = s->parameters.zero_page_detection;
-    params->has_direct_io = true;
-    params->direct_io = s->parameters.direct_io;
-
-    return params;
+    return QAPI_CLONE(MigrationParameters, &s->parameters);
 }
 
 void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->tls_authz = g_strdup("");
 
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
@@ -974,6 +909,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_cpu_throttle_increment = true;
     params->has_cpu_throttle_tailslow = true;
     params->has_max_bandwidth = true;
+    params->has_avail_switchover_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
     params->has_multifd_channels = true;
-- 
2.39.5


