Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AEAD29DC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 06:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYEG-0006Ll-72; Tue, 13 Jan 2026 01:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfYDe-00064T-5V; Tue, 13 Jan 2026 01:49:35 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfYDZ-0001tV-Ds; Tue, 13 Jan 2026 01:49:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3ADC3807A6;
 Tue, 13 Jan 2026 09:49:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:93c4:8e38:1f90:3c73] (unknown
 [2a02:6bf:803e:400:93c4:8e38:1f90:3c73])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KnM80u4Ae0U0-VhpsuKWX; Tue, 13 Jan 2026 09:49:22 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768286962;
 bh=TZ8mu0WBWMfswijbT+e0w17mPBYTxGyZIFriIAz1Nrw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WXitobGYAL7gMAU136XVxcq4dI5F8CErFnHBHnE1JEb9nDW4IUsERGIoaqX+E+JLE
 VpNydObfjJNqGSZGi1VgwsFUD8eWzk0BWvtwSHwNbU0Y2v/7Kk4oP1wSjs9OkTw6p5
 UZB7qtgjDlAkFQE0Pknptb0+s/pTcy721IH48KFI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f1fcd806-f391-47a4-821d-2d15882cd645@yandex-team.ru>
Date: Tue, 13 Jan 2026 11:49:20 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] vhost-user-blk: support inter-host inflight
 migration
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, mzamazal@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260112114503.1174330-1-dtalexundeer@yandex-team.ru>
 <20260112114503.1174330-6-dtalexundeer@yandex-team.ru>
 <20260112181917.GE462084@fedora>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260112181917.GE462084@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 1/12/26 23:19, Stefan Hajnoczi wrote:
> On Mon, Jan 12, 2026 at 04:45:03PM +0500, Alexandr Moshkov wrote:
>> During inter-host migration, waiting for disk requests to be drained
>> in the vhost-user backend can incur significant downtime.
>>
>> This can be avoided if QEMU migrates the inflight region in
>> vhost-user-blk.
>> Thus, during the qemu migration, with feature flag the vhost-user
>> back-end can immediately stop vrings, so all in-flight requests will be
>> migrated to another host.
>>
>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> ---
>>   hw/block/vhost-user-blk.c          | 28 ++++++++++++++++++++++++++++
>>   include/hw/virtio/vhost-user-blk.h |  1 +
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index a8fd90480a..5e44f6253c 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -656,6 +656,28 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
>>       return &s->dev;
>>   }
>>   
>> +static bool vhost_user_blk_inflight_needed(void *opaque)
>> +{
>> +    struct VHostUserBlk *s = opaque;
>> +
>> +    bool inflight_drain = vhost_dev_has_feature(&s->dev,
>> +                        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT must only be negotiated
> when inflight_migration is enabled. Otherwise the backend will use this
> feature even though vhost_user_blk_inflight_needed() skips migrating the
> in-flight region.
Oh, I understand now. I'll fix this too, thanks!

