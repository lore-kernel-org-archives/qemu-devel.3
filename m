Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4119C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkjjJ-0003l7-KB; Wed, 19 Feb 2025 08:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkjjA-0003ih-59
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkjj6-0005pS-PC
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739970174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SV8fB814/6cayJPLhjdSvKElwhX2pesRbTeul1zeAjg=;
 b=gtEEK6AZHomz2q2yzOpshLsdSjhQOhRUgHN0I0Ja8qv0JIUiRz/xjh3Xzf+FEz9aX3z9Iy
 QVt4LYSeuqA3yxaXMz5gvoQc0ogShYqU90PTB+Wg1NjvvrUcJxvAX3o0wnILhYQdx8vDS3
 FoH7dTLWSVs9kqhru5tZlokecKpSqWA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-jVVNcNf9NWuqdH2yiB336w-1; Wed,
 19 Feb 2025 08:02:52 -0500
X-MC-Unique: jVVNcNf9NWuqdH2yiB336w-1
X-Mimecast-MFC-AGG-ID: jVVNcNf9NWuqdH2yiB336w_1739970171
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ACB718D95DC; Wed, 19 Feb 2025 13:02:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6A491800359; Wed, 19 Feb 2025 13:02:47 +0000 (UTC)
Date: Wed, 19 Feb 2025 14:02:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 09/11] rust/block: Add read support for block drivers
Message-ID: <Z7XWdLOe7dK1eh29@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-10-kwolf@redhat.com>
 <0ee134e7-02bf-4b9b-9c9a-83c88386cd57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee134e7-02bf-4b9b-9c9a-83c88386cd57@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 19.02.2025 um 07:11 hat Paolo Bonzini geschrieben:
> On 2/18/25 19:20, Kevin Wolf wrote:
> > +    /// The described blocks are stored in a child node.
> > +    Data {
> > +        /// Child node in which the data is stored
> > +        node: Arc<BdrvChild>,
> 
> Having Arc<> here shouldn't be necessary, since the BdrvChild is already
> reference counted.  Since the code is called under the bdrv_graph_rdlock
> there's no risk of the BdrvChild going away, and you can just make it a
> &BdrvChild.

That would mean that you need keep the BlockDriver borrowed as long as
you're using the mapping. It would work today, but as soon as I want to
cache mappings, it won't any more.

> Likewise, even BochsImage should not need a standard Rust Arc<BdrvChild>.
> However you need to add your own block::Arc<BdrvChild> and map Clone/Drop to
> bdrv_ref/bdrv_unref.  Then BochsImage can use block::Arc<BdrvChild>; this
> makes it even clearer that Mapping should not use the Arc<> wrapper, because
> bdrv_ref is GLOBAL_STATE_CODE() and would abort if run from a non-main
> thread.

It's not BdrvChild that is refcounted on the C side, but
BlockDriverState. We definitely don't bdrv_ref()/unref() for each
request on the C side and we shouldn't on the Rust side either. The
refcount only changes when you modify the graph.

I'm not entirely sure how your block::Arc<T> is supposed to work. It
would be tied to one specific type (BlockDriverState), not generic.
Which probably means that it can't be a separate pointer type, but
BlockDriverState itself should just implement Clone with bdrv_ref().

Though that doesn't help here, obviously, because we have a BdrvChild.

> That said, I'm not sure how to include "block graph lock must be taken" into
> the types, yet.  That has to be taken into account too, sooner or later.
> You probably have a lot of items like this one so it'd be nice to have TODO
> comments as much as you can.

Actually, I'm not aware of that many items. But yes, there is a TODO
item for the graph lock.

I think I'll have something like:

    pub struct BdrvChild {
        child: GraphLock<*mut bindings::BdrvChild>,
    }

where you can access the inner object either by calling a lock function,
or passing another graph lock guard that you already own. And for the
FFI boundary unsafe functions like "I promise I already own the lock".

> (This boundary is where you get an unholy mix of C and Rust concepts. It
> takes a while to get used to, and it teaches you a lot of the parts of Rust
> that you usually take for granted.  So while it's not hard, it's unusual and
> it does feel like water and oil in the beginning).
> 
> > +) -> std::os::raw::c_int {
> > +    let s = unsafe { &mut *((*bs).opaque as *mut D) };
> 
> &mut is not safe here (don't worry, we went through the same thing for
> devices :)).  You can only get an & unless you go through an UnsafeCell (or
> something that contains one).

Right, we can have multiple requests in flight.

The fix is easy here: Even though bindgen gives us a *mut, we only want
a immutable reference.

> You'll need to split the mutable and immutable parts of BochsImage in
> separate structs, and embed the former into the latter.  Long term you
> there should be a qemu_api::coroutine::CoMutex<>, but for the short
> term you can just use a BqlRefCell<> or a standard Rust RefCell<>.
> You can see how PL011Registers is included into PL011State in
> rust/hw/char/pl011/src/device.rs, and a small intro is also present in
> docs/devel/rust.rst.

There is no mutable part in BochsImage, which makes this easy. The only
thing is the *mut bindings::BdrvChild, but we never dereference that in
Rust. It is also essentially interior mutability protected by the graph
lock, even though this isn't explicit yet.

But if we were to introduce a mutable part (I think we will add write
support to it sooner or later), then BqlRefCell or RefCell are
definitely not right. They would only turn the UB into a safe panic when
you have more than one request in flight. (Or actually, BqlRefCell
should already panic with just one request from an iothread, because we
don't actually hold the BQL.)

> Anyway, the BdrvChild needs to remain in BochsImage, so that it is
> accessible outside the CoMutex critical section and can be placed into
> the Mapping.
> 
> > +    let mut offset = offset as u64;
> > +    let mut bytes = bytes as u64;
> > +
> > +    while bytes > 0 {
> > +        let req = Request::Read { offset, len: bytes };
> > +        let mapping = match qemu_co_run_future(s.map(&req)) {
> > +            Ok(mapping) => mapping,
> > +            Err(e) => return -i32::from(Errno::from(e).0),
> 
> This is indeed not great, but it's partly so because you're doing a
> lot (for some definition of "a lot") in the function.  While it would
> be possible to use a trait, I wrote the API thinking of minimal glue
> code that only does the C<->Rust conversion.
> 
> In this case, because you have a lot more code than just a call into
> the BlockDriver trait, you'd have something like
> 
> fn bdrv_co_preadv_part(
>     bs: &dyn BlockDriver,
>     offset: i64,
>     bytes: i64,
>     qiov: &bindings::QEMUIOVector,
>     mut qiov_offset: usize,
>     flags: bindings::BdrvRequestFlags) -> io::Result<()>
> 
> and then a wrapper (e.g. rust_co_preadv_part?) that only does
> 
>    let s = unsafe { &mut *((*bs).opaque as *mut D) };
>    let qiov = unsafe { &*qiov };
>    let result = bdrv_co_preadv_part(s, offset, bytes,
>          qiov, qiov_offset, flags);
>    errno::into_negative_errno(result)
> 
> This by the way has also code size benefits because &dyn, unlike
> generics, does not need to result in duplicated code.

I don't really like the aesthetics of having two functions on the
Rust side for each C function, but I guess ugliness is expected in
bindings...

For the errno conversion functions, I'm still not sure that they should
only support trivial wrappers with no early returns. I reluctantly buy
your &dyn argument (though in C block drivers this is generally
duplicated code, too), but that's unrelated to error handling.

> For now, I'd rather keep into_negative_errno() this way, to keep an
> eye on other cases where you have an io::Error<()>.  Since Rust rarely
> has Error objects that aren't part of a Result, it stands to reason
> that the same is true of QEMU code, but if I'm wrong then it can be
> changed.

This one is part of a Result, too. But not a result that is directly
returned in both success and error cases, but where the error leads to
an early return. That is, an equivalent for the ubiquitous pattern:

    ret = foo();
    if (ret < 0) {
        return ret;
    }

    /* Do something with the successful result of foo() */

Kevin


