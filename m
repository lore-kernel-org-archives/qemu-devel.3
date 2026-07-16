Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D4C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJCS-00041V-87; Thu, 16 Jul 2026 06:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkJCP-00040R-TN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:20:13 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkJCJ-00054q-VQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784197198; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=ANb5OyyCZT/FApULtSqZ9QNYrtKLeWbtrDaSoNGlUyI=;
 b=JGJD9RWRDDn7UvQRhmHfNJQV6qyADZBrY5k7hemQjZiTCix99DcqbHzs+qm8/bh0ybsF5KF2t20R5+GBw8K6RH37FVyktnSz2OZeE4EUO8CX9eKJsKXtodmMwzaY22eGOD3EIs2NcZvRNEDaV+kCaOO5NwWafpvF8++e2sbAYqA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X7E6RmL_1784197194; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X7E6RmL_1784197194 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 16 Jul 2026 18:19:55 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 2/3] migration: fix const mismatch in format_time_str()
Date: Thu, 16 Jul 2026 18:19:51 +0800
Message-ID: <20260716101952.65329-3-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260716101952.65329-1-guobin@linux.alibaba.com>
References: <20260716101952.65329-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

format_time_str() returns a newly allocated string from
g_strdup_printf(), so the caller owns it.  Return gchar * rather
than const gchar * to match the g_autofree callers.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/migration-hmp-cmds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 502ca704da..6bedf786df 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -54,7 +54,7 @@ static void migration_global_dump(Monitor *mon)
                    ms->clear_bitmap_shift);
 }
 
-static const gchar *format_time_str(uint64_t us)
+static gchar *format_time_str(uint64_t us)
 {
     const char *units[] = {"us", "ms", "sec"};
     int index = 0;
@@ -123,8 +123,8 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
         monitor_printf(mon, "Postcopy Latency Distribution:\n");
 
         while (item) {
-            g_autofree const gchar *from = format_time_str(1UL << count);
-            g_autofree const gchar *to = format_time_str(1UL << (count + 1));
+            g_autofree gchar *from = format_time_str(1UL << count);
+            g_autofree gchar *to = format_time_str(1UL << (count + 1));
 
             monitor_printf(mon, "  [ %8s - %8s ]: %10"PRIu64"\n",
                            from, to, item->value);
-- 
2.50.1 (Apple Git-155)


