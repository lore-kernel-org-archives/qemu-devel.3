Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F31F9D0E7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCgyv-0007GR-Gv; Tue, 14 Apr 2026 12:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1wCgyt-0007DF-Rb
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:51:19 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1wCgyr-000648-JA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:51:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FDB95BE1D;
 Tue, 14 Apr 2026 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1776185473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lX/0w9YP/DqUSMVQKYBI6gVtw0w+IriCgUYJkQMZhC4=;
 b=OlBnJzyZvmp3UPVSUQsyusZ9pEPL2ajzr9byn8pu9Vl4kB2whopRvw+nwNCRukl8c1nUkm
 EvjtOeC0oP6ILGHU/Dp+x5TEnHqPhtLt+y8CX/5rf/BjOzdo3op5gB8Ak9nxYJl8/TcASf
 mZHekjdFcGTOpfN9TFF4WX4oC3yngiU=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=OlBnJzyZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1776185473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lX/0w9YP/DqUSMVQKYBI6gVtw0w+IriCgUYJkQMZhC4=;
 b=OlBnJzyZvmp3UPVSUQsyusZ9pEPL2ajzr9byn8pu9Vl4kB2whopRvw+nwNCRukl8c1nUkm
 EvjtOeC0oP6ILGHU/Dp+x5TEnHqPhtLt+y8CX/5rf/BjOzdo3op5gB8Ak9nxYJl8/TcASf
 mZHekjdFcGTOpfN9TFF4WX4oC3yngiU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2716C4B549;
 Tue, 14 Apr 2026 16:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XVNrCIFw3mm5CwAAD6G6ig
 (envelope-from <mwilck@suse.com>); Tue, 14 Apr 2026 16:51:13 +0000
Message-ID: <3d54a532eb5b3111d8f8849458a009493d3d8845.camel@suse.com>
Subject: Re: [PATCH RFC] qga: Add selinux-helper for guest-exec subcommand
 (bsc#1237450)
From: Martin Wilck <mwilck@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Cathy Hu
 <cathy.hu@suse.com>
Cc: qemu-devel@nongnu.org, Cathy Hu <cahu@suse.de>, Fabiano Rosas
 <fabiano.rosas@suse.com>, KVM Bugs <kvm-bugs@suse.de>
Date: Tue, 14 Apr 2026 18:51:12 +0200
In-Reply-To: <acaVRtE-NPUa5Ujy@redhat.com>
References: <20260327102515.502822-5-cathy.hu@suse.com>
 <acaVRtE-NPUa5Ujy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[libvirt.org:url,suse.de:email,suse.com:dkim,suse.com:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 4FDB95BE1D
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=mwilck@suse.com; helo=smtp-out2.suse.de
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

On Fri, 2026-03-27 at 14:33 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 27, 2026 at 11:25:19AM +0100, Cathy Hu wrote:
> > From: Cathy Hu <cahu@suse.de>
> >=20
> > Problem:
> >=20
> > ATM the QEMU Guest Agent and SELinux are not working together
> > properly.
> > The fedora (and therefor also the openSUSE) policy confine the
> > qemu-guest-agent
> > service in the domain `qemu_ga_t`. That means, qemu-guest-agent
> > is only allowed to do what the policy says.
> >=20
> > However, the `guest-exec` command allows arbitrary execution
> > of code from a privileged service, which conflicts with the
> > notion of SELinux confinement.
> >=20
> > ATM, the policy allows only some accesses that are used
> > by other qemu-guest-agent commands.
> > That means, the qemu-guest-agent fails sporadically, depending
> > on what is allowed for other commands.
> > However, `guest-exec` would need to allow everything.
> >=20
> > see https://bugzilla.suse.com/show_bug.cgi?id=3D1237450
> >=20
> > Solution:
> >=20
> > This is not an great solution, but it works like this:
> > We add a "wrapper" which is executed instead of the program
> > that is called via `guest-exec`. The "wrapper" just
> > re-executes the command given by `guest-exec`.
> > This way, on the SELinux policy side we can give that
> > wrapper executable a label on the file system.
> > With that label, we can transition into a more broader
> > unconfined domain _and_ toggle that transition with a
> > SELinux boolean. That would make `guest-exec`
> > consistently allowed to execute or not by policy.
> >=20
> > This needs a change on the SELinux policy side to
> > accompany this with:
> > https://github.com/fedora-selinux/selinux-policy/pull/3122
> >=20
> > What other options have been tried unsuccessfully:
> >=20
> > - Fixing via SELinux policy: It is not possible for
> > =C2=A0 one domain to have different permissions depending on
> > =C2=A0 code path. It is also not possible to toggle the permissive
> > =C2=A0 state via a SELinux boolean, so users would need
> > =C2=A0 to add it via semanage.
> > - Setting the domain of the executed commands directly
> > =C2=A0 to a broader domain with setcon/setexeccon.
> > =C2=A0 The SELinux kernel does not allow to spawn a process
> > =C2=A0 directly with those that has broader privileges than the parent.
> >=20
> > What other options are there to solve this issue:
> >=20
> > - Making the qemu-guest-agent unconfined by default
> > - Document the workaround to use semanage to make the domain
> > permissive
> > =C2=A0 if `exec-guest` is needed as works as intended and ignore the
> > problem
>=20
> IMHO, the 'exec' command should never have been added to the
> QEMU guest agent, for precisely this reason that it makes it
> impractical to put any meaningful security controls around it.
> Likewise the commands which allow arbitrary file read/write.
>=20
> QEMU guest agent should focus on specific targetted tasks
> with dedicated commands.
>=20
> NB: in RHEL we disable all those unconfinable commands.
>=20

Downstream bug reporter here. My use case, for which Cathy has come up
with the solution proposed, was to be able to run the ansible libvirt
connection plugin to connect to a freshly installed VM before sshd was
actually configured on the VM, or on a VM that didn't allow ssh access
at all.

My thinking was that the access control was done by libvirt in this
case. The user running ansible would either need to have access to
qemu:///system, or to some remote libvirt server via libvirt's access
controls (in my case, ssh). Users with this permission level would be
able to pause, hard-reset, or destroy the VM in question, so I was
thinking that being able to execute arbitrary commands inside the VM
was not that problematic. But I may be overlooking something, of
course.

> If users want to support an ability to have arbitrary command
> execution, then that should be done with SSH over VSock, where
> the guest owner can choose whether to require authentication
> first or not, and use SSH authorized_keys if desired to limit
> what commands can be run for a given recorded key.
>=20
> These days systemd installs magic to allow SSH'ing directly
> to a guest using VSOCK addresses, and libvirt further
> enhances that to allow SSH'ing to a named VM.

Thanks, I wasn't aware of this feature so far. I suppose you're
referring to https://libvirt.org/ssh-proxy.html. I'll need to
experiment with it. IIUC this works for local libvirt connections only?
If that's the case, it wouldn't be a full replacement for qemu-agent
based access, which I've found to be particularly handy for remote
libvirt instances.

Regards,
Martin

