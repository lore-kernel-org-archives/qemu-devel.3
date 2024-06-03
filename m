Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6E7C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8wU-0005Bd-O4; Mon, 03 Jun 2024 10:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sE8wT-0005Al-0R; Mon, 03 Jun 2024 10:45:45 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sE8wR-0007tn-6T; Mon, 03 Jun 2024 10:45:44 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DBBB444B9B;
 Mon,  3 Jun 2024 16:45:37 +0200 (CEST)
Message-ID: <ea2c0988-9c29-44d0-828e-aa1d8f011ef1@proxmox.com>
Date: Mon, 3 Jun 2024 16:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/copy-before-write: use uint64_t for timeout in
 nanoseconds
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.weber@proxmox.com
References: <20240429141934.442154-1-f.ebner@proxmox.com>
 <ZlYA9QXVaDSfjxOT@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZlYA9QXVaDSfjxOT@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 28.05.24 um 18:06 schrieb Kevin Wolf:
> Am 29.04.2024 um 16:19 hat Fiona Ebner geschrieben:
>> rather than the uint32_t for which the maximum is slightly more than 4
>> seconds and larger values would overflow. The QAPI interface allows
>> specifying the number of seconds, so only values 0 to 4 are safe right
>> now, other values lead to a much lower timeout than a user expects.
>>
>> The block_copy() call where this is used already takes a uint64_t for
>> the timeout, so no change required there.
>>
>> Fixes: 6db7fd1ca9 ("block/copy-before-write: implement cbw-timeout option")
>> Reported-by: Friedrich Weber <f.weber@proxmox.com>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> 
> Thanks, applied to the block branch.
> 
> But I don't think our job is done yet with this. Increasing the limit is
> good and useful, but even if it's now unlikely to hit with sane values,
> we should still catch integer overflows in cbw_open() and return an
> error on too big values instead of silently wrapping around.

NANOSECONDS_PER_SECOND is 10^9 and the QAPI type for cbw-timeout is
uint32_t, so even with the maximum allowed value, there is no overflow.
Should I still add such a check?

Best Regards,
Fiona


