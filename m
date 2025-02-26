Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF00BC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBq3-000745-O3; Wed, 26 Feb 2025 02:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnBq1-00073V-7D
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:28:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnBpz-0002Fk-FK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740554890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z2rpj4I6Gi/sE2bEO64qKzLuMZZIZLHAuaolAXU4CRU=;
 b=D0dgl+Q+CXeipNSsN4GUIgy0JByVnY3AwB4F8/VSqQ4Ozvz1d9c9XJYGhTmH1XNppx/5de
 9vIn3TxIYq3g4uFNh5KaOKja58v6Wd8hv8Me1EDoEsvopXjo/Lou2dS60R1UykhFqB2lEF
 ZakRYp8LG9fPwo2ZA6MD/3kziMevuq8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-fxUNbx31Osqmzxi_0Rd2yA-1; Wed,
 26 Feb 2025 02:28:03 -0500
X-MC-Unique: fxUNbx31Osqmzxi_0Rd2yA-1
X-Mimecast-MFC-AGG-ID: fxUNbx31Osqmzxi_0Rd2yA_1740554881
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B836F19783B3; Wed, 26 Feb 2025 07:28:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E1FA1800352; Wed, 26 Feb 2025 07:28:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6D8821E675E; Wed, 26 Feb 2025 08:27:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Thomas
 Huth <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 03/10] qapi: delete un-needed python static analysis
 configs
In-Reply-To: <20250224033741.222749-4-jsnow@redhat.com> (John Snow's message
 of "Sun, 23 Feb 2025 22:37:34 -0500")
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-4-jsnow@redhat.com>
Date: Wed, 26 Feb 2025 08:27:58 +0100
Message-ID: <87bjup5fnl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

> The pylint config is being left in place because the settings differ
> enough from the python/ directory settings that we need a chit-chat on
> how to merge them O:-)
>
> Everything else can go.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/.flake8    | 3 ---
>  scripts/qapi/.isort.cfg | 7 -------
>  scripts/qapi/mypy.ini   | 4 ----
>  3 files changed, 14 deletions(-)
>  delete mode 100644 scripts/qapi/.flake8
>  delete mode 100644 scripts/qapi/.isort.cfg
>  delete mode 100644 scripts/qapi/mypy.ini
>
> diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
> deleted file mode 100644
> index a873ff67309..00000000000
> --- a/scripts/qapi/.flake8
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -[flake8]
> -# Prefer pylint's bare-except checks to flake8's
> -extend-ignore = E722

python/setup.cfg has:

   [flake8]
   # Prefer pylint's bare-except checks to flake8's
   extend-ignore = E722
   exclude = __pycache__,

Good.

> diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
> deleted file mode 100644
> index 643caa1fbd6..00000000000
> --- a/scripts/qapi/.isort.cfg
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -[settings]
> -force_grid_wrap=4
> -force_sort_within_sections=True
> -include_trailing_comma=True
> -line_length=72
> -lines_after_imports=2
> -multi_line_output=3

python/setup.cfg has:

   [isort]
   force_grid_wrap=4
   force_sort_within_sections=True
   include_trailing_comma=True
   line_length=72
   lines_after_imports=2
   multi_line_output=3

Good.

> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> deleted file mode 100644
> index 8109470a031..00000000000
> --- a/scripts/qapi/mypy.ini
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -[mypy]
> -strict = True
> -disallow_untyped_calls = False
> -python_version = 3.8

python/setup.cfg has:

   [mypy]
   strict = True
   python_version = 3.8
   warn_unused_configs = True
   namespace_packages = True
   warn_unused_ignores = False

Can you briefly explain the differences?

python/setup.cfg additionally has a bunch of ignore_missing_imports that
don't apply here, as far as I can tell.


