Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DCBEDF158
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 12:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqs3b-0002hB-Gt; Fri, 13 Feb 2026 07:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vqs3a-0002gq-BQ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:13:58 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vqs3Y-0003Fc-Dg
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:13:58 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B41585BCE1;
 Fri, 13 Feb 2026 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770984832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=LK/P/msDC/kMLalaCLOtAV8tYWiBC7TxMNweimv3SHg=;
 b=xu/oSYMw1c3U2ZHky2Jll5d2igIszbIXZjASFcEmoDTSqZmnSf+0rwehKy/tCI3Rt+PGAm
 +OFQX9T3e+/VVMEtWYETetQjwwd/JKn8bOIKHMcZt+jEvwdZx5N5V0n3oEFvsgOHFuSH8b
 k4C9uddwtOJ/YBp5pTT6aGVlXINZW/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770984832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=LK/P/msDC/kMLalaCLOtAV8tYWiBC7TxMNweimv3SHg=;
 b=kvSy1LPRmxuG9x+1Vg/iEhrQ2NiSqjqOrX6HSoAqww3ECgVfaX3R5FOImxLypKBvtPXA2B
 AyiSF0RuqStZj4AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770984832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=LK/P/msDC/kMLalaCLOtAV8tYWiBC7TxMNweimv3SHg=;
 b=xu/oSYMw1c3U2ZHky2Jll5d2igIszbIXZjASFcEmoDTSqZmnSf+0rwehKy/tCI3Rt+PGAm
 +OFQX9T3e+/VVMEtWYETetQjwwd/JKn8bOIKHMcZt+jEvwdZx5N5V0n3oEFvsgOHFuSH8b
 k4C9uddwtOJ/YBp5pTT6aGVlXINZW/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770984832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=LK/P/msDC/kMLalaCLOtAV8tYWiBC7TxMNweimv3SHg=;
 b=kvSy1LPRmxuG9x+1Vg/iEhrQ2NiSqjqOrX6HSoAqww3ECgVfaX3R5FOImxLypKBvtPXA2B
 AyiSF0RuqStZj4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 279313EA62;
 Fri, 13 Feb 2026 12:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RqWlNn8Vj2mmFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Feb 2026 12:13:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, stefanha@redhat.com
Subject: COLO concurrency issues
Date: Fri, 13 Feb 2026 09:13:49 -0300
Message-ID: <87ms1cn8n6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[web.de,nongnu.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org];
 RCPT_COUNT_SEVEN(0.00)[8]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[entry:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Hi, I've been following the qemu-colo.rst steps to test COLO and
encountered a couple of issues. Unfortunately, I don't have cycles to
investigate further. Happens with QEMU master (also tested some versions
back until the COLO fix 0b5bf4ea76).

1) Deadlock at fdmon_io_uring_wait:

(steps from qemu-colo.rst)
- Secondary Failover
- Secondary resume replication
- Start the new Secondary
- Sync
- Wait until disk is synced, then:

    {"execute": "stop"}
    {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }

The above results in the old secondary hanging indefinitely at:

    do {
        ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
    } while (ret == -EINTR);

(gdb) bt                                                                                                                                                                      
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00007f5519e0204e in ??? () at //usr/lib64/liburing.so.2
#2  0x00007f5519e01b00 in ??? () at //usr/lib64/liburing.so.2
#3  0x0000563c2dc06cc9 in fdmon_io_uring_wait (ctx=0x563c30411b00, ready_list=0x7ffd0bad8f58, timeout=575708467831) at ../util/fdmon-io_uring.c:416
#4  0x0000563c2dc00976 in aio_poll (ctx=0x563c30411b00, blocking=true) at ../util/aio-posix.c:699
#5  0x0000563c2daa01c6 in bdrv_drain_all_begin () at ../block/io.c:529
#6  0x0000563c2daa03d8 in bdrv_drain_all () at ../block/io.c:574
#7  0x0000563c2d764aae in do_vm_stop (state=RUN_STATE_PAUSED, send_stop=true) at ../system/cpus.c:312
#8  0x0000563c2d765964 in vm_stop (state=RUN_STATE_PAUSED) at ../system/cpus.c:754
#9  0x0000563c2d7f3378 in qmp_stop (errp=0x7ffd0bad9080) at ../monitor/qmp-cmds.c:62
#10 0x0000563c2dba7a72 in qmp_marshal_stop (args=0x563c306ac070, ret=0x7f5518dffda8, errp=0x7f5518dffda0) at qapi/qapi-commands-misc.c:197
#11 0x0000563c2dbf1316 in do_qmp_dispatch_bh (opaque=0x7f5518dffe40) at ../qapi/qmp-dispatch.c:128
#12 0x0000563c2dc1de48 in aio_bh_call (bh=0x563c3040fef0) at ../util/async.c:173
#13 0x0000563c2dc1df64 in aio_bh_poll (ctx=0x563c3040c070) at ../util/async.c:220
#14 0x0000563c2dbffff0 in aio_dispatch (ctx=0x563c3040c070) at ../util/aio-posix.c:389
#15 0x0000563c2dc1e3cd in aio_ctx_dispatch (source=0x563c3040c070, callback=0x0, user_data=0x0) at ../util/async.c:365
#16 0x00007f551b114f4c in g_main_dispatch (context=0x563c304120f0) at ../glib/gmain.c:3476
#17 g_main_context_dispatch_unlocked (context=context@entry=0x563c304120f0) at ../glib/gmain.c:4284
#18 0x00007f551b1170c9 in g_main_context_dispatch (context=0x563c304120f0) at ../glib/gmain.c:4272
#19 0x0000563c2dc1fa0b in glib_pollfds_poll () at ../util/main-loop.c:290
#20 0x0000563c2dc1fa85 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
#21 0x0000563c2dc1fb8a in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
#22 0x0000563c2d78eb60 in qemu_main_loop () at ../system/runstate.c:903
#23 0x0000563c2db412fc in qemu_default_main (opaque=0x0) at ../system/main.c:50
#24 0x0000563c2db413ab in main (argc=40, argv=0x7ffd0bad94d8) at ../system/main.c:93

---

2) Race at colo_process_checkpoint

The following pattern seems to be inherently racy, whether the switch
statement sees the state as COMPLETED or not varies:

colo_process_checkpoint()
{
    ...
out:
    ...
    /*
     * There are only two reasons we can get here, some error happened
     * or the user triggered failover.
     */
--> switch (failover_get_state()) {
    case FAILOVER_STATUS_COMPLETED:
        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
                                  COLO_EXIT_REASON_REQUEST);
        break;
    default:
        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
                                  COLO_EXIT_REASON_ERROR);
    }

    /* Hope this not to be too long to wait here */
--> qemu_event_wait(&s->colo_exit_event);
    ...
}

This results in what seems like a spurious:

{"timestamp": {"seconds": 1770984655, "microseconds": 216464}, "event":
"COLO_EXIT", "data": {"mode": "primary", "reason": "error"}}

I'm not sure if the intention is to just ignore it, but it seems moving
the qemu_event_wait before checking the state would eliminate the race.


