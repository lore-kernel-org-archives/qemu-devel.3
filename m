Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8665C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 07:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrvVA-0006AG-P2; Wed, 03 Apr 2024 03:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hengqi@linux.alibaba.com>)
 id 1rrvV9-00069x-3w
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 03:57:43 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hengqi@linux.alibaba.com>)
 id 1rrvV6-0002Ka-BR
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 03:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712131045; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=R0yA25vpOsgMjEIbg/eLjwHteozmPXXyADvI8WORaFA=;
 b=KQi5tStuas3JwKzy6NaNA/+QUR+0Mf1o5TveDdt56XAj77qTK/PnkWSTmN2QvPGGJOouG62b2hhEeGW/tgOWfkVyrrmOIjiAEt5bNBWxJy/Dei9sJ+xUnSvTof9vF7YOmPONcwdojGzjkdFNMKVFA3W2BUWmEFM4mtcxR6BK7tI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=hengqi@linux.alibaba.com; NM=1; PH=DS; RN=16; SR=0;
 TI=SMTPD_---0W3qvPFc_1712131042; 
Received: from 30.221.147.161(mailfrom:hengqi@linux.alibaba.com
 fp:SMTPD_---0W3qvPFc_1712131042) by smtp.aliyun-inc.com;
 Wed, 03 Apr 2024 15:57:23 +0800
Message-ID: <ae848a33-383f-40d8-9c41-7a4b51045b3b@linux.alibaba.com>
Date: Wed, 3 Apr 2024 15:57:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
To: Breno Leitao <leitao@debian.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com, riel@surriel.com,
 stable@vger.kernel.org, qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240329171641.366520-1-leitao@debian.org>
 <20240331160618-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240331160618-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=hengqi@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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



在 2024/4/1 上午4:20, Michael S. Tsirkin 写道:
> On Fri, Mar 29, 2024 at 10:16:41AM -0700, Breno Leitao wrote:
>> There is a bug when setting the RSS options in virtio_net that can break
>> the whole machine, getting the kernel into an infinite loop.
>>
>> Running the following command in any QEMU virtual machine with virtionet
>> will reproduce this problem:
>>
>>      # ethtool -X eth0  hfunc toeplitz
>>
>> This is how the problem happens:
>>
>> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
>>
>> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
>>
>> 3) virtnet_commit_rss_command() populates 4 entries for the rss
>> scatter-gather
>>
>> 4) Since the command above does not have a key, then the last
>> scatter-gatter entry will be zeroed, since rss_key_size == 0.
>> sg_buf_size = vi->rss_key_size;
>>
>> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
>> with zero length, and do the following in virtqueue_map_desc() (QEMU
>> function):
>>
>>    if (!sz) {
>>        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>>
>> 6) virtio_error() (also QEMU function) set the device as broken
>>
>>      vdev->broken = true;
>>
>> 7) Qemu bails out, and do not repond this crazy kernel.
>>
>> 8) The kernel is waiting for the response to come back (function
>> virtnet_send_command())
>>
>> 9) The kernel is waiting doing the following :
>>
>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>> 	     !virtqueue_is_broken(vi->cvq))
>> 	      cpu_relax();
>>
>> 10) None of the following functions above is true, thus, the kernel
>> loops here forever. Keeping in mind that virtqueue_is_broken() does
>> not look at the qemu `vdev->broken`, so, it never realizes that the
>> vitio is broken at QEMU side.
>>
>> Fix it by not sending RSS commands if the feature is not available in
>> the device.
>>
>> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
>> Cc: stable@vger.kernel.org
> net has its own stable process, don't CC stable on net patches.
>
>
>> Cc: qemu-devel@nongnu.org
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>> Changelog:
>>
>> V2:
>>    * Moved from creating a valid packet, by rejecting the request
>>      completely
>> V3:
>>    * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
>>      the rejection path.
>>
>> ---
>>   drivers/net/virtio_net.c | 22 ++++++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index c22d1118a133..c4a21ec51adf 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>>   			    struct netlink_ext_ack *extack)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>> +	bool update = false;
>>   	int i;
>>   
>>   	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
>> @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
>>   		return -EOPNOTSUPP;
>>   
>>   	if (rxfh->indir) {
>> +		if (!vi->has_rss)
>> +			return -EOPNOTSUPP;
>> +
>>   		for (i = 0; i < vi->rss_indir_table_size; ++i)
>>   			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
>> +		update = true;
>>   	}
>> -	if (rxfh->key)
>> +
>> +	if (rxfh->key) {
>> +		if (!vi->has_rss && !vi->has_rss_hash_report)
>> +			return -EOPNOTSUPP;
>
> What's the logic here? Is it || or &&? A comment can't hurt.

&&

Hi Breno,

You can add a comment like the following:

If either _F_HASH_REPORT or _F_RSS are negotiated, the device provides
hash calculation capabilities, that is, hash_key can be configured.

Regards,
Heng

>
>> +
>>   		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
>> +		update = true;
>> +	}
>>   
>> -	virtnet_commit_rss_command(vi);
>> +	if (update)
>> +		virtnet_commit_rss_command(vi);
>>   
>>   	return 0;
>>   }
>> @@ -4729,13 +4741,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>>   		vi->has_rss_hash_report = true;
>>   
>> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
>> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>>   		vi->has_rss = true;
>>   
>> -	if (vi->has_rss || vi->has_rss_hash_report) {
>>   		vi->rss_indir_table_size =
>>   			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>>   				rss_max_indirection_table_length));
>> +	}
>> +
>> +	if (vi->has_rss || vi->has_rss_hash_report) {
>>   		vi->rss_key_size =
>>   			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
>>   
>> -- 
>> 2.43.0


