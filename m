Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRHc-0003Mc-Hc; Thu, 01 Aug 2024 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZRHa-0003L9-VF; Thu, 01 Aug 2024 04:35:35 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZRHX-0002Ao-Ss; Thu, 01 Aug 2024 04:35:33 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:25c3:0:640:236:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1F28661073;
 Thu,  1 Aug 2024 11:35:22 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b657::1:21] (unknown
 [2a02:6b8:b081:b657::1:21])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JZS4Q11Vr8c0-2IxUAXJw; Thu, 01 Aug 2024 11:35:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722501321;
 bh=4CqkpUTAEsThD9CEL3L1dde3/kT8y+R+i0AhPlJm5nM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=PcHeMXidxx3ExrCz20aXUUIywa3ezWSKfLHO90X25WXYK2Er5AThafpyD/QXfDybX
 x0asbTfn6MDSzUVL/yhnMOkufjFxfg/ctN8wX8N9s71DLPDrZDEgSxofLMddgExMLJ
 1WCDdNj2BLS2TXndaZH9rzLh3CbkvCV16UuqXrks=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <96c93d33-ac30-4c0d-97a4-4696825d436d@yandex-team.ru>
Date: Thu, 1 Aug 2024 11:35:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 yc-core@yandex-team.ru
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <CAMDpr=cyULZmtaodbmET_NEfYMhfXT2ndQ8S8vjDrapG6PUsRg@mail.gmail.com>
 <20240701165515-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240701165515-mutt-send-email-mst@kernel.org>
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

On 01.07.24 23:55, Michael S. Tsirkin wrote:
> On Mon, Jul 01, 2024 at 08:42:39AM -0400, Raphael Norwitz wrote:
>> I have no issues with these APIs, but I'm not a QMP expert so others
>> should review those bits.
>>
>> For the vhost-user-blk code:
>>
>> Acked-by: Raphael Norwitz <raphael@enfabrica.net>
> 
> Could the relevant bits get ack from qapi maintainers please?
> 

We go them. Could you queue the patches please?

> 
> 
>> On Tue, Jun 25, 2024 at 8:19 AM Vladimir Sementsov-Ogievskiy
>> <vsementsov@yandex-team.ru> wrote:
>>>
>>> v5:
>>> 03: drop extra check on is is runstate running
>>>
>>>
>>> Vladimir Sementsov-Ogievskiy (3):
>>>    qdev-monitor: add option to report GenericError from find_device_state
>>>    vhost-user-blk: split vhost_user_blk_sync_config()
>>>    qapi: introduce device-sync-config
>>>
>>>   hw/block/vhost-user-blk.c | 27 ++++++++++++++------
>>>   hw/virtio/virtio-pci.c    |  9 +++++++
>>>   include/hw/qdev-core.h    |  3 +++
>>>   qapi/qdev.json            | 24 ++++++++++++++++++
>>>   system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
>>>   5 files changed, 105 insertions(+), 11 deletions(-)
>>>
>>> --
>>> 2.34.1
>>>
> 

-- 
Best regards,
Vladimir


