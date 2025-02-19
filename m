Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B81AC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeyy-000264-ND; Wed, 19 Feb 2025 02:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkeyw-00025d-Eb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkeyt-0001nh-Sk
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739951933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cyj4W70b/Kr3RQ1RHJQDi5q+XKGs/Og7rBCPxs5Z1E=;
 b=AYX7fD2uZobJIBXXrmUSi6OuHTsoPZhLuBMYELt68X9byDY1fxS8HSkSLmReooZ59YENXv
 0CkBL11Xu898Mm3volaomXT6h3MtGCfeSZQy7nibODfRVA1DVemqh8YPPkr1NVmn3QvMq4
 NyZwllKtpPpEbQ0j7C46IrP+ySht4uw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-6-w0KWFoONixg9_jtCjgZw-1; Wed,
 19 Feb 2025 02:58:49 -0500
X-MC-Unique: 6-w0KWFoONixg9_jtCjgZw-1
X-Mimecast-MFC-AGG-ID: 6-w0KWFoONixg9_jtCjgZw_1739951928
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBCE31800570; Wed, 19 Feb 2025 07:58:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 046D619412A3; Wed, 19 Feb 2025 07:58:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84FD221E6A28; Wed, 19 Feb 2025 08:58:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 28/42] qapi/parser: prohibit untagged sections between
 tagged sections
In-Reply-To: <CAFn=p-YNBAD66dMScLCrAAAbaJ=KJ8_h-iJJ4BEKVb99DrEogw@mail.gmail.com>
 (John Snow's message of "Tue, 18 Feb 2025 16:36:46 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-29-jsnow@redhat.com>
 <87ed03r0qc.fsf@pond.sub.org>
 <CAFn=p-YNBAD66dMScLCrAAAbaJ=KJ8_h-iJJ4BEKVb99DrEogw@mail.gmail.com>
Date: Wed, 19 Feb 2025 08:58:43 +0100
Message-ID: <87tt8q74cs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> On Wed, Feb 12, 2025 at 4:06=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This is being done primarily to ensure consistency between the source
>> > documents and the final, rendered HTML output. Because
>> > member/feature/returns sections will always appear in a visually group=
ed
>> > element in the HTML output, prohibiting free paragraphs between those
>> > sections ensures ordering consistency between source and the final
>> > render.
>> >
>> > Additionally, prohibiting such "middle" text paragraphs allows us to
>> > classify all plain text sections as either "intro" or "detail"
>> > sections, because these sections must either appear before structured
>> > elements ("intro") or afterwards ("detail").
>> >
>> > This keeps the inlining algorithm simpler with fewer "splice" points
>> > when inlining multiple documentation blocks.
>>
>> Mention the two "middle" paragraphs you have to eliminate in this patch?
>>
>
> OK; I will mention that this patch adjusts the source documentation but I
> won't go into detail on which. You can read the patch to find out easily
> enough.
>
>
>>
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/net.json                   |  4 ++--
>> >  qapi/qom.json                   |  4 ++--
>> >  scripts/qapi/parser.py          | 16 ++++++++++++++++
>> >  tests/qapi-schema/doc-good.json |  4 ++--
>> >  tests/qapi-schema/doc-good.out  |  4 ++--
>> >  tests/qapi-schema/doc-good.txt  |  8 ++++----
>> >  6 files changed, 28 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/qapi/net.json b/qapi/net.json
>> > index 2739a2f4233..49bc7de64e9 100644
>> > --- a/qapi/net.json
>> > +++ b/qapi/net.json
>> > @@ -655,13 +655,13 @@
>> >  #     this to zero disables this function.  This member is mutually
>> >  #     exclusive with @reconnect.  (default: 0) (Since: 9.2)
>> >  #
>> > -# Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
>> > -#
>> >  # Features:
>> >  #
>> >  # @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
>> >  #     instead.
>> >  #
>> > +# Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
>> > +#
>> >  # Since: 7.2
>> >  ##
>> >  { 'struct': 'NetdevStreamOptions',
>>
>> The text moved applies to member @addr.  You're moving it even farther
>> away from @addr.  Move it into @addr instead?  Could be done as a
>> separate cleanup patch to keep this one as simple as possible; matter of
>> taste.
>>
>
> Mmm, I was doing a mechanical hacksaw job here, admittedly. I can do a mo=
re
> tactful adjustment. I think it should be in this patch in order to preser=
ve
> the context of precisely *why* it was juggled around, because I admit in
> this one case it is a slight downgrade.
>
> Moving it into @addr.
>
>
>>
>> The same text is in NetdevDgramOptions below, where it applies to both
>> @remote and @local.  It just happens to follow @remote and @local
>> immediately, because there are no other members and no features.  Hmm.
>>
>> Ideally, we'd have a way to put such notes next to the stuff they apply
>> to without having to rely on happy accidents like "no features".
>> Alternatively, have a way to link stuff and note.  Footnotes?  Food for
>> thought, not demand.
>>
>
> Yes, we discussed this at KVM Forum and I was dreaming of some complicated
> solution like "section-details: " or something that allows us to add
> amendments to documentation regions that aren't associated with any one
> particular member or feature, but can be inserted visually at that point.
>
> I know it's a capability you'd like to preserve, but I think we only use =
it
> once, so I'd be happy to push this off until a bit later and just suffer
> the indignity of slightly suboptimal documentation in one spot until then
> in exchange for the massive upgrade everywhere else.

If minor degradations are the price of major improvement, we pay.

> What would help a good deal is if you could brainstorm some source syntax
> that you think would be pleasant for the purpose, and then for my end I c=
an
> worry about how to munge the docutils tree and HTML renderer to make it
> happen in some pleasing way.

Can we make do with just ReST?  Footnotes?  Best if we can control their
placement somehow.

> For now... "Figure out how to add notes or footnotes to the members secti=
on
> as a whole" added to the "for later" part of my tasklist?

Yes, please, with the understanding that this is *not* a blocker for
getting the new doc generator accepted.

>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 28ce24cd8d0..11277d1f84c 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -195,12 +195,12 @@
>> >  #
>> >  # @typename: the type name of an object
>> >  #
>> > +# Returns: a list of ObjectPropertyInfo describing object properties
>> > +#
>> >  # .. note:: Objects can create properties at runtime, for example to
>> >  #    describe links between different devices and/or objects.  These
>> >  #    properties are not included in the output of this command.
>> >  #
>> > -# Returns: a list of ObjectPropertyInfo describing object properties
>> > -#
>> >  # Since: 2.12
>> >  ##
>>
>> This move is fine.  Placing notes at the end is more common already.
>>
>> >  { 'command': 'qom-list-properties',
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index b2f77ffdd7a..c5d2b950a82 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -500,6 +500,20 @@ def get_doc(self) -> 'QAPIDoc':
>> >              self.accept(False)
>> >              line =3D self.get_doc_line()
>> >              have_tagged =3D False
>> > +            no_more_tags =3D False
>> > +
>> > +            def _tag_check(what: str) -> None:
>> > +                if what in ('TODO', 'Since'):
>> > +                    return
>> > +
>> > +                if no_more_tags:
>> > +                    raise QAPIParseError(
>> > +                        self,
>> > +                        f"{what!r} section cannot appear after free "
>> > +                        "paragraphs that follow other tagged sections=
. "
>> > +                        "Move this section upwards with the preceding=
 "
>> > +                        "tagged sections."
>> > +                    )
>>
>> Why !r conversion?
>>
>
> It just adds quotes so it'll print like: "Returns" section cannot appear
> after ...
> I thought it looked nicer codewise than: f'"{what}" section cannot appear
> after ...'

Prior art:

                raise QAPISemError(
                    info, "duplicated '%s' section" % kind)

                raise QAPISemError(
                    self.returns.info,
                    "'Returns' section, but command doesn't return anything=
")

                raise QAPISemError(
                    self.returns.info,
                    "'Returns' section is only valid for commands")

                raise QAPISemError(
                    self.errors.info,
                    "'Errors' section is only valid for commands")

Let's stick to this style.

>> Error messages should be a single, short phrase, no punctuation at the
>> end.  Sometimes a helpful hint is desirable.  Here's one in expr.py:
>>
>
>>         raise QAPISemError(
>>             info,
>>             "%s has unknown key%s %s\nValid keys are %s."
>>             % (source, 's' if len(unknown) > 1 else '',
>>                pprint(unknown), pprint(allowed)))
>>
>
> Cold day in hell when I successfully remember to omit the punctuation. Wi=
ll
> rephrase and fix.

:)

>> Needs a negative test case.
>>
>
> Yes, I didn't add any new tests because I was being lazy and wanted to see
> which things you'd toss out before I had to write them. No reason to do a=
ll
> that work in advance of review. Please ask for tests wherever you feel th=
ey
> are required and I'll add them. In this case, I knew you had some qualms
> about this patch, so I was hesitant ...

Good strategy.  I'd appreciate notes on known gaps in the commit message
and/or the cover letter, though.  Don't go out of your way to find gaps,
just make a reasonable effort to write down the ones you already know.

>> Aside: we should probably convert most string interpolation to f-strings
>> en masse at some point.
>>
>
> Yeah, just putting it off because the review for that sounds like a hassle
> ;)
> I can do a mechanical conversion to get you started and then let you
> finesse it if you want?
> We can share the pain.
>
> If you really wanna have a flag day about it, we can just run the black
> formatter on everything and get it all over with at once...
>
> later stuff, to be clear.

Yes, all of it.

>> >
>> >              while line is not None:
>> >                  # Blank lines
>> > @@ -513,6 +527,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                      if doc.features:
>> >                          raise QAPIParseError(
>> >                              self, "duplicated 'Features:' line")
>> > +                    _tag_check("Features")
>> >                      self.accept(False)
>> >                      line =3D self.get_doc_line()
>> >                      while line =3D=3D '':
>> > @@ -576,6 +591,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                          )
>> >                          raise QAPIParseError(self, emsg)
>> >
>> > +                    _tag_check(match.group(1))
>> >                      doc.new_tagged_section(
>> >                          self.info,
>> >                          QAPIDoc.Kind.from_string(match.group(1))
>> > diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-g=
ood.json
>> > index f64bf38d854..14b2091b08f 100644
>> > --- a/tests/qapi-schema/doc-good.json
>> > +++ b/tests/qapi-schema/doc-good.json
>> > @@ -157,12 +157,12 @@
>> >  # @cmd-feat1: a feature
>> >  # @cmd-feat2: another feature
>> >  #
>> > -# .. note:: @arg3 is undocumented
>> > -#
>> >  # Returns: @Object
>> >  #
>> >  # Errors: some
>> >  #
>> > +# .. note:: @arg3 is undocumented
>> > +#
>>
>> This used to be right next to @arg1 and arg2 (commit 80d1f2e4a5d) until
>> commit 79598c8a634 added features in between.  This patch adds more
>> stuff there.  Right next is clearly the best spot, but this is just a
>> test, so it doesn't really matter.  Related: NetdevDgramOptions' note
>> discussed above.
>>
>
> So long as it doesn't disturb the point of what is being tested. It's not
> always directly clear when adjusting the good doc what precisely is being
> tested.

True.

>> >  # TODO: frobnicate
>> >  #
>> >  # .. admonition:: Notes
>>
>> [...]
>>
>>


