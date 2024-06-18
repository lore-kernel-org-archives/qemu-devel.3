Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA2C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWhN-0002Ev-OO; Tue, 18 Jun 2024 07:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJWhL-0002Dz-CN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJWhI-0003yt-JJ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718708899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtlpwM+xw7GOrhqDdYcqPh+//63a2KIWzAGGn3P7Tfk=;
 b=Q8pVFB1HAeMeaTynmQztpO848d7/mnq6tlFQJ7N+gxJ4KdykLziIuKOE7kwqkq6box+dVb
 h2InxJzy5rs7dhE5+EzB7COq2Q+oLb4YpawLk1cavOGWxQ5R4qOyv8lYA7Czu2A1aeE1//
 IyIbk4zZMmYOkKwJdzw2nZMxB+J4pI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-zTY19Y_nOh-D_OjMw9r78w-1; Tue,
 18 Jun 2024 07:08:17 -0400
X-MC-Unique: zTY19Y_nOh-D_OjMw9r78w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8539C1956050; Tue, 18 Jun 2024 11:08:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5F141955F2D; Tue, 18 Jun 2024 11:08:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1F8521E6621; Tue, 18 Jun 2024 13:08:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Ani Sinha <anisinha@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>,  Jiri Pirko
 <jiri@resnulli.us>,  Mads Ynddal <mads@ynddal.dk>,  Jason Wang
 <jasowang@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 19/20] qapi: convert "Note" sections to plain rST
In-Reply-To: <CAFn=p-aZO54tiX=ebziayAkUZpR2wjGthpArcSOYxwz+iHU3pA@mail.gmail.com>
 (John Snow's message of "Mon, 17 Jun 2024 15:56:36 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-20-jsnow@redhat.com>
 <87msnnzlj8.fsf@pond.sub.org>
 <CAFn=p-aZO54tiX=ebziayAkUZpR2wjGthpArcSOYxwz+iHU3pA@mail.gmail.com>
Date: Tue, 18 Jun 2024 13:08:09 +0200
Message-ID: <87bk3y8q5i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> On Fri, Jun 14, 2024, 9:44=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > We do not need a dedicated section for notes. By eliminating a special=
ly
>> > parsed section, these notes can be treated as normal rST paragraphs in
>> > the new QMP reference manual, and can be placed and styled much more
>> > flexibly.
>> >
>> > Update the QAPI parser to now prohibit special "Note" sections while
>> > suggesting a new syntax.
>> >
>> > The exact formatting to use is a matter of taste, but a good candidate
>> > is simply:
>> >
>> > .. note:: lorem ipsum ...
>> >
>> > but there are other choices, too. The Sphinx readthedocs theme offers
>> > theming for the following forms (capitalization unimportant); all are
>> > adorned with a (!) symbol in the title bar for rendered HTML docs.
>>
>
> Store this paragraph in your L1 cache for a moment ...
>
>>
>> > These are rendered in orange:
>> >
>> > .. Attention:: ...
>> > .. Caution:: ...
>> > .. WARNING:: ...
>> >
>> > These are rendered in red:
>> >
>> > .. DANGER:: ...
>> > .. Error:: ...
>> >
>> > These are rendered in green:
>> >
>> > .. Hint:: ...
>> > .. Important:: ...
>> > .. Tip:: ...
>> >
>> > These are rendered in blue:
>> >
>> > .. Note:: ...
>> > .. admonition:: custom title
>> >
>> >    admonition body text
>> >
>> > This patch uses ".. notes::" almost everywhere, with just two "caution"
>> > directives. ".. admonition:: notes" is used in a few places where we h=
ad
>> > an ordered list of multiple notes.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/block-core.json                          | 30 +++----
>> >  qapi/block.json                               |  2 +-
>> >  qapi/char.json                                | 12 +--
>> >  qapi/control.json                             | 15 ++--
>> >  qapi/dump.json                                |  2 +-
>> >  qapi/introspect.json                          |  6 +-
>> >  qapi/machine-target.json                      | 26 +++---
>> >  qapi/machine.json                             | 47 +++++-----
>> >  qapi/migration.json                           | 12 +--
>> >  qapi/misc.json                                | 88 +++++++++----------
>> >  qapi/net.json                                 |  6 +-
>> >  qapi/pci.json                                 |  7 +-
>> >  qapi/qdev.json                                | 30 +++----
>> >  qapi/qom.json                                 | 19 ++--
>> >  qapi/rocker.json                              | 16 ++--
>> >  qapi/run-state.json                           | 18 ++--
>> >  qapi/sockets.json                             | 10 +--
>> >  qapi/stats.json                               | 22 ++---
>> >  qapi/transaction.json                         |  8 +-
>> >  qapi/ui.json                                  | 29 +++---
>> >  qapi/virtio.json                              | 12 +--
>> >  qga/qapi-schema.json                          | 48 +++++-----
>> >  scripts/qapi/parser.py                        |  9 ++
>> >  tests/qapi-schema/doc-empty-section.err       |  2 +-
>> >  tests/qapi-schema/doc-empty-section.json      |  2 +-
>> >  tests/qapi-schema/doc-good.json               |  6 +-
>> >  tests/qapi-schema/doc-good.out                | 10 ++-
>> >  tests/qapi-schema/doc-good.txt                | 14 ++-
>> >  .../qapi-schema/doc-interleaved-section.json  |  2 +-
>> >  29 files changed, 258 insertions(+), 252 deletions(-)
>>
>> Missing: update of docs/devel/qapi-code-gen.rst.  Something like
>>
>> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
>> index f453bd3546..1a4e240adb 100644
>> --- a/docs/devel/qapi-code-gen.rst
>> +++ b/docs/devel/qapi-code-gen.rst
>> @@ -995,14 +995,13 @@ line "Features:", like this::
>>    # @feature: Description text
>>
>>  A tagged section begins with a paragraph that starts with one of the
>> -following words: "Note:"/"Notes:", "Since:", "Example:"/"Examples:",
>> -"Returns:", "Errors:", "TODO:".  It ends with the start of a new
>> -section.
>> +following words: "Since:", "Example:"/"Examples:", "Returns:",
>> +"Errors:", "TODO:".  It ends with the start of a new section.
>>
>>  The second and subsequent lines of tagged sections must be indented
>>  like this::
>>
>> - # Note: Ut enim ad minim veniam, quis nostrud exercitation ullamco
>> + # TODO: Ut enim ad minim veniam, quis nostrud exercitation ullamco
>>   #     laboris nisi ut aliquip ex ea commodo consequat.
>>   #
>>   #     Duis aute irure dolor in reprehenderit in voluptate velit esse
>>
>>
> Done.

Thanks!

>> >
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 64fe5240cc9..530af40404d 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -1510,7 +1510,7 @@
>> >  # @mode: whether and how QEMU should create a new image, default is
>> >  #     'absolute-paths'.
>> >  #
>> > -# Note: Either @device or @node-name must be set but not both.
>> > +# .. note:: Either @device or @node-name must be set but not both.
>>
>> The commit message talks about ".. Note::", but you actually use
>> ".. note::".  Is there a difference?
>>
>
> Retrieve paragraph from L1 cache.
>
> Nope! Sphinx RTD theme docs use capitals sporadically, but it's case
> insensitive. I stuck with all lowercase everywhere in the patches, but the
> capitalization in the commit message came directly from the Sphinx RTD
> theme documentation.

Lowercase seems to be consistent with existing usage elsewhere.

I'd stick to lowercase in the commit message as well.  Matter of taste,
you decide.

>> >  #
>> >  ##
>> >  { 'struct': 'BlockdevSnapshotSync',
>> > @@ -1616,9 +1616,9 @@
>> >  #
>> >  # @unstable: Member @x-perf is experimental.
>> >  #
>> > -# Note: @on-source-error and @on-target-error only affect background
>> > -#     I/O.  If an error occurs during a guest write request, the
>> > -#     device's rerror/werror actions will be used.
>> > +# .. note:: @on-source-error and @on-target-error only affect backgro=
und
>> > +#    I/O.  If an error occurs during a guest write request, the devic=
e's
>> > +#    rerror/werror actions will be used.
>> >  #
>> >  # Since: 4.2
>> >  ##
>> > @@ -5534,8 +5534,8 @@
>> >  #     after this event and must be repaired (Since 2.2; before, every
>> >  #     BLOCK_IMAGE_CORRUPTED event was fatal)
>> >  #
>> > -# Note: If action is "stop", a STOP event will eventually follow the
>> > -#     BLOCK_IO_ERROR event.
>> > +# .. note:: If action is "stop", a STOP event will eventually follow =
the
>> > +#    BLOCK_IO_ERROR event.
>> >  #
>> >  # Example:
>> >  #
>> > @@ -5581,8 +5581,8 @@
>> >  #     field is a debugging aid for humans, it should not be parsed by
>> >  #     applications) (since: 2.2)
>> >  #
>> > -# Note: If action is "stop", a STOP event will eventually follow the
>> > -#     BLOCK_IO_ERROR event
>> > +# .. note:: If action is "stop", a STOP event will eventually follow =
the
>> > +#    BLOCK_IO_ERROR event.
>>
>> You're adding a period.  Okay, but please mention it in the commit
>> message.
>>
>
> OK. When hoisting notes into little visual boxes I felt it looked naked
> without the punctuation, so I just went for it. Sorry.

You're right, and I appreciate your attention to detail.

>> >  #
>> >  # Since: 0.13
>> >  #
>> > @@ -5720,8 +5720,8 @@
>> >  #
>> >  # @speed: rate limit, bytes per second
>> >  #
>> > -# Note: The "ready to complete" status is always reset by a
>> > -#     @BLOCK_JOB_ERROR event
>> > +# .. note:: The "ready to complete" status is always reset by a
>> > +#    @BLOCK_JOB_ERROR event.
>>
>> Likewise.  Not going to point this out again.
>>
>
> I just need to update the commit message, yeah?.

Either that, or you add the periods in a separate patch, possibly
together with related changes.

>> >  #
>> >  # Since: 1.3
>> >  #
>> > @@ -5974,7 +5974,7 @@
>> >  #
>> >  # @sectors-count: failed read operation sector count
>> >  #
>> > -# Note: This event is rate-limited.
>> > +# .. note:: This event is rate-limited.
>> >  #
>> >  # Since: 2.0
>> >  #
>> > @@ -6005,7 +6005,7 @@
>> >  #
>> >  # @sectors-count: failed read operation sector count
>> >  #
>> > -# Note: This event is rate-limited.
>> > +# .. note:: This event is rate-limited.
>> >  #
>> >  # Since: 2.0
>> >  #
>> > @@ -6037,9 +6037,9 @@
>> >  #
>> >  # @name: the name of the internal snapshot to be created
>> >  #
>> > -# Notes: In transaction, if @name is empty, or any snapshot matching
>> > -#     @name exists, the operation will fail.  Only some image formats
>> > -#     support it, for example, qcow2, and rbd.
>> > +# .. note:: In a transaction, if @name is empty or any snapshot match=
ing
>> > +#    @name exists, the operation will fail.  Only some image formats
>> > +#    support it; for example, qcow2, and rbd.
>>
>> You're fixing up prose.  Welcome, but put it in a separate patch,
>> please, to keep this one mechanical.
>>
>
> Couldn't help it while auditing every last notebox. (:

Again, I appreciate your attention to detail.

> OK, separate patch...
>
>
>> >  #
>> >  # Since: 1.7
>> >  ##
>> > diff --git a/qapi/block.json b/qapi/block.json
>> > index 5de99fe09d9..ea81d9e1921 100644
>> > --- a/qapi/block.json
>> > +++ b/qapi/block.json
>> > @@ -113,7 +113,7 @@
>> >  # Errors:
>> >  #     - If @device is not a valid block device, DeviceNotFound
>> >  #
>> > -# Notes: Ejecting a device with no media results in success
>> > +# .. note:: Ejecting a device with no media results in success.
>> >  #
>> >  # Since: 0.14
>> >  #
>> > diff --git a/qapi/char.json b/qapi/char.json
>> > index ab4c23976ed..0f39c2d5cdf 100644
>> > --- a/qapi/char.json
>> > +++ b/qapi/char.json
>> > @@ -21,8 +21,8 @@
>> >  #     backend (e.g. with the chardev=3D... option) is in open or clos=
ed
>> >  #     state (since 2.1)
>> >  #
>> > -# Notes: @filename is encoded using the QEMU command line character
>> > -#     device encoding.  See the QEMU man page for details.
>> > +# .. note:: @filename is encoded using the QEMU command line character
>> > +#    device encoding.  See the QEMU man page for details.
>> >  #
>> >  # Since: 0.14
>> >  ##
>> > @@ -387,9 +387,9 @@
>> >  #
>> >  # @rows: console height, in chars
>> >  #
>> > -# Note: the options are only effective when the VNC or SDL graphical
>> > -#     display backend is active.  They are ignored with the GTK,
>> > -#     Spice, VNC and D-Bus display backends.
>> > +# .. note:: The options are only effective when the VNC or SDL graphi=
cal
>> > +#    display backend is active.  They are ignored with the GTK, Spice,
>> > +#    VNC and D-Bus display backends.
>>
>> You're capitalizing the beginning of the note text.  Good, because the
>> generated HTML wants that.  But please mention it in the commit message.
>>
>> More below; not going to point it out.
>>
>
> OK; so long as the commit message mentions it, we don't need to make note
> of each time I do it, right...?

A blanket notice should suffice.  Something like "Tidy up note text to
start with a capital letter and end with a period, because the formatted
documentation clearly looks better that way."

>> >  #
>> >  # Since: 1.5
>> >  ##
>> > @@ -805,7 +805,7 @@
>> >  #
>> >  # @open: true if the guest has opened the virtio-serial port
>> >  #
>> > -# Note: This event is rate-limited.
>> > +# .. note:: This event is rate-limited.
>> >  #
>> >  # Since: 2.1
>> >  #
>> > diff --git a/qapi/control.json b/qapi/control.json
>> > index 10c906fa0e7..2498e5dd6ba 100644
>> > --- a/qapi/control.json
>> > +++ b/qapi/control.json
>> > @@ -22,14 +22,13 @@
>> >  #          "arguments": { "enable": [ "oob" ] } }
>> >  #     <- { "return": {} }
>> >  #
>> > -# Notes: This command is valid exactly when first connecting: it must
>> > -#     be issued before any other command will be accepted, and will
>> > -#     fail once the monitor is accepting other commands.  (see qemu
>> > -#     docs/interop/qmp-spec.rst)
>> > +# .. note:: This command is valid exactly when first connecting: it m=
ust
>> > +#    be issued before any other command will be accepted, and will fa=
il
>> > +#    once the monitor is accepting other commands.
>> > +#    (see :doc:`/interop/qmp-spec`)
>>
>> You're adding markup to make a reference work.  Welcome, but put it in a
>> separate patch, please, to keep this one mechanical.
>>
>
> Whoops. This snuck in. I do have a growing markup change patch...
>
>
>> >  #
>> > -#     The QMP client needs to explicitly enable QMP capabilities,
>> > -#     otherwise all the QMP capabilities will be turned off by
>> > -#     default.
>> > +# .. note:: The QMP client needs to explicitly enable QMP capabilitie=
s,
>> > +#    otherwise all the QMP capabilities will be turned off by default.
>> >  #
>> >  # Since: 0.13
>> >  ##
>> > @@ -150,7 +149,7 @@
>> >  #          ]
>> >  #        }
>> >  #
>> > -# Note: This example has been shortened as the real response is too
>> > +#     Note: This example has been shortened as the real response is t=
oo
>> >  #     long.
>>
>> Your commit message lists a number of conversions.  This one isn't among
>> them.
>>
>> The next patch reverts the indentation and drops "Note: ":
>>
>>    -#     Note: This example has been shortened as the real response is =
too
>>    -#     long.
>>    +# This example has been shortened as the real response is too long.
>>
>> Hmm.  Swap the two patches?  Perhaps not worth the bother now.  Squash
>> the next patch's change into this one?
>>
>
> Yeah, OK. (The problem was that this began being picked up as a note
> section in its own right, but I thought it wasn't appropriate in this cas=
e,
> but needed to avoid the parser complaining about the old Note: section.)
>
>
>> A few more below.
>>
>> >  ##
>> >  { 'command': 'query-commands', 'returns': ['CommandInfo'],

[...]

>> > diff --git a/qapi/misc.json b/qapi/misc.json
>> > index 4b41e15dcd4..b04efbadec6 100644
>> > --- a/qapi/misc.json
>> > +++ b/qapi/misc.json
>> > @@ -103,9 +103,9 @@
>> >  #
>> >  # Returns a list of information about each iothread.
>> >  #
>> > -# Note: this list excludes the QEMU main loop thread, which is not
>> > -#     declared using the -object iothread command-line option.  It is
>> > -#     always the main thread of the process.
>> > +# .. note:: This list excludes the QEMU main loop thread, which is not
>> > +#    declared using the ``-object iothread`` command-line option.  It=
 is
>> > +#    always the main thread of the process.
>>
>> You're adding markup.  Welcome, but put it in a separate patch, please,
>> to keep this one mechanical.
>>
>
> OK

[...]

>> > @@ -1461,16 +1462,15 @@
>> >  #     * POSIX: as defined by os-release(5)
>> >  #     * Windows: contains string "server" or "client"
>> >  #
>> > -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>> > -#     @version, @version-id, @variant and @variant-id follow the
>> > -#     definition specified in os-release(5). Refer to the manual page
>> > -#     for exact description of the fields.  Their values are taken
>> > -#     from the os-release file.  If the file is not present in the
>> > -#     system, or the values are not present in the file, the fields
>> > -#     are not included.
>> > +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>> > +#    @version, @version-id, @variant and @variant-id follow the
>> > +#    definition specified in os-release(5). Refer to the manual page =
for
>> > +#    exact description of the fields.  Their values are taken from the
>> > +#    os-release file.  If the file is not present in the system, or t=
he
>> > +#    values are not present in the file, the fields are not included.
>> >  #
>> > -#     On Windows the values are filled from information gathered from
>> > -#     the system.
>> > +#    On Windows the values are filled from information gathered from
>> > +#    the system.
>>
>> Accidental indentation change?
>
> I don't think so; the original heading seems to suggest that there is a
> sequence of notes; "On POSIX" ... "On Windows". This indentation change
> keeps this information in the same note box.

Still in the same box if I instead keep the indentation like this:

     @@ -1461,7 +1462,7 @@
      #     * POSIX: as defined by os-release(5)
      #     * Windows: contains string "server" or "client"
      #
     -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
     +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
      #     @version, @version-id, @variant and @variant-id follow the
      #     definition specified in os-release(5). Refer to the manual page
      #     for exact description of the fields.  Their values are taken

>> >  #
>> >  # Since: 2.10
>> >  ##

[...]


