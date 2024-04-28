Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D692CC19F53
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXt-0002dC-6u; Sun, 28 Apr 2024 03:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXp-0002Wm-0u
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:53 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXm-0005UA-Ex
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:52 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2b1817f0d34so73033a91.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287709; x=1714892509;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kIQXmifnPWoXrMYCJzyZR+Oo5RYOWKTwINiEQw0HTbk=;
 b=Y4TXZxBaaF8ONesDdY6L05yLUvl5tfyYDovexLmJ2HvaW01jDPo4dsEqRrBgwfxLVR
 PNEYYIiruZYUPeCDFzlatOESwK7oo1WyZkhAutjLkdipusEfXs/JeHarP+gK6PmbKLPr
 GvIlChs6PZmvMpHsteIcyeYTS587dH8lnPx5aOgnW/j4VJlYp6Wesp9A9GDEhiWSGFpE
 nicVlsVnXXoq9RqvQW4r6zYNCFC1/3JGYnxYwFxR0Q4rYlnGpjMmake5GnkEI5jl835W
 PljUB2dAwscmlYH5c+0rnJk0Z4HuC1JE2gCydKKlqDStUoXyBFV+SVEYBWi+Rim107Pz
 mf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287709; x=1714892509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kIQXmifnPWoXrMYCJzyZR+Oo5RYOWKTwINiEQw0HTbk=;
 b=c91uyMRN/icmskkMv6Ps8fsY029KXxLxuc9I1zhf+k1wAW/tWgBD3Vpy4/L1775ReU
 3141Bg64CM5ctzdo6wWaWfbsiLAmaZXykgq+z7OzuvuAWcc9MFIy6Ju6icbY5tiCXtAU
 95gu8pfAaF+fka8XjfqwDJiRjppB5o8nVkeBrELB6tlWGs12+ZpvbhEWjfz7rgas1R51
 IyUuILwJgNKWnnQ8xZhaeyG8JBwQQ73HPrbePaRbz2xVYx92SwS6PBtXWFEwYp19Ubtq
 /dCBiXPq67snMglOWfHIOYOeAHHk79qin9SEwre41ogvmM/XiyroakSLEZaDwPmVdBJT
 W7Uw==
X-Gm-Message-State: AOJu0YyD+0bcCh+Y77t+6/d7tyMn7ZbHXWtG0vkwfs+QR78yN2U6S6LI
 q7sg0HsDedO6zjTIbnjHK20Ip62QE94rjuqUi3zlJWkNLWIPcjHU3b8o+Ql3Qgc=
X-Google-Smtp-Source: AGHT+IHTUAljJwX9TUaorAmGBJEH2yKx2F0EbfjQpuPhgco6C61B3bmrafuDd18YsPHGy2NzhNzXyQ==
X-Received: by 2002:a17:90a:fe0c:b0:2b0:88eb:dbcf with SMTP id
 ck12-20020a17090afe0c00b002b088ebdbcfmr3495414pjb.29.1714287709155; 
 Sun, 28 Apr 2024 00:01:49 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 d2-20020a17090a114200b002a533330849sm18802770pje.16.2024.04.28.00.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:57 +0900
Subject: [PATCH v10 14/18] virtio-net: Do not write hashes to peer buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-14-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The peer buffer is qualified with const and not meant to be modified.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 527aac3a0465..c8059dc99bd4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1830,16 +1830,9 @@ static uint8_t virtio_net_get_hash_type(bool hasip4,
     return 0xff;
 }
 
-static void virtio_set_packet_hash(const uint8_t *buf, uint8_t report,
-                                   uint32_t hash)
-{
-    struct virtio_net_hdr_v1_hash *hdr = (void *)buf;
-    hdr->hash_value = hash;
-    hdr->hash_report = report;
-}
-
 static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
-                                  size_t size)
+                                  size_t size,
+                                  struct virtio_net_hdr_v1_hash *hdr)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     unsigned int index = nc->queue_index, new_index = index;
@@ -1870,7 +1863,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
                                              n->rss_data.hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
-            virtio_set_packet_hash(buf, VIRTIO_NET_HASH_REPORT_NONE, 0);
+            hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
+            hdr->hash_report = 0;
         }
         return n->rss_data.redirect ? n->rss_data.default_queue : -1;
     }
@@ -1878,7 +1872,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
 
     if (n->rss_data.populate_hash) {
-        virtio_set_packet_hash(buf, reports[net_hash_type], hash);
+        hdr->hash_value = hash;
+        hdr->hash_report = reports[net_hash_type];
     }
 
     if (n->rss_data.redirect) {
@@ -1898,7 +1893,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
     struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
-    struct virtio_net_hdr_mrg_rxbuf mhdr;
+    struct virtio_net_hdr_v1_hash extra_hdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
@@ -1908,7 +1903,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
-        int index = virtio_net_process_rss(nc, buf, size);
+        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
             NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
             return virtio_net_receive_rcu(nc2, buf, size, true);
@@ -1968,15 +1963,17 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             if (n->mergeable_rx_bufs) {
                 mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
                                     sg, elem->in_num,
-                                    offsetof(typeof(mhdr), num_buffers),
-                                    sizeof(mhdr.num_buffers));
+                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
+                                    sizeof(extra_hdr.hdr.num_buffers));
             }
 
             receive_header(n, sg, elem->in_num, buf, size);
             if (n->rss_data.populate_hash) {
-                offset = sizeof(mhdr);
+                offset = offsetof(typeof(extra_hdr), hash_value);
                 iov_from_buf(sg, elem->in_num, offset,
-                             buf + offset, n->host_hdr_len - sizeof(mhdr));
+                             (char *)&extra_hdr + offset,
+                             sizeof(extra_hdr.hash_value) +
+                             sizeof(extra_hdr.hash_report));
             }
             offset = n->host_hdr_len;
             total += n->guest_hdr_len;
@@ -2022,10 +2019,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (mhdr_cnt) {
-        virtio_stw_p(vdev, &mhdr.num_buffers, i);
+        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
         iov_from_buf(mhdr_sg, mhdr_cnt,
                      0,
-                     &mhdr.num_buffers, sizeof mhdr.num_buffers);
+                     &extra_hdr.hdr.num_buffers,
+                     sizeof extra_hdr.hdr.num_buffers);
     }
 
     for (j = 0; j < i; j++) {

-- 
2.44.0


