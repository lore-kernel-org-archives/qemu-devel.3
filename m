Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C32BC3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESdR-0008WA-A5; Mon, 12 May 2025 08:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uESdO-0008VD-Tu
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uESdL-0005cE-Ph
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747054305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqO6v2f8ptpnS0y81ZBzuNwN7yATriyketYADzQ9aB8=;
 b=P30EsmX/PeCvUqMuDARfoFVDaa7f1YGktvlnfUztScy7loZU4VNi/J/b2zJc3hGWCx7g04
 T1UFGP43TxrlcFs1Mq/7N3r98PVHlz+xi+cB8ukQcPp77y3N8RrdkrCgAg+dIQNRwoQ4h5
 iSyDfjDjo0R1FOtSTqGYUhowyIQpq4c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-S0ui_tnmPEehuukHWdJGXg-1; Mon,
 12 May 2025 08:51:43 -0400
X-MC-Unique: S0ui_tnmPEehuukHWdJGXg-1
X-Mimecast-MFC-AGG-ID: S0ui_tnmPEehuukHWdJGXg_1747054301
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00BAE1800446; Mon, 12 May 2025 12:51:41 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.80.184])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A71219560A3; Mon, 12 May 2025 12:51:36 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v11 1/3] migration: write zero pages when postcopy enabled
Date: Mon, 12 May 2025 18:21:22 +0530
Message-ID: <20250512125124.147064-2-ppandit@redhat.com>
In-Reply-To: <20250512125124.147064-1-ppandit@redhat.com>
References: <20250512125124.147064-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

During multifd migration, zero pages are written if
they are migrated more than once.

This may result in a migration thread hang issue when
multifd and postcopy are enabled together.

When postcopy is enabled, always write zero pages as and
when they are migrated.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/multifd-zero-page.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

v11:
- s/ones/once, remove capitalisations and call _test_byte_offset() once

v10:
- https://lore.kernel.org/qemu-devel/20250508122849.207213-2-ppandit@redhat.com/T/#t

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index dbc1184921..4cde868159 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -85,9 +85,27 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
         void *page = p->host + p->zero[i];
-        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
+        bool received =
+                ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i]);
+
+        /*
+         * During multifd migration zero page is written to the memory
+         * only if it is migrated more than once.
+         *
+         * It becomes a problem when both multifd & postcopy options are
+         * enabled. If the zero page which was skipped during multifd phase,
+         * is accessed during the postcopy phase of the migration, a page
+         * fault occurs. But this page fault is not served because the
+         * 'receivedmap' says the zero page is already received. Thus the
+         * thread accessing that page may hang.
+         *
+         * When postcopy is enabled, always write the zero page as and when
+         * it is migrated.
+         */
+        if (migrate_postcopy_ram() || received) {
             memset(page, 0, multifd_ram_page_size());
-        } else {
+        }
+        if (!received) {
             ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
         }
     }
--
2.49.0


