Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB28C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 07:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twz68-0006Qo-VR; Tue, 25 Mar 2025 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1twz67-0006QX-5e
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 03:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1twz65-0001QF-14
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 03:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742889194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ih4ZCts7KdtmIGttLE/z31TncmIqkNyg5qead0jt7NQ=;
 b=hD5+G2XKmRkRPafSAA5bQMliSm0dn1d+ob46FHv1bkloD1WAdBY22m07x1NsOEiDqeTX0t
 XYvv4VyzQQZe2DuftS71P+WbljZRSf4/PPWeoSSJWGKXE3UzK1M5sctR1CwD0fNgHgN+XT
 8JIYnWRyhRtUtXmajmEPAoCzhYUIdho=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Qe5ZBKyhNjmRbGK_JOboPw-1; Tue,
 25 Mar 2025 03:52:59 -0400
X-MC-Unique: Qe5ZBKyhNjmRbGK_JOboPw-1
X-Mimecast-MFC-AGG-ID: Qe5ZBKyhNjmRbGK_JOboPw_1742889179
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B8581800267; Tue, 25 Mar 2025 07:52:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71788180B492; Tue, 25 Mar 2025 07:52:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 66D8C21E6773; Tue, 25 Mar 2025 08:52:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] python: add qapi static analysis tests
In-Reply-To: <20250321222347.299121-5-jsnow@redhat.com> (John Snow's message
 of "Fri, 21 Mar 2025 18:23:46 -0400")
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-5-jsnow@redhat.com>
Date: Tue, 25 Mar 2025 08:52:53 +0100
Message-ID: <87jz8dpmwa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Update the python tests to also check qapi. No idea why I didn't do this
> before. I guess I was counting on moving it under python/ and then just
> forgot after that was NACKed. Oops, this turns out to be really easy.
>
> flake8, isort and mypy use the tool configuration from the existing
> python directory (in setup.cfg). pylint continues to use the special
> configuration located in scripts/qapi/ - that configuration is more
> permissive. If we wish to unify the two configurations, that's a
> separate series and a discussion for a later date.
>
> As a result of this patch, one would be able to run any of the following
> tests locally from the qemu.git/python directory and have it cover the
> scripts/qapi/ module as well. All of the following options run the
> python tests, static analysis tests, and linter checks; but with
> different combinations of dependencies and interpreters.
>
> - "make check-minreqs" Run tests specifically under our oldest supported
>   Python and our oldest supported dependencies. This is the test that
>   runs on GitLab as "check-python-minreqs". This helps ensure we do not
>   regress support on older platforms accidentally.
>
> - "make check-tox" Runs the tests under the newest supported
>   dependencies, but under each supported version of Python in turn. At
>   time of writing, this is Python 3.8 to 3.13 inclusive. This test helps
>   catch bleeding-edge problems before they become problems for developer
>   workstations. This is the GitLab test "check-python-tox" and is an
>   optionally run, may-fail test due to the unpredictable nature of new
>   dependencies being released into the ecosystem that may cause
>   regressions.
>
> - "make check-dev" Runs the tests under the newest supported
>   dependencies using whatever version of Python the user happens to have
>   installed. This is a quick convenience check that does not map to any
>   particular GitLab test.
>
> (Note! check-dev may be busted on Fedora 41 and bleeding edge versions
> of setuptools. That's unrelated to this patch and I'll address it
> separately and soon. Thank you for your patience, --mgmt)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Let's mention this is a step towards having "make check" run the static
analysis we want developers to run, but we're not there, yet.

> ---
>  python/setup.cfg            |  1 +
>  python/tests/minreqs.txt    | 21 +++++++++++++++++++++
>  python/tests/qapi-flake8.sh |  4 ++++
>  python/tests/qapi-isort.sh  |  6 ++++++
>  python/tests/qapi-mypy.sh   |  2 ++
>  python/tests/qapi-pylint.sh |  6 ++++++
>  scripts/qapi/pylintrc       |  1 +
>  7 files changed, 41 insertions(+)
>  create mode 100755 python/tests/qapi-flake8.sh
>  create mode 100755 python/tests/qapi-isort.sh
>  create mode 100755 python/tests/qapi-mypy.sh
>  create mode 100755 python/tests/qapi-pylint.sh
>
> diff --git a/python/setup.cfg b/python/setup.cfg
> index cf5af7e6641..84d8a1fd30d 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -47,6 +47,7 @@ devel =
>      urwid >= 2.1.2
>      urwid-readline >= 0.13
>      Pygments >= 2.9.0
> +    sphinx >= 3.4.3
>  
>  # Provides qom-fuse functionality
>  fuse =
> diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> index 19c0f5e4c50..94928936d44 100644
> --- a/python/tests/minreqs.txt
> +++ b/python/tests/minreqs.txt
> @@ -11,6 +11,9 @@
>  # When adding new dependencies, pin the very oldest non-yanked version
>  # on PyPI that allows the test suite to pass.
>  
> +# Dependencies for qapidoc/qapi_domain et al
> +sphinx==3.4.3
> +
>  # Dependencies for the TUI addon (Required for successful linting)
>  urwid==2.1.2
>  urwid-readline==0.13
> @@ -49,3 +52,21 @@ platformdirs==2.2.0
>  toml==0.10.0
>  tomlkit==0.10.1
>  wrapt==1.14.0
> +
> +# Transitive sphinx dependencies
> +Jinja2==2.7
> +MarkupSafe==1.1.0
> +alabaster==0.7.1
> +babel==1.3
> +docutils==0.12
> +imagesize==0.5.0
> +packaging==14.0
> +pytz==2011b0
> +requests==2.5.0
> +snowballstemmer==1.1
> +sphinxcontrib-applehelp==1.0.0
> +sphinxcontrib-devhelp==1.0.0
> +sphinxcontrib-htmlhelp==1.0.0
> +sphinxcontrib-jsmath==1.0.0
> +sphinxcontrib-qthelp==1.0.0
> +sphinxcontrib-serializinghtml==1.0.0

This wasn't there when I last saw this patch.  The previous patch also
updates this file.  How did you decide which updates go where?  Or is
this an accident?

> diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.sh
> new file mode 100755
> index 00000000000..7b5983d64a9
> --- /dev/null
> +++ b/python/tests/qapi-flake8.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh -e
> +python3 -m flake8 ../scripts/qapi/ \
> +        ../docs/sphinx/qapidoc.py \
> +        ../docs/sphinx/qapi_domain.py

Not linting docs/sphinx/qapidoc_legacy.py.  This is intentional (see its
initial commit message).  Since we plan to drop it soon, there's no real
need for a comment here, but mentioning it in the commit message
wouldn't hurt.

> diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
> new file mode 100755
> index 00000000000..f31f12d3425
> --- /dev/null
> +++ b/python/tests/qapi-isort.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh -e
> +python3 -m isort --sp . -c ../scripts/qapi/
> +# Force isort to recognize "compat" as a local module and not third-party
> +python3 -m isort --sp . -c -p compat -p qapidoc_legacy \
> +        ../docs/sphinx/qapi_domain.py \
> +        ../docs/sphinx/qapidoc.py

Comment on flake8 applies.

> diff --git a/python/tests/qapi-mypy.sh b/python/tests/qapi-mypy.sh
> new file mode 100755
> index 00000000000..377b29b873b
> --- /dev/null
> +++ b/python/tests/qapi-mypy.sh
> @@ -0,0 +1,2 @@
> +#!/bin/sh -e
> +python3 -m mypy ../scripts/qapi

Not type-checking docs/sphinx/qapi_domain.py and docs/sphinx/qapidoc.py?
Impractical due to us targeting an isanely wide Sphinx version range?

> diff --git a/python/tests/qapi-pylint.sh b/python/tests/qapi-pylint.sh
> new file mode 100755
> index 00000000000..f4bb7a5a795
> --- /dev/null
> +++ b/python/tests/qapi-pylint.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh -e
> +SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint \
> +                                --rcfile=../scripts/qapi/pylintrc \
> +                                ../scripts/qapi/ \
> +                                ../docs/sphinx/qapidoc.py \
> +                                ../docs/sphinx/qapi_domain.py

Comment on flake8 applies.

> diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
> index d24eece7411..e16283ada3d 100644
> --- a/scripts/qapi/pylintrc
> +++ b/scripts/qapi/pylintrc
> @@ -19,6 +19,7 @@ disable=consider-using-f-string,
>          too-many-instance-attributes,
>          too-many-positional-arguments,
>          too-many-statements,
> +        unknown-option-value,
>          useless-option-value,
>  
>  [REPORTS]

This wasn't there when I last saw this patch.  PATCH 1 also updates this
file.  How did you decide which updates go where?  Or is this an
accident?


