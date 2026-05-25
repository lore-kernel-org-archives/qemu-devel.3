Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99589CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 12:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRUs6-0006a1-Am; Mon, 25 May 2026 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wRUs3-0006ZE-Te; Mon, 25 May 2026 08:57:27 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wRUs0-0001qR-AS; Mon, 25 May 2026 08:57:27 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 44DB58074F;
 Mon, 25 May 2026 15:57:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8e::1:a] (unknown [2a02:6bf:8080:b8e::1:a])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id FvWitP1gMOs0-no1MYikO; Mon, 25 May 2026 15:57:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779713836;
 bh=GGu40zt+3Pj/5Eue9IyEKU/aWhrD24iIS0v4UNyTbHU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=If2hagXQ+bif29R4w7MYarFKN+A9b+g3C9Ay1dIINsVrSuQC6yyZ0zLVV8X4+ff9s
 7eJn3DJeZyPXwXXKlnS76gHjotHEByBEXaXw+hG2ooSTwsO0FLSVRIkXk/+EFEH5xC
 2crlElfj+YjxIQ+zWKbk8uPAdJ48QuixlK1EQUmU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1db6e4bf-ec69-47bb-8d8a-cbb7ea683e2e@yandex-team.ru>
Date: Mon, 25 May 2026 15:57:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/22] vhost: move protocol_features to vhost_user
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi
 <zhenwei.pi@linux.dev>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20260420200339.708640-1-vsementsov@yandex-team.ru>
 <20260420200339.708640-5-vsementsov@yandex-team.ru>
 <6b808fc2-a90e-4b25-84d2-d516eb176c8e@yandex-team.ru>
 <20260524025735-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260524025735-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
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

On 24.05.26 09:58, Michael S. Tsirkin wrote:
> On Fri, May 22, 2026 at 03:31:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 20.04.26 23:03, Vladimir Sementsov-Ogievskiy wrote:
>>> As comment says: it's only for vhost-user. So, let's move it
>>> to corresponding vhost backend realization.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>    backends/cryptodev-vhost.c     |  1 -
>>>    hw/block/vhost-user-blk.c      |  6 ++----
>>>    hw/net/vhost_net.c             |  2 --
>>>    hw/virtio/meson.build          |  3 +++
>>>    hw/virtio/vhost-user-stub.c    |  6 ++++++
>>>    hw/virtio/vhost-user.c         | 36 +++++++++++++++++++++++++++-------
>>>    hw/virtio/virtio-qmp.c         |  6 ++++--
>>>    include/hw/virtio/vhost-user.h |  4 ++++
>>>    include/hw/virtio/vhost.h      |  8 --------
>>>    9 files changed, 48 insertions(+), 24 deletions(-)
>>>    create mode 100644 hw/virtio/vhost-user-stub.c
>>>
>>
>> [..]
>>
>>> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>>> index 415e359e9fc..adc3a4f748a 100644
>>> --- a/hw/virtio/meson.build
>>> +++ b/hw/virtio/meson.build
>>> @@ -43,6 +43,8 @@ if have_vhost
>>>                             if_true: files('vhost-user-input-pci.c'))
>>>        system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
>>>                             if_true: files('vhost-user-spi-pci.c'))
>>
>> Small conflict, when applying to current master, as in master there is now
>> one more entry after CONFIG_VHOST_USER_SPI:
>>
>>     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RTC'],
>>                          if_true: files('vhost-user-rtc-pci.c'))
>>
>> so, "else" should go after this new CONFIG_VHOST_USER_RTC entry.
>>
>>
>> Let me know, if resend needed.
>>
>>> +  else
>>> +    system_virtio_ss.add(files('vhost-user-stub.c'))

[1]

>>>      endif
>>>      if have_vhost_vdpa
>>>        system_virtio_ss.add(files('vhost-vdpa.c'))
>>> @@ -91,6 +93,7 @@ system_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>>>    system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
>>>    stub_ss.add(files('vhost-stub.c'))
>>> +stub_ss.add(files('vhost-user-stub.c'))
>>>    stub_ss.add(files('virtio-stub.c'))
>>>    stub_ss.add(files('virtio-md-stubs.c'))
> 
> 
> I'm confused why would we add vhost-user-stub.c twice at all.
> 

Hmm. Mistake of rebasing through  2fa22ab7fe5a1ca4e0c2  "hw/*: Build stubs once".

So, correct fix is to drop [1].

> 
>>
>>
>> -- 
>> Best regards,
>> Vladimir
> 


-- 
Best regards,
Vladimir

