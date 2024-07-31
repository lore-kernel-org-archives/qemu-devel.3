Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A74C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBLG-0001GR-0f; Wed, 31 Jul 2024 11:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZBLE-0001Fx-GK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZBLC-00027J-V8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722440052;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xt1y7Ymbjhp98Ia+dUFO04kudEZcuVG8h77B37Uxuck=;
 b=Nx1Xb9nai6DFuaatY+w00aGWY8bRtuckxri+PudPUXdX49tmHu03adLfH4bvMQaRxwGMlJ
 YH16/B1de/Oa9W6GwfHo7f+gBcgil3Ec8ohmBCRcyQyA8J44eRPuUPCKqILLpSxeVm/pCX
 DWkwQ7D0p2sn0IRmbqWsrEcEEMfzHCk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-PugLXuxaNGCJUqjN3ezfaA-1; Wed,
 31 Jul 2024 11:34:11 -0400
X-MC-Unique: PugLXuxaNGCJUqjN3ezfaA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D6DF1955F43; Wed, 31 Jul 2024 15:34:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21B89300022B; Wed, 31 Jul 2024 15:34:05 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:34:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] util: retry open() when it gets interrupted by a signal
Message-ID: <ZqpZaZTqC8xvmyEn@redhat.com>
References: <20240731132524.308273-1-philipp.reisner@linbit.com>
 <ZqpF6VoZgFsfhhl7@redhat.com>
 <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
 <ZqpWYfst2jsG3TB1@redhat.com>
 <CAFEAcA83zF4Gr3KUDAZMYmwZ7onw0zs=N0HeNkc3mSMF6n_sKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA83zF4Gr3KUDAZMYmwZ7onw0zs=N0HeNkc3mSMF6n_sKQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, Jul 31, 2024 at 04:24:45PM +0100, Peter Maydell wrote:
> On Wed, 31 Jul 2024 at 16:21, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 03:32:52PM +0100, Peter Maydell wrote:
> > > This is why we have the RETRY_ON_EINTR() macro, right?
> > >
> > > Currently we have some places that call qemu_open_old() inside
> > > RETRY_ON_EINTR -- we should decide whether we want to
> > > handle EINTR inside the qemu_open family of functions,
> > > or make the caller deal with it, and put the macro uses
> > > in the right place consistently.
> >
> > It is incredibly arbitrary where we use RETRY_ON_EINTR, which I think
> > points towards it being a sub-optimal solution to the general problem.
> 
> Agreed (and agreed that SA_RESTART is the usual approach to
> avoid this mess). Partly I just vaguely recall discussions
> about this back when we added/improved the RETRY_ON_EINTR
> macro in the first place: maybe there's a reason we have it
> still...
> 
> > > I agree that it would be nicer if we could use SA_RESTART,
> > > but presumably there's a reason why we don't. (At any
> > > rate code that's shared with the user-mode emulation
> > > has to be EINTR-resistant, because we can't force the
> > > user-mode guest code to avoid registering signal handlers
> > > that aren't SA_RESTART.)
> >
> > For user mode emulation isn't it valid to just propagage the
> > EINTR back up to the application, since EINTR is a valid errno
> > they have to be willing to handle unless the app has itself
> > use SA_RESTART.
> 
> Yes, that's what we must do for cases where we are doing some
> syscall on behalf of the guest. But for cases where we're
> doing a syscall because of something QEMU itself needs to do,
> we may need to retry, because we might not be in a position
> to be able to back out of what we're doing (or we might not
> even be inside the "handle a guest syscall" codepath at all).

Ah ok, so RETRY_ON_EINTR conceivably makes sense in the linux-user
/ bsd-user code in certain scenarios......but it seems almost every
single use today is in system emulator code !

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


