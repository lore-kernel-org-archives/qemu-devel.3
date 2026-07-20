Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF34CC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpSf-0007Jr-NK; Mon, 20 Jul 2026 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpSU-0007I3-U2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpST-0006km-FD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784559544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVIFGkukln+xod9bmAynQS13TngsQVCJPxsTIasZjQE=;
 b=cFcppElYjM7r+VPvj6F0Ojt4HsBgV+5HSQiUzftlxL7/U505hFXEc/DpHY5sNo5kVqW7eu
 wIpNNhka017BrUNX953ESQBXgBYrUJU5HF5yRRHaSnjYjfupROoBFIcb87tofHnRH890ip
 wcdG2mPx6lVw3KkrDkfjEvfAgm+VUQA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-rgL7yAUrOkCJOQYGlwE-eg-1; Mon, 20 Jul 2026 10:59:03 -0400
X-MC-Unique: rgL7yAUrOkCJOQYGlwE-eg-1
X-Mimecast-MFC-AGG-ID: rgL7yAUrOkCJOQYGlwE-eg_1784559543
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso86000131cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784559543; x=1785164343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DVIFGkukln+xod9bmAynQS13TngsQVCJPxsTIasZjQE=;
 b=uGU55JXm5/6nSD6vaUcxNJlrm6gQ/sX7bIUZ/wQx9ppfNpoGHvLew42h48PZ+9vZwJ
 fGcBFhmjHIbWIRrTMEPnJAHh+rMQPH9O9kQA84mTINoYfzwNZ7NyNoYcnHmUWLzL0C+f
 fJHnnt6eKsitfcGDFtjPm9VEpoRjcbAk1QBKhhy/jxqJPU29Hrg48S5Sei0J80WwxSh/
 0u53kyFw9EwIZiRz0SCE4w0w2pzzv1DeAM2XTtsUORGMsYP2ycKQyG5lBVM69uTWKnvr
 MxTrnzOasq6WgjAnvGQOftQywjH1iaoFXSECUp+OL+nw1xwWc8qE75wbUWYUjmDCSGU/
 l8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559543; x=1785164343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DVIFGkukln+xod9bmAynQS13TngsQVCJPxsTIasZjQE=;
 b=Mg7ouTFu/y2raeEBpUebRz4ckaZnJxanxrSDaIjYRx54DvYnYmX284DTI13ldnM2PB
 iM9MjZ2lVA73DWCpyq+urafdLUVVVHKPYUbo0Tg5nnJYeV/xjlbf2vzpzlThw3f6z9p1
 YGwBQRDBX+ad5Nv0c6AgH9k+ebRERdSN67HA0eL9FxHMOrH6BK6jGGWMb2eK97IbcUaB
 I7BU33SsFu9saYy1YHIOfP5RdARs5EoiBDpRTVWq0iCGi5oqIeWCa2rcsMJrBgsHjLt7
 hEToA91UvbwaduXHwA736pr/ouYG30U55oE9h2pDjov6Z6tUWkKUqJi+JApw07EofO8P
 d6QA==
X-Gm-Message-State: AOJu0YwOn8ErpZRHO9qtbzdUdcIGXkWKVToIht8eZJh3/xD1/30gMHxX
 VVHfrWi2VbI7oGForByH6WhtEFR0KkEhHtOHj73FwpZXJG0WLWG2ZubrauGsQEwX3KPbW1YyNqU
 F1S/evSW3hB4EDvcxHOrR+fKVKbM0MISvw8U1rqsWNBv84qoFOm+6z59WZ4NXVOplkeQOASbiwQ
 ugvLElHg4vCPv90gLb4tGS5bCDznKp6RcigyNlcw==
X-Gm-Gg: AfdE7ckyH+cG9UuaxGw/x68/ShDaBFf+D2pimQA6349nm7eMZ4G2AEXxbDCmym2HIZI
 +Y2yz95tKqWD6+wVWaasbxoVs29I93sIwxG8K9xzk52JD6pYaKRiuRatk+0PiB/Mdn5LAMXEoDb
 WaTXi2uN5RjUzetXhHLPaadthQ1Q90bGa03a+GUD9IhO+91yTjvdiXpR6GeMq/KQzt2Q2EGCmfL
 /+DITE5HciOpAhpPKKkO+T3DXSCP8DVIqBPS4VRB5D52rJO86NgQOcmIugJe5wiVi+eJCiqIk/q
 vS0mupdFeSNeQ3nKgAmd0NhHiD+x9zalT5dplAoqDnRWenlZboDkd/5fpA2CMBFvuQ==
X-Received: by 2002:ac8:58d6:0:b0:51c:7b12:5fdc with SMTP id
 d75a77b69052e-5213d4b3a56mr137087031cf.88.1784559542653; 
 Mon, 20 Jul 2026 07:59:02 -0700 (PDT)
X-Received: by 2002:ac8:58d6:0:b0:51c:7b12:5fdc with SMTP id
 d75a77b69052e-5213d4b3a56mr137086581cf.88.1784559541925; 
 Mon, 20 Jul 2026 07:59:01 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-521502b9d5bsm75640391cf.31.2026.07.20.07.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:59:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 3/3] migration: clean up postcopy blocktime presentation
Date: Mon, 20 Jul 2026 10:58:53 -0400
Message-ID: <20260720145853.1483307-4-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720145853.1483307-1-peterx@redhat.com>
References: <20260720145853.1483307-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Bin Guo <guobin@linux.alibaba.com>

Small cleanups for the postcopy blocktime fine-grained tracking
feature:

* Remove a redundant memset() on latency_buckets after g_new0().
* Use singular "Latency" in the HMP label for postcopy non-vCPU
  latency, consistent with other single-value labels.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Link: https://lore.kernel.org/r/20260716101952.65329-4-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 2 +-
 migration/postcopy-ram.c       | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8b385f560e..7ec010fd05 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -95,7 +95,7 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
     }
 
     if (info->has_postcopy_non_vcpu_latency) {
-        monitor_printf(mon, "Postcopy non-vCPU Latencies (ns): %" PRIu64 "\n",
+        monitor_printf(mon, "Postcopy non-vCPU Latency (ns): %" PRIu64 "\n",
                        info->postcopy_non_vcpu_latency);
     }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index b0828edb3e..a3314d3180 100644
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
2.54.0


