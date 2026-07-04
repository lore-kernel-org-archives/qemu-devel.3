Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A7C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfwVY-00032d-9q; Sat, 04 Jul 2026 05:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wfwVT-00030y-8A; Sat, 04 Jul 2026 05:17:51 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wfwVQ-0003Lh-J8; Sat, 04 Jul 2026 05:17:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id AF094807D2;
 Sat, 04 Jul 2026 12:17:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a44::1:29] (unknown
 [2a02:6bf:8080:a44::1:29])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id eHeGdx0Z04Y0-VLtTK2Fu; Sat, 04 Jul 2026 12:17:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783156661;
 bh=FFEOLK8TI95Wzrmk48bdx1vTtA8ItDNZ9eqLVKY0vH0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Y7AdXPKNu3F17lUq6fYwH0uYPPrrG5o22dmgIKx0HK8YaB4EpCZGgln5+0YYuqBF9
 P5EuvL1OEnOY5J/IMmxshoTuFSGI1vC6lmW4fLFvaD5G/ZUWxM1QqgjOZsMbPPbjbI
 BLnOAPZ1HWixtZdMDJ3KmEwgd0vxGPhb65I+vANI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <573d11f7-71e1-4f31-bbfb-884778961e14@yandex-team.ru>
Date: Sat, 4 Jul 2026 12:17:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user-blk: add seg-max-adjust flag
To: Raphael Norwitz <rnorwitz@nvidia.com>,
 Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260401230548.136541-1-heifetz@yandex-team.com>
 <82d9d2d5-7102-4b34-ad7d-df0e8f77b509@nvidia.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <82d9d2d5-7102-4b34-ad7d-df0e8f77b509@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 15.04.26 18:24, Raphael Norwitz wrote:
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index c151e836770..23f910d9fe3 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -65,6 +65,11 @@ static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>       /* Our num_queues overrides the device backend */
>>       virtio_stw_p(vdev, &s->blkcfg.num_queues, s->num_queues);
>>
>> +    if (s->seg_max_adjust) {
> 
> NIT: declaration at the top of the function

Hmm, no, accordingly to docs/dev/style.rst, "at the beginning of blocks",
so, it's OK to declare it at top of if-block, it's often used in the code,
look at output of `git grep -B 3 '^        int '` for example.

> 
>> +        uint32_t seg_max = MIN(s->blkcfg.seg_max, s->queue_size - 2);
>> +        virtio_stl_p(vdev, &s->blkcfg.seg_max, seg_max);
>> +    } 


-- 
Best regards,
Vladimir

