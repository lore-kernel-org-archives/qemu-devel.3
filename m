Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ED9C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoZk-0003ij-2t; Wed, 21 Feb 2024 10:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1rcoOz-0004ZR-VV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1rciUc-0007hV-RF
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708506137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=azwLzlnyPjgX5VLVt2HH/5+1YSAiygsKde1d3DmglQY=;
 b=APMuNN5oB/4cIsr9znVE9LGNfWNjqAo+6sa0Xnfz7YE5+4GXIL04BvpcQqTMv2YaiRsNex
 CvKEGcKesBwpmGAEDvUDj3bIWfM15rqsm1EOTZz9LtO/V1AM6Qe13C67n6Z4JKheMCCvgw
 N3BmYFR2JWaPvt/0MfmduYv65SnvnnY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-9pUlW4eiPxC7gO3lKHxHug-1; Wed, 21 Feb 2024 04:02:13 -0500
X-MC-Unique: 9pUlW4eiPxC7gO3lKHxHug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6BF310650E0;
 Wed, 21 Feb 2024 09:02:12 +0000 (UTC)
Received: from [10.39.208.17] (unknown [10.39.208.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38349C03489;
 Wed, 21 Feb 2024 09:02:10 +0000 (UTC)
Message-ID: <f9111e6b-4094-4731-b2de-e442b1a4fa5f@redhat.com>
Date: Wed, 21 Feb 2024 10:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: fix the issue of vhost deadlock in nested
 virtualization
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Hao Chen <chenh@yusur.tech>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 huangml@yusur.tech, zy@yusur.tech
References: <20240126100737.2509847-1-chenh@yusur.tech>
 <20240213050258-mutt-send-email-mst@kernel.org>
 <5176a8e4-dbdc-45e0-a1f2-d9cb3b71a6b1@redhat.com>
 <20240220064027-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 xsFNBFOEQQIBEADjNLYZZqghYuWv1nlLisptPJp+TSxE/KuP7x47e1Gr5/oMDJ1OKNG8rlNg
 kLgBQUki3voWhUbMb69ybqdMUHOl21DGCj0BTU3lXwapYXOAnsh8q6RRM+deUpasyT+Jvf3a
 gU35dgZcomRh5HPmKMU4KfeA38cVUebsFec1HuJAWzOb/UdtQkYyZR4rbzw8SbsOemtMtwOx
 YdXodneQD7KuRU9IhJKiEfipwqk2pufm2VSGl570l5ANyWMA/XADNhcEXhpkZ1Iwj3TWO7XR
 uH4xfvPl8nBsLo/EbEI7fbuUULcAnHfowQslPUm6/yaGv6cT5160SPXT1t8U9QDO6aTSo59N
 jH519JS8oeKZB1n1eLDslCfBpIpWkW8ZElGkOGWAN0vmpLfdyiqBNNyS3eGAfMkJ6b1A24un
 /TKc6j2QxM0QK4yZGfAxDxtvDv9LFXec8ENJYsbiR6WHRHq7wXl/n8guyh5AuBNQ3LIK44x0
 KjGXP1FJkUhUuruGyZsMrDLBRHYi+hhDAgRjqHgoXi5XGETA1PAiNBNnQwMf5aubt+mE2Q5r
 qLNTgwSo2dpTU3+mJ3y3KlsIfoaxYI7XNsPRXGnZi4hbxmeb2NSXgdCXhX3nELUNYm4ArKBP
 LugOIT/zRwk0H0+RVwL2zHdMO1Tht1UOFGfOZpvuBF60jhMzbQARAQABzSxNYXhpbWUgQ29x
 dWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPsLBeAQTAQIAIgUCV3u/5QIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQyjiNKEaHD4ma2g/+P+Hg9WkONPaY1J4AR7Uf
 kBneosS4NO3CRy0x4WYmUSLYMLx1I3VH6SVjqZ6uBoYy6Fs6TbF6SHNc7QbB6Qjo3neqnQR1
 71Ua1MFvIob8vUEl3jAR/+oaE1UJKrxjWztpppQTukIk4oJOmXbL0nj3d8dA2QgHdTyttZ1H
 xzZJWWz6vqxCrUqHU7RSH9iWg9R2iuTzii4/vk1oi4Qz7y/q8ONOq6ffOy/t5xSZOMtZCspu
 Mll2Szzpc/trFO0pLH4LZZfz/nXh2uuUbk8qRIJBIjZH3ZQfACffgfNefLe2PxMqJZ8mFJXc
 RQO0ONZvwoOoHL6CcnFZp2i0P5ddduzwPdGsPq1bnIXnZqJSl3dUfh3xG5ArkliZ/++zGF1O
 wvpGvpIuOgLqjyCNNRoR7cP7y8F24gWE/HqJBXs1qzdj/5Hr68NVPV1Tu/l2D1KMOcL5sOrz
 2jLXauqDWn1Okk9hkXAP7+0Cmi6QwAPuBT3i6t2e8UdtMtCE4sLesWS/XohnSFFscZR6Vaf3
 gKdWiJ/fW64L6b9gjkWtHd4jAJBAIAx1JM6xcA1xMbAFsD8gA2oDBWogHGYcScY/4riDNKXi
 lw92d6IEHnSf6y7KJCKq8F+Jrj2BwRJiFKTJ6ChbOpyyR6nGTckzsLgday2KxBIyuh4w+hMq
 TGDSp2rmWGJjASrOwU0EVPSbkwEQAMkaNc084Qvql+XW+wcUIY+Dn9A2D1gMr2BVwdSfVDN7
 0ZYxo9PvSkzh6eQmnZNQtl8WSHl3VG3IEDQzsMQ2ftZn2sxjcCadexrQQv3Lu60Tgj7YVYRM
 H+fLYt9W5YuWduJ+FPLbjIKynBf6JCRMWr75QAOhhhaI0tsie3eDsKQBA0w7WCuPiZiheJaL
 4MDe9hcH4rM3ybnRW7K2dLszWNhHVoYSFlZGYh+MGpuODeQKDS035+4H2rEWgg+iaOwqD7bg
 CQXwTZ1kSrm8NxIRVD3MBtzp9SZdUHLfmBl/tLVwDSZvHZhhvJHC6Lj6VL4jPXF5K2+Nn/Su
 CQmEBisOmwnXZhhu8ulAZ7S2tcl94DCo60ReheDoPBU8PR2TLg8rS5f9w6mLYarvQWL7cDtT
 d2eX3Z6TggfNINr/RTFrrAd7NHl5h3OnlXj7PQ1f0kfufduOeCQddJN4gsQfxo/qvWVB7PaE
 1WTIggPmWS+Xxijk7xG6x9McTdmGhYaPZBpAxewK8ypl5+yubVsE9yOOhKMVo9DoVCjh5To5
 aph7CQWfQsV7cd9PfSJjI2lXI0dhEXhQ7lRCFpf3V3mD6CyrhpcJpV6XVGjxJvGUale7+IOp
 sQIbPKUHpB2F+ZUPWds9yyVxGwDxD8WLqKKy0WLIjkkSsOb9UBNzgRyzrEC9lgQ/ABEBAAHC
 wV8EGAECAAkFAlT0m5MCGwwACgkQyjiNKEaHD4nU8hAAtt0xFJAy0sOWqSmyxTc7FUcX+pbD
 KVyPlpl6urKKMk1XtVMUPuae/+UwvIt0urk1mXi6DnrAN50TmQqvdjcPTQ6uoZ8zjgGeASZg
 jj0/bJGhgUr9U7oG7Hh2F8vzpOqZrdd65MRkxmc7bWj1k81tOU2woR/Gy8xLzi0k0KUa8ueB
 iYOcZcIGTcs9CssVwQjYaXRoeT65LJnTxYZif2pfNxfINFzCGw42s3EtZFteczClKcVSJ1+L
 +QUY/J24x0/ocQX/M1PwtZbB4c/2Pg/t5FS+s6UB1Ce08xsJDcwyOPIH6O3tccZuriHgvqKP
 yKz/Ble76+NFlTK1mpUlfM7PVhD5XzrDUEHWRTeTJSvJ8TIPL4uyfzhjHhlkCU0mw7Pscyxn
 DE8G0UYMEaNgaZap8dcGMYH/96EfE5s/nTX0M6MXV0yots7U2BDb4soLCxLOJz4tAFDtNFtA
 wLBhXRSvWhdBJZiig/9CG3dXmKfi2H+wdUCSvEFHRpgo7GK8/Kh3vGhgKmnnxhl8ACBaGy9n
 fxjSxjSO6rj4/MeenmlJw1yebzkX8ZmaSi8BHe+n6jTGEFNrbiOdWpJgc5yHIZZnwXaW54QT
 UhhSjDL1rV2B4F28w30jYmlRmm2RdN7iCZfbyP3dvFQTzQ4ySquuPkIGcOOHrvZzxbRjzMx1
 Mwqu3GQ=
In-Reply-To: <20240220064027-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=maxime.coquelin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/20/24 12:43, Michael S. Tsirkin wrote:
> On Tue, Feb 20, 2024 at 12:26:49PM +0100, Maxime Coquelin wrote:
>>
>>
>> On 2/13/24 11:05, Michael S. Tsirkin wrote:
>>> On Fri, Jan 26, 2024 at 06:07:37PM +0800, Hao Chen wrote:
>>>> I run "dpdk-vdpa" and "qemur-L2" in "qemu-L1".
>>>>
>>>> In a nested virtualization environment, "qemu-L2" vhost-user socket sends
>>>> a "VHOST_USER_IOTLB_MSG" message to "dpdk-vdpa" and blocks waiting for
>>>> "dpdk-vdpa" to process the message.
>>>> If "dpdk-vdpa" doesn't complete the processing of the "VHOST_USER_IOTLB_MSG"
>>>> message and sends a message that needs to be replied in another thread,
>>>> such as "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", "dpdk-vdpa" will also
>>>> block and wait for "qemu-L2" to process this message. However, "qemu-L2"
>>>> vhost-user's socket is blocking while waiting for a reply from "dpdk-vdpa"
>>>> after processing the message "VHOSTr_USER_IOTLB_MSG", and
>>>> "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" will not be processed.
>>>> In this case, both "dpdk-vdpa" and "qemu-L2" are blocked on the
>>>> vhost read, resulting in a deadlock.
>>>>
>>>> You can modify "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" or
>>>> "VHOST_USER_IOTLB_MSG" to "no need reply" to fix this issue.
>>>> There are too many messages in dpdk that are similar to
>>>> "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", and I would prefer the latter.
>>>>
>>>> Fixes: 24e34754eb78 ("vhost-user: factor out msg head and payload")
>>>>
>>>> Signed-off-by: Hao Chen <chenh@yusur.tech>
>>>
>>> I would be very worried that IOTLB becomes stale and
>>> guest memory is corrupted if we just proceed without waiting.
>>>
>>> Maxime what do you think? How would you address the issue?
>>
>> I agree with you, this is not possible.
>> For example, in case of IOTLB invalidate, the frontend relies on the
>> backend reply to ensure it is no more accessing the memory before
>> proceeding.
>>
>> The reply-ack for VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG request is
>> less important, if it fails the host notifications won't work but would
>> not risk corruption. Maybe on Qemu side we could fail init if processing
>> the request fails, as I think that if negotiated, we can expect it to
>> succeed.
>>
>> What do you think about this proposal?
>>
>> Regards,
>> Maxime
> 
> Fundamentally, I think that if qemu blocks guest waiting for a rely
> that is ok but it really has to process incoming messages meanwhile.
> Same should apply to backend I think ...

I understand your point.
For DPDK Vhost library, it will likely imply ABI breakage as it would
require to asynchronous handling of Vhost-user requests. We would only
be able to do it at next LTS release.

Hao, as your driver is not available upstream it will be difficult to
assist you more. But if you look at other DPDK vDPA driver like SFC for
instance, the way they implemented host notification control should be
safe against this kind of deadlocks.


> 
>>>
>>>
>>>> ---
>>>>    hw/virtio/vhost-user.c | 10 ++--------
>>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>> index f214df804b..02caa94b6c 100644
>>>> --- a/hw/virtio/vhost-user.c
>>>> +++ b/hw/virtio/vhost-user.c
>>>> @@ -2371,20 +2371,14 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
>>>>    static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
>>>>                                                struct vhost_iotlb_msg *imsg)
>>>>    {
>>>> -    int ret;
>>>>        VhostUserMsg msg = {
>>>>            .hdr.request = VHOST_USER_IOTLB_MSG,
>>>>            .hdr.size = sizeof(msg.payload.iotlb),
>>>> -        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
>>>> +        .hdr.flags = VHOST_USER_VERSION,
>>>>            .payload.iotlb = *imsg,
>>>>        };
>>>> -    ret = vhost_user_write(dev, &msg, NULL, 0);
>>>> -    if (ret < 0) {
>>>> -        return ret;
>>>> -    }
>>>> -
>>>> -    return process_message_reply(dev, &msg);
>>>> +    return vhost_user_write(dev, &msg, NULL, 0);
>>>>    }
>>>> -- 
>>>> 2.27.0
>>>
> 


