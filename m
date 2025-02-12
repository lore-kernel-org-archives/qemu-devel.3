Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D52DC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiC98-0007CC-Lg; Wed, 12 Feb 2025 07:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiC95-0007Bt-RF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiC93-00047d-Se
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739364432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xsh7VanH7sfiVHMO9rLV1PJGWwOQ3kk5zetFTpIjnWo=;
 b=A0AobQazGXScmtx5hOVIg0106XVb6CFJ5LlgUUZe83GWDc4Wjka5GrLOriNrY7idBkSaWl
 O32IPs4Otik4gVWehG/d6uo92GFzkIZHpj6H+2F4Y+Sqyhu3DLOMo9w+bw0DPvAyhEvGyA
 GNXekpetc0HTJQvHur5giJB6/nScFZo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-hj7In-5SPOeRCSfrPFY9KQ-1; Wed,
 12 Feb 2025 07:47:10 -0500
X-MC-Unique: hj7In-5SPOeRCSfrPFY9KQ-1
X-Mimecast-MFC-AGG-ID: hj7In-5SPOeRCSfrPFY9KQ_1739364429
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B2F195608B; Wed, 12 Feb 2025 12:47:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8D3D3001D19; Wed, 12 Feb 2025 12:47:04 +0000 (UTC)
Date: Wed, 12 Feb 2025 13:47:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/11] rust/qemu-api: Add wrappers to run futures in QEMU
Message-ID: <Z6yYRrp4KTjveCHg@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-5-kwolf@redhat.com>
 <533ac9c1-7486-4b1b-af9a-ed4a864727de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533ac9c1-7486-4b1b-af9a-ed4a864727de@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 12.02.2025 um 10:28 hat Paolo Bonzini geschrieben:
> On 2/11/25 22:43, Kevin Wolf wrote:
> > +/// Use QEMU's event loops to run a Rust [`Future`] to completion and return its result.
> > +///
> > +/// This function must be called in coroutine context. If the future isn't ready yet, it yields.
> > +pub fn qemu_co_run_future<F: Future>(future: F) -> F::Output {
> > +    let waker = Arc::new(RunFutureWaker {
> > +        co: unsafe { bindings::qemu_coroutine_self() },
> > +    })
> > +    .into();
> 
> into what? :)  Maybe you can add the type to the "let" for clarity.

Into Waker. Do we have any idea yet how explicit we want to be with type
annotations that aren't strictly necessary? I didn't think of making it
explicit here because the only thing that is done with it is building a
Context from it, so it seemed obvious enough.

If you think that being explicit is better, then Waker::from() might
be better than adding a type name to let and keeping .into().

> > +    let mut cx = Context::from_waker(&waker);
> > +
> > +    let mut pinned_future = std::pin::pin!(future);
> > +    loop {
> > +        match pinned_future.as_mut().poll(&mut cx) {
> > +            Poll::Ready(res) => return res,
> 
> Alternatively, "break res" (matter of taste).
> 
> > +            Poll::Pending => unsafe {
> > +                bindings::qemu_coroutine_yield();
> > +            },
> > +        }
> > +    }
> > +}
> > +/// Wrapper around [`qemu_co_run_future`] that can be called from C.
> > +///
> > +/// # Safety
> > +///
> > +/// `future` must be a valid pointer to an owned `F` (it will be freed in this function).  `output`
> > +/// must be a valid pointer representing a mutable reference to an `F::Output` where the result can
> > +/// be stored.
> > +unsafe extern "C" fn rust_co_run_future<F: Future>(
> > +    future: *mut bindings::RustBoxedFuture,
> > +    output: *mut c_void,
> > +) {
> > +    let future = unsafe { Box::from_raw(future.cast::<F>()) };
> > +    let output = output.cast::<F::Output>();
> > +    let ret = qemu_co_run_future(*future);
> > +    unsafe {
> > +        *output = ret;
> 
> This should use output.write(ret), to ensure that the output is written
> without dropping the previous value.

Oops, thanks. I need to learn that unsafe Rust still isn't C. :-)

> Also, would qemu_co_run_future() and qemu_run_future() become methods on an
> Executor later?  Maybe it make sense to have already something like
> 
> pub trait QemuExecutor {
>     fn run_until<F: Future>(future: F) -> F::Output;
> }
> 
> pub struct Executor;
> pub struct CoExecutor;
> 
> and pass an executor to Rust functions (&Executor for no_coroutine_fn,
> &CoExecutor for coroutine_fn, &dyn QemuExecutor for mixed).  Or would that
> be premature in your opinion?

If we could get bindgen to actually do that for the C interface, then
this could be interesting, though for most functions it also would
remain unused boilerplate. If we have to get the executor manually on
the Rust side for each function, that's probably the same function that
will want to execute the future - in which case it just can directly
call the correct function.

The long term idea should be anyway that C coroutines disappear from the
path and we integrate an executor into the QEMU main loop. But as long
as the block layer core is written in C and uses coroutines and we want
Rust futures to be able to call into coroutine_fns, that's still a long
way to go.

Kevin


