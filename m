Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA53C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf20z-0000fm-EP; Wed, 01 Jul 2026 16:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wf20x-0000dp-Cw
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 16:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wf20w-0006kA-1q
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 16:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782939512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xlqzwEVJ//eselTUqbL0rhg4LsLoCt7QKcRQ0ES1vlE=;
 b=UZTZvORC2CotIGl1Nnapgdg0x2kgNlg1WLT8qDnrHBoWE48BTfzizqaeudaY85h7gBvNnz
 3Wk7xBnM3aCy9mrTR0bhssZuNnyZsy9lwyTIra89ydAd+ALZoGmBpAU7T+veTr3gmLZ8YR
 cKpXQzmCAWM/Z6KrpXDQ3O8Bt7gKRfo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Ad8wTVRJOymPZ-GVRly1-g-1; Wed, 01 Jul 2026 16:58:31 -0400
X-MC-Unique: Ad8wTVRJOymPZ-GVRly1-g-1
X-Mimecast-MFC-AGG-ID: Ad8wTVRJOymPZ-GVRly1-g_1782939510
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473bc66c837so833261f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782939510; x=1783544310; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xlqzwEVJ//eselTUqbL0rhg4LsLoCt7QKcRQ0ES1vlE=;
 b=FVT9cA/NbXwytwkaCRA/iXGekZ9O69LbNN8+/greUyEMWlVV+VFMELCGW5qbiLzihB
 UGG5gjWQ1+IDEo8vLxh83AoBuXLJ/MbQR/YKLEvwcdo7D1/ORg0hEhx5nZXfRLKhfF/a
 rNHgih/Ld6+WRCgZ0OZbjulBoiAunNIfFItwWvqLQYnx7DMK1njmLqUgy91Gr1w66eTS
 DGYDBzLbNT7Ba6Xm9+ISr85HejlfsC6AHG636uKtOZRSiEe2TRt9sA9CUjtpgN0Z6rC/
 g6IQa+d3kx/o+qedXDGCrvwm0eCmG0uXeMKZX3rna4PILcM8Kj3SxSzK21M9iMwz+1+1
 WRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782939510; x=1783544310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlqzwEVJ//eselTUqbL0rhg4LsLoCt7QKcRQ0ES1vlE=;
 b=VtSZ24vJ4iCW6P/kEi75Lt7/VcbKMWFKhN1aHzIaPCAD1DfoYbROshVC1z7nfC4vJP
 yrsLzXrkUkvtqWdNQrJLuLsCREtK0qK7I0dSKpal0yD+/HDZYHe8ilD84hPV0pvE50qD
 b/4YIMPIwkIZ7nJ7/iclv1hrTjhwGeyp8xpZXOA8M6qU0WDmaD+ykSK2CV0cVC5mZryQ
 vfZbSrShQgzIcg31BG2L4ReWNwCPz7nTVov37PQ55MLipM3UqGCzL0WaGH5/KTFYneBN
 tCs+9cfAl2yydO8jNYjyu7B9KKwkpYWtjdjZXQVvW8HhC/WhbDEtSp+hOHAt7BlnKNYj
 o30Q==
X-Gm-Message-State: AOJu0YxgyaPyvoc4LJUs2QEvGmr2Vi6ammMKGVml1GEkJiWEWR/Uc5Ra
 Kpn04RSFWmdhvpsHPAlaor9gWPEILJgBLQm/fwWF4dV20tR0EYX0VX3vHG5c9BWIRJ8TeIROowd
 vghOZNB5OBF6N2k/DaWw0bb0PQJObcJDtlUkHr2d2gd5a40pPZXaRNyR0
X-Gm-Gg: AfdE7ck0m9Q8YsnQOj4Qmd37BB+rONbwNssCHwsPIu/4NShlReo7r5Gy/L/XT1vSx4P
 L/cqxzTjF8VBS1Ua+zV7h/VWX34x7VqrIsccG9FpE11t+ksPf7Puii0wSgvNVzCA2QU2a4MQmVa
 8v1H9g8twePBEKTv+ba3ZIDUarqZK3vNYRIjHg7pRjpEDt/de+2RQv944rsSnL0nz1F4JLX+qd6
 678lgk0fO+BrlpTSiVJw9iUdU61IVD+/AQnxKjVLeOraLnHj17h6LXyldGWZ3lb8tGYY3smdyvZ
 9utd1VGgGVYXkqw4g//Sx7uoD1pgcDvB4fiszZzZz5zv0o8Y07+PeYj5FNrbqU7zfJdmi8obz0J
 3d2dDDOdA1ERUyzaFsbmkSS2wnQJGicGy
X-Received: by 2002:a05:6000:25f5:b0:471:2631:9d7e with SMTP id
 ffacd0b85a97d-4775aab07d2mr5078361f8f.27.1782939509735; 
 Wed, 01 Jul 2026 13:58:29 -0700 (PDT)
X-Received: by 2002:a05:6000:25f5:b0:471:2631:9d7e with SMTP id
 ffacd0b85a97d-4775aab07d2mr5078340f8f.27.1782939509262; 
 Wed, 01 Jul 2026 13:58:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba0esm2573110f8f.7.2026.07.01.13.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 13:58:28 -0700 (PDT)
Date: Wed, 1 Jul 2026 16:58:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 K S Maan <kirandeepmaan45@gmail.com>
Subject: Re: [PATCH v4 1/4] hw/pci: Introduce romfile_fixup hook in PCIDevice
Message-ID: <20260701165814-mutt-send-email-mst@kernel.org>
References: <20260701182035.96010-1-tomitamoeko@gmail.com>
 <20260701182035.96010-2-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701182035.96010-2-tomitamoeko@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 02, 2026 at 02:20:32AM +0800, Tomita Moeko wrote:
> Some devices, such as VFIO IGD passthrough, require device-specific
> fixups on the romfile provided by user. Add an optional romfile_fixup
> hook to PCIDevice. When set, it is invoked from pci_add_option_rom()
> right after the image is loaded, receiving the ROM buffer and its
> size. This provides a place to post-process a loaded romfile without
> leaking device-specific logic into the generic PCI core.
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>

fine by me:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci/pci.c                | 4 ++++
>  include/hw/pci/pci_device.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4298adf5a0..7d30d44411 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2632,6 +2632,10 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>              /* Only the default rom images will be patched (if needed). */
>              pci_patch_ids(pdev, ptr, size);
>          }
> +
> +        if (pdev->romfile_fixup) {
> +            pdev->romfile_fixup(pdev, ptr, size);
> +        }
>      }
>  
>      pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 5cac6e1688..a65e77018c 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -159,6 +159,7 @@ struct PCIDevice {
>      bool has_rom;
>      MemoryRegion rom;
>      int32_t rom_bar;
> +    void (*romfile_fixup)(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
>  
>      /* INTx routing notifier */
>      PCIINTxRoutingNotifier intx_routing_notifier;
> -- 
> 2.53.0


