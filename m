Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B087C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFYa-0002Xw-O0; Mon, 13 Jul 2026 08:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjFYZ-0002Xd-Sm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjFYW-0007DH-8e
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783944878;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DyCn/gDPXTQ+OYiqOXbC3THSKc2eu8rjsY8fuZyBGw=;
 b=W/8VuBSrVIC9lPFPpucqb/HnZxkT3oGqluwWZ9uGq4b7x9lre8VokVvxrPeBcSCPYdqdo8
 XAQ0iI6vCcJ77axywdhoq3ZfSz8dFQGYHui2GzTxCm2e5jw+rTMAtDrfrg9seUownsdqEI
 0z3FwpyOSK+MBdB7aONniDIdM9aen0A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-zTe4CjMcOTmFqepEAHjATg-1; Mon,
 13 Jul 2026 08:14:32 -0400
X-MC-Unique: zTe4CjMcOTmFqepEAHjATg-1
X-Mimecast-MFC-AGG-ID: zTe4CjMcOTmFqepEAHjATg_1783944871
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B4E41955F26; Mon, 13 Jul 2026 12:14:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ECF7180067C; Mon, 13 Jul 2026 12:14:26 +0000 (UTC)
Date: Mon, 13 Jul 2026 13:14:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: what is qemu_system_guest_panicked() for?
Message-ID: <alTWn2xq4FfdxnE4@redhat.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <alSkWHw6ryhEEaDf@redhat.com> <87cxwrtgfd.fsf@pond.sub.org>
 <alSqlDRT9L8OqAso@redhat.com> <87se5ngln1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87se5ngln1.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jul 13, 2026 at 01:43:46PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Jul 13, 2026 at 10:57:58AM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Fri, Jul 10, 2026 at 05:02:53PM +0100, Peter Maydell wrote:
> >> 
> >> [...]
> >> 
> >> >> So I guess my question is, is it OK to mash these two categories of
> >> >> "we can't keep running the VM" together, or should we define a new
> >> >> one for the "unrecoverable guest error" case, or do we already have
> >> >> some better thing to do that I missed?
> >> >
> >> > IMHO we should NOT be abusing "panicked" for cases which are
> >> > not guest OS panics.
> >> 
> >> Point.
> >> 
> >> > Adding new QMP events is cheap and we should do so.
> >> 
> >> Changing the event sent on a certain situation is technically a
> >> compatibility break.  Would it matter here?
> >
> > What wins "compat break" or "bug fix" ? A strict POV prevents almost
> > any bug fixes, if you want to remain bug-for-bug compatible with
> > old QEMU.
> 
> There is no hard and fast rule.
> 
> If a patch changes behavior, and no one is around to observe it, should
> we still treat it as compatibility break?  The pragmatic answer is no.
> 
> It's of course hard to be sure about non-observation.  The pragmatic
> answer to that is "we use the best available data, and where it is
> lacking, reasonably conservative guesses."
> 
> How likely is it that the fix breaks something else, and how painful
> could such breakage be?  Again, hard to be sure, thus reasonably
> conservative guesses.
> 
> > With my "management app" hat on, I want QEMU to stop sending panic
> > events for things that are not panics, as that is triggering incorrect
> > actions / admin activities. ie on a panic, I'm going to take a guest
> > memory dump and try to analyse what is broken in the guest kernel.
> >
> > The QAPI spec says:
> >
> >   ##
> >   # @GUEST_PANICKED:
> >   #
> >   # Emitted when guest OS panic is detected
> >
> >
> > and
> >
> >   ##
> >   # @RunState:
> >   #
> >   # An enumeration of VM run states.
> >   #
> >   ..
> >   # @guest-panicked: guest has been panicked as a result of guest OS
> >   #     panic
> >
> >
> > I don't think "machine check exception" or "unknown VM exit"
> > can be said to match either of those docs, and thus fixing
> > compliance should trump bug-for-bug compatibility IMHO.
> 
> I'm not objecting, I just want the compatibility issues considered.
> 
> What are the known observers of GUEST_PANICKED?  How would they be
> affected by the change?
> 
> What are the use cases for observing GUEST_PANICKED?  How could they be
> affected?
> 
> Reasonably conservative guesses will do.

When libvirt see a GUEST_PANICKED, it will transition the state to
"CRASHED" and assign a reason of "PANICKED" as the trigger / cause.

Then depending on the guest XML config for <on_crash> it will do one
of

 * Take a core dump of QEMU
 * Terminate QEMU
 * Restart QEMU
 * Take a core dump of QEMU and restart
 * Leave it in crashed state (to allow a debugger to attach)


The "machine check" and "unknown VM exit" scenarios, would still map
to libvirt's "CRASHED" state, but we would want to assign distinct
"cause" for each of them.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


