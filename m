Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375DCCD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 08:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtNeU-0002KN-4T; Sun, 07 Apr 2024 04:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rtNeO-0002IZ-6E
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 04:13:16 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rtNeK-0001Dn-N3
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 04:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712477578; h=Message-ID:Subject:Date:From:To;
 bh=Jyrgw+fdsx70sA5rZNTdVtftvjSvV7dvUm0DDwjdLJw=;
 b=FQfjlvnLyb9rS6Jf0JpTxFfCIl9PAdi0OpCW8/hNhAl/XzkjpfV6eHFjrsmntHnqkorBfrBj6N7Z9hfvFFId451b9EAJr0yGenfuy9yMUkrBC4MqAAq1j9aFe5jR/KFOsnZBR/mC3bFx6FwOusWePbCkflxkqcHaJZXEAPZF0vM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=16; SR=0;
 TI=SMTPD_---0W4.rUrS_1712477576; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0W4.rUrS_1712477576) by smtp.aliyun-inc.com;
 Sun, 07 Apr 2024 16:12:57 +0800
Message-ID: <1712477565.823871-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v4] virtio_net: Do not send RSS key if it is not
 supported
Date: Sun, 7 Apr 2024 16:12:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list), hengqi@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240403154313.1331319-1-leitao@debian.org>
In-Reply-To: <20240403154313.1331319-1-leitao@debian.org>
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=xuanzhuo@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed,  3 Apr 2024 08:43:12 -0700, Breno Leitao <leitao@debian.org> wrote:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
>
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
>
>     # ethtool -X eth0  hfunc toeplitz
>
> This is how the problem happens:
>
> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
>
> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
>
> 3) virtnet_commit_rss_command() populates 4 entries for the rss
> scatter-gather
>
> 4) Since the command above does not have a key, then the last
> scatter-gatter entry will be zeroed, since rss_key_size == 0.
> sg_buf_size = vi->rss_key_size;
>
> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> with zero length, and do the following in virtqueue_map_desc() (QEMU
> function):
>
>   if (!sz) {
>       virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>
> 6) virtio_error() (also QEMU function) set the device as broken
>
>     vdev->broken = true;
>
> 7) Qemu bails out, and do not repond this crazy kernel.
>
> 8) The kernel is waiting for the response to come back (function
> virtnet_send_command())
>
> 9) The kernel is waiting doing the following :
>
>       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> 	     !virtqueue_is_broken(vi->cvq))
> 	      cpu_relax();
>
> 10) None of the following functions above is true, thus, the kernel
> loops here forever. Keeping in mind that virtqueue_is_broken() does
> not look at the qemu `vdev->broken`, so, it never realizes that the
> vitio is broken at QEMU side.
>
> Fix it by not sending RSS commands if the feature is not available in
> the device.
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Cc: stable@vger.kernel.org
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> Changelog:
>
> V2:
>   * Moved from creating a valid packet, by rejecting the request
>     completely.
> V3:
>   * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
>     the rejection path.
> V4:
>   * Added a comment in an "if" clause, as suggested by Michael S. Tsirkin.
>
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..115c3c5414f2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	bool update = false;
>  	int i;
>
>  	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> @@ -3814,13 +3815,28 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  		return -EOPNOTSUPP;
>
>  	if (rxfh->indir) {
> +		if (!vi->has_rss)
> +			return -EOPNOTSUPP;
> +
>  		for (i = 0; i < vi->rss_indir_table_size; ++i)
>  			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> +		update = true;
>  	}
> -	if (rxfh->key)
> +
> +	if (rxfh->key) {
> +		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
> +		 * device provides hash calculation capabilities, that is,
> +		 * hash_key is configured.
> +		 */
> +		if (!vi->has_rss && !vi->has_rss_hash_report)
> +			return -EOPNOTSUPP;
> +
>  		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
> +		update = true;
> +	}
>
> -	virtnet_commit_rss_command(vi);
> +	if (update)
> +		virtnet_commit_rss_command(vi);
>
>  	return 0;
>  }
> @@ -4729,13 +4745,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>  		vi->has_rss_hash_report = true;
>
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>  		vi->has_rss = true;
>
> -	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_indir_table_size =
>  			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>  				rss_max_indirection_table_length));
> +	}
> +
> +	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
>
> --
> 2.43.0
>

