Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228CFCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wGl-0001BG-Ae; Thu, 09 Oct 2025 15:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6wGe-0001AT-4e; Thu, 09 Oct 2025 15:25:37 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6wGZ-0001J3-64; Thu, 09 Oct 2025 15:25:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1EB7C807E9;
 Thu, 09 Oct 2025 22:25:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FPQEvJ1Fp8c0-JnZoAZhD; Thu, 09 Oct 2025 22:25:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760037916;
 bh=15Skc7FckDmLvkAS6DISAI4SPmDItD4ZvnHmk0YPbAA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gEFUp+TDh31pYLesS5oHk3NRiRmK014C4hYE3NZIeUHPsRBwqJAdO66vweX6cwAQy
 x9dkeJsiVrHWEErmn1XU+obvPKGj1v+fbwp1kkoUVcwqmd7GmEBi8G4ruQ0JZj8jtA
 8eSeXE7fZYQBrcIq24CKMMbAZGGgX4fgcC5ZYCGA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <69f22929-8439-4ed1-b2dc-3ca88f2ca40d@yandex-team.ru>
Date: Thu, 9 Oct 2025 22:25:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] vhost: introduce
 vhost_ops->vhost_set_vring_enable_supported method
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-2-vsementsov@yandex-team.ru>
 <CAFubqFvWwHu2B-Tg6eB+-j86mhGu8MKsHBLL-4+sQy9WS5XbWQ@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFvWwHu2B-Tg6eB+-j86mhGu8MKsHBLL-4+sQy9WS5XbWQ@mail.gmail.com>
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

On 09.10.25 21:56, Raphael Norwitz wrote:
> On Wed, Aug 13, 2025 at 12:53 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Remove vhost-user specific hack from generic code.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/vhost-user.c            |  8 ++++++++
>>   hw/virtio/vhost.c                 | 15 ++++++---------
>>   include/hw/virtio/vhost-backend.h |  2 ++
>>   3 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 1e1d6b0d6e..1b2879a90c 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -1230,6 +1230,12 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
>>       return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring, false);
>>   }
>>
>> +static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
>> +{
>> +    return virtio_has_feature(dev->backend_features,
>> +                              VHOST_USER_F_PROTOCOL_FEATURES);
>> +}
>> +
>>   static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>>   {
>>       int i;
>> @@ -3032,6 +3038,8 @@ const VhostOps user_ops = {
>>           .vhost_reset_device = vhost_user_reset_device,
>>           .vhost_get_vq_index = vhost_user_get_vq_index,
>>           .vhost_set_vring_enable = vhost_user_set_vring_enable,
>> +        .vhost_set_vring_enable_supported =
>> +            vhost_user_set_vring_enable_supported,
> 
> Why not make this a callback like vhost_user_gpu_{set|shared}_socket()
> in vhost_backend.h instead?

You mean make it just a separate function vhost_user_set_vring_enable_supported()?

But this way we'll have to keep "hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER"
below..

Or what do you mean?

> 
> 
>>           .vhost_requires_shm_log = vhost_user_requires_shm_log,
>>           .vhost_migration_done = vhost_user_migration_done,
>>           .vhost_net_set_mtu = vhost_user_net_set_mtu,
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 6557c58d12..c33dad4acd 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1986,15 +1986,12 @@ static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
>>           return 0;
>>       }
>>
>> -    /*
>> -     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
>> -     * been negotiated, the rings start directly in the enabled state, and
>> -     * .vhost_set_vring_enable callback will fail since
>> -     * VHOST_USER_SET_VRING_ENABLE is not supported.
>> -     */
>> -    if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER &&
>> -        !virtio_has_feature(hdev->backend_features,
>> -                            VHOST_USER_F_PROTOCOL_FEATURES)) {
>> +    if (hdev->vhost_ops->vhost_set_vring_enable_supported &&
>> +        !hdev->vhost_ops->vhost_set_vring_enable_supported(hdev)) {
>> +        /*
>> +         * This means, that rings are always enabled, and disable/enable
>> +         * API is not supported.
>> +         */
>>           return 0;
>>       }
>>
>> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
>> index d6df209a2f..f65fa26298 100644
>> --- a/include/hw/virtio/vhost-backend.h
>> +++ b/include/hw/virtio/vhost-backend.h
>> @@ -105,6 +105,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
>>   typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
>>   typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
>>                                            int enable);
>> +typedef bool (*vhost_set_vring_enable_supported_op)(struct vhost_dev *dev);
>>   typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
>>   typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
>>                                          char *mac_addr);
>> @@ -193,6 +194,7 @@ typedef struct VhostOps {
>>       vhost_reset_device_op vhost_reset_device;
>>       vhost_get_vq_index_op vhost_get_vq_index;
>>       vhost_set_vring_enable_op vhost_set_vring_enable;
>> +    vhost_set_vring_enable_supported_op vhost_set_vring_enable_supported;
>>       vhost_requires_shm_log_op vhost_requires_shm_log;
>>       vhost_migration_done_op vhost_migration_done;
>>       vhost_vsock_set_guest_cid_op vhost_vsock_set_guest_cid;
>> --
>> 2.48.1
>>
>>


-- 
Best regards,
Vladimir

