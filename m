Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C207610A62CD
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kks-0001uN-Gz; Thu, 26 Mar 2026 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5kkr-0001uF-Br
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:28:09 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5kkp-00074z-6C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:28:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5806C5BD11;
 Thu, 26 Mar 2026 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774531685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+FxhNFW54P6zvMEyx0FgapAkjZoouiBOrHTJMP2AE4=;
 b=HpAtbLhUN6VvqdAYW9DRDuLcHy/8zL0HDd5APsD39c3356NQuDkXkObuMwKgwXtOch6jCh
 M0+hwXarmnch3rtZU9Y2bfchW4BBrNJYz6ShdmGOGE/jUNeKfDvIeUJnbx8XkzKHn5gpvp
 GNFXW3UfH8gUqdg8QCtgIFcYkeOw58E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774531685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+FxhNFW54P6zvMEyx0FgapAkjZoouiBOrHTJMP2AE4=;
 b=cY9047TcoBQGqZCst3WGaOP/1spRO06Etzz2mqXw2OYTkBaMqW057phNnbmOMSdqjFv2/M
 HLyYAnak3GVbUSCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HpAtbLhU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cY9047Tc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774531685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+FxhNFW54P6zvMEyx0FgapAkjZoouiBOrHTJMP2AE4=;
 b=HpAtbLhUN6VvqdAYW9DRDuLcHy/8zL0HDd5APsD39c3356NQuDkXkObuMwKgwXtOch6jCh
 M0+hwXarmnch3rtZU9Y2bfchW4BBrNJYz6ShdmGOGE/jUNeKfDvIeUJnbx8XkzKHn5gpvp
 GNFXW3UfH8gUqdg8QCtgIFcYkeOw58E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774531685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+FxhNFW54P6zvMEyx0FgapAkjZoouiBOrHTJMP2AE4=;
 b=cY9047TcoBQGqZCst3WGaOP/1spRO06Etzz2mqXw2OYTkBaMqW057phNnbmOMSdqjFv2/M
 HLyYAnak3GVbUSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E89504A0A3;
 Thu, 26 Mar 2026 13:28:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u26ILWQ0xWn1ZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Mar 2026 13:28:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PULL 05/10] tests/qtest/migration: Force exit-on-error=false
In-Reply-To: <7002cee0-9287-4ff1-9580-eff97aa02566@redhat.com>
References: <20260317182320.31991-1-farosas@suse.de>
 <20260317182320.31991-6-farosas@suse.de>
 <7002cee0-9287-4ff1-9580-eff97aa02566@redhat.com>
Date: Thu, 26 Mar 2026 10:28:02 -0300
Message-ID: <87cy0qk9el.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5806C5BD11
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 17/03/2026 19.23, Fabiano Rosas wrote:
>> Some tests can cause QEMU to exit(1) too early while the incoming
>> coroutine has not yielded for a first time yet. This trips ASAN
>> because resources related to dispatching the incoming process will
>> still be allocated in the io/channel.c layer without a
>> straight-forward way for the migration code to clean them up.
>> 
>> As an example of one such issue, the UUID validation happens early
>> enough that the temporary socket from qio_net_listener_channel_func()
>> still has an elevated refcount. If it fails, the listener dispatch
>> code never gets to free the resource:
>> 
>> Direct leak of 400 byte(s) in 1 object(s) allocated from:
>>      #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
>>      #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
>>      #2 0x55e66a8ef05f in object_new_with_type ../qom/object.c:767:15
>>      #3 0x55e66a8ef178 in object_new ../qom/object.c:789:12
>>      #4 0x55e66a93bcc6 in qio_channel_socket_new ../io/channel-socket.c:70:31
>>      #5 0x55e66a93f34f in qio_channel_socket_accept ../io/channel-socket.c:401:12
>>      #6 0x55e66a96752a in qio_net_listener_channel_func ../io/net-listener.c:64:12
>>      #7 0x55e66a94bdac in qio_channel_fd_source_dispatch ../io/channel-watch.c:84:12
>>      #8 0x7f3c7e2adf4b in g_main_dispatch ../glib/gmain.c:3476
>>      #9 0x7f3c7e2adf4b in g_main_context_dispatch_unlocked ../glib/gmain.c:4284
>>      #10 0x7f3c7e2b00c8 in g_main_context_dispatch ../glib/gmain.c:4272
>> 
>> The exit(1) also requires some tests to setup qtest to expect a return
>> code of 1 from the QEMU process. Although we can check migration
>> status changes to be fairly certain where the failure happened, there
>> is always the possibility of QEMU exiting for another reason and the
>> test passing. This happens frequently with sanitizers enabled, but
>> also risks masking issues in the regular build.
>> 
>> Stop allowing the incoming migration to exit and instead require the
>> tests to wait for the FAILED state and end QEMU gracefully with
>> qtest_quit.
>> 
>> In practice this means setting exit-on-error=false for every incoming
>> migration, changing MIG_TEST_FAIL_DEST_QUIT_ERR to MIG_TEST_FAIL and
>> waiting for a change of state where necessary.
>> 
>> With this, the MIG_TEST_FAIL_DEST_QUIT_ERR error result is now unused,
>> remove it.
>> 
>> The affected tests are:
>> validate_uuid_error
>> multifd_tcp_cancel
>> dirty_limit
>> precopy_unix_tls_x509_default_host
>> precopy_tcp_tls_no_hostname
>> tcp_tls_x509_mismatch_host
>> dbus_vmstate_missing_src
>> dbus_vmstate_missing_dst
>> 
>> Also add a comment to QEMU source explaining that the incoming
>> coroutine might block for a while until it yields as this is the
>> actual root cause of the issue.
>> 
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>> Link: https://lore.kernel.org/qemu-devel/20260311213418.16951-6-farosas@suse.de
>> [assert that key doesn't already exists]
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   migration/migration.c                 |  5 +++++
>>   tests/qtest/dbus-vmstate-test.c       |  5 +++--
>>   tests/qtest/migration/framework.c     |  5 +----
>>   tests/qtest/migration/framework.h     |  2 --
>>   tests/qtest/migration/migration-qmp.c |  7 +++++++
>>   tests/qtest/migration/misc-tests.c    |  4 ++--
>>   tests/qtest/migration/precopy-tests.c | 12 +++++-------
>>   tests/qtest/migration/tls-tests.c     | 14 ++++++++------
>>   8 files changed, 31 insertions(+), 23 deletions(-)
>
>   Hi Fabiano,
>
> this patch now triggers a failure in the qtests when I'm running these in 
> "SPEED=thorough" mode:
>
> MESON_TEST_ITERATION=1 MALLOC_PERTURB_=120 
> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 G_TEST_SLOW=1 
> PYTHON=/home/thuth/tmp/qemu-build/pyvenv/bin/python3 RUST_BACKTRACE=1 
> QTEST_QEMU_IMG=./qemu-img 
> G_TEST_DBUS_DAEMON=/home/thuth/devel/qemu/tests/dbus-vmstate-daemon.sh 
> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
> QTEST_QEMU_BINARY=./qemu-system-x86_64 
> /home/thuth/tmp/qemu-build/tests/qtest/migration-test --tap -k --full
>
> TAP version 14
> # random seed: R02Sb882c8142734dce2265e65214fd2b060
> # starting QEMU: exec ./qemu-system-x86_64 -qtest 
> unix:/tmp/qtest-106610.sock -qtest-log /dev/null -chardev 
> socket,path=/tmp/qtest-106610.qmp,id=char0 -mon chardev=char0,mode=control 
> -display none -audio none -run-with exit-with-parent=on -machine none -accel 
> qtest
> # Skipping test: userfaultfd not available
> 1..80
> # Start of x86_64 tests
> # Running /x86_64/dirty_limit
> # Using machine type: pc-q35-11.0
> # starting QEMU: exec ./qemu-system-x86_64 -qtest 
> unix:/tmp/qtest-106610.sock -qtest-log /dev/null -chardev 
> socket,path=/tmp/qtest-106610.qmp,id=char0 -mon chardev=char0,mode=control 
> -display none -audio none -run-with exit-with-parent=on -accel 
> kvm,dirty-ring-size=4096 -accel tcg -machine pc-q35-11.0, -name 
> source,debug-threads=on -machine memory-backend=mig.mem -object 
> memory-backend-ram,id=mig.mem,size=150M,share=off -serial 
> file:/tmp/migration-test-8B95M3/src_serial -drive 
> if=none,id=d0,file=/tmp/migration-test-8B95M3/bootsect,format=raw -device 
> ide-hd,drive=d0,secs=1,cyls=1,heads=1  2>/dev/null -accel qtest
> # starting QEMU: exec ./qemu-system-x86_64 -qtest 
> unix:/tmp/qtest-106610.sock -qtest-log /dev/null -chardev 
> socket,path=/tmp/qtest-106610.qmp,id=char0 -mon chardev=char0,mode=control 
> -display none -audio none -run-with exit-with-parent=on -accel 
> kvm,dirty-ring-size=4096 -accel tcg -machine pc-q35-11.0, -name 
> target,debug-threads=on -machine memory-backend=mig.mem -object 
> memory-backend-ram,id=mig.mem,size=150M,share=off -serial 
> file:/tmp/migration-test-8B95M3/dest_serial -incoming 
> unix:/tmp/migration-test-8B95M3/migsocket  -drive 
> if=none,id=d0,file=/tmp/migration-test-8B95M3/bootsect,format=raw -device 
> ide-hd,drive=d0,secs=1,cyls=1,heads=1  2>/dev/null -accel qtest
> ../../devel/qemu/tests/qtest/libqtest.c:201: kill_qemu() tried to terminate 
> QEMU process but encountered exit status 1 (expected 0)
> Aborted (core dumped)
>
> Could you please try whether you could reproduce that crash?
>
>   Thomas

Argh, too many dirty this, dirty that. I'll send a patch. Thanks!

