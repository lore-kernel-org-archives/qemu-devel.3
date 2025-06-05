Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471D1C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 06:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN4Al-0008QN-Sj; Thu, 05 Jun 2025 02:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN4Aj-0008Pz-GU
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN4Ah-0005KC-VI
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749105230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BtYqADsQr5xNnXQ6oVn1W/cUF10o6VPy9If6SPK+4k4=;
 b=BauOI7QOGzx2axgwY7kESkkN+wtNqzR8G5FjrABDAA0dN2Mwk2n/HLFX05lmxAIJske3tj
 TEFWuxYqzb4rnUQXUBgt+tjW3CSXb1htlpbtC0d3yoCsI77uj8++Ip3kKaSICi5/4IIMqj
 vua4TjL/40Xw22ml1sndzUM9mQ9VHkE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-cmEwjukeMH2x4bX-jBuWNw-1; Thu,
 05 Jun 2025 02:33:48 -0400
X-MC-Unique: cmEwjukeMH2x4bX-jBuWNw-1
X-Mimecast-MFC-AGG-ID: cmEwjukeMH2x4bX-jBuWNw_1749105228
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E907118002B4; Thu,  5 Jun 2025 06:33:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CE651956087; Thu,  5 Jun 2025 06:33:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DECDE21E6757; Thu, 05 Jun 2025 08:33:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Cleber
 Rosa <crosa@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 4/6] python: add qapi static analysis tests
In-Reply-To: <20250604200354.459501-5-jsnow@redhat.com> (John Snow's message
 of "Wed, 4 Jun 2025 16:03:52 -0400")
References: <20250604200354.459501-1-jsnow@redhat.com>
 <20250604200354.459501-5-jsnow@redhat.com>
Date: Thu, 05 Jun 2025 08:33:44 +0200
Message-ID: <87frgen1dj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

[...]

> diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.sh
> new file mode 100755
> index 00000000000..2211b6c7f41
> --- /dev/null
> +++ b/python/tests/qapi-flake8.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: LGPL-2.1-or-later

Why not GPL-2.0-or-later?

> +
> +python3 -m flake8 ../scripts/qapi/ \
> +        ../docs/sphinx/qapidoc.py \
> +        ../docs/sphinx/qapi_domain.py
> diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
> new file mode 100755
> index 00000000000..e546f5a7b5c
> --- /dev/null
> +++ b/python/tests/qapi-isort.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: LGPL-2.1-or-later

Likewise.

> +
> +python3 -m isort --sp . -c ../scripts/qapi/
> +# Force isort to recognize "compat" as a local module and not third-party
> +python3 -m isort --sp . -c -p compat -p qapidoc_legacy \
> +        ../docs/sphinx/qapi_domain.py \
> +        ../docs/sphinx/qapidoc.py
> diff --git a/python/tests/qapi-mypy.sh b/python/tests/qapi-mypy.sh
> new file mode 100755
> index 00000000000..50fb8ed1e3e
> --- /dev/null
> +++ b/python/tests/qapi-mypy.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: LGPL-2.1-or-later

Likewise.

> +
> +python3 -m mypy ../scripts/qapi
> diff --git a/python/tests/qapi-pylint.sh b/python/tests/qapi-pylint.sh
> new file mode 100755
> index 00000000000..5f1b79c1883
> --- /dev/null
> +++ b/python/tests/qapi-pylint.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: LGPL-2.1-or-later

Likewise.

> +
> +SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint \
> +                                --rcfile=../scripts/qapi/pylintrc \
> +                                ../scripts/qapi/ \
> +                                ../docs/sphinx/qapidoc.py \
> +                                ../docs/sphinx/qapi_domain.py
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


