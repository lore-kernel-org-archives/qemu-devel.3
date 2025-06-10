Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F61C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 18:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP3Gg-0004HB-P3; Tue, 10 Jun 2025 14:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP3Ge-0004Gu-Nc
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 14:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP3Gc-0001xK-Vu
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 14:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749578407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrSAA9YDXbEfGqFtAxDWtVKDopFynCeZOuJTIBTN1UY=;
 b=BiUAtEGS7+LEzOh+tgUAfnsewjEb9Zl66aaFkeRzZj52YaQYWXeX9LeQGzobMa5CE491pS
 B1HWd3btWkNjSUDEA2HbJ2w2sk9K0bUMKJxyO004mMsViHM3Ck+RKLV5CmyJWMhTxO9cMr
 Fb5nLdqp16MTrlLrGRM1SpFrY4j4A7w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-ArtieKt1Mqap4DNzQqmkUw-1; Tue, 10 Jun 2025 14:00:06 -0400
X-MC-Unique: ArtieKt1Mqap4DNzQqmkUw-1
X-Mimecast-MFC-AGG-ID: ArtieKt1Mqap4DNzQqmkUw_1749578405
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso399105e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 11:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749578405; x=1750183205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrSAA9YDXbEfGqFtAxDWtVKDopFynCeZOuJTIBTN1UY=;
 b=dd9v1DG+Tu+9Dtzc6rblCLHcVN5yAwlK9+cDzrvLIULpSazTcxlGd11FdPxElPa7fv
 /XtOxUBvL+U2AvkxG4Fvqux/HkBzMKIaXcwrcyPmegT/PQMxY77tcV5bSCrPkDIF92hh
 DoqqRpGoElRtPvPAvxcdyvFetEeOyD2EYvJbiq3c1LxReOePE8XnIa76oOY8MRXX0Ies
 oHqH7zDs1fa8Y9t0nHtxxTHrbIKqI5/4eVWjWU361kCvWTHuV7NKSjO44R13yJoUoHZf
 ekvr97Gls1rvKD3bba/EgPlq8B1QJMPsEI7zRDxSbV6MSWE7dISuik+ZxY8nyCTKF+DL
 HyrA==
X-Gm-Message-State: AOJu0YwIsCk1PIbjMJZtSiAOtFQeUyPKIprFNvumcjfrt659T0jfnVmr
 TXNqWjSRM5+6Q7o2HUfD6PeQiX/5riv/TWinnrbz4DvO+apwc8Ums1x0ckrg/jsia3c0+az9Hs1
 c25rqrv0mj7D40PL6WDvTOQkq4YbOELcoTbj7AZE1xHUjdlcZZBYVZazM
X-Gm-Gg: ASbGncsyJg/uZ3f/06Zw/Yx9QUKsdDMt7g5eN6l8u17DQLCPZUDVl8kajAta6rHs7cJ
 aM/tayWsXuKNtr0uYLvzRAiwND9DD2KEbsyfJ4GnPLGw593CX8vpBLthRQC/fylaNXqn2xLCHgG
 nA9cw3OU/Cp2NRL1fw3U904ePCsAKXZdM7lSc98SBjP0JP5lCDlXFRGnkos1XMwAl7hrZ8o31IQ
 Iz4dCQNBqqXqNu6qGz6jQzdj/tO4e/dQD2YGN5Y6M32V4x6U9cSyEl/4bUWSYUTA1EzsOsazY5i
 NmR6Z1KQtVQSImOf
X-Received: by 2002:a05:600d:18:b0:453:84a:e8d6 with SMTP id
 5b1f17b1804b1-453240beb11mr2750465e9.1.1749578405022; 
 Tue, 10 Jun 2025 11:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbnGS+wYDO5op+jeRhd/LClv0jLsvPBSXX8C/KqjayDF6mNuPvX+INnvQHr/9B4/qI6TE/fw==
X-Received: by 2002:a05:600d:18:b0:453:84a:e8d6 with SMTP id
 5b1f17b1804b1-453240beb11mr2750205e9.1.1749578404603; 
 Tue, 10 Jun 2025 11:00:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d50sm148732095e9.5.2025.06.10.11.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 11:00:04 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:00:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V5.1] pci: skip reset during cpr
Message-ID: <20250610135838-mutt-send-email-mst@kernel.org>
References: <1749576403-25355-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749576403-25355-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 10, 2025 at 10:26:43AM -0700, Steve Sistare wrote:
> Do not reset a vfio-pci device during CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/pci/pci.c         | 5 +++++
>  hw/vfio/pci.c        | 7 +++++++
>  include/hw/pci/pci.h | 2 ++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 9b4bf48..c70b5ce 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -32,6 +32,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-properties-system.h"
> +#include "migration/cpr.h"
>  #include "migration/qemu-file-types.h"
>  #include "migration/vmstate.h"
>  #include "net/net.h"
> @@ -537,6 +538,10 @@ static void pci_reset_regions(PCIDevice *dev)
>  
>  static void pci_do_device_reset(PCIDevice *dev)
>  {
> +    if ((dev->cap_present & QEMU_PCI_SKIP_RESET_ON_CPR) && cpr_is_incoming()) {
> +        return;
> +    }
> +
>      pci_device_deassert_intx(dev);
>      assert(dev->irq_state == 0);
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b1250d8..4cd92c3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3408,6 +3408,13 @@ static void vfio_instance_init(Object *obj)
>      /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
>       * line, therefore, no need to wait to realize like other devices */
>      pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> +
> +    /*
> +     * A device that is resuming for cpr is already configured, so do not
> +     * reset it during qemu_system_reset prior to cpr load, else interrupts
> +     * may be lost.
> +     */
> +    pci_dev->cap_present |= QEMU_PCI_SKIP_RESET_ON_CPR;
>  }
>  
>  static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 35d59d7..df3cc7b 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -222,6 +222,8 @@ enum {
>      QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
>  #define QEMU_PCI_CAP_PM_BITNR 14
>      QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
> +#define QEMU_PCI_SKIP_RESET_ON_CPR_BITNR 15
> +    QEMU_PCI_SKIP_RESET_ON_CPR = (1 << QEMU_PCI_SKIP_RESET_ON_CPR_BITNR),
>  };
>  
>  typedef struct PCIINTxRoute {
> -- 
> 1.8.3.1


