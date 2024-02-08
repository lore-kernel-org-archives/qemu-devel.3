Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08151C4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXuku-0007GW-6E; Wed, 07 Feb 2024 22:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujy-0006Kj-Rc
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujx-0004Mt-5q
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVjPcPPLJ3RpMmbR7Nkhhoz2QLEcIP6RZZBw/2/XOyQ=;
 b=HLKBc4f/8nBljIWeu2gmJhXepc4g+ynEM1HcPoFRcI/Xs9ZChQxYy4s6hYtBvGn1yuUzRz
 k/l6z71ZKb0DMPZhDj7W0bW2Jn3rmwI51baonUaY6ZN25F7kgrWaBU/7udPiooHUXmLfed
 MD/F3CzNjR+uvd8W+aLQDoUiEf7Vz8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-CjK9iwiDOZaE90mNVcC8sQ-1; Wed, 07 Feb 2024 22:06:10 -0500
X-MC-Unique: CjK9iwiDOZaE90mNVcC8sQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95060101FA2C;
 Thu,  8 Feb 2024 03:06:10 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 395CE492BC7;
 Thu,  8 Feb 2024 03:06:07 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 12/34] migration/multifd: Move trace_multifd_send|recv()
Date: Thu,  8 Feb 2024 11:05:06 +0800
Message-ID: <20240208030528.368214-13-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Move them into fill/unfill of packets.  With that, we can further cleanup
the send/recv thread procedure, and remove one more temp var.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-12-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 94a0124934..44163e4e28 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -291,6 +291,9 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
 
     p->packets_sent++;
     p->total_normal_pages += pages->num;
+
+    trace_multifd_send(p->id, p->packet_num, pages->num, p->flags,
+                       p->next_packet_size);
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -341,6 +344,9 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->packets_recved++;
     p->total_normal_pages += p->normal_num;
 
+    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->flags,
+                       p->next_packet_size);
+
     if (p->normal_num == 0) {
         return 0;
     }
@@ -704,7 +710,6 @@ static void *multifd_send_thread(void *opaque)
         qemu_mutex_lock(&p->mutex);
 
         if (qatomic_read(&p->pending_job)) {
-            uint64_t packet_num = p->packet_num;
             MultiFDPages_t *pages = p->pages;
 
             if (use_zero_copy_send) {
@@ -722,8 +727,6 @@ static void *multifd_send_thread(void *opaque)
             }
 
             multifd_send_fill_packet(p);
-            trace_multifd_send(p->id, packet_num, pages->num, p->flags,
-                               p->next_packet_size);
 
             if (use_zero_copy_send) {
                 /* Send header first, without zerocopy */
@@ -1123,8 +1126,6 @@ static void *multifd_recv_thread(void *opaque)
         flags = p->flags;
         /* recv methods don't know how to handle the SYNC flag */
         p->flags &= ~MULTIFD_FLAG_SYNC;
-        trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
-                           p->next_packet_size);
         qemu_mutex_unlock(&p->mutex);
 
         if (p->normal_num) {
-- 
2.43.0


