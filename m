Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9904EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZfa-0002kF-6M; Thu, 18 Jul 2024 18:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUZfY-0002jL-8d
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:32:12 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUZfW-0002yD-EW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:32:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E88521AF5;
 Thu, 18 Jul 2024 22:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721341928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kK2bYwNFzNJmC/VbNMOk/w8l5xVqCdbwXpqto5usnqs=;
 b=uyonvZNpC/RaCMNlVSwRPj31+KKdlPUN5trGKq6aWA7wOL0ODX1mCg7R5bhRoaN1PJVVKo
 y951SyEmN62SftxO739bR+2FiI98EJ5IMxliNzBt8S86B69yCYoFX9x5qQPOdG7pP3TDCz
 zGI4iAUuLCvpa2hs7fgnCUiik2ioJ4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721341928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kK2bYwNFzNJmC/VbNMOk/w8l5xVqCdbwXpqto5usnqs=;
 b=qAoxhMap8IFXqDNqgtnSfiEzM+t0TmLtrqrS/xazpiVEZAVKyFagledFBKZQLKu1uGP+gX
 YZH1hvromjBTDRCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uyonvZNp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qAoxhMap
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721341928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kK2bYwNFzNJmC/VbNMOk/w8l5xVqCdbwXpqto5usnqs=;
 b=uyonvZNpC/RaCMNlVSwRPj31+KKdlPUN5trGKq6aWA7wOL0ODX1mCg7R5bhRoaN1PJVVKo
 y951SyEmN62SftxO739bR+2FiI98EJ5IMxliNzBt8S86B69yCYoFX9x5qQPOdG7pP3TDCz
 zGI4iAUuLCvpa2hs7fgnCUiik2ioJ4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721341928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kK2bYwNFzNJmC/VbNMOk/w8l5xVqCdbwXpqto5usnqs=;
 b=qAoxhMap8IFXqDNqgtnSfiEzM+t0TmLtrqrS/xazpiVEZAVKyFagledFBKZQLKu1uGP+gX
 YZH1hvromjBTDRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 060AB1379D;
 Thu, 18 Jul 2024 22:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y+HPL+eXmWacHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Jul 2024 22:32:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <ZpmOmXS2G3f_65xK@x1n>
References: <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de> <Zo8DaHbWlrNe3RXL@x1n>
 <87msmodnly.fsf@suse.de> <ZpAEIvbNr-ANuASV@x1n> <87jzhi1odn.fsf@suse.de>
 <ZpmFT9O-UN30i1F1@x1n> <87frs61jcr.fsf@suse.de> <ZpmOmXS2G3f_65xK@x1n>
Date: Thu, 18 Jul 2024 19:32:05 -0300
Message-ID: <87cyna1gd6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7E88521AF5
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jul 18, 2024 at 06:27:32PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
>> >> v2 is ready, but unfortunately this approach doesn't work. When client A
>> >> takes the payload, it fills it with it's data, which may include
>> >> allocating memory. MultiFDPages_t does that for the offset. This means
>> >> we need a round of free/malloc at every packet sent. For every client
>> >> and every allocation they decide to do.
>> >
>> > Shouldn't be a blocker?  E.g. one option is:
>> >
>> >     /* Allocate both the pages + offset[] */
>> >     MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
>> >                                       sizeof(ram_addr_t) * n, 1);
>> >     pages->allocated = n;
>> >     pages->offset = &pages[1];
>> >
>> > Or.. we can also make offset[] dynamic size, if that looks less tricky:
>> >
>> > typedef struct {
>> >     /* number of used pages */
>> >     uint32_t num;
>> >     /* number of normal pages */
>> >     uint32_t normal_num;
>> >     /* number of allocated pages */
>> >     uint32_t allocated;
>> >     RAMBlock *block;
>> >     /* offset of each page */
>> >     ram_addr_t offset[0];
>> > } MultiFDPages_t;
>> 
>> I think you missed the point. If we hold a pointer inside the payload,
>> we lose the reference when the other client takes the structure and puts
>> its own data there. So we'll need to alloc/free everytime we send a
>> packet.
>
> For option 1: when the buffer switch happens, MultiFDPages_t will switch as
> a whole, including its offset[], because its offset[] always belong to this
> MultiFDPages_t.  So yes, we want to lose that *offset reference together
> with MultiFDPages_t here, so the offset[] always belongs to one single
> MultiFDPages_t object for its lifetime.

MultiFDPages_t is part of MultiFDSendData, it doesn't get allocated
individually:

struct MultiFDSendData {
    MultiFDPayloadType type;
    union {
        MultiFDPages_t ram_payload;
    } u;
};

(and even if it did, then we'd lose the pointer to ram_payload anyway -
or require multiple free/alloc)

>
> For option 2: I meant MultiFDPages_t will have no offset[] pointer anymore,
> but make it part of the struct (MultiFDPages_t.offset[]).  Logically it's
> the same as option 1 but maybe slight cleaner.  We just need to make it
> sized 0 so as to be dynamic in size.

Seems like an undefined behavior magnet. If I sent this as the first
version, you'd NACK me right away.

Besides, it's an unnecessary restriction to impose in the client
code. And like above, we don't allocate the struct directly, it's part
of MultiFDSendData, that's an advantage of using the union.

I think we've reached the point where I'd like to hear more concrete
reasons for not going with the current proposal, except for the
simplicity argument you already put. I like the union idea, but OTOH we
already have a working solution right here.

>
> Hmm.. is it the case?

