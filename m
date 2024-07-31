Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DB7C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZB91-0002ix-B6; Wed, 31 Jul 2024 11:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZB8z-0002i8-Fp
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZB8x-0006hy-PK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722439294;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTogfFo0xxLk8tiw+WEKKwv4Dvgm3icbEeGCSVYs5+c=;
 b=ZQYZu9JfDMkeD+UMjIUPp0gaDpuMSPrPK0FRBE19rASDjHAQYgonEh0FFI679idclkTosT
 10roEe44V0seZ7ehArfQu5jcblwjROj0qdJZLH0UB/Rwi+8T+ky1wnvCCJ0CoJ6m+cZy6a
 SwEkWNi/Rb8pOmx0Z2r42PvCzXn0UDA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-0Cl10TstOTCdyLIDF3mQfQ-1; Wed,
 31 Jul 2024 11:21:30 -0400
X-MC-Unique: 0Cl10TstOTCdyLIDF3mQfQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 097931977025; Wed, 31 Jul 2024 15:21:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6736F1955D42; Wed, 31 Jul 2024 15:21:09 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:21:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] util: retry open() when it gets interrupted by a signal
Message-ID: <ZqpWYfst2jsG3TB1@redhat.com>
References: <20240731132524.308273-1-philipp.reisner@linbit.com>
 <ZqpF6VoZgFsfhhl7@redhat.com>
 <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 31, 2024 at 03:32:52PM +0100, Peter Maydell wrote:
> On Wed, 31 Jul 2024 at 15:11, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 03:25:24PM +0200, Philipp Reisner wrote:
> > > As with many syscalls, open() might be interrupted by a signal.
> > >
> > > The experienced logfile entry is:
> > >
> > > qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call

What is the actual signal you are seeing that impacts QEMU
in this way ?

> > > Retry it until it is not interrupted by a signal.
> >
> > As you say, many syscalls can be interruptted by signals, so
> > special casing open() isn't really a solution - its just
> > addressing one specific instance you happened to see.
> >
> > If there are certain signals that we don't want to have a
> > fatal interruption for, it'd be better to set SA_RESTART
> > with sigaction, which will auto-restart a large set of
> > syscalls, while allowing other signals to be fatal.
> 
> This is why we have the RETRY_ON_EINTR() macro, right?
> 
> Currently we have some places that call qemu_open_old() inside
> RETRY_ON_EINTR -- we should decide whether we want to
> handle EINTR inside the qemu_open family of functions,
> or make the caller deal with it, and put the macro uses
> in the right place consistently.

It is incredibly arbitrary where we use RETRY_ON_EINTR, which I think
points towards it being a sub-optimal solution to the general problem.

> 
> I agree that it would be nicer if we could use SA_RESTART,
> but presumably there's a reason why we don't. (At any
> rate code that's shared with the user-mode emulation
> has to be EINTR-resistant, because we can't force the
> user-mode guest code to avoid registering signal handlers
> that aren't SA_RESTART.)

For user mode emulation isn't it valid to just propagage the
EINTR back up to the application, since EINTR is a valid errno
they have to be willing to handle unless the app has itself
use SA_RESTART.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


