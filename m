Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6201C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdr4-0000PB-IP; Thu, 29 Feb 2024 05:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rfdqw-0000OC-JU; Thu, 29 Feb 2024 05:41:27 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rfdqu-0001w6-Io; Thu, 29 Feb 2024 05:41:26 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0DDB047D27;
 Thu, 29 Feb 2024 11:41:22 +0100 (CET)
Message-ID: <195fe8a5-02c2-4cc4-bc41-095f6477b676@proxmox.com>
Date: Thu, 29 Feb 2024 11:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mirror: implement incremental and bitmap modes
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <217803cb-fced-4dce-87f3-9892b2f97dce@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <217803cb-fced-4dce-87f3-9892b2f97dce@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 28.02.24 um 17:24 schrieb Vladimir Sementsov-Ogievskiy:
> On 16.02.24 13:55, Fiona Ebner wrote:
>> Previous discussion from when this was sent upstream [0] (it's been a
>> while). I rebased the patches and re-ordered and squashed like
>> suggested back then [1].
>>
>> This implements two new mirror modes:
>>
>> - bitmap mirror mode with always/on-success/never bitmap sync mode
>> - incremental mirror mode as sugar for bitmap + on-success
>>
>> Use cases:
>> * Possibility to resume a failed mirror later.
>> * Possibility to only mirror deltas to a previously mirrored volume.
>> * Possibility to (efficiently) mirror an drive that was previously
>>    mirrored via some external mechanism (e.g. ZFS replication).
>>
>> We are using the last one in production without any issues since about
>> 4 years now. In particular, like mentioned in [2]:
>>
>>> - create bitmap(s)
>>> - (incrementally) replicate storage volume(s) out of band (using ZFS)
>>> - incrementally drive mirror as part of a live migration of VM
>>> - drop bitmap(s)
> 
> Actually which mode you use, "never", "always" or "conditional"? Or in
> downstream you have different approach?
> 

We are using "conditional", but I think we don't really require any
specific mode, because we drop the bitmaps after mirroring (even in
failure case). Fabian, please correct me if I'm wrong.

> Why am I asking:
> 
> These modes (for backup) were developed prior to
> block-dirty-bitmap-merge command, which allowed to copy bitmaps as you
> want. With that API, we actually don't need all these modes, instead
> it's enough to pass a bitmap, which would be _actually_ used by mirror.
> 
> So, if you need "never" mode, you just copy your bitmap by
> block-dirty-bitmap-add + block-dirty-bitmap-merge, and pass a copy to
> mirror job.
> 
> Or, you pass your bitmap to mirror-job, and have a "always" mode.
> 
> And I don't see, why we need a "conditional" mode, which actually just
> drops away the progress we actually made. (OK, we failed, but why to
> drop the progress of successfully copied clusters?)
> 

I'm not sure actually. Maybe John remembers?

I see, I'll drop the 'bitmap-mode' in the next version if nobody
complains :)

> 
> Using user-given bitmap in the mirror job has also an additional
> advantage of live progress: up to visualization of disk copying by
> visualization of the dirty bitmap contents.
> 

Best Regards,
Fiona


