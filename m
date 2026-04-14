Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9A8F9D0E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCh7z-0002Ji-T1; Tue, 14 Apr 2026 13:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCh7s-0002Hm-0z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCh7o-0008Km-Mo
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776186030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dmNZStiAPffiAKXW2kyU+YqFcRubclS7+Uy/xspFGo=;
 b=bOSiFJsqJqnGQJt9x6jSQtRFRS99OjX41alb+5KOpnRRoFQz3cytxSfbuliNFQJE6QOJqK
 dUUoy+H1b1D+s7lRjOJAsWmQ/UBUIdf7RnAFIFt0U4Bi1eGERoiS2p/UtUV419lBgH/eJ3
 oP91tIoRUHWwkQdLm8kGPVUsUHCxvgc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-Ky-h0rkLMaeqf-QpFoQOMQ-1; Tue,
 14 Apr 2026 13:00:27 -0400
X-MC-Unique: Ky-h0rkLMaeqf-QpFoQOMQ-1
X-Mimecast-MFC-AGG-ID: Ky-h0rkLMaeqf-QpFoQOMQ_1776186025
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70A151956094; Tue, 14 Apr 2026 17:00:25 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4F3030001BE; Tue, 14 Apr 2026 17:00:23 +0000 (UTC)
Date: Tue, 14 Apr 2026 18:00:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Cathy Hu <cathy.hu@suse.com>, qemu-devel@nongnu.org,
 Cathy Hu <cahu@suse.de>, Fabiano Rosas <fabiano.rosas@suse.com>,
 KVM Bugs <kvm-bugs@suse.de>
Subject: Re: [PATCH RFC] qga: Add selinux-helper for guest-exec subcommand
 (bsc#1237450)
Message-ID: <ad5ypLQMlHQm6ATh@redhat.com>
References: <20260327102515.502822-5-cathy.hu@suse.com>
 <acaVRtE-NPUa5Ujy@redhat.com>
 <3d54a532eb5b3111d8f8849458a009493d3d8845.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d54a532eb5b3111d8f8849458a009493d3d8845.camel@suse.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 14, 2026 at 06:51:12PM +0200, Martin Wilck wrote:
> On Fri, 2026-03-27 at 14:33 +0000, Daniel P. Berrangé wrote:
> > On Fri, Mar 27, 2026 at 11:25:19AM +0100, Cathy Hu wrote:
> > > From: Cathy Hu <cahu@suse.de>
> > > 
> > > Problem:
> > > 
> > > ATM the QEMU Guest Agent and SELinux are not working together
> > > properly.
> > > The fedora (and therefor also the openSUSE) policy confine the
> > > qemu-guest-agent
> > > service in the domain `qemu_ga_t`. That means, qemu-guest-agent
> > > is only allowed to do what the policy says.
> > > 
> > > However, the `guest-exec` command allows arbitrary execution
> > > of code from a privileged service, which conflicts with the
> > > notion of SELinux confinement.
> > > 
> > > ATM, the policy allows only some accesses that are used
> > > by other qemu-guest-agent commands.
> > > That means, the qemu-guest-agent fails sporadically, depending
> > > on what is allowed for other commands.
> > > However, `guest-exec` would need to allow everything.
> > > 
> > > see https://bugzilla.suse.com/show_bug.cgi?id=1237450
> > > 
> > > Solution:
> > > 
> > > This is not an great solution, but it works like this:
> > > We add a "wrapper" which is executed instead of the program
> > > that is called via `guest-exec`. The "wrapper" just
> > > re-executes the command given by `guest-exec`.
> > > This way, on the SELinux policy side we can give that
> > > wrapper executable a label on the file system.
> > > With that label, we can transition into a more broader
> > > unconfined domain _and_ toggle that transition with a
> > > SELinux boolean. That would make `guest-exec`
> > > consistently allowed to execute or not by policy.
> > > 
> > > This needs a change on the SELinux policy side to
> > > accompany this with:
> > > https://github.com/fedora-selinux/selinux-policy/pull/3122
> > > 
> > > What other options have been tried unsuccessfully:
> > > 
> > > - Fixing via SELinux policy: It is not possible for
> > >   one domain to have different permissions depending on
> > >   code path. It is also not possible to toggle the permissive
> > >   state via a SELinux boolean, so users would need
> > >   to add it via semanage.
> > > - Setting the domain of the executed commands directly
> > >   to a broader domain with setcon/setexeccon.
> > >   The SELinux kernel does not allow to spawn a process
> > >   directly with those that has broader privileges than the parent.
> > > 
> > > What other options are there to solve this issue:
> > > 
> > > - Making the qemu-guest-agent unconfined by default
> > > - Document the workaround to use semanage to make the domain
> > > permissive
> > >   if `exec-guest` is needed as works as intended and ignore the
> > > problem
> > 
> > IMHO, the 'exec' command should never have been added to the
> > QEMU guest agent, for precisely this reason that it makes it
> > impractical to put any meaningful security controls around it.
> > Likewise the commands which allow arbitrary file read/write.
> > 
> > QEMU guest agent should focus on specific targetted tasks
> > with dedicated commands.
> > 
> > NB: in RHEL we disable all those unconfinable commands.
> 
> Downstream bug reporter here. My use case, for which Cathy has come up
> with the solution proposed, was to be able to run the ansible libvirt
> connection plugin to connect to a freshly installed VM before sshd was
> actually configured on the VM, or on a VM that didn't allow ssh access
> at all.
> 
> My thinking was that the access control was done by libvirt in this
> case. The user running ansible would either need to have access to
> qemu:///system, or to some remote libvirt server via libvirt's access
> controls (in my case, ssh). Users with this permission level would be
> able to pause, hard-reset, or destroy the VM in question, so I was
> thinking that being able to execute arbitrary commands inside the VM
> was not that problematic. But I may be overlooking something, of
> course.

Yes, with traditional virtualization, if you have privileged
access to the host OS, then the guest has no real protection.

None the less in very many scenarios, the VM user broadly
considers the hypervisor admin to be untrusted. Even if the
technology can't enforce protection against a host admin,
the guest doesn't have to open the front door and welcome
them in by opening "guest-exec" command.

With confidential virtualization, the host OS is generally 
not supposed to have any unsecured access to the guest. For
this the intent is to disable the majority of guest agent
commands which would compromise guest confidentiality
by the host.


> > If users want to support an ability to have arbitrary command
> > execution, then that should be done with SSH over VSock, where
> > the guest owner can choose whether to require authentication
> > first or not, and use SSH authorized_keys if desired to limit
> > what commands can be run for a given recorded key.
> > 
> > These days systemd installs magic to allow SSH'ing directly
> > to a guest using VSOCK addresses, and libvirt further
> > enhances that to allow SSH'ing to a named VM.
> 
> Thanks, I wasn't aware of this feature so far. I suppose you're
> referring to https://libvirt.org/ssh-proxy.html. I'll need to
> experiment with it. IIUC this works for local libvirt connections only?

Yes, vsock is exposed to the local host.

> If that's the case, it wouldn't be a full replacement for qemu-agent
> based access, which I've found to be particularly handy for remote
> libvirt instances.

Since libvirt doesn't expose guest-execu either, I presume you're
referring to libvirt's support for agent command passthrough.

One alternative for off-node secure access is to use SSH + socat
to access the vsock channel.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


