Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23495CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrm-0008Jv-VZ; Tue, 19 May 2026 13:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrT-0008Ap-6J
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrR-0004Ny-Mj
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmVRTZeE1PnX8kRbjuyEss4QuQxjLGaPYaUkMd0dC14=;
 b=iSuN42kn57odYbVlC8ykS8+ap0KWqMWsIixIpipcbP3OhOIs08C4D26YDBJybfbZVDudSq
 lWZpRdfP7nk6xaWjpJ8Iis6oJYeL71687jTKAkiEU5GGPFHhSnx/cHGZ8oc7J427Eh00VL
 ntBpxydXtI6k+25CKHCUhWCwOP/trKI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-1vYVohO2N8CHweDJMH4hhA-1; Tue,
 19 May 2026 13:04:03 -0400
X-MC-Unique: 1vYVohO2N8CHweDJMH4hhA-1
X-Mimecast-MFC-AGG-ID: 1vYVohO2N8CHweDJMH4hhA_1779210242
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4676A19560A7; Tue, 19 May 2026 17:04:02 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D094F1684; Tue, 19 May 2026 17:04:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 18/18] block: Improve readability in HMP 'info blockstats'
 output
Date: Tue, 19 May 2026 19:03:17 +0200
Message-ID: <20260519170317.345032-19-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Instead of a long line with key=value pairs for each block device,
switch to a tabular form with aligned values. This makes it much easier
to find the relevant information in the output.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260512112759.66038-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 1fd28d59eb1..69ade0534f1 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -794,30 +794,28 @@ void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
             continue;
         }
 
-        monitor_printf(mon, "%s:", stats->value->device);
-        monitor_printf(mon, " rd_bytes=%" PRId64
-                       " wr_bytes=%" PRId64
-                       " rd_operations=%" PRId64
-                       " wr_operations=%" PRId64
-                       " flush_operations=%" PRId64
-                       " wr_total_time_ns=%" PRId64
-                       " rd_total_time_ns=%" PRId64
-                       " flush_total_time_ns=%" PRId64
-                       " rd_merged=%" PRId64
-                       " wr_merged=%" PRId64
-                       " idle_time_ns=%" PRId64
-                       "\n",
+        monitor_printf(mon, "%s%s: idle_time_ns=%" PRId64 "\n",
+                       stats != stats_list ? "\n" : "",
+                       stats->value->device,
+                       stats->value->stats->idle_time_ns);
+        monitor_printf(mon, "       %24s %16s %24s %10s\n", "bytes",
+                       "operations", "total_time_ns", "merged");
+        monitor_printf(mon, "Read:  %24" PRId64 " %16" PRId64 " %24" PRId64
+                       " %10" PRId64 "\n",
                        stats->value->stats->rd_bytes,
-                       stats->value->stats->wr_bytes,
                        stats->value->stats->rd_operations,
+                       stats->value->stats->rd_total_time_ns,
+                       stats->value->stats->rd_merged);
+        monitor_printf(mon, "Write: %24" PRId64 " %16" PRId64 " %24" PRId64
+                       " %10" PRId64 "\n",
+                       stats->value->stats->wr_bytes,
                        stats->value->stats->wr_operations,
-                       stats->value->stats->flush_operations,
                        stats->value->stats->wr_total_time_ns,
-                       stats->value->stats->rd_total_time_ns,
-                       stats->value->stats->flush_total_time_ns,
-                       stats->value->stats->rd_merged,
-                       stats->value->stats->wr_merged,
-                       stats->value->stats->idle_time_ns);
+                       stats->value->stats->wr_merged);
+        monitor_printf(mon, "Flush: %24s %16" PRId64 " %24" PRId64 "\n",
+                       "",
+                       stats->value->stats->flush_operations,
+                       stats->value->stats->flush_total_time_ns);
     }
 
     qapi_free_BlockStatsList(stats_list);
-- 
2.54.0


