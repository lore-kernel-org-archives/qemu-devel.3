Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FB9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFJu-000206-Fq; Tue, 21 Oct 2025 12:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBFJq-0001ys-1t; Tue, 21 Oct 2025 12:34:42 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBFJl-000439-CP; Tue, 21 Oct 2025 12:34:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9E74BC026F;
 Tue, 21 Oct 2025 19:34:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4c::1:32] (unknown
 [2a02:6bf:8080:a4c::1:32])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PYZD640P3W20-lYxediLN; Tue, 21 Oct 2025 19:34:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761064466;
 bh=8RZ2DEmQswhERLMVMCdsdTZaKi6SoE4FXixgaTbK1SY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=akTF8bVVDoc6GjzRFYy4IiwaGhFewCt70YlNFVAvg7OBRAX8D0dF0QO3tXT0WjG0o
 4EVbXGSPVJ7Z5RU7dHFOLFyhI5JCDbhMbNVkUSeEZVMqRa5GJMOyaB6uLvhciZEz2l
 CSpj+iASFV3j1Rj6T9e+ejB9vSx4wv1YDm0aKeFQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1f2cb2aa-1920-4321-8180-ec9052b1c4f6@yandex-team.ru>
Date: Tue, 21 Oct 2025 19:34:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/25] vhost-user: add vmstate
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de,
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-21-vsementsov@yandex-team.ru>
 <CAFubqFsLqnHc1tm5B0PCFcDsRgzifB-6aX+UK4F6NfC_W-FE8g@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFsLqnHc1tm5B0PCFcDsRgzifB-6aX+UK4F6NfC_W-FE8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 21.10.25 02:51, Raphael Norwitz wrote:
> For now a naming nit and a question.
> 
> On Thu, Oct 16, 2025 at 7:44 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/vhost-user.c         | 95 ++++++++++++++++++++++++++++++++++
>>   include/hw/virtio/vhost-user.h |  4 ++
>>   2 files changed, 99 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index c5cb5ed528..a820214188 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -28,6 +28,8 @@
>>   #include "system/runstate.h"
>>   #include "system/cryptodev.h"
>>   #include "migration/postcopy-ram.h"
>> +#include "migration/qemu-file-types.h"
>> +#include "migration/qemu-file.h"
>>   #include "trace.h"
>>   #include "system/ramblock.h"
>>
>> @@ -3137,6 +3139,99 @@ void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
>>           qmp_decode_protocols(u->protocol_features);
>>   }
>>
>> +typedef struct VhostUserMigTmp {
>> +    struct vhost_dev *parent;
>> +    bool has_backend_channel;
>> +    int backend_fd;
>> +    uint32_t memory_slots;
>> +    uint64_t protocol_features;
>> +} VhostUserMigTmp;
>> +
>> +static int vhost_user_tmp_pre_save(void *opaque)
>> +{
>> +    VhostUserMigTmp *tmp = opaque;
>> +    struct vhost_dev *dev = tmp->parent;
>> +    struct vhost_user *u = dev->opaque;
>> +    QIOChannelSocket *sioc = u->backend_sioc;
>> +
>> +    if (sioc && sioc->fd < 0) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    tmp->backend_fd = sioc ? sioc->fd : -1;
>> +    tmp->has_backend_channel = !!sioc;
>> +    tmp->memory_slots = u->user->memory_slots;
>> +    tmp->protocol_features = u->protocol_features;
>> +
>> +    return 0;
>> +}
>> +
>> +static int vhost_user_tmp_post_load(void *opaque, int version_id)
>> +{
>> +    struct VhostUserMigTmp *tmp = opaque;
>> +    struct vhost_dev *dev = tmp->parent;
>> +    struct vhost_user *u = dev->opaque;
>> +    Error *local_err = NULL;
>> +
>> +    if (tmp->has_backend_channel) {
>> +        u->backend_sioc = qio_channel_socket_new_fd(tmp->backend_fd,
>> +                                                    &local_err);
>> +        if (!u->backend_sioc) {
>> +            error_report_err(local_err);
>> +            return -EINVAL;
>> +        }
>> +        u->backend_src = qio_channel_add_watch_source(
>> +            QIO_CHANNEL(u->backend_sioc), G_IO_IN | G_IO_HUP,
>> +            backend_read, u->dev, NULL, NULL);
>> +    }
>> +
>> +    u->user->memory_slots = tmp->memory_slots;
>> +    u->protocol_features = tmp->protocol_features;
>> +
>> +    return 0;
>> +}
>> +
>> +static bool vhost_user_tmp_test_fd(void *opaque, int version_id)
>> +{
>> +    struct VhostUserMigTmp *tmp = opaque;
>> +
>> +    return tmp->has_backend_channel;
>> +}
>> +
> 
> Will this be vhost-user-blk specific? It should probably be something
> like vhost_user_backend_transfer_tmp?
> 

Oh right. a mistake.

>> +static const VMStateDescription vmstate_vhost_user_blk_tmp = {
>> +    .name = "vhost-user-blk-tmp",
>> +    .pre_save = vhost_user_tmp_pre_save,
>> +    .post_load = vhost_user_tmp_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT64(protocol_features, VhostUserMigTmp),
>> +        VMSTATE_UINT32(memory_slots, VhostUserMigTmp),
>> +        VMSTATE_BOOL(has_backend_channel, VhostUserMigTmp),
>> +        VMSTATE_FD_TEST(backend_fd, VhostUserMigTmp, vhost_user_tmp_test_fd),
>> +        VMSTATE_END_OF_LIST()
>> +   },
>> +};
>> +
>> +static int vhost_user_post_load(void *opaque, int version_id)
>> +{
>> +    struct vhost_dev *dev = opaque;
>> +    struct vhost_user *u = dev->opaque;
>> +
>> +    u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
>> +    postcopy_add_notifier(&u->postcopy_notifier);
>> +
>> +    return 0;
>> +}
>> +
> 
> Why do we need a second post_load() callback here? Why can't
> u->postcopy_notifier.notify be set in vhost_user_tmp_post_load()?

Hmm.. Yes, looks strange, I don't remember. Will try to merge.

> 
> 
>> +const VMStateDescription vmstate_vhost_user = {
>> +    .name = "vhost-user",
>> +    .post_load = vhost_user_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_WITH_TMP(struct vhost_dev, VhostUserMigTmp,
>> +                         vmstate_vhost_user_blk_tmp),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   const VhostOps user_ops = {
>>           .backend_type = VHOST_BACKEND_TYPE_USER,
>>           .vhost_backend_init = vhost_user_backend_init,
>> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>> index 36d96296a3..fb89268de2 100644
>> --- a/include/hw/virtio/vhost-user.h
>> +++ b/include/hw/virtio/vhost-user.h
>> @@ -114,4 +114,8 @@ void vhost_user_async_close(DeviceState *d,
>>
>>   void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
>>
>> +extern const VMStateDescription vmstate_vhost_user;
>> +#define VMSTATE_BACKEND_TRANSFER_VHOST_USER(_field, _state) \
>> +    VMSTATE_STRUCT(_field, _state, 0, vmstate_vhost_user, struct vhost_dev)
>> +
>>   #endif
>> --
>> 2.48.1
>>
>>


-- 
Best regards,
Vladimir

