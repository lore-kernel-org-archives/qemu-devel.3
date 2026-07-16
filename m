Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0495C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJCS-00040y-GU; Thu, 16 Jul 2026 06:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkJCP-00040B-6k
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:20:13 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkJCI-00054p-Tt
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784197197; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=tZtJ9o1OGLraNBGTQRGuVYRTBcoj0U7p+LKhOmdV6NA=;
 b=coKg8z8Oes1houwTPr1LY3kJpATYt07V7J26VyN300TXHe0LGmNMf61rmDHPZb+i0apyeaS/M9QTc3Mtu0n2te1VFODacbtCBqG/lZn0gzmkFIbjeBzVb1KZT8Csg5BD9HvXsC28QnUqqDwZMeIo+yHpOyZ7CWII3DkrgbAMybw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X7E4g61_1784197195; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X7E4g61_1784197195 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 16 Jul 2026 18:19:55 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 3/3] migration: clean up postcopy blocktime presentation
Date: Thu, 16 Jul 2026 18:19:52 +0800
Message-ID: <20260716101952.65329-4-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260716101952.65329-1-guobin@linux.alibaba.com>
References: <20260716101952.65329-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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

Small cleanups for the postcopy blocktime fine-grained tracking
feature:

* Remove a redundant memset() on latency_buckets after g_new0().
* Use singular "Latency" in the HMP label for postcopy non-vCPU
  latency, consistent with other single-value labels.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/migration-hmp-cmds.c | 2 +-
 migration/postcopy-ram.c       | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 6bedf786df..4a18ca8bba 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -96,7 +96,7 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
     }
 
     if (info->has_postcopy_non_vcpu_latency) {
-        monitor_printf(mon, "Postcopy non-vCPU Latencies (ns): %" PRIu64 "\n",
+        monitor_printf(mon, "Postcopy non-vCPU Latency (ns): %" PRIu64 "\n",
                        info->postcopy_non_vcpu_latency);
     }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 341cad264a..28d698260e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -297,9 +297,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     unsigned int smp_cpus = ms->smp.cpus;
     PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
 
-    /* Initialize all counters to be zeros */
-    memset(ctx->latency_buckets, 0, sizeof(ctx->latency_buckets));
-
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_current = g_new0(uint8_t, smp_cpus);
-- 
2.50.1 (Apple Git-155)


