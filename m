Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA153CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6xc7-0000dM-P1; Thu, 09 Oct 2025 16:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6xc5-0000cw-Ht; Thu, 09 Oct 2025 16:51:49 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6xbx-0002Wg-2N; Thu, 09 Oct 2025 16:51:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BD6E180845;
 Thu, 09 Oct 2025 23:51:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VpRuiL1FteA0-OOr1LuSI; Thu, 09 Oct 2025 23:51:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760043092;
 bh=pzd1Y0AemQ016gF1MBWMkPjE2UdLvlg6X6dAY/BjowQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NIdwVu6Va9yXjQtLf3ev3To6cQGLTj87pUO9JSt4n0lny29D5TCJ/4qwHYpW/HqK5
 9qKj575AWTbX0R2PDhmwPdl5dSv5y8Y7oR/s6UiqA3vAy5iHUkcICUzNXOhZyqpgix
 FQj/GXcKG9GA/ZezC3reF1b7KmTitjOMHGQ2HJZE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <69a0ca33-86da-4783-a158-67d34add1ff2@yandex-team.ru>
Date: Thu, 9 Oct 2025 23:51:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] vhost: introduce backend migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-29-vsementsov@yandex-team.ru>
 <CAFubqFsw63R8H6nH4ZvJVexgHnfeO6+M+yQo2y7Bw1VoFsgY2g@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFsw63R8H6nH4ZvJVexgHnfeO6+M+yQo2y7Bw1VoFsgY2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 09.10.25 22:09, Raphael Norwitz wrote:
> A few suggestions here. Overall, it looks sane to me.

First my applogizes, I should have said it earlier:

I'm preparing a v2, and starting from this patch it's significantly
reworked (the previous big part of refactoring (01-23,25) is still
relevant)

I have a parallel series for similar migration of virtio-net/tap
(TAP device fds are migrated through UNIX socket), and there were
a lot of discussions, and the ideas applies to vhost-user-blk series
as well.

The main change of v2 is significantly simplified interface:
the whole feature is enabled/disable by one migration parameter,
no need for per-device options. But this requires additional
changes in code, as we have to postpone backend (chardev opening
and initial communication to vhost-server) until the point in time
when we know, are we going to get the fds from migration channel
or not.

Next, migration part was revorked into VMSD structures instead of
.save() / .load() handlers.

Now, my work is to look at the comments and understand, how
much they apply to upcoming v2.

> 
> On Wed, Aug 13, 2025 at 12:56 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:

[..]

>>
>> @@ -1624,21 +1652,30 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>       r = vhost_set_backend_type(hdev, backend_type);
>>       assert(r >= 0);
>>
>> -    r = hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
>> -    if (r < 0) {
>> -        goto fail;
>> +    if (hdev->migrating_backend) {
>> +        /* backend must support detached state */
> 
> Probably better to error_report() or something other than a raw assert?

Assert is better, as this is not possible. Still, no such handlers in v2.

> 
>> +        assert(hdev->vhost_ops->vhost_save_backend);
>> +        assert(hdev->vhost_ops->vhost_load_backend);
>> +        hdev->_features_wait_incoming = true;
>>       }
>>
>> -    r = hdev->vhost_ops->vhost_set_owner(hdev);
>> +    r = hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
>>       if (r < 0) {
>> -        error_setg_errno(errp, -r, "vhost_set_owner failed");

[..]

>> @@ -1920,6 +1960,12 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>>                               uint64_t features)
>>   {
>>       const int *bit = feature_bits;
>> +
> 
> Should this be
> 
>      if (hdev->_features_wait_incoming && hdev->migrating_backend) {
> 
> to not impact existing flows?

This code is still in v2.

But _features_wait_incoming is a new field introduced withi this commit,
so there are no existing flows with it..

And in v2 _features_wait_incoming and migrating_backend are less
connected. Initialization code in v2 doesn't rely on .migrating_backend
(as we just don't know :). stop()/start() code will still rely on
.migrating_backend.

> 
>> +    if (hdev->_features_wait_incoming) {
>> +        /* Excessive set is enough for early initialization. */
>> +        return features;
>> +    }
>> +
>>       while (*bit != VHOST_INVALID_FEATURE_BIT) {
>>           uint64_t bit_mask = (1ULL << *bit);
>>           if (!vhost_dev_has_feature(hdev, *bit)) {
>> @@ -1930,6 +1976,66 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>>       return features;
>>   }
>>

[..]

>> @@ -2204,14 +2317,29 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
>>       event_notifier_cleanup(
>>           &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
>>
>> +    if (hdev->migrating_backend) {
> 
> Ditto - no raw assert()?


no handlers - no problmes (in v2 :). Still, I'm sure that assert was good here, as we never
set migrating_backend for devices which don't support it.

> 
> 
>> +        /* backend must support detached state */
>> +        assert(hdev->vhost_ops->vhost_save_backend);
>> +        assert(hdev->vhost_ops->vhost_load_backend);
>> +    }
>> +
>>       trace_vhost_dev_stop(hdev, vdev->name, vrings);
>>
>>       if (hdev->vhost_ops->vhost_dev_start) {
>>           hdev->vhost_ops->vhost_dev_start(hdev, false);
>>       }
>> -    if (vrings) {
>> +    if (vrings && !hdev->migrating_backend) {
>>           vhost_dev_set_vring_enable(hdev, false);
>>       }
>> +
>> +    if (hdev->migrating_backend) {
>> +        for (i = 0; i < hdev->nvqs; ++i) {
>> +            struct vhost_virtqueue *vq = hdev->vqs + i;
>> +
>> +            event_notifier_set_handler(&vq->error_notifier, NULL);
>> +        }
>> +    }
>> +
>>       for (i = 0; i < hdev->nvqs; ++i) {
>>           rc |= do_vhost_virtqueue_stop(hdev,
>>                                         vdev,



-- 
Best regards,
Vladimir

