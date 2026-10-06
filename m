Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5258BCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLw-0005Fx-5C; Wed, 07 Oct 2026 04:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEKAL-0004Wq-D3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEKAE-0006xQ-TJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791350761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uX/t8GJWMyMm9XuiC7iBFGfun+/uPNMllUeEyhgqwpY=;
 b=EH8hxKSwKuM23tJQxA5yE56GXCJhnkFqaLkh0JyYYvAhHLbVzZ45CCS3kj68G5fi6UBDKS
 50Wvf3fUo1DuXALfeGFW0DFYiQpexM81UCIDRlE9EXISaNswvooNx8cbP9wvoSo5dWzJSj
 S0VNQzdYwbEJx5gfYZn1KyzLkHV8Q4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-P3kcCYW6Pb-u9cM-RycJRA-1; Tue, 06 Oct 2026 00:49:16 -0400
X-MC-Unique: P3kcCYW6Pb-u9cM-RycJRA-1
X-Mimecast-MFC-AGG-ID: P3kcCYW6Pb-u9cM-RycJRA_1791262155
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-487038bc9b8so1584887f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791262155; x=1791866955; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uX/t8GJWMyMm9XuiC7iBFGfun+/uPNMllUeEyhgqwpY=;
 b=T8n6Lb3Zem0QsBdjpnMqvLiTrH11NhzZJFnK6igyZ/HHHe0SLYitDNU15EoaWH8HS3
 8n36g+G+rLMhmm8yexbF/09NyArUeuFCb3hM/iMtsy2EN6zLbD3NB2rJ8wNJatgarUKo
 av5heD2sK0zoklE7VpVRZFiqxcxEfWMUAh2TkvHlcMFG9yxRPN9QWKxs/pmXs5h5lEx/
 89HUeL1AHPmhgsd1nBB/ptcOV434WujzoRSpkBjQNGlfYVVGk6dytk1KR7CsJWBrWIhH
 Yf3dcWQoEMUcJSI6Sja70IS7LrcdEK2x4UfTljN1YC7B9xuUx2z2HGwwG6Fh0nnwtuCO
 67nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791262155; x=1791866955;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uX/t8GJWMyMm9XuiC7iBFGfun+/uPNMllUeEyhgqwpY=;
 b=o8j9XuF4fQZNcluGx3CjisrPD6oaGxegK3k8Ep99sbBtOeD7krl27yhFsm/X6MosWi
 AcC+0JFxw7XfsJFku0v1/djhd9nyPD9aFEH2QgZef0PoQTpXNggW7mBvO2w4uqsg5mDi
 XRpsOUxGJ4S6khwNHKTORXPlSUXHIJEeClogXFb4YnzznAvCz4EZOtdewkYIQrCvHLv8
 nYFurMDegs6EXKvgyqgv1dzup0dZJWRuAayfLpvR5QqH+hk8wDYLfCcdVSQ8x2ozlPtW
 dG3QjEOko2T9c4+sxp+YvD6ZwVTTLtdj6e/z/bceCaMhP0nOnU2MXN8QhScIBwvcz9cK
 lLNA==
X-Gm-Message-State: AFq9FYIX1k3GSeF4OFlfuR+Jw3KWgppoqYPaE7Un6qIdbH24tOgQNIN7
 HaRTBz0zHfSrkf/z8S6VBXAxgK8AxGoRPE9zcMfE+tUoL275ptyhEJThFK7+oWlW59LeKddKm9K
 5BoTktQlo3eJ6HhkY5ywEzXlaykBvZrexk3p4rjgomkts1mNSpitCrU9W
X-Gm-Gg: AYBFou0TqzlrNyS1vxLb33Yl/ZZfQup16n3nLCO6lHpLqzoV0A30bqGa3ZxV38dDsEP
 2KFbU0TmSrjabvfIsOAbgQESuYlxIR8Howa+yLvVxd/qLDCHSSwNEDWxTLCYXEzDtS++VA1uPmz
 DV1liZBI46AJCXA3P4CAd4eyLD4+nuv60ewabzAvOajUQ2iLElTlYAWkZRC7tWtE/IBSGBoePW1
 vqSWNwaW6GxJCLz0JuB8dF3XAPjrDmHUoARdarIuwosDNmoZMaT13xsaFtqIlFNGroKDx4nTlvl
 SdbZQtrUX3Iug+MFj+M+RPW01D7QESffZGAtogPQxzIH2dTpfrPIJ80xoF1pR1bg5R9TkeM=
X-Received: by 2002:adf:e186:0:b0:488:6523:e15c with SMTP id
 ffacd0b85a97d-48c6d1ba854mr275815f8f.32.1791262155181; 
 Mon, 05 Oct 2026 21:49:15 -0700 (PDT)
X-Received: by 2002:adf:e186:0:b0:488:6523:e15c with SMTP id
 ffacd0b85a97d-48c6d1ba854mr275798f8f.32.1791262154758; 
 Mon, 05 Oct 2026 21:49:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c63550d1esm7621927f8f.18.2026.10.05.21.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 21:49:14 -0700 (PDT)
Date: Tue, 6 Oct 2026 00:49:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: Re: [PATCH v2 1/3] xio3130_downstream: Add ACS support for
 downstream PCIe ports
Message-ID: <20261006004605-mutt-send-email-mst@kernel.org>
References: <20261006013133.3457555-1-tdave@nvidia.com>
 <20261006013133.3457555-2-tdave@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006013133.3457555-2-tdave@nvidia.com>
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

On Mon, Oct 05, 2026 at 08:31:31PM -0500, Tushar Dave wrote:
> When a PASID-capable device is added behind the PCIe downstream port,
> for example, an Nvidia GPU, the PCIe downstream ports must expose ACS
> capability otherwise PASID won't get enabled.
> 
> In addition, the other use case is GPUDirect RDMA using Data Direct
> that must require special ACS controls at the PCIe downstream ports
> for P2P communication.
> 
> Gate it behind a new x-pcie-acs property (default on), following the
> x-pcie-* compat-bit convention (x-pcie-ext-tag/x-pcie-err-unc-mask/
> x-pcie-ari-nextfn-1), so older machine types can disable it via
> hw_compat to preserve migration compatibility.
> 
> Signed-off-by: Tushar Dave <tdave@nvidia.com>

Does TI X3130 have ACS? If not will the purpose be
served better by the new generic port recently proposed?

> ---
>  hw/core/machine.c                  | 1 +
>  hw/pci-bridge/xio3130_downstream.c | 9 +++++++++
>  include/hw/pci/pci.h               | 3 +++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d9ac4b419a..b1b3911430 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -43,6 +43,7 @@
>  GlobalProperty hw_compat_11_1[] = {
>      { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
>      { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +    { "xio3130-downstream", "x-pcie-acs", "off" },
>  };
>  const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
>  
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 0c3fed3053..6a9df5c174 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -40,6 +40,8 @@
>  #define XIO3130_SSVID_SSID              0
>  #define XIO3130_EXP_OFFSET              0x90
>  #define XIO3130_AER_OFFSET              0x100
> +#define XIO3130_ACS_OFFSET \
> +    (XIO3130_AER_OFFSET + PCI_ERR_SIZEOF)
>  
>  static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>                                           uint32_t val, int len)
> @@ -60,6 +62,7 @@ static void xio3130_downstream_reset(DeviceState *qdev)
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> +    pcie_acs_reset(d);
>      pci_bridge_reset(qdev);
>  }
>  
> @@ -111,6 +114,10 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>          goto err;
>      }
>  
> +    if (d->cap_present & QEMU_PCIE_CAP_ACS) {
> +        pcie_acs_init(d, XIO3130_ACS_OFFSET);
> +    }
> +
>      return;
>  
>  err:
> @@ -137,6 +144,8 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
>  static const Property xio3130_downstream_props[] = {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
> +                    QEMU_PCIE_ACS_BITNR, true),
>  };
>  
>  static const VMStateDescription vmstate_xio3130_downstream = {
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index f2448e941a..dd52b9639e 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -231,6 +231,9 @@ enum {
>      QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
>  #define QEMU_PCI_SKIP_RESET_ON_CPR_BITNR 15
>      QEMU_PCI_SKIP_RESET_ON_CPR = (1 << QEMU_PCI_SKIP_RESET_ON_CPR_BITNR),
> +    /* PCIe ACS (Access Control Services) extended capability present */
> +#define QEMU_PCIE_ACS_BITNR 16
> +    QEMU_PCIE_CAP_ACS = (1 << QEMU_PCIE_ACS_BITNR),
>  };
>  
>  typedef struct PCIINTxRoute {
> -- 
> 2.34.1


