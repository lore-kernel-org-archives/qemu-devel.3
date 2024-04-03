Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23A2CD1299
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs2lu-0000Gk-BL; Wed, 03 Apr 2024 11:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rs2ls-0000Ft-Tt
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:43:28 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rs2lo-0007go-Ts
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:43:26 -0400
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-a4644bde1d4so893322566b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712159003; x=1712763803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WYy0xsk/6e7/EP3ZA06B/kwt1hnSoccxl0+aSYTRzhw=;
 b=iy1nZsE0hDudZnQVhgzXtDxP6tEN4XFFiqxR+XOhP/vdvsSvJs9FS0wERrngNzn5th
 /DlX3pLYg/fW1d9xUYvO3G80E+MdbEY3rt3/RfUfLpUL7EpcSH7CgCtnZg9tEMToGJtw
 rlVUUWRogWzMn+j1PFfHbicUgKhrvdMla5jSjgZO676WAAqORzfnu5IC0Nb1wU9REb/l
 jZTBNZ4y+3iS6450V4JxTINdWIC97F3MNwIKXg1u5gAJVKsNxnfybt9qb7QvVjue/luS
 Ej6GVQRKxEc3wvrtjH5JB4M1kt1NUpjNaGX4MXOx0H8TUlNpb+SiKZ/7czu64OlEvBY9
 N6ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+JDTjr8tGrdKjwRtH+9Za9n+sEPwBlh33pQdKRuDsathGsqT6vDuy8xGirdaeo1G2p+woEcgobLxTPz35KvNJzf7pmuI=
X-Gm-Message-State: AOJu0YxLEMTV6drZTJKv4OFrxHoEV82kIc7CKYrGowBmsNnTHsXtPag0
 K1kVlLsSWqoB+DG93fpk0KHZl1hxzLa7WnQlX2gfiyqvJeD89kuQ/Sp8iXFZ
X-Google-Smtp-Source: AGHT+IGjMXBqyqOYrFRXxpu0T86R9H2NUxfGQRZ7Sm1nQSfyM8IFBGndg+xpb3YMbBIoQ8iZBhCSaA==
X-Received: by 2002:a17:907:868d:b0:a51:7d1a:e10d with SMTP id
 qa13-20020a170907868d00b00a517d1ae10dmr503935ejc.32.1712159002989; 
 Wed, 03 Apr 2024 08:43:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net.
 [2a03:2880:30ff:8::face:b00c]) by smtp.gmail.com with ESMTPSA id
 wn2-20020a170907068200b00a4e781bd30dsm3029235ejb.24.2024.04.03.08.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:43:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4] virtio_net: Do not send RSS key if it is not supported
Date: Wed,  3 Apr 2024 08:43:12 -0700
Message-ID: <20240403154313.1331319-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47;
 envelope-from=breno.debian@gmail.com; helo=mail-ej1-f47.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There is a bug when setting the RSS options in virtio_net that can break
the whole machine, getting the kernel into an infinite loop.

Running the following command in any QEMU virtual machine with virtionet
will reproduce this problem:

    # ethtool -X eth0  hfunc toeplitz

This is how the problem happens:

1) ethtool_set_rxfh() calls virtnet_set_rxfh()

2) virtnet_set_rxfh() calls virtnet_commit_rss_command()

3) virtnet_commit_rss_command() populates 4 entries for the rss
scatter-gather

4) Since the command above does not have a key, then the last
scatter-gatter entry will be zeroed, since rss_key_size == 0.
sg_buf_size = vi->rss_key_size;

5) This buffer is passed to qemu, but qemu is not happy with a buffer
with zero length, and do the following in virtqueue_map_desc() (QEMU
function):

  if (!sz) {
      virtio_error(vdev, "virtio: zero sized buffers are not allowed");

6) virtio_error() (also QEMU function) set the device as broken

    vdev->broken = true;

7) Qemu bails out, and do not repond this crazy kernel.

8) The kernel is waiting for the response to come back (function
virtnet_send_command())

9) The kernel is waiting doing the following :

      while (!virtqueue_get_buf(vi->cvq, &tmp) &&
	     !virtqueue_is_broken(vi->cvq))
	      cpu_relax();

10) None of the following functions above is true, thus, the kernel
loops here forever. Keeping in mind that virtqueue_is_broken() does
not look at the qemu `vdev->broken`, so, it never realizes that the
vitio is broken at QEMU side.

Fix it by not sending RSS commands if the feature is not available in
the device.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
---
Changelog:

V2:
  * Moved from creating a valid packet, by rejecting the request
    completely.
V3:
  * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
    the rejection path.
V4:
  * Added a comment in an "if" clause, as suggested by Michael S. Tsirkin.

---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..115c3c5414f2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -3814,13 +3815,28 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	if (rxfh->indir) {
+		if (!vi->has_rss)
+			return -EOPNOTSUPP;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+		update = true;
 	}
-	if (rxfh->key)
+
+	if (rxfh->key) {
+		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
+		 * device provides hash calculation capabilities, that is,
+		 * hash_key is configured.
+		 */
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EOPNOTSUPP;
+
 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4729,13 +4745,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 
-- 
2.43.0


