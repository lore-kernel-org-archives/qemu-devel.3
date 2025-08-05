Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0EC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 15:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujJks-00038E-Ja; Tue, 05 Aug 2025 11:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujJas-000466-Bq
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:28:55 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujJao-0000Gu-Hi
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:28:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F0A81FB91;
 Tue,  5 Aug 2025 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754407722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCecu7K4tLCqiSNDx4T+nzy09pMieWsdNF0gIpDd5uI=;
 b=RXGcdAzeqTCPpWBZ5nt0fPBZtEDdiiSZvpGKh5pUW6OuM2kLJ1969JF0g1+qXDJKoA8lJ7
 7y1BkppqzCzHWen06Wl3lIwZjs28FecbzbLk1WOsV54h4fevksdqKS2dakJvhjAIAMmfRL
 byFw+lIPff+LO9zgs7Wtzum/PE23HDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754407722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCecu7K4tLCqiSNDx4T+nzy09pMieWsdNF0gIpDd5uI=;
 b=wUrbd5Qvc3hSa4eNM33XyYrScHazlfeUwe1DOHLlcAA8wK+JffYNqNfnW2SH6Btk5yUT2+
 pGHEw5w+wuuwwqDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RXGcdAze;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wUrbd5Qv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754407722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCecu7K4tLCqiSNDx4T+nzy09pMieWsdNF0gIpDd5uI=;
 b=RXGcdAzeqTCPpWBZ5nt0fPBZtEDdiiSZvpGKh5pUW6OuM2kLJ1969JF0g1+qXDJKoA8lJ7
 7y1BkppqzCzHWen06Wl3lIwZjs28FecbzbLk1WOsV54h4fevksdqKS2dakJvhjAIAMmfRL
 byFw+lIPff+LO9zgs7Wtzum/PE23HDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754407722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCecu7K4tLCqiSNDx4T+nzy09pMieWsdNF0gIpDd5uI=;
 b=wUrbd5Qvc3hSa4eNM33XyYrScHazlfeUwe1DOHLlcAA8wK+JffYNqNfnW2SH6Btk5yUT2+
 pGHEw5w+wuuwwqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860CE13AA8;
 Tue,  5 Aug 2025 15:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1NEfEikjkmikawAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Aug 2025 15:28:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
In-Reply-To: <aJISp1UvPCwwXyPf@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
 <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
 <87jz3i3n0u.fsf@suse.de> <aJHYSwGXTOF4o00n@redhat.com>
 <87h5yl3mt2.fsf@suse.de> <aJISp1UvPCwwXyPf@redhat.com>
Date: Tue, 05 Aug 2025 12:28:38 -0300
Message-ID: <87a54d3hzt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0F0A81FB91
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Aug 05, 2025 at 10:44:41AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Aug 04, 2025 at 04:27:45PM -0300, Fabiano Rosas wrote:
>> >> Juraj Marcin <jmarcin@redhat.com> writes:
>> >>=20
>> >> > Hi Daniel,
>> >> >
>> >> > On 2025-08-01 18:02, Daniel P. Berrang=C3=A9 wrote:
>> >> >> This is a followup to previously merged patches that claimed to
>> >> >> workaround the gnutls bug impacting migration, but in fact were
>> >> >> essentially non-functional. Juraj Marcin pointed this out, and
>> >> >> this new patch tweaks the workaround to make it actually do
>> >> >> something useful.
>> >> >>=20
>> >> >> Daniel P. Berrang=C3=A9 (2):
>> >> >>   migration: simplify error reporting after channel read
>> >> >>   migration: fix workaround for gnutls thread safety
>> >> >>=20
>> >> >>  crypto/tlssession.c   | 16 ----------------
>> >> >>  migration/qemu-file.c | 22 +++++++++++++++++-----
>> >> >>  2 files changed, 17 insertions(+), 21 deletions(-)
>> >> >>=20
>> >> >
>> >> > thanks for finding a fix for the workaround. I have tested it and it
>> >> > resolves the issue.
>> >> >
>> >> > However, it significantly slows down migration, even with the worka=
round
>> >> > disabled (and thus no locking). When benchmarking, I used the fixed
>> >> > version of GNUTLS, VM with 20GB of RAM which were fully written to
>> >> > before starting a normal migration with no workload during the
>> >> > migration.
>> >> >
>> >> > Test cases:
>> >> > [1]: before this patchset
>> >> > [2]: with this patchset applied and GNUTLS workaround enabled
>> >> > [2]: with this patchset applied and GNUTLS workaround disabled
>> >> >
>> >> >   | Total time | Throughput | Transfered bytes |
>> >> > --+------------+------------+------------------+
>> >> > 1 |  31 192 ms |  5450 mpbs |   21 230 973 763 |
>> >> > 2 |  74 147 ms |  2291 mbps |   21 232 849 066 |
>> >> > 3 |  72 426 ms |  2343 mbps |   21 215 009 392 |
>> >>=20
>> >> Thanks testing this. I had just managed to convince myself that there
>> >> wouldn't be any performance issues.
>> >>=20
>> >> The yield at every buffer fill on the incoming side is probably way m=
ore
>> >> impactful than the poll on the RP.
>> >
>> > Yeah, that's an unacceptable penalty on the incoming side for sure.
>> >
>> > How about we simply change the outbound migration channel to be in
>> > non-blocking mode ?   I originally put it in blocking mode way back
>> > in 9e4d2b98ee98f4cee50d671e500eceeefa751ee0, but if I look at the
>> > QEMUFile impl of qemu_fill_buffer and qemu_fflush, but should be
>> > coping with a non-blocking socket. qemu_fill_buffer has explicit
>> > code to wait, and qemu_fflush uses the _all() variant whcih has
>> > built-in support for waiting. So I'm not seeing an obvious need
>> > to run the channel in blocking mode.
>> >
>>=20
>> It's definitely simpler and I think it works. It's uncomfortably late
>> though to add a bunch of glib event loop code to the migration
>> thread. Is the suggestion of moving the yield to tlssession.c even
>> feasible?
>
> Well that'll remove the burden for the non-TLS incoming migration,
> but the incoming TLS migration will still have the redundant
> yields and so still suffer a hit.
>
> Given where we are in freeze, I'm thinking we should just hard
> disable the workaround for this release, and re-attempt it in
> next cycle and then we can bring it back to stable afterwards.
>

Yes, I agree. Will you send a patch?

> With regards,
> Daniel

