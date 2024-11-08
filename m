Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D316D5E142
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9JB4-0003eJ-35; Fri, 08 Nov 2024 02:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t9JB1-0003cz-SK; Fri, 08 Nov 2024 02:13:03 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t9JAx-0006wp-2y; Fri, 08 Nov 2024 02:13:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AFCD260BC6;
 Fri,  8 Nov 2024 10:12:51 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7225::1:3] (unknown
 [2a02:6b8:b081:7225::1:3])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nCdbYB1TwOs0-Bufmx2xa; Fri, 08 Nov 2024 10:12:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1731049970;
 bh=WY3Mpq3QU1ts4bH6/H5NP4XFM7VVEdfpYA+SmpBsWoc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=n3A2ceRIowVBTx5IvkqoPQyuvMBYv3QVVW0Av4zrjIojR2xyrHtDOtGOh/4G1w1IQ
 NtI1i+c4hHpBqDJZxsL5i+LAmk/stHIu5/sJe4P7pvuPvxhddHwfTDNJauHz+KE6s0
 ymdkntmsyA4WEtNq2HEwd5gI8tCtPnbIDJ1xhPjo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9a5b8568-0e27-48d4-a5be-c7395597f4f5@yandex-team.ru>
Date: Fri, 8 Nov 2024 10:12:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] vhost-user-blk: live resize additional APIs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, sgarzare@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
References: <20241106111837.115820-1-vsementsov@yandex-team.ru>
 <20241106131649-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20241106131649-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 06.11.24 21:17, Michael S. Tsirkin wrote:
> On Wed, Nov 06, 2024 at 02:18:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> v7: update QAPI version 9.1 -> 9.2
> 
> 
> 
> Not like this. ypur patches are merged, pls post a fix patch on top.
> Thanks!

Ah, missed this. Ok.

> 
>> Vladimir Sementsov-Ogievskiy (3):
>>    qdev-monitor: add option to report GenericError from find_device_state
>>    vhost-user-blk: split vhost_user_blk_sync_config()
>>    qapi: introduce device-sync-config
>>
>>   hw/block/vhost-user-blk.c | 27 ++++++++++++++------
>>   hw/virtio/virtio-pci.c    |  9 +++++++
>>   include/hw/qdev-core.h    |  6 +++++
>>   qapi/qdev.json            | 24 ++++++++++++++++++
>>   system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
>>   5 files changed, 108 insertions(+), 11 deletions(-)
>>
>> -- 
>> 2.34.1
> 

-- 
Best regards,
Vladimir


