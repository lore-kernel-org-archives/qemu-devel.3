Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDAAC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6tQ-00057D-Mi; Fri, 16 Feb 2024 17:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tP-000513-Fm
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:15 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tN-0007KU-MW
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:15 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4c01a5e85e8so699104e0c.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708123273; x=1708728073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/OfLhO0CA6m0WDBPYJTqQUVPYsQDRD36SN09xd28yU=;
 b=NozMc7+GQFb5iur7RwiYsaYUX9fUhMml3ZhOLnmK72zUDcitP+MEKTsrkCLaIRKU+s
 DfJfTQDwFYqw+vTAbrdS7DP3A7s+YiyclzvlQJhPQATl2hkMQ1U+5TmWPg1M+Q1mEeEi
 +F/6yeXDxvDg5Vqo7lZou940kF9e2cu6ZiUqG1SpIAzp6fl4FiOuMYLG6I4GWU5LQhZ2
 C54MXPiBY2S8uQgjYpkehL4kMGmjwxbpzdvRSwxUM5XaWBXmJKOhehNOvtba0yhzEi8P
 vPonJIPzW/kagce2RLWLjl0IDL2jsPiRlRqSikJuO4OalVmEPlENl4jxSGrMIs71XKMI
 HW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123273; x=1708728073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/OfLhO0CA6m0WDBPYJTqQUVPYsQDRD36SN09xd28yU=;
 b=fOk27XMUzWzO5zPYh38+ijjAQmhrYiUYw2CowV8AK3HiWZrUa+B8rkWc8NYzSvBTXs
 dYOLxWKZVOhwi098JK5dmPKk57vUZDh7576ylsasc1es4+HnybcfugirFFLEecjEFnGr
 7gElokSjoxWjRS8Jg9gnXJXTouZLyir2WmCEEKudrciGsg0MFnpWRKc/EFdQGpKu6p7C
 8VkeWgHFoDPbOvY4f63jNUnKvrkWDUVthoZ4DMMEY41PNA19e8PhI3B/d7pditko3g6D
 B1GLffnvgdpzGaGKXGiwZOCPg4pvXjJEPdhAy+7uk6NmHClxyal2Pbar/WagcREh6Wf6
 hFNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDz45my7b2kjETxkalusXA6NpqqubETVMRuYQEEZ5txg/5kDyvlI1YNeuKZQ+36Vwqlguc+jfDkABeop1L0p1Yhhtqjao=
X-Gm-Message-State: AOJu0YzCm8LmgiDxSUPjdSYmNnuUoXZ3FPH44D+2yKmy6/sATUQCpARl
 8NqVsP9m0dVCgo1H8YB898+VacaSS/tm1uigzg4CB1uauoDnArn3j7mXK4GysMw=
X-Google-Smtp-Source: AGHT+IH2r+7Tp4EotXB4AUc4JLvq9c/++hrwcItqmtZKi1Kc2tpGnm+BH+MP+zmM6aDFJ2/fVLAdng==
X-Received: by 2002:a1f:eb03:0:b0:4b6:cc19:42dc with SMTP id
 j3-20020a1feb03000000b004b6cc1942dcmr6329585vkh.11.1708123272767; 
 Fri, 16 Feb 2024 14:41:12 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 cz18-20020a056122449200b004c0a12c4d53sm120991vkb.51.2024.02.16.14.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 14:41:12 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 6/7] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
Date: Fri, 16 Feb 2024 22:40:01 +0000
Message-Id: <20240216224002.1476890-7-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216224002.1476890-1-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa2c.google.com
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
index 7e96ae6ffd..abe035c9f2 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -111,6 +111,10 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->ram->normal);
         monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
                        info->ram->normal_bytes >> 10);
+        monitor_printf(mon, "zero: %" PRIu64 " pages\n",
+                       info->ram->zero);
+        monitor_printf(mon, "zero bytes: %" PRIu64 " kbytes\n",
+                       info->ram->zero_bytes >> 10);
         monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
                        info->ram->dirty_sync_count);
         monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..1968ea7075 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1112,6 +1112,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->skipped = 0;
     info->ram->normal = stat64_get(&mig_stats.normal_pages);
     info->ram->normal_bytes = info->ram->normal * page_size;
+    info->ram->zero = stat64_get(&mig_stats.zero_pages);
+    info->ram->zero_bytes = info->ram->zero * page_size;
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count =
         stat64_get(&mig_stats.dirty_sync_count);
diff --git a/qapi/migration.json b/qapi/migration.json
index e2450b92d4..892875da18 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -63,6 +63,10 @@
 #     between 0 and @dirty-sync-count * @multifd-channels.  (since
 #     7.1)
 #
+# @zero: number of zero pages (since 9.0)
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
+           'zero': 'int', 'zero-bytes': 'int' } }
 
 ##
 # @XBZRLECacheStats:
@@ -332,6 +337,8 @@
 #           "duplicate":123,
 #           "normal":123,
 #           "normal-bytes":123456,
+#           "zero":123,
+#           "zero-bytes":123456,
 #           "dirty-sync-count":15
 #         }
 #      }
@@ -358,6 +365,8 @@
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
+#             "zero":123,
+#             "zero-bytes":123456,
 #             "dirty-sync-count":15
 #          }
 #       }
@@ -379,6 +388,8 @@
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
+#             "zero":123,
+#             "zero-bytes":123456,
 #             "dirty-sync-count":15
 #          },
 #          "disk":{
@@ -405,6 +416,8 @@
 #             "duplicate":10,
 #             "normal":3333,
 #             "normal-bytes":3412992,
+#             "zero":3333,
+#             "zero-bytes":3412992,
 #             "dirty-sync-count":15
 #          },
 #          "xbzrle-cache":{
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index 608d7270f6..75315b99b7 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -92,6 +92,8 @@ def _migrate_progress(self, vm):
                 info["ram"].get("skipped", 0),
                 info["ram"].get("normal", 0),
                 info["ram"].get("normal-bytes", 0),
+                info["ram"].get("zero", 0);
+                info["ram"].get("zero-bytes", 0);
                 info["ram"].get("dirty-pages-rate", 0),
                 info["ram"].get("mbps", 0),
                 info["ram"].get("dirty-sync-count", 0)
-- 
2.30.2


