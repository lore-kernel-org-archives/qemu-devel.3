Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC50C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 06:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rodNn-0001UW-DC; Mon, 25 Mar 2024 02:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rodNk-0001Ti-Tj
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:00:28 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rodNh-0004XN-Ps
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1711346414; h=Message-ID:Subject:Date:From:To;
 bh=JNL9A38afeP0aEJfOCNG1LEpvhSBCwkDLxX/IRTOtms=;
 b=kpCDMD7gZLJfGeUmP9zWIPgXWPjPB7b+/US7NNVETxDyzNvuwcdKOBimDIta09tDR2wzjNwM/OumN1DibA9btOhl+NNEi/5QjAwXh8rHyNnt7/ATKnaFUoT4dcMtxMSnJs6f5X2jR4UpPzFMJX4zilz0gkH+Mx5cSVUH9lvp43U=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0W39kIMB_1711346410; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0W39kIMB_1711346410) by smtp.aliyun-inc.com;
 Mon, 25 Mar 2024 14:00:11 +0800
Message-ID: <1711346273.5079622-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Date: Mon, 25 Mar 2024 13:57:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240321165431.3517868-1-leitao@debian.org>
 <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
 <Zf1bofzE4x0wGEm+@gmail.com>
In-Reply-To: <Zf1bofzE4x0wGEm+@gmail.com>
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=xuanzhuo@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
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

On Fri, 22 Mar 2024 03:21:21 -0700, Breno Leitao <leitao@debian.org> wrote:
> Hello Xuan,
>
> On Fri, Mar 22, 2024 at 10:00:22AM +0800, Xuan Zhuo wrote:
> > On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:
>
> > > 4) Since the command above does not have a key, then the last
> > >    scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > >     sg_buf_size = vi->rss_key_size;
> >
> >
> >
> > 	if (vi->has_rss || vi->has_rss_hash_report) {
> > 		vi->rss_indir_table_size =
> > 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> > 				rss_max_indirection_table_length));
> > 		vi->rss_key_size =
> > 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> >
> > 		vi->rss_hash_types_supported =
> > 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> > 		vi->rss_hash_types_supported &=
> > 				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> > 				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> > 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> > 		dev->hw_features |= NETIF_F_RXHASH;
> > 	}
> >
> >
> > vi->rss_key_size is initiated here, I wonder if there is something wrong?
>
> Not really, the code above is never executed (in my machines). This is
> because `vi->has_rss` and `vi->has_rss_hash_report` are both unset.
>
> Looking further, vdev does not have the VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT features.
>
> Also, when I run `ethtool -x`, I got:
>
> 	# ethtool  -x eth0
> 	RX flow hash indirection table for eth0 with 1 RX ring(s):
> 	Operation not supported
> 	RSS hash key:
> 	Operation not supported
> 	RSS hash function:
> 	    toeplitz: on
> 	    xor: off
> 	    crc32: off


The spec saies:
	Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it
	supports only one pair of virtqueues, it MUST support at least one of
	commands of VIRTIO_NET_CTRL_MQ class to configure reported hash
	parameters:

	If the device offers VIRTIO_NET_F_RSS, it MUST support
	VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per 5.1.6.5.7.1.

	Otherwise the device MUST support VIRTIO_NET_CTRL_MQ_HASH_CONFIG command
	per 5.1.6.5.6.4.


So if we have not anyone of `vi->has_rss` and `vi->has_rss_hash_report`,
we should return from virtnet_set_rxfh directly.

Thanks.

