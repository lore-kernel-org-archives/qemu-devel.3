Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261E4C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZT5-00016g-WF; Tue, 29 Sep 2026 11:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBZSy-00015x-9a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBZSw-0005ss-K8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790694593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quZAYt2i9xvS66I5QKTPdQqQ/WTXOmecM8lac2UmdtA=;
 b=OY3lPB63YFfNBi5Ye+t/aaAoCaBgOJ9gk3ACTyqpACBYRwq+A3cxGC8OVnveApavnq/M41
 qsR6iqYIrR5v2IH5RCSL+pA92KhcvqD32rD8sPO6oetRG8K8lwLLArh1LHQZj87E48a6oZ
 iP13FUFyA5kNO9A2/P88F30mWagpKFs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-lAmPalVnPz-djnf3sutWMg-1; Tue,
 29 Sep 2026 11:09:41 -0400
X-MC-Unique: lAmPalVnPz-djnf3sutWMg-1
X-Mimecast-MFC-AGG-ID: lAmPalVnPz-djnf3sutWMg_1790694571
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0CB418E68E3; Tue, 29 Sep 2026 15:09:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07E861956042; Tue, 29 Sep 2026 15:09:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92CDA21E6A04; Tue, 29 Sep 2026 17:09:27 +0200 (CEST)
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
Subject: Re: [PATCH 10/14] qapi/parser: add _append() method
In-Reply-To: <CAFn=p-YN-AqL335UF1U1eMDKNm+xFR7e9zVDfANJsMFU7qzkJA@mail.gmail.com>
 (John Snow's message of "Tue, 29 Sep 2026 10:14:51 -0400")
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-11-jsnow@redhat.com>
 <87qzicw5js.fsf@pond.sub.org>
 <CAFn=p-YN-AqL335UF1U1eMDKNm+xFR7e9zVDfANJsMFU7qzkJA@mail.gmail.com>
Date: Tue, 29 Sep 2026 17:09:27 +0200
Message-ID: <87qzicumag.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Tue, Sep 29, 2026, 9:28=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This method is intended to become the sole point of appending new
>> > sections to the section list, prohibiting outside callers from
>> > accessing the list of sections directly.
>> >
>> > A forthcoming commit will actually convert the "all_sections" field to
>> > be a private field to begin enforcing that no outside callers are
>> > manipulating the section list from outside of this class.
>>
>> This suggests you merely add the method now.  Not true, you also put it
>> to use.
>>
>
> Didn't mean to suggest such a thing! I'll try to reword.
>
> I mean only to convey that at this point, this doesn't *quite* become the
> sole access point as intended, due to some transitional code that this
> series is on its way to remove.
>
> I'm trying to justify the partial conversion.
>
>
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/parser.py | 50 ++++++++++++++++++++++++++----------------
>> >  1 file changed, 31 insertions(+), 19 deletions(-)
>> >
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 5fc9c18c81d..0dca1acba4c 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -542,7 +542,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >              if not symbol:
>> >                  raise QAPIParseError(self, "name required after '@'")
>> >              doc =3D QAPIDoc(info, symbol)
>> > -            doc.all_sections.append(QAPIDoc.Section(info, QAPIDoc.Kin=
d.INTRO))
>> > +            doc.new_tagged_section(info, QAPIDoc.Kind.INTRO)
>> >              line =3D self.get_doc_indented(doc)
>> >              no_more_args =3D False
>> >              last_ordered_section =3D QAPIDoc.Kind.INTRO
>> > @@ -772,6 +772,33 @@ def __init__(self, info: QAPISourceInfo, symbol: =
Optional[str] =3D None):
>> >      def has_features(self) -> bool:
>> >          return bool(self._features)
>> >
>> > +    def _append(self, section: 'QAPIDoc.Section') -> None:
>>
>> Maybe name it _append_section()?  We already have append_line()...
>>
>
> Eh, why not, sure.
>
>
>> > +        """
>> > +        Primary internal interface for adding a new section.
>> > +
>> > +        It is intended to become the sole access point for adding new
>> > +        sections to the QAPIDoc section list, but we are currently in
>> > +        a transitional phase where other methods access the section
>> > +        list directly to do insertions of generated sections at
>> > +        targeted points.
>>
>> Yes: ._insert_near_kind().
>>
>> > +        """
>>
>> This comment will soon change to
>>
>>            """
>>            Primary internal interface for adding a new section.
>>
>>            All other methods/helpers/etc ultimately use this and only
>>            this interface for appending a new section.
>>            """
>>
>> There's a bit of redundancy.  Suggest
>>
>>            """
>>            Add a new section at the end.
>>
>>            It is intended to ...
>>            """
>>
>> now, and
>>
>>            """
>>            Add a new section at the end.
>>
>>            All other ...
>>            """
>>
>> later.
>>
>
> More or less correct, though "at the end" isn't really true, it's
> contextually sensitive.
>
> "Add a new section" is more correct.
>
> Actually, why don't we name it _add_section() to make it clear that it
> isn't *always* an append?

Sold!

[...]


