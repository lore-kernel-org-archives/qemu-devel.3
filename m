Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD74BC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FjX-0004gm-UI; Thu, 17 Sep 2026 13:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x7FjU-0004gd-MZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x7FjT-0004MM-07
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789665428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLLPwpAW2PaOCgEb584xHnHO2JG875EwKRwyJeR4GSQ=;
 b=OqMob+wT8LFja8K5Phz75GDlhAB5lUy3/LFLSE4Fj41uCju0no8oDd7Vhbfhfh6yun+Rz9
 Jgk6OosBpaaRFOWXaeveSCelA2Ok1Ea90hZzWVazKkAbzTlKAAPGJVjG8x+7rLUD+QKdSz
 p1/moKA3d0z9mkTIlc88RI4TmIpsUuA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-vOZMiMVoMA-2CEH345m64A-1; Thu, 17 Sep 2026 13:17:07 -0400
X-MC-Unique: vOZMiMVoMA-2CEH345m64A-1
X-Mimecast-MFC-AGG-ID: vOZMiMVoMA-2CEH345m64A_1789665426
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so8122065e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789665426; x=1790270226; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mLLPwpAW2PaOCgEb584xHnHO2JG875EwKRwyJeR4GSQ=;
 b=Pxv3VEV/ifcQdrqC9j0lyzYGPDgf6oOdhR6gqEAMZaN9+QTdtKHaf9X9JbHCoDXSqo
 KkAy7S28qOlPQlKhKFehcnNMpgX2JuHS+Ik9CSlvtQs5x8TJxUZO/61ue0YIwK96/JSp
 uXEMSp/lfn5o0nmGLAZqxo7NS4LbZBjoBYR+JlSy6r9Hu+gaEClyvz7wS1EODoB7LVyD
 z/r7S2rmlaNGU37PjqMV1ZZF16YSchoRoreX7zbpERvmhw1lZya0Y5krI5m//Q3mzWpo
 sEmKQ09DAUca8u54WLubnknIo3qvUahg9Cy9q3sADH2t++b+DahDe4YR78EaKWNASn+U
 cLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665426; x=1790270226;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mLLPwpAW2PaOCgEb584xHnHO2JG875EwKRwyJeR4GSQ=;
 b=wnIujgZB4UXd4e/TBLbhwcToOk0xwdXxFEuCVW+WC+2UArpOnUssNEq2Hfbr5BcvRm
 8RrMH4YjOT7H449tXv0jawvpiEW5LgBUaysjs3lDiiCtFnJ7zVXH2PNcPnWgBg/epINs
 PIb8aOwCEx3GOZcnefjeQfFA0bq9KlwJHQZJ42f7seHWgxJXXEuFLXUduLRH8x9pJEg2
 sl4BarNoxVYfufoS/gA4LOzLIVNm/7GXDcat32UaCHDD96fsaXJpxGP00ZUe5IumBPEk
 gRSPhbwlRzSggT88hag21I4f75S2kKWhMtXMNj+CCaLGQjOR37dnJHZuUQ+qnA/Fu+nQ
 U0Gw==
X-Gm-Message-State: AFuF++mFj5MloQLCIGEcLH3+NEqCUfEYc70iozccf3zSCs8O1JC1W5du
 zDYxsGLPUP6Hj4CNfozqAqLUwvtff8rWtSSgMjtZ956w5tHWkv8Epcw4HPYypu3lhBJ6yK+A9C9
 4nPp5/+2K4YVJvmyFdtuXiWQqFHQdEk9z1R0gKGdCVviv1YxQ1KUAUB1AbSfFB8iP
X-Gm-Gg: AYBFou0KJ2XLxK7gJe1QAowxy71vX+mFqlA/2vVUAqkdCzyZIsJxunUzZoYBnOIQXHt
 kJl8wq0RGFEO6DRNarJpQEQJije9926powVtT4a12fmi1Tk8Tl8J/AvQSxoFbnrDsrO7GXJy+U8
 ibRmbTOkNFD12hGqzv8v90l3dPW2tI/Bp/AyrwnZSRUj0Ebvalx0eXVsIl2BQBz0e/sVTK+sHXs
 jFmP4bEA3noGJZbc032IpixKBxiGyz4fXo0hSp1NSLHRmXgGrbbq6X5Rntxo/7eBUHE8wL8GLq0
 lBZyRZqgoqJZSrEs/5OdujC0HkzCAgR7fDw6tJejecM1r0lT7JDWRC8fiwBCzoPLJOWlpgBZHHv
 9NG1U82YZ+VryKenzAqZIc9s=
X-Received: by 2002:a05:600c:3b29:b0:49c:fc6c:be06 with SMTP id
 5b1f17b1804b1-49eb733b065mr89005115e9.29.1789665426079; 
 Thu, 17 Sep 2026 10:17:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3b29:b0:49c:fc6c:be06 with SMTP id
 5b1f17b1804b1-49eb733b065mr89004545e9.29.1789665425562; 
 Thu, 17 Sep 2026 10:17:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf462cesm16370722f8f.37.2026.09.17.10.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:17:05 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:17:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lirongqing <lirongqing@baidu.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] pcie_sriov: fix wrong write width and off-by-one in
 pf_reset
Message-ID: <20260917131304-mutt-send-email-mst@kernel.org>
References: <20260917053818.2565-1-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917053818.2565-1-lirongqing@baidu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 17, 2026 at 01:38:18PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> pcie_sriov_pf_reset() restores the VF BAR type registers using
> pci_set_quad() with a 4-byte stride. Since each VF BAR register is
> 4 bytes wide, the 8-byte write also covers the following BAR
> register. Although subsequent iterations overwrite most of the
> unintended writes, the access is incorrect and the final iteration
> can write beyond the VF BAR registers.
> 
> SR-IOV defines six VF BAR registers and does not provide a VF ROM BAR.
> However, several SR-IOV code paths use PCI_NUM_REGIONS, which includes
> the ROM slot and therefore has a value of seven.
> 
> In particular, the final iteration in pcie_sriov_pf_reset() currently
> writes a quadword at the offset of the seventh region. This starts at
> the byte immediately following the six VF BAR registers and can
> overwrite subsequent fields in the SR-IOV capability.
> 
> Use pci_set_long() to match the 4-byte VF BAR register width, and use
> PCI_SRIOV_NUM_BARS when iterating over SR-IOV VF BARs. This also makes
> the BAR count consistent with the assertion in
> pcie_sriov_pf_init_vf_bar().
> 
> Fixes: 7c0fa8dff811b5 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")

i do not see the bug in that version.
do u mean 19e55471d4e8 maybe?

> Fixes: c8bc4db403e176 ("pcie_sriov: Reset SR-IOV extended capability")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  hw/pci/pcie_sriov.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index c41ac95..6122a26 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -229,7 +229,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
>  
>      assert(sriov_cap > 0);
>      assert(region_num >= 0);
> -    assert(region_num < PCI_NUM_REGIONS);
> +    assert(region_num < PCI_SRIOV_NUM_BARS);
>      assert(region_num != PCI_ROM_SLOT);
>  
>      wmask = ~(size - 1);
> @@ -308,7 +308,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
>              return -1;
>          }
>  
> -        for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
> +        for (size_t j = 0; j < PCI_SRIOV_NUM_BARS; j++) {
>              if (vfs[i]->io_regions[j].size != vfs[0]->io_regions[j].size ||
>                  vfs[i]->io_regions[j].type != vfs[0]->io_regions[j].type) {
>                  error_setg(errp, "inconsistent SR-IOV BARs");
> @@ -344,7 +344,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
>      dev->exp.sriov_pf.vf = vfs;
>      dev->exp.sriov_pf.vf_user_created = true;
>  
> -    for (i = 0; i < PCI_NUM_REGIONS; i++) {
> +    for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>          PCIIORegion *region = &vfs[0]->io_regions[i];
>  
>          if (region->size) {
> @@ -463,8 +463,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
>       */
>      pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
>  
> -    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
> -        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
> +    for (uint16_t i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +        pci_set_long(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
>                       dev->exp.sriov_pf.vf_bar_type[i]);
>      }
>  }
> -- 
> 2.9.4


