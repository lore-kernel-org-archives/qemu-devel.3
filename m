Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A36FEC01A1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4aRr-0006dh-CM; Mon, 23 Mar 2026 04:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4aRi-0006d7-34
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4aRg-0006tX-7r
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774253731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojFXdw6PZlOuZMJ+kH95L84PJ5hIrATRQx7Wz8BZ8Ww=;
 b=a7YtT9gGUKA9cvsvc7c443XKCLTLuT7J69UjPrx/9LBocsP/zXaQd1j2w73ZJSL/zH56LT
 XrUDwgu4nTUlfMT75YrOCVYvEGh4vHwoqXd1gGEKnjLpSuC3ZQbWfZfqzNn+tEhlPljDPF
 dZNoELp2WshU9skIBDFUduQdZHSG/H4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-qig_37FIN0CtoHYC1bZmiQ-1; Mon,
 23 Mar 2026 04:15:28 -0400
X-MC-Unique: qig_37FIN0CtoHYC1bZmiQ-1
X-Mimecast-MFC-AGG-ID: qig_37FIN0CtoHYC1bZmiQ_1774253726
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A34B518005BA; Mon, 23 Mar 2026 08:15:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5099A1955D71; Mon, 23 Mar 2026 08:15:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A451921E6937; Mon, 23 Mar 2026 09:15:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jason Wang <jasowang@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Alex Williamson <alex@shazbot.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Yanan
 Wang <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 1/8] qapi: differentiate "intro" and "details" sections
In-Reply-To: <CAFn=p-b5uJL8uW_zVg6+30xVVO8MXwD=ukFk-H3UCjT7dHia5g@mail.gmail.com>
 (John Snow's message of "Fri, 20 Mar 2026 13:20:59 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-2-jsnow@redhat.com>
 <87se9u7koi.fsf@pond.sub.org>
 <CAFn=p-b5uJL8uW_zVg6+30xVVO8MXwD=ukFk-H3UCjT7dHia5g@mail.gmail.com>
Date: Mon, 23 Mar 2026 09:15:18 +0100
Message-ID: <87wlz3ynah.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Fri, Mar 20, 2026, 8:24=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch begins distinguishing "Plain" sections as being either
>> > "Intro" or "Details" sections for the purpose of knowing when/where/how
>> > to inline those sections.
>> >
>> > The Intro section is always the first section of any doc block. It may
>> > be empty or any number of paragraphs. It is interrupted by any other
>> > non-plaintext section, i.e.; Members, Features, Errors, Returns, Since,
>> > and TODO.
>> >
>> > The details section, when present, is either the last section or the
>> > second-to-last section when a "Since:" section is present. It consists
>> > of any plain text in the doc block that follows any named sections if
>> > present.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> The commit message explains what kinds INTRO and DETAILS are, but not
>> why they're useful.  My guess:
>>
>
> Right, my apologies. Leaning on you having some existing knowledge here,
> and also going light on details because the series is still obviously in
> flux.

No worries!

> Let me elaborate on the motivations here...
>
>
>> 1. Represent the future "Details:" marker: the plain section before it
>> is of kind INTRO, the one afterwards is of kind DETAILS.
>>
>
> Yes.
>
>
>> 2. Future programming convenience?  With just PLAIN, code may have to
>> understand the section's context to make decisions, and with INTRO and
>> DETAILS is doesn't.
>>
>> Guess close enough?
>>
>
> Pretty much.
>
> Originally, I thought I'd inline things like this:
>
> Intro (child)
> Intro (parent)
> ...other sections...
> Details (parent)
> Details (child)
>
> Last time we went over this, you mused that there was likely never a
> sufficient reason to actually inline the intro. I recall believing and
> accepting this.

Turns out we use the first section (i.e. INTRO) for describing the thing
being defined.  Inlining such descriptions results in nonsense.  For
instance, here's SevGuestProperties and its base SevGuestProperties:

    ##
    # @SevCommonProperties:
    #
    # Properties common to objects that are derivatives of sev-common.
    #
    [...]
    ##
    # @SevGuestProperties:
    #
    # Properties for sev-guest objects.
    #
    # @dh-cert-file: guest owners DH certificate (encoded with base64)
    #
    [...]

Inlining the base as you originally thought would result in something
like

    Object SevGuestProperties (Since: 2.12)

       Properties for sev-guest objects.

       Properties common to objects that are derivatives of sev-common.

       Members: * dh-cert-file (string, optional) -- guest owners DH
       certificate (encoded with base64)

The intro paragraph inlined from the base is nonsense.

We either stop writing such descriptions (ugh), or we drop them on
inlining.  If we drop, code needs to recognize them.  The only method I
can see is to assume INTRO is description.

Now, the QAPI generator cannot stop people from putting stuff in INTRO
is *not* description and *should* be inlined.  This is a risk we will
have to accept to gain the benefits of inlining.

For the inliner's initial merge, we'll want to review all the INTRO
sections the inliner drops.  If almost all of them are fine, the risk is
low.

> So functionally what this does for us is:
>
> (1) Explicitly delineate what comes before the tabular section of the docs
> (members, Returns, Errors, features) and what comes after.
>
> (2) Explicitly defines what will not be inlined.

Yes.

I think we'll want to at least hint at this in the final commit message.
The full story would be too much, I guess.

>> The commit message covers PLAIN sections at the beginning and at the end
>> (modulo Since:).  It doesn't cover PLAIN sections between tagged
>> sections / member descriptions.  You disallow these in PATCH 2.  You can
>> either cover them here, or get rid of them by swapping PATCH 1 and 2.
>>
>
> Sure. For now they're separated just to separate concerns in review, but =
if
> you believe both should be all-at-once, that's fine too. I think there's
> not a regression by separating it, though. It's just a semantic change fr=
om
> details meaning "anything after the intro" to "specifically the closing
> section". The intermediate meaning exists for only one patch.

Have you tried swapping the patches?

If that's bothersome, squashing them together may well do.

>> Hmm, is your description of DETAILS accurate?  Looks like it isn't; see
>> my review of tests/qapi-schema/doc-good.out below.
>>
>
> Whoops, future-think. It winds up being true, but isn't true yet as of th=
is
> commit. Well, almost. See below.
>
>
>> > ---
>> >  docs/sphinx/qapidoc.py         |  2 +-
>> >  scripts/qapi/parser.py         | 35 +++++++++++++++++++++++-----------
>> >  tests/qapi-schema/doc-good.out |  8 ++++----
>> >  3 files changed, 29 insertions(+), 16 deletions(-)
>>
>> [Skipping the Python code in my first pass...]
>>
>> > diff --git a/tests/qapi-schema/doc-good.out
>> b/tests/qapi-schema/doc-good.out
>> > index 04a55072646..04e29e8d50f 100644
>> > --- a/tests/qapi-schema/doc-good.out
>> > +++ b/tests/qapi-schema/doc-good.out
>> > @@ -116,7 +116,7 @@ The _one_ {and only}, description on the same line
>> >  Also _one_ {and only}
>> >      feature=3Denum-member-feat
>> >  a member feature
>> > -    section=3DPlain
>> > +    section=3DDetails
>> >  @two is undocumented
>>
>> The section containing "@two is undocumented" changes from PLAIN to
>> DETAILS.  Doc source:
>>
>>     ##
>>     # @Enum:
>>     #
>>     # @one: The _one_ {and only}, description on the same line
>>     #
>>     # Features:
>>     # @enum-feat: Also _one_ {and only}
>>     # @enum-member-feat: a member feature
>>     #
>>     # @two is undocumented
>>     ##
>>
>> It is at the end.  Good.
>>
>> >  doc symbol=3DBase
>> >      body=3D
>> > @@ -175,7 +175,7 @@ description starts on the same line
>> >  a feature
>> >      feature=3Dcmd-feat2
>> >  another feature
>> > -    section=3DPlain
>> > +    section=3DDetails
>> >  .. note:: @arg3 is undocumented
>>
>> The section containing "@arg3 is undocumented" changes from PLAIN to
>> DETAILS.  Doc source:
>>
>> Doc source:
>>
>>     ##
>>     # @cmd:
>>     #
>>     # @arg1:
>>     #     description starts on a new line,
>>     #     indented
>>     #
>>     # @arg2: description starts on the same line
>>     #     remainder indented differently
>>     #
>>     # Returns: @Object
>>     #
>>     # Errors: some
>>     #
>>     # Features:
>>     # @cmd-feat1: a feature
>>     # @cmd-feat2: another feature
>>     #
>>     # .. note:: @arg3 is undocumented
>>     #
>>     # TODO: frobnicate
>>     #
>>
>> It is *not* at the end.  Is the commit message inaccurate?
>>
>
> Ah. I wasn't considering TODO... Since it is a comment I mentally elided =
it.
>
> What I mean to say is that Details is (will be) essentially the last
> content section that is actually rendered.
>
> In the HTML, it will always be last if present because both TODO and Since
> are actually entirely removed from the flow of the document.

We can handwave these two away, but the issue persists until the next
patch.

Consider this change to the test before the series:

    diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-go=
od.json
    index fac13425b7..4d586b043f 100644
    --- a/tests/qapi-schema/doc-good.json
    +++ b/tests/qapi-schema/doc-good.json
    @@ -169,6 +169,8 @@
     #
     # Returns: @Object
     #
    +# plain in the middle
    +#
     # Errors: some
     #
     # TODO: frobnicate
    diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-goo=
d.out
    index 04a5507264..040e901474 100644
    --- a/tests/qapi-schema/doc-good.out
    +++ b/tests/qapi-schema/doc-good.out
    @@ -179,6 +179,8 @@ another feature
     .. note:: @arg3 is undocumented
         section=3DReturns
     @Object
    +    section=3DPlain
    +plain in the middle
         section=3DErrors
     some
         section=3DTodo

The current patch then acquires another hunk:

    diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-goo=
d.out
    index 04e29e8d50..28abb1d98e 100644
    --- a/tests/qapi-schema/doc-good.out
    +++ b/tests/qapi-schema/doc-good.out
    @@ -179,6 +179,8 @@ another feature
     .. note:: @arg3 is undocumented
         section=3DReturns
     @Object
    +    section=3DDetails
    +plain in the middle
         section=3DErrors
     some
         section=3DTodo

> Though as we both point out, what i write is not technically true here. (=
It
> can currently be an intermediate section AND Since is not the only section
> that may follow it.)

[...]


