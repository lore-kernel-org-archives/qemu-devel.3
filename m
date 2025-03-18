Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2199EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuXPY-0004Kk-VI; Tue, 18 Mar 2025 09:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuXPV-0004IV-Mr
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuXPK-0000od-Pj
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742306100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATxhQwGOfECtIn17GKaJ3ka5l/3drII2sikoNGL2Sj0=;
 b=Hi/Xk//E776okf3onQrzgpcH/LxTA8PNVHLxe/5FIvix0McRNKiNEFC+B3sPthEFSaeGev
 +gIAlUcGNKe1OmG8dN8pFkbTqtWUIAzzL5IavgHQGf41EXuTJzz8kFWDze4weBfzff9DSp
 0t9frgHI0Gj/cMV2X52MhperXddveY0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-_uA9kmoyPY2ZmExQgk5QpQ-1; Tue,
 18 Mar 2025 09:54:56 -0400
X-MC-Unique: _uA9kmoyPY2ZmExQgk5QpQ-1
X-Mimecast-MFC-AGG-ID: _uA9kmoyPY2ZmExQgk5QpQ_1742306095
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 577A0180AF6E; Tue, 18 Mar 2025 13:54:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DCC51828A92; Tue, 18 Mar 2025 13:54:51 +0000 (UTC)
Date: Tue, 18 Mar 2025 13:54:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andreas Schwab <schwab@suse.de>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
Message-ID: <Z9l7J0oZ8GAEqaMP@redhat.com>
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 18, 2025 at 01:06:17PM +0000, Peter Maydell wrote:
> On Tue, 18 Mar 2025 at 12:43, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Mar 18, 2025 at 01:34:57PM +0100, Andreas Schwab wrote:
> > > On Mär 18 2025, Daniel P. Berrangé wrote:
> > >
> > > > Whereever practical, it is preferrable to check a discrete feature
> > > > or behaviour in a functional way, rather than matching on "is it QEMU"
> > >
> > > Do you know a way to detect support for CLONE_VFORK that isn't too
> > > expensive?
> >
> > No, but I feel like the right thing in this particular case is to look
> > at improving our vfork impl. The current impl is incredibly crude and
> > acknowledged by the original author
> >
> >   commit 436d124b7d538b1fd9cf72edf17770664c309856
> >   Author: Andrzej Zaborowski <balrogg@gmail.com>
> >   Date:   Sun Sep 21 02:39:45 2008 +0000
> >
> >     Band-aid vfork() emulation (Kirill Shutemov).
> >
> > I can see why they did it that way, but I'm feeling like it ought to
> > be possible to do a better special case vfork impl ni QEMU instead of
> > overloading the fork() impl.
> 
> The difficulty with vfork() (and, more generally, with various of
> the clone() syscall flag combinations) is that because we use the
> host libc we are restricted to the thread/process creation options
> that that libc permits: which is only fork() and pthread_create().
> vfork() wants "create a new process like fork with its own file
> descriptors, signal handlers, etc, but share all the memory space with
> the parent", and the host libc just doesn't provide us with the tools
> to do that. (We can't call the host vfork() because we wouldn't be
> abiding by the rules it imposes, like "don't return from the function
> that called vfork".)
> 
> If we were implemented as a usermode emulator that sat on the raw
> kernel syscalls, we could directly call the clone syscall and
> use that to provide at least a wider range of the possible clone
> flag options; but our dependency on libc means we have to avoid
> doing things that would confuse it.

I guess I'm not seeing how libc is blocking us in this respect ?
The clone() syscall wrapper is exposed by glibc at least, and it
is possible to call it, albeit with some caveats that we might
miss any logic glibc has around its fork() wrapper. The spec
requires that any child must immediately call execve after vfrok
so I'm wondering just what risk of confusion we would have in
practice ?

> For vfork in particular, we could I guess do something like:
>  * use real fork() to create child process
>  * parent process arranges to wait until child process exits
>    (via waitpid or equivalent) or it tells us it's about to exec
>  * we make all the guest memory be mapped read-only in the child
>    process, so we can trap writes and tell the parent about them
>    so it can update its copy of the memory.
>    (Sadly since we can't guaranteedly get control on termination
>    events for the child before it really terminates, we can't
>    do this memory-transfer in bulk at the end; otherwise we'd
>    behave wrongly for the "child process gets SIGKILLed" case.)

That would get the synchronization behaviour of Linux vfork,
but I'm not sure it'd get the performance benefits (of avoiding
page table copying) which is what  Andreas mentioned as the
desired thing ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


