Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAF5C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 08:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfaas-0003IW-1s; Wed, 05 Feb 2025 03:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfaan-0003IA-SU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfaal-0002p2-HB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738743422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BRqQ3fWXl/YMiyl0p96PplQZs/WUy+PJhzJxG+8YK4=;
 b=fr3awDTDJlIx3N/T3TKa8wt/QxZ4iikI7rZ2Ri+bhjN66odLEvALZIdqJq8r4FPACKgXxL
 18rihUCD75sJOtTEtIwZ47kHfeI1qTLG/6H0W6F7a1CwQgsGMTWSP86EIfHy++R9WK/wA1
 oIR4Y8rjH59fwRgEAf9IaOcKwdaOL5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-ocbuJZS0NRen_c3dQigbDw-1; Wed,
 05 Feb 2025 03:16:58 -0500
X-MC-Unique: ocbuJZS0NRen_c3dQigbDw-1
X-Mimecast-MFC-AGG-ID: ocbuJZS0NRen_c3dQigbDw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E74DC1800264; Wed,  5 Feb 2025 08:16:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B09501800365; Wed,  5 Feb 2025 08:16:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3340F21E6A28; Wed, 05 Feb 2025 09:16:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju
 Jose <shiju.jose@huawei.com>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  John Snow
 <jsnow@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/14] scripts/ghes_inject: add a script to generate
 GHES error inject
In-Reply-To: <80858743b6fd67db3f48ac8cb466bbcde5b11132.1738345063.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Fri, 31 Jan 2025 18:42:55 +0100")
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <80858743b6fd67db3f48ac8cb466bbcde5b11132.1738345063.git.mchehab+huawei@kernel.org>
Date: Wed, 05 Feb 2025 09:16:53 +0100
Message-ID: <87bjvg6c22.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
>
> Add a helper script with subcommands to prepare such data.
>
> Currently, only ARM Processor error CPER record is supported, by
> using:
> 	$ ghes_inject.py arm
>
> which produces those warnings on Linux:
>
> [  705.032426] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> [  774.866308] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> [  774.866583] {4}[Hardware Error]: event severity: recoverable
> [  774.866738] {4}[Hardware Error]:  Error 0, type: recoverable
> [  774.866889] {4}[Hardware Error]:   section_type: ARM processor error
> [  774.867048] {4}[Hardware Error]:   MIDR: 0x00000000000f0510
> [  774.867189] {4}[Hardware Error]:   running state: 0x0
> [  774.867321] {4}[Hardware Error]:   Power State Coordination Interface state: 0
> [  774.867511] {4}[Hardware Error]:   Error info structure 0:
> [  774.867679] {4}[Hardware Error]:   num errors: 2
> [  774.867801] {4}[Hardware Error]:    error_type: 0x02: cache error
> [  774.867962] {4}[Hardware Error]:    error_info: 0x000000000091000f
> [  774.868124] {4}[Hardware Error]:     transaction type: Data Access
> [  774.868280] {4}[Hardware Error]:     cache error, operation type: Data write
> [  774.868465] {4}[Hardware Error]:     cache level: 2
> [  774.868592] {4}[Hardware Error]:     processor context not corrupted
> [  774.868774] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
>
> Such script allows customizing the error data, allowing to change
> all fields at the record. Please use:
>
> 	$ ghes_inject.py arm -h
>
> For more details about its usage.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[...]

> diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
> new file mode 100644
> index 000000000000..b0e8450e667e
> --- /dev/null
> +++ b/scripts/arm_processor_error.py
> @@ -0,0 +1,476 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=C0301,C0114,R0903,R0912,R0913,R0914,R0915,W0511
> +# SPDX-License-Identifier: GPL-2.0

Sorry if this has been answered already...  why not GPL-2.0-or-later?

More of the same below.

[...]


