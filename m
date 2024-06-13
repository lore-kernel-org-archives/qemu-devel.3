Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62FCC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHliw-00088R-VI; Thu, 13 Jun 2024 10:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHlit-00087f-FU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHlip-0000dh-S6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718289998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXE+sOXjCe4sE8efq8vAJUPysl9fDBmIpsTghyfpsPI=;
 b=SEuEIk02NPWbTE+lb0aiUeYApKaN4LKKR7vHgNt908viTcQK51mdvWRbbzTG7g1xqPxRuk
 xbwoM+uxfvQH/tLpVh3etfgBryjpYiyJD9IeswJ/YcRukqxhprkYY/TQfdt1lNwQ/Jghwe
 aUXFzcFs87xcdsf1sV0kLHpZ8BTmDDo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-EJ6lSRAmO8ShXTGxqDs7jQ-1; Thu,
 13 Jun 2024 10:46:35 -0400
X-MC-Unique: EJ6lSRAmO8ShXTGxqDs7jQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A607A1955DA2; Thu, 13 Jun 2024 14:46:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AAD31944EB2; Thu, 13 Jun 2024 14:45:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F7F421E6682; Thu, 13 Jun 2024 16:45:49 +0200 (CEST)
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
Subject: Re: [PATCH 07/20] qapi/parser: add semantic 'kind' parameter to
 QAPIDoc.Section
In-Reply-To: <CAFn=p-YiwRnbTeghGA5GMAuP3JNUmvFxqamLrzkTgj_mss5UNg@mail.gmail.com>
 (John Snow's message of "Thu, 16 May 2024 10:46:15 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-8-jsnow@redhat.com>
 <87wmnunuu5.fsf@pond.sub.org>
 <CAFn=p-YiwRnbTeghGA5GMAuP3JNUmvFxqamLrzkTgj_mss5UNg@mail.gmail.com>
Date: Thu, 13 Jun 2024 16:45:49 +0200
Message-ID: <87y1789a02.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

> On Thu, May 16, 2024, 2:18=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > When iterating all_sections, this is helpful to be able to distinguish
>> > "members" from "features"; the only other way to do so is to
>> > cross-reference these sections against QAPIDoc.args or QAPIDoc.feature=
s,
>> > but if the desired end goal for QAPIDoc is to remove everything except
>> > all_sections, we need *something* accessible to distinguish them.
>> >
>> > To keep types simple, add this semantic parameter to the base Section
>> > and not just ArgSection; we can use this to filter out paragraphs and
>> > tagged sections, too.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/parser.py | 25 ++++++++++++++++---------
>> >  1 file changed, 16 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 161768b8b96..cf4cbca1c1f 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -613,21 +613,27 @@ class QAPIDoc:
>> >
>> >      class Section:
>> >          # pylint: disable=3Dtoo-few-public-methods
>> > -        def __init__(self, info: QAPISourceInfo,
>> > -                     tag: Optional[str] =3D None):
>> > +        def __init__(
>> > +            self,
>> > +            info: QAPISourceInfo,
>> > +            tag: Optional[str] =3D None,
>> > +            kind: str =3D 'paragraph',
>> > +        ):
>> >              # section source info, i.e. where it begins
>> >              self.info =3D info
>> >              # section tag, if any ('Returns', '@name', ...)
>> >              self.tag =3D tag
>> >              # section text without tag
>> >              self.text =3D ''
>> > +            # section type - {paragraph, feature, member, tagged}
>> > +            self.kind =3D kind
>>
>> Hmm.  .kind is almost redundant with .tag.
>>
>
> Almost, yes. But the crucial bit is members/features as you notice. That's
> the real necessity here that saves a lot of code when relying on *only*
> all_sections.
>
> (If you want to remove the other fields leaving only all_sections behind,
> this is strictly necessary.)
>
>
>> Untagged section:    .kind is 'paragraph', .tag is None
>>
>> Member description:  .kind is 'member', .tag matches @NAME
>>
>> Feature description: .kind is 'feature', .tag matches @NAME
>
>
>> Tagged section:      .kind is 'tagged', .tag matches
>>                           r'Returns|Errors|Since|Notes?|Examples?|TODO'
>>
>> .kind can directly be derived from .tag except for member and feature
>> descriptions.  And you want to tell these two apart in a straightforward
>> manner in later patches, as you explain in your commit message.
>>
>> If .kind is 'member' or 'feature', then self must be an ArgSection.
>> Worth a comment?  An assertion?
>>
>
> No real need. The classes don't differ much in practice so there's not mu=
ch
> benefit, and asserting it won't help the static typer out anyway because =
it
> can't remember the inference from string->type anyway.
>
> If you wanted to be FANCY, we could use string literal typing on the field
> and restrict valid values per-class, but that's so needless not even I'm
> tempted by it.
>
>
>> Some time back, I considered changing .tag for member and feature
>> descriptions to suitable strings, like your 'member' and 'feature', and
>> move the member / feature name into ArgSection.  I didn't, because the
>> benefit wasn't worth the churn at the time.  Perhaps it's worth it now.
>> Would it result in simpler code than your solution?
>>
>
> Not considerably, I think. Would just be shuffling around which field nam=
es
> I touch and where/when.

The way .tag works irks me.  I might explore the change I proposed just
to see whether I hate the result less.  On top of your work, to not
annoy you without need.

> It might actually just add some lines where I have to assert isinstance to
> do type narrowing in the generator.
>
>> Terminology nit: the section you call 'paragraph' isn't actually a
>> paragraph: it could be several paragraphs.  Best to call it 'untagged',
>> as in .ensure_untagged_section().
>>
>
> Oh, I hate when you make a good point. I was avoiding the term because I'm
> removing Notes and Examples, and we have plans to eliminate Since ... the
> tagged sections are almost going away entirely, leaving just TODO, which =
we
> ignore.
>
> Uhm, can I name it paragraphs? :) or open to other suggestions, incl.
> untagged if that's still your preference.

'untagged' is more consistent with existing names and comments:
.ensure_untagged_section(), "additional (non-argument) sections,
possibly tagged", ...

When all tags but 'TODO' are gone, the concept "tagged vs. untagged
section" ceases to make sense, I guess.  We can tweak the names and
comments accordingly then.

>
>> >
>> >          def append_line(self, line: str) -> None:
>> >              self.text +=3D line + '\n'
>> >
>> >      class ArgSection(Section):
>> > -        def __init__(self, info: QAPISourceInfo, tag: str):
>> > -            super().__init__(info, tag)
>> > +        def __init__(self, info: QAPISourceInfo, tag: str, kind: str):
>> > +            super().__init__(info, tag, kind)
>> >              self.member: Optional['QAPISchemaMember'] =3D None
>> >
>> >          def connect(self, member: 'QAPISchemaMember') -> None:
>>
>> [...]
>>
>>


