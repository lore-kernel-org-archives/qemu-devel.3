Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A98DCF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkJyY-0002qb-HG; Mon, 26 Jan 2026 05:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJyH-0002iW-BJ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:37:30 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJyF-00034z-6D
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:37:25 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8860d6251bso397342466b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 02:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769423841; cv=none;
 d=google.com; s=arc-20240605;
 b=VZdnKujXy6xkgUT9VH1SmxvS3scUpN1PeXXZi55/0Izfx8deXPCxYu1fJMWzsYBemu
 hUk/x0v/iJA1DOw2ZAsj5RzTSbcRLLp3a47owyRa6UGI4L4ID70Y3vm7AcfDamF+OeQ6
 oA2zZe/J78ZPvtt2aPnagTI6ydA5qzv/H9dTTVn1EOroKHhWdKs1aVm7L/ukkbnGyHUJ
 9lGiEJaTZ5zTqSQ/H5FAXmrOo5Q1fCnPZXOj/lAgZnhaRLqlXX8tyOrhmJ9ZJkZQsDNd
 Xf/gMQccP37e/Mxuks1aN/515vuZXec2BMgZJSXosYAgRod7LzN/NV6qG37FbBH64CmF
 uCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=plVjL1fWAD6PfksYF+4Ny5cPMp+X+IM5+Z4KoeQFkDk=;
 fh=s6dmwFxEl8RL676PKCJOnauEIPRhU6KyHPQEOwBNEQQ=;
 b=VPKkACnTGLrh6y/fNG+TubgykpJ9H0M4E7xv0DZuOgL+22aMsB0uCuAhfHTeCpYlGZ
 gHOUegdMf4ULt4UpFg5GTAa8tX0UKpZAJtm/J7NtYVmE9oz3UQUR7bAKYD3/jY8RQ8UU
 aiEVWL3Ue5Q0oPjePSAsn6MGDq+zOzA72v3SPNBknHmyyoXm5un0i487V3mHaXhHIHlY
 hfGhdl+u+aG76tgS1l2k9R+YJPFXwufSBz6kCGdhn373zFGV8qI2OE1Ke3SO0o3KYqIK
 y2Pl+zEdyaifBIOfABKEo0NzZvVUdbbD/PfDMqiMilib8IO2DkBwHlfbABD4efME3WYQ
 toTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769423841; x=1770028641; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plVjL1fWAD6PfksYF+4Ny5cPMp+X+IM5+Z4KoeQFkDk=;
 b=kcs/L+jWjxfSnwvkuqEEXEV4chjsJuZzvBFDamKHq5zqOLqa3S6ZJaJzmlLDFL7c7u
 I41MIVPwRwECxQjws5hKZvcBtJgy2fYzu9/jhOns2xX0phW6ai/Pcwwao8RrrkFjkZra
 CB9uZh/a84Bc1ZRGeuUYB0MWuyHV6PCtoNC3k1bYal0F1P5rXPk/aoHvXknHbpdEQNzi
 ghGqLtRg1tFRCrpNYODSWsliwa7xWQTyLqfztDg4b/R/Uj3aHJehOj46bPyAQ8par1Rm
 Ne1oplKYCJas3Ecz2lts8L2RyUDxOlVI45LXRsYDwNG/16uzkx86UpNMMcO0GHmYYS7J
 bYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769423841; x=1770028641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plVjL1fWAD6PfksYF+4Ny5cPMp+X+IM5+Z4KoeQFkDk=;
 b=NXk0qyqry2wH5bp7ZXmz6tibdWagJ0My6qyAUmR62n1niJ6RqkbjXogoioUfcO6vmz
 xyXQHXANKSLWvSLhL6bXLKs8aFUz7o7nFCaPsf4PLX6mTJlOX9is/KbauwjGTeI87Aly
 TQUl3eGIXDz2mL3If0st8kNtV8JrheJQU1y6zM1hKfhq1jbcrvl51jhhneV4gpmoqJk3
 KFuYFyHfxXPDG7V26Az7JeLTeqgnjB9n2KrVNt39H5IE2E3I2OGYfA/modwIGDPquQ8r
 j1AhZWGUwCPyzwFSTXfVdAJrmrDCLxFUx/MFlXzmOM0YXfknfiC2XWnt9+RIVOVYQydm
 kXoQ==
X-Gm-Message-State: AOJu0Yy1xlsbqvOgFjZ/2kLeU+p8zjDK5ijcl4DMav1+p9sODr0iFNMb
 jCZdpjLoEFjs6IBBdbjHU1r8BuDBKkbK13bUQ6F5AfiyqDLGuxQQVgccTfsLh/q/klwYpEEOEIv
 ZLUH55ds4kszlBymU9WTA9sNMSBcw+pE=
X-Gm-Gg: AZuq6aLajCJedBldC+tIgMeaWoK33PKIk1P0mjsvdvnIMQqTt76gOhdy6es5YcFyTA0
 /XmlTzhdWnSLnHptsh5RHdskQZuOjeDIvwK9IdQS5A8S+/hJXWK3bPGXC6Nc1Ul/m4KnwlyY0nA
 Ftl75vSfANf8ouo3mjdAqf1ogc9dkKhlNPMs3IlCA8LxUjTwL8kHci4GOPoLJLgp1GT8QQQzTwA
 fTRKC5Q2stc1ko6JEDctzYZE+QxRLHtZt6v0aEeUdK2+LqnMxydgtrTsFkxuTHYIBojbfhQ
X-Received: by 2002:a17:907:782:b0:b87:34e3:a79e with SMTP id
 a640c23a62f3a-b8d20da0986mr247626166b.12.1769423840350; Mon, 26 Jan 2026
 02:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 26 Jan 2026 18:36:39 +0800
X-Gm-Features: AZwV_QiKAB23DrH8N8CGSo19YXmwotdfBkPVdMm75yHKnbhg0HzL1CIfIbbbWHk
Message-ID: <CAK3tnv+uzkmetL443GW3KZPkH9UoVCeqLLtZCND1P02qi==CPg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Juan Quintela <quintela@trasno.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 26, 2026 at 4:40=E2=80=AFAM Lukas Straub <lukasstraub2@web.de> =
wrote:
>
> Like in the normal ram_load() path, put the received pages into the
> colo cache and mark the pages in the bitmap so that they will be
> flushed to the guest later.
>
> Multifd with COLO is useful to reduce the VM pause time during checkpoint=
ing
> for latency sensitive workloads. In such workloads the worst-case latency
> is especially important.
>
> Also, this is already worth it for the precopy phase as it helps with
> converging. Moreover, multifd migration is the preferred way to do migrat=
ion
> nowadays and this allows to use multifd compression with COLO.
>
> Benchmark:
> Cluster nodes
>  - Intel Xenon E5-2630 v3
>  - 48Gb RAM
>  - 10G Ethernet
> Guest
>  - Windows Server 2016
>  - 6Gb RAM
>  - 4 cores
> Workload
>  - Upload a file to the guest with SMB to simulate moderate
>    memory dirtying
>  - Measure the memory transfer time portion of each checkpoint
>  - 600ms COLO checkpoint interval
>
> Results
> Plain
>  idle mean: 4.50ms 99per: 10.33ms
>  load mean: 24.30ms 99per: 78.05ms
> Multifd-4
>  idle mean: 6.48ms 99per: 10.41ms
>  load mean: 14.12ms 99per: 31.27ms
>
> Evaluation
> While multifd has slightly higher latency when the guest idles, it is
> 10ms faster under load and more importantly it's worst case latency is
> less than 1/2 of plain under load as can be seen in the 99. Percentile.
>

Why the multifd get higher latency when the guest idles?  The status same
with normal live migration? Where is the time spent? The Sorry, I
don't know this background yet.

Thanks
Chen

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS                |  1 +
>  migration/meson.build      |  2 +-
>  migration/multifd-colo.c   | 50 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  migration/multifd-colo.h   | 26 ++++++++++++++++++++++++
>  migration/multifd-nocomp.c | 10 +++++++++-
>  migration/multifd.c        |  8 ++++++++
>  migration/multifd.h        |  5 ++++-
>  7 files changed, 99 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e9bdd87c3a2f84f3abfc56986cd793976810fdd..883f0a8f4eb92d0bf0f89fcab=
4674ccc4aed1cc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3853,6 +3853,7 @@ COLO Framework
>  M: Lukas Straub <lukasstraub2@web.de>
>  S: Maintained
>  F: migration/colo*
> +F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
>  F: docs/COLO-FT.txt
> diff --git a/migration/meson.build b/migration/meson.build
> index c7f39bdb55239ecb0e775c77b90a1aa9e6a4a9ce..c9f0f5f9f2137536497e53e96=
0ce70654ad1b394 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -39,7 +39,7 @@ system_ss.add(files(
>  ), gnutls, zlib)
>
>  if get_option('replication').allowed()
> -  system_ss.add(files('colo-failover.c', 'colo.c'))
> +  system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
>  else
>    system_ss.add(files('colo-stubs.c'))
>  endif
> diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c47f5044663969e0c9af56da5=
ec34902d635810a
> --- /dev/null
> +++ b/migration/multifd-colo.c
> @@ -0,0 +1,50 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * multifd colo implementation
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/target_page.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "ram.h"
> +#include "multifd.h"
> +#include "options.h"
> +#include "io/channel-socket.h"
> +#include "migration/colo.h"
> +#include "multifd-colo.h"
> +#include "system/ramblock.h"
> +
> +void multifd_colo_prepare_recv(MultiFDRecvParams *p)
> +{
> +    /*
> +     * While we're still in precopy state (not yet in colo state), we co=
py
> +     * received pages to both guest and cache. No need to set dirty bits=
,
> +     * since guest and cache memory are in sync.
> +     */
> +    if (migration_incoming_in_colo_state()) {
> +        colo_record_bitmap(p->block, p->normal, p->normal_num);
> +        colo_record_bitmap(p->block, p->zero, p->zero_num);
> +    }
> +}
> +
> +void multifd_colo_process_recv(MultiFDRecvParams *p)
> +{
> +    if (!migration_incoming_in_colo_state()) {
> +        for (int i =3D 0; i < p->normal_num; i++) {
> +            void *guest =3D p->block->host + p->normal[i];
> +            void *cache =3D p->host + p->normal[i];
> +            memcpy(guest, cache, multifd_ram_page_size());
> +        }
> +        for (int i =3D 0; i < p->zero_num; i++) {
> +            void *guest =3D p->block->host + p->zero[i];
> +            memset(guest, 0, multifd_ram_page_size());
> +        }
> +    }
> +}
> diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de52=
f9d57a337d4754a
> --- /dev/null
> +++ b/migration/multifd-colo.h
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * multifd colo header
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
> +#define QEMU_MIGRATION_MULTIFD_COLO_H
> +
> +#ifdef CONFIG_REPLICATION
> +
> +void multifd_colo_prepare_recv(MultiFDRecvParams *p);
> +void multifd_colo_process_recv(MultiFDRecvParams *p);
> +
> +#else
> +
> +static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
> +static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
> +
> +#endif
> +#endif
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc30b971b35=
f464103a61787f0 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -16,6 +16,7 @@
>  #include "file.h"
>  #include "migration-stats.h"
>  #include "multifd.h"
> +#include "multifd-colo.h"
>  #include "options.h"
>  #include "migration.h"
>  #include "qapi/error.h"
> @@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, E=
rror **errp)
>          return -1;
>      }
>
> -    p->host =3D p->block->host;
>      for (i =3D 0; i < p->normal_num; i++) {
>          uint64_t offset =3D be64_to_cpu(packet->offset[i]);
>
> @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, =
Error **errp)
>          p->zero[i] =3D offset;
>      }
>
> +    if (migrate_colo()) {
> +        multifd_colo_prepare_recv(p);
> +        assert(p->block->colo_cache);
> +        p->host =3D p->block->colo_cache;
> +    } else {
> +        p->host =3D p->block->host;
> +    }
> +
>      return 0;
>  }
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 332e6fc58053462419f3171f6c320ac37648ef7b..220ed8564960fdabc58e4baa0=
69dd252c8ad293c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -29,6 +29,7 @@
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "multifd.h"
> +#include "multifd-colo.h"
>  #include "options.h"
>  #include "qemu/yank.h"
>  #include "io/channel-file.h"
> @@ -1258,6 +1259,13 @@ static int multifd_ram_state_recv(MultiFDRecvParam=
s *p, Error **errp)
>      int ret;
>
>      ret =3D multifd_recv_state->ops->recv(p, errp);
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    if (migrate_colo()) {
> +        multifd_colo_process_recv(p);
> +    }
>
>      return ret;
>  }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 89a395aef2b09a6762c45b5361e0ab63256feff6..fbc35702b062fdc3213ce92ba=
ed35994f5967c2b 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -279,7 +279,10 @@ typedef struct {
>      uint64_t packets_recved;
>      /* ramblock */
>      RAMBlock *block;
> -    /* ramblock host address */
> +    /*
> +     * Normally, it points to ramblock's host address.  When COLO
> +     * is enabled, it points to the mirror cache for the ramblock.
> +     */
>      uint8_t *host;
>      /* buffers to recv */
>      struct iovec *iov;
>
> --
> 2.39.5
>

