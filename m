Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0F1CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 19:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ezE-0005uQ-OH; Sat, 11 Oct 2025 15:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7ezA-0005to-UL; Sat, 11 Oct 2025 15:10:32 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7ez6-00070Y-5o; Sat, 11 Oct 2025 15:10:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E277B80830;
 Sat, 11 Oct 2025 22:10:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4b::1:3c] (unknown
 [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FASd4e1F20U0-8dtuDyj4; Sat, 11 Oct 2025 22:10:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760209816;
 bh=kRL8z2oupbNhLRCalBsUM9ndvhQnvdp8ONsuX4NET7w=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=Oj59LhR/GY+anYHUyb9q6b0ea85MAFc2nGpGZha4zbOrWnIikhVOMSybKTOB/s6pi
 L6naNBXH4k6lK3h5HSfsCOST3u7ZliNdtkpq0sOL76aNbjRwmDKUUzcYZ99CPD1wdX
 S4PXkA0rwilKYEjGpslejEIc0IVjMz2dumeoRPLA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f8517cb5-0c4a-44eb-b3bb-6e3fd70721c7@yandex-team.ru>
Date: Sat, 11 Oct 2025 22:10:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] vhost: make vhost_memory_unmap() null-safe
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-12-vsementsov@yandex-team.ru>
 <CAFubqFudmBtoPSGptvZiSuzabV4SrRaL45BYCDtpiU9i6wNzeA@mail.gmail.com>
 <735ce0e5-6c04-4b3e-9d21-50a4624092c9@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <735ce0e5-6c04-4b3e-9d21-50a4624092c9@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09.10.25 23:00, Vladimir Sementsov-Ogievskiy wrote:
> On 09.10.25 22:00, Raphael Norwitz wrote:
>> On Wed, Aug 13, 2025 at 12:56 PM Vladimir Sementsov-Ogievskiy
>> <vsementsov@yandex-team.ru> wrote:
>>>
>>> This helps to simplify failure paths of vhost_virtqueue_start()
>>> a lot.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   hw/virtio/vhost.c | 23 +++++++++++------------
>>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 1e14987cd5..1fdc1937b6 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -489,6 +489,10 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
>>>                                  hwaddr len, int is_write,
>>>                                  hwaddr access_len)
>>>   {
>>> +    if (!buffer) {
>>> +        return;
>>> +    }
>>> +
>>>       if (!vhost_dev_has_iommu(dev)) {
>>>           cpu_physical_memory_unmap(buffer, len, is_write, access_len);
>>>       }
>>> @@ -1313,33 +1317,33 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>>>       vq->desc = vhost_memory_map(dev, a, l, false);
>>>       if (!vq->desc) {
>>>           r = -ENOMEM;
>>> -        goto fail_alloc_desc;
>>> +        goto fail;
>>>       }
>>>       vq->avail_size = l = virtio_queue_get_avail_size(vdev, idx);
>>>       vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
>>>       vq->avail = vhost_memory_map(dev, a, l, false);
>>>       if (!vq->avail) {
>>>           r = -ENOMEM;
>>> -        goto fail_alloc_avail;
>>> +        goto fail;
>>>       }
>>>       vq->used_size = l = virtio_queue_get_used_size(vdev, idx);
>>>       vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
>>>       vq->used = vhost_memory_map(dev, a, l, true);
>>>       if (!vq->used) {
>>>           r = -ENOMEM;
>>> -        goto fail_alloc_used;
>>> +        goto fail;
>>>       }
>>>
>>>       r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
>>>       if (r < 0) {
>>> -        goto fail_alloc;
>>> +        goto fail;
>>>       }
>>>
>>>       file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
>>>       r = dev->vhost_ops->vhost_set_vring_kick(dev, &file);
>>>       if (r) {
>>>           VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
>>> -        goto fail_kick;
>>> +        goto fail;
>>>       }
>>>
>>>       /* Clear and discard previous events if any. */
>>> @@ -1359,24 +1363,19 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>>>           file.fd = -1;
>>>           r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>>>           if (r) {
>>> -            goto fail_vector;
>>> +            goto fail;
>>>           }
>>>       }
>>>
>>>       return 0;
>>>
>>> -fail_vector:
>>> -fail_kick:
>>> -fail_alloc:
>>> +fail:
>>>       vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
>>>                          0, 0);
>>> -fail_alloc_used:
>>>       vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
>>>                          0, 0);
>>> -fail_alloc_avail:
>>>       vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
>>>                          0, 0);
>>> -fail_alloc_desc:
>>>       return r;
>>
>> This assumes that vq->{used, avail, desc} will be nulled out. I’m not
>> totally convinced that will be the case when a device is started and
>> stopped, or at least I don’t see the unmap path doing it.
>>
> 
> Oh, right, good caught. Seems we never zero these fields, and after do_vhost_virtqueue_stop()
> they become invalid. I'll rework it somehow.
> 
> I also notice now, that we do
> 
>      vq->used = vhost_memory_map(dev, a, &l, true);
>      if (!vq->used || l != s) {
>          r = -ENOMEM;
>          goto fail_alloc_used;
>      }
> 
> so, theoretically pre-patch we may leak the mapping in case when vq->used is not NULL but l != s after vhost_memory_map().
> 
> this should be fixed with this commit (of course, if fix also the problem you pointed out)

oh, I forget that previous patch already fixes it.

> 
>>>   }
>>
>>>
>>> -- 
>>> 2.48.1
>>>
>>>
> 
> 


-- 
Best regards,
Vladimir

