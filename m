Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73B5CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEa6Y-0000C9-QC; Wed, 07 Oct 2026 18:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEa6V-0000Bv-AB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEa6R-0004fD-P4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791412030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3MBRz1uTkMTg24wkB54snQj9H81wh1+cqeH2HE7gO4=;
 b=eSJyk8juOG/M/mTWSYDK9WyFWB4fAYoqQgY7P5+1t9p/Rz/uvdK3socdQhbN6msWmkQ/nB
 acy9028zmoHk+AU0hvhQc+/z+A3PS3mI97DDS14srN5tr7Ni8qBYLzD/2UZP8ZCP4MSWkf
 0x0r4aF6J5dvmkjr1FtaZzt8y3V4Qho=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-26C21riyMuGYVd6D5EbVuw-1; Wed, 07 Oct 2026 18:27:08 -0400
X-MC-Unique: 26C21riyMuGYVd6D5EbVuw-1
X-Mimecast-MFC-AGG-ID: 26C21riyMuGYVd6D5EbVuw_1791412027
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48afe67dfc2so55585f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791412027; x=1792016827; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g3MBRz1uTkMTg24wkB54snQj9H81wh1+cqeH2HE7gO4=;
 b=pMVGknhZ/8HeNh9BImpESXOgJoG/ISEi0vClZfzRqwhrFvhHP/5UtTTaEoIoNXRari
 fR2c486GvCLE3DKQjhbqnp4GZRFV1qN2pqbidIt7PJcQ4lDpvHY2+JfR8p37/V0DqHYz
 zPAu4kSulLb3cFtFQk0yF4JiVgi+4G9THnv+K89pSdJ9f/r4sfemx9FPtgJRfZ5huQD0
 chrgXOHLhLri31f99PBu89jxd/hRVDdBMDLME+qDl78mcOvQrhLi3AVunX/yxOGTFT7v
 i0UjDCwptav6HVXlDUl0PSiRbWHk2Xb036lndQkCW+1CHRVN5DcEm4wMsRpZ+r48+193
 iKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791412027; x=1792016827;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g3MBRz1uTkMTg24wkB54snQj9H81wh1+cqeH2HE7gO4=;
 b=g/RyKDcvh9S0Y5zH2PUkX6n9A80Ck+RJLTcyA0TQSyLO4ELR9NNkLb+gy2cHJX2hl3
 2gkk4l1xzXnBdTHxe9VtP2lXRYy7NNRo0c21v+6xm1thTLf1z7ENtCHwiz7oVXIG+m87
 z5CfK2o1+ETXbYbYggD+GDC6+EcfFtkJyNUECot53ECd4Xpo+zCnzepDeBpOqdmVU+oV
 IBKCcc0Yffxuc/ECLmO+diVertuwUuJD7dzERqc9ixomMSp1NC7dbzaYPLhjAtAu2CNj
 x4+H+XbrdSmYPibJvV9nDNaCXmplqNT5kgIaHzIPoj7eq+3WXPGFzgN3cjT+XXIiyXhN
 41JA==
X-Gm-Message-State: AFuF++niVYhChEqiBoGd0+jFccYxcGh9KkaU+hAThr5DUselCa58aMs4
 QYXbV5Dhky1W1a1sh0UdMlpfi8WrIJ1sKDt1toKzOp4aMbz7UfEj7Wvtq/AEQP3GoAa/nrbUzUG
 uhFIPAaYTEhewtHt5e4qpIgFD7S5R19ZVsWCyHT3fN7DkLYP5NVSpM59fb4kQ704m
X-Gm-Gg: AYBFou2Zh4OwpK7nQsS7MQ2kMnxs2bl/SgoXSXPpynQqJKT/m5gCYJe6S/C0DielmdK
 IdHobp4eHPfZbKVxpaacXycz9OaKrB3Py4cFB/HO5bOVIfvzEWROrA125YBBg4Ld9nlO/Z+WlFR
 E3yRi+AIvlkpEmja+ZI8v6nxGetE71N0KiIqS03LyHT4uAdV4ZPRO4FTKQrI4pcysjJUjT9lT0H
 FXR0/CpXvXtfGNk39qlwx+eFFO1aAiCshexIUH8tKyJgGf/Zm6LoT2x9ayv/6FPHkPwl4j7w6XX
 p3odrjr+PVRw5IrwkWcF8N7cX+zfg11wPbhmf+b/N2z7VPqL7BbqKQsPDISxotX7SGki+zI=
X-Received: by 2002:a05:600c:1553:b0:4a0:34a:588c with SMTP id
 5b1f17b1804b1-4a1851c05admr10390855e9.14.1791412027186; 
 Wed, 07 Oct 2026 15:27:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1553:b0:4a0:34a:588c with SMTP id
 5b1f17b1804b1-4a1851c05admr10390465e9.14.1791412026623; 
 Wed, 07 Oct 2026 15:27:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843d82f8sm24204865e9.9.2026.10.07.15.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 15:27:05 -0700 (PDT)
Date: Wed, 7 Oct 2026 18:27:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: Re: [PATCH v2 3/3] hw/pci: Make ACS Control read-only to guests
Message-ID: <20261007182531-mutt-send-email-mst@kernel.org>
References: <20261006013133.3457555-1-tdave@nvidia.com>
 <20261006013133.3457555-4-tdave@nvidia.com>
 <20261006004130-mutt-send-email-mst@kernel.org>
 <0dccf054-fe56-4ab5-98cf-1be764005851@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dccf054-fe56-4ab5-98cf-1be764005851@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Oct 07, 2026 at 11:33:04AM -0500, Tushar Dave wrote:
> 
> 
> On 10/5/2026 11:44 PM, Michael S. Tsirkin wrote:
> > On Mon, Oct 05, 2026 at 08:31:33PM -0500, Tushar Dave wrote:
> >> GPUDirect RDMA using data-direct requires a specific ACS configuration
> >> on PCIe Root Ports and Downstream Ports.
> >>
> >> While ACS can be configured via QEMU's 'acs-ctrl' property, the guest
> >> kernel may overwrite ACS during standard programming.
> >>
> >> This change blocks all guest writes to the PCIe ACS Control register and
> >> preserves QEMU-provided ACS settings across device resets on PCIe Root Ports
> >> and Downstream Ports.
> > 
> > Why is that a sensible thing to do?
> 
> 
> It is sensible because it allows the administrator to define and
> preserve the PCIe topology and P2P configuration from the QEMU command
> line. The administrator can configure ACS on a Root Port or Downstream
> Port as part of defining the desired PCIe topology and P2P behavior. If
> the guest could modify the ACS Control register, it could change the
> administrator-defined ACS configuration, which could prevent P2P from
> working as expected.
> 
> > per pci express spec:
> > 
> > 7.16.3. ACS Control Register (Offset 06h)
> > 
> > Bit Location
> > 0
> > Register Description
> > ACS Source Validation Enable (V) – When Set, the component
> > validates the Bus Number from the Requester ID of Upstream
> > Requests against the secondary/subordinate Bus Numbers.
> > Attributes
> > RW
> > Default value of this bit is 0b. Must be hardwired to 0b if the ACS
> > Source Validation functionality is not implemented.
> > 
> > 
> > And this is repeated for every bit:
> > 
> > RW
> > Default value of this bit is 0b. Must be hardwired to 0b if the ACS
> > Source Validation functionality is not implemented.
> > 
> > 
> > 
> > Looks like your change would put us out of spec?
> 
> 
> You are right that the ACS Control bits are defined as RW, and I am not
> claiming otherwise. The intent is not to make ACS Control read-only in
> general. The read-only behavior is tied to the acs-ctrl property:
> 
> - If acs-ctrl is not specified, ACS Control remains writable as it is
>   today.
> - If acs-ctrl is explicitly specified, the administrator has requested a
>   specific ACS configuration. QEMU then preserves that configuration and
>   does not allow the guest to modify it.
> 
> This is an intentional virtualization policy. When the administrator
> explicitly configures the ACS Control register, the guest should not be
> able to change the ACS configuration and P2P behavior selected by the
> administrator.
> 
> Thanks.
> -Tushar

And then some guest writes the register, reads the value expecting to
see what it wrote, and crashes.  I don't care that it happens to work
for you, we are not doing this kind of thing.

> > 
> > 
> >> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> >> ---
> >>  hw/pci-bridge/pcie_root_port.c     |  5 ++--
> >>  hw/pci-bridge/xio3130_downstream.c |  5 ++--
> >>  hw/pci/pcie.c                      | 46 ++++++++++++++++++++++++++++--
> >>  include/hw/pci/pcie.h              |  3 ++
> >>  include/hw/pci/pcie_port.h         |  1 +
> >>  5 files changed, 54 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> >> index e7cce8c0ee..6ac64c8b2b 100644
> >> --- a/hw/pci-bridge/pcie_root_port.c
> >> +++ b/hw/pci-bridge/pcie_root_port.c
> >> @@ -123,7 +123,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
> >>          if (rc < 0) {
> >>              goto err;
> >>          }
> >> -    } else if (p->acs_ctrl) {
> >> +    } else if (p->acs_ctrl_configured) {
> >>          error_setg(errp, "acs-ctrl is not supported by this root port");
> >>          goto err;
> >>      }
> >> @@ -159,7 +159,8 @@ static void rp_exit(PCIDevice *d)
> >>  static const Property rp_props[] = {
> >>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> >>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> >> -    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
> >> +    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
> >> +                                   qdev_prop_acs_ctrl, uint16_t),
> >>  };
> >>  
> >>  static void rp_instance_post_init(Object *obj)
> >> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> >> index e243dfdf7d..66d25098d7 100644
> >> --- a/hw/pci-bridge/xio3130_downstream.c
> >> +++ b/hw/pci-bridge/xio3130_downstream.c
> >> @@ -120,7 +120,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
> >>          if (rc < 0) {
> >>              goto err;
> >>          }
> >> -    } else if (p->acs_ctrl) {
> >> +    } else if (p->acs_ctrl_configured) {
> >>          error_setg(errp, "acs-ctrl requires x-pcie-acs to be on");
> >>          goto err;
> >>      }
> >> @@ -154,7 +154,8 @@ static const Property xio3130_downstream_props[] = {
> >>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> >>      DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
> >>                      QEMU_PCIE_ACS_BITNR, true),
> >> -    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
> >> +    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
> >> +                                   qdev_prop_acs_ctrl, uint16_t),
> >>  };
> >>  
> >>  static const VMStateDescription vmstate_xio3130_downstream = {
> >> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >> index af24ec7fd9..1fead3a053 100644
> >> --- a/hw/pci/pcie.c
> >> +++ b/hw/pci/pcie.c
> >> @@ -1265,6 +1265,8 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
> >>  {
> >>      bool is_downstream = pci_is_express_downstream_port(dev);
> >>      uint16_t cap_bits = 0;
> >> +    PCIEPort *p = (PCIEPort *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_PORT);
> >> +    bool configured = p && p->acs_ctrl_configured;
> >>  
> >>      /* For endpoints, only multifunction devs may have an ACS capability: */
> >>      assert(is_downstream ||
> >> @@ -1286,7 +1288,7 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
> >>          cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> >>              PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
> >>  
> >> -        if (ctrl_bits & ~cap_bits) {
> >> +        if (configured && (ctrl_bits & ~cap_bits)) {
> >>              error_setg(errp,
> >>                         "acs-ctrl 0x%hx has bits not supported by this port "
> >>                         "(supported: 0x%hx)", ctrl_bits, cap_bits);
> >> @@ -1295,7 +1297,17 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
> >>      }
> >>  
> >>      pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
> >> -    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> >> +
> >> +    if (is_downstream && configured) {
> >> +        /*
> >> +         * Block guest writes to ACS Control entirely to preserve QEMU
> >> +         * ACS settings
> >> +         */
> >> +        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, 0);
> >> +    } else {
> >> +        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> >> +    }
> >> +
> >>      pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
> >>  
> >>      return 0;
> >> @@ -1308,6 +1320,36 @@ void pcie_acs_reset(PCIDevice *dev, uint16_t val)
> >>      }
> >>  }
> >>  
> >> +static void set_acs_ctrl(Object *obj, Visitor *v, const char *name,
> >> +                         void *opaque, Error **errp)
> >> +{
> >> +    PCIEPort *p = PCIE_PORT(obj);
> >> +    const Property *prop = opaque;
> >> +    uint16_t *ptr = object_field_prop_ptr(obj, prop);
> >> +
> >> +    if (!visit_type_uint16(v, name, ptr, errp)) {
> >> +        return;
> >> +    }
> >> +    p->acs_ctrl_configured = true;
> >> +}
> >> +
> >> +static void get_acs_ctrl(Object *obj, Visitor *v, const char *name,
> >> +                         void *opaque, Error **errp)
> >> +{
> >> +    const Property *prop = opaque;
> >> +    uint16_t *ptr = object_field_prop_ptr(obj, prop);
> >> +
> >> +    visit_type_uint16(v, name, ptr, errp);
> >> +}
> >> +
> >> +const PropertyInfo qdev_prop_acs_ctrl = {
> >> +    .type = "uint16",
> >> +    .description = "PCIe ACS ctrl configuration (if set, even to 0, "
> >> +                   "makes ACS Control read-only to the guest)",
> >> +    .get = get_acs_ctrl,
> >> +    .set = set_acs_ctrl,
> >> +};
> >> +
> >>  void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
> >>                              uint8_t pasid_width, bool exec_perm, bool priv_mod)
> >>  {
> >> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> >> index 678ad73f7f..bbb11fd402 100644
> >> --- a/include/hw/pci/pcie.h
> >> +++ b/include/hw/pci/pcie.h
> >> @@ -26,6 +26,7 @@
> >>  #include "hw/pci/pcie_aer.h"
> >>  #include "hw/pci/pcie_sriov.h"
> >>  #include "hw/core/hotplug.h"
> >> +#include "hw/core/qdev-properties.h"
> >>  
> >>  typedef struct PCIEPort PCIEPort;
> >>  typedef struct PCIESlot PCIESlot;
> >> @@ -86,6 +87,8 @@ struct PCIExpressDevice {
> >>  
> >>  #define COMPAT_PROP_PCP "power_controller_present"
> >>  
> >> +extern const PropertyInfo qdev_prop_acs_ctrl;
> >> +
> >>  /* PCI express capability helper functions */
> >>  int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
> >>                    uint8_t port, Error **errp);
> >> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> >> index 2ad9a563d9..ef2c2ec2cd 100644
> >> --- a/include/hw/pci/pcie_port.h
> >> +++ b/include/hw/pci/pcie_port.h
> >> @@ -37,6 +37,7 @@ struct PCIEPort {
> >>      /* pci express switch port */
> >>      uint8_t     port;
> >>      uint16_t    acs_ctrl;
> >> +    bool        acs_ctrl_configured;
> >>  };
> >>  
> >>  void pcie_port_init_reg(PCIDevice *d);
> >> -- 
> >> 2.34.1
> > 


