Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C483AC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 21:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bDe-0006CL-8v; Fri, 04 Sep 2026 17:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2bDc-00067T-1z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 17:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2bDa-0001cf-5O
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 17:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788556381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UAOeP16h7Zydy+ntmn4YoJCLJ5sa9X4OsuLRV9M7FvA=;
 b=g/DDnygqbIaMxJ5uHUt2vi+208OY7soqoxazlWQrZSQrh7ExO6+VjDdAxdp+1VjqycjNSf
 sFJfrEF1S3m2LpchZbnE7i1ZdPD2Xli6bDSPHhWs/DtDkOVoHnMto7eBjSgP6+ehpMTETh
 X6EzjAWm5Xh/19M4OZUCt9sCAFKST6c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-MQlcGSzUN7SDGMEZtueB8A-1; Fri, 04 Sep 2026 17:12:58 -0400
X-MC-Unique: MQlcGSzUN7SDGMEZtueB8A-1
X-Mimecast-MFC-AGG-ID: MQlcGSzUN7SDGMEZtueB8A_1788556377
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-484362cb000so973311f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 14:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788556377; x=1789161177; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UAOeP16h7Zydy+ntmn4YoJCLJ5sa9X4OsuLRV9M7FvA=;
 b=aWrMxI5AOJTl55CeGaXjC5AKBIxGr5kyPcxxZovatwFVmtlUq09nnIutaYnlALs20O
 3Eo/j7HQGMtufDpm8nCz9oLDLybcVBcCXpsZw56vwFLbN425FVZkQyYUYYNvmh+qa9eH
 I5jELuSF+FGpZGmTfiWTOQk8IcEw3lj8KFRK3LL+QVJ4SLXBIfsB+eIeuqCSPQ7ICMN/
 Gt5GqEsefp7JQHdIfV/i1y+t6Z9HNUnLqcZTpJI8AaQutrneKB7W8tpXnLbJq714d7eT
 vHZayCsckc9wnqPQXC8zayW0tiYcUB7YRk1dCc9Y1p/XRQ5SRKGIY5mGyGOF9KysVIiU
 bq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788556377; x=1789161177;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UAOeP16h7Zydy+ntmn4YoJCLJ5sa9X4OsuLRV9M7FvA=;
 b=ll/8MVKg9GMYNLf4+JxmL9nw9070XSX0W/QEucCskBHW7ZiUj5j2WRTZMNh+pWyyEo
 RgmExZrXRLCPVtgWXKG+4WarnSFS5iix/ne4IMlfiWI4lt62pfzRbE2geVQgJZiytbdz
 k6TX9yCAWxvJ4hYGFmeTm37/MoyG++CQsYbFfVnRdMj2EjIoW0G+cnHZfdgpO3Rz+xTe
 Kw0NSAVUbA0l4fECofRMO3lsvUYfM3aODTF06Tyobz/VCZ/usvDHmamezq/sIkyYBk7S
 p0vXEKUc2Qt9EAn1cRQCgclWpRSEA857socofX6Ifd/xwljT3Mv8w2BGnSOLe37efRjt
 36+g==
X-Gm-Message-State: AFuF++mNmiSR+3tSLVMJN/BwqqQ/JPHhic1DvthDO+LMRridAJe15Z5n
 HrSmu0UkfszVF+7UF0TH90hUvHFeeqtNw2EDVMAj5qYTLvt8xras68QORDzg67voDRQ7Js1OEAQ
 hQzsEXooO3Yn4fOiCHxP+P33XGSsSOf57bm9reGC9hIjioLuciD467ayn
X-Gm-Gg: AYBFou2S3RWCq7mi6om8jmI/OlhYcPEcEmJNm10/HXHe7s1QJqO0JgZ3GRYJX19V9Zb
 1lIQh7v3RkRdyP6Wi6AwRF5E08mXTiAfrqjGJBAXbgaoJmEfaaztEmNklL9kUjTJLC6O9Jc+epv
 7ZGfnmcX3Bst0snDCEqFu1rgF8STOL6y3xfdOM/dZgVZh3OMuJd6s14HbOfnAJddpMl0DAtUA7Z
 C7VZe6ur282peI15yEfk+fUSJVyb77JGu6vFcZhHE9544ZiR7t2oB9D+Ah9PFlmh0gW1wfq2K5G
 r0a2zBRp7+1AG2Hkt6VdYLwHbL8NVy1/VYFIS2CknMvczXBfUfxIdltbYzb1vPQF8vYrkbiQYfu
 dO5/qXPPbe7Sou6PzOmDzibY=
X-Received: by 2002:a05:6000:2687:b0:484:482d:dce4 with SMTP id
 ffacd0b85a97d-48589184852mr7965247f8f.0.1788556377313; 
 Fri, 04 Sep 2026 14:12:57 -0700 (PDT)
X-Received: by 2002:a05:6000:2687:b0:484:482d:dce4 with SMTP id
 ffacd0b85a97d-48589184852mr7965208f8f.0.1788556376772; 
 Fri, 04 Sep 2026 14:12:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm9323638f8f.24.2026.09.04.14.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 14:12:56 -0700 (PDT)
Date: Fri, 4 Sep 2026 17:12:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] hw/pci: add IDE + TEE capability to PCIe root port
Message-ID: <20260904171137-mutt-send-email-mst@kernel.org>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
 <20260904-jmac-rme-da-prep-v2-1-fb461d78bbb2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-jmac-rme-da-prep-v2-1-fb461d78bbb2@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 04, 2026 at 05:05:01PM +0100, Jim MacArthur wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 

Please include a commit log explaining the motivation,
alternatives and result.

A possible format:

Currently .... as a result .... we can not .... because ....
To fix ... and then ...




> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c |  8 ++++++++
>  hw/pci/pcie.c                      | 15 +++++++++++++++
>  include/hw/pci/pcie.h              |  3 +++
>  include/hw/pci/pcie_regs.h         |  4 ++++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 5434d693d9..452ebf69b3 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -26,6 +26,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
>  #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
>          (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> +#define GEN_PCIE_ROOT_PORT_ACS_END \
> +        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
>  
>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
> @@ -100,6 +102,12 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>          d->wmask[PCI_IO_BASE] = 0;
>          d->wmask[PCI_IO_LIMIT] = 0;
>      }
> +
> +    uint32_t offset = GEN_PCIE_ROOT_PORT_ACS_END;
> +    pcie_ide_init(d, offset);
> +    offset += PCI_IDE_SIZEOF;
> +
> +    pcie_cap_tee_init(d);
>  }
>  
>  static const VMStateDescription vmstate_rp_dev = {
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4622c75e48..b9ead826ed 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -968,6 +968,12 @@ void pcie_cap_flr_write_config(PCIDevice *dev,
>      }
>  }
>  
> +void pcie_cap_tee_init(PCIDevice *dev)
> +{
> +    pci_long_test_and_set_mask(dev->config + dev->exp.exp_cap + PCI_EXP_DEVCAP,
> +                               PCI_EXP_DEVCAP_TEE);
> +}
> +
>  /* Alternative Routing-ID Interpretation (ARI)
>   * forwarding support for root and downstream ports
>   */
> @@ -1371,6 +1377,15 @@ uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
>      return pci_get_long(dev->config + dev->exp.pri_cap + PCI_PRI_ALLOC_REQ);
>  }
>  
> +/* IDE */
> +void pcie_ide_init(PCIDevice *dev, uint16_t offset)
> +{
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_IDE, PCI_IDE_VER,
> +                        offset, PCI_IDE_SIZEOF);
> +    uint32_t cap = PCI_IDE_CAP_SELECTIVE;
> +    pci_set_byte(dev->config + offset + PCI_IDE_CAP, cap);
> +}
> +
>  bool pcie_pri_enabled(const PCIDevice *dev)
>  {
>      if (!pci_is_express(dev) || !dev->exp.pri_cap) {
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 71ba94874b..db66678252 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -123,6 +123,8 @@ void pcie_cap_flr_init(PCIDevice *dev);
>  void pcie_cap_flr_write_config(PCIDevice *dev,
>                             uint32_t addr, uint32_t val, int len);
>  
> +void pcie_cap_tee_init(PCIDevice *dev);
> +
>  /* ARI forwarding capability and control */
>  void pcie_cap_arifwd_init(PCIDevice *dev);
>  void pcie_cap_arifwd_reset(PCIDevice *dev);
> @@ -161,6 +163,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
>                       bool exec_perm, bool priv_mod);
>  void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
>                     bool prg_response_pasid_req);
> +void pcie_ide_init(PCIDevice *dev, uint16_t offset);
>  
>  uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
>  bool pcie_pri_enabled(const PCIDevice *dev);
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 33a22229fe..aa21177411 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -182,4 +182,8 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_DOE_VER                     0x1
>  #define PCI_DOE_SIZEOF                  24
>  
> +/* IDE */
> +#define PCI_IDE_VER                     0x1
> +#define PCI_IDE_SIZEOF                  12
> +
>  #endif /* QEMU_PCIE_REGS_H */
> 
> -- 
> 2.43.0


