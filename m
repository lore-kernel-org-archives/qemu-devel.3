Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452D9D3E79A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTazj-0001CE-VX; Thu, 11 Dec 2025 02:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTazf-0001Bq-Jy
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTazZ-0006DZ-Fa
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765437696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ilzcr8DM/OGBl4r8/eUGlwmgnfGKpf0ZaDGZCNUAUTc=;
 b=D4GuIYnOuh+JKAWPMpNCD3nqTDJx4rR94iRegcikDl9y+bk3BQC0438DNQlGJO28WYtEk6
 3BWF/creIBeO7E2/sMUbuQJTOmLvxWPI53xnDXyUkevUiQlMrU+9StTANBSnFFuLcVjT7j
 3c+VZWvN8PJUs5fBDAN4+aq6ar/l5Ro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-secZkMd_MHiCZGGcCE6lLw-1; Thu,
 11 Dec 2025 02:21:33 -0500
X-MC-Unique: secZkMd_MHiCZGGcCE6lLw-1
X-Mimecast-MFC-AGG-ID: secZkMd_MHiCZGGcCE6lLw_1765437692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78ED91956080; Thu, 11 Dec 2025 07:21:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFA25180045B; Thu, 11 Dec 2025 07:21:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EEEA21E6A27; Thu, 11 Dec 2025 08:21:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  qemu-rust@nongnu.org
Subject: Re: [PATCH 04/19] rust/qobject: add basic bindings
In-Reply-To: <c99be3c6-7301-4230-aacf-deeef4b99885@redhat.com> (Paolo
 Bonzini's message of "Fri, 5 Dec 2025 12:27:54 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-5-pbonzini@redhat.com>
 <875xalz2y6.fsf@pond.sub.org>
 <c99be3c6-7301-4230-aacf-deeef4b99885@redhat.com>
Date: Thu, 11 Dec 2025 08:21:29 +0100
Message-ID: <87bjk55vra.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 12/5/25 10:35, Markus Armbruster wrote:
>>> +/// A wrapper for a C `QObject`.
>>> +///
>>> +/// Because `QObject` is not thread-safe, the safety of these bindings
>>> +/// right now hinges on treating them as immutable.  It is part of the
>>> +/// contract with the `QObject` constructors that the Rust struct is
>>> +/// only built after the contents are stable.
>>> +///
>>> +/// Only a bare bones API is public; production and consumption of `QObject`
>>> +/// generally goes through `serde`.
>>> +pub struct QObject(&'static UnsafeCell<bindings::QObject>);
>> 
>> This defines the Rust QObject.  All it contains is a reference (wrapped
>> in UnsafeCell) self.0 to the C QObject.  Correct?
>
> Correct.
>
>>> +
>>> +// SAFETY: the QObject API are not thread-safe other than reference counting;
>>> +// but the Rust struct is only created once the contents are stable, and
>>> +// therefore it obeys the aliased XOR mutable invariant.
>> 
>> In other words, we promise never to change a QObject while Rust code
>> holds a reference, except for the reference counts.  Correct?
>> 
>> The reference count is the mutable part of an otherwise immutable
>> object.  Not mentioned here: it is atomic.  Therefore, concurrent
>> updates cannot mess it up.  Nothing depends on its value except
>> deallocation when the last reference drops.  I figure that's why the
>> exception to "aliased XOR mutable" is fine.  Correct?
>
> Yes, it's one of a few exceptions to "aliased XOR mutable" including:
>
> - Mutex (because only one guy can access it at all anyway)
>
> - RefCell (enforces aliased XOR mutable at run-time, enforces 
> single-thread usage at compile-time)
>
> - atomics (a mini mutex)
>
> - Cell (Mutex:RefCell = atomics:Cell, in other words every access is 
> independent but also single-thread usage is checked at compile time)
>
>>> +unsafe impl Send for QObject {}
>>> +unsafe impl Sync for QObject {}
>>> +
>>> +// Since a QObject can be a floating-point value, and potentially a NaN,
>>> +// do not implement Eq
>>> +impl PartialEq for QObject {
>>> +    fn eq(&self, other: &Self) -> bool {
>>> +        unsafe { bindings::qobject_is_equal(self.0.get(), other.0.get()) }
>>> +    }
>>> +}
>>> +
>>> +impl QObject {
>>> +    /// Construct a [`QObject`] from a C `QObjectBase` pointer.
>> 
>> It's spelled QObjectBase_.  More of the same below, not flagging again.
>> 
>> Comment next to its definition:
>> 
>>      /* Not for use outside include/qobject/ */
>> 
>> We're using it outside now.  Do we really need to?
>
> It's because we're defining equivalents of inline functions in 
> include/qobject.

Fair, but we should update comments when we make them wrong :)

> I can however replace uses of from_base with a macro similar to QOBJECT()

Might be cleaner.

>>> +    /// Obtain a raw C pointer from a reference. `self` is consumed
>>> +    /// and the C `QObject` pointer is leaked.
>> 
>> What exactly do you mean by "leaked"?
>
> s/and the.*/without decreasing the reference count, thus transferring 
> the reference to the `*mut bindings::QOjbect`/

Much clearer.

>>> +    pub fn into_raw(self) -> *mut bindings::QObject {
>>> +        let src = ManuallyDrop::new(self);
>>> +        src.0.get()
>>> +    }
>>> +
>>> +    /// Construct a [`QObject`] from a C `QObject` pointer.
>> 
>> Pasto?  Isn't it QObjectBase_ here?
>
> Yes.
>
>>> +impl From<()> for QObject {
>>> +    fn from(_null: ()) -> Self {
>>> +        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.base)) }
>> 
>> qnull_ is not meant for use outside qnull.[ch] and its unit test
>> check-qnull.c.  Could we use qnull()?
>
> Same as above---it's inline.  The above is a translation of
>
> static inline QNull *qnull(void)
> {
>      return qobject_ref(&qnull_);
> }

Could we call C qnull() instead?

>>> +macro_rules! from_double {
>>> +    ($t:ty) => {
>>> +        impl From<$t> for QObject {
>>> +            fn from(n: $t) -> Self {
>>> +                let qobj = unsafe { &*bindings::qnum_from_double(n.into()) };
>>> +                unsafe { QObject::from_base(addr_of!(qobj.base)) }
>>> +            }
>>> +        }
>>> +    };
>>> +}
>>> +
>>> +from_double!(f32);
>> 
>> Uh, isn't the double in from_double misleading?
>
> It's a reference to the function that it calls (qnum_from_double).  Can 
> rename it to impl_from_returning_qnum_double.
>
>>> +from_double!(f64);
>> 
>> Can you briefly explain why we need more than i64, u64, and double?
>
> Because Rust doesn't do automatic casts.  So it's nicer (and also less 
> error prone) if the subsequent patches do not have to always convert to 
> u64 or i64.

Okay.

>> Skipping the remainder, it's too much macro magic for poor, ignorant me
>> :)
>
> It's not really hard.  The thing to the left of => effectively defines a 
> parser. Each thing of the shape $IDENT:RULE matches a piece of Rust 
> grammar; expr is expression an tt is token tree (either a single token 
> or a parenthesized group).  To access $IDENT that appears within $(...)? 
> on the left of => you must have a similar $(...)? on the right, and the 
> whole $(...)? on the right will be skipped if the left-side wasn't there.
>
> The macro is used like this:
>
>          match_qobject! { (self) =>
>              () => Unexpected::Unit,
>              bool(b) => Unexpected::Bool(b),
>              i64(n) => Unexpected::Signed(n),
>              u64(n) => Unexpected::Unsigned(n),
>              f64(n) => Unexpected::Float(n),
>              CStr(s) => s.to_str().map_or_else(
>                  |_| Unexpected::Other("string with invalid UTF-8"),
>                  Unexpected::Str),
>              QList(_) => Unexpected::Seq,
>              QDict(_) => Unexpected::Map,
>          }
>
> And it produces a "switch" on QObject types, where each "case" extracts 
> the datum, places it in the variable to the left of "=>" (such as "b" 
> for bool), and returns the value on the right of "=>" (such as 
> "Unexpected::Bool(b)"):
>
>
>>> +    ) => {
>>> +        loop {
>>> +            let qobj_ = $qobj.0.get();
>>> +            match unsafe { &* qobj_ }.base.type_ {
>>> +                $($crate::bindings::QTYPE_QNULL => break $unit,)?
>>> +                $($crate::bindings::QTYPE_QBOOL => break {
>>> +                    let qbool__: *mut $crate::bindings::QBool = qobj_.cast();
>>> +                    let $boolvar = unsafe { (&*qbool__).value };
>>> +                    $bool
>>> +                },)?
>
> (The loop/break is just a syntactic convenience---the loop never rolls 
> more than once).
>
> Paolo

Thanks for your help!


