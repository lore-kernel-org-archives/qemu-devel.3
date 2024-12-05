Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1255BE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJELX-00070k-5h; Thu, 05 Dec 2024 11:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJELV-00070P-TE
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJELS-0000UD-JF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733414688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cn0TFB+dheuVi5JV+esed/wCO8rDPnhf3i39qCl9SUc=;
 b=DZWGuqlANLdFAsTsqs53vxu/J0ZXRaaMc7eoOQgdfvTm6qCCk7mmV6APXdHMQzFWChapey
 BatdAB57jGw5QVKMsbwW3baQHxSEn8ETbiAkU5dXLoXVuT3atXBuy/YfIgSNMkadTrUKHu
 BWsj61+FTN8zEMjVCqlRw0F7YN808aw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-QitxrrD-OpeFibtBOVAF7A-1; Thu,
 05 Dec 2024 11:04:47 -0500
X-MC-Unique: QitxrrD-OpeFibtBOVAF7A-1
X-Mimecast-MFC-AGG-ID: QitxrrD-OpeFibtBOVAF7A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EBBC1944D20
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 16:04:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF6DE195422D; Thu,  5 Dec 2024 16:04:43 +0000 (UTC)
Date: Thu, 5 Dec 2024 16:04:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 0/9] Require error handling for dynamically created
 objects
Message-ID: <Z1HPF8wQG4ZqZIhF@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
 <87a5dbln8x.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5dbln8x.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 04, 2024 at 12:07:58PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > NB, this series is targetting 10.0, NOT for 9.2 freeze.
> >
> > With code like
> >
> >     Object *obj = object_new(TYPE_BLAH)
> >
> > the caller can be pretty confident that they will successfully create
> > an object instance of TYPE_BLAH. They know exactly what type has been
> > requested, so it passing an abstract type for example, it is a clear
> > programmer error that they'll get an assertion failure.
> >
> > Conversely with code like
> >
> >    void somefunc(const char *typename) {
> >       Object * obj = object_new(typename)
> >       ...
> >    }
> >
> > all bets are off, because the call of object_new() knows nothing
> > about what 'typename' resolves to.
> 
> We know nothing *locally*.
> 
> Commonly, a non-local argument can demonstrate safety.  Only when the
> type name comes from the user, we truly know nothing.

...except for the failures introduced by modules not being installed,
then all bets are off for all types unless you happen to recall
which have been modularized so far.

> >                                    It could easily be an abstract
> > type.
> 
> It could also be no type at all.
> 
> >       As a result, many code paths have added a manual check ahead
> > of time
> >
> >    if (object_class_is_abstract(typename)) {
> >       error_setg(errp, ....)
> >    }
> 
> Actually, object_class_is_abstract() takes an ObjectClass, not a type
> name string.
> 
> The actual guards we use are variations of
> 
>     klass = object_class_by_name(typename);
>     if (!klass) {
>         error_setg(errp, "invalid object type: %s", typename);
>         return NULL;
>     }
> 
>     if (object_class_is_abstract(klass)) {
>         error_setg(errp, "object type '%s' is abstract", typename);
>         return NULL;
>     }
> 
> which covers "no type at all", too.
> 
> Sometimes, we use module_object_class_by_name() instead, which I believe
> additionally loads the module providing the type, if any.  Which of the
> two should be used where is a mystery to me, and I suspect we're getting
> it wrong in places.  But this is turning into a digression.  To
> hopefully maintain focus, I'm pretending modules don't exist until later
> in this message.

Yeah, I'm not a fan of having the separate module_object_class_by_name,
because it requires us to remember whether something has been modularized
or not.

> Sometimes, we throw in an object_class_dynamic_cast(klass, T) to check
> @typename resolves to a subtype of some T.
> 
> > ...except for where we forget to do this, such as qdev_new().
> 
> We did not forget it there!  It's by design a thin wrapper around
> object_new(), with preconditions just like object_new().

Yes, I think what I meant to write here, was "...except for where
we forgot todo this in *callers* of qdev_new that take user input"

> > Overall 'object_new' is a bad design because it is inherantly
> > unsafe to call with unvalidated typenames.
> 
> To be fair, object_new() was not designed for use with user-provided
> type names.  When it chokes on type names not provided by the user, it's
> clearly a programming error, and assert() is a perfectly fine way to
> catch programming errors.  Same for qdev_new().
> 
> However, we do in fact use these functions with user-provided type
> names, if rarely.  When we do, we need to validate the type name before
> we pass it to them.
> 
> Trouble is the validation code is a bit involved, and reimplementing it
> everywhere it's needed is asking for bugs.
> Creating and using more interfaces that are more convenient for this
> purpose would avoid that.

Yep, I don't have confidence in an API that will assert if the caller
forgot to validate the pre-conditions that can be triggered by user
input (or potentially other unexpected scenarios like something being
switched over to a module).

> > This problem is made worse by the proposal to introduce the idea
> > of 'singleton' classes[1].
> >
> > Thus, this series suggests a way to improve safety at build
> > time. The core idea is to allow 'object_new' to continue to be
> > used *if-and-only-if* given a static, const string, because that
> > scenario indicates the caller is aware of what type they are
> > creating at build time.
> >
> > A new 'object_new_dynamic' method is proposed for cases where
> > the typename is dynamically chosen at runtime. This method has
> > an "Error **errp" parameter, which can report when an abstract
> > type is created, leaving the assert()s only for scenarios which
> > are unambiguous programmer errors.
> >
> > With a little macro magic, we guarantee a compile error is
> > generated if 'object_new' is called with a dynamic type, forcing
> > all potentially unsafe code over to object_new_dynamic.
> 
> Three cases:
> 
> 1. Type name is literal string.  No change.  This is the most common
>    case.
> 
> 2. It's not.
> 
> 2a. Type name is user-provided.  This is rare.  We replace
> 
>         if (... guard ...) {
>             ... return failure ...
>         }
>         obj = object_new(...);
> 
>     by
> 
>         obj = object_new_dynamic(..., errp);
>         if (!obj) {
>             ... return failure ...
>         }
> 
>     This is an improvement.
> 
> 2b. It's not.  We should replace
> 
>         obj = object_new(...);
> 
>     by
> 
>         obj = object_new_dynamic(..., &error_abort);
> 
>     Exact same behavior, just wordier, to placate the compiler.
>     Tolerable as long as it's relatively rare.
> 
>     But I'm not sure it's worthwhile.  All it really does is helping
>     some towards not getting case 2a wrong.  But 2a is rare.

Yes, 2a is fairly rare, but this is amplified by the consequences
of getting it wrong, which are an assert killing your running VM.
My goal was to make it much harder to screw up and trigger an
assert, even if that makes some valid uses more verbose.

> > This is more tractable than adding 'Error **errp' to 'object_new'
> > as only a handful of places use a dynamic type name.
> 
> True!
> 
> Alright, enter modules.
> 
> Modules break a fundamental design assumption: object_new() on a
> compiled-in type name is safe, i.e. the failure modes are all
> programming errors.
> 
> Modules add new failure modes that are *not* programming errors:
> 
> * The module providing the type was not deployed correctly.
> 
> * It was, but the host system lacks the resources to load it.

Hmm, yes, I hadn't considered the 2nd problem. That's more
unpleasant, as libvirt may well have queried QEMU earlier to
detect the missing module, and assume all is safe if it is
present.

> 
> Before modules, object_new(T) was safe unless T was user-provided.
> Which implies it's safe when T is a literal string.
> 
> Since modules, object_new(T) is safe unless T is user-provided or the
> type named by it is compiled as module.  This does *not* imply it's safe
> when T is a literal string.

Agreed. 

> When looking at a use of object_new(), whether the argument names a type
> that could be compiled as module cannot be known locally.  Therefore, we
> cannot know locally whether we need to handle failure, either with a
> suitable guard or by switching to a new function like
> object_new_dynamic().  This is bad.
>
> Breaking fundamental design assumptions tends to have ugly and expensive
> consequences.  Consequences like having to rework every single call of
> object_new() & friends.
> 
> Can we reduce the damage?  Maybe.  What if we create a
> module_object_new() that takes an Error **, and make object_new() crash
> & burn when the @typename argument resolves to a type provided by a
> module?

I'm doubtful about a design where maintainers have to choose the
right API, based on mental knowledge of what is a module or not.
The place where object_new is called is typically distinct from
the module impl, so the knowledge is separated. This opens the
door to forgetting to change code from object_new to module_object_new.
This is what motivated my attempt to try to force compile time errors
scenarios which had a high chance of being user specified types.

I don't have a good answer for how to extend compile time validation
to cover non-user specified types that might be modules, without
changnig 'object_new' itself to add "Error **errp" and convert as
many callers as possible to propagate errors. That's a huge pile
of tedious work and in many cases would deteriorate  to &error_abort
since some key common use scenarios lack a "Error *errp" to propagate
into.

> Maybe module_object_new() and object_new_dynamic() could be fused into a
> single function with a better name.
> 
> > With this series, my objections to Peter Xu's singleton series[1]
> > would be largely nullified.
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05524.html
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


