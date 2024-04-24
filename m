Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8A3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdNN-0001FD-L2; Wed, 24 Apr 2024 10:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzdNL-0001Es-Sq
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzdNI-0007ic-PE
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713968007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXcJu4Ef4ZRKnDnB/0NbsADpHpOhb6t/sHBcVEPbB9s=;
 b=TrwJ1Ol1FXnsE5qwrLqcZ29JH24qm1UjkOyhSgzegqaj6Tq4Z2V8G3iJAwgMpZydWShYXl
 cUYjjkTL3vFvG60x6aFGJ85ETXqLolTCbbYcoZa+ZQif33O4C2l+KoGEr/45oYvjgXUmOt
 D12JbwdnbfPVHjUilKF76BNLJIRWxSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Yf4e18FfPqWzjT-64CnFWQ-1; Wed, 24 Apr 2024 10:13:23 -0400
X-MC-Unique: Yf4e18FfPqWzjT-64CnFWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4B62830E76;
 Wed, 24 Apr 2024 14:13:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50C3F20128F3;
 Wed, 24 Apr 2024 14:13:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70DB521E6811; Wed, 24 Apr 2024 16:13:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
In-Reply-To: <CAFn=p-bE053tRvnC0791duhh64-7cC_in5Y_qTmamXQaoLyWew@mail.gmail.com>
 (John Snow's message of "Tue, 23 Apr 2024 14:32:31 -0400")
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
 <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
 <87wmopg3ez.fsf@pond.sub.org>
 <CAFn=p-bXLbn1o1f+jsFUP502yak0r4yNvAYjTz4MMXShygQQ7g@mail.gmail.com>
 <CAFn=p-YUceA2kx7OQJPxThRi5_w-V-N7YJY57T4paapcvBRUvw@mail.gmail.com>
 <877cgoa5a0.fsf@pond.sub.org>
 <CAFn=p-bE053tRvnC0791duhh64-7cC_in5Y_qTmamXQaoLyWew@mail.gmail.com>
Date: Wed, 24 Apr 2024 16:13:22 +0200
Message-ID: <877cgmsvb1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Apr 23, 2024, 3:48=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Mon, Apr 22, 2024 at 12:38=E2=80=AFPM John Snow <jsnow@redhat.com> =
wrote:
>> >>
>> >> On Mon, Apr 22, 2024 at 5:20=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> >> >
>> >> > John Snow <jsnow@redhat.com> writes:
>> >> >
>> >> > > On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster <armbru@=
redhat.com> wrote:
>> >> > >
>> >> > >> John Snow <jsnow@redhat.com> writes:
>> >> > >>
>> >> > >> > This series adds a new qapi-domain extension for Sphinx, which=
 adds a
>> >> > >> > series of custom directives for documenting QAPI definitions.
>>
>> [...]
>>
>> >> > >> > Known issues / points of interest:
>>
>> [...]
>>
>> >> > >> > - Inlining all members means there is some ambiguity on what t=
o do with
>> >> > >> >   doc block sections on inlined entities; features and members=
 have an
>> >> > >> >   obvious home - body, since, and misc sections are not as obv=
ious on
>> >> > >> >   how to handle. This will feature more prominently in the gen=
erator
>> >> > >> >   series.
>> >> > >>
>> >> > >> Yes, this is a real problem.
>> >> > >>
>> >> > >> The member documentation gets written in the context of the type=
. It
>> >> > >> may make sense only in that context.  Inlining copies it into a
>> >> > >> different context.
>> >> > >>
>> >> > >> Features may need to combine.  Say a command's arguments are a u=
nion
>> >> > >> type, and several branches of the union both contain deprecated =
members.
>> >> > >> These branch types all document feature @deprecated.  Simply inl=
ining
>> >> > >> their feature documentation results in feature @deprecated docum=
ented
>> >> > >> several times.  Ugh.  Combining them would be better.  But how? =
Do we
>> >> > >> need to rethink how we document features?
>> >> > >
>> >> > > To be honest, I figured I'd plow ahead and then find the counter-=
examples
>> >> > > programmatically and decide what to do once I had my pile of edge=
 cases.
>> >> > >
>> >> > > It might involve rewriting docs in some places, but I think the u=
sability
>> >> > > win is completely worth the hassle.
>> >> > >
>> >> > > It's possible there might be some rework needed to maximize cogen=
cy of the
>> >> > > generated docs, but I think prioritizing a user-facing reference =
for QMP is
>> >> > > the objectively correct end goal and I'm more than happy to work =
backwards
>> >> > > from that desired state.
>> >> >
>> >> > I'm not disputing the idea that documenting the arguments right wit=
h the
>> >> > command is good.  I'm merely pointing out obstacles to pulling that=
 off.
>> >> >
>> >> > Adjusting existing documentation is only half the battle.  The other
>> >> > half is making sure documentation stays adjusted.  We may have to c=
ome
>> >> > up with new documentation rules, and ways to enforce them.
>> >>
>> >> For the sake of argument, let's say we forbid everything except
>> >> arg/features from definitions destined to be used as base/inherited
>> >> types. This would be very easy to enforce at the qapidoc level where
>> >> the doc inlining is performed by yelping when the base type contains
>> >> additional documentation sections.
>> >>
>> >> Now, in the real world, maybe sometimes those sections are useful and
>> >> we don't want to get rid of them, esp. because they may contain useful
>> >> documentation that we don't want to duplicate in the source files.
>> >>
>> >> My plan is to just forbid them at first and enumerate the cases where
>> >> they occur, then decide which ones are better off being moved
>> >> elsewhere or explicitly tolerated. The generator's tolerance can be
>> >> adjusted accordingly and we can formulate a rule for exactly how doc
>> >> blocks are combined and merged. I think it won't be a problem to
>> >> enforce it programmatically.
>> >>
>> >> I'll get back to you on how often and precisely where these cases
>> >> occur so you can take a look and see how you feel.
>> >>
>> >
>> > For a warmup, let's look at every unique instance of non-empty
>> > paragraph text on an object that is used as a base anywhere:
>> >
>> > Warning: AudiodevPerDirectionOptions - inlined paragraph
>> > Warning: BlockdevOptionsCurlBase - inlined paragraph
>> > Warning: BlockdevOptionsGenericCOWFormat - inlined paragraph
>> > Warning: BlockdevOptionsGenericFormat - inlined paragraph
>> > Warning: BlockExportOptionsNbdBase - inlined paragraph
>> > Warning: BlockNodeInfo - inlined paragraph
>> > Warning: ChardevCommon - inlined paragraph
>> > Warning: CpuInstanceProperties - inlined paragraph
>> > Warning: CryptodevBackendProperties - inlined paragraph
>> > Warning: EventLoopBaseProperties - inlined paragraph
>> > Warning: MemoryBackendProperties - inlined paragraph
>> > Warning: NetfilterProperties - inlined paragraph
>> > Warning: QCryptoBlockAmendOptionsLUKS - inlined paragraph
>> > Warning: QCryptoBlockCreateOptionsLUKS - inlined paragraph
>> > Warning: QCryptoBlockInfoBase - inlined paragraph
>> > Warning: QCryptoBlockOptionsBase - inlined paragraph
>> > Warning: QCryptoBlockOptionsLUKS - inlined paragraph
>> > Warning: RngProperties - inlined paragraph
>> > Warning: SecretCommonProperties - inlined paragraph
>> > Warning: SpiceBasicInfo - inlined paragraph
>> > Warning: TlsCredsProperties - inlined paragraph
>> > Warning: VncBasicInfo - inlined paragraph
>> >
>> > There's 22 instances.
>> >
>> > Let's look at what they say:
>> >
>> > AudiodevPerDirectionOptions: "General audio backend options that are
>> > used for both playback and recording."
>> > BlockdevOptionsCurlBase: "Driver specific block device options shared
>> > by all protocols supported by the curl backend."
>> > BlockdevOptionsGenericCOWFormat: "Driver specific block device options
>> > for image format that have no option besides their data source and an
>> > optional backing file."
>> > BlockdevOptionsGenericFormat: "Driver specific block device options
>> > for image format that have no option besides their data source."
>> > BlockExportOptionsNbdBase: "An NBD block export (common options shared
>> > between nbd-server-add and the NBD branch of block-export-add)."
>> > BlockNodeInfo: "Information about a QEMU image file"
>> > ChardevCommon: "Configuration shared across all chardev backends"
>> >
>> > CpuInstanceProperties:
>> > "List of properties to be used for hotplugging a CPU instance, it
>> > should be passed by management with device_add command when a CPU is
>> > being hotplugged.
>> >
>> > Which members are optional and which mandatory depends on the
>> > architecture and board.
>> >
>> > For s390x see :ref:`cpu-topology-s390x`.
>> >
>> > The ids other than the node-id specify the position of the CPU
>> > within the CPU topology (as defined by the machine property "smp",
>> > thus see also type @SMPConfiguration)"
>> >
>> > CryptodevBackendProperties: "Properties for cryptodev-backend and
>> > cryptodev-backend-builtin objects."
>> > EventLoopBaseProperties: "Common properties for event loops"
>> > MemoryBackendProperties: "Properties for objects of classes derived
>> > from memory-backend."
>> > NetfilterProperties: "Properties for objects of classes derived from n=
etfilter."
>> > QCryptoBlockAmendOptionsLUKS: "This struct defines the update
>> > parameters that activate/de-activate set of keyslots"
>> > QCryptoBlockCreateOptionsLUKS: "The options that apply to LUKS
>> > encryption format initialization"
>> > QCryptoBlockInfoBase: "The common information that applies to all full
>> > disk encryption formats"
>> > QCryptoBlockOptionsBase: "The common options that apply to all full
>> > disk encryption formats"
>> > QCryptoBlockOptionsLUKS: "The options that apply to LUKS encryption fo=
rmat"
>> > RngProperties: "Properties for objects of classes derived from rng."
>> > SecretCommonProperties: "Properties for objects of classes derived
>> > from secret-common."
>> > SpiceBasicInfo: "The basic information for SPICE network connection"
>> > TlsCredsProperties: "Properties for objects of classes derived from tl=
s-creds."
>> > VncBasicInfo: "The basic information for vnc network connection"
>> >
>> > ... Alright. So like 98% of the time, it's functionally useless
>> > information for the end-user. The only thing that looks mildly
>> > interesting is CpuInstanceProperties and *maybe*
>> > QCryptoBlockAmendOptionsLUKS.
>> >
>> > I propose we add a new section to QAPI doc blocks that gets ignored
>> > from rendered documentation, like "Comment:" -- to keep any info that
>> > might be mildly relevant to a developer that explains the *factoring*
>> > of the object, but won't be exposed in user-facing documents.
>>
>> Two existing ways to add comments that don't go into generated
>> documentation:
>>
>> 1. Write a non-doc comment.
>>
>>    ##
>>    # This is a doc comment.
>>    ##
>>
>>    #
>>    # This isn't.
>>    #
>>
>> 2. TODO sections in a doc comment.
>>
>> Not sure we need more ways, but if we do, we'll create them.
>
> Yeah. we could just delete them. Just offering a section in case you don't
> want to lose a mandate that every entity should be documented.

I don't want to think about things like "does this need documentation",
or "where does the documentation go".  I want our tools to be able to
decide that for us.

> I don't have strong feelings beyond "I think we don't need to inline thes=
e,
> but we should make it obvious when we do or do not."
>
> If you want to just pull out these paragraphs to be comments before/after
> the doc block or just delete them, I don't have strong feelings.

I figure almost all of them are thoroughly uninteresting.  If that turns
out to be the case, we delete the uninteresting ones, then decide what
to do about each of the few interesting ones.

>> > On the occasion we DO want to inline documentation paragraphs, we can
>> > leave them in and have the doc generator inline them. There's probably
>> > very few cases where we actually want this.
>> >
>> > Let's take a look at any tagged sections now, excluding "Since":
>> >
>> > Warning: BackupCommon - inlined tag section Note
>> > Warning: CpuInstanceProperties - inlined, tag section Note
>> > Warning: MemoryBackendProperties - inlined tag section Note
>> >
>> > Not very many! Just three.
>> >
>> > BackupCommon:
>> >
>> > Note: @on-source-error and @on-target-error only affect background
>> >     I/O.  If an error occurs during a guest write request, the
>> >     device's rerror/werror actions will be used.
>> >
>> > BackupCommon is used as a base for DriveBackup and BlockdevBackup. In
>> > this case, this note probably does belong on both. It should be
>> > inlined and included.
>> >
>> > CpuInstanceProperties:
>> >
>> > Note: management should be prepared to pass through additional
>> >     properties with device_add.
>> >
>> > This is only used as a base with no other addon args for
>> > NumaCpuOptions, in turn only used for an argument. This is probably
>> > right to pass through, too. (Though I admit I don't really know what
>> > it means... we can discuss the doc *quality* another day.)
>>
>> Oh boy, don't get me started!
>
> :)
>
>
>> > MemoryBackendProperties:
>> >
>> > Note: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the same
>> >     time.  With reserve=3Dtrue, the behavior depends on the operating
>> >     system: for example, Linux will not reserve swap space for
>> >     shared file mappings -- "not applicable". In contrast,
>> >     reserve=3Dfalse will bail out if it cannot be configured
>> >     accordingly.
>> >
>> > This is used in MemoryBackendFileProperties,
>> > MemoryBackendMemfdProperties, and MemoryBackendEpcProperties. None are
>> > commands. I think the note here should also be inlined into each
>> > object.
>> >
>> > So, I think that:
>> >
>> > - Most naked paragraphs are usually useless to the end-user, and we
>> > should put them behind a Comment section to prevent them from being
>> > inlined.
>>
>> We may want to delete them instead.
>
> Sure, yeah. You're the maintainer, so your call.
>
> (1) New comment section
> (2) Pulled out as a non-doc-block comment
> (3) Just deleted.
>
>
>> > - Any *other* paragraph or section should be included in the
>> > descendent. We'll just review with that eye going forward.
>>
>> But where exactly does it go?
>
> "Into the HTML. Any other questions?"
>
> ;)

Would you be interested in a product manager role?  ;-P

>> The question applies not just to tagged sections such as "Note:", but to
>> argument, member, and feature descriptions, too.
>
>
>> Our current answer for argument / member descriptions is "right after
>> the body section".  Works because we permit only the body section before
>> argument / member descriptions .  Pretty arbitrary restriction, though.
>>
>> Fine print: can be a bit more complicated for unions, but let's ignore
>> that here.
>>
>> I guess our current answer for feature descriptions is something like
>> "right after argument / member descriptions if they exist, else right
>> after the body section".
>>
>> What could our answer be for other sections?
>
> Inherited members: Injected *before* the member section *when already
> present*. i.e., members are source order, ancestor-to-descendent.
>
> Features are the same. The system does not care if they are duplicated.

The reader might.  We'll see.

> The only ambiguity arises when the final descendent does not *have* member
> or feature sections.

Yes.

> Current prototype's hack: if we leave the doc sections and members/featur=
es
> remain undocumented, they are appended to the end of the block.
>
> I do agree this isn't ideal. We had a call off-list earlier today where y=
ou
> suggested the idea of a section or token that would mark the location for
> such things to be inlined in the event that there was no obvious place
> otherwise. I don't have a better idea; and it would make this action
> explicit rather than implicit. It would only be needed in very few doc
> blocks and it would be possible to write a very, very detailed error
> message in the circumstances where this was missed.
>
> i.e. a simple section that's just simply:
>
> Inherited-Members: ...
>
> or
>
> Inherited-Features: ...
>
> would do perfectly well.
>
> Example error message: 'QAPI definition foo has inherited
> <features/members> [from QAPI <meta-type> bar] but no local
> <features/members> section in its documentation block. Please annotate
> where they should be included in generated documentation by including the
> line "Inherited-<Features/Members>: ..." in the doc block.'
>
> (With a pointer to the source file and line where the doc block starts.)
>
> If this line is erroneously *included* in a doc block that doesn't need i=
t,
> we can also emit a (fatal) warning urging its removal and an auditing of
> the rendered HTML output.
>
> That leaves other sections. We also spoke about the possibility of
> eliminating "notes" and "examples" in exchange for explicit ReST/sphinx
> syntax. I think that's probably a good idea overall, because it increases
> flexibility in how we can annotate examples and remove more custom qapidoc
> parsing code.

Yes.  We're reinventing reST there for historical reasons only.  And our
reinvented wheel is decidedly less round than reST's.

> So, let's assume the only thing left would be "where do we inline inherit=
ed
> paragraphs?"
>
> How about this:
>
> If we inherit from an object that *has* such paragraphs, then the
> descendent needs to mark the spot for its inclusion.
>
> Copying from the above ideas for members/features, how about:
>
> Inherited-paragraphs: ...
>
> The docgen uses this as the splice point. If the splice point is absent a=
nd
> there are no paragraphs to splice in, there's no problem. If there are, we
> can emit a very detailed warning that explains exactly what went wrong and
> how to fix it. Similarly, if the splice point is indicated but absent, we
> can warn and urge its removal alongside an audit of the generated
> documentation.
>
> This way, the feature is self-documenting and self-correcting. It will
> catch regressions written before the feature existed and give guidance on
> how to fix it. It will catch the large majority of rebase and refactoring
> mistakes.

Worth exploring.

> It adds a little complexity to the QAPIDoc parser, but not very much.
>
> (And in fact, with the removal of Notes and Examples, it may indeed be
> possible to refactor the parser to be drastically simpler. Alongside using
> all_sections, once qapidoc.py is rewritten/replaced, even more drastic
> simplifications are possible.)

When I rewrote the doc parser, I aimed for such simplifications, but
qapidoc.py resisted change too much to be worth it, so I shelved the
idea.

>> In my experience, the people writing the doc comments rarely check how
>> they come out in generated documentation.
>>
>> The closer the doc comments are to the generated documentation, the
>> higher the chance it comes out as intended.
>>
>> The more complex the inlining gets, the higher the chance of mishaps.
>>
>> If cases of complex inlining are rare, we could sidestep complex
>> inlining by inlining manually.
>>
>> If that's undesirable or impractical, we could require explicit
>> instructions where the inlined material should go.
>>
>> I'm merely thinking aloud; these are certainly not requests, just ideas,
>> and possibly bad ones.
>>
>> > - Since: ... we'll talk about later this week.
>>
>> Yes.
>
> Also discussed on call, but I'm leaving this alone for right now.
>
> Current prototype: inherited "since" sections are ignored but emit a
> non-fatal warning. We can audit these cases and decide if that's an
> acceptable shortcoming while we work on something more robust, or if it
> needs addressing before merge.
>
> (Or if we just issue manual source corrections in the interim before your
> proposed changes to generate such info are merged.)
>
> OK.
>
> So: I quite like the idea of inherited placeholders if and only if they a=
re
> required, and would like to proceed with prototyping this mechanism. Are
> you OK with me proceeding to prototype this?

Yes.

I'm curious how many of them we'll need in practice.

> (It's okay to have reservations and we may still change our mind, but I
> want a tentative ACK before I embark on this as it is categorically more
> disruptive than any of the changes I've made thus far. i.e. does it
> *conceptually* work for you?)

Well, we need *some* solution to make inlining viable.  Since inlining
is desirable, and no better solution comes to mind, let's explore this
one.


