Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2D6D12D78
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 06:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAO6n-0006mK-81; Mon, 11 Nov 2024 01:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6d-0006kb-OI
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:41:01 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6c-0000fS-13
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:59 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720c286bcd6so3489868b3a.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 22:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731307256; x=1731912056;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NDL1NP5K5bOcbgjLwqMXNqM37U/dezgHiGmS6DKu8Qk=;
 b=ycDPGvrq4KnaKIoePLh9Kj3w/H3f5HXl7HZU2nyg6/6gCFeacEzCfe910t/wDW0i7D
 rQoUskQj1PCfScskgqVVXqMkpEapl0UbvgAfC/ZmaLcyg1slZmsBfpovfkhbH7SynDPB
 7y+7u2cErpLvmNBieRgpvksXXqgwgBrAJiV+T4yrHHGd6Ft5ZamNvJOf6TJV39Dyv5S/
 8qbRx+l6gBsFrxckJOPYOZb/uQS4fwLVjiBbYQR08rMxzSaMvTVTd/pFN4KtcPMJU+xN
 EIvEXxBX7WCm2vg04/54Yvf7J/Sooa/GhsYCcB/KhpQ9V6QNLhk/IFcfdReDbkPEc10/
 ZEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731307256; x=1731912056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDL1NP5K5bOcbgjLwqMXNqM37U/dezgHiGmS6DKu8Qk=;
 b=Wz88dEFhPzcP6n2zd+sE/en+x2pNFOk+3zKWZFEf7bv8/Em/r72tLstiVN+R5lgy/L
 VZjYLtEo1lA59CvsuRKl5U5BlwzkEAg6qbm69TuOCcfSkBlw8SAGIhEtHHwXzi4QrDCq
 jVe8XrmoT67XJKmPuqp0smKMJj1d5nofskHcjjVg9zeQzfft0CpIpda4wtxhRE/mQQSE
 11ySyhj+R9evRB/BNDV0coItVYv9Lf+LYys6H6mCABZH84M/Io6tgO6vdSpI8pJ0q6oz
 hxR+VR+Uzoj5cygBzswh+vvBcXk3cR4nWVzWQ6maRJ4nHYi6QUD/A0oyYXVa66PvBQTG
 iXhA==
X-Gm-Message-State: AOJu0YwlRV63p7XGfMIW4yu8QXJDPQ3v6IkX5UZvzVjp6bACLE7g9Uwg
 lpaRcDPTctk6pu3uwwWIwKkqKO9tJZ+94G+yZyJvr9gQaZEcteZrzJ3G+1FHzw1OkjHikjSs702
 T478=
X-Google-Smtp-Source: AGHT+IEeJypxeoDWAw0eQrX+DZKq6GfD9f0nw7qWXwk9EnPz1rcpjHJJOPOt3SYzlJbuU9V83FKPYQ==
X-Received: by 2002:a05:6a21:398:b0:1dc:e:e996 with SMTP id
 adf61e73a8af0-1dc22b63711mr15829369637.33.1731307256423; 
 Sun, 10 Nov 2024 22:40:56 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7f41f65ba85sm6592719a12.73.2024.11.10.22.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 22:40:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Nov 2024 15:40:21 +0900
Subject: [PATCH v2 4/6] virtio-net: Fix hash reporting when the queue changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-queue-v2-4-2f7883a1004f@daynix.com>
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
In-Reply-To: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio_net_process_rss() fills the values used for hash reporting, but
the values used to be thrown away with a recursive function call if
the queue changes after RSS. Avoid the function call to keep the values.

Fixes: a4c960eedcd2 ("virtio-net: Do not write hashes to peer buffer")
Buglink: https://issues.redhat.com/browse/RHEL-59572
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index abbb22e40f9f..ea5faaf16422 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1893,10 +1893,10 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
 }
 
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
-                                      size_t size, bool no_rss)
+                                      size_t size)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
-    VirtIONetQueue *q = virtio_net_get_subqueue(nc);
+    VirtIONetQueue *q;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
@@ -1906,12 +1906,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
+    if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
-            NetClientState *nc2 =
-                qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
-            return virtio_net_receive_rcu(nc2, buf, size, true);
+            nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
         }
     }
 
@@ -1919,6 +1917,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
+    q = virtio_net_get_subqueue(nc);
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;
@@ -2044,7 +2044,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size, false);
+    return virtio_net_receive_rcu(nc, buf, size);
 }
 
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,

-- 
2.47.0


