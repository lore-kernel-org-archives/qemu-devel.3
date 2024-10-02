Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065F4CF3199
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtw1-0003sm-Ny; Wed, 02 Oct 2024 03:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svtvz-0003sQ-87; Wed, 02 Oct 2024 03:38:07 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svtvx-0007xw-5w; Wed, 02 Oct 2024 03:38:07 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1301:0:640:a2b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 000FD60D0B;
 Wed,  2 Oct 2024 10:37:57 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ubVtHh1IaOs0-jAXEo4Lq; Wed, 02 Oct 2024 10:37:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727854677;
 bh=1w0dpZMkK/2oMxpQwcnJddobjN3hpB7OFX4IDmGPTXs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=uIY9kLejUF1NBVIi7EK8whNNUy+G1qvt9MJMX/hcr4uvDI6LKFnA9Jn8QawnU7Ulr
 u4iH8cv9aqTD49IUHikVoSKrDaohFdAPc5tHSsGR+nCnZEfXaDKvyXdWyaKcmsJupu
 ryiaBtuSy39HErZVemZl6g6MkpjcqucLEvLbIcaI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9c0ad262-2b32-4210-98d9-572016c40f3f@yandex-team.ru>
Date: Wed, 2 Oct 2024 10:37:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/5] block/reqlist: allow adding overlapping requests
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org
References: <20240930084325.187606-1-vsementsov@yandex-team.ru>
 <20240930084325.187606-4-vsementsov@yandex-team.ru>
 <ae4dc4d5-eb62-4562-9fc7-f413f193575e@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ae4dc4d5-eb62-4562-9fc7-f413f193575e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 01.10.24 19:28, Michael Tokarev wrote:
> 30.09.2024 11:43, Vladimir Sementsov-Ogievskiy wrote:
>> From: Fiona Ebner <f.ebner@proxmox.com>
>>
>> Allow overlapping request by removing the assert that made it
>> impossible. There are only two callers:
>>
>> 1. block_copy_task_create()
>>
>> It already asserts the very same condition before calling
>> reqlist_init_req().
>>
>> 2. cbw_snapshot_read_lock()
>>
>> There is no need to have read requests be non-overlapping in
>> copy-before-write when used for snapshot-access. In fact, there was no
>> protection against two callers of cbw_snapshot_read_lock() calling
>> reqlist_init_req() with overlapping ranges and this could lead to an
>> assertion failure [1].
>>
>> In particular, with the reproducer script below [0], two
>> cbw_co_snapshot_block_status() callers could race, with the second
>> calling reqlist_init_req() before the first one finishes and removes
>> its conflicting request.
> 
> Hm.  This one applies to 7.2 too (current oldest stable series), with
> the description above matching what the code is doing.
> 
> I picked it up for up to 7.2.  Please let me know if this shouldn't be
> done :)
> 

I don't see any problems) Still, that's not a guarantee that we don't have them. At least, we definitely lack a test for this case.


-- 
Best regards,
Vladimir


