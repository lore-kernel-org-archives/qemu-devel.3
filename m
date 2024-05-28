Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD708C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1NG-0002j2-02; Tue, 28 May 2024 14:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sC1Mz-0002Zc-91; Tue, 28 May 2024 14:16:24 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sC1Mu-0001bm-Sk; Tue, 28 May 2024 14:16:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 84579203D4;
 Tue, 28 May 2024 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716920171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRKFbSNZ1W7ON6HVCdYFQCUK9IOonozx+atMgtBTUfQ=;
 b=dqjhZXtHxpTcPsQUm4eH9ycTztZ5XQFHj44e37lY/LGN9P8NKAPVrYVmAf9XaO6Uz9FLfg
 MypnGHPfHOhZEIx4mYlzz2YKkkJwlROxxs4BhwNb3JFWhG/dnxWAJmxWAKu1OwU592LGJy
 SWrb6AoMuTfd9Q0ItH/lpuSbzvNDF9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716920171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRKFbSNZ1W7ON6HVCdYFQCUK9IOonozx+atMgtBTUfQ=;
 b=/lrERNQso4XL4CGFTt1uVU2Hoqnrw3LDP0vSRnwiS/tV+bf4580b7LeG8mKoIPVqfwDxKk
 YjHhdnBywXyFULAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UxLD6ado;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6U71esgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716920170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRKFbSNZ1W7ON6HVCdYFQCUK9IOonozx+atMgtBTUfQ=;
 b=UxLD6adoHkdGj+EHb26iBG9lZggSuFKpZYJodLpgZ0z+pGVSHvjJBcx5iA1O2ZjaWPupEU
 +10++hKQeEc8eA5kV50z8IAQIVvSpwiKvzvTd+KzZYfvGK2Hd656lwavOOGjvGVR9rLuHU
 +RcYQBqiJKTp111WLkbjPaN2xCa8gHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716920170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRKFbSNZ1W7ON6HVCdYFQCUK9IOonozx+atMgtBTUfQ=;
 b=6U71esgXNOgtx/l4JdznVFIGgBqfJD3x3Hkfm7WRbARY0CEuj46CEW+Z3L7VRwpNOAupCB
 kA4LipqM2vvwVaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B60D13A5D;
 Tue, 28 May 2024 18:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 96j1MGkfVmYlfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 May 2024 18:16:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migrate-test: Use regular file file for
 shared-memory tests
In-Reply-To: <ZlYAvIFodnTrQIkX@x1n>
References: <20240528042758.621589-1-npiggin@gmail.com>
 <ZlXdmi7PqKJdv3fP@x1n> <ZlYAvIFodnTrQIkX@x1n>
Date: Tue, 28 May 2024 15:16:07 -0300
Message-ID: <87jzjdg5ug.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,gmail.com]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 84579203D4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, May 28, 2024 at 09:35:22AM -0400, Peter Xu wrote:
>> On Tue, May 28, 2024 at 02:27:57PM +1000, Nicholas Piggin wrote:
>> > There is no need to use /dev/shm for file-backed memory devices, and
>> > it is too small to be usable in gitlab CI. Switch to using a regular
>> > file in /tmp/ which will usually have more space available.
>> > 
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> > Am I missing something? AFAIKS there is not even any point using
>> > /dev/shm aka tmpfs anyway, there is not much special about it as a
>> > filesystem. This applies on top of the series just sent, and passes
>> > gitlab CI qtests including aarch64.
>> 
>> I think it's just that /dev/shm guarantees shmem usage, while the var
>> "tmpfs" implies g_dir_make_tmp() which may be another non-ram based file
>> system, while that'll be slightly different comparing to what a real user
>> would use - we don't suggest user to put guest RAM on things like btrfs.
>> 
>> One real implication is if we add a postcopy test it'll fail with
>> g_dir_make_tmp() when it is not pointing to a shmem mount, as
>> UFFDIO_REGISTER will fail there.  But that test doesn't yet exist as the
>> QEMU paths should be the same even if Linux will trigger different paths
>> when different types of mem is used (anonymous v.s. shmem).
>> 
>> If the goal here is to properly handle the case where tmpfs doesn't have
>> enough space, how about what I suggested in the other email?
>> 
>> https://lore.kernel.org/r/ZlSppKDE6wzjCF--@x1n
>> 
>> IOW, try populate the shmem region before starting the guest, skip if
>> population failed.  Would that work?
>
> Let me append some more info here..
>
> I think madvise() isn't needed as fallocate() should do the population work
> already, afaiu, then it means we pass the shmem path to QEMU and QEMU
> should notice this memory-backend-file existed, open() directly.
>
> I quicked walk the QEMU memory code and so far it looks all applicable, so
> that QEMU should just start the guest with the pre-populated shmem page
> caches.
>
> There's one trick where qemu_ram_mmap() will map some extra pages, on x86
> 4k, and I don't yet know why we did that..
>
>     /*
>      * Note: this always allocates at least one extra page of virtual address
>      * space, even if size is already aligned.
>      */
>     total = size + align;

At the end of the function:

    /*
     * Leave a single PROT_NONE page allocated after the RAM block, to serve as
     * a guard page guarding against potential buffer overflows.
     */

