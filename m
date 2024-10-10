Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508A5D2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz0WG-0005xl-Vq; Thu, 10 Oct 2024 17:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sz0WF-0005xU-Oa
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sz0WD-0001Us-RH
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728594980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzl15d/ADcaC+xsZyGNHMlXFFQmoJJYCAEz8nBqVQA8=;
 b=R7ziQqRt+IW96Bubf66b4HxMa7Kxt5t0MAMGmG4XIk2DO/n5ajc+VECZnBHP9iWZIiKLQV
 kKF7NoXkCRQ0xK1DfvXObo7TVQIQa5O1vvoDpHRWpTIFNSfIHlZFAg5AhezJa6VzJDaB2x
 J7/6Z9s1GyOEpihCVLM7bTuG6iYhDuQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-WLmxWamsPIOEX-R0MlPoEA-1; Thu, 10 Oct 2024 17:16:16 -0400
X-MC-Unique: WLmxWamsPIOEX-R0MlPoEA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4604b3ef225so2906181cf.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728594976; x=1729199776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzl15d/ADcaC+xsZyGNHMlXFFQmoJJYCAEz8nBqVQA8=;
 b=GZp5KaFbfZMCdEcYTLFj0joQdSnKJ4QrzrOIAwa57F9GSpGEBx/2mx47jhBek5xNuE
 +McCFNclDPEjewVIo73chUClExkWNQX7L/pYk0KnjVZk5pNEGZ4uQxi7DrJXQFUvlSrU
 gc6LCbTvunKKLksTiutDlfBrmq/KxB2Fm+M2zBgTjJXi2SnfBqVPkiO2MMyuM9pm+Hrr
 fBCj0BmbHRcidgons2VdK7zsCUaWpouv/fgrIKGBQT8IUX1yyS1sfrWwREQZUboTyn+o
 ap89OtPzySyYRZTwf2oivhfPOCXVy0D7Eoghc451yb5aj5ld1RVNd62wp/C8ioWuFEBy
 I3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6UT/luqnn1xdZlN0q12zOKsKLIRMkemYs/4ZJUkqiA8PNj6IeY+Bx1P1iorEyN4d4o6f9+hoet0mn@nongnu.org
X-Gm-Message-State: AOJu0Yx0vlYZeeXFsxDdXJviDSsQ01Edq14S6EQoGQHF3qn5NyySkJeN
 onjlSXoeGE9je08EGMH0qbelWAPwroq29Yx22VzmW8mm9b91zunehx9gU/+J6XUm0IMpw9elRG7
 RwSu6To2Ce93GTNcfpgQBku7GNsiOZ+91Ig2s02Y4P0oDEMivaABx
X-Received: by 2002:ac8:5f4c:0:b0:458:51ea:e36b with SMTP id
 d75a77b69052e-4604bba3299mr4553531cf.5.1728594975887; 
 Thu, 10 Oct 2024 14:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYq9K1c10eIBjIHbyp69UMfm+/dIg9whS/1tcxg+8f9vG91AQ42uYMMwTQC+L3vABcGx2bWA==
X-Received: by 2002:ac8:5f4c:0:b0:458:51ea:e36b with SMTP id
 d75a77b69052e-4604bba3299mr4553201cf.5.1728594975480; 
 Thu, 10 Oct 2024 14:16:15 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460427d5398sm9003431cf.23.2024.10.10.14.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 14:16:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:16:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Subject: Re: precreate phase
Message-ID: <ZwhEG40a5AXW23KI@x1n>
References: <b57f8eda-d0ec-469f-8ac2-635f3c8d238b@oracle.com>
 <877cafsmuz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cafsmuz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Thu, Oct 10, 2024 at 05:51:16PM -0300, Fabiano Rosas wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
> > Peter, Fabiano,
> >
> > I have a nice solution that allows dest qemu configuration with cpr-transfer.
> > I define a new qemu initialization phase called 'precreate' which occurs
> > before most backends or devices have been created.  The only exception
> > is monitor devices and the qtest device and their chardevs, which are created.
> > I untangled dependencies so that that migration_object_init can be called
> > before this phase.  The monitor accepts commands during this phase and can
> > receive migration configuration commands.  qemu starts listening on the
> > normal migration URI during this phase (which can come from either the
> > qemu command line or from a migrate_incoming command) so the user can
> > issue query-migrate to get the socket-address for dynamically allocated
> > port numbers.
> >
> > qemu enters the phase if qemu is started with the -precreate option.
> > The phase ends when the user sends a precreate-exit command.

Perhaps x-exit-precreate, just to match x-exit-preconfig?

> > Qemu then calls cpr_load_state and reads from the normal migration connection
> > as in the existing design, including the HUP.

I didn't fully get this part - can the cpr-uri channel completely avoided
then?  Do you mean the HUP can be avoided with it (alone with -cpr-uri dest
qemu cmdline)?

> >
> > (This sounds like the preconfig phase, but that occurs too late, after
> > backends have been created.)
> >
> > I implemented this scheme for another reason but abandoned it, so I need
> > a few days to rebase it and test.  It is not small, and requires approvals
> > from additional maintainers.  Let me know if you think this is the right
> > solution, and I will revive it.
> 
> Seems reasonable to me, given the requirements we're working with. Was
> there a branch we could skim somewhere?

Yes a tree can be clearer, with an example usage.

This design looks even cleaner to me (but maybe misunderstood some part),
it may slow down the merge because we need broader reviews.  So it's just
that it might have higher chance miss 9.2.

> 
> >
> > Preview:
> >
> >    0725d70 vl: precreate phase
> >    edd2dee net: cleanup for precreate phase
> >    4733c00 accel: encapsulate search state
> >    6d26ea4 accel: accel preinit function
> >    518e737 accel: split configure_accelerators
> >    8ef936b accel: delete accelerator and machine props
> >    b5c2a84 accel: set accelerator and machine props earlier
> >    56890a0 migration: init early
> >    76506b2 monitor: chardev name
> >    e85111d qom: get properties
> >    8356f7e qemu-option: filtered foreach
> >    fb6cc98 qemu-options: pass object to filter
> >    bdfec1b monitor: connect in precreate
> >    8f2f292 qtest: connect in precreate
> >    629cb50 migration: connect URI early
> >    0ae530e migration: allow commands during precreate and preconfig
> >
> >   accel/accel-system.c            |   2 -
> >   accel/kvm/kvm-all.c             |  58 +++++---
> >   accel/xen/xen-all.c             |  11 +-
> >   hmp-commands.hx                 |  20 +++
> >   include/migration/misc.h        |   2 +
> >   include/monitor/hmp.h           |   1 +
> >   include/monitor/monitor.h       |   1 +
> >   include/qapi/visitor.h          |   1 +
> >   include/qemu/accel.h            |   1 +
> >   include/qemu/option.h           |   5 +
> >   include/qom/object_interfaces.h |   2 +
> >   include/sysemu/sysemu.h         |   3 +
> >   migration/migration.c           |  31 +++++
> >   monitor/hmp-cmds.c              |   8 ++
> >   monitor/monitor.c               |  21 +++
> >   net/net.c                       |   4 +-
> >   qapi/migration.json             |  16 ++-
> >   qapi/misc.json                  |  23 +++-
> >   qemu-options.hx                 |  13 ++
> >   qom/object_interfaces.c         |  27 ++--
> >   system/vl.c                     | 291 +++++++++++++++++++++++++++++++---------
> >   target/i386/nvmm/nvmm-all.c     |  10 +-
> >   target/i386/whpx/whpx-all.c     |  14 +-
> >   util/qemu-option.c              |  25 ++++
> >   24 files changed, 471 insertions(+), 119 deletions(-)
> 

-- 
Peter Xu


