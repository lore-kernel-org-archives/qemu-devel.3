Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CAFC48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 02:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfseb-00042S-Vw; Thu, 29 Feb 2024 21:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfsea-00042I-Sh
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:40 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseZ-0005Rm-Av
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:40 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6900f479e3cso14755466d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709260178; x=1709864978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JKPdceht9UhXxil7+9Basmri/1zxv20YhwsApVqg0s=;
 b=k7YQqXy2yYDFvBAQ/zbONW60RC1flyTMWFarBXMaAugA1pe/17bxP+uwQXjqcUedHK
 47SspwcUaEwLu2is3wIyH+CERA/XqDVcSx8RIclqI8v7P+L5hL/HK8b/nSK1olyVOogQ
 OdqyZWlh2s3EnBk5Seier0vrfmHQTooqzsU7rHdr3+umyuaGjq4++jppKq6dIfnNx8KM
 ZQ1nm6uiezvDuLH79Y18VMBPBTEUvwufDLkxt2xi4VGSo7l7JyHim64bmS1JgScbjByD
 u4lv++BW6yROGTTWtxagJTjQ8gOxGCUAr2JTV1lIC95k1hLe8sdhfibAbtJQe0QyTt8Y
 +tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709260178; x=1709864978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JKPdceht9UhXxil7+9Basmri/1zxv20YhwsApVqg0s=;
 b=LtUCgIX2DCJFAAJeRz95KH9Hoasby9/TMW1wjvwD524lz6OZKz3qM8Z8UquaUOzyen
 x8l2Vc/24ZBx8NuR+Gu1jqt+9nW0GYlGwENKHrKS9E+5E5scWYl825RPNNRiBK6STbEY
 urYLjFYJBZos7o6f2V8WnKzT8VikOCGdg6W7TVobrySphG4y9KO32ysn60PH6dEzxrcv
 EXywbe8xNO/k+jzKE3iZNFY+BkC5+tH14Npji8sFXs97hNB61d46rbxgp3AzaYiVIA/1
 bhXVlAqgzNWVUi9Fju1yhy+icill1RlOSfDGMXlfALsD1JKitsv7mBzvflVIlfSvBLFX
 qATA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCP+lvkeZ/H6AlvathkB3zA7XZ6NO+Ig7MHpH7fDmO1r60262MVlT0X9bxwP/iyVtjDWDJAvMnUCwNqQFvWD40uXdnfy4=
X-Gm-Message-State: AOJu0Yw4PZB3AZFipWy1MdCGtrxNGjTOVTtcUW1wrXXQGiFa6H9RV3T6
 PVKa0dGj+bPswaBp5PZveS18sI1lSXuj9QtqfKmPehfDxuGIdV2gVj2GB39qmCU=
X-Google-Smtp-Source: AGHT+IEFfwMhJqX/QVOdR18hRg4UO3YYfvB5bT7wdSIVj3+cOC7HtMkZKUtpNKux4uvI6EPgFebMXA==
X-Received: by 2002:a0c:c603:0:b0:690:690:a5e2 with SMTP id
 v3-20020a0cc603000000b006900690a5e2mr472835qvi.10.1709260178358; 
 Thu, 29 Feb 2024 18:29:38 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.120])
 by smtp.gmail.com with ESMTPSA id
 qo13-20020a056214590d00b0068d11cf887bsm1384107qvb.55.2024.02.29.18.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 18:29:37 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v4 6/7] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
Date: Fri,  1 Mar 2024 02:28:28 +0000
Message-Id: <20240301022829.3390548-7-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022829.3390548-1-hao.xiang@bytedance.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2e.google.com
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
index bab68bcbef..fc4e3ef52d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1126,6 +1126,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->skipped = 0;
     info->ram->normal = stat64_get(&mig_stats.normal_pages);
     info->ram->normal_bytes = info->ram->normal * page_size;
+    info->ram->zero_pages = stat64_get(&mig_stats.zero_pages);
+    info->ram->zero_bytes = info->ram->zero_pages * page_size;
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count =
         stat64_get(&mig_stats.dirty_sync_count);
diff --git a/qapi/migration.json b/qapi/migration.json
index ca9561fbf1..03b850bab7 100644
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
 #               "duplicate":123,
 #               "normal":123,
 #               "normal-bytes":123456,
+#               "zero-pages":123,
+#               "zero-bytes":123456,
 #               "dirty-sync-count":15
 #             }
 #          }
@@ -358,6 +365,8 @@
 #                 "duplicate":123,
 #                 "normal":123,
 #                 "normal-bytes":123456,
+#                 "zero-pages":123,
+#                 "zero-bytes":123456,
 #                 "dirty-sync-count":15
 #              }
 #           }
@@ -379,6 +388,8 @@
 #                 "duplicate":123,
 #                 "normal":123,
 #                 "normal-bytes":123456,
+#                 "zero-pages":123,
+#                 "zero-bytes":123456,
 #                 "dirty-sync-count":15
 #              },
 #              "disk":{
@@ -405,6 +416,8 @@
 #                 "duplicate":10,
 #                 "normal":3333,
 #                 "normal-bytes":3412992,
+#                 "zero-pages":3333,
+#                 "zero-bytes":3412992,
 #                 "dirty-sync-count":15
 #              },
 #              "xbzrle-cache":{
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


