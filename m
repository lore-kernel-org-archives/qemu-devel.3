Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF20DC05023
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 14:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxpUw-00048L-2q; Fri, 19 Apr 2024 10:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rxpUn-00045o-9f
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rxpUj-0002yF-St
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713537939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RF/G95/H2cGc7CBQpDBEXy/nX1AO2EkwfzfcTJnVTYs=;
 b=FebN4oo9bBvg6s+KFGCqBncPvab323s9LsWSEldcsv6X/+hxK0G1aP+PTHnwNiTYHcHYqs
 XgW7ZBeVI/CcTVCFhERKV1XhQAldl5BYrBnjv8EIYWKldig/ffiI/atxtYXd0p3Bn7cH2F
 qVWElD76Iu/r199oicrkORf4+TRQ+ls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-Co_idonpOT6dKptTYbzo1Q-1; Fri, 19 Apr 2024 10:45:33 -0400
X-MC-Unique: Co_idonpOT6dKptTYbzo1Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA3EA81B5AF;
 Fri, 19 Apr 2024 14:45:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7991F400EAC;
 Fri, 19 Apr 2024 14:45:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63DEB21E668A; Fri, 19 Apr 2024 16:45:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com> (John Snow's message
 of "Fri, 19 Apr 2024 00:37:48 -0400")
References: <20240419043820.178731-1-jsnow@redhat.com>
Date: Fri, 19 Apr 2024 16:45:27 +0200
Message-ID: <87msppl8c8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
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

> This series adds a new qapi-domain extension for Sphinx, which adds a
> series of custom directives for documenting QAPI definitions.
>
> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/1259566476
>
> (Link to a demo HTML page at the end of this cover letter, but I want
> you to read the cover letter first to explain what you're seeing.)
>
> This adds a new QAPI Index page, cross-references for QMP commands,
> events, and data types, and improves the aesthetics of the QAPI/QMP
> documentation.

Cross-references alone will be a *massive* improvement!  I'm sure
readers will appreciate better looks and an index, too.

> This series adds only the new ReST syntax, *not* the autogenerator. The
> ReST syntax used in this series is, in general, not intended for anyone
> to actually write by hand. This mimics how Sphinx's own autodoc
> extension generates Python domain directives, which are then re-parsed
> to produce the final result.
>
> I have prototyped such a generator, but it isn't ready for inclusion
> yet. (Rest assured: error context reporting is preserved down to the
> line, even in generated ReST. There is no loss in usability for this
> approach. It will likely either supplant qapidoc.py or heavily alter
> it.) The generator requires only extremely minor changes to
> scripts/qapi/parser.py to preserve nested indentation and provide more
> accurate line information. It is less invasive than you may
> fear. Relying on a secondary ReST parse phase eliminates much of the
> complexity of qapidoc.py. Sleep soundly.

I'm a Sphinx noob.  Let me paraphrase you to make sure I understand.

You proprose to generate formatted documentation in two steps:

=E2=80=A2 First, the QAPI generator generates .rst from the QAPI schema.  T=
he
  generated .rst makes use of a custom directives.

=E2=80=A2 Second, Sphinx turns the .rst into formatted documentation.  A Sp=
hinx
  qapi-domain extension implements the custom directives

This mirrors how Sphinx works for Python docs.  Which is its original
use case.

Your series demonstrates the second step, with test input you wrote
manually.

You have code for the first step, but you'd prefer to show it later.

Fair?

> The purpose of sending this series in its current form is largely to
> solicit feedback on general aesthetics, layout, and features. Sphinx is
> a wily beast, and feedback at this stage will dictate how and where
> certain features are implemented.

I'd appreciate help with that.  Opinions?

> A goal for this syntax (and the generator) is to fully in-line all
> command/event/object members, inherited or local, boxed or not, branched
> or not. This should provide a boon to using these docs as a reference,
> because users will not have to grep around the page looking for various
> types, branches, or inherited members. Any arguments types will be
> hyperlinked to their definition, further aiding usability. Commands can
> be hotlinked from anywhere else in the manual, and will provide a
> complete reference directly on the first screenful of information.

Let me elaborate a bit here.

A command's arguments can be specified inline, like so:

    { 'command': 'job-cancel', 'data': { 'id': 'str' } }

The arguments are then documented right with the command.

But they can also be specified by referencing an object type, like so:

    { 'command': 'block-dirty-bitmap-remove',
      'data': 'BlockDirtyBitmap' }

Reasons for doing it this way:

=E2=80=A2 Several commands take the same arguments, and you don't want to r=
epeat
  yourself.

=E2=80=A2 You want generated C take a single struct argument ('boxed': true=
).

=E2=80=A2 The arguments are a union (which requires 'boxed': true).

Drawback: the arguments are then documented elsewhere.  Not nice.

Bug: the generated documentation fails to point there.

You're proposing to inline the argument documentation, so it appears
right with the command.

An event's data is just like a command's argument.

A command's return value can only specified by referencing a type.  Same
doc usability issue.

Similarly, a union type's base can specified inline or by referencing a
struct type, and a union's branches must be specified by referencing a
struct type.  Same doc usability issue.

At least, the generated documentation does point to the referenced
types.

> (Okay, maybe two screenfuls for commands with a ton of
> arguments... There's only so much I can do!)

*cough* blockdev-add *cough*

> This RFC series includes a "sandbox" .rst document that showcases the
> features of this domain by writing QAPI directives by hand; this
> document will be removed from the series before final inclusion. It's
> here to serve as a convenient test-bed for y'all to give feedback.
>
> All that said, here's the sandbox document fully rendered:
> https://jsnow.gitlab.io/qemu/qapi/index.html
>
> And here's the new QAPI index page created by that sandbox document:
> https://jsnow.gitlab.io/qemu/qapi-index.html
>
> Known issues / points of interest:
>
> - The formatting upsets checkpatch. The default line length for the
>   "black" formatting tool is a little long. I'll fix it next spin.
>
> - I did my best to preserve cross-version compatibility, but some
>   problems have crept in here and there. This series may require
>   Sphinx>=3D 4.0, like the dbus extension. Notably, the Ubuntu build fails
>   on Gitlab CI currently. The next version will text against more Sphinx
>   versions more rigorously. Sphinx version 5.3.0 and above should work
>   perfectly.
>
> - There's a bug in Sphinx itself that may manifest in your testing,
>   concerning reported error locations. There's a patch in this series
>   that fixes it, but it's later in the series. If you run into the bug
>   while testing with this series, try applying that patch first.
>
> - QAPI 'namespaces' aren't yet handled. i.e., there's nothing to
>   distinguish entities between QMP, QGA and QSD yet. That feature will
>   be added to a future version of this patchset (Likely when the
>   generator is ready for inclusion: without it, references will clash
>   and the index will gripe about duplicated entries.)

qemu-storage-daemon's QMP is a proper subset of qemu-system-FOO's.
Regardless, each of them has its own, independent reference manual.
That's defensible.

But the way we build them can complicate matters.  For instance, when I
tried to elide types not used for QMP from the reference manuals, I got
defeated by Sphinx caching.

> - Per-member features and ifcond are not yet accounted for; though
>   definition-scoped features and ifconds are. Please feel free to
>   suggest how you'd like to see those represented.
>
> - Inlining all members means there is some ambiguity on what to do with
>   doc block sections on inlined entities; features and members have an
>   obvious home - body, since, and misc sections are not as obvious on
>   how to handle. This will feature more prominently in the generator
>   series.

Yes, this is a real problem.

The member documentation gets written in the context of the type.  It
may make sense only in that context.  Inlining copies it into a
different context.

Features may need to combine.  Say a command's arguments are a union
type, and several branches of the union both contain deprecated members.
These branch types all document feature @deprecated.  Simply inlining
their feature documentation results in feature @deprecated documented
several times.  Ugh.  Combining them would be better.  But how?  Do we
need to rethink how we document features?

> - Some features could be implemented in either the QAPI domain syntax
>   *or* the generator, or some combination of both. Depending on
>   aesthetic feedback, this may influence where those features should be
>   implemented.
>
> - The formatting and aesthetics of branches are a little up in the air,
>   see the qapi:union patch for more details.
>
> - It's late, maybe other things. Happy Friday!
>
> Hope you like it!

Looks promising!


