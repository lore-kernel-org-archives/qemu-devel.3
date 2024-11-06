Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418EAD44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8for-000308-7y; Wed, 06 Nov 2024 08:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8foo-0002zt-Dw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:11:30 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8fom-0001sE-JY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:11:30 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAD8C21C02;
 Wed,  6 Nov 2024 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730898686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEbREFhq9pRyDNDfzMrcflChPlJuN13snKElrk2Muqs=;
 b=VUTScJXaveHwIaH8cro+Qo3H6N7ipsHQvdx2paX284rjL9ABkQxM6Uhqv2hI9T9Tkyv9wG
 ycjdzZH+47ssc860uMYc6n293E5m8vIbOHBED3aronOZE3LKOkDat9SCHEzHesgNw+sstI
 0fBrCPKnEGR04r40wV9wHqoVoDRKYcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730898686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEbREFhq9pRyDNDfzMrcflChPlJuN13snKElrk2Muqs=;
 b=ViPxoieSx1Lt92U42wfzu5DgW2BzUl3mtbZ7lfKva/C7mgG/3Qq5NVnDsN7HKF+ozh8yJl
 ntWrwiogcaS2hSBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730898686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEbREFhq9pRyDNDfzMrcflChPlJuN13snKElrk2Muqs=;
 b=VUTScJXaveHwIaH8cro+Qo3H6N7ipsHQvdx2paX284rjL9ABkQxM6Uhqv2hI9T9Tkyv9wG
 ycjdzZH+47ssc860uMYc6n293E5m8vIbOHBED3aronOZE3LKOkDat9SCHEzHesgNw+sstI
 0fBrCPKnEGR04r40wV9wHqoVoDRKYcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730898686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEbREFhq9pRyDNDfzMrcflChPlJuN13snKElrk2Muqs=;
 b=ViPxoieSx1Lt92U42wfzu5DgW2BzUl3mtbZ7lfKva/C7mgG/3Qq5NVnDsN7HKF+ozh8yJl
 ntWrwiogcaS2hSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ACA813736;
 Wed,  6 Nov 2024 13:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 599uBP5qK2feHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Nov 2024 13:11:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
In-Reply-To: <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com> <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
Date: Wed, 06 Nov 2024 10:11:23 -0300
Message-ID: <87ldxw1p8k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

> On Tue, 5 Nov 2024 at 18:30, Peter Xu <peterx@redhat.com> wrote:
>> https://www.qemu.org/docs/master/devel/qapi-code-gen.html
>>
>>         Sometimes, the behaviour of QEMU changes compatibly, but without a
>>         change in the QMP syntax (usually by allowing values or operations
>>         that previously resulted in an error). QMP clients may still need
>>         to know whether the extension is available.
>>
>>         For this purpose, a list of features can be specified for
>>         definitions, enumeration values, and struct members. Each feature
>>         list member can either be { 'name': STRING, '*if': COND }, or
>>         STRING, which is shorthand for { 'name': STRING }.
>
> * I see, okay.
>
>> It's a legacy issue as not all features are developed together, and that
>> was planned to be fixed together with handshake.  I think the handshake
>> could introduce one header on top to pair channels.
>>
>> IMHO it is an overkill to add a feature now if it works even if tricky,
>> because it's not the 1st day it was tricky. And we're going to have another
>> header very soon..
>
> * See, current (this series)  'if'  conditional in the
> migration_ioc_process_incoming() function is simple as:
>
>     if (qio_channel_has_feature(ioc,
> QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) { peek_magic_bytes() ... }
>
> If we don't send magic value for the postcopy channel, then we avoid
> peeking into magic bytes when postcopy is enabled, because otherwise
> thread will block peeking into the magic bytes, so the 'if'
> conditional becomes:
>
>     if (migrate_multifd() && !migrate_postcopy() &&
> qio_channel_has_feature (...) ) {
>         peek_magic_bytes()
>         ...
>     } else {
>        When migrate_postcopy() is true
>        It'll reach here not only for the 'Postcopy' channel, but even
> for the 'default' and 'multifd' channels which send the magic bytes.
> Then here again we'll need to identify different channels, right?
>     }
>
> * Let's not make it so complex. Let's send the magic value for the
> postcopy channel and simplify it. If 'handshake' feature is going to
> redo it, so be it, what's the difference? OR maybe we can align it
> with the 'handshake' feature or as part of it or something like that.
>
> @Fabiano Rosas : may I know more about the 'handshake' feature? What
> it'll do and not do?

What we're thinking is having an initial exchange of information between
src & dst as soon as migration starts and that would sync the
capabilities and parameters between both sides. Which would then be
followed by a channel establishment phase that would open each necessary
channel (according to caps) in order, removing the current ambiguity.

>
> Thank you.
> ---
>   - Prasad

