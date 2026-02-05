Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13278EA794F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnmq-0008Ie-Pq; Wed, 04 Feb 2026 20:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmarzins@redhat.com>)
 id 1vnnmp-0008Hj-Aq
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmarzins@redhat.com>)
 id 1vnnmn-0000JC-Ch
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770253434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqqPkT19X8H1Yhs0EVxQLrcQO1bjE7Rm5Ne4UVl7YbQ=;
 b=e4I644SBIL5DmWLI3cj+3yHbL0tyZXLukNbg3XLB8vdUz672mMSqpXSnkybvuLLEW9xwvc
 UdglFIMSgoK6TW3R4R33qDYWJeikVa2IUzt8pRfrrVRKsTh4nViigyQtbFd9g0C7vq6sJc
 AWn+KIHo6rkYtTWSQtsnBzOzQ9wPuRA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-l3eoC3BtPciYnbzjmdz2bg-1; Wed,
 04 Feb 2026 20:03:53 -0500
X-MC-Unique: l3eoC3BtPciYnbzjmdz2bg-1
X-Mimecast-MFC-AGG-ID: l3eoC3BtPciYnbzjmdz2bg_1770253432
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97BA11956059; Thu,  5 Feb 2026 01:03:51 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 with ESMTPS id AE4F01800465; Thu,  5 Feb 2026 01:03:50 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with
 ESMTPS id 61513nYH785051
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 4 Feb 2026 20:03:49 -0500
Received: (from bmarzins@localhost)
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id
 61513ndd785050; Wed, 4 Feb 2026 20:03:49 -0500
Date: Wed, 4 Feb 2026 20:03:49 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Martin Wilck <mwilck@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com,
 qemu-devel@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <aYPsdWW6ntBq2RFm@redhat.com>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <ff71f35e-06b5-4a82-98ec-8e0419f5ec62@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff71f35e-06b5-4a82-98ec-8e0419f5ec62@suse.de>
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

On Thu, Feb 05, 2026 at 12:57:38AM +0100, Hannes Reinecke wrote:
> On 2/4/26 19:32, Stefan Hajnoczi wrote:
> > On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> > > Hi Stefan,
> > > 
> > > On Tue, 2026-02-03 at 13:04 -0500, Stefan Hajnoczi wrote:
> [ .. ]>>>
> > > > It can be generic. The messages will contain the block device
> > > > major:minor as well as information to describe <linux/pr.h> requests.
> > > 
> > > So the ioctls will pass through qemu into the kernel, to be intercepted
> > > by the dm-mpath driver, which will use an upcall to have them handled
> > > by mpathpersistd (for the actual command) and multipathd (for the path
> > > registrations).
> > > 
> > > I don't fully understand the advantage, security and complexity-wise,
> > > of this concept, compared to intercepting them qemu and using a socket
> > > to talk to mpathpersistd directly. If we did this, we could even
> > > support both generic and SCSI PR commands.
> > 
> > Hi Martin,
> > The simplification and security benefits are on the application side,
> > not on the DM-Multipath side, so I can see what you're getting at. From
> > the DM-Multipath perspective things get a little more complex.
> > 
> >  From an application perspective, a single API that works across block
> > device types (SCSI, NVMe, DM-Multipath) and requires no privileges or
> > sockets (they are a pain in container environments) is the most
> > convenient. The <linux/pr.h> ioctl API offers exactly this.
> > 
> > Unfortunately, DM-Multipath currently does not fully support
> > <linux/pr.h>. It sends PR operations down each path, but that is only a
> > subset of libmpathpersist's logic and multipathd is not kept in sync.
> > 
> > My impression is that libmpathpersist and multipathd logic cannot be
> > easily moved into the kernel. This is where the upcall idea comes from.
> > Let's notify multipath-tools from DM-Multipath so it can do its work in
> > userspace.
> > 
> It _might_ be possible by extending the current path-switching
> code in the kernel to keep track of PRs. The we could move the
> registration upon path switching, and (ideally) could do away
> with upcalls.
> Not sure, though, how targets react when having to deal with a
> flood of PR commands ...
> But maybe worth a try.

Making a multipath device pretend to be single Persistently Reservable
device involves a lot of ugly workarounds that I'm not really excited to
see in the kernel.

For instance, every time a new path appears or a path that was down when
the device was registered comes up, multipath needs to register that
path. But a preempt could come it while it is doing this (or indeed any
time after multipath registered the other paths). So it has to check
the that the registrations are still there on the other paths before
registering the new path, and then check again afterwards to make sure
that there wasn't a preempt during the registration. 

Worse, you can't release a reservation from a path that is down. If
multipath needs to release its reservation, and the path that is holding
it is down, the only solution I could come up with is to suspend the
device so no IO happens. Preempt the reservation to move it to an active
path, which wipes the registrations off all the other paths. Then
reregister the all the active paths again, and unsuspend the device.
The failed paths will get reregistred as they come back up.

And there's more cases like these. They are, of course, just as doable
in the kernel as in userspace, but it's a lot of persistent reservation
code to put into the multipath target.

-Ben
 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


