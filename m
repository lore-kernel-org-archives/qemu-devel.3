Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940A1C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulH-0008MU-Tz; Wed, 07 Feb 2024 22:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukW-0006pz-VG
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukU-0004P9-0F
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36Q5NpS1cXhMGO51+Jo7M+vKFKUYs03V1nHpn7mJj4c=;
 b=BlPSmfCqW+9c/7upbvnEgPlIqI3xsOu2ag2Z/xSjxoGstwDtm9A1S8lSOQeGGX4M/miRgS
 wdHwNSG4QlEcMKMJHGFg7Ji8PG/ZLVxfAjWovx1qAiQHV/D1sZGbo6UofRMQ9BOZfGfDYh
 wmu+fuLr+cm9X5sCMLgmywaHqJumIkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668--5qo_JUsP3CmZxNKU1ecYw-1; Wed, 07 Feb 2024 22:06:45 -0500
X-MC-Unique: -5qo_JUsP3CmZxNKU1ecYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC42B845E61;
 Thu,  8 Feb 2024 03:06:44 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38665492BC7;
 Thu,  8 Feb 2024 03:06:41 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PULL 23/34] migration/multifd: Fix MultiFDSendParams.packet_num race
Date: Thu,  8 Feb 2024 11:05:17 +0800
Message-ID: <20240208030528.368214-24-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As reported correctly by Fabiano [1] (while per Fabiano, it sourced back to
Elena's initial report in Oct 2023), MultiFDSendParams.packet_num is buggy
to be assigned and stored.  Consider two consequent operations of: (1)
queue a job into multifd send thread X, then (2) queue another sync request
to the same send thread X.  Then the MultiFDSendParams.packet_num will be
assigned twice, and the first assignment can get lost already.

To avoid that, we move the packet_num assignment from p->packet_num into
where the thread will fill in the packet.  Use atomic operations to protect
the field, making sure there's no race.

Note that atomic fetch_add() may not be good for scaling purposes, however
multifd should be fine as number of threads should normally not go beyond
16 threads.  Let's leave that concern for later but fix the issue first.

There's also a trick on how to make it always work even on 32 bit hosts for
uint64_t packet number.  Switching to uintptr_t as of now to simply the
case.  It will cause packet number to overflow easier on 32 bit, but that
shouldn't be a major concern for now as 32 bit systems is not the major
audience for any performance concerns like what multifd wants to address.

We also need to move multifd_send_state definition upper, so that
multifd_send_fill_packet() can reference it.

[1] https://lore.kernel.org/r/87o7d1jlu5.fsf@suse.de

Reported-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-23-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  2 --
 migration/multifd.c | 56 +++++++++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 9b40a53cb6..98876ff94a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -97,8 +97,6 @@ typedef struct {
     bool running;
     /* multifd flags for each packet */
     uint32_t flags;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
     /*
      * The sender thread has work to do if either of below boolean is set.
      *
diff --git a/migration/multifd.c b/migration/multifd.c
index 130f86a1fb..b317d57d61 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -45,6 +45,35 @@ typedef struct {
     uint64_t unused2[4];    /* Reserved for future use */
 } __attribute__((packed)) MultiFDInit_t;
 
+struct {
+    MultiFDSendParams *params;
+    /* array of pages to sent */
+    MultiFDPages_t *pages;
+    /*
+     * Global number of generated multifd packets.
+     *
+     * Note that we used 'uintptr_t' because it'll naturally support atomic
+     * operations on both 32bit / 64 bits hosts.  It means on 32bit systems
+     * multifd will overflow the packet_num easier, but that should be
+     * fine.
+     *
+     * Another option is to use QEMU's Stat64 then it'll be 64 bits on all
+     * hosts, however so far it does not support atomic fetch_add() yet.
+     * Make it easy for now.
+     */
+    uintptr_t packet_num;
+    /* send channels ready */
+    QemuSemaphore channels_ready;
+    /*
+     * Have we already run terminate threads.  There is a race when it
+     * happens that we got one error while we are exiting.
+     * We will use atomic operations.  Only valid values are 0 and 1.
+     */
+    int exiting;
+    /* multifd ops */
+    MultiFDMethods *ops;
+} *multifd_send_state;
+
 /* Multifd without compression */
 
 /**
@@ -292,13 +321,16 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     MultiFDPages_t *pages = p->pages;
+    uint64_t packet_num;
     int i;
 
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
     packet->normal_pages = cpu_to_be32(pages->num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
-    packet->packet_num = cpu_to_be64(p->packet_num);
+
+    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
+    packet->packet_num = cpu_to_be64(packet_num);
 
     if (pages->block) {
         strncpy(packet->ramblock, pages->block->idstr, 256);
@@ -314,7 +346,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     p->packets_sent++;
     p->total_normal_pages += pages->num;
 
-    trace_multifd_send(p->id, p->packet_num, pages->num, p->flags,
+    trace_multifd_send(p->id, packet_num, pages->num, p->flags,
                        p->next_packet_size);
 }
 
@@ -398,24 +430,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-struct {
-    MultiFDSendParams *params;
-    /* array of pages to sent */
-    MultiFDPages_t *pages;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-    /* send channels ready */
-    QemuSemaphore channels_ready;
-    /*
-     * Have we already run terminate threads.  There is a race when it
-     * happens that we got one error while we are exiting.
-     * We will use atomic operations.  Only valid values are 0 and 1.
-     */
-    int exiting;
-    /* multifd ops */
-    MultiFDMethods *ops;
-} *multifd_send_state;
-
 static bool multifd_send_should_exit(void)
 {
     return qatomic_read(&multifd_send_state->exiting);
@@ -497,7 +511,6 @@ static bool multifd_send_pages(void)
      */
     assert(qatomic_read(&p->pending_job) == false);
     qatomic_set(&p->pending_job, true);
-    p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
     qemu_mutex_unlock(&p->mutex);
@@ -730,7 +743,6 @@ int multifd_send_sync_main(void)
         trace_multifd_send_sync_main_signal(p->id);
 
         qemu_mutex_lock(&p->mutex);
-        p->packet_num = multifd_send_state->packet_num++;
         /*
          * We should be the only user so far, so not possible to be set by
          * others concurrently.
-- 
2.43.0


