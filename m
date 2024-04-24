Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911EFC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 13:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzd5S-0006Sw-SS; Wed, 24 Apr 2024 09:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ovs@ovs.to>) id 1rzaJO-00074j-NA
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:57:14 -0400
Received: from qs51p00im-qukt01072301.me.com ([17.57.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ovs@ovs.to>) id 1rzaJM-00032Q-T8
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovs.to; s=sig1;
 t=1713956228; bh=UWC2JDeqhopdUAA3a6ItrwHEC6ucS1ZQ3oowEpM9ofw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=pTEio9xTqdxG+fKfoJ+bNcsdFdWTvUhtppF6GvS8AGo1EM1MgCa7K5INjgLTA+51H
 KyzYV99HGptkVeUji5/4gcwcbrpMFR3VSHIDXNKLpzYagv0qN59Va3pPJCJOlq62Uy
 9vHaTolna1zAiQS1zFHb0aUh4wDsFV3tAJkfIdRwrVcGoNN7trbUjDMMNsdJaI81ch
 AkQcMZXxKRsuSxaWNre/bnwYMuOVvKO9YYDYTkGy9G/RjM9As5kN2tqgegf1g0Qi0V
 7Ome8NX3paXfDxJWwfDj+Av/zUPvUhRaAWfcnMpEpjcENaxjrsj8GAQsxqjkOtPB3/
 fp6ZBpd9FGKVQ==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
 by qs51p00im-qukt01072301.me.com (Postfix) with ESMTPSA id
 EF9F425400F3; Wed, 24 Apr 2024 10:57:06 +0000 (UTC)
From: Konstantin Ovsepian <ovs@ovs.to>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net, hengqi@linux.alibaba.com, leitao@debian.org,
 xuanzhuo@linux.alibaba.com, ovs@meta.com, qemu-devel@nongnu.org
Subject: [PATCH 6.1.y] virtio_net: Do not send RSS key if it is not supported
Date: Wed, 24 Apr 2024 03:57:04 -0700
Message-ID: <20240424105704.182708-1-ovs@ovs.to>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024041414-humming-alarm-eb41@gregkh>
References: <2024041414-humming-alarm-eb41@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sdjGZWmWw7_ebjwMuRx20I3WAV38thMO
X-Proofpoint-ORIG-GUID: sdjGZWmWw7_ebjwMuRx20I3WAV38thMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_08,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 mlxlogscore=957
 bulkscore=0 malwarescore=0 clxscore=1030 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2404240045
Received-SPF: pass client-ip=17.57.155.12; envelope-from=ovs@ovs.to;
 helo=qs51p00im-qukt01072301.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Apr 2024 09:54:58 -0400
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

commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 upstream

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
(cherry picked from commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47)
Signed-off-by: Konstantin Ovsepian <ovs@ovs.to>
---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 45f1a871b7da..32cddb633793 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2948,19 +2948,35 @@ static int virtnet_get_rxfh(struct net_device *dev, u32 *indir, u8 *key, u8 *hfu
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
+
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
@@ -3852,13 +3868,15 @@ static int virtnet_probe(struct virtio_device *vdev)
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


