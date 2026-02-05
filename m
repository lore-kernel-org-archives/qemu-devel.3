Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD819EC1EA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 12:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vny3Q-00028q-IZ; Thu, 05 Feb 2026 07:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vny3C-00024P-Cf
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 07:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vny36-0004BU-1J
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 07:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770292886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4NkvEx68+Af9BzbdJjYdWePgDjLrhQMsVisBCapUjKE=;
 b=bevp93mLHIRuc8KgkEMM/EPc6fXzQUuW+N5ARBxNUGtI+Xaazo+e8sJBwOsrykp1TKGS+L
 /sdUuB0FpQBeVXHwiinckucf6NHDk3kj5SvyaU3T3TcqhSYS6e2WJ86Rm9M5Ufhp2/59PK
 mOqi0jyaBtPIQ1RtxlxNy8bV+RWC/xA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-PvkjUiOsOVe-3WB3qHGbKQ-1; Thu,
 05 Feb 2026 07:01:22 -0500
X-MC-Unique: PvkjUiOsOVe-3WB3qHGbKQ-1
X-Mimecast-MFC-AGG-ID: PvkjUiOsOVe-3WB3qHGbKQ_1770292882
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F5BA1800282; Thu,  5 Feb 2026 12:01:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9031B300DDA1; Thu,  5 Feb 2026 12:01:17 +0000 (UTC)
Date: Thu, 5 Feb 2026 12:01:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <aYSGia2Zy_g5iop5@redhat.com>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 05, 2026 at 12:52:33PM +0100, Martin Wilck wrote:
> On Wed, 2026-02-04 at 13:32 -0500, Stefan Hajnoczi wrote:
> > On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> > > Hi Stefan,
> > > 
> > > So the ioctls will pass through qemu into the kernel, to be
> > > intercepted
> > > by the dm-mpath driver, which will use an upcall to have them
> > > handled
> > > by mpathpersistd (for the actual command) and multipathd (for the
> > > path
> > > registrations).
> > > 
> > > I don't fully understand the advantage, security and complexity-
> > > wise,
> > > of this concept, compared to intercepting them qemu and using a
> > > socket
> > > to talk to mpathpersistd directly. If we did this, we could even
> > > support both generic and SCSI PR commands.
> > 
> > Hi Martin,
> > The simplification and security benefits are on the application side,
> > not on the DM-Multipath side, so I can see what you're getting at.
> > From
> > the DM-Multipath perspective things get a little more complex.
> > 
> > From an application perspective, a single API that works across block
> > device types (SCSI, NVMe, DM-Multipath) and requires no privileges or
> > sockets (they are a pain in container environments) is the most
> > convenient. The <linux/pr.h> ioctl API offers exactly this.
> 
> I may be missing something, but AFAICS the PR ioctls require having a
> block device open for writing, which does either require root
> privileges, or some file descriptor previously opened with privileges
> and forwarded to another, less privileged process. No?

While QEMU is run unprivileged, libvirt will grant QEMU access any block
devices that have been configured for the guest in question. On Linux,
libvirt will create a new /dev tmpfs populated with the allow-list of
device nodes the guest is permitted to access, with suitable file
permissions, ownership & SELinux labels set.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


