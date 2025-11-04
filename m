Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E95CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGElD-0006Nb-V6; Tue, 04 Nov 2025 05:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGElD-0006NN-1k
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:59:35 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGElB-0002Nb-2g
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:59:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5251CC00D8;
 Tue, 04 Nov 2025 13:59:30 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TxhIph1F7Sw0-3u3h8ZYd; Tue, 04 Nov 2025 13:59:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762253969;
 bh=PSrZMROvu9fbSSrgwVdoRxGJqzHzTvaJrBQGnhaWmU0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MR7D7wyrMVrC1RVROA1+Vz9qG/syehlTMEt17Kc19n1YiYjzn/ek6p162khAQpcKU
 OTncSQ3RdLVgHO+CQdN49RZmVwL216+AVOa7brx54eU7EVj+lgJPnlAeN0TfNiCgw5
 h/oU4mFxIeNbTmbx9AwpsccXs3S9HthVhdgtLaSY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4bef290d-e2b2-4226-977c-489ef2eb044e@yandex-team.ru>
Date: Tue, 4 Nov 2025 13:59:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/23] vhost: introduce check_memslots() helper
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-19-vsementsov@yandex-team.ru>
 <20251103170946-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251103170946-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 04.11.25 01:19, Michael S. Tsirkin wrote:
> On Wed, Oct 15, 2025 at 05:58:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
>> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> 
> 
> This needs a better commit log.
> the subject makes it look like it's merely adding a helper
> but it is not the case: e.g. errors are now handled
> somewhat differently.
> 
> Pls document the thinking process explaining why it does not
> matter. CB.
> 

Will do. Or, split into separate commits for helper and for logic change.

> 
>> ---
>>   hw/virtio/vhost.c | 71 ++++++++++++++++++++++++++---------------------
>>   1 file changed, 40 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 34846edf36..56a812b06b 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1572,12 +1572,50 @@ static int vhost_dev_get_features(struct vhost_dev *hdev,
>>       return r;
>>   }
>>   
>> +static bool check_memslots(struct vhost_dev *hdev, Error **errp)
>> +{
>> +    unsigned int used, reserved, limit;
>> +
>> +    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
>> +    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
>> +        memory_devices_memslot_auto_decision_active()) {
>> +        error_setg(errp, "some memory device (like virtio-mem)"
>> +            " decided how many memory slots to use based on the overall"
>> +            " number of memory slots; this vhost backend would further"
>> +            " restricts the overall number of memory slots");
>> +        error_append_hint(errp, "Try plugging this vhost backend before"
>> +            " plugging such memory devices.\n");
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * The listener we registered properly setup the number of required
> 
> This comment worked in the original code but not now.
> 
> The listener here is memory_listener_register which yes happens to
> be called before check_memslots but it is far from obvious.
> 
> 
> 
>> +     * memslots in vhost_commit().
>> +     */
>> +    used = hdev->mem->nregions;
> 
> 
> 
>> +
>> +    /*
>> +     * We assume that all reserved memslots actually require a real memslot
>> +     * in our vhost backend. This might not be true, for example, if the
>> +     * memslot would be ROM. If ever relevant, we can optimize for that --
>> +     * but we'll need additional information about the reservations.
>> +     */
>> +    reserved = memory_devices_get_reserved_memslots();
>> +    if (used + reserved > limit) {
>> +        error_setg(errp, "vhost backend memory slots limit (%d) is less"
>> +                   " than current number of used (%d) and reserved (%d)"
>> +                   " memory slots for memory devices.", limit, used, reserved);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>                      VhostBackendType backend_type, uint32_t busyloop_timeout,
>>                      Error **errp)
>>   {
>>       uint64_t features[VIRTIO_FEATURES_NU64S];
>> -    unsigned int used, reserved, limit;
>>       int i, r, n_initialized_vqs = 0;
>>   
>>       hdev->vdev = NULL;
>> @@ -1603,19 +1641,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>           goto fail;
>>       }
>>   
>> -    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
>> -    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
>> -        memory_devices_memslot_auto_decision_active()) {
>> -        error_setg(errp, "some memory device (like virtio-mem)"
>> -            " decided how many memory slots to use based on the overall"
>> -            " number of memory slots; this vhost backend would further"
>> -            " restricts the overall number of memory slots");
>> -        error_append_hint(errp, "Try plugging this vhost backend before"
>> -            " plugging such memory devices.\n");
>> -        r = -EINVAL;
>> -        goto fail;
>> -    }
>> -
>>       for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
>>           r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i,
>>                                    busyloop_timeout);
>> @@ -1674,23 +1699,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>       memory_listener_register(&hdev->memory_listener, &address_space_memory);
> 
> 
> So it looks like with your change
> this will temporarily register the listener
> restricting the number of slots, then check and unregister.
> 
> Is this ever a problem?
> 
> commit log needs better documentation why.
> 
> 
> 
>>       QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>>   
>> -    /*
>> -     * The listener we registered properly setup the number of required
>> -     * memslots in vhost_commit().
>> -     */
>> -    used = hdev->mem->nregions;
>> -
>> -    /*
>> -     * We assume that all reserved memslots actually require a real memslot
>> -     * in our vhost backend. This might not be true, for example, if the
>> -     * memslot would be ROM. If ever relevant, we can optimize for that --
>> -     * but we'll need additional information about the reservations.
>> -     */
>> -    reserved = memory_devices_get_reserved_memslots();
>> -    if (used + reserved > limit) {
>> -        error_setg(errp, "vhost backend memory slots limit (%d) is less"
>> -                   " than current number of used (%d) and reserved (%d)"
>> -                   " memory slots for memory devices.", limit, used, reserved);
>> +    if (!check_memslots(hdev, errp)) {
>>           r = -EINVAL;
>>           goto fail;
>>       }
>> -- 
>> 2.48.1
> 


-- 
Best regards,
Vladimir

