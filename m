Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD6AC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 15:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhVY2-00035R-7p; Thu, 31 Jul 2025 11:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uhUL2-0000nB-Uo
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uhUL1-0001Qa-4h
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753972372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GS58p15v4LEFq1xCqc+ivjhqpqgBtFNMAu+jgQ/nfmw=;
 b=JZkJZaxGn/gugnpHYpf09SSvu56tto+l7hVh+AvEph49PgJcZ5lqjTNjb51Th6M7/E84uj
 Jdu86wEEFirP2gcRt3aM5MnYC5WV4CItMTXMPTAuqBiXWjKGxjZcAUV5SJ912bUYtH/O5J
 kGduv7FnWUhC5E8tqB1AamWQb7799hA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ziA_dGbqNduFFN7ydRo_Gw-1; Thu, 31 Jul 2025 10:32:51 -0400
X-MC-Unique: ziA_dGbqNduFFN7ydRo_Gw-1
X-Mimecast-MFC-AGG-ID: ziA_dGbqNduFFN7ydRo_Gw_1753972370
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3e3fa3de6bdso1492485ab.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 07:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753972370; x=1754577170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GS58p15v4LEFq1xCqc+ivjhqpqgBtFNMAu+jgQ/nfmw=;
 b=webygLXCL7noc74/T2qUlyNwI/O1+rddH5JTS99xJtDe77PuNLxp3ZHWD3ncBn1Iuy
 kNyAOcU0L12UamkPjTQzSXHDX91smH70iO+hneuXRNWc8PUIJI/yR/mqlztPIHdcouTD
 9M+VW7H4nsUz2Ch4kv/MzKa1WFEOvjs3zFkoNt3Tg4TxtwYmGpb6CjCao12nDqFR7167
 HJHqQ0qXrIbuyRsdQRo064CZ8G/I03oaHVLR39zrFj9ac7OfoWqFoNntlNdrhnDwEjxM
 XGUWWoGWzylpQLRkZY5pSVXPziDol4iQ8X4qBkDyPl+hBPBZg6tg1ZZTcjTmjlVkgekB
 xIxQ==
X-Gm-Message-State: AOJu0YxYYMGJjciBAuIYAwcB1IGHf4sAUuHW6f9FiI/WEoVlYQZxX5I0
 B/f59sjGwDjz8HYkbCOWvNq6ygCztnvcX88HUhj0MpfuIbbRsk9P20PTHNuulg7v369EbUzxMlu
 QgFBnTU020AOavXFo2N3seMrGD6YY9LkPUErVpkmPca6f5mBHVOJxwplvVzpwsniI
X-Gm-Gg: ASbGncv4toO8KkEYXRx6JlFPrrlKx+xfN1J0JUjCAXLfAbxG9/bMJkht6O1NlBfQ/GK
 WtrSjQnUM1FoWrcFCenratVdI1rJqmvd6zC8LjO03WG7nQs1OXY8HpCneyibs4Xa2ubCOlRptDl
 y+oCdOCexOZacRu2h6ZA2XmVF6zUl9q+J+CF0SMeqQEAJ9R4jGb8Ccmrfi6MhEgRMAkdllh2mdq
 URC5XIdAA40nkP05nGO9YXEsj4Er3dAdYeQXXgzLPb0UDxeiglUtPCtwAyxfE/YJkMCA17LRXjj
 bTcQEKH3+1rN+XmYmIIbYTxIgCTb8Q5Ofyebrb/A+gs=
X-Received: by 2002:a05:6e02:4407:10b0:3e3:d517:d29d with SMTP id
 e9e14a558f8ab-3e3f629ccf7mr24134435ab.5.1753972369681; 
 Thu, 31 Jul 2025 07:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzgCXpVq9Gtf3sxxi1PC+Tl5R64QIGk0mtbDiiNBrerbYdB+2oT3xeFIWqEK3AM1vj9gvzxw==
X-Received: by 2002:a05:6e02:4407:10b0:3e3:d517:d29d with SMTP id
 e9e14a558f8ab-3e3f629ccf7mr24134315ab.5.1753972369321; 
 Thu, 31 Jul 2025 07:32:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a55dbb039sm520356173.94.2025.07.31.07.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 07:32:48 -0700 (PDT)
Date: Thu, 31 Jul 2025 08:32:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-10.2 0/4] vfio: Remove 'vfio-platform'
Message-ID: <20250731083245.0aa1c6e4.alex.williamson@redhat.com>
In-Reply-To: <20250731121947.1346927-1-clg@redhat.com>
References: <20250731121947.1346927-1-clg@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 31 Jul 2025 14:19:43 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Hello,=20
>=20
> The VFIO_PLATFORM device type has been deprecated in the QEMU 10.0
> timeframe. QEMU 10.2 is the time for removal.
>=20
> The last patch moves vfio-region.h under hw/vfio since it no longer
> needs to be a public VFIO interface.
>=20
> Thanks,
>=20
> C.
>=20
>=20
> C=C3=A9dric Le Goater (4):
>   vfio: Remove 'vfio-amd-xgbe' device
>   vfio: Remove 'vfio-calxeda-xgmac' device
>   vfio: Remove 'vfio-platform'
>   vfio: Move vfio-region.h under hw/vfio/
>=20
>  docs/about/deprecated.rst             |  25 -
>  docs/about/removed-features.rst       |  25 +
>  docs/devel/kconfig.rst                |   2 -
>  {include/hw =3D> hw}/vfio/vfio-region.h |   0
>  include/hw/vfio/vfio-amd-xgbe.h       |  46 --
>  include/hw/vfio/vfio-calxeda-xgmac.h  |  43 --
>  include/hw/vfio/vfio-device.h         |   2 +-
>  include/hw/vfio/vfio-platform.h       |  78 ---
>  hw/arm/virt.c                         |   5 -
>  hw/core/sysbus-fdt.c                  | 383 --------------
>  hw/vfio/amd-xgbe.c                    |  61 ---
>  hw/vfio/calxeda-xgmac.c               |  61 ---
>  hw/vfio/platform.c                    | 716 --------------------------
>  hw/arm/Kconfig                        |   3 -
>  hw/vfio/Kconfig                       |  16 -
>  hw/vfio/meson.build                   |   3 -
>  hw/vfio/trace-events                  |  11 -
>  17 files changed, 26 insertions(+), 1454 deletions(-)
>  rename {include/hw =3D> hw}/vfio/vfio-region.h (100%)
>  delete mode 100644 include/hw/vfio/vfio-amd-xgbe.h
>  delete mode 100644 include/hw/vfio/vfio-calxeda-xgmac.h
>  delete mode 100644 include/hw/vfio/vfio-platform.h
>  delete mode 100644 hw/vfio/amd-xgbe.c
>  delete mode 100644 hw/vfio/calxeda-xgmac.c
>  delete mode 100644 hw/vfio/platform.c
>=20

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


