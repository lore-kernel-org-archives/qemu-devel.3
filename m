Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB80E87852
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 17:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnKaZ-00023L-UT; Tue, 03 Feb 2026 12:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmarzins@redhat.com>)
 id 1vnKaY-00022d-CC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmarzins@redhat.com>)
 id 1vnKaW-00058v-M5
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770141199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sF6AZvE2H4z0vsQbXL9N7TvXRwnD1A7XU2Rs8PhBhPU=;
 b=RWxUDrkXEbcoEaik0Cir2QpDsVb7lqNkz3DhKpqoLSA+pKfdg34rlI2VxAcddYv9P4+ftT
 +/2ECMBGlzEwEn3z79Ur3ARHb2SMhItj1lEJtZzE8nR68rK/2+yJ0gp4ue32MqYG/Rv4WR
 jPohM/79kTy8e15dVRfEf5paiwzJ1LY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-YdynwRxEOp6S41UOmM0onQ-1; Tue,
 03 Feb 2026 12:53:16 -0500
X-MC-Unique: YdynwRxEOp6S41UOmM0onQ-1
X-Mimecast-MFC-AGG-ID: YdynwRxEOp6S41UOmM0onQ_1770141195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCFB719560B5; Tue,  3 Feb 2026 17:53:14 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 with ESMTPS id 518FC180094B; Tue,  3 Feb 2026 17:53:13 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with
 ESMTPS id 613HrC09735221
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 3 Feb 2026 12:53:12 -0500
Received: (from bmarzins@localhost)
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id
 613HrCis735220; Tue, 3 Feb 2026 12:53:12 -0500
Date: Tue, 3 Feb 2026 12:53:12 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>, Martin Wilck <mwilck@suse.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <aYI2CAjmHGklh3mi@redhat.com>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203150939.GB445116@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=bmarzins@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 03, 2026 at 10:09:39AM -0500, Stefan Hajnoczi wrote:
> On Tue, Jan 27, 2026 at 04:06:03PM -0500, Benjamin Marzinski wrote:
> > On Tue, Jan 27, 2026 at 01:47:43PM -0500, Stefan Hajnoczi wrote:
> > > Hi Benjamin and Paolo,
> > > I would like to discuss changes to DM-Multipath and qemu-pr-helper to
> > > handle SCSI Persistent Reservations in QEMU without privileged code.
> > > 
> > > SCSI Persistent Reservations support in QEMU is built on the
> > > qemu-pr-helper daemon that performs PERSISTENT RESERVATION IN and
> > > PERSISTENT RESERVATION OUT commands on behalf of the guest. The
> > > qemu-pr-helper process provides privilege separation for ioctl(SG_IO)'s
> > > CAP_SYS_RAWIO and libmpathpersist's root privileges since the main QEMU
> > > process should not have those privileges.
> > > 
> > > There are issues with the current approach:
> > > - Privileged code is a security attack surface.
> > > - A bunch of code is required for privilege separation and for management
> > >   tools to set up qemu-pr-helper with access to multipathd.
> > > - The interface is SCSI-specific and does not support NVMe.
> > > 
> > > Several of us have pondered a different approach that I will summarize
> > > here. The <linux/pr.h> ioctl interface provides an alternative to
> > > ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
> > > SCSI and NVMe. Since privileges are not required, there would be no need
> > > for the qemu-pr-helper daemon anymore.
> > > 
> > > The blocker is that <linux/pr.h> is not usable in multipath
> > > environments. The Linux DM-Multipath driver has an incomplete ioctl
> > > implementation that falls short of what libmpathpersist and multipathd
> > > do in userspace. Kernel changes are necessary to fix this.
> > > 
> > > My suggestion is to implement <linux/pr.h> via upcalls from DM-Multipath
> > > to multipathd. That way applications like QEMU can consistently use
> > > <linux/pr.h> across block device types and no longer have to go through
> > > the privileged libmpathpersist interface.
> > 
> > This would take intercepting the pr commands to multipath devices right
> > at the start of dm_call_pr(). In order to make some persistent
> > reservation commands seem atomic, libmpathpersist needs to suspend the
> > multipath device in certain situations. So device-mapper cannot call
> > dm_get_live_table(), since this will block suspends. This should be o.k.
> > Libmpathpersist is designed to handle the possiblity that the multipath
> > device gets reloaded with different paths while it is running. And since
> > the multipath target is an immutable singleton target, there is no
> > possibility of it turning into another target type because of a table
> > reload during suspend.
> > 
> > Also, just to clarify, the kernel code can't interface directly with
> > multipathd. Most of the code for handling persistent reservations is in
> > libmpathpersist, which just needs multipathd to do things like make sure
> > that paths that are added in the furture get registered properly. There
> > would likely need to be some new program (that is just a thin wrapper
> > around libmpathpersist) which can be called with call_usermodehelper().

Adding Martin Wilck, since he will also be looking at these changes.
 
> Hi everyone,
> I'm starting to work on the DM-Multipath changes. Some more details on
> how I am approaching this:
> 
> - multipath-tools will create multipath device-mapper targets with a new
>   ctr argument (pr_netlink) when this feature is enabled. When the
>   feature is disabled, everything remains backwards compatible. With the
>   pr_netlink ctr argument, the multipath target sends a netlink
>   multicast group notification instead of handling PR operations (e.g.
>   IOC_PR_* ioctls) in the kernel.
> 
> - There will be a new program in multipath-tools called mpathpersistd
>   that listens on the netlink multicast group for notifications. The
>   notification tells it which multipath device has a pending PR
>   operation. It fetches the PR operation parameters by sending a netlink
>   message, performs the persistent reservation operation via
>   libmpathpersist, and then sends a response to the kernel via another
>   netlink message.
> 
> - The multipath device-mapper target completes the PR operation upon
>   receiving the netlink response.
> 
> I ended up choosing netlink because call_usermodehelper() seems less
> appropriate for an operation triggered by untrusted userspace processes.
> 
> Your input is welcome. Let me know if a different approach would be
> better.

Is the netlink interface going to be a generic persistent reservation
upcall interface, or it this just for dm multipath? I'm not sure if
there would ever be another user, and I don't have enough experience
with the netlink code to know how ugly it might be to route
communications from different kernel drivers to different userspace
daemons through the same generic netlink family. But if there's not
much extra complexity in building a generic interface, it seems like
it would be preferable to a multipath specific one.

-Ben

> Thanks,
> Stefan



