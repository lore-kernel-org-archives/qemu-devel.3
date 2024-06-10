Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35E9C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 20:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGlNd-0002s5-He; Mon, 10 Jun 2024 16:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sGlNc-0002ru-Dk
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:12:36 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sGlNa-0003rb-92
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:12:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2AE2008E;
 Mon, 10 Jun 2024 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718050352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvP0MYR194EQnHNqd0SlaPCh1XCj6kJimdHVjg1Xlq8=;
 b=wWZQOlA+OzFGN/f8YSrKCUXTBiBa93d0x7VFCie6s60QOngu2O9wfy94YITaKdjRveUn7c
 tcgwGFA0628/WhJjGG5rQg18CCMj22ZiQaA0iJZmntmBapigb1N1PKb2YCOSa4prxZS4qW
 jvKI681ORy8J6wVHDfi2W4p011jvqV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718050352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvP0MYR194EQnHNqd0SlaPCh1XCj6kJimdHVjg1Xlq8=;
 b=/4rUywrUBeLBG12NnnEwtTyiNhl5Kimd9pQY88lJ6ePJbTRU14NPkHrQRBTi7RM0RKrkqf
 fOZ2/A5sH3hNACAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718050352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvP0MYR194EQnHNqd0SlaPCh1XCj6kJimdHVjg1Xlq8=;
 b=wWZQOlA+OzFGN/f8YSrKCUXTBiBa93d0x7VFCie6s60QOngu2O9wfy94YITaKdjRveUn7c
 tcgwGFA0628/WhJjGG5rQg18CCMj22ZiQaA0iJZmntmBapigb1N1PKb2YCOSa4prxZS4qW
 jvKI681ORy8J6wVHDfi2W4p011jvqV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718050352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvP0MYR194EQnHNqd0SlaPCh1XCj6kJimdHVjg1Xlq8=;
 b=/4rUywrUBeLBG12NnnEwtTyiNhl5Kimd9pQY88lJ6ePJbTRU14NPkHrQRBTi7RM0RKrkqf
 fOZ2/A5sH3hNACAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5A9F13A7F;
 Mon, 10 Jun 2024 20:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RgLJGi9eZ2YoIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Jun 2024 20:12:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to
 precopy file migration
In-Reply-To: <ZmdNstq2bONG-7M7@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n> <87r0d4wv1q.fsf@suse.de>
 <ZmdNstq2bONG-7M7@x1n>
Date: Mon, 10 Jun 2024 17:12:29 -0300
Message-ID: <87le3cwo9e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
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

> On Mon, Jun 10, 2024 at 02:45:53PM -0300, Fabiano Rosas wrote:
>> >> AIUI, the issue here that users are already allowed to specify in
>> >> libvirt the equivalent to direct-io and multifd independent of each
>> >> other (bypass-cache, parallel). To start requiring both together now in
>> >> some situations would be a regression. I confess I don't know libvirt
>> >> code to know whether this can be worked around somehow, but as I said,
>> >> it's a relatively simple change from the QEMU side.
>> >
>> > Firstly, I definitely want to already avoid all the calls to either
>> > migration_direct_io_start() or *_finish(), now we already need to
>> > explicitly call them in three paths, and that's not intuitive and less
>> > readable, just like the hard coded rdma codes.
>> 
>> Right, but that's just a side-effect of how the code is structured and
>> the fact that writes to the stream happen in small chunks. Setting
>> O_DIRECT needs to happen around aligned IO. We could move the calls
>> further down into qemu_put_buffer_at(), but that would be four fcntl()
>> calls for every page.
>
> Hmm.. why we need four fcntl()s instead of two?

Because we need to first get the flags before flipping the O_DIRECT
bit. And we do this once to enable and once to disable.

    int flags = fcntl(fioc->fd, F_GETFL);
    if (enabled) {
        flags |= O_DIRECT;
    } else {
        flags &= ~O_DIRECT;
    }
    fcntl(fioc->fd, F_SETFL, flags);

>> 
>> A tangent:
>>  one thing that occured to me now is that we may be able to restrict
>>  calls to qemu_fflush() to internal code like add_to_iovec() and maybe
>>  use that function to gather the correct amount of data before writing,
>>  making sure it disables O_DIRECT in case alignment is about to be
>>  broken?
>
> IIUC dio doesn't require alignment if we don't care about perf?  I meant it
> should be legal to write(fd, buffer, 5) even if O_DIRECT?

No, we may get an -EINVAL. See Daniel's reply.

>
> I just noticed the asserts you added in previous patch, I think that's
> better indeed, but still I'm wondering whether we can avoid enabling it on
> qemufile.
>
> It makes me feel slightly nervous when introducing dio to QEMUFile rather
> than iochannels - the API design of QEMUFile seems to easily encourage
> breaking things in dio worlds with a default and static buffering. And if
> we're going to blacklist most of the API anyway except the new one for
> mapped-ram, I start to wonder too why bother on top of QEMUFile anyway.
>
> IIRC you also mentioned in the previous doc patch so that libvirt should
> always pass in two fds anyway to the fdset if dio is enabled.  I wonder
> whether it's also true for multifd=off and directio=on, then would it be
> possible to use the dio for guest pages with one fd, while keeping the
> normal stream to use !dio with the other fd.  I'm not sure whether it's
> easy to avoid qemufile in the dio fd, even if not looks like we may avoid
> frequent fcntl()s?

Hm, sounds like a good idea. We'd need a place to put that new ioc
though. Either QEMUFile.direct_ioc and then make use of it in
qemu_put_buffer_at() or a more transparent QIOChannelFile.direct_fd that
gets set somewhere during file_start_outgoing_migration(). Let me try to
come up with something.

