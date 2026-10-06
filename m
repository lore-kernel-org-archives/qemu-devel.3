Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B4FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLs-00052g-1H; Wed, 07 Oct 2026 04:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEK3Q-0003Lk-Rp
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEK3G-0006IL-M1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791350329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMZFLdzlFQPXvtyp/a6JR+4kkXwbEdrJTct3lJWGlIk=;
 b=IHQNtkJbmaYrqCF7JPZzGSlmpp5R4khtTLL/y7XHCIfp6Lnaxg4OknQghynjVD8omwvVND
 is97oGz/vpY+M8pprZe4u8yb4NW3DF5RM7lQKOJ1RX73QJJ0t/T4H71X71OApi5+Flm9l3
 sXQJu0aJwrLNinAf4JDzHQ7xa2+x3cg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Wt6QKIRZPF6hs_S9mMYBFg-1; Tue, 06 Oct 2026 00:45:50 -0400
X-MC-Unique: Wt6QKIRZPF6hs_S9mMYBFg-1
X-Mimecast-MFC-AGG-ID: Wt6QKIRZPF6hs_S9mMYBFg_1791261949
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b0679906dso1461505f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791261949; x=1791866749; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kMZFLdzlFQPXvtyp/a6JR+4kkXwbEdrJTct3lJWGlIk=;
 b=NyDv8U+URLiMD7H0PFdF9rCVblZkRd5r1fkYHmNVFnU3c2kzp0aNFDRpHoAxjYkw82
 6ftKg20sFg/zAGbnawzF+HSaSiKDE2hp5G4Wcq+9rELPfnoRD6Uv+A+0uev79LTnDPa9
 TicQm0sfLs4OZCpJUTfBMu7+pY1aXqWnmJe7VyYa8kD8uEzPmrwwvQmIApqPH/WcjIlw
 G7P196VUMJh8+39PFGK1AR6T4pJ01ERMTU6UEtcQGCbCYZMl2FJbupW4GPV1EDcczbip
 q6iAi0NKlyHe29DcoaGceQtPEGAa5uwHWOSVUdiJSPKVWLEDXflujhxc797v6mtW73DK
 ux0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791261949; x=1791866749;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kMZFLdzlFQPXvtyp/a6JR+4kkXwbEdrJTct3lJWGlIk=;
 b=BLDbABykYBqIxPhu7+2jhWXJYRyfH5QAggPfwYBoI8USXo0PuU69dEz5IZUNSv9XWr
 1l1iVx7qiRBqtL8k8ELKaXzuzd+XVa3LX6LcQCh5QQHgjTIEYH4WdC+H7nKtIIoqaSMa
 oCdOj13bs25cfn78YvdXo2FmFE+qorsbLhx2w578OhxVlhWfzdnMLNTNRyIybI4aNtoz
 w/uRVbm/WTtJDFCXeR02ScjCQiXxDmAuFbj9ptOF/sJgPAkpLqcExG+GbVZKBQ4aEnux
 Oe1nLAKgohyHpFGZuAcmE3WR24bZabBb9NpW52kkpzWvju755G9Gh0o+Vu+Nywulbh5P
 iWwA==
X-Gm-Message-State: AFq9FYJh7QP90XS6s8PMDZkhtQPfEMM+DeFYnqcThixvCD3eUFDNX2N0
 teIL6mKXzYD9tWIsRpFMi20M211WFaYAjZkC2uLS2Ne4UXjWeDVcG1hpVHPzDvctZd83TehGVrW
 XCQ/DOHTp1iHtuRNtn4DqOeBcls6jpKUqJMx4FpkajC7U/L5yRsJjvjNF
X-Gm-Gg: AYBFou3h+NynZEZpzflI/SZrmNS5TxP/PhD6059vlmu0tK9k9dm5fmZcE086lD+GSpm
 uo8r/Df4Pqp1svoRG73VCdGptKXr9i5gHtLxZvmlvPrIsLuXU1rw7JtJE7/QsVWxjL26yHS+J1h
 iZqwH2q1CPjXTLDvo8iVbkPBImjHl3G9vEigorj9RCG9CiPZ09rH2EhKtfZf3MtQCuCz7TRPvad
 WkIy086k+0X3IfZeZorYEXHhYVDZHU/c75jff5y+fKYpe5hWaP+I6zl1xl2lp0RmUNRfj4CFx76
 15JJWZ1miyM0zIHFcwvDhqIoBAiATUsH8iXmoEMpySkeXB3BYftr/AOYMfzaEDZZnp6caB8=
X-Received: by 2002:a05:6000:2509:b0:48b:f08:8162 with SMTP id
 ffacd0b85a97d-48c6d196a7cmr296498f8f.39.1791261948774; 
 Mon, 05 Oct 2026 21:45:48 -0700 (PDT)
X-Received: by 2002:a05:6000:2509:b0:48b:f08:8162 with SMTP id
 ffacd0b85a97d-48c6d196a7cmr296465f8f.39.1791261948203; 
 Mon, 05 Oct 2026 21:45:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c621e4a4dsm7893263f8f.2.2026.10.05.21.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 21:45:47 -0700 (PDT)
Date: Tue, 6 Oct 2026 00:45:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: Re: [PATCH v2 2/3] hw/pci: Expose ACS ctrl on Guest as configured by
 the hypervisor
Message-ID: <20261006004500-mutt-send-email-mst@kernel.org>
References: <20261006013133.3457555-1-tdave@nvidia.com>
 <20261006013133.3457555-3-tdave@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006013133.3457555-3-tdave@nvidia.com>
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

On Mon, Oct 05, 2026 at 08:31:32PM -0500, Tushar Dave wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> To support P2P on Guest we must expose to the guest OS the actual
> PCIe topology and configuration as set by the hypervisor. The ACS
> control must be set accordingly to have functional P2P. A mismatch
> between the hypervisor's ACS configuration and the guest-visible ACS
> Control register can prevent P2P between devices from working as
> expected.
> 
> Extend both root port and downstream port to accept ACS Control bits
> that match the hypervisor configuration and expose them to the guest.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Co-developed-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  hw/pci-bridge/pcie_root_port.c     | 13 +++++++++++--
>  hw/pci-bridge/xio3130_downstream.c | 13 +++++++++++--
>  hw/pci/pcie.c                      | 17 ++++++++++++++---
>  include/hw/pci/pcie.h              |  5 +++--
>  include/hw/pci/pcie_port.h         |  1 +
>  5 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 7c3e78010b..e7cce8c0ee 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -46,6 +46,7 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
>  static void rp_reset_hold(Object *obj, ResetType type)
>  {
>      PCIDevice *d = PCI_DEVICE(obj);
> +    PCIEPort *p = PCIE_PORT(d);
>      DeviceState *qdev = DEVICE(obj);
>  
>      rp_aer_vector_update(d);
> @@ -53,7 +54,7 @@ static void rp_reset_hold(Object *obj, ResetType type)
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> -    pcie_acs_reset(d);
> +    pcie_acs_reset(d, p->acs_ctrl);
>      pcie_aer_root_reset(d);
>      pci_bridge_reset(qdev);
>      pci_bridge_disable_base_limit(d);
> @@ -118,11 +119,18 @@ static void rp_realize(PCIDevice *d, Error **errp)
>      rp_aer_vector_update(d);
>  
>      if (rpc->acs_offset) {
> -        pcie_acs_init(d, rpc->acs_offset);
> +        rc = pcie_acs_init(d, rpc->acs_offset, p->acs_ctrl, errp);
> +        if (rc < 0) {
> +            goto err;
> +        }
> +    } else if (p->acs_ctrl) {
> +        error_setg(errp, "acs-ctrl is not supported by this root port");
> +        goto err;
>      }
>      return;
>  
>  err:
> +    pcie_aer_exit(d);
>      pcie_chassis_del_slot(s);
>  err_pcie_cap:
>      pcie_cap_exit(d);
> @@ -151,6 +159,7 @@ static void rp_exit(PCIDevice *d)
>  static const Property rp_props[] = {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>  };
>  
>  static void rp_instance_post_init(Object *obj)
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 6a9df5c174..e243dfdf7d 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -58,11 +58,12 @@ static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>  static void xio3130_downstream_reset(DeviceState *qdev)
>  {
>      PCIDevice *d = PCI_DEVICE(qdev);
> +    PCIEPort *p = PCIE_PORT(d);
>  
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> -    pcie_acs_reset(d);
> +    pcie_acs_reset(d, p->acs_ctrl);
>      pci_bridge_reset(qdev);
>  }
>  
> @@ -115,12 +116,19 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>      }
>  
>      if (d->cap_present & QEMU_PCIE_CAP_ACS) {
> -        pcie_acs_init(d, XIO3130_ACS_OFFSET);
> +        rc = pcie_acs_init(d, XIO3130_ACS_OFFSET, p->acs_ctrl, errp);
> +        if (rc < 0) {
> +            goto err;
> +        }
> +    } else if (p->acs_ctrl) {
> +        error_setg(errp, "acs-ctrl requires x-pcie-acs to be on");
> +        goto err;

Tying a stable QAPI to an unstable one like this is not really
reasonable.

>      }
>  
>      return;
>  
>  err:
> +    pcie_aer_exit(d);
>      pcie_chassis_del_slot(s);
>  err_pcie_cap:
>      pcie_cap_exit(d);
> @@ -146,6 +154,7 @@ static const Property xio3130_downstream_props[] = {
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
>                      QEMU_PCIE_ACS_BITNR, true),
> +    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>  };
>  
>  static const VMStateDescription vmstate_xio3130_downstream = {
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 42bcb9206d..af24ec7fd9 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1260,7 +1260,8 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned)
>  }
>  
>  /* ACS (Access Control Services) */
> -void pcie_acs_init(PCIDevice *dev, uint16_t offset)
> +int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
> +                  Error **errp)
>  {
>      bool is_downstream = pci_is_express_downstream_port(dev);
>      uint16_t cap_bits = 0;
> @@ -1284,16 +1285,26 @@ void pcie_acs_init(PCIDevice *dev, uint16_t offset)
>           */
>          cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>              PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
> +
> +        if (ctrl_bits & ~cap_bits) {
> +            error_setg(errp,
> +                       "acs-ctrl 0x%hx has bits not supported by this port "
> +                       "(supported: 0x%hx)", ctrl_bits, cap_bits);
> +            return -EINVAL;
> +        }
>      }
>  
>      pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
>      pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> +    pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
> +
> +    return 0;
>  }
>  
> -void pcie_acs_reset(PCIDevice *dev)
> +void pcie_acs_reset(PCIDevice *dev, uint16_t val)
>  {
>      if (dev->exp.acs_cap) {
> -        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
> +        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, val);
>      }
>  }
>  
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index ec25e7a7de..678ad73f7f 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -137,8 +137,9 @@ bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
>                              uint16_t offset, uint16_t size);
>  void pcie_sync_bridge_lnk(PCIDevice *dev);
>  
> -void pcie_acs_init(PCIDevice *dev, uint16_t offset);
> -void pcie_acs_reset(PCIDevice *dev);
> +int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
> +                  Error **errp);
> +void pcie_acs_reset(PCIDevice *dev, uint16_t val);
>  
>  void pcie_ari_init(PCIDevice *dev, uint16_t offset);
>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index b28af067a6..2ad9a563d9 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -36,6 +36,7 @@ struct PCIEPort {
>  
>      /* pci express switch port */
>      uint8_t     port;
> +    uint16_t    acs_ctrl;
>  };
>  
>  void pcie_port_init_reg(PCIDevice *d);
> -- 
> 2.34.1


