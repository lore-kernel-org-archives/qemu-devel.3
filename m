Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E94BEA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpokQ-0004ap-Is; Tue, 10 Feb 2026 09:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vpokO-0004Yv-Jj
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:29:48 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vpokN-0006Hc-0G
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:29:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98D5F3E716;
 Tue, 10 Feb 2026 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770733785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnSQjR7mM1hhH5xrvhdRkS2zHoHfzREYpbu/R8Fkh7U=;
 b=cFi5dpY1mB/ptuFd+sfOI8PhvTSxSHt8drKSCJv8W2sCME+8o0vflWzed1gQt5oiBhT0ft
 JiugCDJR1H2i5KvA3Yt5n0PHqjcPwHKsFKEZghlyemhVJnow7ex4TfMbwYiRgGy3Eq4CX8
 enjteIF/QF9lu1vyjPUx4z7C0prVYU4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770733785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnSQjR7mM1hhH5xrvhdRkS2zHoHfzREYpbu/R8Fkh7U=;
 b=cFi5dpY1mB/ptuFd+sfOI8PhvTSxSHt8drKSCJv8W2sCME+8o0vflWzed1gQt5oiBhT0ft
 JiugCDJR1H2i5KvA3Yt5n0PHqjcPwHKsFKEZghlyemhVJnow7ex4TfMbwYiRgGy3Eq4CX8
 enjteIF/QF9lu1vyjPUx4z7C0prVYU4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 526763EA62;
 Tue, 10 Feb 2026 14:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7P0CE9lAi2nLCgAAD6G6ig
 (envelope-from <mwilck@suse.com>); Tue, 10 Feb 2026 14:29:45 +0000
Message-ID: <a6ba29d816211fa689798ed2f133d0f40c27d37c.camel@suse.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
From: Martin Wilck <mwilck@suse.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, Paolo
 Bonzini	 <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, 	afaria@redhat.com, qemu-devel@nongnu.org, Mikulas
 Patocka <mpatocka@redhat.com>
Date: Tue, 10 Feb 2026 15:29:43 +0100
In-Reply-To: <20260210135931.GA90664@fedora>
References: <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com> <20260205133930.GA36872@fedora>
 <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
 <20260206140809.GA68769@fedora>
 <ba99c16a-f621-49a7-bab4-c262a4f2a2e8@suse.de>
 <20260209142306.GA24854@fedora>
 <cd9c02195bcda43c4ac992c17a2a1de5d51102e7.camel@suse.com>
 <20260210135931.GA90664@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=mwilck@suse.com;
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

On Tue, 2026-02-10 at 08:59 -0500, Stefan Hajnoczi wrote:
> On Tue, Feb 10, 2026 at 11:23:51AM +0100, Martin Wilck wrote:
> > On Mon, 2026-02-09 at 09:23 -0500, Stefan Hajnoczi wrote:
> > > On Mon, Feb 09, 2026 at 01:50:00PM +0100, Hannes Reinecke wrote:
> > > >=20
> > > > My concern with opening the block device with BLK_OPEN_WRITE is
> > > > that
> > > > this will trigger udev to 'synthesize' (ie regenerate) an 'add'
> > > > event
> > > > on close, causing 'interesting' effects as this will cascade
> > > > down
> > > > through the udev rule chain, triggering blkid, partition scan,
> > > > you
> > > > name it.
> > > > Horrible, horrible, horrible.
> > > > Don't do it.
> > > >=20
> > > > Especially not as you are only interested in reading
> > > > information,
> > > > and not changing the disk state in any way.
> > >=20
> > > I see. I will send patches to change blkdev_pr_read_keys()
> > > blkdev_pr_read_reservation() to require only BLK_OPEN_READ.
> >=20
> > Hm, but then if you need to make an actual reservation and call
> > e.g.
> > blkdev_pr_reserve(), you'll need to re-open the device r/w, and
> > have
> > the same problem. I'm not sure I understand the issue here ...
> > doesn't
> > your process have an open fd to the device in question anyway? You
> > just
> > need to be sure not to _close_ it, as that's what causes the
> > uevents
> > (udev uses an IN_CLOSE_WRITE inotify(7) event on the device node).
>=20
> Shell scripts are the most exposed to this issue because they invoke
> blkpr(8) anew each time instead of keeping the fd open between
> reading
> reservation details and performing a reservation operation.

Right. We shouldn't do that. If we find we have to, we _must_ remove
the "watch" udev property from the devices in question.

Martin

