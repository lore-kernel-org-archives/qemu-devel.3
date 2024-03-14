Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3659C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklhk-0002lb-Hn; Thu, 14 Mar 2024 10:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rklhe-0002kY-Tp
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rklhQ-0005X0-3W
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710425085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fW6M+5E8MB2Ofv2mj9SNf5wVJOZ2LRjlzOF88DfynvU=;
 b=VfmtlcqhjBpahfjNQWUCk0Hp7GPTxqdbsNTLvhL9aMzTLugM0hTZByK2FLslw5XqPz0N9g
 brpy5iM84zO4Ze9bLjFfqsGQ5J1RNKaNXQKyAfY9yREsNe4WQeAW5LNn2LD8/NU/38/vSo
 OkbAp03iVrwy9+ELN/JJJ8GBWb71Vi0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-fkXcD8tRMzWdZy5E0kzkdg-1; Thu, 14 Mar 2024 10:04:41 -0400
X-MC-Unique: fkXcD8tRMzWdZy5E0kzkdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DD68800268;
 Thu, 14 Mar 2024 14:04:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1A0E3C23;
 Thu, 14 Mar 2024 14:04:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C514A21E6A24; Thu, 14 Mar 2024 15:04:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v4 05/23] qapi: create QAPISchemaDefinition
In-Reply-To: <CAFn=p-bZdrG=MiGpP6jUNqwUfV1RW9aD4Ps+7WKKkCfrshm5rQ@mail.gmail.com>
 (John Snow's message of "Thu, 14 Mar 2024 09:32:52 -0400")
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-6-jsnow@redhat.com>
 <87o7bh9nyt.fsf@pond.sub.org>
 <CAFn=p-bZdrG=MiGpP6jUNqwUfV1RW9aD4Ps+7WKKkCfrshm5rQ@mail.gmail.com>
Date: Thu, 14 Mar 2024 15:04:39 +0100
Message-ID: <87il1o9afc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Mar 14, 2024, 5:12=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Include entities don't have names, but we generally expect "entities" =
to
>> > have names. Reclassify all entities with names as *definitions*, leavi=
ng
>> > the nameless include entities as QAPISchemaEntity instances.
>> >
>> > This is primarily to help simplify typing around expectations of what
>> > callers expect for properties of an "entity".
>> >
>> > Suggested-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/schema.py | 144 +++++++++++++++++++++++------------------
>> >  1 file changed, 82 insertions(+), 62 deletions(-)
>> >
>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index 117f0f78f0c..da273c1649d 100644
>> > --- a/scripts/qapi/schema.py
>> > +++ b/scripts/qapi/schema.py
>>
>> [...]
>>
>> > @@ -107,6 +90,46 @@ def _set_module(self, schema, info):
>> >      def set_module(self, schema):
>> >          self._set_module(schema, self.info)
>> >
>> > +    def visit(self, visitor):
>> > +        # pylint: disable=3Dunused-argument
>> > +        assert self._checked
>> > +
>> > +
>> > +class QAPISchemaDefinition(QAPISchemaEntity):
>> > +    meta: Optional[str] =3D None
>> > +
>> > +    def __init__(self, name: str, info, doc, ifcond=3DNone, features=
=3DNone):
>> > +        assert isinstance(name, str)
>> > +        super().__init__(info)
>> > +        for f in features or []:
>> > +            assert isinstance(f, QAPISchemaFeature)
>> > +            f.set_defined_in(name)
>> > +        self.name =3D name
>> > +        self.doc =3D doc
>> > +        self._ifcond =3D ifcond or QAPISchemaIfCond()
>> > +        self.features =3D features or []
>> > +
>> > +    def __repr__(self):
>> > +        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
>> > +                                    id(self))
>> > +
>> > +    def c_name(self):
>> > +        return c_name(self.name)
>> > +
>> > +    def check(self, schema):
>> > +        assert not self._checked
>> > +        seen =3D {}
>> > +        for f in self.features:
>> > +            f.check_clash(self.info, seen)
>> > +        super().check(schema)
>>
>> v3 called super().check() first.  Why did you move it?  I'm asking just
>> to make sure I'm not missing something subtle.
>>
>
> I don't believe you are, I think it was just ... something I didn't notice
> when rebasing, since I merged this patch by hand. I recall having to inse=
rt
> the super call manually, and I guess my preferences are nondeterministic.

I'd like to move it back, for consistency with its subtypes' .check(),
which all call super().check() early.  Okay?

>> > +
>> > +    def connect_doc(self, doc=3DNone):
>> > +        super().connect_doc(doc)
>> > +        doc =3D doc or self.doc
>> > +        if doc:
>> > +            for f in self.features:
>> > +                doc.connect_feature(f)
>> > +
>> >      @property
>> >      def ifcond(self):
>> >          assert self._checked
>>
>> [...]
>>
>>


