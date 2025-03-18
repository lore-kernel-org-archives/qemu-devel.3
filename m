Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D284AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuaao-0006CE-L0; Tue, 18 Mar 2025 13:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuaac-0006Ab-2k
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuaaT-0000tc-QR
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742318323;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6qz/VZpXFx71U4zTqHOY/bIAm81GXzgWawFz07fAzgU=;
 b=gpTeuyDWeCmnR1lP19/SLWWlHGGHlXtVBv5x+p1Y+xrvjEl3vrJHgKMLsM/xAd6YbUmnai
 wOjvGeUjRYSprpzCHYVxiPEg6QtRPCVqDFlEy64PMibU60MPFhfrMDZmm95XdqwbEl533K
 LnfXXNmoSrPB9vyO2QjGJ1BNIG8MT9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-Hvs8vl6zPmS7Y22dyWEcHA-1; Tue,
 18 Mar 2025 13:18:39 -0400
X-MC-Unique: Hvs8vl6zPmS7Y22dyWEcHA-1
X-Mimecast-MFC-AGG-ID: Hvs8vl6zPmS7Y22dyWEcHA_1742318318
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A3C0180AF71; Tue, 18 Mar 2025 17:18:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EBD918001F6; Tue, 18 Mar 2025 17:18:36 +0000 (UTC)
Date: Tue, 18 Mar 2025 17:18:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andreas Schwab <schwab@suse.de>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
Message-ID: <Z9mq6BtHD4YMGlE3@redhat.com>
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
 <Z9l7J0oZ8GAEqaMP@redhat.com>
 <CAFEAcA_ZBz3yvUYo5WhqmKRqCm+Jy1R01pshtU0NPRzzbP4hYQ@mail.gmail.com>
 <CAFEAcA-=FaNSQOSG3iFua30baATRvjBQPd5TfG6fBqJrFBFuYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-=FaNSQOSG3iFua30baATRvjBQPd5TfG6fBqJrFBFuYA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 18, 2025 at 05:08:52PM +0000, Peter Maydell wrote:
> On Tue, 18 Mar 2025 at 15:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> > More generally, AIUI glibc expects that it has control over what's
> > happening with threads, so it can set up its own data structures
> > for the new thread (e.g. for TLS variables). This email from the
> > glibc mailing list is admittedly now two decades old
> > https://public-inbox.org/libc-alpha/200408042007.i74K7ZOr025380@magilla.sf.frob.com/
> > but it says:
> >
> > # Basically, if you want to call libc functions you should do it from a
> > # thread that was set up by libc or libpthread.  i.e., if you make your own
> > # threads with clone, only call libc functions from the initial thread.
> 
> I spoke to some glibc devs on IRC and they confirmed that this
> remains true for modern glibc: because glibc needs to set up
> things like TLS on new threads, you can't mix your own direct
> calls to clone() with calls to glibc functions.

Using clone() directly is done by a number of projects (systemd, libvirt,
podman/docker/runc, etc) that want to create containers, while freely using
arbitrary glibc calls in the program. You do need to be careful what glibc
functions you run in the child after clone, but before execve though.

For the projects I mention, avoiding the danger areas is probably easier
than for QEMU, since QEMU has to theoretically cope with whatever madness
the guest program chooses to do, while those programs know exactly what
they will run between clone & execve.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


