Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ACEE65D00
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 23:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEGEN-0007hY-2w; Thu, 21 Nov 2024 18:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEGEF-0007gm-H8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 18:04:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEGED-0007lQ-F3
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 18:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732230287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGxfBZcE5SDWQnpM5AgtDO/BbDxAKd8X5wIGjf8eGqQ=;
 b=JM8vPG7BdcSjkvD6oxmmAUwbkq0x+jPg+c//1wVsWgiGfwkly1jBGvXKf9PAI2GP0u5OGe
 94ewwjzrMPMidH+uXepnxFuLvVyhKDeM1YPCH4Ec1/kxsrJUjInJItCg/tGbZZg9cOKL60
 veA/ps7mNb6IZxOF9XPZLsLASz4K4rs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-6_IUiD2tNLyXuibhzAgKKQ-1; Thu, 21 Nov 2024 18:04:46 -0500
X-MC-Unique: 6_IUiD2tNLyXuibhzAgKKQ-1
X-Mimecast-MFC-AGG-ID: 6_IUiD2tNLyXuibhzAgKKQ
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a6b7974696so18478345ab.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 15:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732230285; x=1732835085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGxfBZcE5SDWQnpM5AgtDO/BbDxAKd8X5wIGjf8eGqQ=;
 b=iEeeYx+SAogJaywhD7Nq7Xc4Feam/g6AMdnc1VHLWMzycWq1n8hODMmULsnzUho8Wp
 aPT+n44RrO9EePWhrGNWt9BNU8C0JntLp6L9RzMrJV7PnjcjC54NUdpWJf/ZjycQ4+oK
 Z1jukMy8NMci3hcUw+6IJOx0QJ1SmHz4P9z4iTz5KqGXwXSrOOQVJJMg9DgZMYvgEDaM
 kTnrS4/InYtneQ5OWRUWLg8xW46jzimyoJTuLs2oeYpdYBH1G3a2SkH0oI5xUTS7/Ysu
 nIhejO/ejdgJCauwPrF2zTjig9EJF3Q5hXg1ZDEyycU3tJzXVx4jWXX1so0Kzs9JgpJK
 Yh6w==
X-Gm-Message-State: AOJu0YwMd5Xbr+SnuDieOc6y3OngUQuNpHUxlYYcEgkrgmg7kUlu8tsN
 jUyjx3vliUi6WURQWFHKNhsj1tsmdyeesAmFYOb1q1+Ivxzpx5tPE8tw4IzGnU2aMiYlYW3nOiO
 8LnpPYFr3QWSJxjtgfvXn9faSPWeZcG3QXwbAp5jts1UEnVHcOCEsPmlCYx7j
X-Gm-Gg: ASbGncs/jFHeu5+I9we1uiYUYxoD5s7D0YjvpZjJSwpxr/e1l5knOf188vorhvHNXsj
 jatt4SeMqfl/XiyDKaRKLNaAEmCBA8t/ruMVBoyNZtPn2m2lKtOzrJHWHaSYw04pscms1wzL8ks
 HMFoSluDF1M7A8HYdGMRcrtoXww20fE7griza7qLnjsm0SanAqlXwYnvFnngExcyo3Bp2d1bZp6
 ftONGQI98bc6LswNJLZS0HIUiZE65/Dj/Gxt5QtR6TaJZA1QUA+sFBSYEsOlqVSs1Yi2n8Mac3c
 AGoq6QibZf0=
X-Received: by 2002:a05:6e02:184a:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a79ad10db6mr11129855ab.2.1732230283820; 
 Thu, 21 Nov 2024 15:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFLFQDlzpwqBkyK0Fh4X4T0r+r/nyP+TWmOHGGFF1hA1vDj73I4SWBP1iMT1ziex5vPwr3Og==
X-Received: by 2002:a05:6e02:184a:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a79ad10db6mr11129735ab.2.1732230283512; 
 Thu, 21 Nov 2024 15:04:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cff358dbsm339398173.147.2024.11.21.15.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 15:04:43 -0800 (PST)
Date: Thu, 21 Nov 2024 18:04:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 07/22] tests/qtest/migration: Rename migration-helpers.c
Message-ID: <Zz-8iXBl79D0F7qM@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 04:46:15PM -0300, Fabiano Rosas wrote:
> Rename migration-helpers.c to migration-util.c to make its purpose
> more explicit and avoid the "helper" terminology.
> 
> Move the file to the qtest/migration/ directory along with the rest of
> the migration files.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/meson.build                                  | 4 ++--
>  tests/qtest/migration-test.c                             | 2 +-
>  tests/qtest/migration/migration-qmp.c                    | 2 +-
>  tests/qtest/migration/migration-qmp.h                    | 2 ++
>  .../{migration-helpers.c => migration/migration-util.c}  | 4 ++--
>  .../{migration-helpers.h => migration/migration-util.h}  | 9 ++++++---
>  tests/qtest/virtio-net-failover.c                        | 2 +-
>  7 files changed, 15 insertions(+), 10 deletions(-)
>  rename tests/qtest/{migration-helpers.c => migration/migration-util.c} (99%)
>  rename tests/qtest/{migration-helpers.h => migration/migration-util.h} (89%)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index ca199b9491..b9f70ac32f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -331,9 +331,9 @@ endif
>  tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
>  
>  migration_files = [files(
> -  'migration-helpers.c',
>    'migration/bootfile.c',
>    'migration/migration-qmp.c',
> +  'migration/migration-util.c',
>  )]
>  
>  if gnutls.found()
> @@ -347,7 +347,7 @@ endif
>  qtests = {
>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
>    'cdrom-test': files('boot-sector.c'),
> -  'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
> +  'dbus-vmstate-test': files('migration/migration-qmp.c', 'migration/migration-util.c') + dbus_vmstate1,

Seems like the -qmp.c part should belong to previous patch.

>    'erst-test': files('erst-test.c'),
>    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
>    'migration-test': migration_files,
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index a0c63026ed..59f02f7815 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -22,9 +22,9 @@
>  #include "crypto/tlscredspsk.h"
>  #include "ppc-util.h"
>  
> -#include "migration-helpers.h"
>  #include "migration/bootfile.h"
>  #include "migration/migration-qmp.h"
> +#include "migration/migration-util.h"
>  #ifdef CONFIG_GNUTLS
>  # include "tests/unit/crypto-tls-psk-helpers.h"
>  # ifdef CONFIG_TASN1
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index 20be46fdf6..71b14b51b2 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -12,8 +12,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> -#include "migration-helpers.h"
>  #include "migration-qmp.h"
> +#include "migration-util.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
> diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
> index ed927cf408..caaa78722a 100644
> --- a/tests/qtest/migration/migration-qmp.h
> +++ b/tests/qtest/migration/migration-qmp.h
> @@ -2,6 +2,8 @@
>  #ifndef MIGRATION_QMP_H
>  #define MIGRATION_QMP_H
>  
> +#include "migration-util.h"
> +
>  G_GNUC_PRINTF(4, 5)
>  void migrate_qmp_fail(QTestState *who, const char *uri,
>                        const char *channels, const char *fmt, ...);
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration/migration-util.c
> similarity index 99%
> rename from tests/qtest/migration-helpers.c
> rename to tests/qtest/migration/migration-util.c
> index 218ee4e59f..8a974ded22 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -1,5 +1,5 @@
>  /*
> - * QTest migration helpers
> + * QTest migration utilities
>   *
>   * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
>   *   based on the vhost-user-test.c that is:
> @@ -19,8 +19,8 @@
>  #include "qemu/cutils.h"
>  #include "qemu/memalign.h"
>  
> -#include "migration-helpers.h"
>  #include "migration/bootfile.h"
> +#include "migration/migration-util.h"
>  
>  static char *SocketAddress_to_str(SocketAddress *addr)
>  {
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration/migration-util.h
> similarity index 89%
> rename from tests/qtest/migration-helpers.h
> rename to tests/qtest/migration/migration-util.h
> index 2cb1f78d9e..de1bc0ad0c 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration/migration-util.h
> @@ -10,11 +10,14 @@
>   *
>   */
>  
> -#ifndef MIGRATION_HELPERS_H
> -#define MIGRATION_HELPERS_H
> +#ifndef MIGRATION_UTIL_H
> +#define MIGRATION_UTIL_H
>  
>  #include "libqtest.h"
>  
> +#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
> +#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"

Are these re-defined in migration-test.c?

> +
>  typedef struct QTestMigrationState {
>      bool stop_seen;
>      bool resume_seen;
> @@ -51,4 +54,4 @@ void migration_test_add(const char *path, void (*fn)(void));
>  char *migrate_get_connect_uri(QTestState *who);
>  void migrate_set_ports(QTestState *to, QList *channel_list);
>  
> -#endif /* MIGRATION_HELPERS_H */
> +#endif /* MIGRATION_UTIL_H */
> diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
> index 28a6147d9a..08365ffa11 100644
> --- a/tests/qtest/virtio-net-failover.c
> +++ b/tests/qtest/virtio-net-failover.c
> @@ -11,8 +11,8 @@
>  #include "libqtest.h"
>  #include "libqos/pci.h"
>  #include "libqos/pci-pc.h"
> -#include "migration-helpers.h"
>  #include "migration/migration-qmp.h"
> +#include "migration/migration-util.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qjson.h"
> -- 
> 2.35.3
> 

-- 
Peter Xu


