Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6801CC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 21:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVeti-0001vo-0l; Thu, 01 Feb 2024 16:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVetQ-0001se-KT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 16:46:45 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVetO-0000jS-8R
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 16:46:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D301F22132;
 Thu,  1 Feb 2024 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706823999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvbX5roX6K7te1wQ4cM+5M1Ugbt62RmwDJVX1JHq2dA=;
 b=zE5K2TlpkQX5T3GadGLyhGSNu7Yytc+HfPNSWO2OcfnOne9hQueZzi7oZr/q57t/OCn+p5
 MVTwVnSMDjqBDUmFJV2FiXcSeg0/eNfWSDbN1O9wEMr3CJp5L5+o2RCK8YdtNrkj+QhZRH
 c9XjFx5BOWM/6R22E1xz5WUMkArjqdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706823999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvbX5roX6K7te1wQ4cM+5M1Ugbt62RmwDJVX1JHq2dA=;
 b=kzGIuDCdW+qvm9lmz5QJVp81TWIuChfjvB2mAQqfGd9L36W+fFs0Yo9WDVi2OH3TxKYS0E
 0uglQGn14pkQIEDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706823998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvbX5roX6K7te1wQ4cM+5M1Ugbt62RmwDJVX1JHq2dA=;
 b=ZgOuJEwqzpT2wUtAGg2SYFeEi1RYG6DR33Y3j3iS9rFmi+iaKzqgIgpYlgpWk+17/DDcho
 YK1NJCt9BRbBJ3ZyjU2MNNhMAbm4G+gTFwCu9r679KJmjk6oUriWqu+/rwPUCRP1uwaeSB
 rerUVXo4sBVfnwWHUkZuBcvKxyp2VyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706823998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvbX5roX6K7te1wQ4cM+5M1Ugbt62RmwDJVX1JHq2dA=;
 b=It+5UKiX9xLchaanmwPviiyAf0TjtOYx/jOWF78Nuf8RATrpVV/Z/CK7pir6we8AsUTBS4
 1E3JWBvwa9ueD3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C35713672;
 Thu,  1 Feb 2024 21:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wtwMCT4RvGXCXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Feb 2024 21:46:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>, Prasad
 Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>, Hao Xiang
 <hao.xiang@bytedance.com>
Subject: Re: [PATCH 00/14] migration/multifd: Refactor ->send_prepare() and
 cleanups
In-Reply-To: <5515481b-3601-46e0-ba82-cbec056966f0@nvidia.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <871q9xjey8.fsf@suse.de> <ZbswgRJTXP4yKiuf@x1n>
 <5515481b-3601-46e0-ba82-cbec056966f0@nvidia.com>
Date: Thu, 01 Feb 2024 18:46:35 -0300
Message-ID: <87le83j1s4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZgOuJEwq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=It+5UKiX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: D301F22132
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Avihai Horon <avihaih@nvidia.com> writes:

> On 01/02/2024 7:47, Peter Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Jan 31, 2024 at 07:49:51PM -0300, Fabiano Rosas wrote:
>>> peterx@redhat.com writes:
>>>
>>>> From: Peter Xu <peterx@redhat.com>
>>>>
>>>> This patchset contains quite a few refactorings to current multifd:
>>>>
>>>>    - It picked up some patches from an old series of mine [0] (the last
>>>>      patches were dropped, though; I did the cleanup slightly differently):
>>>>
>>>>      I still managed to include one patch to split pending_job, but I
>>>>      rewrote the patch here.
>>>>
>>>>    - It tries to cleanup multiple multifd paths here and there, the ultimate
>>>>      goal is to redefine send_prepare() to be something like:
>>>>
>>>>        p->pages ----------->  send_prepare() -------------> IOVs
>>>>
>>>>      So that there's no obvious change yet on multifd_ops besides redefined
>>>>      interface for send_prepare().  We may want a separate OPs for file
>>>>      later.
>>>>
>>>> For 2), one benefit is already presented by Fabiano in his other series [1]
>>>> on cleaning up zero copy, but this patchset addressed it quite differently,
>>>> and hopefully also more gradually.  The other benefit is for sure if we
>>>> have a more concrete API for send_prepare() and if we can reach an initial
>>>> consensus, then we can have the recent compression accelerators rebased on
>>>> top of this one.
>>>>
>>>> This also prepares for the case where the input can be extended to even not
>>>> any p->pages, but arbitrary data (like VFIO's potential use case in the
>>>> future?).  But that will also for later even if reasonable.
>>>>
>>>> Please have a look.  Thanks,
>>>>
>>>> [0] https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
>>>> [1] https://lore.kernel.org/qemu-devel/20240126221943.26628-1-farosas@suse.de
>>>>
>>>> Peter Xu (14):
>>>>    migration/multifd: Drop stale comment for multifd zero copy
>>>>    migration/multifd: multifd_send_kick_main()
>>>>    migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
>>>>    migration/multifd: Postpone reset of MultiFDPages_t
>>>>    migration/multifd: Drop MultiFDSendParams.normal[] array
>>>>    migration/multifd: Separate SYNC request with normal jobs
>>>>    migration/multifd: Simplify locking in sender thread
>>>>    migration/multifd: Drop pages->num check in sender thread
>>>>    migration/multifd: Rename p->num_packets and clean it up
>>>>    migration/multifd: Move total_normal_pages accounting
>>>>    migration/multifd: Move trace_multifd_send|recv()
>>>>    migration/multifd: multifd_send_prepare_header()
>>>>    migration/multifd: Move header prepare/fill into send_prepare()
>>>>    migration/multifd: Forbid spurious wakeups
>>>>
>>>>   migration/multifd.h      |  34 +++--
>>>>   migration/multifd-zlib.c |  11 +-
>>>>   migration/multifd-zstd.c |  11 +-
>>>>   migration/multifd.c      | 291 +++++++++++++++++++--------------------
>>>>   4 files changed, 182 insertions(+), 165 deletions(-)
>>> This series didn't survive my 9999 iterations test on the opensuse
>>> machine.
>>>
>>> # Running /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
>>> ...
>>> kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
>>>
>>>
>>> #0  0x00005575dda06399 in qemu_mutex_lock_impl (mutex=0x18, file=0x5575ddce9cc3 "../util/qemu-thread-posix.c", line=275) at ../util/qemu-thread-posix.c:92
>>> #1  0x00005575dda06a94 in qemu_sem_post (sem=0x18) at ../util/qemu-thread-posix.c:275
>>> #2  0x00005575dd56a512 in multifd_send_thread (opaque=0x5575df054ef8) at ../migration/multifd.c:720
>>> #3  0x00005575dda0709b in qemu_thread_start (args=0x7fd404001d50) at ../util/qemu-thread-posix.c:541
>>> #4  0x00007fd45e8a26ea in start_thread (arg=0x7fd3faffd700) at pthread_create.c:477
>>> #5  0x00007fd45cd2150f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>>
>>> The multifd thread is posting channels_ready with an already freed
>>> multifd_send_state.
>>>
>>> This is the bug Avihai has hit. We're going into multifd_save_cleanup()
>>> so early that multifd_new_send_channel_async() hasn't even had the
>>> chance to set p->running. So it misses the join and frees everything up
>>> while a second multifd thread is just starting.
>> Thanks for doing that.
>>
>> Would this series makes that bug easier to happen?
>
> I think so.
> Patch #3 added an extra multifd_send_should_exit() check in 
> multifd_send_sync_main(), so now it can exit early if the first channel 
> fails.
> Plus, now migration state is set to FAILED early by:
> multifd_new_send_channel_async()->multifd_send_terminate_threads() and 
> multifd_tls_outgoing_handshake()->multifd_send_terminate_threads()
> so migration_iteration_run() is completely skipped because 
> migration_is_active() check before it will return false.
>
> I *think* this is what makes main migration thread finish earlier and 
> call multifd_save_cleanup() earlier, at least for me.
>

I'm doing some experiments with a global semaphore like channels_ready
instead of a per-channel structure like you suggested. I think we only
need to have a point past which we're assured no more channels will be
created. With that we'd only need one post at
multifd_new_send_channel_async.

