Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1492C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHpaM-0007nF-26; Wed, 21 May 2025 15:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmarzins@redhat.com>)
 id 1uHo7W-0004nZ-7B
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmarzins@redhat.com>)
 id 1uHo7Q-00059g-R8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747851882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MtYnxm+R9qr+gg54NUhqzGSSx4sYOYfUwPDWgVozEig=;
 b=S85D1gGas4lgiwhbtoTBs9j04R1ilw5lhywMlWaYMc5flnPHcWwSbKqLiMwoLBKDTUtGPn
 AsJ4gmcMG7lsWIIMZoy0J7bJwRJT9Vpl5gyL8pR4WAfGqFQ5tc2YYqYDL3R2QqQwKESXlk
 YqupOF/1PfFWJzpl28imk2RV66/G4/s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-Hheea976OvOqZ6EOhr0zEg-1; Wed,
 21 May 2025 14:23:32 -0400
X-MC-Unique: Hheea976OvOqZ6EOhr0zEg-1
X-Mimecast-MFC-AGG-ID: Hheea976OvOqZ6EOhr0zEg_1747851811
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0CB71800446; Wed, 21 May 2025 18:23:31 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 with ESMTPS id EACE719560B7; Wed, 21 May 2025 18:23:30 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with
 ESMTPS id 54LINTBo597458
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 14:23:29 -0400
Received: (from bmarzins@localhost)
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id
 54LINTQI597457; Wed, 21 May 2025 14:23:29 -0400
Date: Wed, 21 May 2025 14:23:29 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 hreitz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <aC4aIXX-Ce7ZY8J8@redhat.com>
References: <20250513113730.37404-1-kwolf@redhat.com>
 <20250513135148.GB227327@fedora> <aCWiuYUWiwKJz4_j@redhat.com>
 <20250515140142.GA333399@fedora> <aCYCFrh_As6XuPQj@redhat.com>
 <20250520140339.GC82528@fedora> <aC4Rdt5HWgh7LGjG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC4Rdt5HWgh7LGjG@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=bmarzins@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 May 2025 15:58:39 -0400
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

On Wed, May 21, 2025 at 07:46:30PM +0200, Kevin Wolf wrote:
> Am 20.05.2025 um 16:03 hat Stefan Hajnoczi geschrieben:
> > On Thu, May 15, 2025 at 05:02:46PM +0200, Kevin Wolf wrote:
> > > Am 15.05.2025 um 16:01 hat Stefan Hajnoczi geschrieben:
> > > > On Thu, May 15, 2025 at 10:15:53AM +0200, Kevin Wolf wrote:
> > > > > Am 13.05.2025 um 15:51 hat Stefan Hajnoczi geschrieben:
> > > > > > On Tue, May 13, 2025 at 01:37:30PM +0200, Kevin Wolf wrote:
> > > > > > > When scsi-block is used on a host multipath device, it runs into the
> > > > > > > problem that the kernel dm-mpath doesn't know anything about SCSI or
> > > > > > > SG_IO and therefore can't decide if a SG_IO request returned an error
> > > > > > > and needs to be retried on a different path. Instead of getting working
> > > > > > > failover, an error is returned to scsi-block and handled according to
> > > > > > > the configured error policy. Obviously, this is not what users want,
> > > > > > > they want working failover.
> > > > > > > 
> > > > > > > QEMU can parse the SG_IO result and determine whether this could have
> > > > > > > been a path error, but just retrying the same request could just send it
> > > > > > > to the same failing path again and result in the same error.
> > > > > > > 
> > > > > > > With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> > > > > > > block devices (queued in the device mapper tree for Linux 6.16), we can
> > > > > > > tell the kernel to probe all paths and tell us if any usable paths
> > > > > > > remained. If so, we can now retry the SG_IO ioctl and expect it to be
> > > > > > > sent to a working path.
> > > > > > > 
> > > > > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > > > > ---
> > > > > > >  block/file-posix.c | 82 +++++++++++++++++++++++++++++++++++++++++++++-
> > > > > > >  1 file changed, 81 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > Maybe the probability of retry success would be higher with a delay so
> > > > > > that intermittent issues have time to resolve themselves. Either way,
> > > > > > the patch looks good.
> > > > > 
> > > > > I don't think adding a delay here would be helpful. The point of
> > > > > multipath isn't that you wait until a bad path comes back, but that you
> > > > > just switch to a different path until it is restored.
> > > > 
> > > > That's not what this loop does. DM_MPATH_PROBE_PATHS probes all paths
> > > > and fails when no paths are available. The delay would only apply in the
> > > > case when there are no paths available.
> > > > 
> > > > If the point is not to wait until some path comes back, then why loop at
> > > > all?
> > > 
> > > DM_MPATH_PROBE_PATHS can only send I/O to paths in the active path
> > > group, so it doesn't fail over to different path groups. If there are no
> > > usable paths left in the current path group, but there are some in
> > > another one, then the ioctl returns 0 and the next SG_IO would switch to
> > > a different path group, which may or may not succeed. If it fails, we
> > > have to probe the paths in that group, too.
> > 
> > This wasn't obvious to me, can that be emphasized in the code via naming
> > or comments? About retrying up to 5 times: is the assumption that there
> > will be 5 or fewer path groups?
> 
> Originally, the thought behind the 5 was more about the case where
> DM_MPATH_PROBE_PATHS offlines bad paths, but then another one goes down
> before we retry SG_IO, so that it fails again.
> 
> But you're right that it would now apply to retrying in a different path
> group. The assumption we make would then be that there will be 5 or
> fewer path groups with no working path in them (rather than just 5 of
> them existing). That doesn't seem like a completely unreasonable
> assumption, but maybe we should increase the number now just to be on
> the safe side?
> 
> Ben, do you have an opinion on this?

5 seems like a reasonable number. Unless people have the
path_grouping_policy set to failover, 5 path groups seems like more
than enough. You could make the argument that if users were configured
with failover (one path per path group) or had a number paths marked
marginal (and placed into marginal path groups), you could exceed 5
path groups. 8 would seems like a reasonable maximum then. It is
possible to have multipath devices with over 8 paths, but that's pretty
rare.

-Ben

> 
> Kevin



