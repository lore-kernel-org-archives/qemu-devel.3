Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8188DC35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1turvJ-00008o-2n; Wed, 19 Mar 2025 07:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1turvG-00008M-RV
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1turvD-0003CZ-9L
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742384956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbLFFzGTI7317sIsZ449FROcg+qo6KC3pM78lNmzHxA=;
 b=QHLLymkBjmEq6jlTxwKn1PGeVu9ok4R+ba1X5NfkbBUuuqmsG2nxipUKEbfZSQJFv6ISjo
 zP65nYTlxkRjNHURumj6ACKzackVQ5lv8XC8wLHkpEiDKnAfKCUjxHf8LJmiGhQByH84e1
 WShg3HiqRZhk2ZZv3xt3aZQzF4QVpvs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-33g3V57OOCuAp2CLE9Ne2w-1; Wed, 19 Mar 2025 07:49:15 -0400
X-MC-Unique: 33g3V57OOCuAp2CLE9Ne2w-1
X-Mimecast-MFC-AGG-ID: 33g3V57OOCuAp2CLE9Ne2w_1742384954
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so28952825e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 04:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742384952; x=1742989752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbLFFzGTI7317sIsZ449FROcg+qo6KC3pM78lNmzHxA=;
 b=QKO2k5twzSGOA5pf6aGh+Tu4hpbvLZGrhKOy4o7Db8h4XR7rgdtxOw4y9zi3kXvmWO
 7cgupoR8QzjCz0ekMUOc1TFXXWpRnu1XC830p0BtVRtY7aj/O+1yuyaDeaBVWrtHsynh
 CaV9Xj8cGQjPk8F26RzRHxzoQfmG5kW8Hb3HhYE+S5uDON1h3OPLeEVS37BXb9hdWikH
 JfaWlb8o3Vm2DLHxLoNnevAQuL+Q/Fzw4P2ZGhQPtGQPWpZnvAd85oLcRVxl7q0JRSZF
 Lu+bu8Kp3Xn7W55WX0w1zCi934Nl1FW77mSoO/NeqjCKDEPDk33doHetUHWIcuP71Hih
 427g==
X-Gm-Message-State: AOJu0YxMGXq7HweHTohzPwuXTzk8hewX/d3fZj9+mdLCJ14eo86RODAn
 5sBsv1G4BFEkRfyOJBchZK6l8YicHqHvXLh+G+cESsPtShH2EsVerqjrNcVDS2ulv7TtPg/SDwr
 EUqLZYBaC3e44oGqkMJfnVG7GGOodq6KRRLFhMCrrSN83jSdtFEQuK5q7FWEAiiZJhn/MpQpXgH
 bFQm44vHRF9tF+uWcvG0C5O97yzZs=
X-Gm-Gg: ASbGncuOoxq5Z3Ly4BxVbVcSfGDwpY1Z2n0Tp7iN7jvWLwmCzYBzInTOZeAdOhp/Sg3
 Qm4rhf6sGo0WDyOf1V9bFbY+zqELCINFddZUHZHYQS9Da/UIU21JMteUWN9xaf3FOp+IfBfO2w/
 4=
X-Received: by 2002:a05:600c:1e0d:b0:43d:738:4a9 with SMTP id
 5b1f17b1804b1-43d4383d921mr18258635e9.27.1742384951572; 
 Wed, 19 Mar 2025 04:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE63zpIpXeibslo/feIlrr3cIbkgHyEGUFp8ZyWz3or8BmCFQ76r6j/0Wyx3k6J9cVivvJRCOCjmDXJrZk5g2c=
X-Received: by 2002:a05:600c:1e0d:b0:43d:738:4a9 with SMTP id
 5b1f17b1804b1-43d4383d921mr18258365e9.27.1742384951124; Wed, 19 Mar 2025
 04:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-4-clg@redhat.com>
In-Reply-To: <20250318095415.670319-4-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 19 Mar 2025 17:18:54 +0530
X-Gm-Features: AQ5f1JoH_f78pGBM4Pt8XQsGUaf9NpVdzmWxPM5j5h-lVxCNEroF9TKD0U-VtHY
Message-ID: <CAE8KmOzvhnEBX0NRECfahgNttuH8df0eVvNJWdtv-=3dQ6zMjQ@mail.gmail.com>
Subject: Re: [PATCH for-10.1 03/32] vfio: Introduce a new header file for
 external migration services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, 18 Mar 2025 at 15:29, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> The migration core subsytem makes uses of the VFIO migration API to

* subsytem -> subsystem
* uses -> use

> collect statistics on the number of bytes transferred.

* statistics on the bytes transferred  (number of seems redundant)  OR
 statistics of bytes transferred.

> These services are declared in "hw/vfio/vfio-common.h" which also
> contains VFIO internal declarations. Move the migration declarations
> into a new header file "hw/vfio/vfio-migration.h" to reduce the exposure
> of VFIO internals.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h    |  4 ----
>  include/hw/vfio/vfio-migration.h | 17 +++++++++++++++++
>  hw/vfio/migration-multifd.c      |  1 +
>  hw/vfio/migration.c              |  1 +
>  migration/target.c               |  2 +-
>  5 files changed, 20 insertions(+), 5 deletions(-)
>  create mode 100644 include/hw/vfio/vfio-migration.h
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc..5fc7ee76573375bc8464baee2=
9ab88974fac3d3b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -290,13 +290,9 @@ extern VFIODeviceList vfio_device_list;
>  extern const MemoryListener vfio_memory_listener;
>  extern int vfio_kvm_device_fd;
>
> -bool vfio_mig_active(void);
>  int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **=
errp);
>  void vfio_unblock_multiple_devices_migration(void);
>  bool vfio_viommu_preset(VFIODevice *vbasedev);
> -int64_t vfio_mig_bytes_transferred(void);
> -void vfio_mig_reset_bytes_transferred(void);
> -void vfio_mig_add_bytes_transferred(unsigned long val);
>  bool vfio_device_state_is_running(VFIODevice *vbasedev);
>  bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>
> diff --git a/include/hw/vfio/vfio-migration.h b/include/hw/vfio/vfio-migr=
ation.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..259c532f64bdd002d512375df=
3140f291a0ade85
> --- /dev/null
> +++ b/include/hw/vfio/vfio-migration.h
> @@ -0,0 +1,17 @@
> +/*
> + * VFIO migration interface
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_MIGRATION_H
> +#define HW_VFIO_VFIO_MIGRATION_H
> +
> +bool vfio_mig_active(void);
> +int64_t vfio_mig_bytes_transferred(void);
> +void vfio_mig_reset_bytes_transferred(void);
> +void vfio_mig_add_bytes_transferred(unsigned long val);
> +
> +#endif /* HW_VFIO_VFIO_MIGRATION_H */
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 378f6f3bf01f6a4155fb424f8028cb5380f27f02..fe84735ec2c7bd085820d25c0=
6be558761fbe0d5 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -11,6 +11,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>  #include "migration/misc.h"
>  #include "qapi/error.h"
>  #include "qemu/bswap.h"
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 8bf65b8e11094b8363692dba3084b762362c7dd6..75096377ffecf62b3bab91102=
a00d723827ea4c7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -17,6 +17,7 @@
>
>  #include "system/runstate.h"
>  #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>  #include "migration/misc.h"
>  #include "migration/savevm.h"
>  #include "migration/vmstate.h"
> diff --git a/migration/target.c b/migration/target.c
> index f5d8cfe7c2a3473f4bd3f5068145598c60973c58..e1eacd1db7a471cba51b4e257=
a834eb7581f9671 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -11,7 +11,7 @@
>  #include CONFIG_DEVICES
>
>  #ifdef CONFIG_VFIO
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>  #endif
>
>  #ifdef CONFIG_VFIO
> --
> 2.48.1

* Looks okay. With above text corrections, reviewed by:  Prasad Pandit
<pjp@fedoraproject.org>

Thank you.
---
  - Prasad


