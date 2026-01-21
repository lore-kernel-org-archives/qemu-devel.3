Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC778C44525
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXZu-0005DN-PO; Wed, 21 Jan 2026 07:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viXS0-0000Us-Q1
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viXRy-0004YV-4G
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768999000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FliO+0+N6yK98z0Fg6EgwNxlGjUJONnnw/NVFutu8WU=;
 b=dyldfiQYLIWo7PNJZVceia8f30wXsNmOIgls81B72zYIChB1B5ozaHoByMoKZX+0lGobir
 GEKLM8IL3TEZAyV/7TI3uuXwQSUyNdtw8FP3X4KaxMx4GdZUtCrg/h7UUkRbgo67if9KCT
 y2K+DeINzTqEr1qvaEltLvzZs19rVL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-ZtxLmjk5Ovmjnn4gD8ZHjQ-1; Wed, 21 Jan 2026 07:36:38 -0500
X-MC-Unique: ZtxLmjk5Ovmjnn4gD8ZHjQ-1
X-Mimecast-MFC-AGG-ID: ZtxLmjk5Ovmjnn4gD8ZHjQ_1768998997
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edc79ff28so42143635e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 04:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768998997; x=1769603797; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FliO+0+N6yK98z0Fg6EgwNxlGjUJONnnw/NVFutu8WU=;
 b=TN+octmm6zisJ+mstYnBNfhVmwAsQO08u9bDQ1qK681hIHfu7FD6v/KFmNbtb6FWsN
 99svJyuiBmjx99Ljlj/nDYsAWyRmbe19doaAaYWTNeK/kDlJb2Tf1YL/NpPfSSv6y41+
 iCTSrA9biJKpMQeVN8Pu8TDEixDIlr0qGXq1jADPX6h2dAfjAkA+cuS8LpBykcuEvLY8
 b/+f73kJeVvstopZ1/a3sDHaiPtnp86AC1HjDNTdzYBaUuOWfA6AH7jAN/7PNW1CIFul
 nZyuYLmBqHNPVoGE7R3KH97fNo8OeLI1W26hGlfLD/T8JSrS/FFvZM5TiaNhplLYd5fe
 wFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768998997; x=1769603797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FliO+0+N6yK98z0Fg6EgwNxlGjUJONnnw/NVFutu8WU=;
 b=i9p8swjOBSJOfPXigUsTZ8EKywF5jrr/nmXG2Y6cKOJnR5VoOny7NNT0FCK0Q5DpxG
 BXtJTKyeOYE3guWyykHSC+2DxdahmI3VZFcYu1gsurm2MxF9HxTlGEJb9Ds4fJ2oFDfJ
 XkOtDeMe1Ei2NXD3Yn1v9hHqOXoQVdTWTToYKGWKX+97RbnoJgNbLRWGgUOtPpIVaWi6
 G04aQbTFzGbt83Cg9DNU2AcOMpU4WryGs3QAZv85MS0xxzyy+seVXIbY3TpSqkyabvkJ
 WYLnXvbyKSZmVFhHGKcikzJH0/VVaGESJ0s6wW42+gfufIF/ukzBf33bbLwRvxY+wu8b
 n3+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrzTOm6dBE19dZLKEzvI+X2IlM4A+DV/+fKHIlc6MKPaFOV3Rtnz8LfGLdxULMqHktmvFNdZJBqQtd@nongnu.org
X-Gm-Message-State: AOJu0YyPHSraWci4TId0Jl4xJ6mFkCcZkEvNfNlGa3U003iIia9jrV8l
 6Qp82jxZBm6ZzVh+Ih4Cv7vL0yrvhnu0NFXOpg3ONHX3riD9kwIzb4h9sUIiFrITPfSPyjNVFsw
 yrWk6h/JU/FR4T3BrYAAAyLhj5uMfDiWfg5L3CcTu6qEBl4xIPtxA7vIS
X-Gm-Gg: AZuq6aIOprc4zR5wFtVjXlx0uxVTVZrdIAcbZmnJAhAP3/hX2gdqxgFQHCwq3Ruw/iH
 /0/E9lWexG/rF3765KDdOaMpFFcMWZ3u2ITW76p8crSLBB/aJ5C3fPdbps1ETWdypRkGU7ncHq6
 OC6B4v9dhbvssrBPw4ZuwZaWNk9V87B0b3E6HZR3gNOi4Qq5Uowa2yNiYluv5TDQZgWL1Rc1uN0
 wtO1zrcc5xAaRMZY2ynLhQ5cZp64ZUppxhtbODpEw+X5eKg8StdO5ud/RjlWpTN52uZrq63EkEO
 G9Ux7AD+KAA3WQDAV3tIO2I9PfQqrK4ewVutSGt7hbRIcfmIzGp/DbVdQbhgU1UFhpCs/mAZe3n
 wRjIP74Jf8aus5xNERDMR/M6RYSIAAAI=
X-Received: by 2002:a05:600c:5493:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-4803a71968bmr123530455e9.26.1768998997382; 
 Wed, 21 Jan 2026 04:36:37 -0800 (PST)
X-Received: by 2002:a05:600c:5493:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-4803a71968bmr123530015e9.26.1768998996913; 
 Wed, 21 Jan 2026 04:36:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480424c4b8bsm21616655e9.6.2026.01.21.04.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 04:36:36 -0800 (PST)
Date: Wed, 21 Jan 2026 07:36:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex@shazbot.org, clg@redhat.com, cohuck@redhat.com,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhenzhong.duan@intel.com, vivek.kasireddy@intel.com, kjaju@nvidia.com
Subject: Re: [PATCH v4 0/3] vfio: Add DMABUF support for PCI BAR regions
Message-ID: <20260121073625-mutt-send-email-mst@kernel.org>
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121114111.34045-1-skolothumtho@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 21, 2026 at 11:41:08AM +0000, Shameer Kolothum wrote:
> Hi,
> 
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. This adds support for vfio devices to create a dmabuf for
> each mapped BAR region.
> 
> Changes from v3:
>  https://lore.kernel.org/qemu-devel/20260116092950.15796-1-skolothumtho@nvidia.com/
>  
>  - Folded in patch #2 to linux-headers update to avoid bisect failure
>    due to build error.


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> The dmabuf support was sanity tested on an NVIDIA grace paltform.
> 
> Please take a look and let me know.
> 
> Thanks,
> Shameer
> 
> Nicolin Chen (1):
>   hw/vfio/region: Create dmabuf for PCI BAR per region
> 
> Shameer Kolothum (2):
>   linux-headers: Update to Linux v6.19-rc1
>   hw/vfio: Add helper to retrieve device feature
> 
>  hw/net/virtio-net.c                           |  11 +-
>  hw/vfio/container.c                           |   2 +-
>  hw/vfio/device.c                              |   9 ++
>  hw/vfio/listener.c                            |   4 +-
>  hw/vfio/region.c                              |  65 +++++++++-
>  hw/vfio/trace-events                          |   1 +
>  include/hw/vfio/vfio-device.h                 |   3 +
>  include/standard-headers/drm/drm_fourcc.h     |  25 ++--
>  include/standard-headers/linux/ethtool.h      |   5 +
>  .../linux/input-event-codes.h                 |  14 ++-
>  include/standard-headers/linux/pci_regs.h     |  89 ++++++++++++++
>  include/standard-headers/linux/virtio_net.h   |   3 +-
>  include/standard-headers/linux/virtio_pci.h   |   2 +-
>  linux-headers/asm-arm64/kvm.h                 |   2 +-
>  linux-headers/asm-arm64/unistd_64.h           |   1 +
>  linux-headers/asm-generic/unistd.h            |   4 +-
>  linux-headers/asm-loongarch/kvm.h             |   1 +
>  linux-headers/asm-loongarch/unistd.h          |   6 +
>  linux-headers/asm-loongarch/unistd_64.h       |   1 +
>  linux-headers/asm-mips/unistd_n32.h           |   1 +
>  linux-headers/asm-mips/unistd_n64.h           |   1 +
>  linux-headers/asm-mips/unistd_o32.h           |   1 +
>  linux-headers/asm-powerpc/unistd_32.h         |   1 +
>  linux-headers/asm-powerpc/unistd_64.h         |   1 +
>  linux-headers/asm-riscv/kvm.h                 |   3 +
>  linux-headers/asm-riscv/unistd_32.h           |   1 +
>  linux-headers/asm-riscv/unistd_64.h           |   1 +
>  linux-headers/asm-s390/bitsperlong.h          |   4 -
>  linux-headers/asm-s390/unistd.h               |   4 -
>  linux-headers/asm-s390/unistd_64.h            |   9 +-
>  linux-headers/asm-x86/kvm.h                   |   1 +
>  linux-headers/asm-x86/unistd_32.h             |   1 +
>  linux-headers/asm-x86/unistd_64.h             |   1 +
>  linux-headers/asm-x86/unistd_x32.h            |   1 +
>  linux-headers/linux/iommufd.h                 |  10 ++
>  linux-headers/linux/kvm.h                     |  11 ++
>  linux-headers/linux/mshv.h                    | 116 +++++++++++++++++-
>  linux-headers/linux/psp-sev.h                 |  66 ++++++----
>  linux-headers/linux/vfio.h                    |  28 +++++
>  39 files changed, 450 insertions(+), 60 deletions(-)
> 
> -- 
> 2.43.0


