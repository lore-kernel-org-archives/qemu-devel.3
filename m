Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1281BEA3F35
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 10:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkuV-0002Fa-Eb; Tue, 10 Feb 2026 05:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vpkuS-0002F4-Om
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 05:23:57 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vpkuR-0005PM-31
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 05:23:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FD5A3E712;
 Tue, 10 Feb 2026 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770719032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EQ8ynGReZDvxMweG6sRVTIl5BmmR31xo7Qex+4He+Y=;
 b=YZxIHC1AJDcZjzLPxZHuNGrqTNnE4sJn9/Se6thvFfqU5Bz7CLjRcJk+6RWSLw/K9hDrk0
 nmz8sr5mJZJEfPrcmHbRUnQPYJpeZSY4dEviT/xFSkeM+j6V+osX14d4OsZSZEjf7cRoVF
 5Eh0SuYyFFKmpIefE2oRGMUl4RC7oGE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770719032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EQ8ynGReZDvxMweG6sRVTIl5BmmR31xo7Qex+4He+Y=;
 b=YZxIHC1AJDcZjzLPxZHuNGrqTNnE4sJn9/Se6thvFfqU5Bz7CLjRcJk+6RWSLw/K9hDrk0
 nmz8sr5mJZJEfPrcmHbRUnQPYJpeZSY4dEviT/xFSkeM+j6V+osX14d4OsZSZEjf7cRoVF
 5Eh0SuYyFFKmpIefE2oRGMUl4RC7oGE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 296683EA62;
 Tue, 10 Feb 2026 10:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b/4CCTgHi2lHKgAAD6G6ig
 (envelope-from <mwilck@suse.com>); Tue, 10 Feb 2026 10:23:52 +0000
Message-ID: <cd9c02195bcda43c4ac992c17a2a1de5d51102e7.camel@suse.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
From: Martin Wilck <mwilck@suse.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, 
 Benjamin Marzinski
 <bmarzins@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com, 
 qemu-devel@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 10 Feb 2026 11:23:51 +0100
In-Reply-To: <20260209142306.GA24854@fedora>
References: <aYI2CAjmHGklh3mi@redhat.com> <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com> <20260205133930.GA36872@fedora>
 <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
 <20260206140809.GA68769@fedora>
 <ba99c16a-f621-49a7-bab4-c262a4f2a2e8@suse.de>
 <20260209142306.GA24854@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.969]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=mwilck@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 2026-02-09 at 09:23 -0500, Stefan Hajnoczi wrote:
> On Mon, Feb 09, 2026 at 01:50:00PM +0100, Hannes Reinecke wrote:
> >=20
> > My concern with opening the block device with BLK_OPEN_WRITE is
> > that
> > this will trigger udev to 'synthesize' (ie regenerate) an 'add'
> > event
> > on close, causing 'interesting' effects as this will cascade down
> > through the udev rule chain, triggering blkid, partition scan, you
> > name it.
> > Horrible, horrible, horrible.
> > Don't do it.
> >=20
> > Especially not as you are only interested in reading information,
> > and not changing the disk state in any way.
>=20
> I see. I will send patches to change blkdev_pr_read_keys()
> blkdev_pr_read_reservation() to require only BLK_OPEN_READ.

Hm, but then if you need to make an actual reservation and call e.g.
blkdev_pr_reserve(), you'll need to re-open the device r/w, and have
the same problem. I'm not sure I understand the issue here ... doesn't
your process have an open fd to the device in question anyway? You just
need to be sure not to _close_ it, as that's what causes the uevents
(udev uses an IN_CLOSE_WRITE inotify(7) event on the device node).

Another option would be to temporarily disable the udev "watch"
property for the device(s) in question.

Regards
Martin

