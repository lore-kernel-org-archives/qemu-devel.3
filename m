Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A6CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hop-00047j-So; Tue, 14 Oct 2025 12:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8hok-00047C-GP
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:24:07 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8hog-0007mq-R0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:24:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7F1A0C0166;
 Tue, 14 Oct 2025 19:23:57 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tNSsMr2FjOs0-YjQMFu3v; Tue, 14 Oct 2025 19:23:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760459036;
 bh=3JSClgDQ+hDQL8XIE1UFPTepQs1+7Q6NQvWKNuxPLBg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XtGN7Cw3AsEVNFnlqAEZ4fjF+rOmXvJpGQRW27AoUgZrwMWb8Q1j1uiE+HPMZTXOb
 5Nb84A5kDPctnQcXAzlg/ynlrLYj8q8H7F0PcMwgZuir026DuOIzZk+eqzI0L7dNKS
 L7wpEMbzolJN/NOUGC2UffpJ+GvtyGSuBDzQsSR4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5907a392-8eb7-407c-8961-e890210ef91d@yandex-team.ru>
Date: Tue, 14 Oct 2025 19:23:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/23] vhost: vhost_virtqueue_start(): fix failure path
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-11-vsementsov@yandex-team.ru>
 <CAFubqFuuBbuoSjofH1XnTrqfi5m_wDuZXN7-Jox82QunBXsFXg@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFuuBbuoSjofH1XnTrqfi5m_wDuZXN7-Jox82QunBXsFXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 13.10.25 23:13, Raphael Norwitz wrote:
> Overall looks good just once comment.
> 
> On Sat, Oct 11, 2025 at 7:24 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> We miss call to unmap in cases when vhost_memory_map() returns
>> lenght less than requested (still we consider such cases as an
>> error). Let's fix it in vhost_memory_map().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/vhost.c | 35 ++++++++++++++++++++++-------------
>>   1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 773b91c0a0..8031c74e7b 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -453,11 +453,20 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
>>   }
>>
>>   static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
>> -                              hwaddr *plen, bool is_write)
>> +                              hwaddr len, bool is_write)
>>   {
>>       if (!vhost_dev_has_iommu(dev)) {
>> -        return address_space_map(dev->vdev->dma_as, addr, plen, is_write,
>> -                                 MEMTXATTRS_UNSPECIFIED);
>> +        hwaddr mapped_len = len;
>> +        void *res = address_space_map(dev->vdev->dma_as, addr, &mapped_len,
>> +                                      is_write, MEMTXATTRS_UNSPECIFIED);
>> +        if (!res) {
>> +            return NULL;
>> +        }
>> +        if (len != mapped_len) {
> 
> Should this be:
> 
> address_space_unmap(dev->vdev->dma_as, res, mapped_len, is_write,
> MEMTXATTRS_UNSPECIFIED);
> 
> rather than address_space_unmap(...0,0)?

Pre-patch we do "...0,0)" for already mapped memories.

Moreover, following commit above address_space_unmap() definition,
is_write and access_len are here to mark the memory as dirty.

In our case, that's an early fail, and we don't actually access the memory,
so it's correct to set is_write to zero, I think.

The latter 0 is also correct, as it's just unused when is_write==0.

> 
>> +            address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0);
>> +            return NULL;
>> +        }
>> +        return res;
>>       } else {
>>           return (void *)(uintptr_t)addr;
>>       }
>> @@ -1261,7 +1270,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>>       BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>>       VirtioBusState *vbus = VIRTIO_BUS(qbus);
>>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
>> -    hwaddr s, l, a;
>> +    hwaddr l, a;
>>       int r;
>>       int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
>>       struct vhost_vring_file file = {
>> @@ -1301,24 +1310,24 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>>           }
>>       }
>>
>> -    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
>> +    vq->desc_size = l = virtio_queue_get_desc_size(vdev, idx);
>>       vq->desc_phys = a;
>> -    vq->desc = vhost_memory_map(dev, a, &l, false);
>> -    if (!vq->desc || l != s) {
>> +    vq->desc = vhost_memory_map(dev, a, l, false);
>> +    if (!vq->desc) {
>>           r = -ENOMEM;
>>           goto fail_alloc_desc;
>>       }
>> -    vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
>> +    vq->avail_size = l = virtio_queue_get_avail_size(vdev, idx);
>>       vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
>> -    vq->avail = vhost_memory_map(dev, a, &l, false);
>> -    if (!vq->avail || l != s) {
>> +    vq->avail = vhost_memory_map(dev, a, l, false);
>> +    if (!vq->avail) {
>>           r = -ENOMEM;
>>           goto fail_alloc_avail;
>>       }
>> -    vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
>> +    vq->used_size = l = virtio_queue_get_used_size(vdev, idx);
>>       vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
>> -    vq->used = vhost_memory_map(dev, a, &l, true);
>> -    if (!vq->used || l != s) {
>> +    vq->used = vhost_memory_map(dev, a, l, true);
>> +    if (!vq->used) {
>>           r = -ENOMEM;
>>           goto fail_alloc_used;
>>       }
>> --
>> 2.48.1
>>


-- 
Best regards,
Vladimir

