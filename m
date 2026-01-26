Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C5CD19501
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkPdr-0003SQ-ED; Mon, 26 Jan 2026 11:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vkPdp-0003QD-OC; Mon, 26 Jan 2026 11:40:41 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vkPdZ-0004Y9-Uf; Mon, 26 Jan 2026 11:40:41 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 06672C0161;
 Mon, 26 Jan 2026 19:40:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:735::1:1] (unknown [2a02:6bf:8080:735::1:1])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9ej7gs3ApGk0-k1yjpMR4; Mon, 26 Jan 2026 19:40:10 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769445610;
 bh=4alWaK4Gtxc2l/8uVQ0wB752eLYr/EPNILadrai0CI8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=UGtr4Blv6clPalBeWr+T4KgdT01xG7wcnbm/jwsKvAipY7zBmzvPfUJfNofsiepmd
 x5cjclY5VrN7VjqA+N1O1cmxyneu66cBR7ygebDOOukBV0Vf+cP1/VCfBbw4csVvob
 clK24LFdO+R+E9sXaZYoECU8jG6Tu8otNxi1amPQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <26198787-a1da-4858-8656-f5006d153d6e@yandex-team.ru>
Date: Mon, 26 Jan 2026 19:40:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/23] virtio: move common part of _set_guest_notifier
 to generic code
To: Halil Pasic <pasic@linux.ibm.com>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:virtio-ccw" <qemu-s390x@nongnu.org>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-9-vsementsov@yandex-team.ru>
 <20260124000624.1bd7c9c1.pasic@linux.ibm.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260124000624.1bd7c9c1.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24.01.26 02:06, Halil Pasic wrote:
> On Mon, 19 Jan 2026 21:52:12 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> 
>> virtio-pci, virtio-mmio and virtio-ccw handle config notifier equally
>> but with different code (mmio adds a separate function, when pci use
>> common function). Let's chose the more compact way (pci) and reuse it
>> for mmio.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Ultimately is up to Michael to decide, but I'm not sure patch makes
> things cleaner. I would even say, its current form, it does not.
> 
> I do like the idea of getting rid of duplicated logic though.
> 
> 
>> ---
>>   hw/s390x/virtio-ccw.c          | 35 ++++++++++++-------------
>>   hw/virtio/virtio-mmio.c        | 41 +++++------------------------
>>   hw/virtio/virtio-pci.c         | 34 +++---------------------
>>   hw/virtio/virtio.c             | 48 +++++++++++++++++++++++++++++++---
>>   include/hw/virtio/virtio-pci.h |  3 ---
>>   include/hw/virtio/virtio.h     | 16 +++++++++---
>>   6 files changed, 84 insertions(+), 93 deletions(-)
> [..]
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 3dc9423eae..ea43ea620c 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
> [..]
>> +static void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev,
> 
> Function name says 'pci' but it actually is not PCI specific.

Agree. Is "virtio_set_guest_notifier_fd_handler()" OK?

> 
>> +                                                     VirtQueue *vq,
>> +                                                     int n, bool assign,
>> +                                                     bool with_irqfd)
>> +{
>> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
>> +        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
>> +    } else {
>> +        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
>> +    }
>> +}
>> +
> [..]
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 27cd98d2fe..25ef7c9dff 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -420,8 +420,6 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
>>   VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
>>   uint16_t virtio_get_queue_index(VirtQueue *vq);
>>   EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
>> -void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
>> -                                                bool with_irqfd);
>>   int virtio_device_start_ioeventfd(VirtIODevice *vdev);
>>   int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
>>   void virtio_device_release_ioeventfd(VirtIODevice *vdev);
>> @@ -435,8 +433,18 @@ void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx);
>>   VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
>>   VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
>>   EventNotifier *virtio_config_get_guest_notifier(VirtIODevice *vdev);
>> -void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
>> -                                                 bool assign, bool with_irqfd);
>> +
>> +/**
>> + * virtio_queue_set_guest_notifier - set/unset queue or config guest
>> + *     notifier
>> + *
>> + * @vdev: the VirtIO device
>> + * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notifer
> 
> Semantically are mixing queue numbers and interrupt indexes here.

That's preexisting logic in virtio_pci_set_guest_notifier_fd_handler().

But, you are right, that's doesn't answer the question, is it good to share
the logic with mmio and ccw.

Is config notifier only pci specific, or similar feature may appear in future
for mmio and/or ccw?

I can try to keep config-notifier logic only in pci code.

Michael, what's better?

> 
>> + * @assign: true to set notifier, false to unset
>> + * @with_irqfd: irqfd enabled
>> + */
>> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
>> +                                    bool with_irqfd);
> 
> The name says 'queue' but it is not always queue any more.

Agree, should be "virtio_set_guest_notifier()" if we go that way.

> 
> Regards,
> Halil

Thanks for reviewing!

-- 
Best regards,
Vladimir

