Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3544FCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 09:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI0hf-000758-2c; Sat, 17 Oct 2026 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xI0hc-00074y-MW
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 05:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xI0ha-0002d8-TI
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 05:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792229261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xt926C8AeEj2cckg5KQ/de+sevSYeaqaP0xXL+60zU8=;
 b=aeCgxBV38ARziip1cxM2x+t7rbY2lBj3uUOnoQFW7pCQqlCenZtgdKupPWDlFsZlIPf10O
 ynjAJ8kc9SVOg9SkzJH+Snoy/dBdtkLqjcu54MyXgizLrsAzkaT7Vjsc2EWDgZRgiIkcVC
 qPxcSQ/AijqR6TTVoPkMiqrsmwdVDY4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684--ylSg_fMOZSIUzkI0oxoNg-1; Sat,
 17 Oct 2026 09:27:33 +0000
X-MC-Unique: -ylSg_fMOZSIUzkI0oxoNg-1
X-Mimecast-MFC-AGG-ID: -ylSg_fMOZSIUzkI0oxoNg_1792229252
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABE5A1955DD9; Sat, 17 Oct 2026 09:27:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B4ED7C6; Sat, 17 Oct 2026 09:27:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE20721E6A04; Sat, 17 Oct 2026 11:27:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 05/62] qapi: add type-infos generator
In-Reply-To: <20260911-qom-qapi-v5-5-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:34:39 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-5-7732a55b7760@redhat.com>
Date: Sat, 17 Oct 2026 11:27:29 +0200
Message-ID: <87bj8s4qym.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

> New QAPISchemaGenTypeInfoVisitor produces per-module
> qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
> pairing the QAPI type name with its masked introspection name.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Per-module is a bit problematic due to type masking.

To create a QOM property of QAPI type, we need the declaration of its
QAPITypeInfo, and we include the modular type-infos header to get it.

For instance, crypto/secret_common.c includes
qapi/qapi-type-infos-crypto.h for QCryptoSecretFormat_type_info.  Adding
or removing types in qapi/crypto.json will change
qapi/qapi-type-infos-crypto.h and trigger recompilation of
crypto/secret_common.c.  Adding or removing types elswhere won't.  Good.

However, messing with types *anywhere* almost always changes the masked
names *everywhere*, triggering recompilation of all qapi/*type-infos*.c.
Not so good.

A slow build is commonly death by a thousand cuts.  This is yet another
cut.  I'm sure we could figure out how to avoid it, but the series is
big and I don't want to delay it more than I have to.  Let's note the
issue in the commit message.

Aside: existing qapi/qapi-introspect.c is monolithic, which is
differently problematic.  Only qapi/qapi-introspect.c changes.  Good.
It's ~1.2MiB.  Not so good.

> ---
>  docs/devel/qapi-code-gen.rst |  92 +++++++++++++++++++++++
>  meson.build                  |   1 +
>  scripts/qapi/backend.py      |   2 +
>  scripts/qapi/type_infos.py   | 175 +++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 270 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index b697aab930d1..69d5c4af9874 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1250,6 +1250,9 @@ JSON array of strings.
>  To examine a type, start with a command or event using it, then follow
>  references by name.
>=20=20
> +.. TODO document QOM introspection (qom-list, qom-list-properties,
> +   qom-get) and how it relates to QAPI type information.
> +
>  .. TODO document QOM introspection (qom-list, qom-list-properties,
>     qom-get) and how it relates to QAPI type information.
>=20=20

Duplicate.  The first copy is from PATCH 04.  I believe it's an accident
there.

Out of time for today, intend to look at the remainder as soon as I can.

[...]


