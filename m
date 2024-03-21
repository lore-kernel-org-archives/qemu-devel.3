Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9582CC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnLhB-0003wB-8E; Thu, 21 Mar 2024 12:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rnLh5-0003w0-0I
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:55:07 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rnLgz-0001S9-NC
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:55:06 -0400
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-56ba6c83805so1500039a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 09:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711040099; x=1711644899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ccIASRuLFeE03wCjAHLbamrjeo4bc7XautdiMnRXVho=;
 b=xN2E0Q2Oi3YtY7Wav61BFfe7k7CfHEew9ALiJLp4uYKNYbwtp3IGe4aMGymyttN61B
 1hg2ztcFpX9ByK4KxDxtIKq4VwcEIzwAgH/MiyxWDRGIQL3ePtbPXX9VwgIBQk6EHnfv
 Y/MrOxGWIpJ0u6WOuMOKJdBvDLhpUnwlrF660pLsbPCuBy7CIhh4CMrrojCrOU4zbiBS
 o50z+x3+K1P/7rlLDtklQZXPx36w+3Kf2Gmerz7+EWoltiK0cvwwPoSKzPH1vOgUE/4T
 vY0u5PhzbQsDkSBKSj0G8CkzzTGP9yYRcgh6IHXwxPLLtKJB8LKXuW14rme5Pc8HwJ7m
 L5SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYzxnkwGTjLENxmRrOyWBjZ3wGQ1PYwGHAX5h9lGsA4GsIBBKyluBuvGhV/F6LAqcfGpLzvdoFPquBjMtbyKButfW4bck=
X-Gm-Message-State: AOJu0YwVVRW4tXg7ErHnbG3vs9a7SKkKTvZHVEpSCe0HbSDh2ooGl1jx
 6k+YKJmbHWKK22F0TsbuRL3T6b9g5a7Ng5aNNSD3lAWrqNx2+kEu
X-Google-Smtp-Source: AGHT+IHe9TCxSTl6z2Gms7re62jr63VC4NJfpI1DXxe/3yVX/mluDaq35PbXeDEagIXyoqmGKtJLsQ==
X-Received: by 2002:a05:6402:5409:b0:56a:fbe9:80a4 with SMTP id
 ev9-20020a056402540900b0056afbe980a4mr5910560edb.1.1711040099434; 
 Thu, 21 Mar 2024 09:54:59 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net.
 [2a03:2880:30ff:76::face:b00c]) by smtp.gmail.com with ESMTPSA id
 d16-20020a056402401000b005686037bc12sm63505eda.29.2024.03.21.09.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 09:54:59 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] virtio_net: Do not send RSS key if it is not supported
Date: Thu, 21 Mar 2024 09:54:30 -0700
Message-ID: <20240321165431.3517868-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.41;
 envelope-from=breno.debian@gmail.com; helo=mail-ed1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Fix it by not sending the key scatter-gatter key if it is not set.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
---
 drivers/net/virtio_net.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..5a7700b103f8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3041,11 +3041,16 @@ static int virtnet_set_ringparam(struct net_device *dev,
 static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 {
 	struct net_device *dev = vi->dev;
+	int has_key = vi->rss_key_size;
 	struct scatterlist sgs[4];
 	unsigned int sg_buf_size;
+	int nents = 3;
+
+	if (has_key)
+		nents += 1;
 
 	/* prepare sgs */
-	sg_init_table(sgs, 4);
+	sg_init_table(sgs, nents);
 
 	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
 	sg_set_buf(&sgs[0], &vi->ctrl->rss, sg_buf_size);
@@ -3057,8 +3062,13 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
 	sg_set_buf(&sgs[2], &vi->ctrl->rss.max_tx_vq, sg_buf_size);
 
-	sg_buf_size = vi->rss_key_size;
-	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
+	if (has_key) {
+		/* Only populate if key is available, otherwise
+		 * populating a buffer with zero size breaks virtio
+		 */
+		sg_buf_size = vi->rss_key_size;
+		sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
+	}
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
-- 
2.43.0


