Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC21CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 21:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShrp-0005r3-Jm; Thu, 28 May 2026 17:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wShrl-0005qX-Q3
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:02:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wShrj-000206-Kb
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:02:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA6AE6AD7B;
 Thu, 28 May 2026 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780002123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tfnIAgd8QtB1mKRVjrZ4DVLOY2wy8WabVemXl9riKA=;
 b=jqCxycyVUe7F5+OgnbD/SgLnSsPfJ5ZLw2ITqIM860aLfWmQsr3/LJdTUnqNe8GY87mtT/
 AiurBSjBnSZNssUxHb/RRWpXpsVfXnXSaw9EGzT6kkCiOEVN0R51wCAwlEeTuAz4SHoa4g
 3im69rGGjGKit6ruwuw5Ukaf1S99HM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780002123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tfnIAgd8QtB1mKRVjrZ4DVLOY2wy8WabVemXl9riKA=;
 b=8hs0O1G16xKcOAvI5c4uuQRL8nPnpVWQZgjVJOAC7OX5mvVrO225e+O3SRfPm41IwZORVg
 PQchWXm7sADAiUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780002119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tfnIAgd8QtB1mKRVjrZ4DVLOY2wy8WabVemXl9riKA=;
 b=BIhSLhonflV1Fypr4D72HFmJAk2rlra48anL/VSzb2kddYL8rv6GHsBeVm+IxmPbrQ0Ys9
 lB7AEmnwdXq2/1J1n7xj0UvPGp2mrzal9RkAwhhl9yBzMDA1xojgihBM5Y3+HuPABQ0ksZ
 zRggIIdShI6ENeBaT+IEO0TveNR6ZX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780002119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tfnIAgd8QtB1mKRVjrZ4DVLOY2wy8WabVemXl9riKA=;
 b=yG3s2RqdKnqzHZri2c3aabq1QFnsy/oyK92rX3PvlvD4onW91lKtt9fE+FlBe88SrVrurU
 x+ZXhzUuzpeJ6gDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69FBF5AFAD;
 Thu, 28 May 2026 21:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HRTlDketGGqrBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 28 May 2026 21:01:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Stefan Hajnoczi
 <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v1] qed: Don't try to drain during INMIGRATE
In-Reply-To: <ahhzCjSY7zrbXFme@redhat.com>
References: <20260528135507.485-1-farosas@suse.de>
 <ahhzCjSY7zrbXFme@redhat.com>
Date: Thu, 28 May 2026 18:01:57 -0300
Message-ID: <87y0h3tfi2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:email, suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.05.2026 um 15:55 hat Fabiano Rosas geschrieben:
>> It's not possible to access the image file while there is an incoming
>> migration in progress, the QEMU process doesn't hold any locks to the
>> storage at this point so nodes are inactive. Attempting to drain leads
>> to an assert at bdrv_co_write_req_prepare():
>> 
>>    assert(!(bs->open_flags & BDRV_O_INACTIVE))
>> 
>> The issue is reproducible by running iotest 181 on a host under cpu
>> load. The migration must coincide with the header already containing
>> the QED_F_NEED_CHECK flag.
>> 
>> The sequence of events is as follows, with the respective call stacks
>> referenced below:
>> 
>> During block device init, bdrv_qed_attach_aio_context() starts the
>> 'need_check' timer. The timer will not fire during incoming migration
>> as it uses QEMU_CLOCK_VIRTUAL (to avoid this very issue, as the code
>> comment indicates).                                                   (0)
>> 
>> However, there's still bdrv_qed_drain_begin() which uses the fact that
>> the timer is live to decide whether to start the
>> qed_need_check_timer_entry() directly.                                (1)
>> 
>> The qed_need_check_timer_entry() eventually calls into
>> qed_write_header() -> bdrv_co_pwrite() leading to the assert.         (2)
>> 
>> Since we don't have an API for checking if a timer is enabled, an
>> alternative is to skip this logic whenever the runstate is
>> INMIGRATE. This actually matches the setting of the BDRV_O_INACTIVE
>> flag at blockdev.c.
>
> I'm not sure what you mean by "checking if a timer is enabled", because
> bdrv_qed_drain_begin() has a timer_pending() check that sounds exactly
> what you say doesn't exist.
>

Sorry, I meant to say checking if a *clock* is enabled. 

The code comment at qed_start_need_check_timer() says:

    /* Use QEMU_CLOCK_VIRTUAL so we don't alter the image file while suspended for
     * migration.
     */

It seems to assume that since QEMU_CLOCK_VIRTUAL is disabled when vcpus
are paused then the timer function will never execute while the image is
inactive. If bdrv_qed_drain_begin() could check clock->enabled, then it
would be under the same assumption.

> But it's also not clear to me why s->need_check_timer is true on an
> inactive image. I don't think this is supposed to be the case?

bdrv_qed_do_open() reads the header during QEMU startup. Whatever is set
in the header at that moment will be picked up, including
QED_F_NEED_CHECK, which is what the code uses to determine the timer
should be started.

> It looks like qed is missing a .bdrv_inactivate implementation that
> cancels the timer after flushing everything (including the header) to
> disk.
>

Hmm, but bdrv_inactivate happens on the migration source. The
destination machine could still start at any moment while the image is
dirty and see the QED_F_NEED_CHECK flag. Even doing something on the
destination machine wouldn't help I think given how early the crash
happens.

>> 
>> The stacks:
>> 
>> (0) == issues timer_mod ==
>>  #6  in qed_start_need_check_timer       at ../block/qed.c:340
>>  #7  in bdrv_qed_attach_aio_context      at ../block/qed.c:373
>>  #8  in bdrv_qed_do_open                 at ../block/qed.c:556
>>  #9  in bdrv_qed_open_entry              at ../block/qed.c:582
>>  #10 in coroutine_trampoline             at ../util/coroutine-ucontext.c:175
>>  #0  in qemu_coroutine_switch<+120>      at ../util/coroutine-ucontext.c:321
>>  #1  in qemu_aio_coroutine_enter<+356>   at ../util/qemu-coroutine.c:293
>>  #2  in aio_co_enter<+179>               at ../util/async.c:710
>>  #3  in aio_co_wake<+53>                 at ../util/async.c:695
>>  #4  in thread_pool_co_cb<+47>           at ../util/thread-pool.c:283
>>  #5  in thread_pool_completion_bh<+241>  at ../util/thread-pool.c:202
>>  #6  in aio_bh_call<+109>                at ../util/async.c:173
>>  #7  in aio_bh_poll<+299>                at ../util/async.c:220
>>  #8  in aio_poll<+690>                   at ../util/aio-posix.c:745
>>  #9  in bdrv_qed_open<+392>              at ../block/qed.c:607
>>  #10 in bdrv_open_driver<+327>           at ../block.c:1678
>>  #11 in bdrv_open_common<+1619>          at ../block.c:2008
>>  #12 in bdrv_open_inherit<+2556>         at ../block.c:4191
>>  #13 in bdrv_open<+118>                  at ../block.c:4286
>>  #14 in blk_new_open<+199>               at ../block/block-backend.c:458
>>  #15 in blockdev_init<+2011>             at ../blockdev.c:612
>>  #16 in drive_new<+3008>                 at ../blockdev.c:1008
>>  #17 in drive_init_func<+51>             at ../system/vl.c:662
>>  #18 in qemu_opts_foreach<+227>          at ../util/qemu-option.c:1148
>>  #19 in configure_blockdev<+350>         at ../system/vl.c:721
>>  #20 in qemu_create_early_backends<+343> at ../system/vl.c:2076
>>  #21 in qemu_init<+12483>                at ../system/vl.c:3778
>>  #22 in main<+46>                        at ../system/main.c:71
>> 
>> (1) == sees timer_pending ==
>>  #6  in bdrv_qed_drain_begin             at ../block/qed.c:391
>>  #7  in bdrv_do_drained_begin            at ../block/io.c:366
>>  #8  in bdrv_do_drained_begin_quiesce    at ../block/io.c:386
>>  #9  in bdrv_child_cb_drained_begin      at ../block.c:1207
>>  #10 in bdrv_parent_drained_begin_single at ../block/io.c:133
>>  #11 in bdrv_parent_drained_begin        at ../block/io.c:64
>>  #12 in bdrv_do_drained_begin            at ../block/io.c:364
>>  #13 in bdrv_drained_begin               at ../block/io.c:393
>>  #14 in blk_drain                        at ../block/block-backend.c:2101
>>  #15 in blk_unref                        at ../block/block-backend.c:544
>>  #16 in bdrv_open_inherit                at ../block.c:4197
>>  #17 in bdrv_open                        at ../block.c:4286
>>  #18 in blk_new_open                     at ../block/block-backend.c:458
>>  #19 in blockdev_init                    at ../blockdev.c:612
>>  #20 in drive_new                        at ../blockdev.c:1008
>>  #21 in drive_init_func                  at ../system/vl.c:662
>>  #22 in qemu_opts_foreach                at ../util/qemu-option.c:1148
>>  #23 in configure_blockdev               at ../system/vl.c:721
>>  #24 in qemu_create_early_backends       at ../system/vl.c:2076
>>  #25 in qemu_init                        at ../system/vl.c:3778
>>  #26 in main                             at ../system/main.c:71
>> 
>> (2) == crashes ==
>>  #5  in __assert_fail (assertion="!(bs->open_flags & BDRV_O_INACTIVE)", file="../block/io.c", line=1977
>>  #6  in bdrv_co_write_req_prepare  at ../block/io.c:1977
>>  #7  in bdrv_aligned_pwritev       at ../block/io.c:2099
>>  #8  in bdrv_co_pwritev_part       at ../block/io.c:2316
>>  #9  in bdrv_co_pwritev            at ../block/io.c:2233
>>  #10 in bdrv_co_pwrite             at ../include/block/block_int-io.h:77
>>  #11 in qed_write_header           at ../block/qed.c:128
>>  #12 in qed_need_check_timer       at ../block/qed.c:305
>>  #13 in qed_need_check_timer_entry at ../block/qed.c:319
>> 
>> Note that this issue is not exactly the same as what's been reported
>> in Gitlab, but given how easily this reproduces, I imagine it has to
>> be happening in that setup as well.
>> 
>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3515
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2557314306
>> ---
>>  block/qed.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/block/qed.c b/block/qed.c
>> index da23a83d62..ccf32bb4ae 100644
>> --- a/block/qed.c
>> +++ b/block/qed.c
>> @@ -21,6 +21,7 @@
>>  #include "qemu/module.h"
>>  #include "qemu/option.h"
>>  #include "qemu/memalign.h"
>> +#include "system/runstate.h"
>>  #include "trace.h"
>>  #include "qed.h"
>>  #include "system/block-backend.h"
>> @@ -373,6 +374,11 @@ static void bdrv_qed_drain_begin(BlockDriverState *bs)
>>  {
>>      BDRVQEDState *s = bs->opaque;
>>  
>> +    /* Nodes are inactive while waiting for an incoming migration. */
>> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
>
> If you're interested in whether the node is inactive, this is what you
> should check. RUN_STATE_INMIGRATE is only one of the conditions in which
> it might (but doesn't have to) be true. There is bdrv_is_inactive() to
> check this.
>
> Of course, if we're fixing the root cause (that QED_F_NEED_CHECK and
> s->need_check_timer are set on an inactive image), this hunk might not
> be needed at all.
>
>> +        return;
>> +    }
>> +
>>      /* Fire the timer immediately in order to start doing I/O as soon as the
>>       * header is flushed.
>>       */
>
> Kevin

