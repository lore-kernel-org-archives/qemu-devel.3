Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC6AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 02:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJ1X-0002Qt-SY; Tue, 26 Mar 2024 22:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hengqi@linux.alibaba.com>)
 id 1rpJ1V-0002QV-Ed
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:28:17 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hengqi@linux.alibaba.com>)
 id 1rpJ1R-00067o-IF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1711506481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=/zfwjKKsw5HeZkRsJXEcqJbxo+5sK1+snEjBOm3OoIY=;
 b=Q+w9NU5B9Krkmfa+4MMlen2FiZBR713PSX35fsyzFuwIKo2HqxHWA5BAQbbu9P6W4MxsHifoknxTn+YvUCRRSrQIqG+z3tvtgHaU26PYKkfpRqDQVmSpCtNMrsoHk8c+V+p1oZRwVFRaL8fDKoiq4LWXvgnGT4kuDegQPanhGWs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=hengqi@linux.alibaba.com; NM=1; PH=DS; RN=16; SR=0;
 TI=SMTPD_---0W3Mvu.x_1711506478; 
Received: from 30.221.148.214(mailfrom:hengqi@linux.alibaba.com
 fp:SMTPD_---0W3Mvu.x_1711506478) by smtp.aliyun-inc.com;
 Wed, 27 Mar 2024 10:27:59 +0800
Message-ID: <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>
Date: Wed, 27 Mar 2024 10:27:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not
 supported
To: Breno Leitao <leitao@debian.org>, xuanzhuo@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240326151911.2155689-1-leitao@debian.org>
 <20240326151911.2155689-2-leitao@debian.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240326151911.2155689-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=hengqi@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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



在 2024/3/26 下午11:19, Breno Leitao 写道:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
>
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
>
>      # ethtool -X eth0  hfunc toeplitz
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
>    if (!sz) {
>        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>
> 6) virtio_error() (also QEMU function) set the device as broken
>
>      vdev->broken = true;
>
> 7) Qemu bails out, and do not repond this crazy kernel.
>
> 8) The kernel is waiting for the response to come back (function
> virtnet_send_command())
>
> 9) The kernel is waiting doing the following :
>
>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
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
> ---
>   drivers/net/virtio_net.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c640fdf28fc5..e6b0eaf08ac2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	int i;
>   
> +	if (!vi->has_rss && !vi->has_rss_hash_report)
> +		return -EOPNOTSUPP;
> +

Why not make the second patch as the first, this seems to work better.
Or squash them into one patch.

Apart from these and Xuan's comments.

For series:

         Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Regards,
Heng

>   	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
>   	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>   		return -EOPNOTSUPP;


