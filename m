Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E091EC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujcC0-0007il-H8; Wed, 06 Aug 2025 07:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujcBq-0007dQ-Sj
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujcBo-0006Zo-Ox
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754479211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTJtemDVwQAQYzQzNbid3e/e8n0nWZZMR8+HvHHdsLc=;
 b=JXOIlQzNqBzZ6Q2nRGh0Y7j1vZ0aaWUNTqPpa5LG+vyJeCKeAxADVIWwHakIR53PDaS/SD
 bMkS+Fxyf8uy0lgp3iT0pPqKldPchcZ7YKgNKKBH93xpPmYR42CBYBqP7kBeqEaAKuR+eE
 eJ/JvUIOVi6xdNx6aK5m7L6ogkXcEX4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-GhWLEgh5MD6PIEjoiZnk3Q-1; Wed,
 06 Aug 2025 07:20:10 -0400
X-MC-Unique: GhWLEgh5MD6PIEjoiZnk3Q-1
X-Mimecast-MFC-AGG-ID: GhWLEgh5MD6PIEjoiZnk3Q_1754479209
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA6D819560B0; Wed,  6 Aug 2025 11:20:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 093D83000198; Wed,  6 Aug 2025 11:20:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5032E21E6A27; Wed, 06 Aug 2025 13:20:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 5/6] tracetool: add test suite for tracetool with
 reference output
In-Reply-To: <20250806102440.702545-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 6 Aug 2025 11:24:39
 +0100")
References: <20250806102440.702545-1-berrange@redhat.com>
 <20250806102440.702545-6-berrange@redhat.com>
Date: Wed, 06 Aug 2025 13:20:05 +0200
Message-ID: <87y0rwlmsa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> When reviewing tracetool patches it is often very unclear what the
> expected output will be for the generated backends. Compounding
> this is that a default build will only enable the 'log' trace
> backend, so developers won't see generated code for other backends
> without making a special effort. Some backends are also platform
> specific, so can't be enabled in QEMU builds, even though tracetool
> could generate the code.
>
> To address this, introduce a test suite for tracetool which is
> conceptually similar to the qapi-schema test. It is a simple
> python program that runs tracetool and compares the actual output
> to historical reference output kept in git. The test directly
> emits TAP format logs for ease of integration with meson.
>
> This can be run with
>
>   make check-tracetool
>
> to make it easier for developers changing generated output, the
> sample expected content can be auto-recreated
>
>   QEMU_TEST_REGENERATE=3D1 make check-tracetool

make check-qapi-schema uses QAPI_TEST_UPDATE for this.  Should we use a
single environment variable for this purpose?  I'd be fine with changing
QAPI_TEST_UPDATE.

> and the changes reviewed and added to the commit. This will also
> assist reviewers interpreting the change.
>
> Developers are reminded of this in the test output on failure:
>
>   $ make check-tracetool
>   1/6 qemu:tracetool / dtrace        OK              0.14s
>   2/6 qemu:tracetool / ftrace        FAIL            0.06s   exit status 1
>   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
>   1..2
>   ok 1 - ftrace.c
>   #
>   not ok 1 - ftrace.h (set QEMU_TEST_REGENERATE=3D1 to recreate reference=
 output if tracetool generator was intentionally changed)

Neat!  Nice to have in tests/qapi-schema/test-qapi.py, too.
Observation, not a demand.

>   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
>
>   3/6 qemu:tracetool / log           OK              0.06s
>   4/6 qemu:tracetool / simple        OK              0.06s
>   5/6 qemu:tracetool / syslog        OK              0.06s
>   6/6 qemu:tracetool / ust           OK              0.11s
>
>   Summary of Failures:
>
>   2/6 qemu:tracetool / ftrace FAIL            0.06s   exit status 1
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28cea34271..c08c51f4c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3556,6 +3556,7 @@ F: scripts/tracetool/
>  F: scripts/qemu-trace-stap*
>  F: docs/tools/qemu-trace-stap.rst
>  F: docs/devel/tracing.rst
> +F: tests/tracetool/
>  T: git https://github.com/stefanha/qemu.git tracing
>=20=20
>  Simpletrace
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 2b5cb0c148..11f05c0006 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -178,6 +178,34 @@ parser (either fixing a bug or extending/modifying t=
he syntax). To do this:
>=20=20
>    ``qapi-schema +=3D foo.json``
>=20=20
> +.. _tracetool-tests:
> +
> +Tracetool tests
> +~~~~~~~~~~~~~~~
> +
> +The tracetool tests validate the generated source files used for defining
> +probes for various tracing backends and source formats. The test operates
> +by running the tracetool program against a sample trace-events file, and
> +comparing the generated output against known good reference output. The
> +tests can be run with:
> +
> +.. code::
> +
> +  make check-tracetool
> +
> +The reference output is stored in files under tests/tracetool, and when
> +the tracetool backend/format output is intentionally changed, the refere=
nce
> +files need to be updated. This can be automated by setting the
> +QEMU_TEST_REGENERATE=3D1 environment variable:
> +
> +.. code::
> +
> +   QEMU_TEST_REGENERATE=3D1 make check-tracetool
> +
> +The resulting changes must be reviewed by the author to ensure they match
> +the intended results, before adding the updated reference output to the
> +same commit that alters the generator code.

Section "QAPI schema tests" could use similar advice on how to update
reference output.  Observation, not a demand.

> +
>  check-block
>  ~~~~~~~~~~~
>=20=20

[...]


