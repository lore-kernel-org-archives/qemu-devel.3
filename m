Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27153C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 05:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQ8q-0007D8-Ef; Wed, 10 Jul 2024 01:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRQ8h-00079q-P6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 01:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRQ8Z-00024c-1q
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 01:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720590305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/2yhC4gwa9pAD7545LfzT8UiShcPrTJhFEljDxf3H8=;
 b=fLt69L+AW3bXMlWGpbBJhtNXgIfhwDB2FRyc70wmM6kGBGk+7koSyAUKUdSVRQDzb4vrvH
 5OFzq+kFeUiMIIj8P/qnso62Ajp2FvyE9+QXCOFlmiPf3CntA4cu4hLkxf2U/WSY+xIvHw
 akuTHaIsQkAHqpmIRkeBaSmHBrp5GDg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-pA3aCpxjOqip8AtLzKwlRw-1; Wed,
 10 Jul 2024 01:44:59 -0400
X-MC-Unique: pA3aCpxjOqip8AtLzKwlRw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E183019560B3; Wed, 10 Jul 2024 05:44:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91C8419560AE; Wed, 10 Jul 2024 05:44:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A67221E6693; Wed, 10 Jul 2024 07:44:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Stefan Hajnoczi <stefanha@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Ani
 Sinha <anisinha@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Hanna Reitz <hreitz@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,  Alex Williamson
 <alex.williamson@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 8/8] qapi: remove "Example" doc section
In-Reply-To: <CAFn=p-b6SDEpeN3rJc_g6puUR5RmP5CfxUb7bdy3pQRhsvmytQ@mail.gmail.com>
 (John Snow's message of "Tue, 9 Jul 2024 19:12:38 -0400")
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-9-jsnow@redhat.com>
 <87sewihm6k.fsf@pond.sub.org>
 <CAFn=p-b6SDEpeN3rJc_g6puUR5RmP5CfxUb7bdy3pQRhsvmytQ@mail.gmail.com>
Date: Wed, 10 Jul 2024 07:44:53 +0200
Message-ID: <87frshajhm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Jul 9, 2024 at 6:52=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Fully eliminate the "Example" sections in QAPI doc blocks now that they
>> > have all been converted to arbitrary rST syntax using the
>> > ".. qmp-example::" directive. Update tests to match.
>> >
>> > Migrating to the new syntax
>> > ---------------------------
>> >
>> > The old "Example:" or "Examples:" section syntax is now caught as an
>> > error, but "Example::" is stil permitted as explicit rST syntax for an
>> > un-lexed, generic preformatted text block.
>> >
>> > ('Example' is not special in this case, any sentence that ends with ":=
:"
>> > will start an indented code block in rST.)
>> >
>> > Arbitrary rST for Examples is now possible, but it's strongly
>> > recommended that documentation authors use the ".. qmp-example::"
>> > directive for consistent visual formatting in rendered HTML docs. The
>> > ":title:" directive option may be used to add extra information into t=
he
>> > title bar for the example. The ":annotated:" option can be used to wri=
te
>> > arbitrary rST instead, with nested "::" blocks applying QMP formatting
>> > where desired.
>> >
>> > Other choices available are ".. code-block:: QMP" which will not create
>> > an "Example:" box, or the short-form "::" code-block syntax which will
>> > not apply QMP highlighting when used outside of the qmp-example
>> > directive.
>> >
>> > Why?
>> > ----
>> >
>> > This patch has several benefits:
>> >
>> > 1. Example sections can now be written more arbitrarily, mixing
>> >    explanatory paragraphs and code blocks however desired.
>> >
>> > 2. Example sections can now use fully arbitrary rST.
>> >
>> > 3. All code blocks are now lexed and validated as QMP; increasing
>> >    usability of the docs and ensuring validity of example snippets.
>> >
>> >    (To some extent - This patch only gaurantees it lexes correctly, not
>> >    that it's valid under the JSON or QMP grammars. It will catch most
>> >    small mistakes, however.)
>> >
>> > 4. Each qmp-example can be titled or annotated independently without
>> >    bypassing the QMP lexer/validator.
>> >
>> >    (i.e. code blocks are now for *code* only, so we don't have to
>> >    sacrifice exposition for having lexically valid examples.)
>> >
>> > NOTE: As with the "Notes" conversion patch,
>>
>> Commit d461c279737 (qapi: convert "Note" sections to plain rST).
>>
>
> Didn't have a stable commit ID at the time, will work it in if/when the
> notes patches hit main.

They have.

>> >                                             this patch (and those
>> >       preceding) may change the rendering order for Examples in the
>>
>> The three preceding ones, to be precise.
>>
>> >       current generator. The forthcoming qapidoc rewrite will fix this
>> >       by always generating documentation in source order.
>>
>> Conversions from "Example" section to plain reST may change order.  This
>> patch converts a test, and the preceding three convert the real uses.
>>
>> Does any of the patches actually change order?
>
> I do not actually know ...! It has the *potential* in the same exact way
> that the notes patch did, but I don't actually know if it *did*. My hunch
> is "no" because there's only one intermediate section we identified with
> the notes series, but I didn't exhaustively prove it. That's why I used t=
he
> "may" weasel wording.

Alright, I checked.

In documentation of command announce-self, the example moves from after
the arguments to before.  Unwanted change.

I can keep it in place if I insert a TODO before the example like this:

    diff --git a/qapi/net.json b/qapi/net.json
    index 9a723e56b5..50bfd5b681 100644
    --- a/qapi/net.json
    +++ b/qapi/net.json
    @@ -930,6 +930,8 @@
     # switches.  This can be useful when network bonds fail-over the
     # active slave.
     #
    +# TODO: This line is a hack to separate the example from the body
    +#
     # .. qmp-example::
     #
     #     -> { "execute": "announce-self",

I had to delete the .doctrees cache to make sphinx-build generate
corrected output.

>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/devel/qapi-code-gen.rst    | 58 ++++++++++++++++++++++++++++-----
>> >  scripts/qapi/parser.py          | 10 +++++-
>> >  tests/qapi-schema/doc-good.json | 19 +++++++----
>> >  tests/qapi-schema/doc-good.out  | 26 ++++++++++-----
>> >  tests/qapi-schema/doc-good.txt  | 23 ++++++-------
>> >  5 files changed, 98 insertions(+), 38 deletions(-)
>> >
>> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st
>> > index ae97b335cbf..2e10a3cbd69 100644
>> > --- a/docs/devel/qapi-code-gen.rst
>> > +++ b/docs/devel/qapi-code-gen.rst
>> > @@ -899,7 +899,7 @@ Documentation markup
>> >  ~~~~~~~~~~~~~~~~~~~~
>> >
>> >  Documentation comments can use most rST markup.  In particular,
>> > -a ``::`` literal block can be used for examples::
>> > +a ``::`` literal block can be used for pre-formatted text::
>> >
>> >      # ::
>> >      #
>> > @@ -995,8 +995,8 @@ line "Features:", like this::
>> >    # @feature: Description text
>> >
>> >  A tagged section begins with a paragraph that starts with one of the
>> > -following words: "Since:", "Example:"/"Examples:", "Returns:",
>> > -"Errors:", "TODO:".  It ends with the start of a new section.
>> > +following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends w=
ith
>> > +the start of a new section.
>> >
>> >  The second and subsequent lines of tagged sections must be indented
>> >  like this::
>> > @@ -1020,13 +1020,53 @@ detailing a relevant error condition. For
>> example::
>> >  A "Since: x.y.z" tagged section lists the release that introduced the
>> >  definition.
>> >
>> > -An "Example" or "Examples" section is rendered entirely
>> > -as literal fixed-width text.  "TODO" sections are not rendered at all
>> > -(they are for developers, not users of QMP).  In other sections, the
>> > -text is formatted, and rST markup can be used.
>> > +"TODO" sections are not rendered at all (they are for developers, not
>>
>> Drop "at all"?
>>
>
> Sure.
>
>
>>
>> > +users of QMP).  In other sections, the text is formatted, and rST mar=
kup
>> > +can be used.
>> > +
>> > +QMP Examples can be added by using the ``.. qmp-example::``
>> > +directive. In its simplest form, this can be used to contain a single
>> > +QMP code block which accepts standard JSON syntax with additional ser=
ver
>> > +directionality indicators (``->`` and ``<-``), and elisions (``...``).
>> > +
>> > +Optionally, a plaintext title may be provided by using the ``:title:``
>> > +directive option. If the title is omitted, the example title will
>> > +default to "Example:".
>> > +
>> > +A simple QMP example::
>> > +
>> > +  # .. qmp-example::
>> > +  #    :title: Using query-block
>> > +  #
>> > +  #    -> { "execute": "query-block" }
>> > +  #    <- { ... }
>> > +
>> > +More complex or multi-step examples where exposition is needed before=
 or
>> > +between QMP code blocks can be created by using the ``:annotated:``
>> > +directive option. When using this option, nested QMP code blocks must=
 be
>> > +entered explicitly with rST's ``::`` syntax.
>>
>
> Telling on myself: you can use .. code-block:: QMP too, but I figured
> recommending "::" was shorter and sweeter. There are lots of minutiae here
> for people who haven't spent a long time reading and writing rST, so I
> tried to keep it short.

Makes sense.

>> > +
>> > +Highlighting in non-QMP languages can be accomplished by using the
>> > +``.. code-block:: lang`` directive, and non-highlighted text can be
>> > +achieved by omitting the language argument.
>> >
>> >  For example::
>> >
>> > +  # .. qmp-example::
>> > +  #    :annotated:
>> > +  #    :title: A more complex demonstration
>> > +  #
>> > +  #    This is a more complex example that can use
>> > +  #    ``arbitrary rST syntax`` in its exposition::
>> > +  #
>> > +  #      -> { "execute": "query-block" }
>> > +  #      <- { ... }
>> > +  #
>> > +  #    Above, lengthy output has been omitted for brevity.
>> > +
>> > +
>> > +Examples of complete definition documentation::
>> > +
>> >   ##
>> >   # @BlockStats:
>> >   #
>> > @@ -1058,11 +1098,11 @@ For example::
>> >   #
>> >   # Since: 0.14
>> >   #
>> > - # Example:
>> > + # .. qmp-example::
>> >   #
>> >   #     -> { "execute": "query-blockstats" }
>> >   #     <- {
>> > - #          ... lots of output ...
>> > + #          ...
>> >   #        }
>> >   ##
>> >   { 'command': 'query-blockstats',
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 6ad5663e545..adc85b5b394 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -553,7 +553,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                      # Note: "sections" with two colons are left alone=
 as
>> >                      # rST markup and not interpreted as a section hea=
ding.
>> >
>> > -                    # TODO: Remove this error sometime in 2025 or so
>> > +                    # TODO: Remove these errors sometime in 2025 or so
>> >                      # after we've fully transitioned to the new qapid=
oc
>> >                      # generator.
>> >
>> > @@ -567,6 +567,14 @@ def get_doc(self) -> 'QAPIDoc':
>> >                          )
>> >                          raise QAPIParseError(self, emsg)
>> >
>> > +                    if 'Example' in match.group(1):
>> > +                        emsg =3D (
>> > +                            f"The '{match.group(1)}' section is no lo=
nger "
>> > +                            "supported. Please use the '.. qmp-exampl=
e::' "
>> > +                            "directive, or other suitable markup inst=
ead."
>> > +                        )
>> > +                        raise QAPIParseError(self, emsg)
>> > +
>> >                      doc.new_tagged_section(self.info, match.group(1))
>> >                      text =3D line[match.end():]
>> >                      if text:
>> > diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json
>> > index 107123f8a8d..c71d65cd51f 100644
>> > --- a/tests/qapi-schema/doc-good.json
>> > +++ b/tests/qapi-schema/doc-good.json
>> > @@ -172,12 +172,17 @@
>> >  #
>> >  #  Duis aute irure dolor
>> >  #
>> > -# Example:
>> > +# .. qmp-example::
>> > +#    :title: Ideal fast-food burger situation
>> >  #
>> > -#  -> in
>> > -#  <- out
>> > +#    -> "in"
>> > +#    <- "out"
>>
>> Heh, trickery to make the text right of -> and <- JSON.
>>
>
> O:-)
>
> It's maybe *slightly* bad form, but it does help illustrate how the new
> directive is transformed when using text output modes in the test suite, =
so
> I kept it. The new directive will simply not allow malformed JSON, so this
> seemed like the simplest way to cheese that.

I figure an alternative would be a more flexible "...".

Two hunks up, you dumb one down:

    - # Example:
    + # .. qmp-example::
      #
      #     -> { "execute": "query-blockstats" }
      #     <- {
    - #          ... lots of output ...
    + #          ...
      #        }

If qmp_lexer.py understood this more verbose ellipsis, we could use
something like

      #    -> ... input ...
      #    <- ... output ...

Worth the bother?  Certainly not just for tests.  Maybe for nicer
examples in real documentation?  Up to you!

>> >  #
>> > -# Examples:
>> > +# Examples::
>> > +#
>> > +#  - Not a QMP code block
>> > +#  - Merely a preformatted code block literal
>> > +#  It isn't even an rST list.
>> >  #  - *verbatim*
>> >  #  - {braces}
>>
>
> (And here, we test the use of non-QMP code block literals, esp. after the
> qmp-example directive, proving that language settings have been restored =
to
> defaults.)

Appreciated.

>> >  #
>> > @@ -199,11 +204,11 @@
>> >  # @cmd-feat1: a feature
>> >  # @cmd-feat2: another feature
>> >  #
>> > -# Example:
>> > +# .. qmp-example::
>> >  #
>> > -#  -> in
>> > +#    -> "this example"
>> >  #
>> > -#  <- out
>> > +#    <- "has no title"
>>
>> Same trickery.
>>
>
> Do you want that changed ... ?

It's just a test, good enough.

>> >  ##
>> >  { 'command': 'cmd-boxed', 'boxed': true,
>> >    'data': 'Object',
>> > diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out
>> > index bd876b6542d..eee18cd436a 100644
>> > --- a/tests/qapi-schema/doc-good.out
>> > +++ b/tests/qapi-schema/doc-good.out
>> > @@ -184,13 +184,21 @@ frobnicate
>> >   - Ut enim ad minim veniam
>> >
>> >   Duis aute irure dolor
>> > -    section=3DExample
>> > - -> in
>> > - <- out
>> > -    section=3DExamples
>> > +
>> > +.. qmp-example::
>> > +   :title: Ideal fast-food burger situation
>> > +
>> > +   -> "in"
>> > +   <- "out"
>> > +
>> > +Examples::
>> > +
>> > + - Not a QMP code block
>> > + - Merely a preformatted code block literal
>> > + It isn't even an rST list.
>> >   - *verbatim*
>> >   - {braces}
>> > -    section=3DNone
>> > +
>> >  Note::
>> >     Ceci n'est pas une note
>> >      section=3DSince
>> > @@ -202,10 +210,12 @@ If you're bored enough to read this, go see a vi=
deo of boxed cats
>> >  a feature
>> >      feature=3Dcmd-feat2
>> >  another feature
>> > -    section=3DExample
>> > - -> in
>> > +    section=3DNone
>> > +.. qmp-example::
>> >
>> > - <- out
>> > +   -> "this example"
>> > +
>> > +   <- "has no title"
>> >  doc symbol=3DEVT_BOXED
>> >      body=3D
>> >
>> > diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-go=
od.txt
>> > index 30d457e5488..cb37db606a6 100644
>> > --- a/tests/qapi-schema/doc-good.txt
>> > +++ b/tests/qapi-schema/doc-good.txt
>> > @@ -217,17 +217,16 @@ Notes:
>> >
>> >  Duis aute irure dolor
>> >
>> > +Example: Ideal fast-food burger situation:
>>
>
> No comment on the american making fast food burger jokes? :-(

I chuckled, but no witticism came to me, so...
>
>> >
>> > -Example
>> > -~~~~~~~
>> > +   -> "in"
>> > +   <- "out"
>> >
>> > -   -> in
>> > -   <- out
>> > -
>> > -
>> > -Examples
>> > -~~~~~~~~
>> > +Examples:
>> >
>> > +   - Not a QMP code block
>> > +   - Merely a preformatted code block literal
>> > +   It isn't even an rST list.
>> >     - *verbatim*
>> >     - {braces}
>> >
>> > @@ -261,13 +260,11 @@ Features
>> >  "cmd-feat2"
>> >     another feature
>> >
>> > +Example::
>> >
>> > -Example
>> > -~~~~~~~
>> > +   -> "this example"
>> >
>> > -   -> in
>> > -
>> > -   <- out
>> > +   <- "has no title"
>> >
>> >
>> >  "EVT_BOXED" (Event)
>>
>
> Does this adequately resolve your qualms about .txt rendering for example=
s?

I think you mean my "Rendering to text now loses the "Example" heading"
on "[PATCH 13/13] qapi: convert "Example" sections to rST".  The diff
above demonstrates it's no longer lost.

There's a tiny issue you may or may not want to address: an example
isn't always separated by a blank line.  To reproduce, add my TODO hack
to announce-self, and examine qemu-qmp-ref.txt:

    "announce-self" (Command)
    -------------------------

    Trigger generation of broadcast RARP frames to update network
    switches.  This can be useful when network bonds fail-over the active
    slave.


    Arguments
    ~~~~~~~~~

--> The members of "AnnounceParameters"
--> Example::

       -> { "execute": "announce-self",
            "arguments": {
                "initial": 50, "max": 550, "rounds": 10, "step": 50,
                "interfaces": ["vn2", "vn3"], "id": "bob" } }
       <- { "return": {} }


