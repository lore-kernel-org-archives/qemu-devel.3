Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B5C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 11:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMzA-0007qM-EJ; Fri, 07 Feb 2025 06:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMz8-0007mD-CN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMz6-0005zP-At
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738929442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjpUmZIKjIZGPUgiug4xe2Bxoc6x/jrKg13Yq1LbFDY=;
 b=OPkP3SNzEGZ1558Mj38j1sAySx1Rejhf8V/ymBhtmau+OpzSTU9UysyrLKqnTHtXEzt7Yi
 FQ1+iS+K2NDET+gfkBPRQ48+/ceOKfftFmXdACW0fDrpJNu9GJ7TMC3Xjvj2EfCCRJpCkt
 zb6B05CFE54DchASL0MJ09YZfsLdZE4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-m5_xuSD0NwC2Iyy6BrJWVA-1; Fri,
 07 Feb 2025 06:57:21 -0500
X-MC-Unique: m5_xuSD0NwC2Iyy6BrJWVA-1
X-Mimecast-MFC-AGG-ID: m5_xuSD0NwC2Iyy6BrJWVA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3334619560A7; Fri,  7 Feb 2025 11:57:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C522195608D; Fri,  7 Feb 2025 11:57:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DBE021E6A28; Fri, 07 Feb 2025 12:57:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 4/4] qapi: expose all schema features to code
In-Reply-To: <20250205123550.2754387-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 5 Feb 2025 12:35:50
 +0000")
References: <20250205123550.2754387-1-berrange@redhat.com>
 <20250205123550.2754387-5-berrange@redhat.com>
Date: Fri, 07 Feb 2025 12:57:16 +0100
Message-ID: <87wme2hsrn.fsf@pond.sub.org>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This replaces use of the constants from the QapiSpecialFeatures
> enum, with constants from the auto-generate QapiFeatures enum
> in qapi-features.h
>
> The 'deprecated' and 'unstable' features still have a little bit of
> special handling, being force defined to be the 1st + 2nd features
> in the enum, regardless of whether they're used in the schema. This
> retains compatibility with common code that references the features
> via the QapiSpecialFeatures constants.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Daniel, feel free to ignore this at least for now.  I'm trying to learn
some typing lore from John.

v3 made mypy unhappy.  I asked John for advice, and also posted a
solution involving ValuesView I hacked up myself.  Daniel took it for
v4.

John suggested to use List.

I now wonder whether could use Iterable.

I'll show the three solutions inline.

John, thoughts?

[...]

> diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
> new file mode 100644
> index 0000000000..be3e5d03ff
> --- /dev/null
> +++ b/scripts/qapi/features.py
> @@ -0,0 +1,51 @@
> +"""
> +QAPI features generator
> +
> +Copyright 2024 Red Hat
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +"""
> +
> +from typing import Dict, ValuesView
> +
> +from .common import c_enum_const, c_name
> +from .gen import QAPISchemaMonolithicCVisitor
> +from .schema import (
> +    QAPISchema,
> +    QAPISchemaFeature,
> +)
> +
> +
> +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
> +
> +    def __init__(self, prefix: str):
> +        super().__init__(
> +            prefix, 'qapi-features',
> +            ' * Schema-defined QAPI features',
> +            __doc__)
> +
> +        self.features: ValuesView[QAPISchemaFeature]

This is the ValuesView solution.

The List solution:

           self.features: List[QAPISchemaFeature] =3D []

The Iterable solution:

           self.features: Iterable[QAPISchemaFeature]

[...]


> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index e97c978d38..7f70969c09 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py

[...]

> @@ -1147,6 +1161,9 @@ def __init__(self, fname: str):
>          self._def_exprs(exprs)
>          self.check()
>=20=20
> +    def features(self) -> ValuesView[QAPISchemaFeature]:
> +        return self._feature_dict.values()

This is the ValuesView solution.

The List solution:

       def features(self) -> List[QAPISchemaFeature]:
           return list(self._feature_dict.values())

The Iterable solution:

       def features(self) -> Iterable[QAPISchemaFeature]:
           return self._feature_dict.values()


> +
>      def _def_entity(self, ent: QAPISchemaEntity) -> None:
>          self._entity_list.append(ent)
>=20=20

[...]


