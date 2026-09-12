Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428DAC88E45
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 05:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5GXn-0007OY-Qq; Sat, 12 Sep 2026 01:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5GXl-0007OB-SJ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5GXj-0006IW-P3
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789191889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLY6uNo5DJjlnXMb/sLCTJlvKOZItKgW6hFurE+0wHE=;
 b=JkgcgnCs/TCCwh9OgOn9pkEeMJwYceZxrz76KY1rrqg/vQeldEUCXQvJFe82MKujsZT96Q
 csiOisTVjq0Slnhuw8KHx5ZnlxcnYFfHQZx+sj/ZnTUemxnsD0VJ/VeNSy0NPaH0ry5+Y1
 B6elgqD8Rkp2h5OveeZVpBkEkN9CRGM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-BSwq5EIINXK6uM4N5Cd1-w-1; Sat,
 12 Sep 2026 01:44:44 -0400
X-MC-Unique: BSwq5EIINXK6uM4N5Cd1-w-1
X-Mimecast-MFC-AGG-ID: BSwq5EIINXK6uM4N5Cd1-w_1789191883
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC24B195608B; Sat, 12 Sep 2026 05:44:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C3E8195608B; Sat, 12 Sep 2026 05:44:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EBF2721E6A04; Sat, 12 Sep 2026 07:44:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v4 05/75] qapi: add type-infos generator
In-Reply-To: <CAMxuvaxF_W6GAM9aV-ssZuY=QsWtBq+6kcy2PK=--GTDM5_RDQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 11 Sep 2026
 18:50:16 +0400")
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-5-a985f168e938@redhat.com>
 <87o6e453or.fsf@pond.sub.org>
 <CAMxuvaxF_W6GAM9aV-ssZuY=QsWtBq+6kcy2PK=--GTDM5_RDQ@mail.gmail.com>
Date: Sat, 12 Sep 2026 07:44:39 +0200
Message-ID: <87tsnv3tx4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Fri, Sep 11, 2026 at 5:16=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> I'm reviewing just the documentation right now.  I'll look at the
>> remainder later.
>>
>> Documentation updates are commonly at least as hard as generator
>> changes, if not harder.  Please don't be discouraged by my remarks!
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > New QAPISchemaGenTypeInfoVisitor produces per-module
>> > qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
>> > pairing the QAPI type name with its masked introspection name.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  docs/devel/qapi-code-gen.rst | 107 +++++++++++++++++++++++++-
>> >  meson.build                  |   1 +
>> >  scripts/qapi/backend.py      |   2 +
>> >  scripts/qapi/introspect.py   |   2 +-
>> >  scripts/qapi/type_infos.py   | 178 ++++++++++++++++++++++++++++++++++=
+++++++++
>> >  5 files changed, 285 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st
>> > index b1cc5b5f0db1..d176238fc2ef 100644
>> > --- a/docs/devel/qapi-code-gen.rst
>> > +++ b/docs/devel/qapi-code-gen.rst

[...]

>> The final sentence talks about types not reachable from commands or
>> events, and hints at QOM use.  I feel the former is a distraction here.
>> Regarding the latter: we need to say more about QOM introspection than
>> "[types] may also be used by QOM".  Before this series, query-qmp-schema
>> is the only QAPI introspection game in town, and this section explains
>> it.  Afterwards, there's also qom-list, qom-list-properties,
>> qom-list-get.  I fear doing them justice will require some rewriting.
>> Maybe just add a FIXME comment for now?
>
> added

[...]

>> > +
>> > +All user-defined and array types are included in introspection, even =
when
>> > +they are not reachable from a command or event.  Their type info ther=
efore
>> > +always provides the introspection cross-reference.
>>
>> I'm not sure I understand this paragraph.  What are you trying to
>> convey?
>
> I expressed the motivation: type info allows cross-referencing with
> the introspection schema. But I can drop it too.

We can cover this when we document QOM introspection to resolve the
FIXME mentioned above.

>> > +
>> > +Example::
>> > +
>> > +    $ cat qapi-generated/example-qapi-type-infos.h
>> > +    [Uninteresting stuff omitted...]
>> > +
>> > +    #ifndef EXAMPLE_QAPI_TYPE_INFOS_H
>> > +    #define EXAMPLE_QAPI_TYPE_INFOS_H
>> > +
>> > +    #include "qapi/qapi-builtin-type-infos.h"
>> > +
>> > +    extern const QAPITypeInfo UserDefOne_type_info;
>> > +
>> > +    extern const QAPITypeInfo UserDefOneList_type_info;
>> > +
>> > +    #endif /* EXAMPLE_QAPI_TYPE_INFOS_H */
>> > +    $ cat qapi-generated/example-qapi-type-infos.c
>> > +    [Uninteresting stuff omitted...]
>> > +
>> > +    const QAPITypeInfo UserDefOne_type_info =3D {
>> > +        .name =3D "UserDefOne",
>> > +        .masked_name =3D "1",
>> > +        .list =3D &UserDefOneList_type_info,
>> > +    };
>> > +
>> > +    const QAPITypeInfo UserDefOneList_type_info =3D {
>> > +        .name =3D "UserDefOneList",
>> > +        .masked_name =3D "[1]",
>> > +    };
>> > +
>> > +    [Uninteresting stuff omitted...]
>>
>> For me, it actually generates masked names "0" and "[0]".  Is the
>> mapping to masked names stable?
>
> it is not, as you know by design, it depends on registration order

Sorry, I phrased my question poorly.  Does it depend just on
registration order?  If yes, the mapping changes only when the schema
changes, which is desirable for diffing generator output.

[...]


