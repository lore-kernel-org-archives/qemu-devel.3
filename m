Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA2CFCE090
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvcJy-00070O-Tx; Thu, 26 Feb 2026 09:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvcJv-00070F-GB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvcJt-0003M4-Q4
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772115984;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+Tu3BYWZ+h3ezco+sHTsWSQXoCXWEKy2s8TqR0GMZmA=;
 b=QgaUS/FOc+Yb82VmcDI8FShIepJPB+YJ+2gkiTR5/QsXbJfFRLvZ2z0eKg3vlsJdZ+ih3R
 oVb2ul6hGw92NT+uyYO0OLkkif5leoG9JtLaIcUNhzob5m6YlS6p/3hEWYBKbeGQjJwntz
 pRrIMETuQHKXIOficI0DK3t06oiGVu0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-b5NyjP9ePmi8ipK3o6qnsQ-1; Thu,
 26 Feb 2026 09:26:20 -0500
X-MC-Unique: b5NyjP9ePmi8ipK3o6qnsQ-1
X-Mimecast-MFC-AGG-ID: b5NyjP9ePmi8ipK3o6qnsQ_1772115980
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2E601956054; Thu, 26 Feb 2026 14:26:19 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.97])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF54419560B5; Thu, 26 Feb 2026 14:26:17 +0000 (UTC)
Date: Thu, 26 Feb 2026 14:26:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/4] python: replace avocado tests with pytest
Message-ID: <aaBYBfryWrYRMT2G@redhat.com>
References: <20260225192808.957477-1-jsnow@redhat.com>
 <20260225192808.957477-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225192808.957477-3-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 25, 2026 at 02:28:06PM -0500, John Snow wrote:
> Following suit with the rest of this repository, drop avocado and
> replace it with the Python standard "pytest" package.
> 
> In this case, we do not truly need pytest as all we are using it for is
> running other python processes formerly launched by shell scripts, but
> this matches how the standalone python-qemu-qmp package does things,
> which keeps things simple on my end.

From the POV of QEMU we don't really want 'pytest' in the loop
any more than we want avocado. The desire is for "meson" to be
the test harness.

If this use of a pytest is just a temporary stepping stone
towards fully integrating with meson, then that's acceptable
but lets note that this is a temporary solution in the commit
message.

> 
> (pytest version chosen based off of Debian 11's package version as queried by
> repology; under the assumption that this is the likely the oldest
> version we currently leverage in testing.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/Makefile          |  4 +-
>  python/setup.cfg         |  1 +
>  python/tests/linters.py  | 89 ++++++++++++++++++++++++++++++++++++++++
>  python/tests/minreqs.txt |  1 +
>  4 files changed, 93 insertions(+), 2 deletions(-)
>  create mode 100644 python/tests/linters.py
> 
> diff --git a/python/Makefile b/python/Makefile
> index b6c9cd1bce2..42994d39618 100644
> --- a/python/Makefile
> +++ b/python/Makefile
> @@ -105,7 +105,7 @@ develop:
>  
>  .PHONY: check
>  check:
> -	@avocado --config avocado.cfg run tests/
> +	@pytest -v tests/*.py
>  
>  .PHONY: check-tox
>  check-tox:
> @@ -113,7 +113,7 @@ check-tox:
>  
>  .PHONY: check-coverage
>  check-coverage:
> -	@coverage run -m avocado --config avocado.cfg run tests/*.py
> +	@coverage run -m pytest -v tests/*.py
>  	@coverage combine
>  	@coverage html
>  	@coverage report
> diff --git a/python/setup.cfg b/python/setup.cfg
> index c46a95f8d41..03344526730 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -43,6 +43,7 @@ devel =
>      mypy >= 1.4.0
>      pylint >= 2.17.3
>      pylint != 3.2.4; python_version<"3.9"
> +    pytest >= 6.0.2
>      tox >= 3.18.0
>      sphinx >= 3.4.3
>  
> diff --git a/python/tests/linters.py b/python/tests/linters.py
> new file mode 100644
> index 00000000000..28556c09910
> --- /dev/null
> +++ b/python/tests/linters.py
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import subprocess

from subprocess import check_call

> +import sys
> +
> +
> +def pyrun(*args):
> +    subprocess.run((sys.executable, *args), check=True)

Not sure this is worth the trouble compared to doing...


> +
> +
> +class TestLinters:
> +
> +    def test_flake8_pkg(self):
> +        pyrun("-m", "flake8", "qemu/")

...this inline:

    check_call([sys.executable, "-m", "flake8", "qemu/"])


> +    def test_mypy_iotests(self):
> +        cwd = os.getcwd()
> +        try:
> +            os.chdir("../tests/qemu-iotests/")
> +            pyrun("-m", "linters", "--mypy")
> +        finally:
> +            os.chdir(cwd)

This dance could be replaced with

    check_call([sys.executable, "-m", "linters", "--mpypy"],
               cwd="../tests/qemu-iotests/")



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


