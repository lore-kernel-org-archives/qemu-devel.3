Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACC4C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KLd-0002q3-Pf; Thu, 03 Apr 2025 09:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KLb-0002pk-G2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:11:07 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KLZ-0006MH-KY
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:11:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDE59210EF;
 Thu,  3 Apr 2025 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzIt3fVYyTG2itb+P5UHWeS9HLtRR3GD+z8nvvMTmCU=;
 b=qw6vlC4Dbc5kGcbBxGOhwLBU4YP4Ab7dePWoScqFHEAv4Du0qtW6fQz1M+H1wnVdsaoTiQ
 DRrjqZg0uBUk+w2hC/5bJM9nCbBHCK9SMm4aY8m9swXDyY0STWXwskvtGrWyQKdgm/9087
 +Fl+nBPOpmLD6+UuT9HD/34aQxaP9Yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzIt3fVYyTG2itb+P5UHWeS9HLtRR3GD+z8nvvMTmCU=;
 b=leDVinZh7aj6m7wd2/sxVGyaqHuemh+YBB2jbcogVN4Xwd4jP7EapMfsDL9nAL5I0a4cqJ
 MAlappG/T1tOI8Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="hHuu+6J/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=451yaNzM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzIt3fVYyTG2itb+P5UHWeS9HLtRR3GD+z8nvvMTmCU=;
 b=hHuu+6J/c9u/6cCEeYJG0u8vrO6kVB598dzxj+x1gqsoyl9GJllBXYhz5wLj+iIHtIYVIr
 kmVwxydJSE+m5i5DvQGL9zD39mN4Yhz5Cjg/3CmvOi5hjxiMHDNh5dVbF+8lxsww0JjoJL
 h9Eww8yN+oUTbUekeFy0fF+m3EbiRMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzIt3fVYyTG2itb+P5UHWeS9HLtRR3GD+z8nvvMTmCU=;
 b=451yaNzM68GeDrOs4d/p2zlzEIsaMsXO9vf9LJtD+KromrGCyA0pRRuOMWoMXkiZwnez50
 cq+eYoUEZo9PVJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 482C013A2C;
 Thu,  3 Apr 2025 13:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8GkaAueI7mdVPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Apr 2025 13:11:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOyS+nPexU_NbF0yhK_=ubnGgKs5Lv+j7bH=xowgqQ2zkA@mail.gmail.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <87plhwgbu6.fsf@suse.de>
 <CAE8KmOyS+nPexU_NbF0yhK_=ubnGgKs5Lv+j7bH=xowgqQ2zkA@mail.gmail.com>
Date: Thu, 03 Apr 2025 10:11:00 -0300
Message-ID: <87zfgxjspn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CDE59210EF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Tue, 1 Apr 2025 at 02:24, Fabiano Rosas <farosas@suse.de> wrote:
>> The postcopy/multifd/plain test is still hanging from time to time. I
>> see a vmstate load function trying to access guest memory and the
>> postcopy-listen thread already finished, waiting for that
>> qemu_loadvm_state() (frame #18) to return and set the
>> main_thread_load_event.
>>
>> Thread 1 (Thread 0x7fbc4849df80 (LWP 7487) "qemu-system-x86"):
>> #0  __memcpy_evex_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:274
>> #1  0x0000560b135103aa in flatview_read_continue_step (attrs=..., buf=0x560b168a5930 "U\252\022\006\016\a1\300\271", len=9216, mr_addr=831488, l=0x7fbc465ff980, mr=0x560b166c5070) at ../system/physmem.c:3056
>> #2  0x0000560b1351042e in flatview_read_continue (fv=0x560b16c606a0, addr=831488, attrs=..., ptr=0x560b168a5930, len=9216, mr_addr=831488, l=9216, mr=0x560b166c5070) at ../system/physmem.c:3073
>> #3  0x0000560b13510533 in flatview_read (fv=0x560b16c606a0, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3103
>> #4  0x0000560b135105be in address_space_read_full (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3116
>> #5  0x0000560b135106e7 in address_space_rw (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3144
>> #6  0x0000560b13510848 in cpu_physical_memory_rw (addr=831488, buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3170
>> #7  0x0000560b1338f5a5 in cpu_physical_memory_read (addr=831488, buf=0x560b168a5930, len=9216) at qemu/include/exec/cpu-common.h:148
>> #8  0x0000560b1339063c in patch_hypercalls (s=0x560b168840c0) at ../hw/i386/vapic.c:547
>> #9  0x0000560b1339096d in vapic_prepare (s=0x560b168840c0) at ../hw/i386/vapic.c:629
>> #10 0x0000560b13390e8b in vapic_post_load (opaque=0x560b168840c0, version_id=1) at ../hw/i386/vapic.c:789
>> #11 0x0000560b135b4924 in vmstate_load_state (f=0x560b16c53400, vmsd=0x560b147c6cc0 <vmstate_vapic>, opaque=0x560b168840c0, version_id=1) at ../migration/vmstate.c:234
>> #12 0x0000560b132a15b8 in vmstate_load (f=0x560b16c53400, se=0x560b16893390) at ../migration/savevm.c:972
>> #13 0x0000560b132a4f28 in qemu_loadvm_section_start_full (f=0x560b16c53400, type=4 '\004') at ../migration/savevm.c:2746
>> #14 0x0000560b132a5ae8 in qemu_loadvm_state_main (f=0x560b16c53400, mis=0x560b16877f20) at ../migration/savevm.c:3058
>> #15 0x0000560b132a45d0 in loadvm_handle_cmd_packaged (mis=0x560b16877f20) at ../migration/savevm.c:2451
>> #16 0x0000560b132a4b36 in loadvm_process_command (f=0x560b168c3b60) at ../migration/savevm.c:2614
>> #17 0x0000560b132a5b96 in qemu_loadvm_state_main (f=0x560b168c3b60, mis=0x560b16877f20) at ../migration/savevm.c:3073
>> #18 0x0000560b132a5db7 in qemu_loadvm_state (f=0x560b168c3b60) at ../migration/savevm.c:3150
>> #19 0x0000560b13286271 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:892
>> #20 0x0000560b137cb6d4 in coroutine_trampoline (i0=377836416, i1=22027) at ../util/coroutine-ucontext.c:175
>> #21 0x00007fbc4786a79e in ??? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:103
>>
>>
>> Thread 10 (Thread 0x7fffce7fc700 (LWP 11778) "mig/dst/listen"):
>> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
>> #1  0x000055555614e33f in qemu_futex_wait (f=0x5555576f6fc0, val=4294967295) at qemu/include/qemu/futex.h:29
>> #2  0x000055555614e505 in qemu_event_wait (ev=0x5555576f6fc0) at ../util/qemu-thread-posix.c:464
>> #3  0x0000555555c44eb1 in postcopy_ram_listen_thread (opaque=0x5555576f6f20) at ../migration/savevm.c:2135
>> #4  0x000055555614e6b8 in qemu_thread_start (args=0x5555582c8480) at ../util/qemu-thread-posix.c:541
>> #5  0x00007ffff72626ea in start_thread (arg=0x7fffce7fc700) at pthread_create.c:477
>> #6  0x00007ffff532158f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>
>> Thread 9 (Thread 0x7fffceffd700 (LWP 11777) "mig/dst/fault"):
>> #0  0x00007ffff5314a89 in __GI___poll (fds=0x7fffc0000b60, nfds=2, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
>> #1  0x0000555555c3be3f in postcopy_ram_fault_thread (opaque=0x5555576f6f20) at ../migration/postcopy-ram.c:999
>> #2  0x000055555614e6b8 in qemu_thread_start (args=0x555557735be0) at ../util/qemu-thread-posix.c:541
>> #3  0x00007ffff72626ea in start_thread (arg=0x7fffceffd700) at pthread_create.c:477
>> #4  0x00007ffff532158f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>
>> Breaking with gdb and stepping through the memcpy code generates a
>> request for a page that's seemingly already in the receivedmap:
>>
>> (gdb) x/i $pc
>> => 0x7ffff5399d14 <__memcpy_evex_unaligned_erms+86>:    rep movsb %ds:(%rsi),%es:(%rdi)
>> (gdb) p/x $rsi
>> $1 = 0x7fffd68cc000
>> (gdb) si
>> postcopy_ram_fault_thread_request Request for HVA=0x7fffd68cc000 rb=pc.ram offset=0xcc000 pid=11754
>> // these are my printfs:
>> postcopy_request_page:
>> migrate_send_rp_req_pages:
>> migrate_send_rp_req_pages: mutex
>> migrate_send_rp_req_pages: received
>>
>> // gdb hangs here, it looks like the page wasn't populated?
>>
>> I've had my share of postcopy for the day. Hopefully you'll be able to
>> figure out what the issue is.
>>
>> - reproducer (2nd iter already hangs for me):
>>
>> $ for i in $(seq 1 9999); do echo "$i ============="; \
>> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test \
>> --full -r /x86_64/migration/postcopy/multifd/plain || break ; done
>>
>> - reproducer with traces and gdb:
>>
>> $ for i in $(seq 1 9999); do echo "$i ============="; \
>> QTEST_TRACE="multifd_* -trace source_* -trace postcopy_* -trace savevm_* \
>> -trace loadvm_*" QTEST_QEMU_BINARY_DST='gdb --ex "handle SIGUSR1 \
>> noprint" --ex "run" --args ./qemu-system-x86_64' \
>> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test \
>> --full -r /x86_64/migration/postcopy/multifd/plain || break ; done
>
> * Thank you for the reproducer and traces. I'll try to check more and
> see if I'm able to reproduce it on my side.
>

Thanks. I cannot merge this series until that issue is resolved. If it
reproduces on my machine there's a high chance that it will break CI at
some point and then it'll be a nightmare to debug. This has happened
many times before with multifd.

> Thank you.
> ---
>   - Prasad

