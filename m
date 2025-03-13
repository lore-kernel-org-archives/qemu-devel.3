Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17DBC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnnD-0004UY-FU; Thu, 13 Mar 2025 15:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsnmw-0004KL-V1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsnmm-0005xz-QS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741892402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pq5C99W1BLCXyD4U+3CrHf4D6lhNZQgfVdL9ZiMO41Y=;
 b=afEpna3w24WjCkFs0T28eZKrZJXcGuROhnpR9apoj9pDvFuv2qA55kE5xIdwYWMmmNb8ES
 GlVIRCN4pLesGioE9HaEiDnnYDGXC9BvkOb+prAO56t57jQlmLymiz5YNTpbkAwi1r4+uX
 D4mkCvhXUEAweW/LTddFV4Av6jZoZJo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-gHiFp-ktPFewLOnaCB_qVg-1; Thu, 13 Mar 2025 15:00:00 -0400
X-MC-Unique: gHiFp-ktPFewLOnaCB_qVg-1
X-Mimecast-MFC-AGG-ID: gHiFp-ktPFewLOnaCB_qVg_1741892399
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff55176edcso2305154a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741892399; x=1742497199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pq5C99W1BLCXyD4U+3CrHf4D6lhNZQgfVdL9ZiMO41Y=;
 b=NX+QroSXpNPCY+JhDR+ROO6MteTdGaaqdD6co12d8ED7ArDm2uhrshwm1IAJAHnvxr
 k4yy6WXxjXXjh1Fh0htY/ZMURnSgdR8j2lo4inbQuaJ+tmJP6RbQUbvge81mCGYIpLIf
 oYb741UArw4ackDkQv4bLlr86jI+bDVUI94f+ZuSl5OsClWP90fP3gzztUKSzaxaHOG9
 HLmpBosCVBjIaaz4tecsRrlfHXix504ritnvKn2S8dPWBX5E8WMcbnys3vDvOVv3Rr/l
 PUlJxZusiH0VE5r7K/n0a4pATtoVEJ29WSOYPg9Jh3E3bJKpziz446TNVba1TmLpXA9Y
 fwvw==
X-Gm-Message-State: AOJu0Yytd+0WMO3ujgUzvaXHUjWCh1slpyFACnEsXwDBSyw3JvM+Yydj
 hAPj8ECt9yDhcnNNAWa9N4voViR+0Jvnt7WVXUcoX2tfDRxuCYq9NqIPFmAM5Gss+3+p6toIlZy
 R9XVqhwFgu6DP2UARegr2z6weNaWIqLP2Xdlq1KcL7V3rAs/BYgLKVNfSvvKxcc21APkDoNwWH0
 ThyKx6o5dDhNeffTlbH7fEU3SFxNw=
X-Gm-Gg: ASbGncsPdZCGN8mRT0+Tf35MndFGaGecypz+HpDn1A3n4Ru7bYmhDLxPiyO0eVmqiUy
 a3TwP9eruzT3YDobYW5JT5hPUUEAyBiH7MWFAmaSm9EOTW0MyO+jd9z6EFe6znsD0unEeAtchcQ
 JDJHP+7f4GRi7w3HA8d4iNqEx1ReUM
X-Received: by 2002:a17:90b:5688:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-3014e839fc4mr832651a91.10.1741892398900; 
 Thu, 13 Mar 2025 11:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs2bIOJjvvGdHvj8H7xrTe3G2RfE5rsofkrVIjOA5Rt/Lo2dCpKaV7aPHHwY+pKbKc2a2cdjfnw5cy1zYEJIo=
X-Received: by 2002:a17:90b:5688:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-3014e839fc4mr832628a91.10.1741892398504; Thu, 13 Mar 2025
 11:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
 <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
 <87ikod56zf.fsf@pond.sub.org>
 <CAFn=p-b8xsWJw4kROKFUDbBNuJU32_oyktUMB+F5gsE=M9S72w@mail.gmail.com>
 <87o6y43our.fsf@pond.sub.org>
 <CAFn=p-a90ujkHX5abhrW9SoGLp08vPt2W_EE3M3=4c6mTZJVJg@mail.gmail.com>
 <87sengzsu1.fsf@pond.sub.org>
In-Reply-To: <87sengzsu1.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Mar 2025 14:59:44 -0400
X-Gm-Features: AQ5f1JoBIdzDDG_XSusBoAEBq_ZlUaWla5wby-7LzoPY-z6_dXLUwxiIb4b6eBQ
Message-ID: <CAFn=p-YSuD1wso3WFyY02zVowcPccMZy7abePdqZcN7CZBOF7g@mail.gmail.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a67d9406303dedca"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000a67d9406303dedca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:30=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Mar 13, 2025, 11:57=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster <armbru@r=
edhat.com
> >
> >> > wrote:
> >> >
> >> >> John Snow <jsnow@redhat.com> writes:
> >> >>
> >> >> > On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster <
> armbru@redhat.com> wrote:
> >> >> >
> >> >> >> John Snow <jsnow@redhat.com> writes:
> >> >> >>
> >> >> >> > This patch does three things:
> >> >> >> >
> >> >> >> > 1. Record the current namespace context in pending_xrefs so it
> can be
> >> >> >> >    used for link resolution later,
> >> >> >> > 2. Pass that recorded namespace context to find_obj() when
> resolving a
> >> >> >> >    reference, and
> >> >> >> > 3. Wildly and completely rewrite find_obj().
> >> >> >> >
> >> >> >> > cross-reference support is expanded to tolerate the presence o=
r
> absence
> >> >> >> > of either namespace or module, and to cope with the presence o=
r
> absence
> >> >> >> > of contextual information for either.
> >> >> >> >
> >> >> >> > References now work like this:
> >> >> >> >
> >> >> >> > 1. If the explicit reference target is recorded in the domain'=
s
> object
> >> >> >> >    registry, we link to that target and stop looking. We do
> this lookup
> >> >> >> >    regardless of how fully qualified the target is, which
> allows direct
> >> >> >> >    references to modules (which don't have a module component
> to their
> >> >> >> >    names) or direct references to definitions that may or may
> not belong
> >> >> >> >    to a namespace or module.
> >> >> >> >
> >> >> >> > 2. If contextual information is available from qapi:namespace =
or
> >> >> >> >    qapi:module directives, try using those components to find =
a
> direct
> >> >> >> >    match to the implied target name.
> >> >> >> >
> >> >> >> > 3. If both prior lookups fail, generate a series of regular
> expressions
> >> >> >> >    looking for wildcard matches in order from most to least
> >> >> >> >    specific. Any explicitly provided components (namespace,
> module)
> >> >> >> >    *must* match exactly, but both contextual and entirely
> omitted
> >> >> >> >    components are allowed to differ from the search result.
> Note that if
> >> >> >> >    more than one result is found, Sphinx will emit a warning (=
a
> build
> >> >> >> >    error for QEMU) and list all of the candidate references.
> >> >> >> >
> >> >> >> > The practical upshot is that in the large majority of cases,
> namespace
> >> >> >> > and module information is not required when creating simple
> `references`
> >> >> >> > to definitions from within the same context -- even when
> identical
> >> >> >> > definitions exist in other contexts.
> >> >> >>
> >> >> >> Can you illustrate this this examples?
> >> >> >>
> >> >> >
> >> >> > do wha?
> >> >>
> >> >> Sorry, I went into the curve too fast.
> >> >>
> >> >> The stuff under "References now work like this" confuses me.  I
> guess it
> >> >> describes a series of lookups to try one after the other.
> >> >>
> >> >> I understand a cross-reference consists of namespace (optional),
> module
> >> >> (optional), name, and role.
> >> >>
> >> >> Let's assume role is "any" for simplicity's sake.
> >> >>
> >> >> Regarding "1. If the explicit ...":
> >> >>
> >> >>     What is a reference's "explicit reference target"?  Examples
> might
> >> >>     help me understand.
> >> >>
> >> >
> >> > explicit lookup: `QMP:block-core:block-dirty-bitmap-add`
> >> >
> >> > If that explicit target matches an object in the object database
> >> > *directly*, we match immediately and don't consider other potential
> >> > targets. This also applies to things like modules, e.g.
> `QMP:block-core`
> >> > even though the "module" is absent (it IS the module)
> >> >
> >> > We always search for the explicit target no matter how un/fully
> qualified
> >> > it is.
> >> >
> >> >
> >> >>
> >> >>     What is "recorded in the domain's object registry"?
> >> >>
> >> >
> >> > domain.objects{} - essentially a record of every ObjectDefinition's
> >> > "fullname" - the return value from QAPIDefinition._get_fqn().
> >> >
> >> >
> >> >>
> >> >>     Can you show me a reference where this lookup succeeds?
> >> >>
> >> >
> >> > `QMP:block-core`
> >> > `QMP:block-core.block-dirty-bitmap-add`
> >>
> >> So, for this lookup to work, the reference must either be of the form
> >> NAMESPACE:MODULE and resolve to that module in that namespace, or of t=
he
> >> form NAMESPACE:MODULE:DEFN and resolve to that definition in that modu=
le
> >> in that namespace.  Correct?
> >>
> >
> > Yes.
> >
> >
> >> These a "fully qualified names (FQN)" in your parlance, right?
> >>
> >
> > More or less, though as you found below...
> >
> >
> >> Note that the first form is syntactically indistinguishable from
> >> NAMESPACE:DEFN, i.e. a reference to a definition that specifies the
> >> namespace, but not the module.
> >>
> >> If the NAMESPACE:MODULE interpretation resolves, we never try the
> >> NAMESPACE:DEFN interpretation, because that happens in later steps.
> >> Correct?
> >>
> >> The first form is fully qualified only if it resolves as FQN.  So,
> >> whether such a reference is fully qualified is not syntactically
> >> decidable.  Hmm.
> >>
> >
> > You're right. There is a weirdness here. I might need to do some more
> > thinking to make sure it isn't theoretically a problem, but in practice=
,
> > right now, it isn't.
>
> Not a blocker, but please do your thinking :)
>
> > Stay tuned, I guess.
> >
> >
> >> >> Regarding "2. If contextual information ...":
> >> >>
> >> >>     I guess "contextual information" is the context established by
> >> >>     qapi:namespace and qapi:module directives, i.e. the current
> >> >>     namespace and module, if any.
> >> >>
> >> >
> >> > Yep!
> >> >
> >> >
> >> >>
> >> >>     If the cross reference lacks a namespace, we substitute the
> current
> >> >>     namespace.  Same for module.
> >> >>
> >> >>     We then use that "to find a direct match to the implied target
> >> >>     name".  Sounds greek to me.  Example(s) might help.
> >> >>
> >> >
> >> > If namespace or module is missing from the link target, we try to
> fill in
> >> > the blanks with the contextual information if present.
> >> >
> >> > Example, we are in the block-core section of the QEMU QMP reference
> manual
> >> > document and we reference `block-dirty-bitmap-add`. With context, we
> are
> >> > able to assemble a fully qualified name:
> >> > "QMP:block-core.block-dirty-bitmap-add`. This matches an item in the
> >> > registry directly, so it matches and no further search is performed.
> >>
> >> We try this lookup only when the reference lacks a namespace and we ar=
e
> >> "in" a namespace, or when it lacks a module and we are "in" a module.
> >> Correct?
> >>
> >
> > or both: if we provided only a name but the context has both a namespac=
e
> > and module.
>
> So my or is inclusive :)
>
> > essentially the algorithm splits the explicit target into (ns, mod, nam=
e)
> > and for any that are blank, we try to fill in those blanks with context
> > info where available. Sometimes you have neither explicit nor contextua=
l
> > info for a component.
> >
> > Then we do a lookup for an exact match, in order;
> >
> > 1. explicit target name, whatever it was
>
> Fully qualified name.
>

Yes, for lookup to succeed it should be fully qualified, though if the
target text is "ns:module", that's actually going to succeed here, too.


>
> If lookup succeeds, we're done.
>
> If lookup fails, we're also done.
>

If lookup fails, we actually continue on to #2, but whether or not this
does anything useful depends on whether or not the original target text was
fully qualified or not. If it was, #2 searches with the exact same text and
will fail again and proceed to #3, where because we had a fully qualified
name, none of the search conditions apply and we then just exit.

(It just lacks an early return, but abstractly, if lookup on #1 fails with
a fully qualified name, we are indeed done.)

If lookup fails because it wasn't actually fully qualified, then #2 has
some gaps to try to fill.


>
> *Except* for the ambiguous form NAMESPACE:MYSTERY.  If lookup fails for
> that, the name is not fully qualified after all.  Probably.  Maybe.  We
> assume it's missing a module, and proceed to 2.
>
> I'm mostly ignoring this exception from now on to keep things simple.
>
> > 2. FQN using contextual info
>
> Partially qualified name, but context can fill the gaps.
>
> If lookup succeeds, we're done.
>
> Else, we proceed to 3.
>

That's right.


>
> > and we stop after the first hit - no chance for multiple results here,
> just
> > zero-or-one each step.
> >
> > i.e. any explicitly provided information is never "overwritten" with
> > context, context only fills in the blanks where that info was not
> provided.
> >
> > If neither of these work, we move on to fuzzy searching.
> >
> >
> >> We then subsitute current namespace / module for the lacking one(s), a=
nd
> >> try the same lookup as in 1.  Correct?
> >>
> >
> > Yes!
> >
> >
> >> If we have a reference of the form MYSTERY, it could either be a
> >> reference to module MYSTERY in the current namespace, or to definition
> >> MYSTERY in the current namespace and module.  How do we decide?
> >>
> >
> > fqn a: NS:MYSTERY
> > fqn b: NS:MOD:MYSTERY
> >
> > Given we have a current ns/mod context, it's going to pick the second
> one.
> >
> > Hm. Maybe it ought to be ambiguous in this case... I'll have to revise
> > this. (question is: how soon do we need it?)
>
> While we should try to put this on a more solid foundation, it is not a
> blocker.
>
> >> >> Regarding "3. If both prior lookups fail ...":
> >> >>
> >> >>     I guess we get here when namespace or module are absent, and
> >> >>     substituting the current namespace or module doesn't resolve.  =
We
> >> >>     then substitute a wildcard, so to speak, i.e. look in all
> namespaces
> >> >>     / modules, and succeed if we find exactly one resolution.  Fair=
?
> >> >>
> >> >
> >> > More or less, though the mechanics are quite a bit more complex than
> your
> >> > overview (and what I wrote in qapi-domain.rst.) We can get here for =
a
> few
> >> > reasons:
> >> >
> >> > (1) We didn't provide a fully qualified target, and we don't have fu=
ll
> >> > context to construct one.
>
> We skipped 1. because not fully qualified, and we skipped 2. because
> context can't fill the gaps.
>

we tried #1 and failed, then we tried #2 and failed again.


>
> >> >                           For example, we are not "in" a namespace
> and/or
> >> > not "in" a module. This is quite likely to happen when writing simpl=
e
> >> > references to a definition name from outside of the transmogfrified
> QAPI
> >> > documentation, e.g. from qapi-domain.rst itself, or
> dirty-bitmaps.rst, etc.
>
> Yes.
>
> >> > (2) We didn't provide a fully qualified target, and we are referenci=
ng
> >> > something from outside of the local context. For example, we are "in=
"
> a
> >> > module but we are trying to link to a different module's definition.
> e.g.
> >> > we are in QMP:transaction and we reference `block-dirty-bitmap-add`.
> The
> >> > implied FQN will be QMP:transaction.block-dirty-bitmap.add, which
> will not
> >> > resolve.
>
> We skipped 1. because not fully qualified, and we failed 2. because
> context filled the gaps, but lookup failed.
>

Failed #1 and Failed #2.


>
> >> >
> >> > The fuzzy search portion has an order of precedence for how it
> searches -
> >> > and not all searches are tried universally, they are conditional to
> what
> >> > was provided in the reference target and what context is available.
> >> >
> >> > 1. match against the explicitly provided namespace (module was not
> >> > explicitly provided)
> >>
> >> Look for the name in all of the namespace's modules?
> >>
> >
> > Yeah. search for "ns:*.name" and "ns:name" basically.
>
> Got it.
>
> >> > 2. match against the explicitly provided module (namespace was not
> >> > explicitly provided)
> >>
> >> Look for the name in all modules so named in all namespaces?
> >>
> >
> > Yes.
>
> Got it.
>
> >> > 3. match against the implied namespace (neither namespace/module was
> >> > explicitly provided)
> >>
> >> ?
> >>
> >
> > User gave `foo`, but we have a namespace from context, so we look for
> > ns:*.foo or ns:foo.
>
> Got it.
>
> Detail I had not considered until now: a namespace contains modules that
> contain definitions, but it also contains definitions directly.
>
> I can't recall offhand how schema.py represents this.  I'll figure it
> out and report back.
>

I think it gets charged to a module named "qapi-schema". Silly, but it
doesn't really break anything.


> >> > 4. match against the implied module (neither namespace/module was
> >> > explicitly provided)
> >>
> >> ?
> >>
> >
> > User gave `foo`, but we have a module from context, so we search for
> > *:mod.foo and mod.foo
>
> Got it.
>
> >> > 5. match against the definition name only, from anywhere (neither
> >> > namespace/module was explicitly provided)
> >>
> >> Look for the name anywhere?
> >>
> >> I need examples :)
> >>
> >
> > user gave `foo`. search for any qapi definition in all modules and
> > namespaces for anything with the name "foo". The broadest possible
> search.
> >
> > Doesn't search for stuff outside of the QAPI domain directly, but be
> aware
> > when using `references` that all domains are consulted, so it may in fa=
ct
> > match something else from somewhere else, though not by any doing of th=
e
> > qapi domain.
> >
> > i.e. :qapi:any:`foo` will definitely only search using the rules laid o=
ut
> > in this patch/thread, but `foo` will consult all domains (and whine if
> more
> > than one result between all domains is identified.)
>
> Got it, I think.
>
> >> > The searches are performed in order: if a search returns zero
> results, the
> >> > next search is tried. If any search returns one or more results, tho=
se
> >> > results are returned and we stop searching down the list. The priori=
ty
> >> > order ensures that any explicitly provided information is *always*
> used to
> >> > find a match, but contextually provided information is merely a
> "hint" and
> >> > can be ignored for the sake of a match.
> >> >
> >> > If find_obj() as a whole returns zero results, Sphinx emits a warnin=
g
> for a
> >> > dangling reference. if find_obj() as a whole returns multiple result=
s,
> >> > Sphinx emits a warning for the ambiguous cross-reference.
> >> >
> >> > QEMU errors out on any such warnings under our normal build settings=
.
> >> >
> >> > Clear as mud?
> >>
> >> Clearer, but not quite mud, yet.
> >>
> >
> > Ultimately, Search in this order and stop at any point any of these
> > searches return at least one result:
> >
> > 1. Explicitly provided name, whatever it is
> > 2. FQN using contextual info
> > 3. Explicitly provided NS; any module
> > 4. Explicitly provided module; any NS
> > 5. Contextual NS; any module
> > 6. Contextual module; any NS
> > 7. any NS/module.
> >
> > with searches 3-7 being conditional only when the criteria are met:
> >
> > 3. Must have explicit NS (and no explicit module)
> > 4. Must have explicit module (and no explicit NS)
> > 5. Must have contextual NS (must not have explicit NS nor module)
> > 6. Must have contextual module (must not have explicit NS nor module)
> > 7. Must have neither explicit NS nor module.
>

I should point out that:

- #3 and #4 are mutually exclusive
- #5 and #6 are mutually exclusive
- #3/#4 and #5/#6 are mutually exclusive
- Only one of #3/#4/#5/#6 will happen for a given reference.
- If we choose #5 or #6, #7 may also happen. If we choose #3 or #4, #7 will
never happen.

I bet I can make the code here cleaner by combining some of these, it's
just a lot of context on the input to keep in mind while designing the
conditionals, so I wrote it out very "explicitly" to help myself make sense
of it ...


> >
> > In summary:
> >
> > * Anything explicitly provided *must* match. This information is *never=
*
> > ignored.
> > * Anything implicitly provided through context will never overwrite
> > anything explicitly provided. This is used as a *hint* in the event
> > multiple candidates are found, but results are allowed to deviate when
> > stronger matches are not located.
> >
> > i.e. contextual information is used to *prefer* a result from that
> context,
> > but is not used to *limit* you to that context.
> >
> > by contrast, explicit info is used to directly filter and restrict
> search.
>
> Makes sense.
>
> > (With maybe a bug or two for trying to find module names in some
> > circumstances. Will have to check that over...)
>
> Thank you!
>
>
You're welcome!

--000000000000a67d9406303dedca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13,=
 2025 at 2:30=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Mar 13, 2025, 11:57=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster &l=
t;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com<=
/a>&gt;<br>
&gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbr=
uster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@red=
hat.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com=
" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; This patch does three things:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 1. Record the current namespace context in =
pending_xrefs so it can be<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 used for link resolution later=
,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 2. Pass that recorded namespace context to =
find_obj() when resolving a<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 reference, and<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 3. Wildly and completely rewrite find_obj()=
.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; cross-reference support is expanded to tole=
rate the presence or absence<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; of either namespace or module, and to cope =
with the presence or absence<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; of contextual information for either.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; References now work like this:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 1. If the explicit reference target is reco=
rded in the domain&#39;s object<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 registry, we link to that targ=
et and stop looking. We do this lookup<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 regardless of how fully qualif=
ied the target is, which allows direct<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 references to modules (which d=
on&#39;t have a module component to their<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 names) or direct references to=
 definitions that may or may not belong<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 to a namespace or module.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 2. If contextual information is available f=
rom qapi:namespace or<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 qapi:module directives, try us=
ing those components to find a direct<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 match to the implied target na=
me.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; 3. If both prior lookups fail, generate a s=
eries of regular expressions<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 looking for wildcard matches i=
n order from most to least<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 specific. Any explicitly provi=
ded components (namespace, module)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 *must* match exactly, but both=
 contextual and entirely omitted<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 components are allowed to diff=
er from the search result. Note that if<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 more than one result is found,=
 Sphinx will emit a warning (a build<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 error for QEMU) and list all o=
f the candidate references.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; The practical upshot is that in the large m=
ajority of cases, namespace<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; and module information is not required when=
 creating simple `references`<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; to definitions from within the same context=
 -- even when identical<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; definitions exist in other contexts.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Can you illustrate this this examples?<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; do wha?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Sorry, I went into the curve too fast.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The stuff under &quot;References now work like this&quot;=
 confuses me.=C2=A0 I guess it<br>
&gt;&gt; &gt;&gt; describes a series of lookups to try one after the other.=
<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I understand a cross-reference consists of namespace (opt=
ional), module<br>
&gt;&gt; &gt;&gt; (optional), name, and role.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Let&#39;s assume role is &quot;any&quot; for simplicity&#=
39;s sake.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Regarding &quot;1. If the explicit ...&quot;:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0What is a reference&#39;s &quot;explic=
it reference target&quot;?=C2=A0 Examples might<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0help me understand.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; explicit lookup: `QMP:block-core:block-dirty-bitmap-add`<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If that explicit target matches an object in the object datab=
ase<br>
&gt;&gt; &gt; *directly*, we match immediately and don&#39;t consider other=
 potential<br>
&gt;&gt; &gt; targets. This also applies to things like modules, e.g. `QMP:=
block-core`<br>
&gt;&gt; &gt; even though the &quot;module&quot; is absent (it IS the modul=
e)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We always search for the explicit target no matter how un/ful=
ly qualified<br>
&gt;&gt; &gt; it is.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0What is &quot;recorded in the domain&#=
39;s object registry&quot;?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; domain.objects{} - essentially a record of every ObjectDefini=
tion&#39;s<br>
&gt;&gt; &gt; &quot;fullname&quot; - the return value from QAPIDefinition._=
get_fqn().<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Can you show me a reference where this=
 lookup succeeds?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; `QMP:block-core`<br>
&gt;&gt; &gt; `QMP:block-core.block-dirty-bitmap-add`<br>
&gt;&gt;<br>
&gt;&gt; So, for this lookup to work, the reference must either be of the f=
orm<br>
&gt;&gt; NAMESPACE:MODULE and resolve to that module in that namespace, or =
of the<br>
&gt;&gt; form NAMESPACE:MODULE:DEFN and resolve to that definition in that =
module<br>
&gt;&gt; in that namespace.=C2=A0 Correct?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes.<br>
&gt;<br>
&gt;<br>
&gt;&gt; These a &quot;fully qualified names (FQN)&quot; in your parlance, =
right?<br>
&gt;&gt;<br>
&gt;<br>
&gt; More or less, though as you found below...<br>
&gt;<br>
&gt;<br>
&gt;&gt; Note that the first form is syntactically indistinguishable from<b=
r>
&gt;&gt; NAMESPACE:DEFN, i.e. a reference to a definition that specifies th=
e<br>
&gt;&gt; namespace, but not the module.<br>
&gt;&gt;<br>
&gt;&gt; If the NAMESPACE:MODULE interpretation resolves, we never try the<=
br>
&gt;&gt; NAMESPACE:DEFN interpretation, because that happens in later steps=
.<br>
&gt;&gt; Correct?<br>
&gt;&gt;<br>
&gt;&gt; The first form is fully qualified only if it resolves as FQN.=C2=
=A0 So,<br>
&gt;&gt; whether such a reference is fully qualified is not syntactically<b=
r>
&gt;&gt; decidable.=C2=A0 Hmm.<br>
&gt;&gt;<br>
&gt;<br>
&gt; You&#39;re right. There is a weirdness here. I might need to do some m=
ore<br>
&gt; thinking to make sure it isn&#39;t theoretically a problem, but in pra=
ctice,<br>
&gt; right now, it isn&#39;t.<br>
<br>
Not a blocker, but please do your thinking :)<br>
<br>
&gt; Stay tuned, I guess.<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt;&gt; Regarding &quot;2. If contextual information ...&quot;:<b=
r>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0I guess &quot;contextual information&q=
uot; is the context established by<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0qapi:namespace and qapi:module directi=
ves, i.e. the current<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0namespace and module, if any.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Yep!<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0If the cross reference lacks a namespa=
ce, we substitute the current<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0namespace.=C2=A0 Same for module.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0We then use that &quot;to find a direc=
t match to the implied target<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0name&quot;.=C2=A0 Sounds greek to me.=
=C2=A0 Example(s) might help.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If namespace or module is missing from the link target, we tr=
y to fill in<br>
&gt;&gt; &gt; the blanks with the contextual information if present.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Example, we are in the block-core section of the QEMU QMP ref=
erence manual<br>
&gt;&gt; &gt; document and we reference `block-dirty-bitmap-add`. With cont=
ext, we are<br>
&gt;&gt; &gt; able to assemble a fully qualified name:<br>
&gt;&gt; &gt; &quot;QMP:block-core.block-dirty-bitmap-add`. This matches an=
 item in the<br>
&gt;&gt; &gt; registry directly, so it matches and no further search is per=
formed.<br>
&gt;&gt;<br>
&gt;&gt; We try this lookup only when the reference lacks a namespace and w=
e are<br>
&gt;&gt; &quot;in&quot; a namespace, or when it lacks a module and we are &=
quot;in&quot; a module.<br>
&gt;&gt; Correct?<br>
&gt;&gt;<br>
&gt;<br>
&gt; or both: if we provided only a name but the context has both a namespa=
ce<br>
&gt; and module.<br>
<br>
So my or is inclusive :)<br>
<br>
&gt; essentially the algorithm splits the explicit target into (ns, mod, na=
me)<br>
&gt; and for any that are blank, we try to fill in those blanks with contex=
t<br>
&gt; info where available. Sometimes you have neither explicit nor contextu=
al<br>
&gt; info for a component.<br>
&gt;<br>
&gt; Then we do a lookup for an exact match, in order;<br>
&gt;<br>
&gt; 1. explicit target name, whatever it was<br>
<br>
Fully qualified name.<br></blockquote><div><br></div><div>Yes, for lookup t=
o succeed it should be fully qualified, though if the target text is &quot;=
ns:module&quot;, that&#39;s actually going to succeed here, too.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
If lookup succeeds, we&#39;re done.<br>
<br>
If lookup fails, we&#39;re also done.<br></blockquote><div><br></div><div>I=
f lookup fails, we actually continue on to #2, but whether or not this does=
 anything useful depends on whether or not the original target text was ful=
ly qualified or not. If it was, #2 searches with the exact same text and wi=
ll fail again and proceed to #3, where because we had a fully qualified nam=
e, none of the search conditions apply and we then just exit.</div><div><br=
></div><div>(It just lacks an early return, but abstractly, if lookup on #1=
 fails with a fully qualified name, we are indeed done.)</div><div><br></di=
v><div>If lookup fails because it wasn&#39;t actually fully qualified, then=
 #2 has some gaps to try to fill.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
*Except* for the ambiguous form NAMESPACE:MYSTERY.=C2=A0 If lookup fails fo=
r<br>
that, the name is not fully qualified after all.=C2=A0 Probably.=C2=A0 Mayb=
e.=C2=A0 We<br>
assume it&#39;s missing a module, and proceed to 2.<br>
<br>
I&#39;m mostly ignoring this exception from now on to keep things simple.<b=
r>
<br>
&gt; 2. FQN using contextual info<br>
<br>
Partially qualified name, but context can fill the gaps.<br>
<br>
If lookup succeeds, we&#39;re done.<br>
<br>
Else, we proceed to 3.<br></blockquote><div><br></div><div>That&#39;s right=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; and we stop after the first hit - no chance for multiple results here,=
 just<br>
&gt; zero-or-one each step.<br>
&gt;<br>
&gt; i.e. any explicitly provided information is never &quot;overwritten&qu=
ot; with<br>
&gt; context, context only fills in the blanks where that info was not prov=
ided.<br>
&gt;<br>
&gt; If neither of these work, we move on to fuzzy searching.<br>
&gt;<br>
&gt;<br>
&gt;&gt; We then subsitute current namespace / module for the lacking one(s=
), and<br>
&gt;&gt; try the same lookup as in 1.=C2=A0 Correct?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes!<br>
&gt;<br>
&gt;<br>
&gt;&gt; If we have a reference of the form MYSTERY, it could either be a<b=
r>
&gt;&gt; reference to module MYSTERY in the current namespace, or to defini=
tion<br>
&gt;&gt; MYSTERY in the current namespace and module.=C2=A0 How do we decid=
e?<br>
&gt;&gt;<br>
&gt;<br>
&gt; fqn a: NS:MYSTERY<br>
&gt; fqn b: NS:MOD:MYSTERY<br>
&gt;<br>
&gt; Given we have a current ns/mod context, it&#39;s going to pick the sec=
ond one.<br>
&gt;<br>
&gt; Hm. Maybe it ought to be ambiguous in this case... I&#39;ll have to re=
vise<br>
&gt; this. (question is: how soon do we need it?)<br>
<br>
While we should try to put this on a more solid foundation, it is not a<br>
blocker.<br>
<br>
&gt;&gt; &gt;&gt; Regarding &quot;3. If both prior lookups fail ...&quot;:<=
br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0I guess we get here when namespace or =
module are absent, and<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0substituting the current namespace or =
module doesn&#39;t resolve.=C2=A0 We<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0then substitute a wildcard, so to spea=
k, i.e. look in all namespaces<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0/ modules, and succeed if we find exac=
tly one resolution.=C2=A0 Fair?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; More or less, though the mechanics are quite a bit more compl=
ex than your<br>
&gt;&gt; &gt; overview (and what I wrote in qapi-domain.rst.) We can get he=
re for a few<br>
&gt;&gt; &gt; reasons:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (1) We didn&#39;t provide a fully qualified target, and we do=
n&#39;t have full<br>
&gt;&gt; &gt; context to construct one.<br>
<br>
We skipped 1. because not fully qualified, and we skipped 2. because<br>
context can&#39;t fill the gaps.<br></blockquote><div><br></div><div>we tri=
ed #1 and failed, then we tried #2 and failed again.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For example, we are not &quot;in&quot; a=
 namespace and/or<br>
&gt;&gt; &gt; not &quot;in&quot; a module. This is quite likely to happen w=
hen writing simple<br>
&gt;&gt; &gt; references to a definition name from outside of the transmogf=
rified QAPI<br>
&gt;&gt; &gt; documentation, e.g. from qapi-domain.rst itself, or dirty-bit=
maps.rst, etc.<br>
<br>
Yes.<br>
<br>
&gt;&gt; &gt; (2) We didn&#39;t provide a fully qualified target, and we ar=
e referencing<br>
&gt;&gt; &gt; something from outside of the local context. For example, we =
are &quot;in&quot; a<br>
&gt;&gt; &gt; module but we are trying to link to a different module&#39;s =
definition. e.g.<br>
&gt;&gt; &gt; we are in QMP:transaction and we reference `block-dirty-bitma=
p-add`. The<br>
&gt;&gt; &gt; implied FQN will be QMP:transaction.block-dirty-bitmap.add, w=
hich will not<br>
&gt;&gt; &gt; resolve.<br>
<br>
We skipped 1. because not fully qualified, and we failed 2. because<br>
context filled the gaps, but lookup failed.<br></blockquote><div><br></div>=
<div>Failed #1 and Failed #2.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The fuzzy search portion has an order of precedence for how i=
t searches -<br>
&gt;&gt; &gt; and not all searches are tried universally, they are conditio=
nal to what<br>
&gt;&gt; &gt; was provided in the reference target and what context is avai=
lable.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1. match against the explicitly provided namespace (module wa=
s not<br>
&gt;&gt; &gt; explicitly provided)<br>
&gt;&gt;<br>
&gt;&gt; Look for the name in all of the namespace&#39;s modules?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yeah. search for &quot;ns:*.name&quot; and &quot;ns:name&quot; basical=
ly.<br>
<br>
Got it.<br>
<br>
&gt;&gt; &gt; 2. match against the explicitly provided module (namespace wa=
s not<br>
&gt;&gt; &gt; explicitly provided)<br>
&gt;&gt;<br>
&gt;&gt; Look for the name in all modules so named in all namespaces?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes.<br>
<br>
Got it.<br>
<br>
&gt;&gt; &gt; 3. match against the implied namespace (neither namespace/mod=
ule was<br>
&gt;&gt; &gt; explicitly provided)<br>
&gt;&gt;<br>
&gt;&gt; ?<br>
&gt;&gt;<br>
&gt;<br>
&gt; User gave `foo`, but we have a namespace from context, so we look for<=
br>
&gt; ns:*.foo or ns:foo.<br>
<br>
Got it.<br>
<br>
Detail I had not considered until now: a namespace contains modules that<br=
>
contain definitions, but it also contains definitions directly.<br>
<br>
I can&#39;t recall offhand how schema.py represents this.=C2=A0 I&#39;ll fi=
gure it<br>
out and report back.<br></blockquote><div><br></div><div>I think it gets ch=
arged to a module named &quot;qapi-schema&quot;. Silly, but it doesn&#39;t =
really break anything.</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt;&gt; &gt; 4. match against the implied module (neither namespace/module=
 was<br>
&gt;&gt; &gt; explicitly provided)<br>
&gt;&gt;<br>
&gt;&gt; ?<br>
&gt;&gt;<br>
&gt;<br>
&gt; User gave `foo`, but we have a module from context, so we search for<b=
r>
&gt; *:mod.foo and mod.foo<br>
<br>
Got it.<br>
<br>
&gt;&gt; &gt; 5. match against the definition name only, from anywhere (nei=
ther<br>
&gt;&gt; &gt; namespace/module was explicitly provided)<br>
&gt;&gt;<br>
&gt;&gt; Look for the name anywhere?<br>
&gt;&gt;<br>
&gt;&gt; I need examples :)<br>
&gt;&gt;<br>
&gt;<br>
&gt; user gave `foo`. search for any qapi definition in all modules and<br>
&gt; namespaces for anything with the name &quot;foo&quot;. The broadest po=
ssible search.<br>
&gt;<br>
&gt; Doesn&#39;t search for stuff outside of the QAPI domain directly, but =
be aware<br>
&gt; when using `references` that all domains are consulted, so it may in f=
act<br>
&gt; match something else from somewhere else, though not by any doing of t=
he<br>
&gt; qapi domain.<br>
&gt;<br>
&gt; i.e. :qapi:any:`foo` will definitely only search using the rules laid =
out<br>
&gt; in this patch/thread, but `foo` will consult all domains (and whine if=
 more<br>
&gt; than one result between all domains is identified.)<br>
<br>
Got it, I think.<br>
<br>
&gt;&gt; &gt; The searches are performed in order: if a search returns zero=
 results, the<br>
&gt;&gt; &gt; next search is tried. If any search returns one or more resul=
ts, those<br>
&gt;&gt; &gt; results are returned and we stop searching down the list. The=
 priority<br>
&gt;&gt; &gt; order ensures that any explicitly provided information is *al=
ways* used to<br>
&gt;&gt; &gt; find a match, but contextually provided information is merely=
 a &quot;hint&quot; and<br>
&gt;&gt; &gt; can be ignored for the sake of a match.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If find_obj() as a whole returns zero results, Sphinx emits a=
 warning for a<br>
&gt;&gt; &gt; dangling reference. if find_obj() as a whole returns multiple=
 results,<br>
&gt;&gt; &gt; Sphinx emits a warning for the ambiguous cross-reference.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; QEMU errors out on any such warnings under our normal build s=
ettings.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Clear as mud?<br>
&gt;&gt;<br>
&gt;&gt; Clearer, but not quite mud, yet.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Ultimately, Search in this order and stop at any point any of these<br=
>
&gt; searches return at least one result:<br>
&gt;<br>
&gt; 1. Explicitly provided name, whatever it is<br>
&gt; 2. FQN using contextual info<br>
&gt; 3. Explicitly provided NS; any module<br>
&gt; 4. Explicitly provided module; any NS<br>
&gt; 5. Contextual NS; any module<br>
&gt; 6. Contextual module; any NS<br>
&gt; 7. any NS/module.<br>
&gt;<br>
&gt; with searches 3-7 being conditional only when the criteria are met:<br=
>
&gt;<br>
&gt; 3. Must have explicit NS (and no explicit module)<br>
&gt; 4. Must have explicit module (and no explicit NS)<br>
&gt; 5. Must have contextual NS (must not have explicit NS nor module)<br>
&gt; 6. Must have contextual module (must not have explicit NS nor module)<=
br>
&gt; 7. Must have neither explicit NS nor module.<br></blockquote><div><br>=
</div><div>I should point out that:</div><div><br></div><div>- #3 and #4 ar=
e mutually exclusive</div><div>- #5 and #6 are mutually exclusive</div><div=
>- #3/#4 and #5/#6 are mutually exclusive</div><div>- Only one of #3/#4/#5/=
#6 will happen for a given reference.</div><div>- If we choose #5 or #6, #7=
 may also happen. If we choose #3 or #4, #7 will never happen.</div><div><b=
r></div><div>I bet I can make the code here cleaner by combining some of th=
ese, it&#39;s just a lot of context on the input to keep in mind while desi=
gning the conditionals, so I wrote it out very &quot;explicitly&quot; to he=
lp myself make sense of it ...</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
&gt;<br>
&gt; In summary:<br>
&gt;<br>
&gt; * Anything explicitly provided *must* match. This information is *neve=
r*<br>
&gt; ignored.<br>
&gt; * Anything implicitly provided through context will never overwrite<br=
>
&gt; anything explicitly provided. This is used as a *hint* in the event<br=
>
&gt; multiple candidates are found, but results are allowed to deviate when=
<br>
&gt; stronger matches are not located.<br>
&gt;<br>
&gt; i.e. contextual information is used to *prefer* a result from that con=
text,<br>
&gt; but is not used to *limit* you to that context.<br>
&gt;<br>
&gt; by contrast, explicit info is used to directly filter and restrict sea=
rch.<br>
<br>
Makes sense.<br>
<br>
&gt; (With maybe a bug or two for trying to find module names in some<br>
&gt; circumstances. Will have to check that over...)<br>
<br>
Thank you!<br>
<br></blockquote><div><br></div><div>You&#39;re welcome!=C2=A0 <br></div></=
div></div>

--000000000000a67d9406303dedca--


