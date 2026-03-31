Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B18A1061B21
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7WIw-0006YW-OK; Tue, 31 Mar 2026 06:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7WIk-0006Ne-L2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7WIi-0003y7-Tu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774952783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YMX7uqCepZbBy0LM9S6dtaAYYNd8bWTL8dzhvurWY/c=;
 b=T0Fz1+qY0KwTkOdH96H3Bh9g1Ox518+CYcmxDJrs1sgrtOY7w5MAw8CZF6YXIOSdhoa48w
 BBgMYSVRnn+r4g5EhbO7N85CQaxJd5rxH6YGqZcFKalaxJdk9TLC3L62gFiFZYfsSHz100
 p6UKriLFBKjND21MzEMSU0AnKPLoy7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-kE__8mKrNe-6d7kTvaqrEw-1; Tue,
 31 Mar 2026 06:26:20 -0400
X-MC-Unique: kE__8mKrNe-6d7kTvaqrEw-1
X-Mimecast-MFC-AGG-ID: kE__8mKrNe-6d7kTvaqrEw_1774952779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62695195607B; Tue, 31 Mar 2026 10:26:19 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.50.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4A9E19560AB; Tue, 31 Mar 2026 10:26:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	hreitz@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH] block: Fix crash after setting latency historygram with
 single bin
Date: Tue, 31 Mar 2026 12:26:08 +0200
Message-ID: <20260331102608.60882-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Passing an empty list of boundaries to block-latency-histogram-set sets
up a state that leads to a NULL pointer dereference when the next
request should be accounted for. This is not a useful configuration, so
just error out if the user tries to set it.

The crash can easily be reproduced with the following script:

    qmp() {
    cat <<EOF
    {'execute':'qmp_capabilities'}
    {'execute':'block-latency-histogram-set',
     'arguments': {'id':'ide0','boundaries':[]}}
    {'execute':'cont'}
    EOF
    }

    qmp | ./qemu-system-x86_64 -S -qmp stdio \
        -drive if=none,format=raw,file=null-co:// \
        -device ide-hd,drive=none0,id=ide0

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/accounting.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/accounting.c b/block/accounting.c
index 5cf51f029b1..f00fe997403 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -185,6 +185,15 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
         prev = entry->value;
     }
 
+    /*
+     * block_latency_histogram_account() assumes that it can always access
+     * hist->boundaries[0], so require at least one boundary. A histogram with
+     * a single bin is useless anyway.
+     */
+    if (new_nbins <= 1) {
+        return -EINVAL;
+    }
+
     hist->nbins = new_nbins;
     g_free(hist->boundaries);
     hist->boundaries = g_new(uint64_t, hist->nbins - 1);
-- 
2.53.0


