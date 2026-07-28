Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB63C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolkf-0007VJ-Ko; Tue, 28 Jul 2026 13:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkY-0007PY-3H
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkV-0005tk-VV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e76K6cxxgvd1ewhHg5dFxYUvxgoqgs/uhh+nuVf2wWw=;
 b=I+qa7//sc0IIxNUN5qcF7AZRk5W/2XH+oEJTVupmA+dSe6mmIjOX0whWA1bn4HUGFj34Ze
 Z9gVMwVu0mt3ixedg2WPIqVOXC1vR3fYiKusJJqGCwxvGyZ3vMZuX+KAIYHuxaqVG760j+
 W14bzUKOoysQwwBEipkvHlpeputJLJk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-5XUbdhaQNIioH7bz-1L7hA-1; Tue,
 28 Jul 2026 13:37:49 -0400
X-MC-Unique: 5XUbdhaQNIioH7bz-1L7hA-1
X-Mimecast-MFC-AGG-ID: 5XUbdhaQNIioH7bz-1L7hA_1785260268
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6661B18004BB; Tue, 28 Jul 2026 17:37:48 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBBF119560AB; Tue, 28 Jul 2026 17:37:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/17] block/accounting: take stats->lock in latency histogram
 setters
Date: Tue, 28 Jul 2026 19:37:24 +0200
Message-ID: <20260728173739.352078-3-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

block_latency_histogram_set() and block_latency_histograms_clear()
replace BlockLatencyHistogram's nbins/boundaries/bins without taking
stats->lock, while block_account_one_io() reads those same fields
under that lock from whatever iothread completes the I/O. The result
is usual use-after-free and qemu crash.

Take stats->lock in both setters, matching the lock already held by
the reader.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260724111311.4086859-2-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/accounting.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/accounting.c b/block/accounting.c
index f00fe997403..6e06c7609eb 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -194,6 +194,8 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
         return -EINVAL;
     }
 
+    qemu_mutex_lock(&stats->lock);
+
     hist->nbins = new_nbins;
     g_free(hist->boundaries);
     hist->boundaries = g_new(uint64_t, hist->nbins - 1);
@@ -206,6 +208,8 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
     g_free(hist->bins);
     hist->bins = g_new0(uint64_t, hist->nbins);
 
+    qemu_mutex_unlock(&stats->lock);
+
     return 0;
 }
 
@@ -213,12 +217,16 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
 {
     int i;
 
+    qemu_mutex_lock(&stats->lock);
+
     for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
         BlockLatencyHistogram *hist = &stats->latency_histogram[i];
         g_free(hist->bins);
         g_free(hist->boundaries);
         memset(hist, 0, sizeof(*hist));
     }
+
+    qemu_mutex_unlock(&stats->lock);
 }
 
 static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
-- 
2.55.0


