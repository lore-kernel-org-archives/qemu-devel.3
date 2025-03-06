Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3497FC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC10-00087A-HL; Thu, 06 Mar 2025 09:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0d-0007NG-MH
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0b-0001ow-FR
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQLanTp3GDSohaLUCQp6avjWsH1FyqzHgFyDaJKhHhk=;
 b=cP+abiR0MxmY0MOwvSjyswa4zZxS7zeMfJBZ0sPY8afgdNeGfAw7+Va2V6IMuv9wC0/0aZ
 LHDkuIH8xpkAjxzK63HDTlDlWXU3C4EOzW/hgN0ededQxCoVMwIntYbvRxAMcAvrr7TuJd
 ulJyywoYeiebDOFhDfqQt5wYz2YjIKQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-hi75gCTENn-0uqNdd5x9AA-1; Thu,
 06 Mar 2025 09:15:27 -0500
X-MC-Unique: hi75gCTENn-0uqNdd5x9AA-1
X-Mimecast-MFC-AGG-ID: hi75gCTENn-0uqNdd5x9AA_1741270526
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 573941954B31; Thu,  6 Mar 2025 14:15:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2995E1801748; Thu,  6 Mar 2025 14:15:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/42] migration/multifd: Split packet into header and RAM data
Date: Thu,  6 Mar 2025 15:13:55 +0100
Message-ID: <20250306141419.2015340-20-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Read packet header first so in the future we will be able to
differentiate between a RAM multifd packet and a device state multifd
packet.

Since these two are of different size we can't read the packet body until
we know which packet type it is.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/832ad055fe447561ac1ad565d61658660cb3f63f.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/multifd.h |  5 +++++
 migration/multifd.c | 55 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index cf408ff72140a51fef7bdfc90ba11044992cfd2e..f7156f66c0f6b3872c12af7ccdab55806509fac2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -69,6 +69,11 @@ typedef struct {
     uint32_t magic;
     uint32_t version;
     uint32_t flags;
+} __attribute__((packed)) MultiFDPacketHdr_t;
+
+typedef struct {
+    MultiFDPacketHdr_t hdr;
+
     /* maximum number of allocated pages */
     uint32_t pages_alloc;
     /* non zero pages */
diff --git a/migration/multifd.c b/migration/multifd.c
index 215ad0414a799cfb389c501331de5e505600905d..3b47e63c2c4a6a65751b4eb4e9501a443695ff8f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -209,10 +209,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     memset(packet, 0, p->packet_len);
 
-    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
-    packet->version = cpu_to_be32(MULTIFD_VERSION);
+    packet->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
+    packet->hdr.version = cpu_to_be32(MULTIFD_VERSION);
 
-    packet->flags = cpu_to_be32(p->flags);
+    packet->hdr.flags = cpu_to_be32(p->flags);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
 
     packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
@@ -228,12 +228,12 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
                             p->flags, p->next_packet_size);
 }
 
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
+                                             const MultiFDPacketHdr_t *hdr,
+                                             Error **errp)
 {
-    const MultiFDPacket_t *packet = p->packet;
-    uint32_t magic = be32_to_cpu(packet->magic);
-    uint32_t version = be32_to_cpu(packet->version);
-    int ret = 0;
+    uint32_t magic = be32_to_cpu(hdr->magic);
+    uint32_t version = be32_to_cpu(hdr->version);
 
     if (magic != MULTIFD_MAGIC) {
         error_setg(errp, "multifd: received packet magic %x, expected %x",
@@ -247,7 +247,16 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
-    p->flags = be32_to_cpu(packet->flags);
+    p->flags = be32_to_cpu(hdr->flags);
+
+    return 0;
+}
+
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    const MultiFDPacket_t *packet = p->packet;
+    int ret = 0;
+
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
@@ -1165,14 +1174,18 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     while (true) {
+        MultiFDPacketHdr_t hdr;
         uint32_t flags = 0;
         bool has_data = false;
+        uint8_t *pkt_buf;
+        size_t pkt_len;
+
         p->normal_num = 0;
 
         if (use_packets) {
             struct iovec iov = {
-                .iov_base = (void *)p->packet,
-                .iov_len = p->packet_len
+                .iov_base = (void *)&hdr,
+                .iov_len = sizeof(hdr)
             };
 
             if (multifd_recv_should_exit()) {
@@ -1191,6 +1204,26 @@ static void *multifd_recv_thread(void *opaque)
                 break;
             }
 
+            ret = multifd_recv_unfill_packet_header(p, &hdr, &local_err);
+            if (ret) {
+                break;
+            }
+
+            pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
+            pkt_len = p->packet_len - sizeof(hdr);
+
+            ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
+                                           &local_err);
+            if (!ret) {
+                /* EOF */
+                error_setg(&local_err, "multifd: unexpected EOF after packet header");
+                break;
+            }
+
+            if (ret == -1) {
+                break;
+            }
+
             qemu_mutex_lock(&p->mutex);
             ret = multifd_recv_unfill_packet(p, &local_err);
             if (ret) {
-- 
2.48.1


