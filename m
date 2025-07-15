Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E2AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgFb-0001Ym-7K; Tue, 15 Jul 2025 10:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ubfe5-0004TV-Jc; Tue, 15 Jul 2025 09:24:33 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ubfe3-0000IV-6e; Tue, 15 Jul 2025 09:24:33 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C5D154086E;
 Tue, 15 Jul 2025 15:24:18 +0200 (CEST)
Message-ID: <0fb6eb67-2ebb-4042-a5d4-8c679baed4ac@proxmox.com>
Date: Tue, 15 Jul 2025 15:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/48] block: do not drain while holding the graph lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
References: <20250530151125.955508-1-f.ebner@proxmox.com>
 <aGQX6sjaLq9-UjHc@redhat.com> <aHUJd73iuk5b3zRC@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aHUJd73iuk5b3zRC@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 14.07.25 um 15:43 schrieb Kevin Wolf:
> Am 01.07.2025 um 19:16 hat Kevin Wolf geschrieben:
>> Am 30.05.2025 um 17:10 hat Fiona Ebner geschrieben:
>>> This series is an attempt to fix a deadlock issue reported by Andrey
>>> here [3].
>>>
>>> bdrv_drained_begin() polls and is not allowed to be called with the
>>> block graph lock held. Mark the function as GRAPH_UNLOCKED.
>>>
>>> This alone does not catch the issue reported by Andrey, because there
>>> is a bdrv_graph_rdunlock_main_loop() before bdrv_drained_begin() in
>>> the function bdrv_change_aio_context(). That unlock is of course
>>> ineffective if the exclusive lock is held, but it prevents TSA from
>>> finding the issue.
>>>
>>> Thus the bdrv_drained_begin() call from inside
>>> bdrv_change_aio_context() needs to be moved up the call stack before
>>> acquiring the locks. This is the bulk of the series.
>>>
>>> Granular draining is not trivially possible, because many of the
>>> affected functions can recursively call themselves.
>>>
>>> In place where bdrv_drained_begin() calls were removed, assertions
>>> are added, checking the quiesced_counter to ensure that the nodes
>>> already got drained further up in the call stack.
>>
>> I finished review for this series. I had some minor comments on patches
>> 24, 27 and 41. Once we agree what to do there, I can probably just make
>> any changes myself while applying.
> 
> I don't see any objections, so I just applied this and made all the
> changes I had suggested.

Sorry, for not responding anymore. I was on vacation for a while and
will still be busy with other stuff in the coming weeks. The changes you
suggested sound good to me, thanks!

Best Regards,
Fiona


