Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28999CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2Xy-0004fE-SO; Mon, 01 Sep 2025 07:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2Xo-0004ZZ-4O
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2Xm-0004r9-AR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kWTU4bILSuZYsIeV1wFLJONleX24OYtDFuupJRy7CtE=;
 b=UBtMiFQ8y4vtiy65C2+SVQj3fx+HfqJ2VqvfOFKedOcw8Lg4tfGJBdzNeUMhPa8CVRP4JU
 j8epAQH3M11Nr3dlEBsHRFJShg4a/L9gGTIG17XoeRENwwf7oizBR4Vf7FBuctWqMEelK3
 Vsxk8c3v1/JTq7bViqS69+CyldOqSpM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-BeMBQsL3Op6_WZlJAEzRJA-1; Mon, 01 Sep 2025 07:17:47 -0400
X-MC-Unique: BeMBQsL3Op6_WZlJAEzRJA-1
X-Mimecast-MFC-AGG-ID: BeMBQsL3Op6_WZlJAEzRJA_1756725466
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b883aa405so11198815e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756725466; x=1757330266;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kWTU4bILSuZYsIeV1wFLJONleX24OYtDFuupJRy7CtE=;
 b=oUyMfVepYphN5qJsIlpodEYNTKC5NBjb66XfnnlxrQ/U/htOJ2szK52DZae8rktROd
 4BmW2c0gFvZe5Ac8zNewzw392VAX3myj2NPj9BQox9Cs6bKcKwYrwJTdWAqEZPq5Ld1c
 71G1Jj4dBXwJ21Cmgwi9YXcDwZXdm6VwAyiWb2zRj3vfoDCDmy9mhBpmDwlajP8qv4NJ
 o+O8QS3aOBOZ8CxYazx6H6Nb15j6SMC8I+ZNc0TismoZiMFSvVtYkXmVK+3iGzKYzQxB
 c26p1GwF3BP9Esik3KGSFx+vr+4ND1lgSGMez6Mi3HBAzQCCNr1iJp0eaei+0EG2MEcj
 rA4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX75mrxMGTbYm9QLjIizxDnpiCATZ1UElXHIP9HN3QtoXe0YkZHngS2ICssOPgUQAcY/RUP3ohkyvEX@nongnu.org
X-Gm-Message-State: AOJu0Ywf2Qhex21ywa9Qwb2y0XIYVJSx4Gz5+APT8Q9QA891v0/8xVxr
 6KOUK6UF+QyTjZ67E3uINvK1T+kk76dvtmTxzPj1kj24aWtv/GvF2hWy7M8Snp464oxjF64HPo1
 x+m+goNxznX7CBUr2JCWX/1/Om92btIwxdAy3AmZ+25xdCeuk8PwTHxQy
X-Gm-Gg: ASbGnctQwxJBTgAWh6x1xbmLM29Nsfv1SgkSIxriUdeXL459mNuTIDZwztPsJzSNO27
 nTbBA2pwZUGhj1qntP5bu77e2VkuKNKPfwqWaNeGtOzZ1Z0sY4OAoukpI8c6iGAVm5YUpOgRf3P
 n7izXZc9h+rH016LgqBLXHKD5OL9RrbcXQOX59B0GkEmXP2rOi9BtPKIQwXnTjfGPLIEzTmHLAe
 WcBz+3rABh229b3fGGCIyUery2R5aux47iQyHcO8atSNz7ULlLpTW3FB6GUMP32IiIWQG2SEo9n
 sxqTvlc5vtcImCUQfK8UrrnDFzRy9H0vgc/ZGfUCT99kKVmKht6uCQHMbifpONVAL6Kx/e31i6z
 dka4=
X-Received: by 2002:a5d:64c7:0:b0:3d0:ae58:e337 with SMTP id
 ffacd0b85a97d-3d1dcb76478mr6446861f8f.14.1756725466174; 
 Mon, 01 Sep 2025 04:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO9UIwtoYszt9kW69YvMd/a3j0gpvtAK00ZjgGe59qGb66weBOFnHbl/syoPDsAVYfVnAEcg==
X-Received: by 2002:a5d:64c7:0:b0:3d0:ae58:e337 with SMTP id
 ffacd0b85a97d-3d1dcb76478mr6446841f8f.14.1756725465702; 
 Mon, 01 Sep 2025 04:17:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf275d2722sm15060393f8f.19.2025.09.01.04.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:17:44 -0700 (PDT)
Message-ID: <e3e6f261-4bc5-40f4-b3f9-65d2293e9276@redhat.com>
Date: Mon, 1 Sep 2025 13:17:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] s390x/pci: Reset a device in error state
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-5-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250825212434.2255-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/25/25 23:24, Farhan Ali wrote:
> For passthrough devices in error state, for a guest driven reset of the
> device we can attempt a reset to recover the device. A reset of the device
> will trigger a CLP disable/enable cycle on the host to bring the device
> into a recovered state.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          | 7 +++++++
>   hw/s390x/s390-pci-vfio.c         | 6 ++++++
>   include/hw/s390x/s390-pci-vfio.h | 2 ++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index af42eb9938..c9c2d775f0 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1493,6 +1493,8 @@ static void s390_pci_device_reset(DeviceState *dev)
>           return;
>       case ZPCI_FS_STANDBY:
>           break;
> +    case ZPCI_FS_ERROR:
> +        break;
>       default:
>           pbdev->fh &= ~FH_MASK_ENABLE;
>           pbdev->state = ZPCI_FS_DISABLED;
> @@ -1505,6 +1507,11 @@ static void s390_pci_device_reset(DeviceState *dev)
>       } else if (pbdev->summary_ind) {
>           pci_dereg_irqs(pbdev);
>       }
> +
> +    if (pbdev->state == ZPCI_FS_ERROR) {
> +        s390_pci_reset(pbdev);
> +    }
> +
>       if (pbdev->iommu->enabled) {
>           pci_dereg_ioat(pbdev->iommu);
>       }
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 87ecd06a81..a11ec770a7 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -158,6 +158,12 @@ static void s390_pci_err_handler(VFIOPCIDevice *vfio_pci)
>       return;
>   }
>   
> +void s390_pci_reset(S390PCIBusDevice *pbdev)
> +{
> +    VFIOPCIDevice *vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
> +    ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET);
> +}
> +
>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>                                  struct vfio_device_info *info)
>   {
> diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
> index 66b274293c..c28dafeed8 100644
> --- a/include/hw/s390x/s390-pci-vfio.h
> +++ b/include/hw/s390x/s390-pci-vfio.h
> @@ -23,6 +23,7 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
>   void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev);
> +void s390_pci_reset(S390PCIBusDevice *pbdev);
>   #else
>   static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
>   {
> @@ -41,6 +42,7 @@ static inline bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>   }
>   static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
>   static inline void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev) { }
> +void s390_pci_reset(S390PCIBusDevice *pbdev) { }

static inline void ... ^


Thanks,

C.



>   #endif
>   
>   #endif


