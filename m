Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A51CC02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZkB-0007DJ-B6; Thu, 30 Jan 2025 13:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdZk1-0007BO-72
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdZjx-0008Qa-OB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738263488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbK9vwqLWrTpBm/q1NamW65yYjkj4zjMTER9z96M2ok=;
 b=fWgCm60Fo44YN9RUiSmyeswb7d3bfkGwT/nYgMmCxhranezp8dQlg5NUq+pG99TauHkcvZ
 02StXbzZc0Le0TO0eIFo1bdFpvrfPBdt2HkaBx5Kvhf1udYxquQm6t3bhl+Yxp8ml+JLOk
 XiuDK1vsjxdAxjk5FSAggaonrer0FXA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-0Fx72o4ZM-2eL35wfZItrQ-1; Thu, 30 Jan 2025 13:58:05 -0500
X-MC-Unique: 0Fx72o4ZM-2eL35wfZItrQ-1
X-Mimecast-MFC-AGG-ID: 0Fx72o4ZM-2eL35wfZItrQ
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5f31e3b6dacso150421eaf.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738263485; x=1738868285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbK9vwqLWrTpBm/q1NamW65yYjkj4zjMTER9z96M2ok=;
 b=OsPgEGB6urWuKf7RngvAVK0LYJ1g+2gI9CEnmWFDJFngheHm41fCSTBbLKN1L7P+mN
 WeD8c/tgenhCLGUY7/X/7WKfL7TXiOlIgPtv0trPjd6ArPiBwO5/+JeOyZNoqpRzW2yN
 NM98DpzZVBfgjZ7wxvPweg84+OVG+ci0nDOjz2eZAzG5OVCdbGlrW3pZGMKKRDD3WAev
 sgi0BQ8NDyLG/7OapuBakjAvjJm5EPXPR1J7FbUdoatc9BDCVej7sHbFM/8kbpF38iIf
 xSKqi1k6GNYZLosAEegONjmMF8TxtotNbnWwJ8c0pYDaZ7i8mq+1E+ScA3c3ybTsjeSM
 FZzA==
X-Gm-Message-State: AOJu0YyOLF82zQpfE/caSEjGqRN9tHj2i7tVx/2sakwq0NEUPeVvP9GB
 QgGegwNnxVzft3nqo1ZDeDVLqDOUvaXEKUrqvFErVYAbR7zBUPHsxv03/hv8s2ODEejVVGqtSQT
 S8HLN+SEUOBH3f1YPCEETPCjGpu1PcrCkoqok7i5dP9wguAKHyFGA
X-Gm-Gg: ASbGnctf5RZ93yGmdvoiS6I4XHeZazfL4lTTDNov1n2okr91hYXV6gLe+4mA+sL9Jl7
 eqJJ7df29Tx971oBM3SrERFDrmvfS2nbhK0t1PkXyRaDMEpxbpsk3L82C7vPzKVNfV/d5gsBXHF
 Xxo4IX6b7Rv15BqBQy6HS8s7TVY1Nz0qtg5jVTuf600PtVODUAw349cKgJNCdUAn9st06CHKfLo
 HYer4bBetX7LjbidvRQ8PqIInGBd7HdxVYJjm1x5SMqIrMQr1oXYAo01gBjrJykgjKX/z95F0eS
 10rzMaZp
X-Received: by 2002:a05:6871:331f:b0:29e:79ce:933a with SMTP id
 586e51a60fabf-2b3508af7b9mr1202498fac.12.1738263484987; 
 Thu, 30 Jan 2025 10:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgCH9PNKPmRIlDStmlPdr6KjNlq2ij1WGcMdNC82yvqC3xD31XwmTXVnCJMWSW5EmDj06ZVA==
X-Received: by 2002:a05:6871:331f:b0:29e:79ce:933a with SMTP id
 586e51a60fabf-2b3508af7b9mr1202491fac.12.1738263484524; 
 Thu, 30 Jan 2025 10:58:04 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b3565b895fsm564501fac.33.2025.01.30.10.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:58:04 -0800 (PST)
Date: Thu, 30 Jan 2025 11:58:00 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU
 address space width
Message-ID: <20250130115800.60b7cbe6.alex.williamson@redhat.com>
In-Reply-To: <20250130134346.1754143-9-clg@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 30 Jan 2025 14:43:45 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Print a warning if IOMMU address space width is smaller than the
> physical address width. In this case, PCI peer-to-peer transactions on
> BARs are not supported and failures of device MMIO regions are to be
> expected.
>=20
> This can occur with the 39-bit IOMMU address space width as found on
> consumer grade processors or when using a vIOMMU device with default
> settings.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/common.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5c9d8657d746ce30af5ae8f9122101e086a61ef5..e5ef93c589b2bed68f7906088=
68ec3c7779d4cb8 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -44,6 +44,8 @@
>  #include "migration/qemu-file.h"
>  #include "system/tpm.h"
> =20
> +#include "hw/core/cpu.h"
> +
>  VFIODeviceList vfio_device_list =3D
>      QLIST_HEAD_INITIALIZER(vfio_device_list);
>  static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =3D
> @@ -1546,12 +1548,28 @@ retry:
>      return info;
>  }
> =20
> +static bool vfio_device_check_address_space(VFIODevice *vbasedev, Error =
**errp)
> +{
> +    uint32_t cpu_aw_bits =3D cpu_get_phys_bits(first_cpu);
> +    uint32_t iommu_aw_bits =3D vfio_device_get_aw_bits(vbasedev);
> +
> +    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) {

Should we be testing the 64-bit MMIO window and maximum RAM GPA rather
than the vCPU physical address width?

Maybe we're just stuck with an indirect solution currently.  AIUI,
we're testing the vCPU physical address width because (obviously) all
devices and memory need to be addressable within that address space.
However, as we've explored offline, there are bare metal systems where
the CPU physical address width exceeds the IOMMU address width and this
is not a fundamental problem.  It places restrictions on the maximum
RAM physical address and the location of the 64-bit MMIO space.

RAM tends not to be a problem on these bare metal systems since they
physically cannot hold enough RAM to exceed the IOMMU width and, for
the most part, we map RAM starting from the bottom of the address
space.  So long as the VMM doesn't decide to map RAM at the top of the
physical address space, this doesn't become a problem.

However, we've decided to do exactly that for the 64-bit MMIO window.
It's not that the vCPU width being greater than the IOMMU width is a
fundamental problem, it's that we've chosen a 64-bit MMIO policy that
makes this become a problem and QEMU only has a convenient mechanism to
check the host IOMMU width when a vfio device is present.  Arguably,
when a vIOMMU is present guest firmware should be enlightened to
understand the address width of that vIOMMU when placing the 64-bit
MMIO window.  I'd say the failure to do so is a current firmware bug.

If the vIOMMU address width were honored, we could recommend users set
that to match the host, regardless of the vCPU physical address width.
We also already have a failure condition if the vIOMMU address width
exceeds the vfio-device (ie. indirectly the host) IOMMU width.

Of course without a vIOMMU, given our 64-bit MMIO policy, we don't have
a good solution without specifying the 64-bit window or implementing a
more conservative placement.

Not sure how much of this is immediately solvable and some indication
to the user how they can resolve the issue, such as implemented here, is
better than none, but maybe we can elaborate in a comment that this is
really more of a workaround for the current behavior of firmware
relative to the 64-bit MMIO placement policy.  Thanks,

Alex

> +        error_setg(errp, "Host physical address space (%u) is larger tha=
n "
> +                   "the host IOMMU address space (%u).", cpu_aw_bits,
> +                   iommu_aw_bits);
> +        vfio_device_error_append(vbasedev, errp);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                          AddressSpace *as, Error **errp)
>  {
>      const VFIOIOMMUClass *ops =3D
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>      HostIOMMUDevice *hiod =3D NULL;
> +    Error *local_err =3D NULL;
> =20
>      if (vbasedev->iommufd) {
>          ops =3D VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IO=
MMUFD));
> @@ -1571,6 +1589,9 @@ bool vfio_attach_device(char *name, VFIODevice *vba=
sedev,
>          return false;
>      }
> =20
> +    if (!vfio_device_check_address_space(vbasedev, &local_err)) {
> +        warn_report_err(local_err);
> +    }
>      return true;
>  }
> =20


