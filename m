Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C53CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVq0-0002az-Om; Mon, 11 Aug 2025 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ulVpx-0002ZQ-SP
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ulVpi-0008Ry-Qo
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754931428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tttzqLi/wJy6OVDa7dUv5ptLJx05gbnq9e0lYKVIt5M=;
 b=L652K9ZC1EoD0HAYqgWophDVo6IijEjzW37qwDlDqALfPAy+jqnADBl9/3l4Ujc4REm1mU
 VUaOwQYCsEykg5OEOMJi4JwEQpC8fME7pIsQqF/rzd49daB2JgwiXExPn8wrLw3voEb0sh
 HOwLlveev88wjMltnI8VZpt66vE5HPs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-GciwvwNrNyKXZbbz4214iQ-1; Mon, 11 Aug 2025 12:57:07 -0400
X-MC-Unique: GciwvwNrNyKXZbbz4214iQ-1
X-Mimecast-MFC-AGG-ID: GciwvwNrNyKXZbbz4214iQ_1754931426
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-459de8f00cfso19261265e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931425; x=1755536225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tttzqLi/wJy6OVDa7dUv5ptLJx05gbnq9e0lYKVIt5M=;
 b=GY9sIYrZzzvCl1QqWlZ8+l40ZRGZTLX6BlTEVhwCnxQX7lAXjMm1RHF577Mt1+025I
 4cb0Jf0+5fKK2WtFkARLSPS3A8e7WA3xk3sHvxyXKF9JkxqkWlniOEH+Zv9NQ1lP0ahM
 c7zE6IBjpId/iA5iwvsfkJv+kexhXDINKlisYV1FD/9aFou/yO635PRlUOqs/3xnYadK
 Z15cehgteUHJQAulQCBb6jhq0J4H5UVifPCCHnOiMePgT/DWsKutTPgtp0/sK7XeKs4z
 GackZMtHaK5ConWYKHwjIXZDvviUI7FbD9NEHVyV+IO+xMLQumDw9uwN+GiUC7UZ0GqK
 Ch7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc+nWqkLEzKeNteYodp8Z4WwVYHxDGkrxw/zKNBEirS06Pxrgzifz20OXiyMZcdcEgrdBEq5foJAP/@nongnu.org
X-Gm-Message-State: AOJu0YysEVMrKxE1ZinrGl4RSo+ar32/IgtM4CbYF7TErauDSV2pICMN
 MBBM5tvZMROsf63DpZIU9Ess8MqvHq6MUPgdW2emmEOOo52F1wCUcb2OFqiObFeeLtJK8miGUMo
 RYm/U1bf9pf4A8tRLTRAiOleGYrnw3ZaFaIXHsgelFU9VuuNZfkU3KKgO
X-Gm-Gg: ASbGncueGX8EddZaGvJAQNQgPsJJBMhkCXbnJBmv37aUCw33dUW5Cu1X4zLDfaGHRHh
 fkXkRIFAX16d+CTP9lZcPixI8AtQ1rJUxO9eKYEOcJ471WqoZ3DszBlc1DF/1Efc6W0DoAmhYNe
 V/+yoB5BihzvPJEHrdiL5xC4tm/Yt7d4GBWTFBAkFnFEggdXz+9+0WXjyvlg1fnBOJimXZdjr84
 9fFFJi9/MdBCcAGagPY+c0g8J2hHzLVL/c2RXyUC1x31xNlGp2+eys5VV5ZC+9pe0sNfCwj/hWY
 4wk6tOk629HmKvdkF6D5Yz6OhmP76iX2
X-Received: by 2002:a05:600c:35c3:b0:456:18cf:66b5 with SMTP id
 5b1f17b1804b1-45a10c0063amr3937625e9.22.1754931425105; 
 Mon, 11 Aug 2025 09:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErqSPb9cJiFSV5DEgWAoPDiqps3otYi2ZeQ3oDJCusmhK1zVaUFhFeN+Nv6u8Zsj9oY4XjCQ==
X-Received: by 2002:a05:600c:35c3:b0:456:18cf:66b5 with SMTP id
 5b1f17b1804b1-45a10c0063amr3937435e9.22.1754931424608; 
 Mon, 11 Aug 2025 09:57:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c33fesm41891185f8f.29.2025.08.11.09.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:57:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:57:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, ira.weiny@intel.com,
 alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
Message-ID: <20250811125552-mutt-send-email-mst@kernel.org>
References: <20250811033405.332295-1-dave@stgolabs.net>
 <20250811033405.332295-2-dave@stgolabs.net>
 <20250811165741.00003aa2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811165741.00003aa2@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 11, 2025 at 04:57:41PM +0100, Jonathan Cameron wrote:
> On Sun, 10 Aug 2025 20:34:02 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > As with the link speed and width training, have ad-hoc property for
> > setting the flit mode and allow CXL components to make use of it.

I note we didn't make it a stable API for width, want to
prefix this one with "x-", too?

> > For the CXL root port and dsp cases, always report flit mode but
> > the actual value after 'training' will depend on the downstream
> > device configuration.
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> Definitely include PCI maintainers on this.
> +CC Michael, and Marcel.
> 
> Also Markus for command line bits.
> 
> Looks good to me.
> 
> Jonathan
> 
> 
> > ---
> >  hw/mem/cxl_type3.c                        |  9 ++++++---
> >  hw/pci-bridge/cxl_downstream.c            | 11 +++++++----
> >  hw/pci-bridge/cxl_root_port.c             | 11 +++++++----
> >  hw/pci-bridge/cxl_upstream.c              | 19 +++++++++++--------
> >  hw/pci-bridge/gen_pcie_root_port.c        |  1 +
> >  hw/pci/pcie.c                             | 23 +++++++++++++++++++----
> >  include/hw/cxl/cxl_device.h               |  1 +
> >  include/hw/pci-bridge/cxl_upstream_port.h |  1 +
> >  include/hw/pci/pcie.h                     |  2 +-
> >  include/hw/pci/pcie_port.h                |  1 +
> >  10 files changed, 55 insertions(+), 24 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index c4658e0955d5..ecd3a7703b35 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -533,9 +533,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >                                 GPF_DEVICE_DVSEC_REVID, dvsec);
> >  
> >      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> > -        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
> > +                                   /* 68B (maybe), IO, Mem, non-MLD */
> > +        .cap                     = ct3d->flitmode ? 0x6 : 0x26,
> >          .ctrl                    = 0x02, /* IO always enabled */
> > -        .status                  = 0x26, /* same as capabilities */
> > +        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* same */
> >          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> >      };
> >      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> > @@ -1501,7 +1502,8 @@ void ct3d_reset(DeviceState *dev)
> >      uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
> >      uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
> >  
> > -    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
> > +    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
> > +                              ct3d->flitmode);
> >      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
> >      cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
> >  
> > @@ -1540,6 +1542,7 @@ static const Property ct3_props[] = {
> >                                  speed, PCIE_LINK_SPEED_32),
> >      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
> >                                  width, PCIE_LINK_WIDTH_16),
> > +    DEFINE_PROP_BOOL("256b-flit", CXLType3Dev, flitmode, false),
> >      DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
> >  };
> >  
> > diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> > index 6aa8586f0161..94dcd52a8017 100644
> > --- a/hw/pci-bridge/cxl_downstream.c
> > +++ b/hw/pci-bridge/cxl_downstream.c
> > @@ -116,8 +116,9 @@ static void cxl_dsp_reset(DeviceState *qdev)
> >      latch_registers(dsp);
> >  }
> >  
> > -static void build_dvsecs(CXLComponentState *cxl)
> > +static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
> >  {
> > +    PCIESlot *s = PCIE_SLOT(d);
> >      CXLDVSECRegisterLocator *regloc_dvsec;
> >      uint8_t *dvsec;
> >      int i;
> > @@ -129,9 +130,10 @@ static void build_dvsecs(CXLComponentState *cxl)
> >                                 EXTENSIONS_PORT_DVSEC_REVID, dvsec);
> >  
> >      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> > -        .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
> > +                                   /* 68B (maybe), IO, Mem, non-MLD */
> > +        .cap                     = s->flitmode ? 0x7 : 0x27,
> >          .ctrl                    = 0x02, /* IO always enabled */
> > -        .status                  = 0x26, /* same */
> > +        .status                  = s->flitmode ? 0x6 : 0x26, /* same */
> >          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> >      };
> >      cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
> > @@ -212,7 +214,7 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
> >  
> >      cxl_cstate->dvsec_offset = CXL_DOWNSTREAM_PORT_DVSEC_OFFSET;
> >      cxl_cstate->pdev = d;
> > -    build_dvsecs(cxl_cstate);
> > +    build_dvsecs(d, cxl_cstate);
> >      cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_DSP);
> >      memory_region_init(&dsp->bar, OBJECT(d), "registers", (2 << 16));
> >      memory_region_add_subregion(&dsp->bar, 0, component_bar);
> > @@ -257,6 +259,7 @@ static const Property cxl_dsp_props[] = {
> >                                  speed, PCIE_LINK_SPEED_64),
> >      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> >                                  width, PCIE_LINK_WIDTH_16),
> > +    DEFINE_PROP_BOOL("256b-flit", PCIESlot, flitmode, true),
> >  };
> >  
> >  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
> > diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> > index f035987b6f1f..fd992b808355 100644
> > --- a/hw/pci-bridge/cxl_root_port.c
> > +++ b/hw/pci-bridge/cxl_root_port.c
> > @@ -109,8 +109,9 @@ static void latch_registers(CXLRootPort *crp)
> >      cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
> >  }
> >  
> > -static void build_dvsecs(CXLComponentState *cxl)
> > +static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
> >  {
> > +    PCIESlot *s = PCIE_SLOT(d);
> >      CXLDVSECRegisterLocator *regloc_dvsec;
> >      uint8_t *dvsec;
> >      int i;
> > @@ -131,9 +132,10 @@ static void build_dvsecs(CXLComponentState *cxl)
> >                                 GPF_PORT_DVSEC_REVID, dvsec);
> >  
> >      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> > -        .cap                     = 0x26, /* IO, Mem, non-MLD */
> > +                                   /* 68B (maybe), IO, Mem, non-MLD */
> > +        .cap                     = s->flitmode ? 0x6 : 0x26,
> >          .ctrl                    = 0x2,
> > -        .status                  = 0x26, /* same */
> > +        .status                  = s->flitmode ? 0x6 : 0x26, /* same */
> >          .rcvd_mod_ts_data_phase1 = 0xef,
> >      };
> >      cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
> > @@ -189,7 +191,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
> >  
> >      cxl_cstate->dvsec_offset = CXL_ROOT_PORT_DVSEC_OFFSET;
> >      cxl_cstate->pdev = pci_dev;
> > -    build_dvsecs(cxl_cstate);
> > +    build_dvsecs(pci_dev, cxl_cstate);
> >  
> >      cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
> >                                        TYPE_CXL_ROOT_PORT);
> > @@ -235,6 +237,7 @@ static const Property gen_rp_props[] = {
> >                                  speed, PCIE_LINK_SPEED_64),
> >      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> >                                  width, PCIE_LINK_WIDTH_32),
> > +    DEFINE_PROP_BOOL("256b-flit", PCIESlot, flitmode, true),
> >  };
> >  
> >  static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
> > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > index c2150afff39b..6269276408b8 100644
> > --- a/hw/pci-bridge/cxl_upstream.c
> > +++ b/hw/pci-bridge/cxl_upstream.c
> > @@ -147,12 +147,13 @@ static void cxl_usp_reset(DeviceState *qdev)
> >  
> >      pci_bridge_reset(qdev);
> >      pcie_cap_deverr_reset(d);
> > -    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
> > +    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
> >      latch_registers(usp);
> >  }
> >  
> > -static void build_dvsecs(CXLComponentState *cxl)
> > +static void build_dvsecs(CXLUpstreamPort *usp)
> >  {
> > +    CXLComponentState *cxl_cstate = &usp->cxl_cstate;
> >      CXLDVSECRegisterLocator *regloc_dvsec;
> >      uint8_t *dvsec;
> >      int i;
> > @@ -160,17 +161,18 @@ static void build_dvsecs(CXLComponentState *cxl)
> >      dvsec = (uint8_t *)&(CXLDVSECPortExt){
> >          .status = 0x1, /* Port Power Management Init Complete */
> >      };
> > -    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
> > +    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
> >                                 EXTENSIONS_PORT_DVSEC_LENGTH,
> >                                 EXTENSIONS_PORT_DVSEC,
> >                                 EXTENSIONS_PORT_DVSEC_REVID, dvsec);
> >      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> > -        .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
> > +                                 /* 68B (maybe), Cache, IO, Mem, non-MLD */
> > +        .cap                     = usp->flitmode ? 0x7 : 0x27,
> >          .ctrl                    = 0x27, /* Cache, IO, Mem */
> > -        .status                  = 0x26, /* same */
> > +        .status                  = usp->flitmode ? 0x6 : 0x26, /* same */
> >          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> >      };
> > -    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
> > +    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
> >                                 PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
> >                                 PCIE_FLEXBUS_PORT_DVSEC,
> >                                 PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
> > @@ -186,7 +188,7 @@ static void build_dvsecs(CXLComponentState *cxl)
> >              RBI_CXL_CPMU_REG | 0; /* Port so only one 64 bit bar */
> >          regloc_dvsec->reg_base[1 + i].hi = 0;
> >      }
> > -    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
> > +    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
> >                                 REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
> >                                 REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
> >  }
> > @@ -381,7 +383,7 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
> >      }
> >      cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> >      cxl_cstate->pdev = d;
> > -    build_dvsecs(cxl_cstate);
> > +    build_dvsecs(usp);
> >      cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
> >      memory_region_init(&usp->bar, OBJECT(d), "registers", (2 << 16));
> >      memory_region_add_subregion(&usp->bar, 0, component_bar);
> > @@ -433,6 +435,7 @@ static const Property cxl_upstream_props[] = {
> >                                  speed, PCIE_LINK_SPEED_32),
> >      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
> >                                  width, PCIE_LINK_WIDTH_16),
> > +    DEFINE_PROP_BOOL("256b-flit", CXLUpstreamPort, flitmode, false),
> >  };
> >  
> >  static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
> > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > index d9078e783bf0..b092463d471e 100644
> > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > @@ -145,6 +145,7 @@ static const Property gen_rp_props[] = {
> >                                  speed, PCIE_LINK_SPEED_16),
> >      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> >                                  width, PCIE_LINK_WIDTH_32),
> > +    DEFINE_PROP_BOOL("256b-flit", PCIESlot, flitmode, false),
> >  };
> >  
> >  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index eaeb68894e6e..cc8e7c3cbf3f 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -113,7 +113,7 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
> >  
> >  /* Includes setting the target speed default */
> >  static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
> > -                              PCIExpLinkSpeed speed)
> > +                              PCIExpLinkSpeed speed, bool flitmode)
> >  {
> >      /* Clear and fill LNKCAP from what was configured above */
> >      pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
> > @@ -158,10 +158,15 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
> >                                         PCI_EXP_LNKCAP2_SLS_64_0GB);
> >          }
> >      }
> > +
> > +    if (flitmode) {
> > +        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
> > +                                   PCI_EXP_LNKSTA2_FLIT);
> > +    }
> >  }
> >  
> >  void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
> > -                               PCIExpLinkSpeed speed)
> > +                               PCIExpLinkSpeed speed, bool flitmode)
> >  {
> >      uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
> >  
> > @@ -175,7 +180,7 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
> >                                 QEMU_PCI_EXP_LNKSTA_NLW(width) |
> >                                 QEMU_PCI_EXP_LNKSTA_CLS(speed));
> >  
> > -    pcie_cap_fill_lnk(exp_cap, width, speed);
> > +    pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);
> >  }
> >  
> >  static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
> > @@ -212,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
> >          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
> >      }
> >  
> > -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed);
> > +    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
> >  }
> >  
> >  int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> > @@ -1106,6 +1111,8 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
> >      if (!target || !target->exp.exp_cap) {
> >          lnksta = lnkcap;
> >      } else {
> > +        uint16_t lnksta2;
> > +
> >          lnksta = target->config_read(target,
> >                                       target->exp.exp_cap + PCI_EXP_LNKSTA,
> >                                       sizeof(lnksta));
> > @@ -1119,6 +1126,14 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
> >              lnksta &= ~PCI_EXP_LNKSTA_CLS;
> >              lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
> >          }
> > +
> > +        lnksta2 = target->config_read(target,
> > +                                      target->exp.exp_cap + PCI_EXP_LNKSTA2,
> > +                                      sizeof(lnksta2));
> > +        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA2,
> > +                                     PCI_EXP_LNKSTA2_FLIT);
> > +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2, lnksta2 &
> > +                                   PCI_EXP_LNKSTA2_FLIT);
> >      }
> >  
> >      if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 068c20d61ebc..0abfd678b875 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -796,6 +796,7 @@ struct CXLType3Dev {
> >      /* PCIe link characteristics */
> >      PCIExpLinkSpeed speed;
> >      PCIExpLinkWidth width;
> > +    bool flitmode;
> >  
> >      /* DOE */
> >      DOECap doe_cdat;
> > diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
> > index db1dfb6afd98..4862601b2a60 100644
> > --- a/include/hw/pci-bridge/cxl_upstream_port.h
> > +++ b/include/hw/pci-bridge/cxl_upstream_port.h
> > @@ -20,6 +20,7 @@ typedef struct CXLUpstreamPort {
> >  
> >      PCIExpLinkSpeed speed;
> >      PCIExpLinkWidth width;
> > +    bool flitmode;
> >  
> >      DOECap doe_cdat;
> >      uint64_t sn;
> > diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> > index ff6ce08e135a..358374b1df81 100644
> > --- a/include/hw/pci/pcie.h
> > +++ b/include/hw/pci/pcie.h
> > @@ -142,7 +142,7 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset);
> >  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
> >  void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
> >  void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
> > -                               PCIExpLinkSpeed speed);
> > +                               PCIExpLinkSpeed speed, bool flitmode);
> >  
> >  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >                                 Error **errp);
> > diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> > index 7cd7af8cfa4b..53cd64c5edff 100644
> > --- a/include/hw/pci/pcie_port.h
> > +++ b/include/hw/pci/pcie_port.h
> > @@ -58,6 +58,7 @@ struct PCIESlot {
> >  
> >      PCIExpLinkSpeed speed;
> >      PCIExpLinkWidth width;
> > +    bool flitmode;
> >  
> >      /* Disable ACS (really for a pcie_root_port) */
> >      bool        disable_acs;


