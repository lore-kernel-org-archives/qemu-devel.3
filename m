Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7D1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmh7-0007Z2-Qy; Thu, 09 Jul 2026 07:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1whmh6-0007Tr-0m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1whmh4-0008CC-Jq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783595606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HPGeFdKp9c4AA1rheo5WbdAx2MEAMMBk+RR9fSIb+ew=;
 b=alO9FH+r2IPDGgxl+N7mCz77SZDCg2HmNrIPUh/7q92/jHjLnEEzSSOYbDbs2TFBEHn0ub
 gXB3VZPN8hLFZ00sMr2XszKpuaQM6dyQXeP9Y4/0TdtJaRSAwINSQOvgr9DSi7UQLkDt5S
 FTdAT49oo6w6KbMsryjorvJMRrdkOuU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-VvnX50MAOg6N17poQt7oJw-1; Thu,
 09 Jul 2026 07:13:22 -0400
X-MC-Unique: VvnX50MAOg6N17poQt7oJw-1
X-Mimecast-MFC-AGG-ID: VvnX50MAOg6N17poQt7oJw_1783595601
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B72C1800867; Thu,  9 Jul 2026 11:13:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1145F180059F; Thu,  9 Jul 2026 11:13:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH] net/colo: fix g_hash_table_destroy assertion on uninitialized
 filter
Date: Thu,  9 Jul 2026 15:13:15 +0400
Message-ID: <20260709111315.1108185-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

colo_rewriter_cleanup() unconditionally destroys connection_track_table,
but the table is only allocated in colo_rewriter_setup(). When the
filter-rewriter object is finalized without having been set up (e.g.
during qom-test property enumeration), the pointer is NULL and
g_hash_table_destroy() fires an assertion.

Use g_clear_pointer() to skip the destroy when the table was never
initialized.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 net/filter-rewriter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index cdf85aa5eed..c85d180eb96 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -373,7 +373,7 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
         g_free(s->incoming_queue);
     }
 
-    g_hash_table_destroy(s->connection_track_table);
+    g_clear_pointer(&s->connection_track_table, g_hash_table_destroy);
 }
 
 static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
-- 
2.55.0


