Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62640C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 07:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsElT-0003z8-Pg; Fri, 07 Aug 2026 03:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsElI-0003yk-RT
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 03:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsElF-0001wH-8V
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 03:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786086774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlWXU41tXlH4VzEPsnDpBdnqkIqge8+fKnLPWU7RdWA=;
 b=hlqWnn6vvhMn8Ob0VGis2EO9IPbc0FLytXzr8Nc+MUNZsVJx+oKJIPBXf6qEvLglajz22M
 tNrzUGZjzXYKmMb52k49aH0Ut6h/wG8nU7Xu9HGamdrmawnXLRstKUhUXEEiDE+vHSX0gb
 I1W0T6XQjUzrxzGDs8xxqFo6myrRyW8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-9MLCQWT_PQWB9wThbc6LMw-1; Fri,
 07 Aug 2026 03:12:44 -0400
X-MC-Unique: 9MLCQWT_PQWB9wThbc6LMw-1
X-Mimecast-MFC-AGG-ID: 9MLCQWT_PQWB9wThbc6LMw_1786086763
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D4F7195608F; Fri,  7 Aug 2026 07:12:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E6EB180034C; Fri,  7 Aug 2026 07:12:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D0AF21E6920; Fri, 07 Aug 2026 09:12:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 06/53] meson: add qapi-type-infos-*.c/h to build
In-Reply-To: <20260616-qom-qapi-v2-6-cc9396b9c18c@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 16 Jun 2026 00:37:32 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-6-cc9396b9c18c@redhat.com>
Date: Fri, 07 Aug 2026 09:12:40 +0200
Message-ID: <87o6fes8t3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Register the new per-module type-infos output files so they are
> generated during the QAPI code generation step and compiled into
> the build.

Actually, they're generated before this patch already, they just aren't
compiled.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/meson.build              | 4 ++++
>  tests/include/meson.build     | 2 ++
>  tests/meson.build             | 6 ++++++
>  tests/qapi-schema/meson.build | 1 +
>  4 files changed, 13 insertions(+)
>
> diff --git a/qapi/meson.build b/qapi/meson.build
> index a46269b5a0c..7ae3843de6e 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -80,6 +80,7 @@ endif
>  qapi_nonmodule_outputs =3D [
>    'qapi-introspect.c', 'qapi-introspect.h',
>    'qapi-types.c', 'qapi-types.h',
> +  'qapi-type-infos.c', 'qapi-type-infos.h',
>    'qapi-visit.h', 'qapi-visit.c',
>    'qapi-commands.h', 'qapi-commands.c',
>    'qapi-init-commands.h', 'qapi-init-commands.c',
> @@ -90,6 +91,7 @@ qapi_nonmodule_outputs =3D [
>  qapi_outputs =3D qapi_nonmodule_outputs + [
>    'qapi-builtin-types.c', 'qapi-builtin-visit.c',
>    'qapi-builtin-types.h', 'qapi-builtin-visit.h',
> +  'qapi-builtin-type-infos.c', 'qapi-builtin-type-infos.h',
>  ]
>=20=20
>  qapi_inputs =3D []
> @@ -100,6 +102,8 @@ foreach module : qapi_all_modules
>      'qapi-types-@0@.h'.format(module),
>      'qapi-visit-@0@.c'.format(module),
>      'qapi-visit-@0@.h'.format(module),
> +    'qapi-type-infos-@0@.c'.format(module),
> +    'qapi-type-infos-@0@.h'.format(module),
>    ]
>    if have_system or have_tools
>      qapi_module_outputs +=3D [
> diff --git a/tests/include/meson.build b/tests/include/meson.build
> index 8e8d1ec4e69..026480d9685 100644
> --- a/tests/include/meson.build
> +++ b/tests/include/meson.build
> @@ -4,6 +4,8 @@ test_qapi_outputs_extra =3D [
>    'test-qapi-commands-sub-module.h',
>    'test-qapi-events-sub-module.c',
>    'test-qapi-events-sub-module.h',
> +  'test-qapi-type-infos-sub-module.c',
> +  'test-qapi-type-infos-sub-module.h',
>    'test-qapi-types-sub-module.c',
>    'test-qapi-types-sub-module.h',
>    'test-qapi-visit-sub-module.c',
> diff --git a/tests/meson.build b/tests/meson.build
> index 9ba04bbedd3..71dc4ac8bf9 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -2,6 +2,8 @@ subdir('bench')
>  subdir('qemu-iotests')
>=20=20
>  test_qapi_outputs =3D [
> +  'qapi-builtin-type-infos.c',
> +  'qapi-builtin-type-infos.h',
>    'qapi-builtin-types.c',
>    'qapi-builtin-types.h',
>    'qapi-builtin-visit.c',
> @@ -22,6 +24,10 @@ test_qapi_outputs =3D [
>    'test-qapi-init-commands.h',
>    'test-qapi-introspect.c',
>    'test-qapi-introspect.h',
> +  'test-qapi-type-infos-sub-sub-module.c',
> +  'test-qapi-type-infos-sub-sub-module.h',
> +  'test-qapi-type-infos.c',
> +  'test-qapi-type-infos.h',
>    'test-qapi-types-sub-sub-module.c',
>    'test-qapi-types-sub-sub-module.h',
>    'test-qapi-types.c',
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
> index debff633ac1..b10f081554d 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -232,6 +232,7 @@ custom_target('QAPI doc',
>                         'doc-good-qapi-init-commands.c', 'doc-good-qapi-i=
nit-commands.h',
>                         'doc-good-qapi-introspect.c', 'doc-good-qapi-intr=
ospect.h',
>                         'doc-good-qapi-types.c', 'doc-good-qapi-types.h',
> +                       'doc-good-qapi-type-infos.c', 'doc-good-qapi-type=
-infos.h',
>                         'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h' =
],
>                input: files('doc-good.json'),
>                command: [ qapi_gen, '-o', meson.current_build_dir(),

You add *type-infos* before *types* in some places, and after *types* in
others.  I'd prefer same order everywhere.  Slight preference for
before, so the order is alphabetical.

You don't add them to qga/meson.build.  Makes sense; the guest agent has
no use for them at this time.  They're still generated, though, which is
fine, except "make clean" doesn't delete them.  Unclean :)

Related: PATCH 04 generates files with bad names
qapi-builtin-type-builtin-infos.[ch], PATCH 05 fixes them to
qapi-builtin-type-infos.[ch], but "make clean" doesn't delete the bad
ones.  Only "hurts" people compiling between PATCH 04 and 05, so no big
deal.  I'd reorder to avoid this anyway.  The fix's commit message needs
to be adjusted then.

Similar dirtiness predates this series: qapi-features.[ch]
qapi-commands.trace-events qapi-init-commands.trace-events.


