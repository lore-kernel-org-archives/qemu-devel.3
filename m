Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45D2CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZKB-0004rJ-Q1; Tue, 29 Sep 2026 11:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBZK0-0004lW-FF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBZJy-00052G-Lp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790694040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imk8CsUFuatBckDywQe+HSBOt51xD6uedwE+4ppvWwc=;
 b=YMwWc1OapK56x+l2xWnqRsnPz2uhw0QSfY9YdtJ7aBcGg/C4RZXWeFsRPfPguX+DWzm5Ko
 fa47vMr8DVGdCzjvdpBKhpAVVMg+5+q3dp1H9gJ94Rd0WZBuUOx25WbhJoCpoRW5CAucWN
 obv155AKmUh2j4yIOjfdCp0+mECVGas=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-d4uZC5m4NtWJrzKC4_aJpw-1; Tue,
 29 Sep 2026 11:00:37 -0400
X-MC-Unique: d4uZC5m4NtWJrzKC4_aJpw-1
X-Mimecast-MFC-AGG-ID: d4uZC5m4NtWJrzKC4_aJpw_1790694035
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEFFD1944B13; Tue, 29 Sep 2026 15:00:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25A00768; Tue, 29 Sep 2026 15:00:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4F6D21E6A04; Tue, 29 Sep 2026 17:00:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Xu <peterx@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Hanna
 Reitz <hreitz@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Kevin Wolf <kwolf@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Jiri Pirko <jiri@resnulli.us>,  Alex
 Williamson <alex@shazbot.org>,  Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Kostiantyn Kostiuk
 <kkostiuk@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Michael Roth
 <michael.roth@amd.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Jason Wang <jasowangio@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 04/14] qapi/parser: enforce doc block section ordering
In-Reply-To: <CAFn=p-ZCq09nrc=O7jCay9JJ9c9eopMzQmDqHcdS8j=kWtVa_w@mail.gmail.com>
 (John Snow's message of "Tue, 29 Sep 2026 10:31:42 -0400")
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-5-jsnow@redhat.com>
 <87bj9gxmiw.fsf@pond.sub.org>
 <CAFn=p-ZCq09nrc=O7jCay9JJ9c9eopMzQmDqHcdS8j=kWtVa_w@mail.gmail.com>
Date: Tue, 29 Sep 2026 17:00:29 +0200
Message-ID: <874if8w19u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Tue, Sep 29, 2026, 8:36=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Enforce the relative ordering of "Intro", "Members", "Features",
>> > "Errors" and "Returns" sections.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/devel/qapi-code-gen.rst | 19 +++++++++++------
>> >  scripts/qapi/parser.py       | 41 ++++++++++++++++++++++++++++++------
>> >  2 files changed, 48 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st
>> > index 3ac1c2dae18..29e9c5a3da6 100644
>> > --- a/docs/devel/qapi-code-gen.rst
>> > +++ b/docs/devel/qapi-code-gen.rst
>> > @@ -985,12 +985,19 @@ When documentation is required (see pragma_
>> 'doc-required'), every
>> >  definition must have documentation.
>> >
>> >  Definition documentation starts with a description naming the
>> > -definition with an optional indented overview (the "intro"),
>> > -:ref:`descriptions <doc-descrip>` of each argument (for commands and
>> > -events), member (for structs and unions), branch (for alternates), or
>> > -value (for enums), :ref:`feature descriptions <doc-feat>` of each
>> > -feature (if any), and finally optional :ref:`tagged sections
>> > -<doc-tagged>`.
>> > +definition with an optional indented overview (the "intro").
>> > +
>> > +The introduction is followed by :ref:`descriptions <doc-descrip>` of
>> > +each argument (for commands and events), member (for structs and
>> > +unions), branch (for alternates), or value (for enums).
>> > +
>> > +:ref:`Tagged sections <doc-tagged>` follow in order: Returns (for
>> > +commands), Errors (for commands), and lastly :ref:`feature
>> > +descriptions <doc-feat>` if applicable.
>>
>> *Some* of the tagged sections do.
>>
>> Does this document still need the concept "tagged section"?
>>
>
> I doubt it does, beyond an explanation of common syntax. Happy to hear
> suggestions...

I'll keep it in mind when I review PATCH 02.

> We could also stand to change some of the method names like "ensure
> untagged section" could become "ensure details", and the like.

Fair!

> tagged vs untagged has become increasingly non-meaningful.

True.

>> > +
>> > +Definition documentation concludes with rST-formatted detail
>> > +paragraphs (including examples, notes, &c), and finally an optional
>> > +"Since" tagged section at the very end.
>> >
>> >  .. _doc-descrip:
>> >
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index fe284a3f866..94a60a23482 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -545,6 +545,28 @@ def get_doc(self) -> 'QAPIDoc':
>> >              doc.all_sections.append(QAPIDoc.Section(info,
>> QAPIDoc.Kind.INTRO))
>> >              line =3D self.get_doc_indented(doc)
>> >              no_more_args =3D False
>> > +            last_ordered_section =3D QAPIDoc.Kind.INTRO
>> > +
>> > +            def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
>> > +                nonlocal last_ordered_section
>> > +                if isinstance(this, str):
>> > +                    this =3D QAPIDoc.Kind.from_string(this)
>>
>> Simpler, I think: require a .Kind argument, and do the conversion from
>> string in the one caller that needs it.
>>
>
> You're right.
>
>
>> > +
>> > +                if this in (QAPIDoc.Kind.TODO, QAPIDoc.Kind.SINCE,
>> > +                            QAPIDoc.Kind.DETAILS):
>> > +                    return
>> > +
>> > +                if this.value < last_ordered_section.value:
>> > +                    raise QAPIParseError(
>> > +                        self,
>> > +                        f"'{this}' section cannot appear after "
>> > +                        f"'{last_ordered_section}' section, please
>> re-order "
>> > +                        "the sections and adjust phrasing as necessary
>> to "
>> > +                        "ensure consistent documentation flow between
>> the "
>> > +                        "source code and the rendered HTML manual"
>> > +                    )
>>
>> That's a loooong error message.  It actually consists of the error
>> proper and advice on how to correct it.  Please use
>>
>>     "<error>\n<advice>"
>>
>> like we do in expr.py's check_keys(), parser.py's
>> ._validate_doc_line_format(), and schema.py's ._def_definition().  Yes,
>> the embedded newline is a bit of a hack.
>>
>
> ACK.
>
>
>> > +
>> > +                last_ordered_section =3D this
>> >
>> >              while line is not None:
>> >                  # Blank lines
>> > @@ -558,6 +580,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                      if doc.has_features:
>> >                          raise QAPIParseError(
>> >                              self, "duplicated 'Features:' line")
>> > +                    _tag_check(QAPIDoc.Kind.FEATURE)
>> >                      self.accept(False)
>> >                      line =3D self.get_doc_line()
>> >                      while line =3D=3D '':
>> > @@ -581,6 +604,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                              self,
>> >                              "description of '@%s:' follows a section"
>> >                              % match.group(1))
>> > +                    _tag_check(QAPIDoc.Kind.MEMBER)
>> >                      while (line is not None
>> >                             and (match :=3D
>> self._match_at_name_colon(line))):
>> >                          doc.new_argument(self.info, match.group(1))
>> > @@ -621,6 +645,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                          )
>> >                          raise QAPIParseError(self, emsg)
>> >
>> > +                    _tag_check(match.group(1))
>>
>> This is the caller that needs it.
>>
>
> Yep.
>
>
>> >                      doc.new_tagged_section(
>> >                          self.info,
>> >                          QAPIDoc.Kind.from_string(match.group(1))
>> > @@ -632,6 +657,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                      no_more_args =3D True
>> >                  else:
>> >                      # plain paragraph(s)
>> > +                    _tag_check(QAPIDoc.Kind.DETAILS)
>> >                      doc.ensure_untagged_section(self.info)
>> >                      doc.append_line(line)
>> >                      line =3D self.get_doc_paragraph(doc)
>> > @@ -674,14 +700,17 @@ class QAPIDoc:
>> >      """
>> >
>> >      class Kind(enum.Enum):
>> > -        DETAILS =3D 0
>> > +        # The order here is the order in which sections must appear in
>> > +        # source code; with the exception of 'TODO' which may appear
>> > +        # anywhere but is treated as a comment.
>> > +        INTRO =3D 0
>> >          MEMBER =3D 1
>> > -        FEATURE =3D 2
>> > -        RETURNS =3D 3
>> > -        ERRORS =3D 4
>> > -        SINCE =3D 5
>> > +        RETURNS =3D 2
>> > +        ERRORS =3D 3
>> > +        FEATURE =3D 4
>> > +        DETAILS =3D 5
>> >          TODO =3D 6
>> > -        INTRO =3D 7
>> > +        SINCE =3D 7
>> >
>> >          @staticmethod
>> >          def from_string(kind: str) -> 'QAPIDoc.Kind':
>>
>> Missing: negative test for the new error.
>>
>
> Yep. If you are overall pleased with this change enough (pending nits),
> I'll add the tests now.

I am!


