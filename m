Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB8AC36014
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzM9s-0004FF-HQ; Mon, 31 Mar 2025 16:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzM9h-0004D3-Lc
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 16:54:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzM9f-0005cj-HQ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 16:54:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0571211D7;
 Mon, 31 Mar 2025 20:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743454485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifxiBGnnlewC7yvj/DVIwtHutL9D7FCdLtX1plOPSlw=;
 b=X8fJOd+pLWcxIw/R6UmzaE28AENEbfIsUeMRvA5QX3af/4iBV2X08EggruE3vWUjXbvEWU
 MKuaT+4cEEWrtWo15mGwYrH4Qp96WyAzR0FmwUehgaHPkqBDCvl11wFItPHzZt+NJOD96v
 GQYBhBeEpaJoPMqY8+AH7e8qIL7Te28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743454485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifxiBGnnlewC7yvj/DVIwtHutL9D7FCdLtX1plOPSlw=;
 b=lR3QEJ+WsHAQacmKHoZuAu7kojWa7VOtmZI6mY1w825iwRGZC4r4ZlkVn17BxIZK1q0l7p
 02eEDLfDBPUDGwAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NIzTyn5w;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DXM8axsR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743454484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifxiBGnnlewC7yvj/DVIwtHutL9D7FCdLtX1plOPSlw=;
 b=NIzTyn5wdzRff29k2tm30SQ49sNt50WtDa6GrFLe5Nev3HKTlhTTLHYE1Zpkz91ImBk91D
 ClAkI9+6EKzE3Q5H7jgch907tXmBP4daI19ei9Yn6PWQyq6EVBHdny+akZ4ukOU/z9OI3B
 XtFcLsvla605S7iAMNi4cwcfMi2fEDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743454484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifxiBGnnlewC7yvj/DVIwtHutL9D7FCdLtX1plOPSlw=;
 b=DXM8axsRgyyj8DBE6E+cN0ELskUXPEmmkkQo814vE/hyq9+JVNShXInUsDfDiIZnrnvFZE
 kbd1daKa6pue2jDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44AFB139A1;
 Mon, 31 Mar 2025 20:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zCxeARQB62dtKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 31 Mar 2025 20:54:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <20250318123846.1370312-1-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
Date: Mon, 31 Mar 2025 17:54:41 -0300
Message-ID: <87plhwgbu6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D0571211D7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> Hello,
>
> * This series (v8) splits earlier patch-2 which enabled multifd and
>   postcopy options together into two separate patches. One modifies
>   the channel discovery in migration_ioc_process_incoming() function,
>   and second one enables the multifd and postcopy migration together.
>
>   It also adds the 'save_postcopy_prepare' savevm_state handler to
>   enable different sections to take an action just before the Postcopy
>   phase starts. Thank you Peter for these patches.
> ===
> 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             152.66s   81 subtests passed

The postcopy/multifd/plain test is still hanging from time to time. I
see a vmstate load function trying to access guest memory and the
postcopy-listen thread already finished, waiting for that
qemu_loadvm_state() (frame #18) to return and set the
main_thread_load_event.

Thread 1 (Thread 0x7fbc4849df80 (LWP 7487) "qemu-system-x86"):
#0  __memcpy_evex_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:274
#1  0x0000560b135103aa in flatview_read_continue_step (attrs=..., buf=0x560b168a5930 "U\252\022\006\016\a1\300\271", len=9216, mr_addr=831488, l=0x7fbc465ff980, mr=0x560b166c5070) at ../system/physmem.c:3056
#2  0x0000560b1351042e in flatview_read_continue (fv=0x560b16c606a0, addr=831488, attrs=..., ptr=0x560b168a5930, len=9216, mr_addr=831488, l=9216, mr=0x560b166c5070) at ../system/physmem.c:3073
#3  0x0000560b13510533 in flatview_read (fv=0x560b16c606a0, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3103
#4  0x0000560b135105be in address_space_read_full (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3116
#5  0x0000560b135106e7 in address_space_rw (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3144
#6  0x0000560b13510848 in cpu_physical_memory_rw (addr=831488, buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3170
#7  0x0000560b1338f5a5 in cpu_physical_memory_read (addr=831488, buf=0x560b168a5930, len=9216) at qemu/include/exec/cpu-common.h:148
#8  0x0000560b1339063c in patch_hypercalls (s=0x560b168840c0) at ../hw/i386/vapic.c:547
#9  0x0000560b1339096d in vapic_prepare (s=0x560b168840c0) at ../hw/i386/vapic.c:629
#10 0x0000560b13390e8b in vapic_post_load (opaque=0x560b168840c0, version_id=1) at ../hw/i386/vapic.c:789
#11 0x0000560b135b4924 in vmstate_load_state (f=0x560b16c53400, vmsd=0x560b147c6cc0 <vmstate_vapic>, opaque=0x560b168840c0, version_id=1) at ../migration/vmstate.c:234
#12 0x0000560b132a15b8 in vmstate_load (f=0x560b16c53400, se=0x560b16893390) at ../migration/savevm.c:972
#13 0x0000560b132a4f28 in qemu_loadvm_section_start_full (f=0x560b16c53400, type=4 '\004') at ../migration/savevm.c:2746
#14 0x0000560b132a5ae8 in qemu_loadvm_state_main (f=0x560b16c53400, mis=0x560b16877f20) at ../migration/savevm.c:3058
#15 0x0000560b132a45d0 in loadvm_handle_cmd_packaged (mis=0x560b16877f20) at ../migration/savevm.c:2451
#16 0x0000560b132a4b36 in loadvm_process_command (f=0x560b168c3b60) at ../migration/savevm.c:2614
#17 0x0000560b132a5b96 in qemu_loadvm_state_main (f=0x560b168c3b60, mis=0x560b16877f20) at ../migration/savevm.c:3073
#18 0x0000560b132a5db7 in qemu_loadvm_state (f=0x560b168c3b60) at ../migration/savevm.c:3150
#19 0x0000560b13286271 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:892
#20 0x0000560b137cb6d4 in coroutine_trampoline (i0=377836416, i1=22027) at ../util/coroutine-ucontext.c:175
#21 0x00007fbc4786a79e in ??? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:103


Thread 10 (Thread 0x7fffce7fc700 (LWP 11778) "mig/dst/listen"):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x000055555614e33f in qemu_futex_wait (f=0x5555576f6fc0, val=4294967295) at qemu/include/qemu/futex.h:29
#2  0x000055555614e505 in qemu_event_wait (ev=0x5555576f6fc0) at ../util/qemu-thread-posix.c:464
#3  0x0000555555c44eb1 in postcopy_ram_listen_thread (opaque=0x5555576f6f20) at ../migration/savevm.c:2135
#4  0x000055555614e6b8 in qemu_thread_start (args=0x5555582c8480) at ../util/qemu-thread-posix.c:541
#5  0x00007ffff72626ea in start_thread (arg=0x7fffce7fc700) at pthread_create.c:477
#6  0x00007ffff532158f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 9 (Thread 0x7fffceffd700 (LWP 11777) "mig/dst/fault"):
#0  0x00007ffff5314a89 in __GI___poll (fds=0x7fffc0000b60, nfds=2, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x0000555555c3be3f in postcopy_ram_fault_thread (opaque=0x5555576f6f20) at ../migration/postcopy-ram.c:999
#2  0x000055555614e6b8 in qemu_thread_start (args=0x555557735be0) at ../util/qemu-thread-posix.c:541
#3  0x00007ffff72626ea in start_thread (arg=0x7fffceffd700) at pthread_create.c:477
#4  0x00007ffff532158f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Breaking with gdb and stepping through the memcpy code generates a
request for a page that's seemingly already in the receivedmap:

(gdb) x/i $pc
=> 0x7ffff5399d14 <__memcpy_evex_unaligned_erms+86>:    rep movsb %ds:(%rsi),%es:(%rdi)
(gdb) p/x $rsi
$1 = 0x7fffd68cc000
(gdb) si
postcopy_ram_fault_thread_request Request for HVA=0x7fffd68cc000 rb=pc.ram offset=0xcc000 pid=11754
// these are my printfs:
postcopy_request_page:
migrate_send_rp_req_pages: 
migrate_send_rp_req_pages: mutex
migrate_send_rp_req_pages: received

// gdb hangs here, it looks like the page wasn't populated?

I've had my share of postcopy for the day. Hopefully you'll be able to
figure out what the issue is.

- reproducer (2nd iter already hangs for me):

$ for i in $(seq 1 9999); do echo "$i ============="; \
QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test \
--full -r /x86_64/migration/postcopy/multifd/plain || break ; done

- reproducer with traces and gdb:

$ for i in $(seq 1 9999); do echo "$i ============="; \
QTEST_TRACE="multifd_* -trace source_* -trace postcopy_* -trace savevm_* \
-trace loadvm_*" QTEST_QEMU_BINARY_DST='gdb --ex "handle SIGUSR1 \
noprint" --ex "run" --args ./qemu-system-x86_64' \
QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test \
--full -r /x86_64/migration/postcopy/multifd/plain || break ; done

