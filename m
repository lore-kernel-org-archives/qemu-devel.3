Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F9E95A6C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 12:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaYSv-0001nH-La; Tue, 30 Dec 2025 07:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vaYSt-0001mq-P9
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 07:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vaYSq-0007wm-MN
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 07:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767096274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upgDjX4UYDt+AlLIhAAU5Cu/97FIkUld53xGBChV5Jk=;
 b=Oqv0jsgiI/eKYR9yUZHmmzoSh171bJF+1+6f6Hn+2OX8thKI0B/9Yqpvv3au8HBIyCsceb
 hx2Pj4GMXa48wf4pf9DPLnwNQffUvFuzmHgR4h9JWcBgEkOox7qNYZHPmdj8+e5YF8A6KI
 c7gD0aqzyeB/cDq/56aJvoTzzahXpvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-GZqqKjwlMPOeIE5YkC9BSw-1; Tue, 30 Dec 2025 07:04:33 -0500
X-MC-Unique: GZqqKjwlMPOeIE5YkC9BSw-1
X-Mimecast-MFC-AGG-ID: GZqqKjwlMPOeIE5YkC9BSw_1767096272
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so30313585e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 04:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767096271; x=1767701071; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=upgDjX4UYDt+AlLIhAAU5Cu/97FIkUld53xGBChV5Jk=;
 b=te5eKLYFVRKN9ttQuMAL1kkkgK0JJQluvL+y1KScpbpbfM9hZD1iVwtT9cdCxqQWjD
 U+mPycibRh4Zx5gun1s1B0dgUp2uT7VW3jc6UASu5WKQ/dsr9zETpPclVpYrTn5NSQj8
 gxJGZmN0qjYehRyWH8LfPWgJjK4BXvmIv9Bo8DJ0XStcP+t5Sp+Awta1HfXIFPGgsmGU
 t2DX7a5hxa8m2FGqRFC6/zxSx3s+MM8jKYV25Xpm5a44PfK5fbs5wVqjP8kDboI+dLR9
 vqEl8Oh767JbfEd0f8Kbo6z247sJy6K80b7qs6KFVaPw7F5F4FcC0Jc59+wFWXIhPvDS
 PnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767096271; x=1767701071;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upgDjX4UYDt+AlLIhAAU5Cu/97FIkUld53xGBChV5Jk=;
 b=DM7jMKKPKgCnYId0RLi6DZxa/dB6rOokL/lmDtvMclqKS3DbAZPMi2yTw9v+Tj74y2
 wlzscOxi5dY65YQucxj+sy0II+xKJvr3osiwxgWPZJB60JyQyEZhVEVv9I809aoQHiy0
 vt4HQmhtVL+Labt2AZtH8ERfKiGYO7pOlgPwLRWmRVLYFg9kTQHRW9rDgrlu31E8dxcx
 1uwzE2LpL7V6Gc0+l7az8TQeKWlztYxyiFMN6tUkIzkpeGLVbGXTU2UpTHrUcFaZMPt2
 jHDLQCJ5yI0JMhtwglHZoogtxyz4YWG9qxhXVssePbQWpCbUCu1UPXY8Wz1VG0e490p2
 bbgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiOdqnVuBnqFtZpldMTry2nrMOK6nhgcgdJAIp4iy6mCzhVtUuNbqgsaxo720vRcFM151KGyZCSlRb@nongnu.org
X-Gm-Message-State: AOJu0YwJrhRZD1MC+QHOXpr+7l60yuO3lRfHTMk5JpV73UIjkYqwsEFF
 e17ZmJ25/HzdmmvbIJNtATDtfxJ7FuqX8PWk53mM23FAaGMa0bPAcovMxlmez8pjnFNZse7A9zv
 I+aTBhpbs5Xsv2/UetJK3V/b0uE3Uvx7qSdyy/z3Cs2F2fwE7O7+8pnK7
X-Gm-Gg: AY/fxX7klke75lmJMpNbETu6rQHPdKYpDkNyFLoTaGjepsU/42syFS7WU/SGUqptzzU
 xrRaJTSUcd7S5k6nVw6IfGphB24QKx8DaOzuEo+r2Hm8ufOinK8IskcB1yVoIq84iqzIZNgo/dd
 VTWUukGKYHxXU8OziuDH2r6RowEKUmUDqaOXEN/bOLoikc7kuA8YMxAs4O8vm2PItgkVEphhYKs
 0tPkb/2xt4/fvjThvX6yB5OObqG6ggnkEzxRMDxuCCX4/CUvHwVADPpGHp1fGrKyKQeBRsUBBQ0
 xCdPde33QZ4YEUX1EDC4TFWK5PWhK3XW83uyErXG7bb4tt2kuYp4LBUCDWj4dZYQDjgV+ayi72D
 DdnZ0pglq0h9zpIR5Oi2uLhvxQLdKX3OeJA==
X-Received: by 2002:a05:600c:4447:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-47d194c6a2fmr358632685e9.0.1767096270580; 
 Tue, 30 Dec 2025 04:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAlIOjxVFYmDX57Tz8DgVEjz2vr4RAaM5WZvbIL6HB0BKfcdYFrd6maKVlHxSHikBUChq67A==
X-Received: by 2002:a05:600c:4447:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-47d194c6a2fmr358632175e9.0.1767096270005; 
 Tue, 30 Dec 2025 04:04:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm635527695e9.8.2025.12.30.04.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 04:04:29 -0800 (PST)
Date: Tue, 30 Dec 2025 07:04:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
Subject: Re: [PATCH v2 2/9] pnv/phb4: Add reset logic to PHB4
Message-ID: <20251230065711-mutt-send-email-mst@kernel.org>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20251230102156.886288-3-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230102156.886288-3-saif.abrar@linux.vnet.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Dec 30, 2025 at 04:21:20AM -0600, Saif Abrar wrote:
> Add a method to be invoked on QEMU reset.
> Also add CFG and PBL core-blocks reset logic using
> appropriate bits of PHB_PCIE_CRESET register.
> 
> Tested by reading the reset value of a register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
> v1 -> v2:
> - Using the ResettableClass.
> - Reset of the root complex registers done in pnv_phb_root_port_reset_hold().
> 
>  hw/pci-host/pnv_phb.c               |   1 +
>  hw/pci-host/pnv_phb4.c              | 101 +++++++++++++++++++++++++++-
>  include/hw/pci-host/pnv_phb4.h      |   1 +
>  include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
>  tests/qtest/pnv-phb4-test.c         |  28 +++++++-
>  5 files changed, 143 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> index 85fcc3b686..bc08d7488d 100644
> --- a/hw/pci-host/pnv_phb.c
> +++ b/hw/pci-host/pnv_phb.c
> @@ -233,6 +233,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>      pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>      pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>      pci_config_set_interrupt_pin(conf, 0);
> +    pnv_phb4_cfg_core_reset(d);
>  }
>  
>  static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 396bc47817..bf21f955c8 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1,7 +1,8 @@
>  /*
>   * QEMU PowerPC PowerNV (POWER9) PHB4 model
> + * QEMU PowerPC PowerNV (POWER10) PHB5 model
>   *
> - * Copyright (c) 2018-2020, IBM Corporation.
> + * Copyright (c) 2018-2025, IBM Corporation.
>   *
>   * This code is licensed under the GPL version 2 or later. See the
>   * COPYING file in the top-level directory.
> @@ -22,6 +23,7 @@
>  #include "hw/core/qdev-properties.h"
>  #include "qom/object.h"
>  #include "trace.h"
> +#include "system/reset.h"
>  
>  #define phb_error(phb, fmt, ...)                                        \
>      qemu_log_mask(LOG_GUEST_ERROR, "phb4[%d:%d]: " fmt "\n",            \
> @@ -499,6 +501,81 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>      }
>  }
>  
> +/*
> + * Get the PCI-E capability offset from the root-port
> + */
> +static uint32_t get_exp_offset(PCIDevice *pdev)
> +{
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(pdev);
> +    return rpc->exp_offset;
> +}
> +
> +void pnv_phb4_cfg_core_reset(PCIDevice *d)
> +{
> +    uint8_t *conf = d->config;

add an empty line here after declaration.

> +    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
> +    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
> +    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
> +    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
> +    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
> +    pci_set_word(conf + PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
> +    pci_set_long(conf + PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
> +
> +    uint32_t exp_offset = get_exp_offset(d);
> +    pci_set_long(conf + exp_offset, 0x420010);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP,  0x8022);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG
> +                                              | PCI_EXP_DEVCTL_PAYLOAD_512B);
> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_LBNC
> +                 | PCI_EXP_LNKCAP_DLLLARC | BIT(8) | PCI_EXP_LNKCAP_SLS_32_0GB);
> +    pci_set_word(conf + exp_offset + PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);
> +    pci_set_word(conf + exp_offset + PCI_EXP_LNKSTA,
> +                       (PCI_EXP_LNKSTA_NLW_X8 << 2) | PCI_EXP_LNKSTA_CLS_2_5GB);
> +    pci_set_long(conf + exp_offset + PCI_EXP_SLTCTL,
> +                                                   PCI_EXP_SLTCTL_ASPL_DISABLE);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP2, BIT(16)
> +                  | PCI_EXP_DEVCAP2_ARI | PCI_EXP_DEVCAP2_COMP_TMOUT_DIS | 0xF);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP2, BIT(23)
> +                       | PCI_EXP_LNKCAP2_SLS_32_0GB
> +                       | PCI_EXP_LNKCAP2_SLS_16_0GB | PCI_EXP_LNKCAP2_SLS_8_0GB
> +                       | PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB);
> +    pci_set_long(conf + PHB_AER_ECAP, PCI_EXT_CAP(0x1, 0x1, 0x148));
> +    pci_set_long(conf + PHB_SEC_ECAP, (0x1A0 << 20) | BIT(16)
> +                                                       | PCI_EXT_CAP_ID_SECPCI);
> +    pci_set_long(conf + PHB_LMR_ECAP, 0x1E810027);
> +    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
> +    int i;

declare at the beginning of the block please.
and add an empty line here after declaration.
Or, declare inside the for loop.

> +    for (i = PHB_LMR_CTLSTA_2 ; i <= PHB_LMR_CTLSTA_16 ; i += 4) {
> +        pci_set_long(conf + i, 0x9C38);
> +    }
> +
> +    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
> +    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
> +    pci_set_long(conf + P16_ECAP, 0x22410026);
> +    pci_set_long(conf + P32_ECAP, 0x1002A);
> +    pci_set_long(conf + P32_CAP,  0x103);
> +}
> +
> +static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
> +{
> +    /* Zero all registers initially */
> +    int i;

an empty line here after declaration.
Or, declare inside the for loop.

> +    for (i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
> +        phb->regs[i >> 3] = 0x0;
> +    }
> +
> +    /* Set specific register values */
> +    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
> +    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
> +    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;
> +    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
> +}
> +
>  static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>                                 unsigned size)
>  {
> @@ -612,6 +689,17 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>          pnv_phb4_update_xsrc(phb);
>          break;
>  
> +    /* Reset core blocks */
> +    case PHB_PCIE_CRESET:
> +        if (val & PHB_PCIE_CRESET_CFG_CORE) {
> +            PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);

an empty line here after declaration.

> +            pnv_phb4_cfg_core_reset(pci_find_device(pci->bus, 0, 0));
> +        }
> +        if (val & PHB_PCIE_CRESET_PBL) {
> +            pnv_phb4_pbl_core_reset(phb);
> +        }
> +        break;
> +
>      /* Silent simple writes */
>      case PHB_ASN_CMPM:
>      case PHB_CONFIG_ADDRESS:
> @@ -1532,6 +1620,12 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
>      .get_address_space = pnv_phb4_dma_iommu,
>  };
>  
> +static void pnv_phb4_reset(Object *obj, ResetType type)
> +{
> +    PnvPHB4 *phb = PNV_PHB4(obj);

en emoty line here after declaration

> +    pnv_phb4_pbl_core_reset(phb);
> +}
> +
>  static void pnv_phb4_instance_init(Object *obj)
>  {
>      PnvPHB4 *phb = PNV_PHB4(obj);
> @@ -1608,6 +1702,8 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
>      phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>  
>      pnv_phb4_xscom_realize(phb);
> +
> +    qemu_register_resettable(OBJECT(dev));
>  }
>  
>  /*
> @@ -1707,6 +1803,9 @@ static void pnv_phb4_class_init(ObjectClass *klass, const void *data)
>      dc->user_creatable  = false;
>  
>      xfc->notify         = pnv_phb4_xive_notify;
> +
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);

declarations at the beginning of the block please.

> +    rc->phases.enter = pnv_phb4_reset;
>  }
>  
>  static const TypeInfo pnv_phb4_type_info = {
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index de996e718b..47a5c3edf5 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -160,6 +160,7 @@ void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
>  int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
>  PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
>  void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
> +void pnv_phb4_cfg_core_reset(PCIDevice *d);
>  extern const MemoryRegionOps pnv_phb4_xscom_ops;
>  
>  /*
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index bea96f4d91..6892e21cc9 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -343,6 +343,18 @@
>  #define PHB_RC_CONFIG_BASE                      0x1000
>  #define   PHB_RC_CONFIG_SIZE                    0x800
>  
> +#define PHB_AER_ECAP                            0x100
> +#define PHB_AER_CAPCTRL                         0x118
> +#define PHB_SEC_ECAP                            0x148
> +#define PHB_LMR_ECAP                            0x1A0
> +#define PHB_LMR_CTLSTA_2                        0x1AC
> +#define PHB_LMR_CTLSTA_16                       0x1E4
> +#define PHB_DLF_ECAP                            0x1E8
> +#define PHB_DLF_CAP                             0x1EC
> +#define P16_ECAP                                0x1F4
> +#define P32_ECAP                                0x224
> +#define P32_CAP                                 0x228
> +
>  /* PHB4 REGB registers */
>  
>  /* PBL core */
> @@ -368,7 +380,7 @@
>  #define PHB_PCIE_SCR                    0x1A00
>  #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
>  #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
> -
> +#define PHB_PCIE_BNR                    0x1A08
>  
>  #define PHB_PCIE_CRESET                 0x1A10
>  #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
> @@ -423,6 +435,8 @@
>  #define PHB_PCIE_LANE_EQ_CNTL23         0x1B08 /* DD1 only */
>  #define PHB_PCIE_TRACE_CTRL             0x1B20
>  #define PHB_PCIE_MISC_STRAP             0x1B30
> +#define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 0x1B40
> +#define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15 0x1B98
>  
>  /* Error */
>  #define PHB_REGB_ERR_STATUS             0x1C00
> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
> index 3890b4f970..3957c743a3 100644
> --- a/tests/qtest/pnv-phb4-test.c
> +++ b/tests/qtest/pnv-phb4-test.c
> @@ -35,6 +35,29 @@ static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
>      return qtest_readq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_data));
>  }
>  
> +#define phb4_xscom_read(a) pnv_phb_xscom_read(qts, \
> +                                   &pnv_chips[PNV_P10_CHIP_INDEX], PHB4_XSCOM, \
> +                                   PHB_SCOM_HV_IND_ADDR, PHB_SCOM_HV_IND_DATA, \
> +                                   PPC_BIT(0) | a)


macros in UPPER CASE please, and parameters should be in ():
	PPC_BIT(0) | (a)

> +
> +/* Assert that 'PHB PBL Control' register has correct reset value */
> +static void phb4_reset_test(QTestState *qts)
> +{
> +    g_assert_cmpuint(phb4_xscom_read(PHB_PBL_CONTROL), ==, 0xC009000000000000);
> +}
> +
> +static void phb4_tests(void)
> +{
> +    QTestState *qts = NULL;
> +
> +    qts = qtest_initf("-machine powernv10 -accel tcg");
> +
> +    /* Check reset value of a register */
> +    phb4_reset_test(qts);
> +
> +    qtest_quit(qts);
> +}
> +
>  /* Assert that 'PHB - Version Register' bits-[24:31] are as expected */
>  static void phb_version_test(const void *data)
>  {
> @@ -71,8 +94,6 @@ static void phb_version_test(const void *data)
>      /* PHB Version register bits [24:31] */
>      ver = ver >> (63 - 31);
>      g_assert_cmpuint(ver, ==, expected_ver);
> -
> -    qtest_quit(qts);
>  }
>  
>  /* Verify versions of all supported PHB's */
> @@ -95,5 +116,8 @@ int main(int argc, char **argv)
>      /* PHB[345] tests */
>      add_phbX_version_test();
>  
> +    /* PHB4 specific tests */
> +    qtest_add_func("phb4", phb4_tests);
> +
>      return g_test_run();
>  }
> -- 
> 2.47.3


