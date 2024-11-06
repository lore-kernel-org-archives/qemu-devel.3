Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A81D3E798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cH1-0001j8-J4; Wed, 06 Nov 2024 04:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8cGu-0001ea-84
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8cGp-0005Tj-QZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730885049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jmRzFnPJX2eFOo3Byka17HAu+GGpPfSPhDm/QzgD3pI=;
 b=C0fGNa0VzZP8IRNHvSFpxD/t5+zCgvQTCsxkBgCafAuSQChEhi4WpxpIv71SxCZ4vd6J0v
 qikIRekbezDL0OjK8xNQSjPd3qMspzVPd7ocyYT98PAsSxklDCMM4vQY6RBpglqjfQAzs3
 c7eEISVMTPkpvBFtgPBJ8KeHPI3tWOE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-QMX_dGvcP_O5xBeV8-U0eA-1; Wed,
 06 Nov 2024 04:24:08 -0500
X-MC-Unique: QMX_dGvcP_O5xBeV8-U0eA-1
X-Mimecast-MFC-AGG-ID: QMX_dGvcP_O5xBeV8-U0eA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07E76195609D; Wed,  6 Nov 2024 09:24:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D9281955F43; Wed,  6 Nov 2024 09:24:03 +0000 (UTC)
Date: Wed, 6 Nov 2024 09:24:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 04/22] tests/migration: Disambiguate guestperf vs. a-b
Message-ID: <Zys1sCZMVmExDvru@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105180837.5990-5-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 05, 2024 at 03:08:19PM -0300, Fabiano Rosas wrote:
> The current build structure for migration tests is confusing. There is
> the tests/migration directory, which contains two different guest code
> implementations, one for the qtests (a-b-{bootblock|kernel}.S) and
> another for the guestperf script (stress.c). One uses a Makefile,
> while the other uses meson.
> 
> The next patches will add a new qtests/migration/ directory to hold
> qtest code which will make the situation even more confusing.
> 
> Move the guest code used by qtests into a new qtests/migration/
> directory and rename the old one to tests/migration-stress.

NB, this clashes with this proposed series

  https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg03911.html

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/meson.build                                      |  2 +-
>  .../{migration => migration-stress}/guestperf-batch.py |  0
>  .../{migration => migration-stress}/guestperf-plot.py  |  0
>  tests/{migration => migration-stress}/guestperf.py     |  0
>  .../guestperf/__init__.py                              |  0
>  .../guestperf/comparison.py                            |  0
>  .../guestperf/engine.py                                |  0
>  .../guestperf/hardware.py                              |  0
>  .../{migration => migration-stress}/guestperf/plot.py  |  0
>  .../guestperf/progress.py                              |  0
>  .../guestperf/report.py                                |  0
>  .../guestperf/scenario.py                              |  0
>  .../{migration => migration-stress}/guestperf/shell.py |  0
>  .../guestperf/timings.py                               |  0
>  tests/{migration => migration-stress}/initrd-stress.sh |  0
>  tests/{migration => migration-stress}/meson.build      |  0
>  tests/{migration => migration-stress}/stress.c         |  0
>  tests/qtest/migration-test.c                           | 10 +++++-----
>  tests/{ => qtest}/migration/Makefile                   |  0
>  tests/{ => qtest}/migration/aarch64/Makefile           |  0
>  tests/{ => qtest}/migration/aarch64/a-b-kernel.S       |  0
>  tests/{ => qtest}/migration/aarch64/a-b-kernel.h       |  0
>  tests/{ => qtest}/migration/i386/Makefile              |  0
>  tests/{ => qtest}/migration/i386/a-b-bootblock.S       |  0
>  tests/{ => qtest}/migration/i386/a-b-bootblock.h       |  0
>  tests/{ => qtest}/migration/migration-test.h           |  0
>  tests/{ => qtest}/migration/ppc64/Makefile             |  0
>  tests/{ => qtest}/migration/ppc64/a-b-kernel.S         |  0
>  tests/{ => qtest}/migration/ppc64/a-b-kernel.h         |  0
>  tests/{ => qtest}/migration/s390x/Makefile             |  0
>  tests/{ => qtest}/migration/s390x/a-b-bios.c           |  0
>  tests/{ => qtest}/migration/s390x/a-b-bios.h           |  0
>  32 files changed, 6 insertions(+), 6 deletions(-)
>  rename tests/{migration => migration-stress}/guestperf-batch.py (100%)
>  rename tests/{migration => migration-stress}/guestperf-plot.py (100%)
>  rename tests/{migration => migration-stress}/guestperf.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/__init__.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/comparison.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/engine.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/hardware.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/plot.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/progress.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/report.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/scenario.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/shell.py (100%)
>  rename tests/{migration => migration-stress}/guestperf/timings.py (100%)
>  rename tests/{migration => migration-stress}/initrd-stress.sh (100%)
>  rename tests/{migration => migration-stress}/meson.build (100%)
>  rename tests/{migration => migration-stress}/stress.c (100%)
>  rename tests/{ => qtest}/migration/Makefile (100%)
>  rename tests/{ => qtest}/migration/aarch64/Makefile (100%)
>  rename tests/{ => qtest}/migration/aarch64/a-b-kernel.S (100%)
>  rename tests/{ => qtest}/migration/aarch64/a-b-kernel.h (100%)
>  rename tests/{ => qtest}/migration/i386/Makefile (100%)
>  rename tests/{ => qtest}/migration/i386/a-b-bootblock.S (100%)
>  rename tests/{ => qtest}/migration/i386/a-b-bootblock.h (100%)
>  rename tests/{ => qtest}/migration/migration-test.h (100%)
>  rename tests/{ => qtest}/migration/ppc64/Makefile (100%)
>  rename tests/{ => qtest}/migration/ppc64/a-b-kernel.S (100%)
>  rename tests/{ => qtest}/migration/ppc64/a-b-kernel.h (100%)
>  rename tests/{ => qtest}/migration/s390x/Makefile (100%)
>  rename tests/{ => qtest}/migration/s390x/a-b-bios.c (100%)
>  rename tests/{ => qtest}/migration/s390x/a-b-bios.h (100%)
> 
> diff --git a/tests/meson.build b/tests/meson.build
> index 907a4c1c98..f96c1be574 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -84,5 +84,5 @@ endif
>  subdir('unit')
>  subdir('qapi-schema')
>  subdir('qtest')
> -subdir('migration')
> +subdir('migration-stress')
>  subdir('functional')
> diff --git a/tests/migration/guestperf-batch.py b/tests/migration-stress/guestperf-batch.py
> similarity index 100%
> rename from tests/migration/guestperf-batch.py
> rename to tests/migration-stress/guestperf-batch.py
> diff --git a/tests/migration/guestperf-plot.py b/tests/migration-stress/guestperf-plot.py
> similarity index 100%
> rename from tests/migration/guestperf-plot.py
> rename to tests/migration-stress/guestperf-plot.py
> diff --git a/tests/migration/guestperf.py b/tests/migration-stress/guestperf.py
> similarity index 100%
> rename from tests/migration/guestperf.py
> rename to tests/migration-stress/guestperf.py
> diff --git a/tests/migration/guestperf/__init__.py b/tests/migration-stress/guestperf/__init__.py
> similarity index 100%
> rename from tests/migration/guestperf/__init__.py
> rename to tests/migration-stress/guestperf/__init__.py
> diff --git a/tests/migration/guestperf/comparison.py b/tests/migration-stress/guestperf/comparison.py
> similarity index 100%
> rename from tests/migration/guestperf/comparison.py
> rename to tests/migration-stress/guestperf/comparison.py
> diff --git a/tests/migration/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
> similarity index 100%
> rename from tests/migration/guestperf/engine.py
> rename to tests/migration-stress/guestperf/engine.py
> diff --git a/tests/migration/guestperf/hardware.py b/tests/migration-stress/guestperf/hardware.py
> similarity index 100%
> rename from tests/migration/guestperf/hardware.py
> rename to tests/migration-stress/guestperf/hardware.py
> diff --git a/tests/migration/guestperf/plot.py b/tests/migration-stress/guestperf/plot.py
> similarity index 100%
> rename from tests/migration/guestperf/plot.py
> rename to tests/migration-stress/guestperf/plot.py
> diff --git a/tests/migration/guestperf/progress.py b/tests/migration-stress/guestperf/progress.py
> similarity index 100%
> rename from tests/migration/guestperf/progress.py
> rename to tests/migration-stress/guestperf/progress.py
> diff --git a/tests/migration/guestperf/report.py b/tests/migration-stress/guestperf/report.py
> similarity index 100%
> rename from tests/migration/guestperf/report.py
> rename to tests/migration-stress/guestperf/report.py
> diff --git a/tests/migration/guestperf/scenario.py b/tests/migration-stress/guestperf/scenario.py
> similarity index 100%
> rename from tests/migration/guestperf/scenario.py
> rename to tests/migration-stress/guestperf/scenario.py
> diff --git a/tests/migration/guestperf/shell.py b/tests/migration-stress/guestperf/shell.py
> similarity index 100%
> rename from tests/migration/guestperf/shell.py
> rename to tests/migration-stress/guestperf/shell.py
> diff --git a/tests/migration/guestperf/timings.py b/tests/migration-stress/guestperf/timings.py
> similarity index 100%
> rename from tests/migration/guestperf/timings.py
> rename to tests/migration-stress/guestperf/timings.py
> diff --git a/tests/migration/initrd-stress.sh b/tests/migration-stress/initrd-stress.sh
> similarity index 100%
> rename from tests/migration/initrd-stress.sh
> rename to tests/migration-stress/initrd-stress.sh
> diff --git a/tests/migration/meson.build b/tests/migration-stress/meson.build
> similarity index 100%
> rename from tests/migration/meson.build
> rename to tests/migration-stress/meson.build
> diff --git a/tests/migration/stress.c b/tests/migration-stress/stress.c
> similarity index 100%
> rename from tests/migration/stress.c
> rename to tests/migration-stress/stress.c
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index a40451df1e..61c8cf043f 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -24,7 +24,7 @@
>  #include "ppc-util.h"
>  
>  #include "migration-helpers.h"
> -#include "tests/migration/migration-test.h"
> +#include "migration/migration-test.h"
>  #ifdef CONFIG_GNUTLS
>  # include "tests/unit/crypto-tls-psk-helpers.h"
>  # ifdef CONFIG_TASN1
> @@ -138,10 +138,10 @@ static char *bootpath;
>  /* The boot file modifies memory area in [start_address, end_address)
>   * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
>   */
> -#include "tests/migration/i386/a-b-bootblock.h"
> -#include "tests/migration/aarch64/a-b-kernel.h"
> -#include "tests/migration/ppc64/a-b-kernel.h"
> -#include "tests/migration/s390x/a-b-bios.h"
> +#include "migration/i386/a-b-bootblock.h"
> +#include "migration/aarch64/a-b-kernel.h"
> +#include "migration/ppc64/a-b-kernel.h"
> +#include "migration/s390x/a-b-bios.h"
>  
>  static void bootfile_delete(void)
>  {
> diff --git a/tests/migration/Makefile b/tests/qtest/migration/Makefile
> similarity index 100%
> rename from tests/migration/Makefile
> rename to tests/qtest/migration/Makefile
> diff --git a/tests/migration/aarch64/Makefile b/tests/qtest/migration/aarch64/Makefile
> similarity index 100%
> rename from tests/migration/aarch64/Makefile
> rename to tests/qtest/migration/aarch64/Makefile
> diff --git a/tests/migration/aarch64/a-b-kernel.S b/tests/qtest/migration/aarch64/a-b-kernel.S
> similarity index 100%
> rename from tests/migration/aarch64/a-b-kernel.S
> rename to tests/qtest/migration/aarch64/a-b-kernel.S
> diff --git a/tests/migration/aarch64/a-b-kernel.h b/tests/qtest/migration/aarch64/a-b-kernel.h
> similarity index 100%
> rename from tests/migration/aarch64/a-b-kernel.h
> rename to tests/qtest/migration/aarch64/a-b-kernel.h
> diff --git a/tests/migration/i386/Makefile b/tests/qtest/migration/i386/Makefile
> similarity index 100%
> rename from tests/migration/i386/Makefile
> rename to tests/qtest/migration/i386/Makefile
> diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/qtest/migration/i386/a-b-bootblock.S
> similarity index 100%
> rename from tests/migration/i386/a-b-bootblock.S
> rename to tests/qtest/migration/i386/a-b-bootblock.S
> diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/qtest/migration/i386/a-b-bootblock.h
> similarity index 100%
> rename from tests/migration/i386/a-b-bootblock.h
> rename to tests/qtest/migration/i386/a-b-bootblock.h
> diff --git a/tests/migration/migration-test.h b/tests/qtest/migration/migration-test.h
> similarity index 100%
> rename from tests/migration/migration-test.h
> rename to tests/qtest/migration/migration-test.h
> diff --git a/tests/migration/ppc64/Makefile b/tests/qtest/migration/ppc64/Makefile
> similarity index 100%
> rename from tests/migration/ppc64/Makefile
> rename to tests/qtest/migration/ppc64/Makefile
> diff --git a/tests/migration/ppc64/a-b-kernel.S b/tests/qtest/migration/ppc64/a-b-kernel.S
> similarity index 100%
> rename from tests/migration/ppc64/a-b-kernel.S
> rename to tests/qtest/migration/ppc64/a-b-kernel.S
> diff --git a/tests/migration/ppc64/a-b-kernel.h b/tests/qtest/migration/ppc64/a-b-kernel.h
> similarity index 100%
> rename from tests/migration/ppc64/a-b-kernel.h
> rename to tests/qtest/migration/ppc64/a-b-kernel.h
> diff --git a/tests/migration/s390x/Makefile b/tests/qtest/migration/s390x/Makefile
> similarity index 100%
> rename from tests/migration/s390x/Makefile
> rename to tests/qtest/migration/s390x/Makefile
> diff --git a/tests/migration/s390x/a-b-bios.c b/tests/qtest/migration/s390x/a-b-bios.c
> similarity index 100%
> rename from tests/migration/s390x/a-b-bios.c
> rename to tests/qtest/migration/s390x/a-b-bios.c
> diff --git a/tests/migration/s390x/a-b-bios.h b/tests/qtest/migration/s390x/a-b-bios.h
> similarity index 100%
> rename from tests/migration/s390x/a-b-bios.h
> rename to tests/qtest/migration/s390x/a-b-bios.h
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


