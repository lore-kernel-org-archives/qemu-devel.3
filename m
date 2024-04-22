Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BF0C07E8F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 09:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rypqF-0007g9-DS; Mon, 22 Apr 2024 05:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rypqB-0007d4-Fq
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rypq6-0007kJ-U0
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713777593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bedbrtpnScS6oBDD80T7ANXVRoXVJdcmU7BGKMOVhtc=;
 b=MZCa0HoF7SWDLIJ3IawPa/QmqpwPCLoDqnP2WL7rszXAItYD3zUlT5Gv/RBFCO4nC62eeS
 +C3a2RmJ9evZDERnI7Kr/MHIVvODisiAlo6qjAHMUnGaKR4VxBJrlSZpIAGCW6VBjc3UgL
 FcEfDQ686eNwM6y0gFNeI8lxuE9zyjw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-VTL0o-VJMou9eCuFnznIRg-1; Mon, 22 Apr 2024 05:19:49 -0400
X-MC-Unique: VTL0o-VJMou9eCuFnznIRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A30C1049C93;
 Mon, 22 Apr 2024 09:19:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15CF140F183;
 Mon, 22 Apr 2024 09:19:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A83D21E66C8; Mon, 22 Apr 2024 11:19:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
In-Reply-To: <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
 (John Snow's message of "Fri, 19 Apr 2024 12:31:48 -0400")
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
 <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
Date: Mon, 22 Apr 2024 11:19:48 +0200
Message-ID: <87wmopg3ez.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.42,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This series adds a new qapi-domain extension for Sphinx, which adds a
>> > series of custom directives for documenting QAPI definitions.
>> >
>> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/1259566476
>> >
>> > (Link to a demo HTML page at the end of this cover letter, but I want
>> > you to read the cover letter first to explain what you're seeing.)
>> >
>> > This adds a new QAPI Index page, cross-references for QMP commands,
>> > events, and data types, and improves the aesthetics of the QAPI/QMP
>> > documentation.
>>
>> Cross-references alone will be a *massive* improvement!  I'm sure
>> readers will appreciate better looks and an index, too.
>>
>> > This series adds only the new ReST syntax, *not* the autogenerator. The
>> > ReST syntax used in this series is, in general, not intended for anyone
>> > to actually write by hand. This mimics how Sphinx's own autodoc
>> > extension generates Python domain directives, which are then re-parsed
>> > to produce the final result.
>> >
>> > I have prototyped such a generator, but it isn't ready for inclusion
>> > yet. (Rest assured: error context reporting is preserved down to the
>> > line, even in generated ReST. There is no loss in usability for this
>> > approach. It will likely either supplant qapidoc.py or heavily alter
>> > it.) The generator requires only extremely minor changes to
>> > scripts/qapi/parser.py to preserve nested indentation and provide more
>> > accurate line information. It is less invasive than you may
>> > fear. Relying on a secondary ReST parse phase eliminates much of the
>> > complexity of qapidoc.py. Sleep soundly.
>>
>> I'm a Sphinx noob.  Let me paraphrase you to make sure I understand.
>>
>> You proprose to generate formatted documentation in two steps:
>>
>> =E2=80=A2 First, the QAPI generator generates .rst from the QAPI schema.=
  The
>>   generated .rst makes use of a custom directives.
>>
>
> Yes, but this .rst file is built in-memory and never makes it to disk, li=
ke
> Sphinx's autodoc for Python.

Makes sense.

> (We can add a debug knob to log it or save it out to disk if needed.)

Likely useful at least occasionally.

>> =E2=80=A2 Second, Sphinx turns the .rst into formatted documentation.  A=
 Sphinx
>>   qapi-domain extension implements the custom directives
>
> Yes.
>
>
>> This mirrors how Sphinx works for Python docs.  Which is its original
>> use case.
>>
>> Your series demonstrates the second step, with test input you wrote
>> manually.
>>
>> You have code for the first step, but you'd prefer to show it later.
>
> Right, it's not fully finished, although I have events, commands, and
> objects working. Unions, Alternates and Events need work.
>
>
>> Fair?
>
> Bingo!

Thanks!

>> > The purpose of sending this series in its current form is largely to
>> > solicit feedback on general aesthetics, layout, and features. Sphinx is
>> > a wily beast, and feedback at this stage will dictate how and where
>> > certain features are implemented.
>>
>> I'd appreciate help with that.  Opinions?
>
>
>> > A goal for this syntax (and the generator) is to fully in-line all
>> > command/event/object members, inherited or local, boxed or not, branch=
ed
>> > or not. This should provide a boon to using these docs as a reference,
>> > because users will not have to grep around the page looking for various
>> > types, branches, or inherited members. Any arguments types will be
>> > hyperlinked to their definition, further aiding usability. Commands can
>> > be hotlinked from anywhere else in the manual, and will provide a
>> > complete reference directly on the first screenful of information.
>>
>> Let me elaborate a bit here.
>>
>> A command's arguments can be specified inline, like so:
>>
>>     { 'command': 'job-cancel', 'data': { 'id': 'str' } }
>>
>> The arguments are then documented right with the command.
>>
>> But they can also be specified by referencing an object type, like so:
>>
>>     { 'command': 'block-dirty-bitmap-remove',
>>       'data': 'BlockDirtyBitmap' }
>>
>> Reasons for doing it this way:
>>
>> =E2=80=A2 Several commands take the same arguments, and you don't want t=
o repeat
>>   yourself.
>>
>> =E2=80=A2 You want generated C take a single struct argument ('boxed': t=
rue).
>>
>> =E2=80=A2 The arguments are a union (which requires 'boxed': true).
>>
>> Drawback: the arguments are then documented elsewhere.  Not nice.
>>
>> Bug: the generated documentation fails to point there.
>>
>> You're proposing to inline the argument documentation, so it appears
>> right with the command.
>>
>> An event's data is just like a command's argument.
>>
>> A command's return value can only specified by referencing a type.  Same
>> doc usability issue.
>>
>> Similarly, a union type's base can specified inline or by referencing a
>> struct type, and a union's branches must be specified by referencing a
>> struct type.  Same doc usability issue.
>>
>> At least, the generated documentation does point to the referenced
>> types.
>>
>
> Right. My proposal is to recursively inline referenced bases for the
> top-level members so that this manual is useful as a user reference,
> without worrying about the actual QAPI structure.
>
> Return types will just be hotlinked.

The argument for inlining the arguments equally applies to results:
"users will not have to grep around the page".

102 out of 236 commands return something, usually some object type or an
array of some object type.  Most of these types are used for exactly one
command's return and nothing else.

Regardless, it's fine to explore inlining just for arguments.  If we can
make that work, extending it to return results shouldn't be too hard.

>> > (Okay, maybe two screenfuls for commands with a ton of
>> > arguments... There's only so much I can do!)
>>
>> *cough* blockdev-add *cough*
>
>
>> > This RFC series includes a "sandbox" .rst document that showcases the
>> > features of this domain by writing QAPI directives by hand; this
>> > document will be removed from the series before final inclusion. It's
>> > here to serve as a convenient test-bed for y'all to give feedback.
>> >
>> > All that said, here's the sandbox document fully rendered:
>> > https://jsnow.gitlab.io/qemu/qapi/index.html
>> >
>> > And here's the new QAPI index page created by that sandbox document:
>> > https://jsnow.gitlab.io/qemu/qapi-index.html
>> >
>> > Known issues / points of interest:
>> >
>> > - The formatting upsets checkpatch. The default line length for the
>> >   "black" formatting tool is a little long. I'll fix it next spin.
>> >
>> > - I did my best to preserve cross-version compatibility, but some
>> >   problems have crept in here and there. This series may require
>> >   Sphinx>=3D 4.0, like the dbus extension. Notably, the Ubuntu build f=
ails
>> >   on Gitlab CI currently. The next version will text against more Sphi=
nx
>> >   versions more rigorously. Sphinx version 5.3.0 and above should work
>> >   perfectly.
>> >
>> > - There's a bug in Sphinx itself that may manifest in your testing,
>> >   concerning reported error locations. There's a patch in this series
>> >   that fixes it, but it's later in the series. If you run into the bug
>> >   while testing with this series, try applying that patch first.
>> >
>> > - QAPI 'namespaces' aren't yet handled. i.e., there's nothing to
>> >   distinguish entities between QMP, QGA and QSD yet. That feature will
>> >   be added to a future version of this patchset (Likely when the
>> >   generator is ready for inclusion: without it, references will clash
>> >   and the index will gripe about duplicated entries.)
>>
>> qemu-storage-daemon's QMP is a proper subset of qemu-system-FOO's.
>> Regardless, each of them has its own, independent reference manual.
>> That's defensible.
>>
>> But the way we build them can complicate matters.  For instance, when I
>> tried to elide types not used for QMP from the reference manuals, I got
>> defeated by Sphinx caching.
>
> I haven't tried yet, but I believe it should be possible to "tag" each
> referenced QAPI object and mark it as "visited". Each namespaced definiti=
on
> would be tagged separately.
>
> (i.e. qemu.block-core.blockdev-backup and qsd.block-core.blockdev-backup
> would be two distinct entities.)
>
> Then, the renderer could ignore/squelch untagged entities. (I think.)
>
> Maybe some work to do to un-index unvisited entities.
>
> Or we can go the other route and bake this info into the schema and squel=
ch
> stuff earlier. We can add this feature later. I am still not sure why your
> prototype for this ran into cache issues, but I am convinced it should be
> fixable by making namespaced entities distinct.

From (hazy) memory: when full QMP and storage daemon QMP both include a
sub-module for its types, but full QMP uses more of its types than
storage daemon QMP does, the storage daemon manual elides more of its
types than the QMP manual does.  However, sphinx-build's caching uses
whatever got built first for *both* manuals.  When we happen to build
the full QMP manual first, we end up with extra types in the storage
daemon manual.  When we happen to build the storage daemon manual first,
the full manual is missing types.

> We could perhaps bake the namespace into the qapidoc directive, e.g.:
>
>  .. qapi:autodoc:: schema.json
>    :namespace: QSD
>
> (And the default adds no namespace.)

Is it worth it?  How useful is the separate QEMU Storage Daemon QMP
Reference Manual?  It's an exact duplicate of selected chapters of the
QEMU QMP Reference Manual...  Could we instead document "QMP, but only
these chapters"?

Diversion: can we come up with a better way of subsetting the full QAPI
schema for the storage daemon?

We currently subset by having storage-daemon/qapi/qapi-schema.json a
subset of the submodules qapi/qapi-schema.json includes.  The code
generated for the entire schema differs (basically qapi-init-commands.c,
qapi-emit-events.[ch], and qapi-introspect.c).  The code generated for
the submodules should be identical (modulo unused array types, but
that's harmless detail).  So we ignore the code generated for the
storage daemon's submodules.

End of diversion.

>> > - Per-member features and ifcond are not yet accounted for; though
>> >   definition-scoped features and ifconds are. Please feel free to
>> >   suggest how you'd like to see those represented.
>> >
>> > - Inlining all members means there is some ambiguity on what to do with
>> >   doc block sections on inlined entities; features and members have an
>> >   obvious home - body, since, and misc sections are not as obvious on
>> >   how to handle. This will feature more prominently in the generator
>> >   series.
>>
>> Yes, this is a real problem.
>>
>> The member documentation gets written in the context of the type.  It
>> may make sense only in that context.  Inlining copies it into a
>> different context.
>>
>> Features may need to combine.  Say a command's arguments are a union
>> type, and several branches of the union both contain deprecated members.
>> These branch types all document feature @deprecated.  Simply inlining
>> their feature documentation results in feature @deprecated documented
>> several times.  Ugh.  Combining them would be better.  But how?  Do we
>> need to rethink how we document features?
>
> To be honest, I figured I'd plow ahead and then find the counter-examples
> programmatically and decide what to do once I had my pile of edge cases.
>
> It might involve rewriting docs in some places, but I think the usability
> win is completely worth the hassle.
>
> It's possible there might be some rework needed to maximize cogency of the
> generated docs, but I think prioritizing a user-facing reference for QMP =
is
> the objectively correct end goal and I'm more than happy to work backwards
> from that desired state.

I'm not disputing the idea that documenting the arguments right with the
command is good.  I'm merely pointing out obstacles to pulling that off.

Adjusting existing documentation is only half the battle.  The other
half is making sure documentation stays adjusted.  We may have to come
up with new documentation rules, and ways to enforce them.

>> > - Some features could be implemented in either the QAPI domain syntax
>> >   *or* the generator, or some combination of both. Depending on
>> >   aesthetic feedback, this may influence where those features should be
>> >   implemented.
>> >
>> > - The formatting and aesthetics of branches are a little up in the air,
>> >   see the qapi:union patch for more details.
>> >
>> > - It's late, maybe other things. Happy Friday!
>> >
>> > Hope you like it!
>>
>> Looks promising!
>
> Fingers crossed. This has bothered me about QEMU for years.

Thanks!


