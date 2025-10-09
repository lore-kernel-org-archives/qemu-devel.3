Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2A1CCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6woX-0003sS-5C; Thu, 09 Oct 2025 16:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6woI-0003px-Di; Thu, 09 Oct 2025 16:00:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6woD-0005QL-Cg; Thu, 09 Oct 2025 16:00:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8982:0:640:5cf4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6A252C04D7;
 Thu, 09 Oct 2025 23:00:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 60Rgu81F8iE0-sLEWbq2q; Thu, 09 Oct 2025 23:00:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760040007;
 bh=I6tW7bSqzdpUx2rHXI49rHLIqxTL2oSweCIJ2pV1w7k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VpgeenKWcEo/tOvha0lnYc4QoRoXhIwv6eD2/i/VDbqMb7n7gm7SKZnrffWPeMLBb
 U2/9iBAOBUDfAaPWI6LsGmT18PBMXmgxK6LAouLXRrr9r2k797DqLjNgkI5YImqLji
 R/p34XpBmb2KiRyDhfDb5vmHoWAjo1SwFo1J/zok=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <735ce0e5-6c04-4b3e-9d21-50a4624092c9@yandex-team.ru>
Date: Thu, 9 Oct 2025 23:00:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] vhost: make vhost_memory_unmap() null-safe
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFudmBtoPSGptvZiSuzabV4SrRaL45BYCDtpiU9i6wNzeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 09.10.25 22:00, Raphael Norwitz wrote:
> On Wed, Aug 13, 2025 at 12:56 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> This helps to simplify failure paths of vhost_virtqueue_start()
>> a lot.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/vhost.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 1e14987cd5..1fdc1937b6 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -489,6 +489,10 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
>>                                  hwaddr len, int is_write,
>>                                  hwaddr access_len)
>>   {
>> +    if (!buffer) {
>> +        return;
>> +    }
>> +
>>       if (!vhost_dev_has_iommu(dev)) {
>>           cpu_physical_memory_unmap(buffer, len, is_write, access_len);
>>       }
>> @@ -1313,33 +1317,33 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>>       vq->desc = vhost_memory_map(dev, a, l, false);
>>       if (!vq->desc) {
>>           r = -ENOMEM;
>> -        goto fail_alloc_desc;
>> +        goto fail;
>>       }
>>       vq->avail_size = l = virtio_queue_get_avail_size(vdev, idx);
>>       vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
>>       vq->avail = vhost_memory_map(dev, a, l, false);
>>       if (!vq->avail) {
>>           r = -ENOMEM;
>> -        goto fail_alloc_avail;
>> +        goto fail;
>>       }
>>       vq->used_size = l = virtio_queue_get_used_size(vdev, idx);
>>       vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
>>       vq->used = vhost_memory_map(dev, a, l, true);
>>       if (!vq->used) {
>>           r = -ENOMEM;
>> -        goto fail_alloc_used;
>> +        goto fail;
>>       }
>>
>>       r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
>>       if (r < 0) {
>> -        goto fail_alloc;
>> +        goto fail;
>>       }
>>
>>       file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
>>       r = dev->vhost_ops->vhost_set_vring_kick(dev, &file);
>>       if (r) {
>>           VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
>> -        goto fail_kick;
>> +        goto fail;
>>       }
>>
>>       /* Clear and discard previous events if any. */
>> @@ -1359,24 +1363,19 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>>           file.fd = -1;
>>           r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>>           if (r) {
>> -            goto fail_vector;
>> +            goto fail;
>>           }
>>       }
>>
>>       return 0;
>>
>> -fail_vector:
>> -fail_kick:
>> -fail_alloc:
>> +fail:
>>       vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
>>                          0, 0);
>> -fail_alloc_used:
>>       vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
>>                          0, 0);
>> -fail_alloc_avail:
>>       vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
>>                          0, 0);
>> -fail_alloc_desc:
>>       return r;
> 
> This assumes that vq->{used, avail, desc} will be nulled out. I’m not
> totally convinced that will be the case when a device is started and
> stopped, or at least I don’t see the unmap path doing it.
> 

Oh, right, good caught. Seems we never zero these fields, and after do_vhost_virtqueue_stop()
they become invalid. I'll rework it somehow.

I also notice now, that we do

     vq->used = vhost_memory_map(dev, a, &l, true);
     if (!vq->used || l != s) {
         r = -ENOMEM;
         goto fail_alloc_used;
     }

so, theoretically pre-patch we may leak the mapping in case when vq->used is not NULL but l != s after vhost_memory_map().

this should be fixed with this commit (of course, if fix also the problem you pointed out)

>>   }
> 
>>
>> --
>> 2.48.1
>>
>>


-- 
Best regards,
Vladimir

