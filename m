Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B74C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqoL-0008EO-BN; Fri, 02 Feb 2024 05:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoJ-0008Dz-DJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoG-0001pJ-J1
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4xocvaBvjPa4sx3hQRwDEJ7tST+sUp5csWbv+7+6Mg=;
 b=VEox/K5svl7yzhl4gEn4EQT6Sz83Xr/uBOZtUM/oNDzmVcgggX+A0hNbwMfeA3IdI0uD2h
 laLublHtUub0dSoFh4jj5Mdnempgwr0/RkznLUPDZv1txmDzEf5DljBWZaHpr9zymKXswz
 wIUkoSvaCpaE/F7KTe7nDe4wBMUx/gQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-DtkEB-LGPFe9rX6iWvSlBA-1; Fri,
 02 Feb 2024 05:30:06 -0500
X-MC-Unique: DtkEB-LGPFe9rX6iWvSlBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BABB280BC80;
 Fri,  2 Feb 2024 10:30:05 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8124C400D783;
 Fri,  2 Feb 2024 10:30:01 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 09/23] migration/multifd: Rename p->num_packets and clean
 it up
Date: Fri,  2 Feb 2024 18:28:43 +0800
Message-ID: <20240202102857.110210-10-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

This field, no matter whether on src or dest, is only used for debugging
purpose.

They can even be removed already, unless it still more or less provide some
accounting on "how many packets are sent/recved for this thread".  The
other more important one is called packet_num, which is embeded in the
multifd packet headers (MultiFDPacket_t).

So let's keep them for now, but make them much easier to understand, by
doing below:

  - Rename both of them to packets_sent / packets_recved, the old
  name (num_packets) are waaay too confusing when we already have
  MultiFDPacket_t.packets_num.

  - Avoid worrying on the "initial packet": we know we will send it, that's
  good enough.  The accounting won't matter a great deal to start with 0 or
  with 1.

  - Move them to where we send/recv the packets.  They're:

    - multifd_send_fill_packet() for senders.
    - multifd_recv_unfill_packet() for receivers.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  6 +++---
 migration/multifd.c | 13 +++++--------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 08f26ef3fe..2e4ad0dc56 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -124,7 +124,7 @@ typedef struct {
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets sent through this channel */
-    uint64_t num_packets;
+    uint64_t packets_sent;
     /* non zero pages sent through this channel */
     uint64_t total_normal_pages;
     /* buffers to send */
@@ -174,8 +174,8 @@ typedef struct {
     MultiFDPacket_t *packet;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
-    /* packets sent through this channel */
-    uint64_t num_packets;
+    /* packets received through this channel */
+    uint64_t packets_recved;
     /* ramblock */
     RAMBlock *block;
     /* ramblock host address */
diff --git a/migration/multifd.c b/migration/multifd.c
index 518f9de723..eca76e2c18 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -288,6 +288,8 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
 
         packet->offset[i] = cpu_to_be64(temp);
     }
+
+    p->packets_sent++;
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -335,6 +337,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
 
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
+    p->packets_recved++;
 
     if (p->normal_num == 0) {
         return 0;
@@ -688,8 +691,6 @@ static void *multifd_send_thread(void *opaque)
         ret = -1;
         goto out;
     }
-    /* initial packet */
-    p->num_packets = 1;
 
     while (true) {
         qemu_sem_post(&multifd_send_state->channels_ready);
@@ -719,7 +720,6 @@ static void *multifd_send_thread(void *opaque)
             }
 
             multifd_send_fill_packet(p);
-            p->num_packets++;
             p->total_normal_pages += pages->num;
             trace_multifd_send(p->id, packet_num, pages->num, p->flags,
                                p->next_packet_size);
@@ -787,7 +787,7 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
 
     return NULL;
 }
@@ -1124,7 +1124,6 @@ static void *multifd_recv_thread(void *opaque)
         p->flags &= ~MULTIFD_FLAG_SYNC;
         trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
                            p->next_packet_size);
-        p->num_packets++;
         p->total_normal_pages += p->normal_num;
         qemu_mutex_unlock(&p->mutex);
 
@@ -1150,7 +1149,7 @@ static void *multifd_recv_thread(void *opaque)
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->packets_recved, p->total_normal_pages);
 
     return NULL;
 }
@@ -1252,8 +1251,6 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
-    /* initial packet */
-    p->num_packets = 1;
 
     p->running = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-- 
2.43.0


