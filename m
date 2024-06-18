Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D00C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJX5Q-0001YS-5P; Tue, 18 Jun 2024 07:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJX5J-0001Xi-5z
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJX5H-0000lF-AE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718710386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqBUnVwDi1Ytkc9nZ+8UC7nHlC1l06ln4Wn3LWka7q8=;
 b=IsWSXZrKOVdgktmz3hwFNfKMZFRHxyLpCICHAZV7577QAsCAspxEEl0lTKJd04+B7TZki1
 nWlmVd9oEd+iv59c7G11wd12tep8DTPs2Ur0YyMwYDR24J1jGH9MDUoR9rGi2Go6m95NLM
 6NOG7vKsbyjNO3jARBb9pWs1jELMTkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-zUyAOnxtOzyf2F9VmXwEhw-1; Tue,
 18 Jun 2024 07:33:03 -0400
X-MC-Unique: zUyAOnxtOzyf2F9VmXwEhw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72EC119560AB; Tue, 18 Jun 2024 11:32:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C85019560AF; Tue, 18 Jun 2024 11:32:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BCF021E6621; Tue, 18 Jun 2024 13:32:56 +0200 (CEST)
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
Subject: Re: [PATCH 09/20] qapi/parser: add undocumented stub members to
 all_sections
In-Reply-To: <CAFn=p-YTa=z5Y5p+S+MN__kEuxf_H36K+=QPNNBdh6wEaZBrkw@mail.gmail.com>
 (John Snow's message of "Mon, 17 Jun 2024 12:54:26 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-10-jsnow@redhat.com>
 <87tthv52ja.fsf@pond.sub.org>
 <CAFn=p-YTa=z5Y5p+S+MN__kEuxf_H36K+=QPNNBdh6wEaZBrkw@mail.gmail.com>
Date: Tue, 18 Jun 2024 13:32:56 +0200
Message-ID: <87msni7afr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> On Fri, Jun 14, 2024 at 4:53=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This helps simplify the doc generator if it doesn't have to check for
>> > undocumented members.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/parser.py | 20 ++++++++++++++++++--
>> >  1 file changed, 18 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index b1794f71e12..3cd8e7ee295 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -740,8 +740,24 @@ def connect_member(self, member: 'QAPISchemaMembe=
r') -> None:
>> >                  raise QAPISemError(member.info,
>> >                                     "%s '%s' lacks documentation"
>> >                                     % (member.role, member.name))
>> > -            self.args[member.name] =3D QAPIDoc.ArgSection(
>> > -                self.info, '@' + member.name, 'member')
>> > +
>> > +            # Insert stub documentation section for missing member do=
cs.
>> > +            section =3D QAPIDoc.ArgSection(
>> > +                self.info, f"@{member.name}", "member")
>>
>> Although I like f-strings in general, I'd pefer to stick to '@' +
>> member.name here, because it's simpler.
>
> Tomayto, Tomahto. (OK.)

Apropos healthy vegetables: at some time, we might want to mass-convert
to f-strings where they are easier to read.

>> Also, let's not change 'member' to "member".  Existing practice: single
>> quotes for string literals unless double quotes avoid escapes.  Except
>> English prose (like error messages) is always in double quotes.
>>
>
> OK. I realize I'm not consistent in this patch either, but I'll explain
> that my using double quotes here is a black-ism that is sneaking in the
> more I use it to auto-format my patches :)
>
> Maybe time for a flag day when I move scripts/qapi to python/qemu/qapi ...
>
> (Sorry, this type of stuff is ... invisible to me, and I really do rely on
> the linters to make sure I don't do this kind of thing.)
>
>
>>
>> > +            self.args[member.name] =3D section
>> > +
>> > +            # Determine where to insert stub doc.
>>
>> If we have some member documentation, the member doc stubs clearly must
>> go there.  Inserting them at the end makes sense.
>>
>> Else we want to put them where the parser would accept real member
>> documentation.
>>
>> "The parser" is .get_doc().  This is what it accepts (I'm prepared to
>> explain this in detail if necessary):
>>
>>     One untagged section
>>
>>     Member documentation, if any
>>
>>     Zero ore more tagged or untagged sections
>>
>>     Feature documentation, if any
>>
>>     Zero or more tagged or untagged sections
>>
>> If we there is no member documentation, this is
>>
>>     One untagged section
>>
>>     Zero ore more tagged or untagged sections
>>
>>     Feature documentation, if any
>>
>>     Zero or more tagged or untagged sections
>>
>> Note that we cannot have two adjacent untagged sections (we only create
>> one if the current section isn't untagged; if it is, we extend it
>> instead).  Thus, the second section must be tagged or feature
>> documentation.
>>
>> Therefore, the member doc stubs must go right after the first section.
>>
>> This is also where qapidoc.py inserts member documentation.
>>
>> > +            index =3D 0
>> > +            for i, sect in enumerate(self.all_sections):
>> > +                # insert after these:
>> > +                if sect.kind in ('intro-paragraph', 'member'):
>> > +                    index =3D i + 1
>> > +                # but before these:
>> > +                elif sect.kind in ('tagged', 'feature', 'outro-paragr=
aph'):
>> > +                    index =3D i
>> > +                    break
>>
>> Can you describe what this does in English?  As a specification; simply
>> paraphrasing the code is cheating.  I tried, and gave up.
>>
>
> It inserts after any intro-paragraph or member section it finds, but befo=
re
> any tagged, feature, or outro-paragraph it finds.
>
> The loop breaks on the very first instance of tagged/feature/outro, exiti=
ng
> immediately and leaving the insertion index set to the first occurrence of
> such a section, so that the insertion will place the member documentation
> prior to that section.
>
> The loop doesn't break when it finds intro-paragraph or members, so it'll
> continue to tick upwards until it reaches the end of the list or it finds
> something disqualifying.
>
>
>>
>> Above, I derived what I believe we need to do.  It's simple enough: if
>> we have member documentation, it starts right after the first (untagged)
>> section, and the stub goes to the end of the member documentation.
>> Else, the stub goes right after the first section.
>>
>> Code:
>>
>>             index =3D 1;
>>             while self.all_sections[index].kind =3D=3D 'member':
>>                 index +=3D 1
>>
>
> Wellp, yeah. That's certainly less code :)
>
> I tossed in your algorithm alongside mine and asserted they were always
> equal, and they are, so... yup. I think the only possible concern here is
> if there is precisely one and only one section and 1 is beyond EOL, but
> that's easy to fix. It apparently doesn't happen in practice, but I can't
> presently imagine why it *couldn't* happen.
>
> I'll just write a comment explaining the assumptions that make your algo
> work (intro section always guaranteed even if empty; intro sections always
> collapse into one section, members must start at i:=3D1 if they exist at =
all,
> members must be contiguous.)

You could assert the first section exists and is untagged.  And maybe
assert if we have members, the first is at index 1.

>> Of course future patches I haven't seen might change the invariants in
>> ways that break my simple code.  We'll see.
>>
>> > +            self.all_sections.insert(index, section)
>> > +
>> >          self.args[member.name].connect(member)
>> >
>> >      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
>>
>>
> Now, for a critique of my own patch: this patch makes it difficult to aud=
it
> all of the cases where intro vs outro paragraphs sections may be ambiguous
> because we automatically add members sections, so the warning yap I add
> later on catches less cases.
>
> It's possible we may want to add a warning yap about paragraph ambiguity
> directly to the parser, OR just decide we don't really care and we just
> *assume* and that it's fine.
>
> We can discuss this pointedly on a call next time, and I'll come prepared
> with examples and line numbers.... Or, if you'd prefer, you can get a
> written report so you can take your time reading in silence.

Let's try whatever feels easier for you first.


