Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F3BFD8FC9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdAI-0003jb-Po; Thu, 26 Feb 2026 10:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vvdAG-0003io-1V; Thu, 26 Feb 2026 10:20:32 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vvdAD-0004C2-Rw; Thu, 26 Feb 2026 10:20:31 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 614FBA60CE;
 Thu, 26 Feb 2026 16:20:18 +0100 (CET)
Message-ID: <7f1754b9-61a7-4413-9a97-1f47958da3e4@proxmox.com>
Date: Thu, 26 Feb 2026 16:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/block: add 'throttle-group' property
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com
References: <20260116143946.1031006-1-f.ebner@proxmox.com>
 <aZ23DELMG6CycbQ8@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aZ23DELMG6CycbQ8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1772119199424
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

Am 24.02.26 um 3:34 PM schrieb Kevin Wolf:
> Am 16.01.2026 um 15:39 hat Fiona Ebner geschrieben:
>> With '-drive', it is possible to specify the throttle configuration
>> directly on the commandline. Add the possibility to do the same when
>> using the modern way with '-blockdev' and a front-end device. Using a
>> throttle filter block node is not always an option: in particular, the
>> mirror block job operates on a root block node and it might be desired
>> to throttle only the guest IO, but not to the block job.
> 
> Hm, is there still a reason why we require a root node for the source?

I'm not sure if the restriction could be lifted. But AFAICS, that
doesn't help in my case with a throttle node as the root node:

Say I'm mirroring the node below throttle and the job is ready to be
completed. Further, assume that requests pile up for the root node,
while the node below is mostly idle, which can easily happen with low
throttle limits:

At some moment, there might be no IO in-flight for the node below
throttle and thus the mirror can complete, while all the in-flight
requests for the throttle node are currently being intercepted by the
throttle group and waiting for the timer to wake them. Because, the call
to bdrv_inc_in_flight() for the node below throttle only happens after
the intercepted requests are woken. Mirror and the node below do not
know about the parent's in flight requests. Is this interpretation correct?

There are scenarios where we finish the job via block-job-cancel after
freezing the guest filesystem to ensure consistency, so having
intercepted requests as described above would mess it up.

>> There already is a 'block_set_io_throttle' QMP command, but it's nicer
>> to be able to do it via the commandline too.
>>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> ---
>>
>> Hope I didn't miss a way to do this already.
>>
>> Should changing via qom-set be supported? Currently, an attempt fails:
>>> Error: Attempt to set property 'throttle-group' on device 'scsi0'
>>> (type 'scsi-hd') after it was realized
>> but there already is the 'block_set_io_throttle' QMP command.
> 
> It would be nice, but I don't think runtime writable properties are used
> much in devices because I believe this would have to be done with plain
> QOM properties, i.e. outside of qdev.
> 
> Though if it's actually easy, we could consider implementing it.
> 
>>  hw/block/block.c           | 15 +++++++++++++++
>>  include/hw/block/block.h   |  4 +++-
>>  tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 56 insertions(+), 1 deletion(-)
> 
> Looks good to me, though maybe we could also use a qemu-iotests case
> that actually tries to set the property instead of only updating the
> output everywhere for having no throttle group.

Ack, I'll send a v2 with a test.

Best Regards,
Fiona


