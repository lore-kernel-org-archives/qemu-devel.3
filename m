Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702EBF3C240
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZOo-0003QQ-Ez; Mon, 09 Mar 2026 08:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzZNz-0003Dl-Qc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:07:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzZNu-0005tp-N8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:06:59 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 649B05BE07;
 Mon,  9 Mar 2026 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773058008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9ANWmGjAZOTg+8Dli/ptJIjsRYsFwAkRZth9vrUT3M=;
 b=M5xwBBbqYL+iGxU8HfWtDu8N/SRKN0/yy1gfApF+Cw9S/TAcywx2VfAU5lV6c3DkKbr1uw
 nwRF44blcpqfavlNOq4BjS6r68cfYaURlDbZOmKhxphIZYdwCkOk8B1lqqJrbrew4i6IfY
 VZJYJ/XwBPd6VjqQCherp5dPm/A++a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773058008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9ANWmGjAZOTg+8Dli/ptJIjsRYsFwAkRZth9vrUT3M=;
 b=/5YWcluDrJFdFoR1QG8itnPFLNldFR9fvvvZ3YmPsylXjafcB73zl5IjAsnIpRxkbQA379
 js6a5tncNwoCVHDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773058008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9ANWmGjAZOTg+8Dli/ptJIjsRYsFwAkRZth9vrUT3M=;
 b=M5xwBBbqYL+iGxU8HfWtDu8N/SRKN0/yy1gfApF+Cw9S/TAcywx2VfAU5lV6c3DkKbr1uw
 nwRF44blcpqfavlNOq4BjS6r68cfYaURlDbZOmKhxphIZYdwCkOk8B1lqqJrbrew4i6IfY
 VZJYJ/XwBPd6VjqQCherp5dPm/A++a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773058008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9ANWmGjAZOTg+8Dli/ptJIjsRYsFwAkRZth9vrUT3M=;
 b=/5YWcluDrJFdFoR1QG8itnPFLNldFR9fvvvZ3YmPsylXjafcB73zl5IjAsnIpRxkbQA379
 js6a5tncNwoCVHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7E3C3EEB7;
 Mon,  9 Mar 2026 12:06:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2BdtG9e3rmmbJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 12:06:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>
Subject: Re: leaks in migration-test
In-Reply-To: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
References: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
Date: Mon, 09 Mar 2026 09:06:45 -0300
Message-ID: <87ldg11a22.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

> I'm continuing to work through leaks reported during "make check".
> Some of them come from the migration-test. (For these to actually
> appear in the log you need to run with QTEST_LOG=1, otherwise the
> migration test framework will send stderr to /dev/null and the
> tests will fail without printing the leak report.)

I'm pretty sure something changed that caused this. In the past the
leaks would be reported by the parent migration-test binary, so it
wouldn't matter where QEMU sends stderr. I don't know if it's QEMU's
build environment or something on my machine.

I'm also seeing in dmesg after migration-test aborts, which didn't use
to be the case:
Process 23732(migration-test) has RLIMIT_CORE set to 1

Anyway, the redirect to /dev/null is a pain for other reasons as well,
we discussed adding an output filter step to qtest like the iotests
have, but I couldn't find the time to work on it yet.

>
> I did find this comment in qmp_migrate_incoming():
>
>      * NOTE: QEMU _might_ leak this refcount in some failure paths, but
>      * that's OK.  This is the minimum change we need to at least making
>      * sure success case is clean on the refcount.  We can try harder to
>      * make it accurate for any kind of failures, but it might be an
>      * overkill and doesn't bring us much benefit.
>

This is silly, but I don't think is what's causing this leak. AFAIK, it
only causes problems in some very-cornery-cases when there are races
involved. I have a patch for this one as well. Again, lacking time.

> The issue with this is that it means we need to suppress leak
> reports in the whole migration-test binary, which means the
> migration code will get no leak-detection coverage at all.
> (Not all the leak paths have qmp_migrate_incoming() in their backtrace,
> as you can see below.)
>
> We're getting pretty close to being able to get a complete "make check"
> run with the leak sanitizer enabled, so it would be nice to not have
> to suppress leak reports for this test at some point.
>

Go team! Let me just put the migration pull-request out and I'll look
into this.

> Full leak report below:
>
> Direct leak of 400 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8423 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86423)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa4ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x61401b586c3c in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:767:15
>     #3 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #4 0x61401b5dabf6 in qio_channel_socket_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:70:31
>     #5 0x61401b5de78f in qio_channel_socket_accept
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:401:12
>     #6 0x61401b60a10d in qio_net_listener_channel_func
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:64:12
>     #7 0x61401b5ec4ac in qio_channel_fd_source_dispatch
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-watch.c:84:12
>     #8 0x787075a9f45d
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #9 0x787075a9f6cf in g_main_context_dispatch
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #10 0x61401c03c809 in glib_pollfds_poll
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:290:9
>     #11 0x61401c03b2c4 in os_host_main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:313:5
>     #12 0x61401c03af01 in main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:592:11
>     #13 0x61401a6f1b06 in qemu_main_loop
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/runstate.c:943:9
>     #14 0x61401bcf5d1d in qemu_default_main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:50:14
>     #15 0x61401bcf5c3e in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:93:9
>     #16 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #17 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #18 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Direct leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8423 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86423)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa4ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075a97240 in g_source_set_callback
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55240) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x61401b5fe2a2 in qio_channel_add_watch_full
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel.c:416:5
>     #4 0x61401b5fe379 in qio_channel_add_watch_source
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel.c:444:10
>     #5 0x61401b605f44 in qio_net_listener_watch
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:166:46
>     #6 0x61401b6071df in qio_net_listener_set_client_func_internal
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:275:5
>     #7 0x61401b606629 in qio_net_listener_set_client_func_full
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:284:5
>     #8 0x61401a8721e2 in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:165:5
>     #9 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #10 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #11 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #12 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #13 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #14 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #15 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #16 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #17 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 168 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8423 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86423)
> (BuildId: 49f2401988ff3a8
> 06eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa4ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x61401b586c3c in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:767:15
>     #3 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #4 0x61401b6040ab in qio_net_listener_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:40:33
>     #5 0x61401a871fdc in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:144:32
>     #6 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #7 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #8 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #9 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #10 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #11 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #12 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #13 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #14 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 96 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8423 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86423)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa4ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075a8645a in g_hash_table_new_full
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x61401b585297 in object_initialize_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:568:23
>     #4 0x61401b586c7d in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:774:5
>     #5 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #6 0x61401b6040ab in qio_net_listener_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:40:33
>     #7 0x61401a871fdc in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:144:32
>     #8 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #9 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #10 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #11 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #12 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #13 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #14 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #15 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #16 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 96 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8423 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86423)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa4ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075a8645a in g_hash_table_new_full
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x61401b585297 in object_initialize_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:568:23
>     #4 0x61401b586c7d in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:774:5
>     #5 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #6 0x61401b5dabf6 in qio_channel_socket_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:70:31
>     #7 0x61401b5de78f in qio_channel_socket_accept
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:401:12
>     #8 0x61401b60a10d in qio_net_listener_channel_func
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:64:12
>     #9 0x61401b5ec4ac in qio_channel_fd_source_dispatch
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-watch.c:84:12
>     #10 0x787075a9f45d
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #11 0x787075a9f6cf in g_main_context_dispatch
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #12 0x61401c03c809 in glib_pollfds_poll
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:290:9
>     #13 0x61401c03b2c4 in os_host_main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:313:5
>     #14 0x61401c03af01 in main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:592:11
>     #15 0x61401a6f1b06 in qemu_main_loop
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/runstate.c:943:9
>     #16 0x61401bcf5d1d in qemu_default_main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:50:14
>     #17 0x61401bcf5c3e in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:93:9
>     #18 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #19 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #20 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8840 in realloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86840)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa5819 in g_realloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63819) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075a863f7
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x443f7) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x787075a86492 in g_hash_table_new_full
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x44492) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #4 0x61401b585297 in object_initialize_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:568:23
>     #5 0x61401b586c7d in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:774:5
>     #6 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #7 0x61401b5dabf6 in qio_channel_socket_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:70:31
>     #8 0x61401b5de78f in qio_channel_socket_accept
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:401:12
>     #9 0x61401b60a10d in qio_net_listener_channel_func
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:64:12
>     #10 0x61401b5ec4ac in qio_channel_fd_source_dispatch
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-watch.c:84:12
>     #11 0x787075a9f45d
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #12 0x787075a9f6cf in g_main_context_dispatch
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #13 0x61401c03c809 in glib_pollfds_poll
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:290:9
>     #14 0x61401c03b2c4 in os_host_main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:313:5
>     #15 0x61401c03af01 in main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:592:11
>     #16 0x61401a6f1b06 in qemu_main_loop
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/runstate.c:943:9
>     #17 0x61401bcf5d1d in qemu_default_main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:50:14
>     #18 0x61401bcf5c3e in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:93:9
>     #19 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #20 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #21 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a860d in calloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f8660d)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa5771 in g_malloc0
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075a8640c
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4440c) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x787075a86492 in g_hash_table_new_full
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x44492) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #4 0x61401b585297 in object_initialize_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:568:23
>     #5 0x61401b586c7d in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:774:5
>     #6 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #7 0x61401b6040ab in qio_net_listener_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:40:33
>     #8 0x61401a871fdc in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:144:32
>     #9 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #10 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #11 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #12 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #13 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #14 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #15 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #16 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #17 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8840 in realloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86840)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa5819 in g_realloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63819) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075a863f7
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x443f7) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x787075a86492 in g_hash_table_new_full
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x44492) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #4 0x61401b585297 in object_initialize_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:568:23
>     #5 0x61401b586c7d in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:774:5
>     #6 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #7 0x61401b6040ab in qio_net_listener_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:40:33
>     #8 0x61401a871fdc in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:144:32
>     #9 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #10 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #11 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #12 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #13 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #14 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #15 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #16 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #17 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a860d in calloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f8660d)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa5771 in g_malloc0
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075a8640c
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4440c) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x787075a86492 in g_hash_table_new_full
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x44492) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #4 0x61401b585297 in object_initialize_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:568:23
>     #5 0x61401b586c7d in object_new_with_type
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:774:5
>     #6 0x61401b586d60 in object_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:789:12
>     #7 0x61401b5dabf6 in qio_channel_socket_new
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:70:31
>     #8 0x61401b5de78f in qio_channel_socket_accept
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-socket.c:401:12
>     #9 0x61401b60a10d in qio_net_listener_channel_func
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:64:12
>     #10 0x61401b5ec4ac in qio_channel_fd_source_dispatch
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-watch.c:84:12
>     #11 0x787075a9f45d
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #12 0x787075a9f6cf in g_main_context_dispatch
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #13 0x61401c03c809 in glib_pollfds_poll
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:290:9
>     #14 0x61401c03b2c4 in os_host_main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:313:5
>     #15 0x61401c03af01 in main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:592:11
>     #16 0x61401a6f1b06 in qemu_main_loop
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/runstate.c:943:9
>     #17 0x61401bcf5d1d in qemu_default_main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:50:14
>     #18 0x61401bcf5c3e in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:93:9
>     #19 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #20 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #21 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 26 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8423 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86423)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa4ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075aba498 in g_strdup
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x78498) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x61401b604206 in g_strdup_inline
> /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>     #4 0x61401b604206 in qio_net_listener_set_name
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:49:22
>     #5 0x61401a872017 in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:149:5
>     #6 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #7 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #8 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #9 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #10 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #11 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #12 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #13 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #14 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 26 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8423 in malloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86423)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa4ac9 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x787075aba498 in g_strdup
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x78498) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #3 0x61401b5fbeb6 in g_strdup_inline
> /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>     #4 0x61401b5fbeb6 in qio_channel_set_name
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel.c:47:17
>     #5 0x61401a87233c in socket_accept_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:129:5
>     #6 0x61401b60a4c8 in qio_net_listener_channel_func
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:79:9
>     #7 0x61401b5ec4ac in qio_channel_fd_source_dispatch
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/channel-watch.c:84:12
>     #8 0x787075a9f45d
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #9 0x787075a9f6cf in g_main_context_dispatch
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #10 0x61401c03c809 in glib_pollfds_poll
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:290:9
>     #11 0x61401c03b2c4 in os_host_main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:313:5
>     #12 0x61401c03af01 in main_loop_wait
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../util/main-loop.c:592:11
>     #13 0x61401a6f1b06 in qemu_main_loop
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/runstate.c:943:9
>     #14 0x61401bcf5d1d in qemu_default_main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:50:14
>     #15 0x61401bcf5c3e in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:93:9
>     #16 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #17 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #18 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a860d in calloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f8660d)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa5771 in g_malloc0
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x61401b604c4e in qio_net_listener_add
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:237:41
>     #3 0x61401b6045ac in qio_net_listener_open_sync
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:126:13
>     #4 0x61401a872068 in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:157:9
>     #5 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #6 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #7 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #8 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #9 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #10 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #11 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #12 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #13 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> Indirect leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x6140191a8840 in realloc
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1f86840)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>     #1 0x787075aa5819 in g_realloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63819) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x61401b604b85 in qio_net_listener_add
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:234:24
>     #3 0x61401b6045ac in qio_net_listener_open_sync
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../io/net-listener.c:126:13
>     #4 0x61401a872068 in socket_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/socket.c:157:9
>     #5 0x61401a767363 in migration_connect_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/channel.c:83:13
>     #6 0x61401a7a4dae in qemu_setup_incoming_migration
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:702:5
>     #7 0x61401a7a49d5 in qmp_migrate_incoming
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../migration/migration.c:1779:5
>     #8 0x61401a5ee910 in qmp_x_exit_preconfig
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:2833:13
>     #9 0x61401a5f4c4a in qemu_init
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/vl.c:3849:9
>     #10 0x61401bcf5bcc in main
> /home/pm215/qemu/build/x86-tgt-san-dbg/../../system/main.c:71:5
>     #11 0x78707362a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #12 0x78707362a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>     #13 0x61401910d5d4 in _start
> (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-x86_64+0x1eeb5d4)
> (BuildId: 49f2401988ff3a806eedf30b7738ac61bcd9af6a)
>
> SUMMARY: AddressSanitizer: 1004 byte(s) leaked in 13 allocation(s).
>
>
> thanks
> -- PMM

