Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B92CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGES7-000853-Ge; Mon, 12 Oct 2026 07:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGERu-00084K-1A
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGERs-0008Lt-3W
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791805447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/gkR/9U9olRN9Pj34qk/SAfrtcajI1EgmNhPsJceG54=;
 b=KxO1LKefPufvOEPrEmGWaQY1cxc/2gn7WYyh/wRM2/saLVtLlllALQAcllLHQtcnCgKmXc
 Xzl9AfkA7REimj/3vI5xXl6i8bL1KHyCbFHhyjN1ORgM3Pljgsub28ZklDBSQRo646DFlA
 Gt8GvnqgNSN++QgIvG3tofQC7VZ8hG8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-VOBVqDfEPyWcgI1ycmbR-A-1; Mon,
 12 Oct 2026 11:44:03 +0000
X-MC-Unique: VOBVqDfEPyWcgI1ycmbR-A-1
X-Mimecast-MFC-AGG-ID: VOBVqDfEPyWcgI1ycmbR-A_1791805443
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4C731954B05; Mon, 12 Oct 2026 11:44:02 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 691AA1956040; Mon, 12 Oct 2026 11:44:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] block: fix leak of block histogram data
Date: Mon, 12 Oct 2026 12:43:59 +0100
Message-ID: <20261012114400.206772-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The block_acct_cleanup method failed to release memory associated
with block histograms.

Fixes: b741ae7417 (block/accounting: introduce latency histogram)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/accounting.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/accounting.c b/block/accounting.c
index 038af370170..40ed70782b4 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -80,6 +80,13 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
 void block_acct_cleanup(BlockAcctStats *stats)
 {
     BlockAcctTimedStats *s, *next;
+    size_t i;
+    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
+        BlockLatencyHistogram *hist = &stats->latency_histogram[i];
+        g_free(hist->bins);
+        g_free(hist->boundaries);
+    }
+
     QSLIST_FOREACH_SAFE(s, &stats->intervals, entries, next) {
         g_free(s);
     }
-- 
2.56.0


