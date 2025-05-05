Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77300C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC16u-0004JD-6O; Mon, 05 May 2025 15:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uC16o-0004Fg-0u
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:04:13 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uC16l-00004y-0G
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:04:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D776321165;
 Mon,  5 May 2025 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746471845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gv/ZVu/YZJ6KSd5Eb1fG0xEWZDg9WkzeMJc/dJxAMw8=;
 b=araX2hw1U3NmlSYlOab5DniOVRBfXEhCJNyOuAK9ntXJKWfALx9VcR+ZUQMP/BGLj69e64
 dar7fLRO+R/9VfWA8JK6v13ryXMTMlXZGAWI0b/LOh3y8aQ5gYJ712w1765lo3mwe/rifA
 RBxoQmHPfjvNiuRvtUHS26eALYfhVrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746471845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gv/ZVu/YZJ6KSd5Eb1fG0xEWZDg9WkzeMJc/dJxAMw8=;
 b=MH1/MyLllE0h8grTHcnscCTOLG0W4fWxy6Dd6o3qzGXO6OUejJ0C/BEq27TmJJnOfd9jc9
 UBouwza9TS2l75Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746471843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gv/ZVu/YZJ6KSd5Eb1fG0xEWZDg9WkzeMJc/dJxAMw8=;
 b=guKTZbsqTONl3BQ/75RPmfXPbcNI4r/bX9H5xzrZKv8eeg7t28WDSviCPN+VjUrrpZ+jRl
 iGdB6JOZRiL6TQu/3vi5gWMaOGVBKpzZdcRZZcBNeoYoN75NEVgeUoZj3XLg1sfk6GlyQV
 K4KwxDudtM8cQIQxWG2vQ99f0KGnL3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746471843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gv/ZVu/YZJ6KSd5Eb1fG0xEWZDg9WkzeMJc/dJxAMw8=;
 b=BysC5h3JPcYv1H+afSUrQWJZ8FpcWuCRYpbwZwDi62ZcY4IJbSYwUskSiIG50TD0WK0Hja
 ZS8oP5W8atwP9ZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 576E21372E;
 Mon,  5 May 2025 19:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LAWNBaMLGWgYGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 May 2025 19:04:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
Date: Mon, 05 May 2025 16:04:00 -0300
Message-ID: <87v7qeg9r3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, gitlab.com:url,
 suse.de:email, suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Hi,
>
>> On Thu, Apr 17, 2025 at 01:05:37PM -0300, Fabiano Rosas wrote:
>> > It's not that page faults happen during multifd. The page was already
>> > sent during precopy, but multifd-recv didn't write to it, it just marked
>> > the receivedmap. When postcopy starts, the page gets accessed and
>> > faults. Since postcopy is on, the migration wants to request the page
>> > from the source, but it's present in the receivedmap, so it doesn't
>> > ask. No page ever comes and the code hangs waiting for the page fault to
>> > be serviced (or potentially faults continuously? I'm not sure on the
>> > details).
>>
>> I think your previous analysis is correct on the zero pages.  I am not 100%
>> sure if that's the issue but very likely.  I tend to also agree with you
>> that we could skip zero page optimization in multifd code when postcopy is
>> enabled (maybe plus some comment right above..).
>
>    migration/multifd: solve zero page causing multiple page faults
>      -> https://gitlab.com/qemu-project/qemu/-/commit/5ef7e26bdb7eda10d6d5e1b77121be9945e5e550
>
> * Is this the optimization that is causing the migration hang issue?
>
> ===
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index dbc1184921..00f69ff965 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -85,7 +85,8 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
>          void *page = p->host + p->zero[i];
> -        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> +        if (!migrate_postcopy() &&
> +            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              memset(page, 0, multifd_ram_page_size());
>          } else {
>              ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
> ===
>
> * Would the above patch help to resolve it?
>
> * Another way could be when the page fault occurs during postcopy
> phase, if we know (from receivedmap) that the faulted page is a
> zero-page, maybe we could write it locally on the destination to
> service the page-fault?
>
> On Thu, 17 Apr 2025 at 21:35, Fabiano Rosas <farosas@suse.de> wrote:
>> Maybe there's a bug in the userfaultfd detection? I'll leave it to you, here's the error:
>>
>> # Running /ppc64/migration/multifd+postcopy/tcp/plain/cancel
>> # Using machine type: pseries-10.0
>> # starting QEMU: exec ./qemu-system-ppc64 -qtest
>> # {
>> #     "error": {
>> #         "class": "GenericError",
>> #         "desc": "Postcopy is not supported: Userfaultfd not available: Function not implemented"
>> #     }
>> # }
>
> * It is saying - function not implemented - does the Pseries machine
> not support userfaultfd?
>

We're missing a check on has_uffd for the multifd+postcopy tests.

> Thank you.
> ---
>   - Prasad

