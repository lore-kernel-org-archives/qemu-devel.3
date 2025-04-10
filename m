Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AD1C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 20:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2yLn-0002ju-UT; Thu, 10 Apr 2025 16:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u2yLm-0002hm-Eg
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 16:18:14 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u2yLk-0003d6-71
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 16:18:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19E791F395;
 Thu, 10 Apr 2025 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744316288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BfQ64SOdCztTMQOg2U9aWcqo3wey0YAqJyPZARprZOM=;
 b=qE+UbBmhUh6sZj8gxiEyGTCjESc29+oRve8I7/p2LDTaVYpJtjfBPVBhh/V6EERjx01ur6
 IISd877FtsUXgXUXFliyRzSH9AsICmEjCh9b5MjuYZkE1i6jY3XitAdxYO6EjkE+qYFY7O
 Ap7yzDngMmrTx2XduPuI0qxQvFdHp7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744316288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BfQ64SOdCztTMQOg2U9aWcqo3wey0YAqJyPZARprZOM=;
 b=UFm+ijk6GRbeUaQJL0o9XcAfn8d+c6oB9Z2kuQBYQX6ikr/12GEMlSbsQMgSXLQ09a+m7c
 nR/rCCf+DYxjKgAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qE+UbBmh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UFm+ijk6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744316288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BfQ64SOdCztTMQOg2U9aWcqo3wey0YAqJyPZARprZOM=;
 b=qE+UbBmhUh6sZj8gxiEyGTCjESc29+oRve8I7/p2LDTaVYpJtjfBPVBhh/V6EERjx01ur6
 IISd877FtsUXgXUXFliyRzSH9AsICmEjCh9b5MjuYZkE1i6jY3XitAdxYO6EjkE+qYFY7O
 Ap7yzDngMmrTx2XduPuI0qxQvFdHp7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744316288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BfQ64SOdCztTMQOg2U9aWcqo3wey0YAqJyPZARprZOM=;
 b=UFm+ijk6GRbeUaQJL0o9XcAfn8d+c6oB9Z2kuQBYQX6ikr/12GEMlSbsQMgSXLQ09a+m7c
 nR/rCCf+DYxjKgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8311C132D8;
 Thu, 10 Apr 2025 20:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kh5gEH8n+GcXYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Apr 2025 20:18:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOxi3w5sf_sd04qLxkg8Lys=KA0pMPJMcZ-=CJVGZRmivw@mail.gmail.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <87plhwgbu6.fsf@suse.de>
 <CAE8KmOyS+nPexU_NbF0yhK_=ubnGgKs5Lv+j7bH=xowgqQ2zkA@mail.gmail.com>
 <87zfgxjspn.fsf@suse.de>
 <CAE8KmOxi3w5sf_sd04qLxkg8Lys=KA0pMPJMcZ-=CJVGZRmivw@mail.gmail.com>
Date: Thu, 10 Apr 2025 17:18:04 -0300
Message-ID: <87h62vhitf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 19E791F395
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
> On Thu, 3 Apr 2025 at 18:41, Fabiano Rosas <farosas@suse.de> wrote:
>> Prasad Pandit <ppandit@redhat.com> writes:
>> > * Thank you for the reproducer and traces. I'll try to check more and
>> > see if I'm able to reproduce it on my side.
>>
>> Thanks. I cannot merge this series until that issue is resolved. If it
>> reproduces on my machine there's a high chance that it will break CI at
>> some point and then it'll be a nightmare to debug. This has happened
>> many times before with multifd.
>
> ===
> qemu/build)$ for i in $(seq 1 9999); do echo "$i ====";
> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test
> --full -r '/x86_64/migration/postcopy/multifd/plain' || break; done |
> tee /tmp/migration-test.out | awk -e '/====/ { printf ("%s ", $_) };
> /slow test/ { printf("%s\n", $_); }'
>
> Host-1]
> ...
> 9980 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.51 secs
> 9981 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.47 secs
> 9982 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.42 secs
> 9983 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.56 secs
> 9984 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.44 secs
> 9985 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.43 secs
> 9986 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.45 secs
> 9987 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.53 secs
> 9988 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.46 secs
> 9989 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.49 secs
> 9990 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> 9991 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.47 secs
> 9992 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.45 secs
> 9993 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.47 secs
> 9994 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.41 secs
> 9995 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.42 secs
> 9996 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.58 secs
> 9997 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.45 secs
> 9998 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.51 secs
> 9999 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.51 secs
> --------
> Iter: 9999, low: 1.35, high: 1.73, avg: 1.47 secs
>
>
> Host-2]
> ...
> 9980 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.45 secs
> 9981 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.69 secs
> 9982 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.41 secs
> 9983 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.54 secs
> 9984 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.45 secs
> 9985 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.44 secs
> 9986 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> 9987 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> 9988 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.44 secs
> 9989 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.51 secs
> 9990 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.37 secs
> 9991 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> 9992 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.51 secs
> 9993 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.47 secs
> 9994 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.47 secs
> 9995 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.45 secs
> 9996 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.53 secs
> 9997 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> 9998 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.47 secs
> 9999 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> --------
> Iter: 9999, low: 1.34, high: 1.82, avg: 1.48 secs
>
>
> Host-3]
> ...
> 9980 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.50 secs
> 9981 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.55 secs
> 9982 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.54 secs
> 9983 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.49 secs
> 9984 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.49 secs
> 9985 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.52 secs
> 9986 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> 9987 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.52 secs
> 9988 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.54 secs
> 9989 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.51 secs
> 9990 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.51 secs
> 9991 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.50 secs
> 9992 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.53 secs
> 9993 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.50 secs
> 9994 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.53 secs
> 9995 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.49 secs
> 9996 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.48 secs
> 9997 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.54 secs
> 9998 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.44 secs
> 9999 ==== # slow test /x86_64/migration/postcopy/multifd/plain
> executed in 1.54 secs
> --------
> Iter: 9999, low: 1.31, high: 2.49, avg: 1.48
> ===
>
> * I tried to reproduce the hang issue with and without -traces across
> 3 different machines but am unable to reproduce it on my side.
>
> * Going through the source and the back trace you provided, you said
> gdb hangs in the postcopy_ram_fault_thread() function at poll()
> function to wait for a missing page.
>    - But by this time, postcopy_ram_listen thread is already preparing
> to cleanup and exit
>        - That means postcopy migration is finished/ending
>    - ie. postcopy migration is ending without (or before) migrating
> all the RAM pages from the source side?
>

That's what it looks like. It could be some error condition that is not
being propagated properly. The thread hits an error and exits without
informing the rest of migration.

> In postcopy mode:
>     * Is there a way to log the pages (#numers) that are sent from the
> source side?
>     * And log the pages (#numbers) that are received on the receive side?
>
> * That way we might be able to check/confirm the pages which were not
> received or not processed properly.

Some combination of the postcopy traces should give you that. Sorry,
Peter Xu really is the expert on postcopy, I just tag along.

>
> * Can we connect the faulting/missing (HVA=0x7fffd68cc000)
> address/page in postcopy_ram_fault_thread() with the memcpy that the
> main thread seems to be loading via vapic_post_load()? ie. the main
> thread and pocyopy_ram_fault_thread() above could be doing unrelated
> things.
>

The snippet I posted shows that it's the same page:

(gdb) x/i $pc
=> 0x7ffff5399d14 <__memcpy_evex_unaligned_erms+86>:    rep movsb %ds:(%rsi),%es:(%rdi)
(gdb) p/x $rsi
$1 = 0x7fffd68cc000

> * Other than this, I've revised the patch-set as suggested. How do we
> proceed further?

Send your next version and I'll set some time aside to debug this.

heads-up: I'll be off from 2025/04/18 until 2025/05/05. Peter should be
already back in the meantime.

>
> Thank you.
> ---
>   - Prasad

