Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F48CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 15:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uol0b-00077X-VE; Wed, 20 Aug 2025 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uol0Z-00075G-Rw
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 11:45:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uol0Y-0001tG-9D
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 11:45:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF30F1FDCF;
 Wed, 20 Aug 2025 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755704748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDvO1I8+KENJf3KaGfZMfZX5hxRg9EMZsxXLfFjKbuQ=;
 b=zv/Ijv3TD3PkO5SjKxBetB0K1yK81jsCvuB1o7W5QgRHBkZYgTganIav3Xz6UDij63vMbq
 CAQftcdm/afGsd5BrGFs1S8fuOafKCzJdnG2Z6i9wFun1WXp0pwBO412FhTLs1Zkz8wNUK
 Nl8Y38b5XgGW8oVjcMxMfIUo7y69F68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755704748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDvO1I8+KENJf3KaGfZMfZX5hxRg9EMZsxXLfFjKbuQ=;
 b=Icj16JDc/6DgZ5TDFf7yq2hLDI3E86hiZRATqdPfB9Aemvr2KPlC7WhzfI03W5QE1HwFMf
 eEYGrHemkLFiU8Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755704748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDvO1I8+KENJf3KaGfZMfZX5hxRg9EMZsxXLfFjKbuQ=;
 b=zv/Ijv3TD3PkO5SjKxBetB0K1yK81jsCvuB1o7W5QgRHBkZYgTganIav3Xz6UDij63vMbq
 CAQftcdm/afGsd5BrGFs1S8fuOafKCzJdnG2Z6i9wFun1WXp0pwBO412FhTLs1Zkz8wNUK
 Nl8Y38b5XgGW8oVjcMxMfIUo7y69F68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755704748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDvO1I8+KENJf3KaGfZMfZX5hxRg9EMZsxXLfFjKbuQ=;
 b=Icj16JDc/6DgZ5TDFf7yq2hLDI3E86hiZRATqdPfB9Aemvr2KPlC7WhzfI03W5QE1HwFMf
 eEYGrHemkLFiU8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54BF91368B;
 Wed, 20 Aug 2025 15:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BKvaBKztpWjjcwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 20 Aug 2025 15:45:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 03/24] migration: Normalize tls arguments
In-Reply-To: <aGf1T8CAQpyf8YoY@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-4-farosas@suse.de> <87y0t81hg1.fsf@pond.sub.org>
 <87o6u456xn.fsf@suse.de> <87jz4o3xry.fsf@suse.de>
 <aGf1T8CAQpyf8YoY@x1.local>
Date: Wed, 20 Aug 2025 12:45:45 -0300
Message-ID: <87ikiivvx2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jul 04, 2025 at 10:12:33AM -0300, Fabiano Rosas wrote:
>
> [...]
>
>> >>> +static void tls_opt_to_str(StrOrNull **tls_opt)
>> >>> +{
>> >>> +    StrOrNull *opt = *tls_opt;
>> >>> +
>> >>> +    if (!opt) {
>> >>> +        return;
>> >>
>> >> ... it can also be null.
>> >>
>> >
>> > Hmm, I'll have to double check, but with the StrOrNull property being
>> > initialized, NULL should not be possible. This looks like a mistake.
>> >
>> 
>> The code is correct, this is coming from the QAPI, so it could be NULL
>> in case the user hasn't provided the option. I'll use your suggested
>> wording and the code suggestion as well.
>
> One more trivial question:
>
>> 
>> >> Maybe
>> >>
>> >>    /* Normalize QTYPE_QNULL to QTYPE_QSTRING "" */
>> >>
>> >>> +    }
>> >>> +
>> >>> +    switch (opt->type) {
>> >>> +    case QTYPE_QSTRING:
>> >>> +        return;
>> >>> +    case QTYPE_QNULL:
>> >>> +        qobject_unref(opt->u.n);
>> >>> +        break;
>> >>> +    default:
>> >>> +        g_assert_not_reached();
>> >>> +    }
>> >>> +
>> >>> +    opt->type = QTYPE_QSTRING;
>> >>> +    opt->u.s = g_strdup("");
>> >>> +    *tls_opt = opt;
>
> Does tls_opt ever change?   I wonder if this line is not needed, instead
> tls_opt_to_str() can take an "StrOrNull *opt" directly.
>

Well spotted!

>> >>> +}
>> >>
>> >> I'd prefer something like
>> >>
>> >>        if (!opt || opt->type == QTYPE_QSTRING) {
>> >>            return;
>> >>        }
>> >>        qobject_unref(opt->u.n);
>> >>        opt->type = QTYPE_QSTRING;
>> >>        opt->u.s = g_strdup("");
>> >>        *tls_opt = opt;
>> >>
>> >> But this is clearly a matter of taste.
>> 
>> This is better indeed. I was moving back-and-forth between
>> implementations and the code ended up a bit weird. Thanks!
>> 

