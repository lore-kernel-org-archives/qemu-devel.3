Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CE3C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 02:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnUKF-0001JU-7q; Thu, 21 Mar 2024 22:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rnUKB-0001Ib-Kd
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 22:08:03 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rnUK8-0006Q1-2B
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 22:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1711073269; h=Message-ID:Subject:Date:From:To;
 bh=u+tMN1LwSbe9n5PNdUk4hVRTCTGRyukBQQgHRB/HjG0=;
 b=uz6vjIEQkvS1r8+ETKyqxpTeYVDiy+jjYHSvKUQAM5vT919bEOyhQMdV8QYVkifADzR5aqSRQIAb5SIVeON/RQejhkifh4l6LIXa2rzCcwO9wJhGRVyU4dDOuN4HBWwwNrr/Zsr6BGIMUPDa3O83WdZepQnRI9D5izLqQxUWZOQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0W3077TT_1711072960; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0W3077TT_1711072960) by smtp.aliyun-inc.com;
 Fri, 22 Mar 2024 10:02:41 +0800
Message-ID: <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Date: Fri, 22 Mar 2024 10:00:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240321165431.3517868-1-leitao@debian.org>
In-Reply-To: <20240321165431.3517868-1-leitao@debian.org>
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=xuanzhuo@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
>
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
>
> 	# ethtool -X eth0  hfunc toeplitz
>
> This is how the problem happens:
>
> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
>
> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
>
> 3) virtnet_commit_rss_command() populates 4 entries for the rss
>    scatter-gather
>
> 4) Since the command above does not have a key, then the last
>    scatter-gatter entry will be zeroed, since rss_key_size == 0.
>     sg_buf_size = vi->rss_key_size;



	if (vi->has_rss || vi->has_rss_hash_report) {
		vi->rss_indir_table_size =
			virtio_cread16(vdev, offsetof(struct virtio_net_config,
				rss_max_indirection_table_length));
		vi->rss_key_size =
			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));

		vi->rss_hash_types_supported =
		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
		vi->rss_hash_types_supported &=
				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);

		dev->hw_features |= NETIF_F_RXHASH;
	}


vi->rss_key_size is initiated here, I wonder if there is something wrong?

Thanks.


>
> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
>    with zero length, and do the following in virtqueue_map_desc() (QEMU
>    function):
>
>       if (!sz) {
>           virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>
> 6) virtio_error() (also QEMU function) set the device as broken
>
> 	vdev->broken = true;
>
> 7) Qemu bails out, and do not repond this crazy kernel.
>
> 8) The kernel is waiting for the response to come back (function
>    virtnet_send_command())
>
> 9) The kernel is waiting doing the following :
>
>           while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>                  !virtqueue_is_broken(vi->cvq))
>                   cpu_relax();
>
> 10) None of the following functions above is true, thus, the kernel
>     loops here forever. Keeping in mind that virtqueue_is_broken() does
>     not look at the qemu `vdev->broken`, so, it never realizes that the
>     vitio is broken at QEMU side.
>
> Fix it by not sending the key scatter-gatter key if it is not set.
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Cc: qemu-devel@nongnu.org
> ---
>  drivers/net/virtio_net.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..5a7700b103f8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3041,11 +3041,16 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>  {
>  	struct net_device *dev = vi->dev;
> +	int has_key = vi->rss_key_size;
>  	struct scatterlist sgs[4];
>  	unsigned int sg_buf_size;
> +	int nents = 3;
> +
> +	if (has_key)
> +		nents += 1;
>
>  	/* prepare sgs */
> -	sg_init_table(sgs, 4);
> +	sg_init_table(sgs, nents);
>
>  	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
>  	sg_set_buf(&sgs[0], &vi->ctrl->rss, sg_buf_size);
> @@ -3057,8 +3062,13 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>  			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
>  	sg_set_buf(&sgs[2], &vi->ctrl->rss.max_tx_vq, sg_buf_size);
>
> -	sg_buf_size = vi->rss_key_size;
> -	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
> +	if (has_key) {
> +		/* Only populate if key is available, otherwise
> +		 * populating a buffer with zero size breaks virtio
> +		 */
> +		sg_buf_size = vi->rss_key_size;
> +		sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
> +	}
>
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>  				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
> --
> 2.43.0
>

