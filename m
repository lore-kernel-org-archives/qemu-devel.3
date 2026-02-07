Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BA6EE0AE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voigi-00042s-Ns; Sat, 07 Feb 2026 08:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voigT-0003mK-63
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voigP-0003Hv-7K
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp9aBnO3KajDA7xQyQybSz68hMVXM/FTvW8kMmAJ+XA=;
 b=Kb+YoDnv003Dks2jh2kuZH3GrGc7QYfX+9WNCwcMyoNozZUT0g7eoUW/4XJ1Aga2QssaX5
 x/2EAozlwXvy/REaQIlfpPqcHQqAqFHrZRbEmu1eKTC7lePQyr64WMvFTQoQ1ycGLrXduC
 Et/SbutBy9lrV8Ap6dwNKK+DiQNXafA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-oTZFbYC7Pn2iSCEScRZhbA-1; Sat,
 07 Feb 2026 08:49:04 -0500
X-MC-Unique: oTZFbYC7Pn2iSCEScRZhbA-1
X-Mimecast-MFC-AGG-ID: oTZFbYC7Pn2iSCEScRZhbA_1770472143
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 107451956088; Sat,  7 Feb 2026 13:49:03 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B822318004AD; Sat,  7 Feb 2026 13:48:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 09/12] net/filter-mirror: treat redirector injections as raw
 frames
Date: Sat,  7 Feb 2026 21:47:25 +0800
Message-ID: <20260207134728.1495932-9-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Packets injected from the redirector chardev are raw Ethernet frames without a
vnet_hdr prefix. Mark them as RAW so downstream filters (e.g. dump) do not skip
vnet_hdr_len bytes, and strip the vnet_hdr prefix only when vnet_hdr_support is
enabled and a valid prefix is present.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index c1b9dabacd..de32028246 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -146,6 +146,7 @@ static int filter_send(MirrorState *s,
 }
 
 static void redirector_to_filter(NetFilterState *nf,
+                                 unsigned flags,
                                  const uint8_t *buf,
                                  int len)
 {
@@ -156,13 +157,13 @@ static void redirector_to_filter(NetFilterState *nf,
 
     if (nf->direction == NET_FILTER_DIRECTION_ALL ||
         nf->direction == NET_FILTER_DIRECTION_TX) {
-        qemu_netfilter_pass_to_next(nf->netdev, 0, &iov, 1, nf);
+        qemu_netfilter_pass_to_next(nf->netdev, flags, &iov, 1, nf);
     }
 
     if (nf->direction == NET_FILTER_DIRECTION_ALL ||
         nf->direction == NET_FILTER_DIRECTION_RX) {
-        qemu_netfilter_pass_to_next(nf->netdev->peer, 0, &iov, 1, nf);
-     }
+        qemu_netfilter_pass_to_next(nf->netdev->peer, flags, &iov, 1, nf);
+    }
 }
 
 static int redirector_chr_can_read(void *opaque)
@@ -294,12 +295,31 @@ static void redirector_rs_finalize(SocketReadState *rs)
 {
     MirrorState *s = container_of(rs, MirrorState, rs);
     NetFilterState *nf = NETFILTER(s);
+    const uint8_t *buf = rs->buf;
+    int len = rs->packet_len;
 
     /* Update indev statistics */
     s->indev_packets++;
-    s->indev_bytes += rs->packet_len;
+    s->indev_bytes += len;
+
+    /*
+     * If the sender enables vnet_hdr_support, received data includes a
+     * vnet_hdr prefix. Skip vnet_hdr_len bytes and pass the Ethernet frame.
+     */
+    if (s->vnet_hdr) {
+        if (rs->vnet_hdr_len <= 0 || rs->vnet_hdr_len >= len) {
+            return;
+        }
+        buf += rs->vnet_hdr_len;
+        len -= rs->vnet_hdr_len;
+    }
 
-    redirector_to_filter(nf, rs->buf, rs->packet_len);
+    /*
+     * Packets injected from the chardev are raw Ethernet frames without a
+     * vnet_hdr prefix. Mark them as RAW so downstream filters (e.g. dump)
+     * won't try to skip a vnet_hdr_len.
+     */
+    redirector_to_filter(nf, QEMU_NET_PACKET_FLAG_RAW, buf, len);
 }
 
 static void filter_redirector_vm_state_change(void *opaque, bool running,
-- 
2.52.0


