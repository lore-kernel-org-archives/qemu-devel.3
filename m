Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1418FCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnvt-0004g4-MZ; Tue, 12 May 2026 10:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMnv1-0004a1-0q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMnuj-0007UB-Rt
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778595407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AZ5uAvo2+W42FKAe2JI1wWFsPsN3s48Gf9a/uwm9BJg=;
 b=XYFIf+3N90jG99RXiZneW8BPwAGPvNKMFYntHJo+9H3zGt2pP9Z/wUuiCJodUHwwhJ1zje
 pHyTzRzPxAxaPdQpcQXAZYpmWYGDXkK7uZKYBAX/PQGlnZBUPU7IR3qRwMCChxgUxvvg3u
 Defik4yvp7PI4mHIPuGn9bfel/FlOns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-z8ryxKoENKSxlBy6YwohQQ-1; Tue,
 12 May 2026 10:16:45 -0400
X-MC-Unique: z8ryxKoENKSxlBy6YwohQQ-1
X-Mimecast-MFC-AGG-ID: z8ryxKoENKSxlBy6YwohQQ_1778595404
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86F6F18002D6; Tue, 12 May 2026 14:16:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.152])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 402F01955D84; Tue, 12 May 2026 14:16:42 +0000 (UTC)
Date: Tue, 12 May 2026 16:16:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Can we make QMP commands in Rust always be coroutine safe?
Message-ID: <agM2R2g2yXzs4k0P@redhat.com>
References: <87tssm5jq2.fsf@pond.sub.org>
 <424027a4-432f-441a-a53a-69e01412af07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424027a4-432f-441a-a53a-69e01412af07@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 05.05.2026 um 12:51 hat Paolo Bonzini geschrieben:
> On 5/5/26 10:44, Markus Armbruster wrote:
> >      Coroutine safety can be hard to prove, similar to thread safety.  Common
> >      pitfalls are:
> > 
> >      - The BQL isn't held across ``qemu_coroutine_yield()``, so
> >        operations that used to assume that they execute atomically may have
> >        to be more careful to protect against changes in the global state.
> > 
> >      - Nested event loops (``AIO_WAIT_WHILE()`` etc.) are problematic in
> >        coroutine context and can easily lead to deadlocks.  They should be
> >        replaced by yielding and reentering the coroutine when the condition
> >        becomes false.
> > 
> >      Since the command handler may assume coroutine context, any callers
> >      other than the QMP dispatcher must also call it in coroutine context.
> >      In particular, HMP commands calling such a QMP command handler must be
> >      marked ``.coroutine = true`` in hmp-commands.hx.
> > 
> >      It is an error to specify both ``'coroutine': true`` and ``'allow-oob': true``
> >      for a command.  We don't currently have a use case for both together and
> >      without a use case, it's not entirely clear what the semantics should
> >      be.
> > 
> > Can we make commands written in Rust always coroutine safe?
> 
> We won't *ever* have mixed coroutine/non-coroutine functions in Rust.
> Kevin's prototype used async functions (stackless coroutines) for Rust
> yielding functions, rather than qemu_coroutine_yield()[1].  Within sucg
> fubctuibs, yielding is much more explicit than in C (you have to write
> ".await" explicitly at all levels of calling a yielding function).

By the way, one thing I realised only recently is that we probably don't
have a way to implement no_coroutine_fn in Rust (or specfically the Rust
bindings for C no_coroutine_fn functions).

> But we have the BQL, and "coroutine: true" commands if I understand
> correctly are run outside it (they run in iothread context).  So any command
> that uses BQL-protected data cannot be coroutine safe, and that means it's
> likely that Rust would also have coroutine: true/false.

A coroutine QMP command handler runs in the main loop initially, which
means that it holds the BQL. So I don't think you have a real reason to
have coroutine: false.

What the handler can do is move itself into a different thread later on
using something like aio_co_reschedule_self(), and then of course, it
can't rely on the BQL any more.

My understanding is that this would normally be handled by requiring the
Send trait for the Future in the function that hands the future off to
another thread. However, here we're not in the context of the
synchronous executor that works with the Future object, but in the async
fn itself. I'm not quite sure how to encode this requirement in the
binding for aio_co_reschedule_self() so that the calling async fn has to
be Send for it to compile. Any ideas?

> However, there are safeguards:
> 
> 1) it will be impossible to write yielding code in a "coroutine: false" Rust
> command; it won't secretly start a nested event loop.

Having a nested event loop in Rust isn't any harder than having it in C
(and I needed it in some block layer bindings because of synchronous
interfaces), so this depends on our discipline.

> 2) releasing the BQL while keeping a reference to a BqlRefCell is an instant
> panic;
> 
> This leaves nested event loops in "coroutine: true" commands as a potential
> pitfall.

I guess this is where a no_coroutine_fn that is understood by the
compiler would be useful.

> [1] suspension and resumption is represented respectively by futures (a
> discriminated union of a suspension state and a result after completion) and
> wakers.  To convert suspended async fns to qemu_coroutine_yield() calls,
> Kevin wrapped the async fns with a loop that continues until the future as a
> result, yielding across calls to the async fn; and to resume the suspended
> async fn, he wrote a waker that invokes qemu_coroutine_resume().

Kevin


