Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07074C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 22:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVJP5-0003Up-7y; Wed, 31 Jan 2024 17:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVJP4-0003Ug-A9
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 17:49:58 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVJP2-00040M-A3
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 17:49:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F39FC21E6C;
 Wed, 31 Jan 2024 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706741394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHCDYdK5XfxTRTfGLsyQtBbinZNUcjvoRxfJEM63vkM=;
 b=iiQOyuJcFzrKJIJJFfeFdMlbfE102pm/FzUgLQFZBVtdvyW6JxqRwrnYNwTORJbF52VX0p
 WtTDFx5J2QzpQeIJeYU0ZTfvdUBkVGUKocbyOUqdQL+T5QLTu2xpkdOs8gaD8olOcOtCak
 9RVjZUSocX5p/9VR61xJ+nyeW8HYMEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706741394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHCDYdK5XfxTRTfGLsyQtBbinZNUcjvoRxfJEM63vkM=;
 b=On2gLnxt0D7toKZ2cxR83lyloRpsq9QVlyqrk+FeQgj7uvXHc2GAK8uovf4s5tAoUTCSxp
 s1Qfc0YUaNUW6DCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706741394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHCDYdK5XfxTRTfGLsyQtBbinZNUcjvoRxfJEM63vkM=;
 b=iiQOyuJcFzrKJIJJFfeFdMlbfE102pm/FzUgLQFZBVtdvyW6JxqRwrnYNwTORJbF52VX0p
 WtTDFx5J2QzpQeIJeYU0ZTfvdUBkVGUKocbyOUqdQL+T5QLTu2xpkdOs8gaD8olOcOtCak
 9RVjZUSocX5p/9VR61xJ+nyeW8HYMEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706741394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHCDYdK5XfxTRTfGLsyQtBbinZNUcjvoRxfJEM63vkM=;
 b=On2gLnxt0D7toKZ2cxR83lyloRpsq9QVlyqrk+FeQgj7uvXHc2GAK8uovf4s5tAoUTCSxp
 s1Qfc0YUaNUW6DCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C87F139B1;
 Wed, 31 Jan 2024 22:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PS7aEJHOumWUfgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 22:49:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, Prasad Pandit
 <ppandit@redhat.com>, peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 00/14] migration/multifd: Refactor ->send_prepare() and
 cleanups
In-Reply-To: <20240131103111.306523-1-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
Date: Wed, 31 Jan 2024 19:49:51 -0300
Message-ID: <871q9xjey8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iiQOyuJc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=On2gLnxt
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F39FC21E6C
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> This patchset contains quite a few refactorings to current multifd:
>
>   - It picked up some patches from an old series of mine [0] (the last
>     patches were dropped, though; I did the cleanup slightly differently):
>
>     I still managed to include one patch to split pending_job, but I
>     rewrote the patch here.
>
>   - It tries to cleanup multiple multifd paths here and there, the ultimate
>     goal is to redefine send_prepare() to be something like:
>
>       p->pages ----------->  send_prepare() -------------> IOVs
>
>     So that there's no obvious change yet on multifd_ops besides redefined
>     interface for send_prepare().  We may want a separate OPs for file
>     later.
>
> For 2), one benefit is already presented by Fabiano in his other series [1]
> on cleaning up zero copy, but this patchset addressed it quite differently,
> and hopefully also more gradually.  The other benefit is for sure if we
> have a more concrete API for send_prepare() and if we can reach an initial
> consensus, then we can have the recent compression accelerators rebased on
> top of this one.
>
> This also prepares for the case where the input can be extended to even not
> any p->pages, but arbitrary data (like VFIO's potential use case in the
> future?).  But that will also for later even if reasonable.
>
> Please have a look.  Thanks,
>
> [0] https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
> [1] https://lore.kernel.org/qemu-devel/20240126221943.26628-1-farosas@suse.de
>
> Peter Xu (14):
>   migration/multifd: Drop stale comment for multifd zero copy
>   migration/multifd: multifd_send_kick_main()
>   migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
>   migration/multifd: Postpone reset of MultiFDPages_t
>   migration/multifd: Drop MultiFDSendParams.normal[] array
>   migration/multifd: Separate SYNC request with normal jobs
>   migration/multifd: Simplify locking in sender thread
>   migration/multifd: Drop pages->num check in sender thread
>   migration/multifd: Rename p->num_packets and clean it up
>   migration/multifd: Move total_normal_pages accounting
>   migration/multifd: Move trace_multifd_send|recv()
>   migration/multifd: multifd_send_prepare_header()
>   migration/multifd: Move header prepare/fill into send_prepare()
>   migration/multifd: Forbid spurious wakeups
>
>  migration/multifd.h      |  34 +++--
>  migration/multifd-zlib.c |  11 +-
>  migration/multifd-zstd.c |  11 +-
>  migration/multifd.c      | 291 +++++++++++++++++++--------------------
>  4 files changed, 182 insertions(+), 165 deletions(-)

This series didn't survive my 9999 iterations test on the opensuse
machine.

# Running /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
...
kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)


#0  0x00005575dda06399 in qemu_mutex_lock_impl (mutex=0x18, file=0x5575ddce9cc3 "../util/qemu-thread-posix.c", line=275) at ../util/qemu-thread-posix.c:92
#1  0x00005575dda06a94 in qemu_sem_post (sem=0x18) at ../util/qemu-thread-posix.c:275
#2  0x00005575dd56a512 in multifd_send_thread (opaque=0x5575df054ef8) at ../migration/multifd.c:720
#3  0x00005575dda0709b in qemu_thread_start (args=0x7fd404001d50) at ../util/qemu-thread-posix.c:541
#4  0x00007fd45e8a26ea in start_thread (arg=0x7fd3faffd700) at pthread_create.c:477
#5  0x00007fd45cd2150f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

The multifd thread is posting channels_ready with an already freed
multifd_send_state.

This is the bug Avihai has hit. We're going into multifd_save_cleanup()
so early that multifd_new_send_channel_async() hasn't even had the
chance to set p->running. So it misses the join and frees everything up
while a second multifd thread is just starting.

