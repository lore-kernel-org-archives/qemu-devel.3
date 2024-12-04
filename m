Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52897E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 11:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tInEs-0006sn-5B; Wed, 04 Dec 2024 06:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tInEp-0006sQ-4k
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 06:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tInEk-0004vM-8r
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 06:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733310484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVjLt2FuU1f+kieAlC1HY6wXllTbrNBPMl4W7SuSYbU=;
 b=FJFmLhm79EURbgQpa7CT7eBk0SiI2oVj01j6NAPOpHnXCwghGtQOh+ouF8x/I81lWYsU4/
 Cw0gFVNBoYBD8MG/gFrkVEQhxPiQayjPk0p366sEGzuujkcH/pPCmXF6KaFY7JGdaNIBsg
 llZ4+r+QnF03cX6nvvf/tDBgXItwqO0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-tPMzWZsNPxCeIvcckWkg6w-1; Wed,
 04 Dec 2024 06:08:03 -0500
X-MC-Unique: tPMzWZsNPxCeIvcckWkg6w-1
X-Mimecast-MFC-AGG-ID: tPMzWZsNPxCeIvcckWkg6w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA2F11955D4E
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2024 11:08:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7234A1956054
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2024 11:08:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4349A21E66D2; Wed,  4 Dec 2024 12:07:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v3 0/9] Require error handling for dynamically created
 objects
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 15 Nov 2024 17:25:12
 +0000")
References: <20241115172521.504102-1-berrange@redhat.com>
Date: Wed, 04 Dec 2024 12:07:58 +0100
Message-ID: <87a5dbln8x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> NB, this series is targetting 10.0, NOT for 9.2 freeze.
>
> With code like
>
>     Object *obj =3D object_new(TYPE_BLAH)
>
> the caller can be pretty confident that they will successfully create
> an object instance of TYPE_BLAH. They know exactly what type has been
> requested, so it passing an abstract type for example, it is a clear
> programmer error that they'll get an assertion failure.
>
> Conversely with code like
>
>    void somefunc(const char *typename) {
>       Object * obj =3D object_new(typename)
>       ...
>    }
>
> all bets are off, because the call of object_new() knows nothing
> about what 'typename' resolves to.

We know nothing *locally*.

Commonly, a non-local argument can demonstrate safety.  Only when the
type name comes from the user, we truly know nothing.

>                                    It could easily be an abstract
> type.

It could also be no type at all.

>       As a result, many code paths have added a manual check ahead
> of time
>
>    if (object_class_is_abstract(typename)) {
>       error_setg(errp, ....)
>    }

Actually, object_class_is_abstract() takes an ObjectClass, not a type
name string.

The actual guards we use are variations of

    klass =3D object_class_by_name(typename);
    if (!klass) {
        error_setg(errp, "invalid object type: %s", typename);
        return NULL;
    }

    if (object_class_is_abstract(klass)) {
        error_setg(errp, "object type '%s' is abstract", typename);
        return NULL;
    }

which covers "no type at all", too.

Sometimes, we use module_object_class_by_name() instead, which I believe
additionally loads the module providing the type, if any.  Which of the
two should be used where is a mystery to me, and I suspect we're getting
it wrong in places.  But this is turning into a digression.  To
hopefully maintain focus, I'm pretending modules don't exist until later
in this message.

Sometimes, we throw in an object_class_dynamic_cast(klass, T) to check
@typename resolves to a subtype of some T.

> ...except for where we forget to do this, such as qdev_new().

We did not forget it there!  It's by design a thin wrapper around
object_new(), with preconditions just like object_new().

> Overall 'object_new' is a bad design because it is inherantly
> unsafe to call with unvalidated typenames.

To be fair, object_new() was not designed for use with user-provided
type names.  When it chokes on type names not provided by the user, it's
clearly a programming error, and assert() is a perfectly fine way to
catch programming errors.  Same for qdev_new().

However, we do in fact use these functions with user-provided type
names, if rarely.  When we do, we need to validate the type name before
we pass it to them.

Trouble is the validation code is a bit involved, and reimplementing it
everywhere it's needed is asking for bugs.

Creating and using more interfaces that are more convenient for this
purpose would avoid that.

> This problem is made worse by the proposal to introduce the idea
> of 'singleton' classes[1].
>
> Thus, this series suggests a way to improve safety at build
> time. The core idea is to allow 'object_new' to continue to be
> used *if-and-only-if* given a static, const string, because that
> scenario indicates the caller is aware of what type they are
> creating at build time.
>
> A new 'object_new_dynamic' method is proposed for cases where
> the typename is dynamically chosen at runtime. This method has
> an "Error **errp" parameter, which can report when an abstract
> type is created, leaving the assert()s only for scenarios which
> are unambiguous programmer errors.
>
> With a little macro magic, we guarantee a compile error is
> generated if 'object_new' is called with a dynamic type, forcing
> all potentially unsafe code over to object_new_dynamic.

Three cases:

1. Type name is literal string.  No change.  This is the most common
   case.

2. It's not.

2a. Type name is user-provided.  This is rare.  We replace

        if (... guard ...) {
            ... return failure ...
        }
        obj =3D object_new(...);

    by

        obj =3D object_new_dynamic(..., errp);
        if (!obj) {
            ... return failure ...
        }

    This is an improvement.

2b. It's not.  We should replace

        obj =3D object_new(...);

    by

        obj =3D object_new_dynamic(..., &error_abort);

    Exact same behavior, just wordier, to placate the compiler.
    Tolerable as long as it's relatively rare.

    But I'm not sure it's worthwhile.  All it really does is helping
    some towards not getting case 2a wrong.  But 2a is rare.

Same for similar interfaces, e.g. qdev_new().

> This is more tractable than adding 'Error **errp' to 'object_new'
> as only a handful of places use a dynamic type name.

True!

Alright, enter modules.

Modules break a fundamental design assumption: object_new() on a
compiled-in type name is safe, i.e. the failure modes are all
programming errors.

Modules add new failure modes that are *not* programming errors:

* The module providing the type was not deployed correctly.

* It was, but the host system lacks the resources to load it.

Before modules, object_new(T) was safe unless T was user-provided.
Which implies it's safe when T is a literal string.

Since modules, object_new(T) is safe unless T is user-provided or the
type named by it is compiled as module.  This does *not* imply it's safe
when T is a literal string.

When looking at a use of object_new(), whether the argument names a type
that could be compiled as module cannot be known locally.  Therefore, we
cannot know locally whether we need to handle failure, either with a
suitable guard or by switching to a new function like
object_new_dynamic().  This is bad.

Breaking fundamental design assumptions tends to have ugly and expensive
consequences.  Consequences like having to rework every single call of
object_new() & friends.

Can we reduce the damage?  Maybe.  What if we create a
module_object_new() that takes an Error **, and make object_new() crash
& burn when the @typename argument resolves to a type provided by a
module?

Maybe module_object_new() and object_new_dynamic() could be fused into a
single function with a better name.

> With this series, my objections to Peter Xu's singleton series[1]
> would be largely nullified.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05524.html


