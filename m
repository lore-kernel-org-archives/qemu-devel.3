Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7434EC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 11:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMgL-0003ak-67; Fri, 07 Feb 2025 06:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMgI-0003aY-LV
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMgG-0006Zu-5i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738928274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=G681NJWhJblzSW1B26wQodNKl3skj5pWRVUIj+ZWGJ0=;
 b=O0AhtqHbLQzE2jmRWo9X3EzQI3a74yae9gdNlka3b7n3Nw9AsLDD+LBmkK0blzR03K8VI4
 uj7yu/xbYkEVnojBoEikaI7D+VZbeiAh514YFt8IEUKv+jud1OrWoIHqvldDMYoTR8spfq
 ipblYVJO3Xq/M8WUTbGW9/clx+cPfBM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-EsjtT1DmNXqvvJCQQTpAMg-1; Fri,
 07 Feb 2025 06:37:52 -0500
X-MC-Unique: EsjtT1DmNXqvvJCQQTpAMg-1
X-Mimecast-MFC-AGG-ID: EsjtT1DmNXqvvJCQQTpAMg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC714180087A; Fri,  7 Feb 2025 11:37:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 347EF19560AE; Fri,  7 Feb 2025 11:37:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CFF921E6A28; Fri, 07 Feb 2025 12:37:47 +0100 (CET)
Resent-To: michael.roth@amd.com, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 07 Feb 2025 12:37:47 +0100
Resent-Message-ID: <87cyfuj88k.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 4/4] qapi: expose all schema features to code
In-Reply-To: <CAFn=p-Y4RXP395Kjc4ZnSWuEjn-Vr7YuVEtGAOsWse74pkqvCw@mail.gmail.com>
 (John Snow's message of "Thu, 6 Feb 2025 23:38:13 -0500")
References: <20241212110616.3147676-1-berrange@redhat.com>
 <20241212110616.3147676-5-berrange@redhat.com>
 <87jzabm8ae.fsf@pond.sub.org>
 <CAFn=p-Y4RXP395Kjc4ZnSWuEjn-Vr7YuVEtGAOsWse74pkqvCw@mail.gmail.com>
Date: Fri, 07 Feb 2025 11:30:31 +0100
Message-ID: <87wme2jbco.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Fri, Jan 31, 2025 at 8:18=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Cc: John Snow for Python typing expertise.
>>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>> > This replaces use of the constants from the QapiSpecialFeatures
>> > enum, with constants from the auto-generate QapiFeatures enum
>> > in qapi-features.h
>> >
>> > The 'deprecated' and 'unstable' features still have a little bit of
>> > special handling, being force defined to be the 1st + 2nd features
>> > in the enum, regardless of whether they're used in the schema. This
>> > retains compatibility with common code that references the features
>> > via the QapiSpecialFeatures constants.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

>> > diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
>> > new file mode 100644
>> > index 0000000000..f32f9fe5f4
>> > --- /dev/null
>> > +++ b/scripts/qapi/features.py
>> > @@ -0,0 +1,51 @@
>> > +"""
>> > +QAPI features generator
>> > +
>> > +Copyright 2024 Red Hat
>> > +
>> > +This work is licensed under the terms of the GNU GPL, version 2.
>> > +# See the COPYING file in the top-level directory.
>> > +"""
>> > +
>> > +from typing import Dict
>> > +
>> > +from .common import c_enum_const, c_name
>> > +from .gen import QAPISchemaMonolithicCVisitor
>> > +from .schema import (
>> > +    QAPISchema,
>> > +    QAPISchemaFeature,
>> > +)
>> > +
>> > +
>> > +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
>> > +
>> > +    def __init__(self, prefix: str):
>> > +        super().__init__(
>> > +            prefix, 'qapi-features',
>> > +            ' * Schema-defined QAPI features',
>> > +            __doc__)
>> > +
>> > +        self.features: Dict[str, QAPISchemaFeature] =3D {}
>> > +
>> > +    def visit_begin(self, schema: QAPISchema) -> None:
>> > +        self.features =3D schema.features()
>>
>> Inconsistent type hints:
>>
>>     $ mypy --config-file scripts/qapi/mypy.ini scripts/qapi-gen.py
>>     scripts/qapi/schema.py:1164: error: Incompatible return value type
>> (got "dict_values[str, QAPISchemaFeature]", expected
>> "List[QAPISchemaFeature]")  [return-value]
>>     scripts/qapi/features.py:31: error: Incompatible types in assignment
>> (expression has type "List[QAPISchemaFeature]", variable has type
>> "Dict[str, QAPISchemaFeature]")  [assignment]
>>
>> We've been working towards having the build run mypy, but we're not
>> there, yet.  Sorry for the inconvenience!
>>
>> schema.features() returns .values(), i.e. a view object.
>>
>> I guess the type hint should be ValuesView[QAPISchemaFeature], both for
>> type type of attribute .features above, and for the return type of
>> method .features() below.  John?
>>
>
> It's probably easiest to just use list(...) in the return and then use
> List[T] anywhere it matters. The values view type is "kind of, but not
> actually a list" because it isn't mutable. It is, however, an
> Iterable/Sequence. You can either convert it to a list or make the typing
> more abstract.
>
> (Rule of thumb: return types should be as specific as possible, input typ=
es
> should be as abstract as possible.)

Converting a view to a list makes a copy, right?

I'm not asking because that would be terrible.  I just like to
understand things.

I'd like to move further discussion to Daniel's v4.

> I apologize for this format of relaying patches as it is against the blood
> oath I swore as a maintainer, but it's late in my day, forgive me:
> https://gitlab.com/jsnow/qemu/-/commits/dan-fixup
>
> That branch has two things in it:
>
> (1) patches to make the python/ tests check the qapi module. This means t=
he
> "make check-minreqs" test you can run from python/ will be run by the
> GitLab pipelines. You can also run "make check-tox" manually, or run the
> optional python-tox test from the pipeline dashboard.

These are:

    dd9e47f0a8 qapi: update pylintrc config
    dfc6344f32 python: add qapi static analysis tests
    1f89bf53ed qapi: delete un-needed static analysis configs

Will you post them for review & merging?

> (2) two fixups for linting problems with this series with my s-o-b; feel
> free to steal them if they're good enough for you.

These are:

    b36a412162 fixup
    fa6c90ea76 fixup

I'll post them in reply to Daniel's v4 so they get recorded in the list
archive.

> Thank you for your patience,
> --js

Thanks for your help!

[...]


