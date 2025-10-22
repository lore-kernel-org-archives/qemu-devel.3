Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320F9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSn1-0000rA-64; Wed, 22 Oct 2025 02:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBSmx-0000hT-T1; Wed, 22 Oct 2025 02:57:39 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBSmr-00084T-KE; Wed, 22 Oct 2025 02:57:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 88A5F80B6D;
 Wed, 22 Oct 2025 09:57:28 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4a::1:14] (unknown
 [2a02:6bf:8080:a4a::1:14])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RvQZ8F0Io4Y0-XxtiYiXl; Wed, 22 Oct 2025 09:57:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761116247;
 bh=Z3Vz9E4I3gBty9emxN8AARWTH0kIbIwJFXWWdxB48ew=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ExWR+0pUlrw0KhEAFkJgVYHdD3gTZmErlQTjtV6Rz1qWRTlKLJF0ua2GvhpZsFtZ9
 mniIdG465PmxmvjSD8oCHqQdEuEWbii9Qkxx2aWWwrPuktJGl3U7ZWuA9oR40HeeKO
 d7Qb16FfG4CdHNPggvfmEUwwFNzpu8WiCjgweIxs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <01ae19a1-61e5-499b-bb6c-0cc480f220fb@yandex-team.ru>
Date: Wed, 22 Oct 2025 09:57:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] stream: Remove bdrv from job in .clean()
To: Wesley Hershberger <wesley.hershberger@canonical.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20251021-fix-3149-v2-1-5ffbe701e964@canonical.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251021-fix-3149-v2-1-5ffbe701e964@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21.10.25 21:28, Wesley Hershberger wrote:
> This is similar to bdc4c4c5e372756a5ba3fb3a61e585b02f0dd7f4
> (qmp blockdev-backup). The cor_filter_bs was added to the blockjob as
> the main BDS (by passing it to block_job_create), so
> bdrv_cor_filter_drop doesn't actually remove it from global_bdrv_states.
> 
> This can cause races with qmp query-named-block nodes as described in

I'm not against the patch itself..

But I still don't understand, how it fixes the bug.

Why segfault happens, which pointer is invalid? And why?


>   #3149. Stacktrace:
> 
> 0  bdrv_refresh_filename (bs=0x5efed72f8350)

Aha, I start to understand.

1. assume that's exactly the cor_filter_bs (is it? it should be noted here if so)

2. As we know, at this time, it doesn't have any children.

3. But, it (most probably) has bs->implicit = true, as we do set it for cor_filter_bs,
when filter node-name is not given in job parameters. Is it the case?

And finally, in bdrv_refresh_filename(), we have

     if (bs->implicit) {
         /* For implicit nodes, just copy everything from the single child */
         child = QLIST_FIRST(&bs->children);
         assert(QLIST_NEXT(child, next) == NULL);

         pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
                 child->bs->exact_filename);

which, of course, will not work when we don't have any children.


If my assumptions match, they should be mentioned in commit message.


---

Ok, so, the commit make a work-around: avoid listing the invalid node
in query-named-block-nodes by removing it earlier (after the commit,
the node will be removed on final bdrv_unref() in bdrv_cor_filter_drop().

This doesn't seem safe: what if someone else have another reference on
the filter node? Or will have in future? The bug will raise again.

More correct would be fix the core problem: bdrv_refresh_filename()
crashes for detached implicit filters.

Could you check, will something like this fix the reproducer:


diff --git a/block.c b/block.c
index 8848e9a7ed..dfd9090cfc 100644
--- a/block.c
+++ b/block.c
@@ -8069,6 +8069,17 @@ void bdrv_refresh_filename(BlockDriverState *bs)
      if (bs->implicit) {
          /* For implicit nodes, just copy everything from the single child */
          child = QLIST_FIRST(&bs->children);
+
+        if (!child) {
+            /*
+             * The child is detached, which means that filter node
+             * is in process of removing. Keep filename and full_open_options
+             * unchanged, let query-named-block-nodes to show them,
+             * if it called during block-job clean-up process.
+             */
+            return;
+        }
+
          assert(QLIST_NEXT(child, next) == NULL);

          pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),


---

Other ideas:

Maybe, when removing the filter child, we should set its bs->drv to NULL,
as filter node becomes nonfunctional.

Or, set bs->implicit to false, which will activate generic path in
bdrv_refresh_filename (I'm not sure it will work good for the detached
filter node)


---

Hmm, I also think that mentioned
bdc4c4c5e372756a "backup: Remove nodes from job in .clean()" is
at least incomplete.

In block-layer, having reference counters in bs, we can't rely on
"hmm, let's just drop this one reference, and hope, that after next
function, the node will be completely removed".

So, we either need a guarantee, that filter node is completely removed
when we detach it (OK, detaching should just fail if it doesn't lead
to complete removal), or we should be prepared to existing detached
filters, and handle them correctly.


>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
> 1  0x00005efea73cf9dc in bdrv_block_device_info
>      (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
>      at block/qapi.c:62
> 2  0x00005efea7391ed3 in bdrv_named_nodes_list
>      (flat=<optimized out>, errp=0x7ffeb829ebd8)
>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
> 3  0x00005efea7471993 in qmp_query_named_block_nodes
>      (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
> 4  qmp_marshal_query_named_block_nodes
>      (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
>      at qapi/qapi-commands-block-core.c:553
> 5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
>      at qapi/qmp-dispatch.c:128
> 6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
>      at util/async.c:219
> 7  0x00005efea74ffdb2 in aio_dispatch (ctx=0x5efed6f3f430)
>      at util/aio-posix.c:436
> 8  0x00005efea7512846 in aio_ctx_dispatch (source=<optimized out>,
>      callback=<optimized out>,user_data=<optimized out>)
>      at util/async.c:361
> 9  0x00007f2b77809bfb in ?? ()
>      from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> 10 0x00007f2b77809e70 in g_main_context_dispatch ()
>      from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> 11 0x00005efea7517228 in glib_pollfds_poll () at util/main-loop.c:287
> 12 os_host_main_loop_wait (timeout=0) at util/main-loop.c:310
> 13 main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:589
> 14 0x00005efea7140482 in qemu_main_loop () at system/runstate.c:905
> 15 0x00005efea744e4e8 in qemu_default_main (opaque=opaque@entry=0x0)
>      at system/main.c:50
> 16 0x00005efea6e76319 in main
>      (argc=<optimized out>, argv=<optimized out>)
>      at system/main.c:93
> 
> As in bdc4c4c, there is no function to remove just the cor_filter_bs
> from the job, so drop all the job's nodes as they are no longer needed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
> Buglink: https://bugs.launchpad.net/bugs/2126951
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
> This patch fixes the issue described in Gitlab #3149. Please see the bug
> for additional context & reproducer for the issue.
> 
> I'm happy to discuss alternative approaches or resubmit as needed.
> 
> `make check-block` passes locally.
> 
> A review would be greatly appreciated as a customer's production is
> impacted.
> 
> First-time patch mailer so please pardon any mistakes.
> ---
> Changes in v2:
> - Added backtrace to commit message
> - Link to v1: https://lore.kernel.org/qemu-devel/20251020-fix-3149-v1-1-04b2d4db5179@canonical.com
> ---
>   block/stream.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/stream.c b/block/stream.c
> index c0616b69e259bf5a9b146dadd9dbac62bfaa9f23..1733abd8f96d7847701f54a7a55d3284387b8582 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -132,6 +132,12 @@ static void stream_clean(Job *job)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>   
> +    /*
> +     * The job still holds a reference to cor_filter_bs; drop all bdrv to
> +     * ensure that it is unref-ed
> +     */
> +    block_job_remove_all_bdrv(&s->common);
> +
>       if (s->cor_filter_bs) {
>           bdrv_cor_filter_drop(s->cor_filter_bs);
>           s->cor_filter_bs = NULL;
> 
> ---
> base-commit: 3a2d5612a7422732b648b46d4b934e2e54622fd6
> change-id: 20251020-fix-3149-f01ae62fa53c
> 
> Best regards,


-- 
Best regards,
Vladimir

