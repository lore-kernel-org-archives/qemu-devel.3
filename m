Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9172C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3AB-0006yU-Ra; Wed, 29 Jul 2026 08:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp3A8-0006xj-KG
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp3A6-000379-CK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785327205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THvdhvNtSPM3uYfk7F11gDa6rQECqt7z01fPOqYKnF8=;
 b=DVFDZSaiw521y4XMnx+P4yCBkYXhvJGCq9TbqHz54stOh3kwTTXrKdIQVMRXRFskB5hzW5
 a+O5zfF8/MD13K/EpHkvCnltzLIddO8IzgVm/SAytzja8OVFFOiChvsaTcpJ8nR+xt+HFo
 Ni3bX5ZrE3zNMBJ3N/koJRn9BNyGvKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-_-lnZqaXPUS_IqZxyByM9A-1; Wed, 29 Jul 2026 08:13:23 -0400
X-MC-Unique: _-lnZqaXPUS_IqZxyByM9A-1
X-Mimecast-MFC-AGG-ID: _-lnZqaXPUS_IqZxyByM9A_1785327202
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47faa02f707so693087f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785327202; x=1785932002; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=THvdhvNtSPM3uYfk7F11gDa6rQECqt7z01fPOqYKnF8=;
 b=sm+tUW6FOBy4pLrpLFZwNwj4qbReFaUUG/UA9o4w+S1KHImltloNbTO03Jf5dMegIx
 0MNy+4IQ1CLaBKrS/ARzlEGIGY2c4sQPhEf9VKIKVU/ocGnQ2USTgRWENfvBVAyGaRSW
 J9d0wyytx76QTWJyIX7QCSsE58Nk2hHMNYimzzKWHNDFGk7JAkYIvDPr0Xrvs6X0TPmm
 u7hxemQcOBAPVw2S6zKhxSQQMwhub48OQUZStEg8YjvSSNp9su5tIscAWoPXRYs2kBaH
 d39WCI4dBtNADR8JzfB4IshA82d1+G/m+ZJh+7oCJzyGr0cgSjd7hzZvmVWrJwfOw5fu
 jdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327202; x=1785932002;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=THvdhvNtSPM3uYfk7F11gDa6rQECqt7z01fPOqYKnF8=;
 b=Q/pTfKY5MNAe1h3wSAmFI+YDU/jhxYE1fTzzzLKwUEbFWX0tGOymbuWn4vsqNDctk2
 60l6fcwdqibeeFNIxz4Ctph3ixsKLxTao7Ji+OCk4F/Pi+h/VbVxD3HvVSNFioWBj3T/
 bjGIkzlb02cyBte9NNyVWBCCvqtE5B196N7FPdnODuxv6GpqR7OstK4G7T+INNAo4jNT
 dS7roPvoqJam7xrpqVYa+SfAGx7xBmIqQm5B3771V7CDSNNAL7GH8yBE+KdsMYKJIjqI
 wJmsOOD1sJ4if/Pl16wXBzKj2hiNZ/imylr39kT7DfEfU0aHoLfusOzQKb+fDVE8K/go
 nLtw==
X-Gm-Message-State: AOJu0Yy+s+fSEJZMsdhcGRhZ8CsSXpYGQcexXF0bZGbLkLRQZ+A67jIf
 ZQRyx8vXHU0ekaGj25r2oUEW02fniF4VGSFSU6vmfnSItVNQa67jyjk7PZD0QVus9jxi65ApOiN
 aP36DRkil0iTEKr4NERmofooPaF4mJDDXD9StjnAS2GPDMe9g/ociuk1i
X-Gm-Gg: AR+sD12Pj8qOs/r7RatnuCITiqj6+z5efCGeNqNd1kFtq0P0B7j97Y5vKl7qnXKUzvC
 aK8R+cTvAfBzn0X/97VcQnJxZ+geF3LGOm4zFpTCHCs/wAIZu9fjWQUOVnSBGQhDOpmhEQblZ35
 5E98jdyoetKAfunIjl5ZSb18Q3RvFwqR8o4g7qBCCONCRYiCgAzOXH1ueB889hlo2j4rU2NED0o
 7BCT11TtA/3MWzGyK/cW2bSGUJRG4/dlXMcqsW2AZak8lmiJPu0xQKUmXAtc3OLxkSp3cRxAS/i
 YiVIO6RPKpPTKVyJt13mJkKCFlZoqHpF0xzUSzHu3bt5johZkdc54Y3yoN6KsWY6Oamsx2Qhu5C
 tsi2bjzlG7PUA4RYYbnbUMB8=
X-Received: by 2002:a05:6000:1787:b0:47f:95ce:85be with SMTP id
 ffacd0b85a97d-47fbac063a1mr2903015f8f.30.1785327201981; 
 Wed, 29 Jul 2026 05:13:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1787:b0:47f:95ce:85be with SMTP id
 ffacd0b85a97d-47fbac063a1mr2902936f8f.30.1785327201302; 
 Wed, 29 Jul 2026 05:13:21 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6abc703sm7550126f8f.9.2026.07.29.05.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:13:20 -0700 (PDT)
Date: Wed, 29 Jul 2026 08:13:13 -0400
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
Message-ID: <20260729074711-mutt-send-email-mst@kernel.org>
References: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
 <20260728100841.3475774-5-dtalexundeer@yandex-team.ru>
 <20260729051509-mutt-send-email-mst@kernel.org>
 <679a33d1-0f6c-4456-ac76-1f9e1251f2ec@yandex-team.ru>
 <20260729061316-mutt-send-email-mst@kernel.org>
 <a4db1b40-d48c-473b-86a7-63a0c0cc5ccf@yandex-team.ru>
 <20260729064648-mutt-send-email-mst@kernel.org>
 <dd1f5830-75ff-4256-a179-6a8341a3b4ec@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd1f5830-75ff-4256-a179-6a8341a3b4ec@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 29, 2026 at 03:56:54PM +0500, Alexandr Moshkov wrote:
> 
> On 7/29/26 15:48, Michael S. Tsirkin wrote:
> 
>     On Wed, Jul 29, 2026 at 03:35:31PM +0500, Alexandr Moshkov wrote:
> 
>         On 7/29/26 15:14, Michael S. Tsirkin wrote:
> 
>             On Wed, Jul 29, 2026 at 03:09:57PM +0500, Alexandr Moshkov wrote:
> 
>                 On 7/29/26 14:32, Michael S. Tsirkin wrote:
> 
>                      On Tue, Jul 28, 2026 at 03:08:39PM +0500, Alexandr Moshkov wrote:
> 
>                          When migrating from a QEMU version that supports inflight-migration to
>                          an older one that does not, there is no way to disable the feature at
>                          runtime — the VM must be stopped and reconfigured. This is impractical
>                          in production environments.
> 
>                          Make the inflight-migration property mutable after device realization
>                          so it can be toggled via qom-set without restarting the VM.
> 
>                          Acked-by: Raphael Norwitz <rnorwitz@nvidia.com>
>                          Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> 
> 
> 
>                      I think I am beginning to understand.
> 
> 
>                      You are running qemu with inflight-migration on and want to migrate
>                      to qemu without inflight-migration at all.
> 
> 
>                      Since it is guest transparent you could retrofit it like this.
> 
>                      My question is why is it worth it, we do not normally support
>                      migrating between qemu versions with different command lines.
> 
>                 I think you right. Maybe I've been focusing too much on the ability to migrate
>                 between versions of qemu with and without inflight migration.
> 
>                 This series allows to turn off and on the inflight-migration feature at runtime
>                 without recreating the VM

restarting you mean.

> (it was the only way to turn off the feature, since
>                 the protocol feature could no longer be turned off, after initialization with
>                 the backend). This is more important feature, and it leads to the fact that
>                 this feature allows to migrate between different versions of qemu (with and
>                 without inflight-migration support).

so again it's not the 1st feature we have like this. we tie migration
to the machine type and same set of command line flags
specifically to keep things manageable.

really cross version migration is a pain as it is.

> 
>                          ---
>                           hw/block/vhost-user-blk.c | 10 ++++++++--
>                           1 file changed, 8 insertions(+), 2 deletions(-)
> 
>                          diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>                          index e3b873af7c..650c004bde 100644
>                          --- a/hw/block/vhost-user-blk.c
>                          +++ b/hw/block/vhost-user-blk.c
>                          @@ -619,6 +619,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>                               }
>                           };
> 
>                          +static PropertyInfo vhost_user_blk_inflight_migration_prop;
>                          +
>                           static const Property vhost_user_blk_properties[] = {
>                               DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
>                               DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
>                          @@ -632,8 +634,9 @@ static const Property vhost_user_blk_properties[] = {
>                                                 VIRTIO_BLK_F_WRITE_ZEROES, true),
>                               DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
>                                                skip_get_vring_base_on_force_shutdown, false),
>                          -    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
>                          -                     inflight_migration, false),
>                          +    DEFINE_PROP("inflight-migration", VHostUserBlk, inflight_migration,
>                          +                vhost_user_blk_inflight_migration_prop, bool,
>                          +                .set_default = true, .defval.u = false),
>                           };
> 
>                           static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
>                          @@ -665,6 +668,9 @@ static const TypeInfo vhost_user_blk_info = {
> 
>                           static void virtio_register_types(void)
>                           {
>                          +    vhost_user_blk_inflight_migration_prop = qdev_prop_bool;
>                          +    vhost_user_blk_inflight_migration_prop.realized_set_allowed = true;
>                          +
>                               type_register_static(&vhost_user_blk_info);
>                           }
> 
>                      So then,  for example, let us say I paused the VM, then set the flag,
>                      now inflight is on but GET_BASE did not drain it?
> 
>                 If I understood the question correctly, this is valid behavior. Before
>                 migration QEMU check protocol features to understand does the backend support
>                 inflight migration. If it does, after that QEMU migrate inflight buffer to
>                 other VM. If it's not, return error before migration started.
> 
>             I apologise i reverted the logic in the question.
> 
> 
>             I start vm and inflight is on.
>             I stop vm get base does not drain.
> 
>         In case of VM stop, backend wait to drain all requests. Ability to perform
>         drain or not available only during migration by skip_drain variable in
>         vhost_user_blk_stop().
> 
>     What if it was migration but it failed?
> 
> If migration failed, source vm just keep using inflight region, backend
> continue to execute inflight requests that was tried to migrate.


Sorry, to be more clear. I mean migration succeeded but destination failed to
start, so now vm is stopped and we are now trying migrating to a different destination.

IIUC currently on VM stop we simply send GET_BASE and this stops
backend, and depending on features things remain in the inflight buffer.
Correct me if  I am wrong.

I think that we do not want a slow flush on vm stop if we
can avoid it, and we also do not want backend to keep changing
guest memory when VM is stopped. No?




> 
> 
>         skip_drain true only if inflight_migration is on and runstate is
>         FINISH_MIGRATION.

FINISH_MIGRATE? actually i do not see where it affects it.

> 
>     This btw I don't much like, a stopped VM would preferably
>     behave the same whatever the reason to stop.
> 
> Well, I don't see any other way to implement this.


I am not 100% sure it's implementable as described, but I guess
you could block changing the property if VM and thus the backend
is not connected and running.


Which is even more complexity but at least it is consistent.






> I think backend must perform
> drain in all cases except live migration with all the necessary checks 
> (protocol features, special message GET_VRING_BASE_SKIP_DRAIN).


This is not what is going on now, right? Whether it drains depends
on protocol features not on VM state and I think we should
keep it like this.



> 
> 
>             i turn inflight off.
>             now it looks like it will happily migrate?
> 
>         So in this case, when vm migrated with inflight off, it will leads to using
>         GET_VRING_BASE message, that wait all requests to be drained.
> 
> 
>                          --
>                          2.34.1
> 
>


i mean it migrated with on. vm was stopped then it flipped to off.






-- 
MST 


