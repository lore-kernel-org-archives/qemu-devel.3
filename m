Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1B7CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDT9A-0003Kv-0a; Mon, 27 Oct 2025 15:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDT91-0003JA-Gi; Mon, 27 Oct 2025 15:44:44 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDT8l-0000dt-DF; Mon, 27 Oct 2025 15:44:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8DDDBC071B;
 Mon, 27 Oct 2025 22:44:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5c::1:11] (unknown
 [2a02:6bf:8080:c5c::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DiiZbb1LrW20-6cgAwsRs; Mon, 27 Oct 2025 22:44:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761594254;
 bh=wrJD/5gQxDNyQiAu1Na2XfSb55OpyeQHnZBu3XNtGq8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iDFpTlXb7Yz/TtrCa1auYlS8trWD7JFiLAA5Bm7JbQg3KqRd8rL2MN7n7q2ZLGVOR
 4UnOcvE26ll3+tOKVqOrCJY/xSVErce89DhYYT9yhb5jUQ4o2NrM5EDRMlYfT1QbX0
 JE+EKLK7o+A8bRQiQd5qUXu6ToxG/sg72XjoH2hM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a6a09fdf-e5a6-4c8e-b232-223bbbd53509@yandex-team.ru>
Date: Mon, 27 Oct 2025 22:44:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Add missing null checks during
 query-named-block-nodes
To: Kevin Wolf <kwolf@redhat.com>,
 Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
 <aP9BhBEUSuM0ougc@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aP9BhBEUSuM0ougc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 27.10.25 12:55, Kevin Wolf wrote:
> Am 24.10.2025 um 20:07 hat Wesley Hershberger geschrieben:
>> Some operations insert an implicit node above the top node in the block
>> graph (e.g. block-stream or blockdev-backup). The implicit node is
>> removed when the operation finishes. If QMP query-named-block-nodes is
>> called while the operation is removing the implicit node, it may observe
>> a node with no children, causing a segfault.
> 
> How can a QMP command run in the middle of removing a node? Is this the
> real bug?
> 
> You say block-stream is affected, so let's look at stream.c. The
> interesting part here is bdrv_cor_filter_drop(s->cor_filter_bs).
> 
> bdrv_drop_filter() calls bdrv_drained_begin() and bdrv_graph_wrlock(),
> which can run arbitrary callbacks, but not QMP commands. It's too eary
> anyway, the filter is still in the graph at this point.
> 
> Between bdrv_replace_node_common(), which removes the node from its
> parent, and bdrv_unref(cor_filter_bs), I don't see any place that could
> run a QMP command.
> 
> Does cor_filter_bs have a refcount > 1 before running stream_prepare()
> or stream_clean()?
> 
> Aha, your previous commit message [1] is actually clearer on this:
> 
>      The cor_filter_bs was added to the blockjob as the main BDS (by
>      passing it to block_job_create), so bdrv_cor_filter_drop doesn't
>      actually remove it from global_bdrv_states.
> 
> [1] https://patchew.org/QEMU/20251021-fix-3149-v2-1-5ffbe701e964@canonical.com/
> 
> So we _are_ creating a state in which cor_filter_bs still exists, but
> doesn't have a child any more. Which is rather untypical for a filter
> (in fact, it's against the definition of a filter). And your two
> different patches address this from two different angles:
> 
> 1. Don't even let this situation arise. We need to make sure that
>     cor_filter_bs never exists without a child - or at least, that it's
>     happening only for a short time while we know that no other code is
>     running. This is what your previous patch attempted.
> 
> 2. Make sure that everything else in QEMU can deal with a filter node
>     that doesn't have a child. This is what this one does.
> 
> Hanna, do you have an opinion on these two options?
> 
> I'm not sure myself, but I see that both aren't mutually exclusive. I
> would say that having 1. is certainly a good thing that makes everything
> else simpler and less likely to fail, so that's the one I would take in
> any case. I'm not completely sure if that means v2 of "stream: Remove
> bdrv from job in .clean()", or if another version that just removes this
> one node from the job would be better. We do have bdrv_drain_all_begin()
> later in stream_prepare(), which must be assumed to run any sorts of
> callbacks, so removing the node in stream_clean() might be too late in
> some cases.
> 
> And then we could think of having this patch for 2., probably split
> into two patches - though what tells us that this is complete? I would
> be surprised if there aren't more places in QEMU that assume that a
> filter node has exactly one child. So I think in this case we would have
> to audit the rest of the block layer to make sure we caught all of them.
> 
> Hm, I think I am relatively sure now actually that 2. is a bad idea...
> 
> So what if we don't actually do 2., but then add an assertion to
> bdrv_cor_filter_drop() that verifies that the refcount is 1 before
> dropping the filter node? This should help us make sure that the patch
> for 1. actually does what it's supposed to do.
> 
>> This is hypothesized to only affect the block-stream operation as other
>> operations use the workaround bdc4c4c5e372756a5ba3fb3a61e585b02f0dd7f4
>> or do not detach their children during cleanup (see
>> 3108a15cf09865456d499b08fe14e3dbec4ccbb3).
>>
>> This backtrace was observed in #3149 on a relatively recent build. The
>> bs passed to bdrv_refresh_filename is the cor_filter_bs from the
>> block-stream operation; bs->implicit was "true".
>>
>> 0  bdrv_refresh_filename (bs=0x5efed72f8350)
>>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
>> 1  0x00005efea73cf9dc in bdrv_block_device_info
>>      (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
>>      at block/qapi.c:62
>> 2  0x00005efea7391ed3 in bdrv_named_nodes_list
>>      (flat=<optimized out>, errp=0x7ffeb829ebd8)
>>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
>> 3  0x00005efea7471993 in qmp_query_named_block_nodes
>>      (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
>>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
>> 4  qmp_marshal_query_named_block_nodes
>>      (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
>>      at qapi/qapi-commands-block-core.c:553
>> 5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
>>      at qapi/qmp-dispatch.c:128
>> 6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
>>      at util/async.c:219
>> ...
> 
> This is one change...
> 
>> The get_allocated_file_size change resolves a second segfault after the
>> first was resolved. Here, bdrv_filter_bs returns NULL as the
>> bs (cor_filter_bs) has no children:
>>
>> 0  bdrv_co_get_allocated_file_size (bs=<optimized out>)
>>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2+test8/b/qemu/block.c:6018
>> 1  0x0000631d078522be in bdrv_co_get_allocated_file_size_entry
>>      (opaque=0x7ffd375c5dd0) at block/block-gen.c:288
>> 2  0x0000631d07929ec2 in coroutine_trampoline
>>      (i0=<optimized out>, i1=<optimized out>)
>>      at util/coroutine-ucontext.c:175
>> ...
> 
> ...and this is logically a separate one.
> 
> So if we were to go down this route, I think we would have a full patch
> serie to make filter nodes without a child safe. These two parts would
> be separate patches, and I'm almost sure that we would get more patches
> for the series to make it fully safe everywhere.
> 
> As I said above, I think this is too hard to get correct to be a good
> idea, though.
> 
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
>> Buglink: https://bugs.launchpad.net/bugs/2126951
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
>> ---
>> As discussed in the previous thread:
>> https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg05458.html
>>
>> This resolves the issue with my reproducer.
>>
>> make check-block passes locally.
>>
>> Please let me know if any adjustments to the patch are needed.
>>
>> Thanks for the quick & helpful reviews!
> 
> Sorry, Wesley, that this turns out to be a bit more complicated! We'll
> probably need some further discussion before we can know if or which
> adjustments to the patch are needed.
> 
> Before I send this, I just had another thought: Why does copy-on-read
> even drop the child in bdrv_cor_filter_drop()? Wouldn't the normal
> mode of operation be that for a short time you have both the cor node
> and its parent point to the same child node, and that would just work?
> I see commit messages about conflicting node permissions (3108a15cf09 by
> Vladimir), but I don't understand this. A filter without parents
> shouldn't try to take any permissions.
> 
> So another option for never letting the situation arise would be that
> cor_filter_bs just keeps its child until it's really deleted.
> 
> Vladimir, do you remember what the specific problem was?
> 

Hmm.. That's not simple to restore it now)Seems it should be about block-job
blk, which is the conflicting parent. But for backup, we've already had
this block_job_remove_all_bdrv() even at time of 3108a15cf09. Interesting...

The next commit after 3108a15cf09 is:

b75d64b3290136 "block/backup-top: drop .active"

and it introduces use of new interface, and drop old hack:

@@ -283,16 +245,9 @@ void bdrv_backup_top_drop(BlockDriverState *bs)
  {
      BDRVBackupTopState *s = bs->opaque;

-    bdrv_drained_begin(bs);
+    bdrv_drop_filter(bs, &error_abort);

      block_copy_state_free(s->bcs);

-    s->active = false;
-    bdrv_child_refresh_perms(bs, bs->backing, &error_abort);
-    bdrv_replace_node(bs, bs->backing->bs, &error_abort);
-    bdrv_set_backing_hd(bs, NULL, &error_abort);
-
-    bdrv_drained_end(bs);
-
      bdrv_unref(bs);
  }


Good. So, I go to b75d64b3290136 and do:

--- a/block.c
+++ b/block.c
@@ -5182,7 +5182,7 @@ int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,

  int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
  {
-    return bdrv_replace_node_common(bs, bdrv_filter_or_cow_bs(bs), true, true,
+    return bdrv_replace_node_common(bs, bdrv_filter_or_cow_bs(bs), true, false,
                                      errp);
  }


This breaks most of iotests found by "git grep backup", it breaks:

    028 055 056 124 129 185 222 256 257 264 281 304

at least, output of 185 is readable:

+QEMU_PROG: Conflicts with use by #block1177 as 'backing', which does not allow 'write' on #block151

and looking at backup_top_child_perm(), it obvious:

     } else {
         /* Source child */
         bdrv_default_perms(bs, c, role, reopen_queue,
                            perm, shared, nperm, nshared);

         if (perm & BLK_PERM_WRITE) {
             *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
         }
         *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
     }

We've unshared write-perm unconditionally, not caring about parents.


Later in


3860c0201924d "block/copy-before-write: relax permission requirements when no parents"

we move to current behavior: don't unshare write, when no parents. And the commit say:


     Currently, filter unshares write permission unconditionally on source
     node. It's good, but it will not allow to do blockdev-add. So, let's
     relax restrictions when filter doesn't have any parent.


Was it really good or not? At that moment, I thought it was good. Now I'm not so sure..
Should filter guarantee, that some other parents will not pass it by? Or the filter should
care only to block writes, which explicitly go through it? The latter seems
maybe less safe, but actually, more native for "filters".

Anyway, starting from 3860c0201924d, permission restrictions become less aggressive, let's
check, staying at 3860c0201924d, and with same hack to bdrv_drop_filter:

check -qcow2 028 055 056 124 129 141 185 219 222 256 257 264 281 283 294 304

- only 257 fails. (why?)

Double check with 3860c0201924d^: again, almost all fails:

Failures: 028 055 056 124 129 185 222 256 257 264 281 304



And same with current master: 257 fails, if hack bdrv_drop_filter() to pass detach_subchain=false to bdrv_replace_node_common().


So to summarize: most probably, 3108a15cf09 was needed because I wanted copy-before-write
filter (backup-top in that past time) to unshare WRITE permission unconditionally, to be
extremely safe. Later, I had to drop this restriction anyway, but bdrv_drop_filter() was
kept as is (I doubt, that there were some specific reason, most probably I just didn't
think of it. And I considered 3860c0201924d as work-around, not as final good solution).


So, reverting 3108a15cf09 now is quite possible, we just will have to fix 257.


-- 
Best regards,
Vladimir

