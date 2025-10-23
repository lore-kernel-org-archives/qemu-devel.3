Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CC3CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqnu-0004ss-Rj; Thu, 23 Oct 2025 04:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBqns-0004pu-D9; Thu, 23 Oct 2025 04:36:12 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBqnn-000157-Ml; Thu, 23 Oct 2025 04:36:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C9056807FA;
 Thu, 23 Oct 2025 11:35:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:538::1:38] (unknown
 [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vZToGQ0IpqM0-Y3SIltwJ; Thu, 23 Oct 2025 11:35:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761208559;
 bh=77VlgxDUuQYRJgHOSQlvMOrp/M4gafk8/tJz7LlJgcE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bFLfVM15z9dxo2boe3LO+pGwh1z8F+a32lkvgQyPeJf7SfFuJQdDFhkiVe+e2IG8k
 mmp9QCxPVqaQvGeZ6uoZLq+mTBmDuQyMt2esHB8njkc1csoIDjLyOiEc7NYqMowUV8
 AzThv8D/qdC5ZUfYzF1GnMdDaL/5ApvLkacM3bww=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4f334cb8-31c8-4e6a-9075-ede5a4b2b1f5@yandex-team.ru>
Date: Thu, 23 Oct 2025 11:35:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] stream: Remove bdrv from job in .clean()
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20251021-fix-3149-v2-1-5ffbe701e964@canonical.com>
 <01ae19a1-61e5-499b-bb6c-0cc480f220fb@yandex-team.ru>
 <CADzzt1DQbdA23W8dKTf9V0va7b6DhtWncQCbCGeevNuaGkTh0Q@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CADzzt1DQbdA23W8dKTf9V0va7b6DhtWncQCbCGeevNuaGkTh0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23.10.25 00:34, Wesley Hershberger wrote:
> On Wed, Oct 22, 2025 at 1:57 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> If my assumptions match, they should be mentioned in commit message.
> 
> This is my understanding of the problem. I'll try to be more clear in
> the next submission.
> 
>> Ok, so, the commit make a work-around: avoid listing the invalid node
>> in query-named-block-nodes by removing it earlier (after the commit,
>> the node will be removed on final bdrv_unref() in bdrv_cor_filter_drop().
>>
>> This doesn't seem safe: what if someone else have another reference on
>> the filter node? Or will have in future? The bug will raise again.
>>
>> More correct would be fix the core problem: bdrv_refresh_filename()
>> crashes for detached implicit filters.
>>
>> Could you check, will something like this fix the reproducer:
> 
> I tested this patch last week and again today:
> 
> diff --git a/block.c b/block.c
> index 8848e9a7ed..a0246a65a5 100644
> --- a/block.c
> +++ b/block.c
> @@ -8067,6 +8067,12 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>       }
> 
>       if (bs->implicit) {
> +        /* Avoid races where an implicit node is removed from the graph but
> +         * not yet unrefed/closed */
> +        if (QLIST_EMPTY(&bs->children)) {
> +            return;
> +        }
> +
>           /* For implicit nodes, just copy everything from the single child */
>           child = QLIST_FIRST(&bs->children);
>           assert(QLIST_NEXT(child, next) == NULL);
> 
> This resolves the first segfault, but it produces another one in
> bdrv_co_get_allocated_file_size. Here's the trace from
> query-named-block-nodes:
> 
> qmp_query_named_block_nodes
> bdrv_named_nodes_list
> bdrv_block_device_info (block/qapi.c L44)
> bdrv_query_image_info (block/qapi.c L336)
> bdrv_do_query_node_info (block/qapi.c L238)
> bdrv_get_allocated_file_size (include/block/block-io.h L90)
> bdrv_co_get_allocated_file_size (block.c L6011) (called through
> co_wrapper_bdrv_lock)

I think, in bdrv_co_get_allocated_file_size() we go to

     } else if (drv->is_filter) {
         /* Filter drivers default to the size of their filtered child */
         return bdrv_co_get_allocated_file_size(bdrv_filter_bs(bs));

branch, bdrv_filter_bs(bs) returns NULL for detached filter, and then
we crash on trying to dereference NULL pointer in

int64_t coroutine_fn bdrv_co_get_allocated_file_size(BlockDriverState *bs)
{
     BlockDriver *drv = bs->drv;

.

So, something like
--- a/block.c
+++ b/block.c
@@ -6024,6 +6024,12 @@ int64_t coroutine_fn bdrv_co_get_allocated_file_size(BlockDriverState *bs)
           */
          return -ENOTSUP;
      } else if (drv->is_filter) {
+        BlockDriverState *filtered = bdrv_filter_bs(bs);
+
+        if (!filtered) {
+            return -ENOMEDIUM;
+        }
+
          /* Filter drivers default to the size of their filtered child */
          return bdrv_co_get_allocated_file_size(bdrv_filter_bs(bs));
      } else {

should help.

> 
> And the bt from gdb:
> #0  bdrv_co_get_allocated_file_size (bs=<optimized out>)
>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2+test8/b/qemu/block.c:6018
> #1  0x0000631d078522be in bdrv_co_get_allocated_file_size_entry
>      (opaque=0x7ffd375c5dd0) at block/block-gen.c:288
> #2  0x0000631d07929ec2 in coroutine_trampoline
>      (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:175
> #3  0x0000772778862f60 in ?? ()
>      at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66 from
> target:/lib/x86_64-linux-gnu/libc.so.6
> #4  0x00007ffd375c5ae0 in ?? ()
> #5  0x0000000000000000 in ?? ()
> 
> I need to spend a little more time getting this reproduced properly
> using a debug build; it's not clear to me (yet) what is actually
> causing the segfault here. I'll work on putting together another patch
> to fix this too.
> 
>> Other ideas:
>>
>> Maybe, when removing the filter child, we should set its bs->drv to NULL,
>> as filter node becomes nonfunctional.
> 
> Based on a quick look through of the code, this would cause
> query-named-block-nodes to either return nothing or fail outright; it doesn't
> seem like the right solution.
> 
>> Or, set bs->implicit to false, which will activate generic path in
>> bdrv_refresh_filename (I'm not sure it will work good for the detached
>> filter node)
> 
> This will run into the same second segfault as above; it also feels like
> a workaround instead of a real fix :/
> 
>> Hmm, I also think that mentioned
>> bdc4c4c5e372756a "backup: Remove nodes from job in .clean()" is
>> at least incomplete.
>>
>> In block-layer, having reference counters in bs, we can't rely on
>> "hmm, let's just drop this one reference, and hope, that after next
>> function, the node will be completely removed".
>>
>> So, we either need a guarantee, that filter node is completely removed
>> when we detach it (OK, detaching should just fail if it doesn't lead
>> to complete removal), or we should be prepared to existing detached
>> filters, and handle them correctly.
> 
> Thanks, this is helpful. I originally wrote off this approach due to the second
> segfault but I'll revisit it. I think I'll submit a new series instead
> of a v3 of this
> patch unless you'd prefer a v3.
> 

I think, if it feasible to fix the problem in generic code, it's better than
work-around in specific job-type.

On the other hand, we already have similar block_job_remove_all_bdrv() calls
in backup and mirror, and it works well. So we can proceed with this patch too,
just add a comment, that we are avoiding invalid block graph state by having
detached filter, which leads to crashes, because generic code is unprepared
to detached filters.

-- 
Best regards,
Vladimir

