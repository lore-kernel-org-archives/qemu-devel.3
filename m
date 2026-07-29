Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C418C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1JX-0008EJ-8F; Wed, 29 Jul 2026 06:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp1JV-0008E2-Mj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp1JU-0005Gq-2t
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785320099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eROq5aHdjWSnz43ds9dNZRTI0rWGEt384Vv2CIIwYso=;
 b=evaSRA7f8FntSyTZfK5pBcGnciwrMJ03JZaG/6qScLvG3KIUa87aHpuhhSdRjy+nNJqyMi
 ILDXMeRqMl/4anOIPX8TBLRNXhQv5CVm818mdWH4GyMwsAPdqO0pZQsjvBkZnRsnWDOOz7
 sN263UfWYVNUGrl4ldxjGH3jUOZvi7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-6d_iRH_3ODO6T2lJ8g3S0g-1; Wed, 29 Jul 2026 06:14:57 -0400
X-MC-Unique: 6d_iRH_3ODO6T2lJ8g3S0g-1
X-Mimecast-MFC-AGG-ID: 6d_iRH_3ODO6T2lJ8g3S0g_1785320097
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493a7fa8481so12825715e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785320096; x=1785924896; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eROq5aHdjWSnz43ds9dNZRTI0rWGEt384Vv2CIIwYso=;
 b=ccONOxh3EsVbhuppmXK8lsBr+C3Sd1Gtq+OgBB86jdp6q3CexajevIqHkqKHzHCRHC
 qazMG/W15UGtSmbzxLQLUjjmoJqD+M85X1UmTPE+EANt/KXyEgUrYKQSZvkjGYDZ1Uvq
 qtJ8L2fQqQPPtjzkDeQLLf8bH/hivzotcLS7kTvqeS8tvUs+/fJYN371yFxP+AgqX+K1
 BsP/hWnoOfCbKsKS/4Kf2oTLZuXSKfL3s7/BpYT2sSRElK2mtME53yL4+uOt4fn3ZHrY
 CoF3SaPSMfj3G1wtENZzxid+r2oFjn4YtCAuBEt7YzOS0TlsP9PW7rgoXeDCkzmBRvKu
 3B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785320096; x=1785924896;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eROq5aHdjWSnz43ds9dNZRTI0rWGEt384Vv2CIIwYso=;
 b=cLHLgx0fwliRJeK8U2/QTGKUnef5ePk9ry0peaqAkVpDWVXgdsYo2sd8oZfU9rxFWn
 MobHtRk3heW2QuzZsERGRgCXXZkFyD0RFIeMXNtTM78CzR83EulfEsNRaHqJyuVJ7YrG
 Vf3sgnTr939P20U4sTE2ckD2f9trQn4HbVlMDr9nE60gRyHB6LtyTyj3WZUcBvXTxlA+
 cbbgw39tL2yz792kmfnpPyy5DopdiNuSOcpYcn4qeYsSsXA3OzqvVZZGVUiNOGiP1Xdc
 XwhCib2ZAo54BAUOhI3h1jtzjTY5MK8ftzsVvj0jQtcZwADKjLLYvS+Xs7fQbMNpAYfU
 eUjA==
X-Gm-Message-State: AOJu0YyltmI/+mDSYrxL3CCkkq7QxTeaI6nKavY/FPJhnCgnjs1toy3C
 p6II7Nw4IGU2Gwn1yrX0whfSFeOss3lBib2lQYJzUoarfSz5fNi5jptid5Hjal477uytJBvrr3E
 zpg1H3wtBiz5PNQW/R2P6Doy06hwROBbFX6tX6v2gSAEsZSFIkjbSO7Lq
X-Gm-Gg: AR+sD12XsTC32JMIMOJc1fR3fDbGMCY2vGU7DAJ8R2bd82ZMNzs9dOfKunP0kzARTAE
 3WprHpKYhlwpcrVxI0JM4Btx7JtzJdZku1T4curab6qcEWOJOFaJkojNJUEfLSozcQyIrXkor4S
 0lPZBwJAa072FrZy5o+L7tUmv2Val1VZ8XbXDNHu3IEY3uSAVwMduWc0skbnGjxGfAKJaOmGf/N
 E+nKfATj4UJBeA/9RtcvFrKDO/V4cJ6Erk/rQP08EAdZDLO46q1HxqgcMqP0tVUS1GytmsnK+B5
 oOanvRbDyqV02kIWWaVqNVjV5JzMVGadjajxJEgqckXq3EeT3L/1wWhfuMKBFA5Ut9xp1X6Mr7B
 nLJEAV3gTH6y+aERhHJUAVuw=
X-Received: by 2002:a05:600c:4746:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-497fd2f50bbmr16748335e9.3.1785320096535; 
 Wed, 29 Jul 2026 03:14:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4746:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-497fd2f50bbmr16747845e9.3.1785320095897; 
 Wed, 29 Jul 2026 03:14:55 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4615f5fsm139025205e9.9.2026.07.29.03.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:14:55 -0700 (PDT)
Date: Wed, 29 Jul 2026 06:14:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 virtio-fs@lists.linux.dev, Kevin Wolf <kwolf@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>
Subject: Re: [PATCH v5 4/6] vhost-user-blk: make inflight-migration prop
 mutable
Message-ID: <20260729061316-mutt-send-email-mst@kernel.org>
References: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
 <20260728100841.3475774-5-dtalexundeer@yandex-team.ru>
 <20260729051509-mutt-send-email-mst@kernel.org>
 <679a33d1-0f6c-4456-ac76-1f9e1251f2ec@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <679a33d1-0f6c-4456-ac76-1f9e1251f2ec@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

On Wed, Jul 29, 2026 at 03:09:57PM +0500, Alexandr Moshkov wrote:
> 
> On 7/29/26 14:32, Michael S. Tsirkin wrote:
> 
>     On Tue, Jul 28, 2026 at 03:08:39PM +0500, Alexandr Moshkov wrote:
> 
>         When migrating from a QEMU version that supports inflight-migration to
>         an older one that does not, there is no way to disable the feature at
>         runtime — the VM must be stopped and reconfigured. This is impractical
>         in production environments.
> 
>         Make the inflight-migration property mutable after device realization
>         so it can be toggled via qom-set without restarting the VM.
> 
>         Acked-by: Raphael Norwitz <rnorwitz@nvidia.com>
>         Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> 
> 
> 
>     I think I am beginning to understand.
> 
> 
>     You are running qemu with inflight-migration on and want to migrate
>     to qemu without inflight-migration at all.
> 
> 
>     Since it is guest transparent you could retrofit it like this.
> 
>     My question is why is it worth it, we do not normally support
>     migrating between qemu versions with different command lines.
> 
> I think you right. Maybe I've been focusing too much on the ability to migrate 
> between versions of qemu with and without inflight migration.
> 
> This series allows to turn off and on the inflight-migration feature at runtime
> without recreating the VM (it was the only way to turn off the feature, since
> the protocol feature could no longer be turned off, after initialization with
> the backend). This is more important feature, and it leads to the fact that
> this feature allows to migrate between different versions of qemu (with and
> without inflight-migration support).
> 
>     
> 
>         ---
>          hw/block/vhost-user-blk.c | 10 ++++++++--
>          1 file changed, 8 insertions(+), 2 deletions(-)
> 
>         diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>         index e3b873af7c..650c004bde 100644
>         --- a/hw/block/vhost-user-blk.c
>         +++ b/hw/block/vhost-user-blk.c
>         @@ -619,6 +619,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>              }
>          };
> 
>         +static PropertyInfo vhost_user_blk_inflight_migration_prop;
>         +
>          static const Property vhost_user_blk_properties[] = {
>              DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
>              DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
>         @@ -632,8 +634,9 @@ static const Property vhost_user_blk_properties[] = {
>                                VIRTIO_BLK_F_WRITE_ZEROES, true),
>              DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
>                               skip_get_vring_base_on_force_shutdown, false),
>         -    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
>         -                     inflight_migration, false),
>         +    DEFINE_PROP("inflight-migration", VHostUserBlk, inflight_migration,
>         +                vhost_user_blk_inflight_migration_prop, bool,
>         +                .set_default = true, .defval.u = false),
>          };
> 
>          static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
>         @@ -665,6 +668,9 @@ static const TypeInfo vhost_user_blk_info = {
> 
>          static void virtio_register_types(void)
>          {
>         +    vhost_user_blk_inflight_migration_prop = qdev_prop_bool;
>         +    vhost_user_blk_inflight_migration_prop.realized_set_allowed = true;
>         +
>              type_register_static(&vhost_user_blk_info);
>          }
> 
>     So then,  for example, let us say I paused the VM, then set the flag,
>     now inflight is on but GET_BASE did not drain it?
> 
> If I understood the question correctly, this is valid behavior. Before
> migration QEMU check protocol features to understand does the backend support
> inflight migration. If it does, after that QEMU migrate inflight buffer to
> other VM. If it's not, return error before migration started.  


I apologise i reverted the logic in the question.


I start vm and inflight is on.
I stop vm get base does not drain.
i turn inflight off.
now it looks like it will happily migrate?

>         --
>         2.34.1
> 


