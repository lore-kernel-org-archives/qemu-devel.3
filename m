Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D94CC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 05:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMgFb-0002Cs-Dj; Wed, 04 Jun 2025 01:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMgFZ-0002CW-Eh
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 01:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMgFX-0006xG-EZ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 01:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749013273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9U7DFJXfWf/vKvMUHBf190NKh4qVaL+xxhXe/H3kfL0=;
 b=DKioXuJOy40zp7gJyWk75i9TIm5uMd8Q7HnFRr78xxNaSctpESJFi2cL40TlEktpyzDY9j
 R9wmKPzLTkz68XxLJUto0naUDfbbHbb6NDJdulYUWT4LeNWyvZjlSjP9sXUZLZ3okcGX2E
 jOMwE9jMdU9m+GLcPv0d42as9FQqwYY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-2mnGsU4qMv-7wbpkYTm56g-1; Wed,
 04 Jun 2025 01:01:09 -0400
X-MC-Unique: 2mnGsU4qMv-7wbpkYTm56g-1
X-Mimecast-MFC-AGG-ID: 2mnGsU4qMv-7wbpkYTm56g_1749013268
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D41B19560B7; Wed,  4 Jun 2025 05:01:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2BFA19560A3; Wed,  4 Jun 2025 05:01:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E79921E66C3; Wed, 04 Jun 2025 07:01:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
In-Reply-To: <2b7be73c-d91f-4820-a8ad-6964a8331150@redhat.com> (Paolo
 Bonzini's message of "Tue, 3 Jun 2025 17:05:59 +0200")
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com>
 <877c1uffj3.fsf@pond.sub.org> <aD7AbxghCc5VYDhu@intel.com>
 <8734ch5d5c.fsf@pond.sub.org>
 <2b7be73c-d91f-4820-a8ad-6964a8331150@redhat.com>
Date: Wed, 04 Jun 2025 07:01:05 +0200
Message-ID: <871ps02j8u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/3/25 12:32, Markus Armbruster wrote:
>>> Then Rust's propagate has the same behavior as C (Of course, here Rust
>>> is actually using C's error_propagate, so the two are equivalent.)
>>=20
>> *If* we want propagate semantics.  I'm not sure we do.
>
> Yes, we do.  This function is used at the Rust-to-C boundary and should=20
> behave exactly like C functions would: it will get an Error ** from the=20
> callers and needs to propagate the just-created Error* into it.

Well, how *do* C functions behave?

 * =3D Rules =3D
 *
 * - Functions that use Error to report errors have an Error **errp
 *   parameter.  It should be the last parameter, except for functions
 *   taking variable arguments.
 *
 * - You may pass NULL to not receive the error, &error_abort to abort
 *   on error, &error_fatal to exit(1) on error, or a pointer to a
 *   variable containing NULL to receive the error.

For later...  This is a precondition.  passing a pointer to a variable
containing anything but NULL violates the precondition.

 *
 * - Separation of concerns: the function is responsible for detecting
 *   errors and failing cleanly; handling the error is its caller's
 *   job.  Since the value of @errp is about handling the error, the
 *   function should not examine it.
 *
 * - The function may pass @errp to functions it calls to pass on
 *   their errors to its caller.  If it dereferences @errp to check
 *   for errors, it must use ERRP_GUARD().
 *
 * - On success, the function should not touch *errp.  On failure, it
 *   should set a new error, e.g. with error_setg(errp, ...), or
 *   propagate an existing one, e.g. with error_propagate(errp, ...).

This is what your FOO_or_propagate() functions are for.

The rule glosses over a subtle detail: the difference between
error_setg() and error_propagate() isn't just create a new error vs. use
an existing one, namely error_setg() makes the precondition violation
mentioned above a programming error, whereas error_propagate() does not,
it instead *ignores* the error it's supposed to propagate.

I consider this difference a design mistake.  Note that GError avoids
this mistake: g_error_propagate() requieres the destination to NULL or
point to NULL.  We deviated from GError, because we thought we were
smarter.  We weren't.

Mostly harmless in practice, as behavior is identical for callers that
satisfy the preconditions.

 *
 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.

So here's the bottom line.  We want a Rust function to use C Error
according to its written rules.  Due to a design mistake, C functions
can behave in two different ways when their caller violates a certain
precondition, depending on how the function transmits the error to the
caller.  For Rust functions, we can

* Always behave the more common way, i.e. like a C function using
  error_setg() to transmit.

* Always behave the less common way, i.e. like a C function using
  error_propagate() to transmit.

* Sometimes one way, sometimes the other way.

This is actually in order of decreasing personal preference.  But what
do *you* think?

> In fact, I had found this issue already last Friday, but then didn't=20
> inform you because of the (long) weekend.  Apologies for that.

No harm, no foul :)


