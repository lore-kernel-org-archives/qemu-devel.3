Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2C1EC1EA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxua-0008QO-Mq; Thu, 05 Feb 2026 06:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vnxuY-0008Pf-OV
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:52:38 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vnxuX-000365-5n
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:52:38 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E24CA3E7B4;
 Thu,  5 Feb 2026 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770292355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0lS8wS2dxbf7DNrg4OOYBTfaF9ViQTYdcKz2ShPRug=;
 b=dKl/jNfj7RPzkT3dlZp5Zyg4y7sOhzDD9kwbTGKTMKQYob4FwUBNHALLqXC/Q62lkZQwqo
 GPVSVuvBhVxgPOs3RsCzjHEtVh/MbZZmzrcBpQfBTHnJ7nG3xm2szC/xW6Oj7D3dgM/RPj
 a4XAslTqiln+RBRY6OvqXC9ZiOhHduY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770292354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0lS8wS2dxbf7DNrg4OOYBTfaF9ViQTYdcKz2ShPRug=;
 b=L8qCKsx8b9n5NmWx7B4B/HuvQ14Ur8CzIVsUUMd1HUmaIEM/DlBt596EfDBal0/qjOh/EA
 i93jkGeKHtE6/WUnuTSAqcwe95noytO0xJIQLraZnDby0OQohIdyTwPv24RhZXGF/BqYr/
 v16nztZkvYzzreL7MOl8Xb46Yl3kQIE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A10943EA63;
 Thu,  5 Feb 2026 11:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zUA8JoKEhGmLeAAAD6G6ig
 (envelope-from <mwilck@suse.com>); Thu, 05 Feb 2026 11:52:34 +0000
Message-ID: <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
From: Martin Wilck <mwilck@suse.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>, Paolo Bonzini	
 <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>,  Hannes Reinecke	 <hare@suse.de>, afaria@redhat.com,
 qemu-devel@nongnu.org, Mikulas Patocka	 <mpatocka@redhat.com>
Date: Thu, 05 Feb 2026 12:52:33 +0100
In-Reply-To: <20260204183201.GB610283@fedora>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
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

On Wed, 2026-02-04 at 13:32 -0500, Stefan Hajnoczi wrote:
> On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> > Hi Stefan,
> >=20
> > So the ioctls will pass through qemu into the kernel, to be
> > intercepted
> > by the dm-mpath driver, which will use an upcall to have them
> > handled
> > by mpathpersistd (for the actual command) and multipathd (for the
> > path
> > registrations).
> >=20
> > I don't fully understand the advantage, security and complexity-
> > wise,
> > of this concept, compared to intercepting them qemu and using a
> > socket
> > to talk to mpathpersistd directly. If we did this, we could even
> > support both generic and SCSI PR commands.
>=20
> Hi Martin,
> The simplification and security benefits are on the application side,
> not on the DM-Multipath side, so I can see what you're getting at.
> From
> the DM-Multipath perspective things get a little more complex.
>=20
> From an application perspective, a single API that works across block
> device types (SCSI, NVMe, DM-Multipath) and requires no privileges or
> sockets (they are a pain in container environments) is the most
> convenient. The <linux/pr.h> ioctl API offers exactly this.

I may be missing something, but AFAICS the PR ioctls require having a
block device open for writing, which does either require root
privileges, or some file descriptor previously opened with privileges
and forwarded to another, less privileged process. No?

> Unfortunately, DM-Multipath currently does not fully support
> <linux/pr.h>. It sends PR operations down each path, but that is only
> a
> subset of libmpathpersist's logic and multipathd is not kept in sync.
>=20
> My impression is that libmpathpersist and multipathd logic cannot be
> easily moved into the kernel. This is where the upcall idea comes
> from.
> Let's notify multipath-tools from DM-Multipath so it can do its work
> in
> userspace.

I agree.

> Getting back to the application vs DM-Multipath advantages: I think
> it's
> worth simplifying things for applications because there are many
> applications and only one DM-Multipath.

TBH, I don't see so many applications. Actually I am having trouble
finding any application at all that uses the generic linux PR
functionality. I haven't even found a basic command line tool that
encapsulates the ioctls, are you aware of one? That would be the first
thing we need, be it only for testing the kernel.

As for applications using SCSI/NVMe PRs, I also don't see many, at
least not in the Linux / open source realm. Actually, qemu is the only
one that immediately comes to my mind. I can imagine that storage
management tools for e.g. OpenStack or Kubernetes would want to use
PRs, but I don't know any details.

Wrt sockets, not sure what's so painful about them. multipathd recently
enabled a pathname sockets for qemu-pr-helper in KubeVirt [1].

Thanks,
Martin

[1] https://github.com/opensvc/multipath-tools/issues/111

