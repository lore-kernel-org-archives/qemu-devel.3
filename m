Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EE6C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfjq-0008Pc-NB; Tue, 15 Jul 2025 09:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubfEc-0000g8-70
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubfEZ-0008Nr-5b
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752584287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rrVsiWinolpy4Unv/XYWKz9b9ipddM/xKTlEg4XOl94=;
 b=Pya2TnpWkKTvkald4+PCpra1qLI4vKA0TJbOF1gzwBxPh9KxwKpf6aRTINlV85/AsSOqQs
 +aB+wDK6H+g7PWPjm1qwsrtlCltKz7mB3yYdV7sGGPJ0RCSqmCxT6B+3vDBHT2Sfv2PgKw
 9xlKf5zgmziUdi221ZvcdBceteHBsw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-62s88rAKPOuDWiXhvg7w0g-1; Tue, 15 Jul 2025 08:58:05 -0400
X-MC-Unique: 62s88rAKPOuDWiXhvg7w0g-1
X-Mimecast-MFC-AGG-ID: 62s88rAKPOuDWiXhvg7w0g_1752584285
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so31302655e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752584285; x=1753189085;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrVsiWinolpy4Unv/XYWKz9b9ipddM/xKTlEg4XOl94=;
 b=eQ1IYUs4gWtyaW9mNtQAdMddTCCcpHu3Yptqnimpgj0KESIhApA2tsuGVHsaeN4Guh
 Z+BoVcP9jQEsIeIDc+bZla7NRCglDEofuFu2nrrn/Pai1ZMkRnUY92bS+6cgYFnVxcmC
 cxJ7K3Y5XatIOfm9qo66GMsWVk0VhKYXkqn/0W1QG9lq5AEl6BuOWZIv6cH9TFgAEKak
 Ooj+lqA4e54ZiyjRrGmPc15I6mxwy50JNGl3gN35KbNZDX9V+q8YmOP/HxBJesFBDoUw
 IyAkoEattuRxU7It8TaXTyE4YsWlWWqzj3ylzfCNoEK6R9LaWSMWJyR7jLDgyjmTGFPH
 cVfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXTJRqc4YiJwlbDjfRuFw+ep9wIhlqgZPv6O8GtG6/aLqTtSflJQWPlCGxIz7SPrFttaDJemwW5PIm@nongnu.org
X-Gm-Message-State: AOJu0Yw7l4ElB3edkti6/IM078I+twbd2ARbFhWoM1+ccCxf8j+fCCW+
 qOK52kBgT/iU4i+qZE3vX2yEDJ/l4i+TSZcEJsq72+nfJ+BYXPndy5Y31krXXgimauaQE9XR6Kg
 b0CsB3K2Ssm/L2k410WmZPI8b61DbPFxUkNmuHFXL4l6pavERSAx0Wkiw
X-Gm-Gg: ASbGncuaqYnbTwFEElTCp6HRc+6gImt+1E/YVvQFoO2ACWiO5WYIVtOo4L1e+weFOKS
 3UDAykCH50Ig5Hb3bNy41omdWVyIRYYGj1yNACcJmS5XV/8RYdBkl/Ns857w3+PQzTxcXNHLTeN
 F90AwTxTkmnI8L44cOVlWCNpK+hpn8e1Wl4hwqHDFV90GnLbwcJsj6VscuArT5IiW88saqSguFv
 NP+xTbwjGQuWvYpZhbGDVU+3bjDq2ANuRc0GGyUCEbw3GGmVrymelaWuQ5tWN1Zfz3OGj6jm+mi
 nuDDZRZ7fb9by45hYd98+nhsUxcEoXJNsX/khSVYe2CTnRLFNja0yZky9Yrt3LaBaZEEswVmi+c
 =
X-Received: by 2002:a05:600c:35d5:b0:456:c3c:d285 with SMTP id
 5b1f17b1804b1-4560c3cd5damr104420045e9.1.1752584284616; 
 Tue, 15 Jul 2025 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+R8wGGZCFSJSKeCje85MBHtvYFvy0NM/50NwgIIkMn+WWVFC8g9bSecSM04lDx3X0PfDQHg==
X-Received: by 2002:a05:600c:35d5:b0:456:c3c:d285 with SMTP id
 5b1f17b1804b1-4560c3cd5damr104419885e9.1.1752584284128; 
 Tue, 15 Jul 2025 05:58:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560db56529sm97349665e9.26.2025.07.15.05.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 05:58:03 -0700 (PDT)
Message-ID: <b2a7accd-9dfa-438c-84a8-af8f07b31f15@redhat.com>
Date: Tue, 15 Jul 2025 14:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/2] vfio/pci: augment set_handler
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
 <1752503222-222669-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1752503222-222669-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/14/25 16:27, Steve Sistare wrote:
> Extend vfio_pci_msi_set_handler() so it can set or clear the handler.
> Add a similar accessor for INTx.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/cpr.c |  2 +-
>   hw/vfio/pci.c | 13 +++++++++++--
>   hw/vfio/pci.h |  3 ++-
>   3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index af0f12a7ad..2a244fc4b6 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -70,7 +70,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
>           fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
>           if (fd >= 0) {
>               vfio_pci_vector_init(vdev, i);
> -            vfio_pci_msi_set_handler(vdev, i);
> +            vfio_pci_msi_set_handler(vdev, i, true);
>           }
>   
>           if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1093b28df7..8b471c054a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -415,6 +415,14 @@ bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       return vfio_intx_enable(vdev, errp);
>   }
>   
> +void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable)
> +{
> +    int fd = event_notifier_get_fd(&vdev->intx.interrupt);
> +    IOHandler *handler = (enable ? vfio_intx_interrupt : NULL);
> +
> +    qemu_set_fd_handler(fd, handler, NULL, vdev);
> +}
> +
>   /*
>    * MSI/X
>    */
> @@ -453,12 +461,13 @@ static void vfio_msi_interrupt(void *opaque)
>       notify(&vdev->pdev, nr);
>   }
>   
> -void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable)
>   {
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>       int fd = event_notifier_get_fd(&vector->interrupt);
> +    IOHandler *handler = (enable ? vfio_msi_interrupt : NULL);
>   
> -    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
> +    qemu_set_fd_handler(fd, handler, NULL, vector);
>   }
>   
>   /*
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 495fae737d..80c8fcfa07 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -218,8 +218,9 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>   bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable);
>   void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
> -void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable);
>   
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>   void vfio_pci_write_config(PCIDevice *pdev,


