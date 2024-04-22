Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 23:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz3QA-0008AF-CW; Mon, 22 Apr 2024 19:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vlad.wing@gmail.com>)
 id 1ryvQp-0004qm-Cg
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:18:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vlad.wing@gmail.com>)
 id 1ryvQn-0000pM-D4
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:18:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-571c2055cb1so892268a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713799086; x=1714403886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9xj7HwmwuIRzsMLAZWeyWIJzUgtPFLJ8hFtN2pvdUw=;
 b=f2pmFmsfFH/cukXxc93EedHb5wsQ74Fhg8tdvlht7YmmLPbQdrjgvE2y3gh6Q1TIO6
 WIP6u4epi3gTSH39s6TirJdrtRAJ1DowPybtkmU01abnFtkOzC8gRqjysLC412ywOWze
 0Fg0QI03W2DS/TWWm+h7EzsSVd/vts4GHs7QzTl7eb8TW1wyTjxDtXfV5upOAzw18E53
 G3njnAJsL4tQJuWXwKFqAJRI0Yzew1XMJaGF0KcB+00In7yL1tpRdJxyi6+7AuZLEcte
 NiN5ghnMwgNf7GppWZVnoK9Vxju7hMCmifqLaRziuJh+qYDBIu7AbPkU+00d4wW4D4r9
 TN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713799086; x=1714403886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9xj7HwmwuIRzsMLAZWeyWIJzUgtPFLJ8hFtN2pvdUw=;
 b=W2QC2WBgSvqGZonAIgJgsDBCShoLt68GCClL62pq177zNO7XZaq/6ODreMbbBRAv2g
 U7R6qZ5OjBEDAhHxl2K6ssxql0sLnY7LQVuONLpNyCBiO3+1r7YMGIrouTd6TYwI47o4
 AZsgY4JXUdraH5JVFdqas4ZcO3ohmFlBd+dkjpHBkHVljUK3sEB4Nsvq0D4s/oI8HwAc
 upAAHnssqy+hyOxI06O1MBo7vFR9nPp2kDO5Ultm/12CxJj4wMorp7AIh4AhWqp9tkox
 ODlhRgtPjXI24EyzLS2qhIuCE9qCcJ8YeSuOmtZmhH01PgizRgWCp91BEfePh8O/EZcZ
 r+Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbmrp2UkXIr3wOl3bQEVCzaEtvgux1OO3c9gSdg7fDGjErky12YDScWp3EItViMXB7G4qvhgGb0UWilEo0QG1aRbqzQFI=
X-Gm-Message-State: AOJu0YwW9jSeb73upBYQvi2C89hYO9WBDsowdJMzTLoU5iv8mObzPmj5
 XWPcuSIyoq8SmefAZlQnbQxNqATNofxL8tTtFwxsdvn6l1hQgNFy
X-Google-Smtp-Source: AGHT+IE0xIZcSiuCSsz7uHwpkq02z/02QgEoSLowEQ4mDuOxo6EQH/+kgcM7JeLLwXtgGDXeB3sn2Q==
X-Received: by 2002:a05:6402:524c:b0:572:1574:2b88 with SMTP id
 t12-20020a056402524c00b0057215742b88mr1242248edd.40.1713799086256; 
 Mon, 22 Apr 2024 08:18:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net.
 [2a03:2880:30ff:7::face:b00c]) by smtp.gmail.com with ESMTPSA id
 p8-20020a05640243c800b00571fad0647csm2411769edc.74.2024.04.22.08.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 08:18:05 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>, qemu-devel@nongnu.org,
 Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 6.6.y] virtio_net: Do not send RSS key if it is not supported
Date: Mon, 22 Apr 2024 08:18:03 -0700
Message-ID: <20240422151803.1266071-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024041412-subduing-brewing-cd04@gregkh>
References: <2024041412-subduing-brewing-cd04@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=vlad.wing@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Apr 2024 19:50:00 -0400
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

From: Breno Leitao <leitao@debian.org>

commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 upstream.

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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 drivers/net/virtio_net.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7cb0548d17a3..56cbe00126bb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3570,19 +3570,34 @@ static int virtnet_get_rxfh(struct net_device *dev, u32 *indir, u8 *key, u8 *hfu
 static int virtnet_set_rxfh(struct net_device *dev, const u32 *indir, const u8 *key, const u8 hfunc)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
 	if (indir) {
+		if (!vi->has_rss)
+			return -EOPNOTSUPP;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = indir[i];
+		update = true;
 	}
-	if (key)
+	if (key) {
+		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
+		 * device provides hash calculation capabilities, that is,
+		 * hash_key is configured.
+		 */
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EOPNOTSUPP;
+
 		memcpy(vi->ctrl->rss.key, key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4491,13 +4506,15 @@ static int virtnet_probe(struct virtio_device *vdev)
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


