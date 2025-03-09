Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CD3C28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trGxm-0005nQ-QB; Sun, 09 Mar 2025 09:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1trGxj-0005kN-JB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1trGxh-0000X0-Kz
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741527897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeQRXUeac0cyXNcpET1/Wh49WrmctkonQAKUMBhZahE=;
 b=SUGgyvmouRVFe3zPqN93WGaTYyMravYaD9xIjDEsxnh1XtVrdPTtu1Vattcllz9FL+ZaTj
 uwWjEENLn4XSKWe2D2RJUARd2fws30YBmYT4Z7EFJ73I68DBrf/vV8+mYouo/Vs59I1PFG
 juSF7OX3bUpKjMp2lDsb/Xm6UuzVuiE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-dhxSpzznPpa8vUmpIDXeXg-1; Sun, 09 Mar 2025 09:44:52 -0400
X-MC-Unique: dhxSpzznPpa8vUmpIDXeXg-1
X-Mimecast-MFC-AGG-ID: dhxSpzznPpa8vUmpIDXeXg_1741527891
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bc5a18c52so14616915e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 06:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741527891; x=1742132691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeQRXUeac0cyXNcpET1/Wh49WrmctkonQAKUMBhZahE=;
 b=njtD/q+i/9zBKoH/kViMhKFuAxyGFbqR/pCxdrLycsRE3F1VyAXRYww/a+eMTqvuC3
 1aEc+v3lm6xkzQfc7J75ZPM+ZA4VtrxAQZvYxM0tnV1euBIZO4/etVZNcZkQBlph2d8W
 XmRtZteVN79xTG0AV8SJvUZFjgqhbNuYjoDO+LvoQJ3TLZivPBEfailRkNpZaQuUAQ/t
 Az1RaSMu74eAntmGIuYGx95uvPtoODi7HbTMBTVKy5yXAQfQG6LxjuD4mLjYgj2WLZul
 PdVJN0cPUZao1uvysIpgftfEr85cc/oWFJ9EnhesZ4yXiJtzQrMFRQ84I3q1qjL88sYP
 43ag==
X-Gm-Message-State: AOJu0YzT4SFSMYxOd6Md2kLozDIqVixbXPp1MCNZQsvJyanFGcq3mEOJ
 2stn1VXGZF2tUMhS8xjaWehBKDcy0x40UlhmYLAbPXmCtALTiaITtq+dW/AXpj/u9C4M3vOB2u5
 AcMsgZjbCqLNlTjsaolpC8Pb7iV+5HXROGsfGH8BixC7iU2SFrWeR
X-Gm-Gg: ASbGncuWjMIYTqsv0t3ZOG+9iEmaZH4cqH1eoeou82WRbQoyt9gp3yVluW5+1172tri
 WcNwLRM07gGHs0lHRZfshu3QadpeLJL5tyrRa73nRUeR8jMlyHXZ/ymR+wIe4LYE1X/GECpuoc4
 45/JsmssrrUfCbWgm7EBPFHn+wNxQQzF9NPjE2FEc2eza9bAohFcrHdbTl6LWII1jvkR+Ii/luS
 7CzAGUXU/NIiiDI9ga72vsVNbn56CqxzitU36kzHS2kHDcq+uWYU2lsGzMsHBiMxWw47LuTBvp+
 /Ts2k4N7Gg==
X-Received: by 2002:a05:600c:1d03:b0:43c:eacc:9d68 with SMTP id
 5b1f17b1804b1-43ceacca125mr25621065e9.20.1741527889310; 
 Sun, 09 Mar 2025 06:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXkv3HVD9fxvENVNk4LatFdn0te6WVj51hT/4P49ZwAQAdPWN9rcWSjXJf1Wx0GrCc6fF7A==
X-Received: by 2002:a05:600c:1d03:b0:43c:eacc:9d68 with SMTP id
 5b1f17b1804b1-43ceacca125mr25620835e9.20.1741527887423; 
 Sun, 09 Mar 2025 06:44:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceaac390bsm47922525e9.35.2025.03.09.06.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 06:44:46 -0700 (PDT)
Date: Sun, 9 Mar 2025 09:44:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <20250309094039-mutt-send-email-mst@kernel.org>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I/O
> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
> device is platform-specific.
> 
> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
> undefined device id.
> 
> Therefore, change the vendor id to Red Hat and request a new QEMU-specific
> device id.
> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Will the existing drivers bind with the device then?


> ---
>  docs/specs/pci-ids.rst | 2 ++
>  hw/i386/amd_iommu.c    | 3 ++-
>  include/hw/pci/pci.h   | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 261b0f359f..2416a70a2d 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -100,6 +100,8 @@ PCI devices (other than virtio):
>    PCI UFS device (``-device ufs``)
>  1b36:0014
>    PCI RISC-V IOMMU device
> +1b36:0015
> +  PCI AMD IOMMU device (``-device amd-iommu``)
>  
>  All these devices are documented in :doc:`index`.
>  
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index dda1a5781f..4d8564249c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1766,7 +1766,8 @@ static void amdvi_pci_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->vendor_id = PCI_VENDOR_ID_AMD;
> +    k->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    k->device_id = PCI_DEVICE_ID_REDHAT_AMD_IOMMU;
>      k->class_id = 0x0806;
>      k->realize = amdvi_pci_realize;
>  
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 4002bbeebd..da44e6673d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -117,6 +117,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
>  #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
>  #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
> +#define PCI_DEVICE_ID_REDHAT_AMD_IOMMU   0x0015
>  #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>  
>  #define FMT_PCIBUS                      PRIx64
> -- 
> 2.34.1


