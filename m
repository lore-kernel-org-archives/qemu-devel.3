Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581A3D3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKca-00027u-KQ; Wed, 10 Dec 2025 08:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vTKcR-00026a-FX
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:52:39 -0500
Received: from sg-1-103.ptr.blmpb.com ([118.26.132.103])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vTKcO-00043b-8K
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765374742; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=knl56dxc9X5hN9naSgMIm0AOR5GwUtxhuUQBXLgfYYo=;
 b=bfgmfrQ4vXDdbwiZtzlsx81mDxQax8fY3tVX2hFXLEnFpima5ajvEjOKZL9AEWNkvRGNI1
 oOAVv3RWeB0owaUM85RlTHEav2IG9lmZMPUzFN7WFamuvOKwkn8lap3upUVhrNG3zCCcUa
 KahGeyrx86r7mdc68I54zQYImFP8l5ZUwHX6QFdEzYbGBvTFhwizZsUKrzc65952rehtcu
 kGn7Hl3/dZAJ2Rt6yiaKTpwoM2nOpXmBX2UBBNgHumDwovGYUFnofoCyQYdS2zzxU/uZdU
 iNAJN589VyNzf5MMo9ix7AqiyC5PfQ9CiM3tTQxfB8E0+296VmsOlXeN6/87RA==
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Subject: Re: [RFC v1 1/2] vhost: eliminate duplicate dirty_bitmap sync when
 log shared by multiple devices
User-Agent: Mozilla Thunderbird
To: "Jason Wang" <jasowang@redhat.com>
Date: Wed, 10 Dec 2025 21:52:18 +0800
Message-Id: <8591d0f5-7bb9-4394-b859-1c0cdd6d4899@bytedance.com>
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
In-Reply-To: <CACGkMEvKyxBry25+bz4Pzk4bWZS38jWxQDSnq49qKg0Fv3LC-w@mail.gmail.com>
Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>, <sgarzare@redhat.com>, 
 <richard.henderson@linaro.org>, <pbonzini@redhat.com>, 
 <david@kernel.org>, <philmd@linaro.org>, <farosas@suse.de>, 
 "Peter Xu" <peterx@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+269397b14+e8ad43+nongnu.org+xuchuangxclwt@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
 <20251208120952.37563-2-xuchuangxclwt@bytedance.com>
 <aTiK5opcOOrsFem9@x1.local>
 <CACGkMEvKyxBry25+bz4Pzk4bWZS38jWxQDSnq49qKg0Fv3LC-w@mail.gmail.com>
Received-SPF: pass client-ip=118.26.132.103;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-103.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,=C2=A0Jason

On 10/12/2025 14:51, Jason Wang wrote:
>>> ---
>>>   hw/virtio/vhost.c         | 30 ++++++++++++++++++++++--------
>>>   include/hw/virtio/vhost.h |  1 +
>>>   2 files changed, 23 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 266a11514a..d397ca327f 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -268,14 +268,6 @@ static int vhost_sync_dirty_bitmap(struct vhost_de=
v *dev,
>>>       return 0;
>>>   }
>>>
>>> -static void vhost_log_sync(MemoryListener *listener,
>>> -                          MemoryRegionSection *section)
>>> -{
>>> -    struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
>>> -                                         memory_listener);
>>> -    vhost_sync_dirty_bitmap(dev, section, 0x0, ~0x0ULL);
>>> -}
>>> -
>>>   static void vhost_log_sync_range(struct vhost_dev *dev,
>>>                                    hwaddr first, hwaddr last)
>>>   {
>>> @@ -287,6 +279,27 @@ static void vhost_log_sync_range(struct vhost_dev =
*dev,
>>>       }
>>>   }
>>>
>>> +static void vhost_log_sync(MemoryListener *listener,
>>> +                          MemoryRegionSection *section)
>>> +{
>>> +    struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
>>> +                                         memory_listener);
>>> +    struct vhost_log *log =3D dev->log;
>>> +
>>> +    if (log && log->refcnt > 1) {
>>> +        /*
>>> +         * When multiple devices use same log, we implement the logic =
of
>>> +         * vhost_log_sync just like what we do in vhost_log_put.
>>> +         */
> We should have already avoided the duplicated syncing with
> vhost_dev_should_log()? Or anything I miss here?

You're right, in my environment, I used version 8.1 for daily testing.=20
When I checked

the latest version in the community, I didn't notice that optimization=20
and naturally

assumed that the latest version of vhost_log_sync also had the same issue.


I apologize for sending a duplicate optimization for vhost_log_sync.

Hope the formula derivation in the cover will provide some inspiration=20
for future optimization work.


Thank you for the reminder.

