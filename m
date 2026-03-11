Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8AE1061217
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0HSE-0000xU-UG; Wed, 11 Mar 2026 07:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w0HSC-0000wY-2y; Wed, 11 Mar 2026 07:10:16 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w0HSA-0006W8-2t; Wed, 11 Mar 2026 07:10:15 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 27209874A9;
 Wed, 11 Mar 2026 12:10:11 +0100 (CET)
Message-ID: <aa44274e-62ff-4f8b-89b3-9d673a8d23c0@proxmox.com>
Date: Wed, 11 Mar 2026 12:10:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
To: Michael Tokarev <mjt@tls.msk.ru>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260219202446.312493-1-kwolf@redhat.com>
 <27e0c423-7133-4aeb-95ea-50255871921e@tls.msk.ru>
 <6f90bb78-b772-4785-9631-7dd3de83afd5@proxmox.com>
 <669adcd6-28ff-4ced-958e-613a7dedfa2a@tls.msk.ru>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <669adcd6-28ff-4ced-958e-613a7dedfa2a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1773227375703
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 10.03.26 um 7:35 PM schrieb Michael Tokarev:
> On 10.03.2026 19:22, Fiona Ebner wrote:
>> Am 08.03.26 um 9:24 AM schrieb Michael Tokarev:
>>> On 19.02.2026 23:24, Kevin Wolf wrote:...>> While trying to apply
>>> this one to 10.0.x series of qemu, I noticed there
>>> are a few other commits missing in this area.  Namely, these commits are
>>> missing in there:
>>>
>>> 91ba0e1c382bd4 block: move drain outside of bdrv_change_aio_context()
>>> and mark GRAPH_RDLOCK
>>> ffdcd081f52544 block: move drain outside of bdrv_root_attach_child()
>>> 6b89e851fabf78 block: add bdrv_graph_wrlock_drained() convenience
>>> wrapper
>>>
>>> This is just a context, but I wonder if the resulting thing look sane.
>>> https://gitlab.com/mjt0k/qemu/-/
>>> commit/04c53bdbef634f93ac4149a19bf2de2e8d156b2b --
>>> can you take a look please?
>>
>> FWIW, it looks fine to me :) The fix here should be orthogonal to the
>> draining changes from those commits.
> 
> Thank you very much for looking at this one.
> 
> Since you're the one who wrote the above mentioned draining commits,
> how do you think, should these be picked up for stable-10.0?
> (I tried, it gets quite a bit messy there, but it seems like they're
> fixing real issues).

Yes, they do fix real deadlocks, but only in some rare, racy edge cases.
I can imagine that it might get messy, since that patch series
essentially touched all of the block layer and is doing lots of
incremental changes. I honestly do not know if it would be worth the effort.

Best Regards,
Fiona


