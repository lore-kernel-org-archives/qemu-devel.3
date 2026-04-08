Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0769010F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXh4-0007Jm-F0; Wed, 08 Apr 2026 14:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAXgq-00075k-CE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCW-00029k-LG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbrwSMWX65NN2qFtsFxD677N8GbRpenQYWl5sMfBjrg=;
 b=CZVWN+iKXM0zMljnBtIJpacfAY9v9kMfqe8t3Viww9hrEf8DPbFHz24fTlUIOiifjWEePK
 /85QzvZVe714kcwPcll8232Ok2pMUQndoaiKMiN61ZrxVhBO1d7k5p62of4Y8amrPkQtdA
 TTcBvpR1mkfRPOR0Er8uY+VVLKUSlOU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-o24luCgIMiCxOCtsOdYteA-1; Wed, 08 Apr 2026 12:56:22 -0400
X-MC-Unique: o24luCgIMiCxOCtsOdYteA-1
X-Mimecast-MFC-AGG-ID: o24luCgIMiCxOCtsOdYteA_1775667382
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50da31af14cso2649191cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667382; x=1776272182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbrwSMWX65NN2qFtsFxD677N8GbRpenQYWl5sMfBjrg=;
 b=tXmLDhgU5LT3gMH0iZPzlpfuteFlDjKEzBHSSlX9z380p7pvZuyoyRlkFoadOXZULl
 B6xxKIFTnWN9T+svvDqUrmc6L7rl/mcHhwaEm4bHT6HBscaYd9x5zyXSWhqJG/duM45S
 If45oDHPHV/jbcsmxRK05xZVituxUXR1al0UwN/Kcs9R1AT/nUcL9G3tgJfc6IFXuJKY
 DgkU6VP3Shenl/IdsnVZvJs4qmhI4LaECWbkfkQSpeVdBikzgMgHVHdBvdxgGBjPCTV2
 MNEHkqq548q9a/afF3bL+p/hz823veBiou39nOAFe4yC6J7MLXnQVGy4Q5WE76bxxny5
 hzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667382; x=1776272182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gbrwSMWX65NN2qFtsFxD677N8GbRpenQYWl5sMfBjrg=;
 b=DUVnBAkL6CLVDURKEjJoU17EzQoh8LXzzaxRNlZYqtJ1yvKxDC0yGfO751cYs7om6N
 q2A/PQKBplAOXuIlViPg2E6GkuxOl8NsHUi8wIVgn3AZbZ+bsjdAsNymQlNPTCU3mvaH
 9VGzub+tCAdqrFRm3q2jIBShtD04gmx6WPpcFVs8nS+iN3ErETlfI6yrvALaO2uJd0lS
 4irgked5JaqxyG8bRmqj7J8NjfVeoStHMSKieA7/k3J/NiqI+rjbcWKrU4+EHUh691VG
 NxRGrXnm0JRPDpj3b/4+MSGS6kLhv+edHYDl82NnKfSkfHUY1dBvt1EK8ZI7ac50sRzH
 80DA==
X-Gm-Message-State: AOJu0YywdTP4axNgJgrqmC0gsW3n2gvqQXeEyq5dk6LQLHy8ihBVCA1H
 7MsoQImfKHiPDpNqeU4V1cMBaaxWUCNfF31wwWfigttC0KzRbXQllgjS8xfw6GrGMbX9V1qnc+2
 gnlaVpibZg+hDG93r6NIAI5D9bnrGB9nXTAbe7A/dtKfbmdnFaVtgwqcCmfIeSt0rH0eAzP3JcK
 yh4twNKAAiakXH5CH2RjmQybrYLqkdOXRHkUmRfg==
X-Gm-Gg: AeBDieuS8PiDxi/ozdD51Sz7tb3XYj6A99OvO4yK7ozm0E/xzHfpEfmimtM389BNyD8
 Vd4jXSlteec1FN1oKKellQifHbwXmI/HbDPbVz26P3lsBEIIkx1I3/F/jOZArbw343m6dw1jUhI
 hzC9THVxVA2e7dxCEQwEFLMiwYzAGydV3qtauEa8kmTKXxSpTYWQsond7odWFMAbrfCTmCgfwVK
 fK6Ntz8QhXYljOV/hTWqzPrGio3x7Nx4dVMp9EwffFmZjTvKMHZ5uGxG4uXqrTxQM+RsBvLjvMu
 8FPeGS1FWtIIRJvc9km0Pji20OFWYXfYoqv1RHaoSdU2zJRpWIeFLmqgKJWV5lWfKJFYd0ks2sR
 +e2Tzw6W0yWsZ5GX7U5zQ/11U7EzTOR7c0VdS1rc/5Vzm
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id
 d75a77b69052e-50d83de50cfmr229016051cf.20.1775667381673; 
 Wed, 08 Apr 2026 09:56:21 -0700 (PDT)
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id
 d75a77b69052e-50d83de50cfmr229015211cf.20.1775667380973; 
 Wed, 08 Apr 2026 09:56:20 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 13/14] migration/qapi: Introduce system-wise "remaining"
 reports
Date: Wed,  8 Apr 2026 12:55:57 -0400
Message-ID: <20260408165559.157108-14-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Remaining (bytes):      1.36 GiB        <------------------- newline
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
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            |  4 ++++
 migration/migration-hmp-cmds.c |  5 +++++
 migration/migration.c          | 11 +++++++++++
 3 files changed, 20 insertions(+)

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
index 0a193b8f54..721c211086 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -178,6 +178,11 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
     }
 
+    if (info->has_remaining) {
+        g_autofree char *remaining = size_to_str(info->remaining);
+        monitor_printf(mon, "Remaining (bytes): \t%s\n", remaining);
+    }
+
     if (info->has_socket_address) {
         SocketAddressList *addr;
 
diff --git a/migration/migration.c b/migration/migration.c
index 4010e5dcf5..c2aa145106 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1076,6 +1076,16 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
     }
 }
 
+static void populate_global_info(MigrationInfo *info, MigrationState *s)
+{
+    MigPendingData data = { };
+
+    qemu_savevm_query_pending(&data, false);
+
+    info->has_remaining = true;
+    info->remaining = data.total_bytes;
+}
+
 static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 {
     size_t page_size = qemu_target_page_size();
@@ -1177,6 +1187,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
         populate_ram_info(info, s);
+        populate_global_info(info, s);
         migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
-- 
2.53.0


