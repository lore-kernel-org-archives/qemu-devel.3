Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943C3CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO7U-00072U-8k; Sat, 30 Aug 2025 12:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1usGpc-0008Oa-IV
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 04:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1usGpY-000184-AE
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 04:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756542058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W56OVayfjtw3+UpoJKq7dLcaG+IStwODUGMsVrNF4vQ=;
 b=J2Ts+0SgeP2FDJMZMb41jGTzIYfopLP2wNvalH7h5Dy29mO2excoiFRk8/r1uaEEoATktg
 doSrWgYwrtyxgJddOZSAnzBJcih9O8KIjSKhohu8xD6KrmbeJ9MrAfTf03xat90bN4R3D/
 80P/a+gy0OhIK6e0QWqUJOFPHOwoL/4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-380lnrq5NoiiOOJ22Ztgww-1; Sat,
 30 Aug 2025 04:20:53 -0400
X-MC-Unique: 380lnrq5NoiiOOJ22Ztgww-1
X-Mimecast-MFC-AGG-ID: 380lnrq5NoiiOOJ22Ztgww_1756542051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E530C180047F; Sat, 30 Aug 2025 08:20:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E5331800446; Sat, 30 Aug 2025 08:20:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA4BF21E6A27; Sat, 30 Aug 2025 10:20:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mads Ynddal
 <mads@ynddal.dk>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v4 7/7] qapi: switch to use QEMU_TEST_REGENERATE env var
In-Reply-To: <20250819161053.464641-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Aug 2025 17:10:53
 +0100")
References: <20250819161053.464641-1-berrange@redhat.com>
 <20250819161053.464641-8-berrange@redhat.com>
Date: Sat, 30 Aug 2025 10:20:47 +0200
Message-ID: <87seh9cja8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> The QAPI_TEST_UPDATE env var can be set when running the QAPI
> schema tests to regenerate the reference output. For consistent
> naming with the tracetool test, change the env var name to
> QEMU_TEST_REGENERATE.
>
> The test is modified to provide a hint about use of the new
> env var and it is also added to the developer documentation.document its =
usage.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/devel/testing/main.rst    | 12 ++++++++++++
>  tests/qapi-schema/test-qapi.py |  7 +++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 11f05c0006..0662766b5c 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -178,6 +178,18 @@ parser (either fixing a bug or extending/modifying t=
he syntax). To do this:
>=20=20
>    ``qapi-schema +=3D foo.json``
>=20=20
> +The reference output can be automatically updated to match the latest QA=
PI
> +code generator by running the tests with the QEMU_TEST_REGENERATE enviro=
nment
> +variable set.
> +
> +.. code::
> +
> +   QEMU_TEST_REGENERATE=3D1 make check-qapi-schema
> +
> +The resulting changes must be reviewed by the author to ensure they match
> +the intended results before adding the updated reference output to the
> +same commit that alters the generator code.
> +
>  .. _tracetool-tests:
>=20=20
>  Tracetool tests

Appreciated, thanks!

> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 4be930228c..cf7fb8a6df 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -165,7 +165,7 @@ def test_and_diff(test_name, dir_name, update):
>      if actual_out =3D=3D expected_out and actual_err =3D=3D expected_err:
>          return 0
>=20=20
> -    print("%s %s" % (test_name, 'UPDATE' if update else 'FAIL'),
> +    print("%s: %s" % (test_name, 'UPDATE' if update else 'FAIL'),

I would've left this out just to keep the patch focused.  Definitely not
worth a respin now.

>            file=3Dsys.stderr)
>      out_diff =3D difflib.unified_diff(expected_out, actual_out, outfp.na=
me)
>      err_diff =3D difflib.unified_diff(expected_err, actual_err, errfp.na=
me)
> @@ -173,6 +173,9 @@ def test_and_diff(test_name, dir_name, update):
>      sys.stdout.writelines(err_diff)
>=20=20
>      if not update:
> +        print(("\n%s: set QEMU_TEST_REGENERATE=3D1 to recreate reference=
 output" +
> +               "if the QAPI schema generator was intentionally changed")=
 % test_name,
> +              file=3Dsys.stderr)
>          return 1
>=20=20
>      try:
> @@ -197,7 +200,7 @@ def main(argv):
>      parser.add_argument('-d', '--dir', action=3D'store', default=3D'',
>                          help=3D"directory containing tests")
>      parser.add_argument('-u', '--update', action=3D'store_true',
> -                        default=3D'QAPI_TEST_UPDATE' in os.environ,
> +                        default=3D'QEMU_TEST_REGENERATE' in os.environ,
>                          help=3D"update expected test results")
>      parser.add_argument('tests', nargs=3D'*', metavar=3D'TEST', action=
=3D'store')
>      args =3D parser.parse_args()

Reviewed-by: Markus Armbruster <armbru@redhat.com>


