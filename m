Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA9EC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 15:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Quy-00012e-29; Thu, 17 Apr 2025 11:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u5Qut-00012E-Vc
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:12:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u5Qur-0001hi-KM
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:12:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2FED1F443;
 Thu, 17 Apr 2025 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744902754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C3bcXn5ewZr5Cv7V1QHKymS1qpzhXokfESMnXW6ncG8=;
 b=kS1193xOL28b1FKdpDNX4fliTi2E8d7e+VC+Yr9B3OoqNU+ty9vbQjlrJC/ByWI68+VVJx
 kDX0BKRwl/g/GL74xxC+VNucbOloC4jZEjEtEYsCdQjlJz+wKUvapej9AbouzTNTJzVRB4
 RPehTI4qbf3Ul3ZP85k6VY0QcgO0li4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744902754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C3bcXn5ewZr5Cv7V1QHKymS1qpzhXokfESMnXW6ncG8=;
 b=BVj7N3CKuJUg4ZseUY0FcuOR7N5SJMS2YflkfBza4/b6ToCmIGzJAEgYvv243ClU0TvTgP
 uSJSZvyryMJMdeCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=coaM35PY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SwBCjXOP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744902753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C3bcXn5ewZr5Cv7V1QHKymS1qpzhXokfESMnXW6ncG8=;
 b=coaM35PYJt7YgoQAVdB6dy7N1JBdmBuw4MUdphFD/67IogxAtLFj8so0vzjlmelE1CmA3J
 Ph37sVFc6Gml9BIaucLJGR/FF01rB5PcQLaFpdSCHy9Hk6Grp1ngdYVaQnLdZ+uWzKbo69
 Qh4mEKRCcz+DzAskoBf0YdSr9L+WDRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744902753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C3bcXn5ewZr5Cv7V1QHKymS1qpzhXokfESMnXW6ncG8=;
 b=SwBCjXOPD9KMFuqKdfSQ3ZJR7hCsl6J/WvwG3Vt6dQaVIFsbMNNTWOPnAhSzMyiu5cIWaT
 rUfV5T/ue4DqQ+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47DE11388F;
 Thu, 17 Apr 2025 15:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNLIAmEaAWhrYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Apr 2025 15:12:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add  FEATURE_SEEKABLE to QIOChannelBlock
In-Reply-To: <7cd3c-6800c580-4b5-10622a60@195456151>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de> <7cd3c-6800c580-4b5-10622a60@195456151>
Date: Thu, 17 Apr 2025 12:12:30 -0300
Message-ID: <871ptqg6u9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D2FED1F443
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, eurecom.fr:email, suse.de:dkim, suse.de:mid,
 suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

"Marco Cavenati" <Marco.Cavenati@eurecom.fr> writes:

> On Tuesday, April 15, 2025 15:50 CEST, Fabiano Rosas <farosas@suse.de> wrote:
>
>> > So, I see your point on performance, but I'm not fully comfortable
>> > with the difference in zero page handling between mapped-ram on
>> > and mapped-ram off. In the former case zero pages are skipped, while
>> > in the latter they are explicitly zeroed.
>> > Enabling mapped-ram has the implicit effect to also skip zero-pages.
>> > I think it is an optimization not really bound to mapped-ram and it
>> > could be better to have this feature external to mapped-ram, enabled
>> > when the destination ram is known to be already zeroed (also for
>> > mapped-ram off ideally).
>> 
>> From a design perspective that makes sense. The only use case currently
>> would be mapped-ram _migration_ (as opposed to snapshot) because
>> non-mapped-ram migration is usually done live. The stream of pages will
>> potentially have several versions of the same page, therefore we need to
>> clear it when it's a zero page.
>
> It might be a niche use case (and maybe I'm the only one still using
> plain old QEMU snapshots) but, also the cli option `-loadvm file` might
> benefit from skipping 0 pages: snapshots are taken with the VM stopped
> and the `-loadvm file` acts on a clean ram.
>

Indeed, I had forgotten about that usage. So that's a case where
mapped-ram does the right thing. Now I can forget about it again =)

For enabling mapped-ram generically at this point I think we don't have
much choice but to introduce a new version of read_ramblock_mapped_ram()
that writes zero pages. It would need to discriminate the zero pages,
(instead of doing a big copy of a bunch of pages) so we could avoid
copying a page that's already zero. In fact, if we do that, it would
already work without further changes. The performance of -loadvm would
leave something to be improved, but we could tackle that later.

What do you think?

If we decide we need to explicitly select that new code, I don't think
we need any new capability, because the user has no choice in it. We
know that loadvm needs it, but -loadvm doesn't, any other sort of
mapped-ram migration also doesn't need it. There is some discussion to
be had on whether we want to bind it to the commands themselves, or do
some form of detection of clean ram. I think it's best we postopone this
part of the discussion until Peter is back (next week), so we can have
more eyes on it.

>> We'd benefit from a separate "don't load zero pages" option only when
>> the VM is guaranteed to be stopped and more importantly, not allowed to
>> be unstopped. This is the tricky part. We have experimented with and
>> dropped the idea of detecting a stopped-vm-migration for mapped-ram (the
>> idea back then was not to do better zero page handling, but skip dirty
>> tracking altogether).
>> 
>> Since we're dealing with snapshots here, which are asynchronous, I'm
>> wondering wheter it would make sense to extend the zero-page-detection
>> option to the destination. Then we could bind the loadvm process to
>> zero-page-detection=none because I don't think we can safely ignore them
>> anyway.
>
>> > My overall goal is a hot-loadvm feature that currently lives in a fork
>> > downstream and has a long way before getting in a mergeable state :)
>> 
>> Cool. Don't hesitate to send stuff our way, the sooner and more often we
>> discuss this, the better the chances of getting it merged upstream.
>> 
>> Do you use libvirt at all? Mapped-ram support has been added to it in
>> the latest version. The original use-case for mapped-ram was quick
>> snapshot saving and loading after all. Libvirt does it in a way that
>> does not use savevm, which might be helpful.
>
> No, I don't use libvirt. Thanks for the hint, but in that case I guess
> libvirt would spawn a new "QEMU -incoming"  for each restore, and
> that would be too expensive.
>
>> > In a nutshell, I'm using dirty page tracking to load from the snapshot
>> > only the pages that have been dirtied between two loadvm;
>> > mapped-ram is required to seek and read only the dirtied pages.
>> 
>> But then you'd have a bitmap of pages you could correlate with the
>> file_bmap and force-load whatever pages you need. It doesn't seem like
>> zero page handling would affect you too much in that case.
>
> Perhaps I'm missing your point; if a page was zero in the snapshot
> and then gets dirtied, I need to zero it out.

I used "zero page handling" as "a policy on how to deal with zero
pages", similarly to the zero-page-detection option.

The page is being zeroed because it was dirty (on your dirty bitmap) not
because some policy determined that it needs to be zeroed. IOW, it seems
your solution doesn't need to have any knowledge of whether the whole
memory is supposed to be zeroed (as discussed above), the presence of a
dirty bitmap already selects which pages are restored and if there's a 1
for that page in the bitmap, then we don't really care what's in the
file_bmap.

If we implement generic snapshot + mapped-ram + zero page then you could
probably simply OR your dirty bitmap on top of the file_bmap.

Does that makes sense? I might be missing something, I'm looking at a
bunch of threads before going on vacation.

> But yeah, the code will be
> different and for my specific use case I don't absolutely need
> mapped-ram snapshots restore to fully work.
>
> Thank you.
> Best,
> Marco

