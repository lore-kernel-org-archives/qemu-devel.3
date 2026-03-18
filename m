Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E7110775F8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uds-00032d-FX; Wed, 18 Mar 2026 13:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pfalcato@suse.de>) id 1w2udo-0002xt-6L
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:25:08 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pfalcato@suse.de>) id 1w2udj-0002NM-Jc
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:25:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69C254D3C1;
 Wed, 18 Mar 2026 17:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773854700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSahki2wTkP6pm77ebAVfN0yovDIpAL1wSq8vLtJmJY=;
 b=HbB8d4u9ZQOCylAIZ9HYbDSIUqBcQ/K2kbdPA0bqvMYQCqHXlHlqwQWKKP8JEofP2hXLP5
 Ps0kFMGmmD0T9Be0B8BwdQLpjmTvN8KEX+3An0SPPjZFpSe4D80Vl0/RE85ZfYiP+1VBlf
 7kYdAdjiIKJ28K5nZC7btmRNdeWaKao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773854700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSahki2wTkP6pm77ebAVfN0yovDIpAL1wSq8vLtJmJY=;
 b=mXJsuj0VXQzm5ou60PirGnTqycnQ9bBJk18F4soEvD81e5oZhbWPXVJ0xKjm8u65Z933ng
 xvZWfd8qx0GiEZCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HbB8d4u9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mXJsuj0V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773854700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSahki2wTkP6pm77ebAVfN0yovDIpAL1wSq8vLtJmJY=;
 b=HbB8d4u9ZQOCylAIZ9HYbDSIUqBcQ/K2kbdPA0bqvMYQCqHXlHlqwQWKKP8JEofP2hXLP5
 Ps0kFMGmmD0T9Be0B8BwdQLpjmTvN8KEX+3An0SPPjZFpSe4D80Vl0/RE85ZfYiP+1VBlf
 7kYdAdjiIKJ28K5nZC7btmRNdeWaKao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773854700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSahki2wTkP6pm77ebAVfN0yovDIpAL1wSq8vLtJmJY=;
 b=mXJsuj0VXQzm5ou60PirGnTqycnQ9bBJk18F4soEvD81e5oZhbWPXVJ0xKjm8u65Z933ng
 xvZWfd8qx0GiEZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D1D4273B;
 Wed, 18 Mar 2026 17:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8ZNoNOvfumllHwAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Wed, 18 Mar 2026 17:24:59 +0000
Date: Wed, 18 Mar 2026 17:24:58 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] ide: Set IDENTIFY word 93 to 0 on SATA drives
Message-ID: <fifhay3zi37f3gyngcgwhtlbhninwljokrqulwzeyxru6tizfn@eyl2uzcqqc3g>
References: <20260318162951.1060969-1-pfalcato@suse.de>
 <abrY1aC1RjG7P2GR@redhat.com> <abrZsaFWDwnbWbKL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abrZsaFWDwnbWbKL@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 69C254D3C1
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=pfalcato@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 18, 2026 at 04:58:25PM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 18, 2026 at 04:54:45PM +0000, Daniel P. Berrangé wrote:
> > On Wed, Mar 18, 2026 at 04:29:51PM +0000, Pedro Falcato wrote:
> > > According to the ATA Command Set specification (and the SATA specification
> > > too), SATA drives are supposed to set word 93 (which for PATA holds hardware
> > > reset results) to 0. As such, clear it when ncq_queues > 0 (which is only true
> > > for SATA drives).
> > > 
> > > Doing so fixes a quirk in Linux where it thinks the AHCI QEMU drive is PATA
> > > over a SATA bridge, and thus limits maximum transfer sizes for individual IOs
> > > with a:
> > > [    1.632121] ata1.00: applying bridge limits
> > > 
> > > While at it, bump the device's firmware revision for IDENTIFY. This makes it
> > > so Linux can avoid enabling a quirk for fixed QEMU releases.
> > > 
> > > Link: https://lore.kernel.org/linux-ide/20260303183337.1013474-1-pfalcato@suse.de/
> > > Cc: qemu-stable@nongnu.org
> > > Suggsted-by: Niklas Cassel <cassel@kernel.org>
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > > ---
> > > Note: I understand the version bump is vaguely controversial (particularly
> > >  exposing the QEMU version in the string) but I don't have a much better
> > >  idea. Logically, bumping it to 11.0 for stable releases doesn't make much
> > >  sense.
> > 
> > Bumping the version string changes guest ABI, so such a change should
> > normally be tied to a new machine type version, not unconditionally
> > changed.  That would also in turn make it unsuitable for QEMU stable
> > release branches which don't take changes which affect machine type
> > ABI.
> >

I don't understand (I don't usually hack on QEMU). What do you mean with
guest ABI and machine type ABI?
 
> > IMHO Linux should just assume any actively maintained distro that
> > cares about this problem will fix their QEMU releases and not try
> > to add a version specific workaround.

The compromise we reached in Linux was to apply this quirk workaround
*only* for 2.5+ versioned firmware revision. Many stable distributions
out there (e.g debian, enterprise) would not see this QEMU fix for years.
Particularly if it is not QEMU stable material.

> 
> Having said that, possibly the functional fix itself might need to
> be tied to the machine type too, given that it is triggering a
> behavioural change in the emulation and guest driver ? If that's

There is no behavioural change on QEMU's side. QEMU has always been
able to perform IO up to the controller interface's limit. Yes, it does
change Linux's behavior.

> the case, then the version could be changed at the same time.

I was skimming through https://www.qemu.org/docs/master/devel/migration/compatibility.html.
So tying this to the machine type would mean (if I am not mistaken, but do
correct me if I'm wrong) setting the device version (or an equivalent device
property) in hw_compat_10_2 (in our case, since it's the last QEMU release).
Is this correct?

I am OK with this idea, especially since the quirk patch is already
propagating through Linux upstream stable branches. So it should be ok to just
apply this permanent fix for the latest QEMU release.

My only other concern would be how to expose firmware versions in a proper way.
From my reading, it is clear that QEMU does not want to expose versions to
guests. Perhaps some versioning scheme like "2.6.<revision>" or maybe even
"2.5+<revision>" could be maximally backwards compatible whilst not exposing
too much to the guest.

-- 
Pedro

