Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B54E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3w1-0006XN-V4; Tue, 23 Dec 2025 10:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vY3vz-0006Um-Nz
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:04:24 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vY3vx-0000EA-67
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:04:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D191C5BCFD;
 Tue, 23 Dec 2025 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766502258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8c9rpyeP+yJYYkRncfV5RA9m++reOvI3Y7z2uDG92w=;
 b=TN+xyDKEO4UQBkuaVZPfkTZCLtyediuv9CiQx5AvfgqHrfS+ROKgLeFhdPe6ct3OiJ61X+
 SpkH9zKHMUEo2ZvcTlihF0Jlqxfsf/rxAYOrZ51aIhqG78rhGT4+oSdGnXi2UN7MRk2ncx
 odd+JwrxQYryA5KTXyDFAlDRHom4D68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766502258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8c9rpyeP+yJYYkRncfV5RA9m++reOvI3Y7z2uDG92w=;
 b=3WlqCAz4Y00ylYxe9U6RUgJLjokoXyiMH87Tkoz/QYSwFrF/2B+vY3CTCY8ahNaUiTDbmb
 K6/bbjC+UD19YcCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766502256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8c9rpyeP+yJYYkRncfV5RA9m++reOvI3Y7z2uDG92w=;
 b=WV95s5+EJw7U9OrsxOtqaRqgGyjbzCKk7wawX9yD1T0sKGYGuYBbED3mvwPxwCqTF3AvXz
 pUd4pmDzUKcqw4x448kWjJOEF3IX2Ph31U0AtO9c/9OscaLq9vCDulmQLE0yy71s1v38Td
 ZPLVP4owTdX/Kf7QT2+gUFcbDuPKhNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766502256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8c9rpyeP+yJYYkRncfV5RA9m++reOvI3Y7z2uDG92w=;
 b=z+bgWX7S7NQJV13LxSgDxkArL8Rtam0Knk/a0lNXsH0rISuEwHokUn0BrVGkwiAKNnsfeI
 iFa/SbDJHDtkTmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51EFD13A54;
 Tue, 23 Dec 2025 15:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id smPmBXCvSmm0fAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Dec 2025 15:04:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <CAE8KmOweak15R4Ji6F50b_za67q=un_GDSEMGCRTYeQKod7zQA@mail.gmail.com>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de>
 <CAE8KmOweak15R4Ji6F50b_za67q=un_GDSEMGCRTYeQKod7zQA@mail.gmail.com>
Date: Tue, 23 Dec 2025 12:04:13 -0300
Message-ID: <87cy45kzo2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hello Fabiano,
>
> * Thanks so much for the quick comments.
>
> On Mon, 22 Dec 2025 at 20:00, Fabiano Rosas <farosas@suse.de> wrote:
>> This doesn't look like it's caused by set-capabilities. Seems like:
>> Please clarify, there might be some other bug lurking around, such as a
>> locking issue with qemu_file_lock or even the BQL.
>>
>> Also, if possible provide an upstream backtrace, or at least mention the
>> code path based on upstream code. It's ok to keep the downstream
>> backtrace, but point that out in the commit message.
>
> * Right, migrate_fd_cleanup was renamed to migration_cleanup() in
>     -> https://gitlab.com/qemu-project/qemu/-/commit/4bbadfc55e6ec608df75911b4360e6e995daa28c

Yep, 10 years from now someone will look at the code and the commit
message and be confused when they don't match. Also, for anyone
backporting or searching for bug fixes, it's good to keep things tight.

I can amend while queuing if you don't mind.

> ===
> libvirtd(8) 19:03:07.260+0000: 396587: error :
> qemuMigrationJobCheckStatus:2056 : operation failed: job 'migration
> out' failed: Unable to write to socket: Connection reset by peer
> libvirtd(8) 19:03:07.261+0000: 396587: info : qemuMonitorSend:836 :
> QEMU_MONITOR_SEND_MSG: mon=0xffffa000e010
> msg={"execute":"migrate-set-capabilities","arguments":
>
>
> qemu-system-aarch64:initiating migration
> qemu-system-aarch64: migrate_fd_cleanup: to_dst_file: 1: 0xaaaaccce0110
> qemu-system-aarch64: migrate_fd_cleanup: before multifd_send_shutdown:
> 0   <== multifd disabled
> qemu-system-aarch64: migrate_fd_cleanup: to_dst_file: 2: (nil)
> qemu-system-aarch64: Unable to write to socket: Connection reset by peer
> qemu-system-aarch64: ../util/yank.c:107: yank_unregister_instance:
> Assertion `QLIST_EMPTY(&entry->yankfns)' failed.
> qemu-system-aarch64:shutting down, reason=crashed
> ===
> * As seen above, when connection is reset
>      1) libvirtd(8) sends the migrate-set-capabilities command to QEMU
> to reset the migration options to false(0). This leads to resetting of
> s->capabilities[MIGRATION_CAPABILITY_MULTIFD]  to false.
>      2) When migration_cleanup (earlier migrate_fd_cleanup) is called
> after above reset
>           migration_cleanup
>            -> multifd_send_shutdown
>             -> if (!migrate_multifd()) {
>                      return;   <== returns because _CAPABILITY_MULTIFD
> is reset to false(0).
>                 }
>          when _CAPABILITY_MULTIFD is reset to false,
> multifd_send_shutdown() returns without really doing its multifd
> cleanup, ie. multifd objects still stay alive, are not freed.
>
> * And that leads to the said assert(3) failure in
>      migration_cleanup()
>      {
>          ...
>          multifd_send_shutdown()  <== does not cleanup

Ok, I forgot there were yank functions for the multifd channels as well.

It seems multifd.c could be made more robust to not require checking
migrate_multifd() so much. For the shutdown call for instance, checking
(!multifd_send_state) would suffice. Maybe a general point for us to
keep in mind, that relying on such a high level knob might not be the
best idea.

>          ...
>          yank_unregister_instance(MIGRATION_YANK_INSTANCE);   <==
> assert(3) failure
>      }
>
>> I'm fine with the general idea:
>>
>> i) FAILED and CANCELLED are terminal states. It makes sense to not have
>> work happen after they're set.
>>
>> ii) Using an intermediate state, assuming locking/atomic are correct is
>> a suitable fix for the issue.
>>
>> iii) Using a FAILING status seems appropriate.
>>
>> However,
>>
>> It would be great if we could stop exposing implementation details via
>> QAPI. Does the user really need to see events for CANCELLING and
>> FAILING?
>
> * Not really; libvirtd(8)/user only needs to know about the success OR
> failure and appropriate reasons.
>
>> This is a good example where having MigrationStatus makes the code more
>> complicated. This could be exiting=true, running=false, etc. It
>> shouldn't matter why this routine failed.
>
> * True, it is rather complicated. Though currently we have 17-18
> migration states defined, going by the functions
> migration_is_running(), migration_is_active(), and
> migration_has_failed(), migration process really has only 3-4 states:
>       0 -> stopped (non-active, not-started-yet)
>       1 -> running/active (sending-receive migration data)
>       2 -> paused/active (not-running, not-send-recv-migration-data)
>       3 -> stopped/failed/completed (non-active, not-running)
> Other interim states of initiating/setting connections OR
> cancelling/failing etc. could be tracked differently.
>

Yes, the amount of states migration_is_running() checks is an indication
that we're making life harder for ourselves. It would be nice if we
could have some idea how to improve this the next time a patch like this
comes along.

