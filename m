Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057E5E77171
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgK-0003cD-Pj; Thu, 05 Dec 2024 19:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgI-0003bG-M1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgG-0005lw-TJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drjbKA8KuZzlVuJlQXBYiI10JQger84ZUXuJUp7t2qg=;
 b=Wqei99SUNCGVFa9KdDqNsWCPlLvOa+ZPyuBhzLQ8ZSQnsY5fwbtzi8GFrUzeFikwjSOSut
 Grgpg0/ZeaqgIdKR+sHCGGm96gpX6vDbO3kbzxxd8vrYcCCew0a/VNdlmofv4n+vMpdS8o
 QhgdxSdiFhwN2e9AWyfijXJ507dVGkA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-izdX7eyUPyeu5W1XxmY0_Q-1; Thu, 05 Dec 2024 19:58:51 -0500
X-MC-Unique: izdX7eyUPyeu5W1XxmY0_Q-1
X-Mimecast-MFC-AGG-ID: izdX7eyUPyeu5W1XxmY0_Q
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d87c55ca85so40361286d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446730; x=1734051530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drjbKA8KuZzlVuJlQXBYiI10JQger84ZUXuJUp7t2qg=;
 b=bnp2k23FslkSetNSBcwllOb6ViCALGtcb/l/1DfbqrKeXsioU/s7rU74YysXuhSJse
 fiGPjd3tUWt4/XMnSG1Dc5cZ7qcS5oirGRfMHGAh10yLwu4rkgEWVK8kBRwx7pybCe4y
 u+C9BUTXWDrK2oFmkT9fhmxfNnvt3kjw2tz3mrGTzk/ceZwbfiTuChRoZP1DhGeZQzet
 MQq1oZUU8XMx30RjmJeKEKM8yr8w1tZBM2jV4IXTjKIU/GKZgpxZGypDtAlY9aZHj3lA
 AhMapzA4HZ4LlPPcY/+qe2EyF0LOYfaLXSGu19FOiIJdVZ3oPKfjCMeZITt2hdP2TX56
 buMw==
X-Gm-Message-State: AOJu0Yw2JAe5ncSpkVqWkDsSNagoqBbbLMk493UmCUNHutrcnVO0T366
 9/6znFmyPdmyUiddoCPFSA8VOeCZNwWTxz7oy9xN5iv0413NHwWOZQrTIfrJxzuMOvh4ulEhABV
 QEK7IfDFdpr2Ynj95XVyFQ53nkmuJXpYr7EMbHHDKGc+Hp225ZegCoY4d6rQAoBCqjDxZO5iDZH
 WHex45AM79HirE3Nme+zQX5RM6h/jnsWHs9w==
X-Gm-Gg: ASbGncv14r6sBAVIVus9SChLo0ssP9rMR6IcnIBzmPktOy4TQvgACsRpnBlg1USzGGE
 4GiOtPtx9+4cYdrH4zVWE5MqIJvy6iYi3YgyBUY/BHs1BDRa9GpbT8q4LE9XMvOwVsiUkpuJl1/
 D/tuNYPVhlwEtRlzFVv8A2+8m1otniE6JGAGbQFpE+ihNImdTHnj1HzH9O2HRa7GqXXPt+CdDQf
 2QVkZKOetI6v4UE6NpeR2rDD+Y2cupJjrIQ05xIvRFUmACiGJlbAj86sxK/naESBZku7GGOTxqL
 fErH+m3ebn3kfdKuKFxNFwJQNw==
X-Received: by 2002:ad4:5b84:0:b0:6d4:1f6d:695f with SMTP id
 6a1803df08f44-6d8e70a4561mr17971796d6.2.1733446730702; 
 Thu, 05 Dec 2024 16:58:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEncKgYAyVwJxQJ2sxQIizv5+JUBBLheVgwUBG7yK1do59UnqfWleTbHlzw2eCjiKn29CnQQ==
X-Received: by 2002:ad4:5b84:0:b0:6d4:1f6d:695f with SMTP id
 6a1803df08f44-6d8e70a4561mr17971506d6.2.1733446730295; 
 Thu, 05 Dec 2024 16:58:50 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:49 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 6/7] migration/multifd: Cleanup src flushes on condition
 check
Date: Thu,  5 Dec 2024 19:58:33 -0500
Message-ID: <20241206005834.1050905-7-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206005834.1050905-1-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The src flush condition check is over complicated, and it's getting more
out of control if postcopy will be involved.

In general, we have two modes to do the sync: legacy or modern ways.
Legacy uses per-section flush, modern uses per-round flush.

Mapped-ram always uses the modern, which is per-round.

Introduce two helpers, which can greatly simplify the code, and hopefully
make it readable again.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h        |  2 ++
 migration/multifd-nocomp.c | 42 ++++++++++++++++++++++++++++++++++++++
 migration/ram.c            | 10 +++------
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index c9ae57ea02..582040922f 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -351,6 +351,8 @@ static inline uint32_t multifd_ram_page_count(void)
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(QEMUFile *f);
+bool multifd_ram_sync_per_round(void);
+bool multifd_ram_sync_per_section(void);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 58372db0f4..c1f686c0ce 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -344,6 +344,48 @@ retry:
     return true;
 }
 
+/*
+ * We have two modes for multifd flushes:
+ *
+ * - Per-section mode: this is the legacy way to flush, it requires one
+ *   MULTIFD_FLAG_SYNC message for each RAM_SAVE_FLAG_EOS.
+ *
+ * - Per-round mode: this is the modern way to flush, it requires one
+ *   MULTIFD_FLAG_SYNC message only for each round of RAM scan.  Normally
+ *   it's paired with a new RAM_SAVE_FLAG_MULTIFD_FLUSH message in network
+ *   based migrations.
+ *
+ * One thing to mention is mapped-ram always use the modern way to sync.
+ */
+
+/* Do we need a per-section multifd flush (legacy way)? */
+bool multifd_ram_sync_per_section(void)
+{
+    if (!migrate_multifd()) {
+        return false;
+    }
+
+    if (migrate_mapped_ram()) {
+        return false;
+    }
+
+    return migrate_multifd_flush_after_each_section();
+}
+
+/* Do we need a per-round multifd flush (modern way)? */
+bool multifd_ram_sync_per_round(void)
+{
+    if (!migrate_multifd()) {
+        return false;
+    }
+
+    if (migrate_mapped_ram()) {
+        return true;
+    }
+
+    return !migrate_multifd_flush_after_each_section();
+}
+
 int multifd_ram_flush_and_sync(QEMUFile *f)
 {
     MultiFDSyncReq req;
diff --git a/migration/ram.c b/migration/ram.c
index 154ff5abd4..5d4bdefe69 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1302,9 +1302,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (migrate_multifd() &&
-                (!migrate_multifd_flush_after_each_section() ||
-                 migrate_mapped_ram())) {
+            if (multifd_ram_sync_per_round()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
@@ -3178,8 +3176,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
 out:
     if (ret >= 0 && migration_is_running()) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
-            !migrate_mapped_ram()) {
+        if (multifd_ram_sync_per_section()) {
             ret = multifd_ram_flush_and_sync(f);
             if (ret < 0) {
                 return ret;
@@ -3252,8 +3249,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() &&
-        migrate_multifd_flush_after_each_section()) {
+    if (multifd_ram_sync_per_section()) {
         /*
          * Only the old dest QEMU will need this sync, because each EOS
          * will require one SYNC message on each channel.
-- 
2.47.0


