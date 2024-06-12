Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46ABC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 18:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHSON-00074P-4b; Wed, 12 Jun 2024 14:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHSOK-000740-Mx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:08:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHSOI-0008P2-MT
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:08:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 721163472E;
 Wed, 12 Jun 2024 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718215686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTMwrqF2lxh9jxrZhFQe7pl4zqn+88zpjvXe3sk/ZKA=;
 b=x0RUq8gYFwPfbNRjqvu2wesXHjHPdC6jfnEG5J1/ZSGguQSrvI3aHayiLA+gmEeWiIPEnN
 sBaIoWCDYtGoQEmamD5hQpH1lkyjlc+ua4C/jGTrQCc+OeVRgvLrz503UuvOtzALWJuh5b
 m9W9IelDHLjA06WYzqXvMrCuDMzbtiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718215686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTMwrqF2lxh9jxrZhFQe7pl4zqn+88zpjvXe3sk/ZKA=;
 b=tqEUdt9woo0Po3wlVG3BoBRVfYnYJaEbC0YoyW9tGF6UfVXl11dp9gZasGc0Q3UAG6k6AX
 8iHIKOIiH4dZfkBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="JZmxXoT/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o2QZ8ePi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718215685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTMwrqF2lxh9jxrZhFQe7pl4zqn+88zpjvXe3sk/ZKA=;
 b=JZmxXoT/eOwxnZKlDGbcER/giULE11oD/VLIdHUYWVhvjf9JcKh/NrSQVC9N/INRueNe7O
 lAkh2ROLuRXc4LqgBxtwSFj1vSONcn5HPtUa3TA+lJprSLrmLLZC6ut9guJAzYJHJJ5LLl
 Ps9VYCBWkG2oQNyIeLRa7RQXzBTYTHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718215685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTMwrqF2lxh9jxrZhFQe7pl4zqn+88zpjvXe3sk/ZKA=;
 b=o2QZ8ePif62penSrJqrLpK2Kjuo4duW0Xu4eM+oBekrfW3stvbyOn7CF9ejs9Ti+l5v3ng
 Gr83IY07gAIgNuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB08D1372E;
 Wed, 12 Jun 2024 18:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sR0BLATkaWY6CQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 12 Jun 2024 18:08:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to
 precopy file migration
In-Reply-To: <87le3cwo9e.fsf@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n> <87r0d4wv1q.fsf@suse.de>
 <ZmdNstq2bONG-7M7@x1n> <87le3cwo9e.fsf@suse.de>
Date: Wed, 12 Jun 2024 15:08:02 -0300
Message-ID: <87ed92c9vh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 721163472E
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Mon, Jun 10, 2024 at 02:45:53PM -0300, Fabiano Rosas wrote:
>>> >> AIUI, the issue here that users are already allowed to specify in
>>> >> libvirt the equivalent to direct-io and multifd independent of each
>>> >> other (bypass-cache, parallel). To start requiring both together now in
>>> >> some situations would be a regression. I confess I don't know libvirt
>>> >> code to know whether this can be worked around somehow, but as I said,
>>> >> it's a relatively simple change from the QEMU side.
>>> >
>>> > Firstly, I definitely want to already avoid all the calls to either
>>> > migration_direct_io_start() or *_finish(), now we already need to
>>> > explicitly call them in three paths, and that's not intuitive and less
>>> > readable, just like the hard coded rdma codes.
>>> 
>>> Right, but that's just a side-effect of how the code is structured and
>>> the fact that writes to the stream happen in small chunks. Setting
>>> O_DIRECT needs to happen around aligned IO. We could move the calls
>>> further down into qemu_put_buffer_at(), but that would be four fcntl()
>>> calls for every page.
>>
>> Hmm.. why we need four fcntl()s instead of two?
>
> Because we need to first get the flags before flipping the O_DIRECT
> bit. And we do this once to enable and once to disable.
>
>     int flags = fcntl(fioc->fd, F_GETFL);
>     if (enabled) {
>         flags |= O_DIRECT;
>     } else {
>         flags &= ~O_DIRECT;
>     }
>     fcntl(fioc->fd, F_SETFL, flags);
>
>>> 
>>> A tangent:
>>>  one thing that occured to me now is that we may be able to restrict
>>>  calls to qemu_fflush() to internal code like add_to_iovec() and maybe
>>>  use that function to gather the correct amount of data before writing,
>>>  making sure it disables O_DIRECT in case alignment is about to be
>>>  broken?
>>
>> IIUC dio doesn't require alignment if we don't care about perf?  I meant it
>> should be legal to write(fd, buffer, 5) even if O_DIRECT?
>
> No, we may get an -EINVAL. See Daniel's reply.
>
>>
>> I just noticed the asserts you added in previous patch, I think that's
>> better indeed, but still I'm wondering whether we can avoid enabling it on
>> qemufile.
>>
>> It makes me feel slightly nervous when introducing dio to QEMUFile rather
>> than iochannels - the API design of QEMUFile seems to easily encourage
>> breaking things in dio worlds with a default and static buffering. And if
>> we're going to blacklist most of the API anyway except the new one for
>> mapped-ram, I start to wonder too why bother on top of QEMUFile anyway.
>>
>> IIRC you also mentioned in the previous doc patch so that libvirt should
>> always pass in two fds anyway to the fdset if dio is enabled.  I wonder
>> whether it's also true for multifd=off and directio=on, then would it be
>> possible to use the dio for guest pages with one fd, while keeping the
>> normal stream to use !dio with the other fd.  I'm not sure whether it's
>> easy to avoid qemufile in the dio fd, even if not looks like we may avoid
>> frequent fcntl()s?
>
> Hm, sounds like a good idea. We'd need a place to put that new ioc
> though. Either QEMUFile.direct_ioc and then make use of it in
> qemu_put_buffer_at() or a more transparent QIOChannelFile.direct_fd that
> gets set somewhere during file_start_outgoing_migration(). Let me try to
> come up with something.

I looked into this and it's cumbersome:

- We'd need to check migrate_direct_io() several times, once to get the
  second fd and during every IO to know to use the fd.

- Even getting the second fd is not straight forward, we need to create
  a new ioc for it with qio_channel_new_path(). But QEMUFile is generic
  code, so we'd probably need to call this channel-file specific
  function from migration_channel_connect().

- With the new ioc, do we put it in QEMUFile, or do we take the fd only?
  Or maybe an ioc with two fds? Or a new QIOChannelDirect? All options
  look bad to me.

So I suggest we proceed proceed with the 1 multifd channel approach,
passing 2 fds into QEMU just like we do for the n channels. Is that ok
from libvirt's perspective? I assume libvirt users are mostly interested
in _enabling_ parallelism with --parallel, instead of _avoiding_ it with
the ommision of the option, so main thread + 1 channel should not be a
bad thing.

Choosing to use 1 multifd channel now is also a gentler introduction for
when we finally move all of the vmstate migration into multifd (I've
been looking into this, but don't hold your breaths).

