Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F1BC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWxt-0001e6-Ss; Tue, 18 Jun 2024 07:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJWxp-0001dF-UO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJWxn-0007PK-Jx
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718709923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPGKaMRCSLQxHp3OrgstpZshzpPx4hqOuSo9BmXkoLU=;
 b=HUThm9D5z5Nppb1gF3YLzulndGtfKsy9UKxxtmQyVI5uITM1054dY74zDPHIReIL5RVekR
 TZs8x8SyF2vrncTHinmvC4noo4qVJlWG09K9EwsUdQ7oGY2wNwM9nw3gAM7PXTa7cA29dM
 4kkIgqTU3Lb5xzzZaZ/+fZ53E6KA3/k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-7egiXI_PPnycu8Newu6AGg-1; Tue,
 18 Jun 2024 07:25:19 -0400
X-MC-Unique: 7egiXI_PPnycu8Newu6AGg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D414419560B4; Tue, 18 Jun 2024 11:25:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E47C1956087; Tue, 18 Jun 2024 11:25:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DA7721E66E5; Tue, 18 Jun 2024 13:25:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Ani
 Sinha <anisinha@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Mads Ynddal
 <mads@ynddal.dk>,  Jason Wang <jasowang@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH 20/20] qapi: convert "Example" sections to rST
In-Reply-To: <CAFn=p-bdRZZtZMpN12JktjtA+tyx1wag_zdErpvEo=UXPoKa=g@mail.gmail.com>
 (John Snow's message of "Mon, 17 Jun 2024 17:27:16 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-21-jsnow@redhat.com>
 <87r0czy4gz.fsf@pond.sub.org>
 <CAFn=p-bdRZZtZMpN12JktjtA+tyx1wag_zdErpvEo=UXPoKa=g@mail.gmail.com>
Date: Tue, 18 Jun 2024 13:25:12 +0200
Message-ID: <87v8267asn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> On Fri, Jun 14, 2024 at 10:39=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Eliminate the "Example" sections in QAPI doc blocks, converting them
>> > into QMP example code blocks. This is generally done by converting
>> > "Example:" or "Examples:" lines into ".. code-block:: QMP" lines.
>> >
>> > This patch does also allow for the use of the rST syntax "Example::" by
>> > exempting double-colon syntax from the QAPI doc parser, but that form =
is
>> > not used by this conversion patch. The phrase "Example" here is not
>> > special, it is the double-colon syntax that transforms the following
>> > block into a code-block. By default, *this* form does not apply QMP
>> > highlighting.
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
>> > 4. Each code-block can be captioned independently without bypassing the
>> >    QMP lexer/validator.
>> >
>> > For any sections with more than one example, examples are split up into
>> > multiple code-block regions. If annotations are present, those
>> > annotations are converted into code-block captions instead, e.g.
>> >
>> > ```
>> > Examples:
>> >
>> >    1. Lorem Ipsum
>> >
>> >    -> { "foo": "bar" }
>> > ```
>> >
>> > Is rewritten as:
>> >
>> > ```
>> > .. code-block:: QMP
>> >    :caption: Example: Lorem Ipsum
>> >
>> >    -> { "foo": "bar" }
>> > ```
>> >
>> > This process was only semi-automated:
>> >
>> > 1. Replace "Examples?:" sections with sed:
>> >
>> > sed -i 's|# Example:|# .. code-block:: QMP|' *.json
>> > sed -i 's|# Examples:|# .. code-block:: QMP|' *.json
>> >
>> > 2. Identify sections that no longer parse successfully by attempting t=
he
>> >    doc build, convert annotations into captions manually.
>> >    (Tedious, oh well.)
>> >
>> > 3. Add captions where still needed:
>> >
>> > sed -zi 's|# .. code-block:: QMP\n#\n|# .. code-block:: QMP\n# :captio=
n: Example\n#\n|g' *.json
>> >
>> > Not fully ideal, but hopefully not something that has to be done very
>> > often. (Or ever again.)
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/acpi.json                  |   6 +-
>> >  qapi/block-core.json            | 120 ++++++++++++++++----------
>> >  qapi/block.json                 |  60 +++++++------
>> >  qapi/char.json                  |  36 ++++++--
>> >  qapi/control.json               |  16 ++--
>> >  qapi/dump.json                  |  12 ++-
>> >  qapi/machine-target.json        |   3 +-
>> >  qapi/machine.json               |  79 ++++++++++-------
>> >  qapi/migration.json             | 145 +++++++++++++++++++++++---------
>> >  qapi/misc-target.json           |  33 +++++---
>> >  qapi/misc.json                  |  48 +++++++----
>> >  qapi/net.json                   |  30 +++++--
>> >  qapi/pci.json                   |   6 +-
>> >  qapi/qapi-schema.json           |   6 +-
>> >  qapi/qdev.json                  |  15 +++-
>> >  qapi/qom.json                   |  20 +++--
>> >  qapi/replay.json                |  12 ++-
>> >  qapi/rocker.json                |  12 ++-
>> >  qapi/run-state.json             |  45 ++++++----
>> >  qapi/tpm.json                   |   9 +-
>> >  qapi/trace.json                 |   6 +-
>> >  qapi/transaction.json           |   3 +-
>> >  qapi/ui.json                    |  62 +++++++++-----
>> >  qapi/virtio.json                |  38 +++++----
>> >  qapi/yank.json                  |   6 +-
>> >  scripts/qapi/parser.py          |  15 +++-
>> >  tests/qapi-schema/doc-good.json |  12 +--
>> >  tests/qapi-schema/doc-good.out  |  17 ++--
>> >  tests/qapi-schema/doc-good.txt  |  17 +---
>> >  29 files changed, 574 insertions(+), 315 deletions(-)
>>
>> Missing: update of docs/devel/qapi-code-gen.rst.
>>
>> > diff --git a/qapi/acpi.json b/qapi/acpi.json
>> > index aa4dbe57943..3da01f1b7fc 100644
>> > --- a/qapi/acpi.json
>> > +++ b/qapi/acpi.json
>> > @@ -111,7 +111,8 @@
>> >  #
>> >  # Since: 2.1
>> >  #
>> > -# Example:
>> > +# .. code-block:: QMP
>> > +#    :caption: Example
>>
>> I wish this was a bit less verbose.  Oh well, we'll live.
>>
>
> We can create a custom directive that assumes a default caption; e.g.
>
> .. qapi:example::
>
>     ... blah blah blah ...
>
> And if you want to override it, you'd just
>
> .. qapi:example::
>     :caption: Lorem Ipsum ...
>
>     ... blah blah blah ...
>
> Interested? (I kept this patch vanilla to avoid getting fancy, but there
> are fanciness options available if you'd like them.)

Let's keep it simple for now.

>> >  #
>> >  #     -> { "execute": "query-acpi-ospm-status" }
>> >  #     <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "D=
IMM", "source": 1, "status": 0},
>>
>> This is rendered as a light green box with the caption on top, in
>> italics and centered.  I'm not sure I like the use of the caption.  The
>> previous patch's Note boxes look nicer.
>>
>
> We can change that with styling - my dedicated CSS intern was busy with
> finals when I wrote this patch ;)

Tell her I asked for another helping of her magic!

>> The contents of the box is highlighted.  I am sure I like that.
>>
>
> Yes.
>
> [...]
>
>> > -# Example:
>> > -#
>> > -#     Set new histograms for all io types with intervals
>> > -#     [0, 10), [10, 50), [50, 100), [100, +inf):
>> > +# .. code-block:: QMP
>> > +#    :caption: Example:
>> > +#      Set new histograms for all io types with intervals
>> > +#      [0, 10), [10, 50), [50, 100), [100, +inf):
>>
>> Captions long enough to be rendered as multiple lines look particularly
>> bad to me.  The centering...
>>
>
> Will attempt to address it with CSS. I do agree, just wasn't time to hamm=
er
> it out.
>
> [...]
>
>
>> > @@ -134,7 +136,8 @@
>> >  #
>> >  # Since: 0.14
>> >  #
>> > -# Example:
>> > +# .. code-block:: QMP
>> > +#    :caption: Example
>> >  #
>> >  #     -> { "execute": "query-commands" }
>> >  #     <- {
>> > @@ -149,8 +152,8 @@
>> >  #          ]
>> >  #        }
>> >  #
>> > -#     Note: This example has been shortened as the real response is t=
oo
>> > -#     long.
>> > +# This example has been shortened as the real response is too long.
>>
>> Squash into the previous patch?
>>
>
> OK
>
> [...]
>
>
>> > diff --git a/qapi/pci.json b/qapi/pci.json
>> > index f51159a2c4c..9192212661b 100644
>> > --- a/qapi/pci.json
>> > +++ b/qapi/pci.json
>> > @@ -182,7 +182,8 @@
>> >  #
>> >  # Since: 0.14
>> >  #
>> > -# Example:
>> > +# .. code-block:: QMP
>> > +#    :caption: Example
>> >  #
>> >  #     -> { "execute": "query-pci" }
>> >  #     <- { "return": [
>> > @@ -311,8 +312,7 @@
>> >  #           ]
>> >  #        }
>> >  #
>> > -#     Note: This example has been shortened as the real response is t=
oo
>> > -#     long.
>> > +# This example has been shortened as the real response is too long.
>>
>> Squash into the previous patch?
>>
>
> OK
>
>
>>
>> >  #
>> >  ##
>> >  { 'command': 'query-pci', 'returns': ['PciInfo'] }
>> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>> > index 5e33da7228f..66fbcbd3619 100644
>> > --- a/qapi/qapi-schema.json
>> > +++ b/qapi/qapi-schema.json
>> > @@ -20,11 +20,7 @@
>> >  # understand.  However, in real protocol usage, they're emitted as a
>> >  # single line.
>> >  #
>> > -# Also, the following notation is used to denote data flow:
>> > -#
>> > -# Example:
>> > -#
>> > -# ::
>> > +# Also, the following notation is used to denote data flow::
>> >  #
>> >  #   -> data issued by the Client
>> >  #   <- Server data response
>>
>> No use of caption here.  Looks better, I think.
>>
>
> OK - Let me play around with the styling, because I do want to have some
> kind of form option available for cargo-culting to add captions or an
> explanation of some kind. If I can't make it look good with CSS, I'll
> capitulate and mark them up as alternating normal paragraphs and examples.
>
> Forbidding "Examples?:" was just an easy way to make sure I converted
> everything; and especially to catch any late merges ... I am hesitant to =
go
> that route for maintainability. But, if you want to volunteer to play
> whack-a-mole for the next few releases, then...

Making use of the old tag a hard error is a smart move.  But I'm
prepared to sacrifice it for more nicely formatted examples.

> (Also, this example doesn't use the QMP lexer, because it's not real QMP.

Yes.

> It could be cajoled by making the lines string values, for example - or
> making it a more representative example that actually resembles QMP.)

No need unless it actually improves the generated docs.

>> > diff --git a/qapi/qdev.json b/qapi/qdev.json
>> > index d031fc3590d..cfe403fea20 100644
>> > --- a/qapi/qdev.json
>> > +++ b/qapi/qdev.json
>> > @@ -62,7 +62,8 @@
>> >  #        the ``-device DEVICE,help`` command-line argument, where DEV=
ICE
>> >  #        is the device's name.
>> >  #
>> > -# Example:
>> > +# .. code-block:: QMP
>> > +#    :caption: Example
>> >  #
>> >  #     -> { "execute": "device_add",
>> >  #          "arguments": { "driver": "e1000", "id": "net1",
>>
>> How does
>>
>>    # Example:
>>   +# .. code-block:: QMP
>>    #
>>    #     -> { "execute": "device_add",
>>    #          "arguments": { "driver": "e1000", "id": "net1",
>>
>> look?  Requires nerfing the error you add to parser.py.
>>
>
> Undesirable, IMO -- but "Example::" alongside an option to choose the QMP
> lexer by default for QMP docs may be acceptable. I can demo some choices
> for you on a screenshare call if you'd like to workshop this aesthetic
> choice out together.
>
> [...]
>
>
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 8b1da96124e..afc0b444034 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -554,9 +554,12 @@ def get_doc(self) -> 'QAPIDoc':
>> >                      no_more_args =3D True
>> >                      intro =3D False
>> >                  elif match :=3D re.match(
>> > -                        r'(Returns|Errors|Since|Notes?|Examples?|TODO=
): *',
>> > +                        r'(Returns|Errors|Since|Notes?|Examples?(?!::=
)|TODO)'
>> > +                        r': *',
>> >                          line):
>>
>> Hmm, I wonder...
>>
>>
>> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#=
literal-blocks
>> has:
>>
>>     Literal code blocks (ref) are introduced by ending a paragraph with
>>     the special marker ::.
>>
>> Not capturing regular rST markup like
>>
>>     Example::
>>
>>         mumble mumble
>>
>> for our own purposes makes sense.  But it makes exactly as much sense
>> for any of the tags, doesn'it?
>>
>> Should we instead change the regexp to match only when there's a
>> *single* colon?
>>
>
> OK. My regexp-fu is maybe weak, but I think I can just put (?!::): at the
> end of this regex without tying it to Examples, and I'll move that into i=
ts
> own patch.
>
>>
>>
>> > -                    # tagged section
>> > +                    # tagged section.
>>
>> Spurious comment change.
>>
>
> A *beautiful* comment change. An *inspired* comment change.
>
> (OK, removing it...)
>
>
>>
>> > +                    # Examples sections followed by two colons are ex=
cluded;
>> > +                    # those are raw rST syntax!
>> >
>> >                      if 'Note' in match.group(1):
>> >                          emsg =3D (
>> > @@ -566,6 +569,14 @@ def get_doc(self) -> 'QAPIDoc':
>> >                          )
>> >                          raise QAPIParseError(self, emsg)
>> >
>> > +                    if match.group(1).startswith("Example"):
>> > +                        emsg =3D (
>> > +                            f"The '{match.group(1)}' section is depre=
cated. "
>> > +                            "Please use rST's '.. code-block:: QMP' d=
irective,"
>> > +                            " 'Example::', or other suitable markup i=
nstead."
>> > +                        )
>> > +                        raise QAPIParseError(self, emsg)
>> > +
>>
>> I guess this will be helpful while people get used to the changed
>> syntax.  Once they are, I'd like to get rid of it.  Same for "Note"
>> right above.
>>
>
> Yeah - the thinking was that it would help buffer the transitional period
> and could be removed after a release or two. I'll update the phrasing to
> not use "deprecated", also.

Throw in a TODO comment to remind us.

>> >                      doc.new_tagged_section(self.info, match.group(1))
>> >                      text =3D line[match.end():]
>> >                      if text:
>> > diff --git a/tests/qapi-schema/doc-good.json
>> b/tests/qapi-schema/doc-good.json
>> > index 0a294eb324e..57e2e591938 100644
>> > --- a/tests/qapi-schema/doc-good.json
>> > +++ b/tests/qapi-schema/doc-good.json
>> > @@ -46,11 +46,12 @@
>> >  #
>> >  # Duis aute irure dolor
>> >  #
>> > -# Example:
>> > +# .. code-block:: QMP
>>
>> No captions here?
>>
>
> They aren't *required*, I just liked having a dedicated place to put 'em =
in
> the rendered output for our real docs.

If captions are optional, doc-good should have at least one with
caption, and one without caption.

> [...]
>
>
>> I want this just as much as the previous patch.
>>
>>
> okie-dokey, I'll include it in the mini-fork of the pre-req series.


