Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F711606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bzfwAcJg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTkpg-0004aT-Gd; Wed, 18 Nov 2026 13:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xTkpa-0004Zi-LZ
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:56:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xTkpY-00063G-Da
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795028187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jThveY4S67zZMJYBqJwOqJDhHbaSY9Uh6r7FQJNwRgE=;
 b=bzfwAcJgjItrgvCIox4S8lXRuDhj/Wkm+Y3i5jstOKSf/IBxcQVwQkjGuvL6eYBsoMBNrf
 kixmUQoqHbXDO9wPwMZLjeQRVCTgJtQFFUzw5o+RuY3IWbo6200YPgut0dbZ7yO8tS0J9t
 SSGYOaZKRxuQtsvTot43Tqy1HmOqXzc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-hocwnYeXON2JG5EJngCybQ-1; Wed,
 18 Nov 2026 13:56:22 -0500
X-MC-Unique: hocwnYeXON2JG5EJngCybQ-1
X-Mimecast-MFC-AGG-ID: hocwnYeXON2JG5EJngCybQ_1795028181
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA9681956042; Wed, 18 Nov 2026 18:56:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EABE21956042; Wed, 18 Nov 2026 18:56:18 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:56:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: John Maguire <jmaguire2013@gmail.com>, f.ebner@proxmox.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, t.lamprecht@proxmox.com
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Message-ID: <20261118185617.GA670091@shajnocz.csb>
References: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
 <3069e3f8-2cbf-436f-bf35-303fc90001ce@kernel.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3069e3f8-2cbf-436f-bf35-303fc90001ce@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 08:58:11AM -0700, Jens Axboe wrote:
> On 11/15/26 4:05 PM, John Maguire wrote:
> > On Tue, Jun 02, 2026, Stefan Hajnoczi wrote:
> >> Pinging Jens: io_uring accounts POLL_ADD SQEs as blocking I/O activity
> >> whereas select(2)/poll(2)/epoll_wait(2) do not. Would it make sense to
> >> follow the same accounting as the syscalls for this operation since that
> >> is probably expected?
> > 
> > Hello,
> > 
> > I run Incus on two hosts and see misleading iowait and IO pressure on
> > both since Incus 7.6, which puts virtio disks on a dedicated iothread by
> > default. Incus users now hit this without opting into iothreads.
> > 
> > Host 1: Arch Linux, stock QEMU 11.1.3, kernel 6.18.62, 16 CPUs, five
> > VMs. /proc/pressure/io shows about 80% "some" and 75% "full", with
> > 20-30% iowait. The disks are lightly loaded (under 15% util), there are
> > no D-state tasks, the pressure is confined to the cgroup holding the
> > QEMU processes, and each QEMU process has one thread in io_cqring_wait.
> > It started the day I upgraded from Incus 7.5.1 to 7.6; QEMU 11.1.x had
> > been in use on this host since late September without it.
> > 
> > Host 2: Debian 13, kernel 6.12.116, 56 CPUs, four VMs, Zabbly's Incus
> > packages. These bundle QEMU 11.1.3 with the pve-qemu patch
> > "fdmon-io_uring: avoid idle event loop being accounted as IO wait".
> > Pressure is about 68% "some" and 65% "full" with disks under 1% util,
> > and again one thread per QEMU process in io_cqring_wait. This kernel
> > does not advertise IORING_FEAT_NO_IOWAIT (added in 6.15), so the patch
> > has no effect there.
> > 
> > So the downstream patch only helps on 6.15+ kernels, and distros
> > shipping unpatched QEMU get these numbers by default.
> > 
> > Is there a preferred way forward? Fiona offered to submit the Proxmox
> > workaround to qemu-devel, and Stefan asked whether io_uring should
> > instead account POLL_ADD the way poll(2) does. Either would fix this
> > for users on distro packages.
> 
> We can just queue up the patches for stable so they bubble back to
> older versions, I think that's the cleanest approach and gets us
> a unified interface across supported kernel versions.

Fiona: On the QEMU side, please submit the QEMU IORING_FEAT_NO_IOWAIT
patch upstream and let's merge it on qemu.git/master and
qemu.git/stable. Given that the kernel feature is available, QEMU might
as well use it.

Jens: I still think io_uring operations should perform accounting inside
the kernel the same way as the equivalent syscalls do (e.g. poll(2) does
not count as iowait).

Pushing the responsibility of deciding what counts as iowait to
userspace via IORING_FEAT_NO_IOWAIT means the decision is duplicated in
every application that uses io_uring. That only makes sense to me if
accounting should work differently on a per-application basis and
applications therefore need full control. I'm not aware of applications
actually wanting to do that? Or is iowait fundamentally incompatible
with io_uring so that applications are the only ones who can decide?

Stefan


