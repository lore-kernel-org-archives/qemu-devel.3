Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C650C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 12:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rffp5-0004Kq-Fh; Thu, 29 Feb 2024 07:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rffoy-0004KI-W7; Thu, 29 Feb 2024 07:47:33 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rffow-0004fF-Tq; Thu, 29 Feb 2024 07:47:32 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8B89B47F8D;
 Thu, 29 Feb 2024 13:47:27 +0100 (CET)
Message-ID: <0a3b3d62-5374-4219-a5fa-f087f93d85d8@proxmox.com>
Date: Thu, 29 Feb 2024 13:47:26 +0100
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
 <cf086f76-1f47-4f45-aba5-fc021ad090da@yandex-team.ru>
 <8a84f7f2-6765-49f6-9469-908bcfdc7437@yandex-team.ru>
 <5ded1c2d-5aa8-440a-9f01-a3529e07abf0@proxmox.com>
 <b737130a-2a01-4b1c-945a-b0d574345d0e@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <b737130a-2a01-4b1c-945a-b0d574345d0e@yandex-team.ru>
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

Am 29.02.24 um 12:48 schrieb Vladimir Sementsov-Ogievskiy:
> On 29.02.24 13:11, Fiona Ebner wrote:
>>
>> The iotest creates a new target image for each incremental sync which
>> only records the diff relative to the previous mirror and those diff
>> images are later rebased onto each other to get the full picture.
>>
>> Thus, it can be that a previous mirror job (not just background process
>> or previous write) already copied a cluster, and in particular, copied
>> it to a different target!
> 
> Aha understand.
> 
> For simplicity, let's consider case, when source "cluster size" = "job
> cluster size" = "bitmap granularity" = "target cluster size".
> 
> Which types of clusters we should consider, when we want to handle guest
> write?
> 
> 1. Clusters, that should be copied by background process
> 
> These are dirty clusters from user-given bitmap, or if we do a full-disk
> mirror, all clusters, not yet copied by background process.
> 
> For such clusters we simply ignore the unaligned write. We can even
> ignore the aligned write too: less disturbing the guest by delays.
> 

Since do_sync_target_write() currently doesn't ignore aligned writes, I
wouldn't change it. Of course they can count towards the "done_bitmap"
you propose below.

> 2. Clusters, already copied by background process during this mirror job
> and not dirtied by guest since this time.
> 
> For such clusters we are safe to do unaligned write, as target cluster
> must be allocated.
> 

Right.

> 3. Clusters, not marked initially by dirty bitmap.
> 
> What to do with them? We can't do unaligned write. I see two variants:
> 
> - do additional read from source, to fill the whole cluster, which seems
> a bit too heavy
> 

Yes, I'd rather only do that as a last resort.

> - just mark the cluster as dirty for background job. So we behave like
> in "background" mode. But why not? The maximum count of such "hacks" is
> limited to number of "clear" clusters at start of mirror job, which
> means that we don't seriously affect the convergence. Mirror is
> guaranteed to converge anyway. And the whole sense of "write-blocking"
> mode is to have a guaranteed convergence. What do you think?
> 

It could lead to a lot of flips between job->actively_synced == true and
== false. AFAIU, currently, we only switch back from true to false when
an error happens. While I don't see a concrete issue with it, at least
it might be unexpected to users, so it better be documented.

I'll try going with this approach, thanks!

> 
> ----
> 
> Of course, we can't distinguish 3 types by on dirty bitmap, so we need
> the second one. For example "done_bitmap", where we can mark clusters
> that were successfully copied. That would be a kind of block-status of
> target image. But using bitmap is a lot better than querying
> block-status from target.

Best Regards,
Fiona


