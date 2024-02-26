Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF42C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh6y-00017n-1J; Mon, 26 Feb 2024 14:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6v-00015S-Ia
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:58:01 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6t-0004v5-Vk
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:58:01 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7d6a772e08dso983497241.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977479; x=1709582279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5vJ7Fapjt2fLK2rGlFf/dXYV4K/HjL/h5AzC5P5oqU=;
 b=cB74g3Oa8gMqGLedsAmUo86VW8hLb8iEX0I0LLC0ccc3wV3F5cxdE/X6nB9MifMdoi
 Gte9gHJ7rYIZerH4IB/LbzHZNl3azaoj6etxZ1o1h0u4CTf/taXpSwryfcLdjg3kIdCj
 Z6wXybRC73jt2k1zUbq2wJ3lcHZ8QKTAUJAYUzX6/UCXP7q7ZPw+ltUObrkIVe8+2IjG
 I2zDQY6M21+An1Dm7aQBTikeE7RKn7k80aZNeTU7levhNMSieioHUQHcdUwwy/z5YNsj
 T1gYXIJtB7t4NVVUF9seJcrl38RzrkBK1xUH+u4JvfNWoDCSfvQAM2SummGu8xBGAkpI
 vBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977479; x=1709582279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5vJ7Fapjt2fLK2rGlFf/dXYV4K/HjL/h5AzC5P5oqU=;
 b=sglkfmICNnOYE8iLYrCbg22BB6FAyWbFXNPQCyUx8fOSXSTBkoPwZPGNsUctl/0eri
 LQqSrRMZrGUGuSk2NoKoAi/52B5UV/tYW/GAJpwcTDjjSb5gX6tkto8WQN8fwLFXsfFc
 iuM8+72I0DAZVfoFmpCRYjrVw/9uLbBPDzOxtnyDVW3DJ5Iuq2GjmMmfZrKIYWuK9m1B
 +jry04lgLH/eF4nD9CbSsci/6CWkikcjE2ccPkgoX1i6a7m1PIU31PPLT6ddjAPutBH2
 metucDAmv2QNId5g5r4PugSBJNEgYmqZGpA4OUKcX8zfZGi7nhvTmhIcnplH1gttVg7+
 PTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEKVVzjpXEPVZxV8kXif3BpsKDzF3VW3lLOdHCVNnFOnX/gUR0tPppIXnWP8IvhtGvQ2VG/VZRdUx5eRloFODxTtiSMx4=
X-Gm-Message-State: AOJu0YxX5bTLuQdjYuIPae0XHM2ClEUT/eYJGoMPaTV3mEU5GLp6P3+U
 NlINwqHHgKaY5muKs1QQCiTsE2cojdBvREfVMDuf2mGUOY7ucCV0q/9oseOPveo=
X-Google-Smtp-Source: AGHT+IF/gC96i+aIgOoScT2eiHvHRV4EG5SBgLHNY4+yGTH+RYZLKbxzxg2f2jaYGZOIkEqHmo1UzQ==
X-Received: by 2002:a1f:ebc2:0:b0:4c0:37a4:dbbd with SMTP id
 j185-20020a1febc2000000b004c037a4dbbdmr4086711vkh.13.1708977478633; 
 Mon, 26 Feb 2024 11:57:58 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:58 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 6/7] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
Date: Mon, 26 Feb 2024 19:56:53 +0000
Message-Id: <20240226195654.934709-7-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This change extends the MigrationStatus interface to track zero pages
and zero bytes counter.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c      |  4 ++++
 migration/migration.c               |  2 ++
 qapi/migration.json                 | 15 ++++++++++++++-
 tests/migration/guestperf/engine.py |  2 ++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e96ae6ffd..a38ad0255d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -111,6 +111,10 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->ram->normal);
         monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
                        info->ram->normal_bytes >> 10);
+        monitor_printf(mon, "zero pages: %" PRIu64 " pages\n",
+                       info->ram->zero_pages);
+        monitor_printf(mon, "zero bytes: %" PRIu64 " kbytes\n",
+                       info->ram->zero_bytes >> 10);
         monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
                        info->ram->dirty_sync_count);
         monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..a99f86f273 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1112,6 +1112,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->skipped = 0;
     info->ram->normal = stat64_get(&mig_stats.normal_pages);
     info->ram->normal_bytes = info->ram->normal * page_size;
+    info->ram->zero_pages = stat64_get(&mig_stats.zero_pages);
+    info->ram->zero_bytes = info->ram->zero_pages * page_size;
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count =
         stat64_get(&mig_stats.dirty_sync_count);
diff --git a/qapi/migration.json b/qapi/migration.json
index a0a85a0312..171734c07e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -63,6 +63,10 @@
 #     between 0 and @dirty-sync-count * @multifd-channels.  (since
 #     7.1)
 #
+# @zero-pages: number of zero pages (since 9.0)
+#
+# @zero-bytes: number of zero bytes sent (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @skipped is always zero since 1.5.3
@@ -81,7 +85,8 @@
            'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
            'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
            'postcopy-bytes': 'uint64',
-           'dirty-sync-missed-zero-copy': 'uint64' } }
+           'dirty-sync-missed-zero-copy': 'uint64',
+           'zero-pages': 'int', 'zero-bytes': 'size' } }
 
 ##
 # @XBZRLECacheStats:
@@ -332,6 +337,8 @@
 #           "duplicate":123,
 #           "normal":123,
 #           "normal-bytes":123456,
+#           "zero-pages":123,
+#           "zero-bytes":123456,
 #           "dirty-sync-count":15
 #         }
 #      }
@@ -358,6 +365,8 @@
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
+#             "zero-pages":123,
+#             "zero-bytes":123456,
 #             "dirty-sync-count":15
 #          }
 #       }
@@ -379,6 +388,8 @@
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
+#             "zero-pages":123,
+#             "zero-bytes":123456,
 #             "dirty-sync-count":15
 #          },
 #          "disk":{
@@ -405,6 +416,8 @@
 #             "duplicate":10,
 #             "normal":3333,
 #             "normal-bytes":3412992,
+#             "zero-pages":3333,
+#             "zero-bytes":3412992,
 #             "dirty-sync-count":15
 #          },
 #          "xbzrle-cache":{
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index 608d7270f6..693e07c227 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -92,6 +92,8 @@ def _migrate_progress(self, vm):
                 info["ram"].get("skipped", 0),
                 info["ram"].get("normal", 0),
                 info["ram"].get("normal-bytes", 0),
+                info["ram"].get("zero-pages", 0);
+                info["ram"].get("zero-bytes", 0);
                 info["ram"].get("dirty-pages-rate", 0),
                 info["ram"].get("mbps", 0),
                 info["ram"].get("dirty-sync-count", 0)
-- 
2.30.2


