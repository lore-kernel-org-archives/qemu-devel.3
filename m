Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FBAFED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aGP-0004ho-7M; Thu, 12 Mar 2026 03:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGN-0004gH-EH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGH-00005c-Ts
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRjhQm8jH2uwusTbR6Ayv6BqAo5wOh620xzE17J8kNQ=;
 b=UD4koe2NFyAQoxsYLPdxKj7C06aAj3G1dRipELfYQpAdz+tJG743HxJgLj9abthfJRzVXp
 hyE6y0GyNvxQj7HIHvZXHM9GyXGplT4F6accJezYFgRlHIQCZMEnb7zzPmGc26HBnE/Xc8
 7sl2B4viv4XYU1gg6zwsfU3Ai/5DMYw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-k_kV1QUmNRSvdeGCqZb69Q-1; Thu,
 12 Mar 2026 03:15:09 -0400
X-MC-Unique: k_kV1QUmNRSvdeGCqZb69Q-1
X-Mimecast-MFC-AGG-ID: k_kV1QUmNRSvdeGCqZb69Q_1773299708
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BCA41977405; Thu, 12 Mar 2026 07:15:08 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74B6719540C2; Thu, 12 Mar 2026 07:15:04 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 4/9] net/filter-redirector: add send helpers and netdev
 counters
Date: Thu, 12 Mar 2026 15:09:32 +0800
Message-ID: <20260312071415.1836655-5-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Add helper functions for sending packets through the AF_PACKET out
socket or the chardev backend, and add netdev RX/TX packet and byte
counters to MirrorState.

The follow-up receive-path changes use these helpers and expose the new
statistics via filter_redirector_get_stats().

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 915f2f8b35..e57fbc94b8 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -64,6 +64,11 @@ struct MirrorState {
     uint64_t indev_bytes;
     uint64_t outdev_packets;
     uint64_t outdev_bytes;
+    /* netdev replay/capture statistics for filter-redirector */
+    uint64_t netdev_rx_packets;
+    uint64_t netdev_rx_bytes;
+    uint64_t netdev_tx_packets;
+    uint64_t netdev_tx_bytes;
 };
 
 typedef struct FilterSendCo {
@@ -175,6 +180,59 @@ static int filter_send(MirrorState *s,
     return data.ret;
 }
 
+static ssize_t filter_redirector_send_netdev_packet(MirrorState *s,
+                                                    const struct iovec *iov,
+                                                    int iovcnt)
+{
+    ssize_t size = iov_size(iov, iovcnt);
+    g_autofree uint8_t *buf = NULL;
+
+    if (s->out_netfd < 0) {
+        return -ENODEV;
+    }
+    if (size > NET_BUFSIZE) {
+        return -EINVAL;
+    }
+
+    buf = g_malloc(size);
+    iov_to_buf(iov, iovcnt, 0, buf, size);
+
+    ssize_t ret = send(s->out_netfd, buf, size, 0);
+    if (ret < 0) {
+        return -errno;
+    }
+    if (ret > 0) {
+        s->netdev_tx_packets++;
+        s->netdev_tx_bytes += ret;
+    }
+    return ret;
+}
+static ssize_t filter_redirector_send_chardev_iov(MirrorState *s,
+                                                  const struct iovec *iov,
+                                                  int iovcnt)
+{
+    if (!s->outdev) {
+        return -ENODEV;
+    }
+
+    if (!qemu_chr_fe_backend_connected(&s->chr_out)) {
+        return 0;
+    }
+
+    return filter_send(s, iov, iovcnt);
+}
+
+static ssize_t filter_redirector_send_netdev_iov(MirrorState *s,
+                                                 const struct iovec *iov,
+                                                 int iovcnt)
+{
+    if (s->out_netfd < 0) {
+        return -ENODEV;
+    }
+
+    return filter_redirector_send_netdev_packet(s, iov, iovcnt);
+}
+
 static void redirector_to_filter(NetFilterState *nf,
                                  const uint8_t *buf,
                                  int len)
@@ -763,6 +821,18 @@ static GList *filter_redirector_get_stats(NetFilterState *nf)
     counter->bytes = s->outdev_bytes;
     list = g_list_append(list, counter);
 
+    counter = g_new0(NetFilterCounter, 1);
+    counter->name = g_strdup("netdev_rx");
+    counter->packets = s->netdev_rx_packets;
+    counter->bytes = s->netdev_rx_bytes;
+    list = g_list_append(list, counter);
+
+    counter = g_new0(NetFilterCounter, 1);
+    counter->name = g_strdup("netdev_tx");
+    counter->packets = s->netdev_tx_packets;
+    counter->bytes = s->netdev_tx_bytes;
+    list = g_list_append(list, counter);
+
     return list;
 }
 
-- 
2.52.0


