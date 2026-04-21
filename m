Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D415BF94CAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbT-0001At-Dw; Tue, 21 Apr 2026 16:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbK-000119-6A
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbI-0008TK-AH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X7sRtkFTct671p0HhVn2KGYiMkJ+R0TAaNfCYnI75E=;
 b=d5I0eX0LTfKFCbsPjoYdThmAnpF8gOeMXQdm6meLJqqojtwEjnNr7I+lOz0Ex7F91GPhQ/
 nK/x50FpQooZjJzxkD0LuQheUG8ZDN7iKkdlLsOtzY0jjTXIykElkJabB9ssXEbdPAK8oW
 c12gmosTj/CrnEbqsaB1RVctNlWtfOc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-FI7HZMVxONWS69-7DRJKHA-1; Tue, 21 Apr 2026 16:21:38 -0400
X-MC-Unique: FI7HZMVxONWS69-7DRJKHA-1
X-Mimecast-MFC-AGG-ID: FI7HZMVxONWS69-7DRJKHA_1776802897
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8acdd800537so96006526d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802897; x=1777407697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6X7sRtkFTct671p0HhVn2KGYiMkJ+R0TAaNfCYnI75E=;
 b=iHeF0YMqF8yBcB/orwIE14EfXTl3KCc19SSNi0YAh8gPKqu98JpJO+RmULw+t7HpFI
 eMw2UQkUmEweKa/yyDq5r57xgMdAwrofr0EKVs9kc7FRXN++RBkBKNJ7bijWqo3kSfWw
 Woa7w9uoAntDAGD+Es44wFe2e4XSRM/pCdJS9Vlj3pGroJYszOEwuGfPf4xgHpQ8SPqF
 mpHuFsy/n6Sqk6VCpv3KMVMPHZHTa0KASolAKqP8vcp2EUEPNTyH9xRgVTa5uFRG9N4P
 H2P9oztqPCkXLkUtP7ZPTtkL8gIqjGWp12Gh1nUtcXl/wzJZj8R1K+FBNatHK5Ai8GLb
 9sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802897; x=1777407697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6X7sRtkFTct671p0HhVn2KGYiMkJ+R0TAaNfCYnI75E=;
 b=LovB7Q1BZtyTjyrn4L3QUM5jbI2HqVWcG4hY7SpAmZN8N17ETDVhVLBJlmngJCdZKg
 6SIEICkgAngo08sMsgj+TvFO2rLAgJ1oez/qg+kRdo55FB2kicsJEdFwf2dIjpz6G5dT
 hG3OSzyBoihccZDzsJJadXlaoeHLjDD1sY5pF04+s5IBaXm9fEKTwxTRN4hem4ebuVie
 vYH8ccZsnMgYlpT/TpO3AIeD4kkHPk+qoyxtODP/BrIdFfoQYfeAvKoMEC9WEIh/H8EI
 Bm+zQmiEUqOq5OigGB8U/jj/Zl4v2/Ki+y4KTEaYlXifbmiJbAZlb8w4IrPpsvpAGlL6
 55IA==
X-Gm-Message-State: AOJu0YxkchpjIv7iV9pBB/LB1NCQw6ZYfd7AU7LHtXr5nP+oc7vjyk+o
 VqSH40DBdMrH/fZcExgYAOyVj6Vf5TE3sLBKzcc3S2EFaIaJjAmNNEVMc2cIf4txDZVLSXv6Epm
 eUn3UWqJVnHFdET3TwN1CmvnRpAGid+aJQKssifw4JEdZeuFvCJxlj+SqT59aIN8qvDnesEyhn8
 Dd2nPPDTCTMJKSiLGO/utNTxOdNXOTI1XBJv0P0w==
X-Gm-Gg: AeBDietR6bjGKmCFqb7DcTVxbMH+mm4AcAkoODT+hrhvfbFwHtRXozo6fHOZv/lKvO/
 1ikpdYaFbcVbPYXLDqbhK2PpG7rQLY5vRV1KDYknVhIaFfVVJMXYMzm3fV4ISi4ztHCKYoWLqEa
 Xt97xeVdihW4PTRuW8CwHyiHiihk5CriCH3J13VmVUnf4vQcNT+xW0Z4Wo17ygatcUdMeozGKOt
 kG23jfl8G6Aj2f4inB9cQCFGCwQDSeDwnRJu3BJOwIdx82MhBcKj2f1Lpheu0SltQX3T5ruykG8
 a6MFTedDf9nbLjA3mUJezRk1e3eGv6xKHECf5906b9ztWwPTuka3rI20+1Iqrjna2MbI6+MP9l/
 WohiBWciAWi0xM6EQjnXu3oMS66TW8I77HxOULu9e6kMCaIV032M7EbyKyg==
X-Received: by 2002:a05:6214:f25:b0:8ac:a6c5:c7d1 with SMTP id
 6a1803df08f44-8b027fd26a4mr319397866d6.8.1776802896536; 
 Tue, 21 Apr 2026 13:21:36 -0700 (PDT)
X-Received: by 2002:a05:6214:f25:b0:8ac:a6c5:c7d1 with SMTP id
 6a1803df08f44-8b027fd26a4mr319397056d6.8.1776802895949; 
 Tue, 21 Apr 2026 13:21:35 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 14/16] migration/qapi: Introduce system-wise "remaining"
 reports
Date: Tue, 21 Apr 2026 16:21:08 -0400
Message-ID: <20260421202110.306051-15-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, mgmt can only query for remaining RAM, not system-wise remaining
data.  It was not a problem before, because for a very long time RAM was
the only part that matters.

After VFIO migrations landed upstream, it may not be true anymore
especially considering that there can be GPU devices that contain GBs of
device states.

Add a new "remaining" field in query-migrate results, reflecting
system-wise remaining data, which will include everything (e.g. VFIO).

This information will be useful for mgmt to implement generic way of stall
detection that covers all system resources.  Say, when system remaining
data does not decrease anymore for a relatively long period of time, then
it may mean that there is a challenge of converging, so mgmt can act based
on how this value changes over time (especially if sampled after each
migration iteration).

Before this patch, "expected_downtime" almost played this role. For
example, by monitoring "expected_downtime" at the beginning of each
iteration can in most cases also reflect the progress of migration
system-wise.  Said that, "expected_downtime" was always calculated based on
a bandwidth value that can fluctuate a lot if avail-switchover-bandwidth is
not used. This new "remaining" field will remove that part of uncertainty
for mgmt.

With the new field, HMP "info migrate" now reports this:

(qemu) info migrate
Status:                 active
Time (ms):              total=12080, setup=14, exp_down=300
Remaining:              1.36 GiB        <------------------- newline
RAM info:
  Throughput (Mbps):    840.50
  Sizes:                pagesize=4 KiB, total=4.02 GiB
  Transfers:            transferred=1.18 GiB, remain=1.36 GiB
    Channels:           precopy=1.18 GiB, multifd=0 B, postcopy=0 B
    Page Types:         normal=307923, zero=388148
  Page Rates (pps):     transfer=25660
  Others:               dirty_syncs=1

It should be the same value as RAM's remaining report when VFIO is not
involved, and it should report more than that when VFIO is involved.

Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 4 ++++
 migration/migration-hmp-cmds.c | 5 +++++
 migration/migration.c          | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index e3ad3f0604..a6e24b5685 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -300,6 +300,9 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
+# @remaining: amount of bytes remaining to be migrated system-wise,
+#     includes both RAM and all devices (like VFIO).  (Since 11.1)
+#
 # Features:
 #
 # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
@@ -310,6 +313,7 @@
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
+           '*remaining': 'uint64',
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54..a3887cc0d7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -178,6 +178,11 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
     }
 
+    if (info->has_remaining) {
+        g_autofree char *remaining = size_to_str(info->remaining);
+        monitor_printf(mon, "Remaining: \t\t%s\n", remaining);
+    }
+
     if (info->has_socket_address) {
         SocketAddressList *addr;
 
diff --git a/migration/migration.c b/migration/migration.c
index 5d68591215..6fd89995a2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1076,6 +1076,12 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
     }
 }
 
+static void populate_global_info(MigrationInfo *info, MigrationState *s)
+{
+    info->has_remaining = true;
+    info->remaining = qatomic_read(&mig_stats.dirty_bytes_total);
+}
+
 static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 {
     size_t page_size = qemu_target_page_size();
@@ -1177,6 +1183,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
         populate_ram_info(info, s);
+        populate_global_info(info, s);
         migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
-- 
2.53.0


