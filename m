Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A7EC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gK1-00030g-Dz; Wed, 02 Sep 2026 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1gJz-00030Q-TZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1gJy-0004HK-7N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788337669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XIJ3kQujLCKSWLtFqQxhpjoCKWLt35C8Ggbu0Nem0M0=;
 b=BDCfTn84yxtIkIgLZOBVrWQy+D/RwqTiDvApm8ructONwBsF6cI1+xPhn5dg3TTjk/TrAj
 EIC8AoEIYgr67c6ord+Pl6wSCBx/4na4ZH/Laccw2WWuM6EixS/NAxLAsI0CG5Tahbbv7x
 CdQmlR5WmTBQwaSVBsCcK/R/sen/mdA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-NZc0OR-KNdiahrobRSi0eA-1; Wed, 02 Sept 2026 04:27:48 -0400
X-MC-Unique: NZc0OR-KNdiahrobRSi0eA-1
X-Mimecast-MFC-AGG-ID: NZc0OR-KNdiahrobRSi0eA_1788337667
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c25501f4aa2so100100866b.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788337667; x=1788942467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XIJ3kQujLCKSWLtFqQxhpjoCKWLt35C8Ggbu0Nem0M0=;
 b=KmrglAQFbk7dU8tbS++iE4/g4iEGvWm7dsGJXGPQUCKVYV90QapxtTExfmtMuBtBcG
 2kQTvQm/rTWhzDCh9HOcVD+FE6987uwri1dYYMiah49VRZMhKFfztJEFVZ11oGlCbmvO
 DA42YDFBKMD2KvmF7NlnkjMLuZrQAbdl8uwWf6ypzs2z0SdYUJREKiU0qQAeO4/Et4El
 gd6+lfEeWsxgcI6o0kgx0ujU6X96q2u6umapEfQhAyLbHN+QkHQfRrvXSvckmXOfTHc6
 nzrAQTGW2+kKG8+sh59TRANyrN1tmR2VRIAUbtHhZOPG3UjsVSydxP8bLpePiZiZ6rex
 ptiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788337667; x=1788942467;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XIJ3kQujLCKSWLtFqQxhpjoCKWLt35C8Ggbu0Nem0M0=;
 b=gDzQ9b6RK4Z+oIKYYDdpfOV48BASHexWyAF1VAmqIpJu460h0KQmKxb5Gtrn29zL4X
 XJFkLRaa3VEPwAgdiD2PNuN5HjXfrn4JKXkrP9JWGNdrjfvbj6DshtQft0/PiLyd0Ura
 6l9Kmbh3EYUs3cjkAO6ujMEZk4OOr6BZxCtj2HIJAGX4w69003337AWkWv2xiGc45QtZ
 zJLvDLBb8iDt8UZdhZOMlLE5b5D63xeE0luxm2DeGk8LqNrVpGLaatvF0/mJl6n/30/Z
 QKeEGNCtAiPkR0WoIgxY7UTMhnzKIRMFD6Civ46eQrmfpqdHEvMGe7zMgTNPV2gP35KY
 HNBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUpozZziO0P40So1b//4sAi9MbLTlPa773Et7tuwy49r1/kCzhgDeiRCePXiVolxD72zE7zfboWu/D@nongnu.org
X-Gm-Message-State: AFuF++lOQGrpP3lB5IHqg5pRa8RMOdKWGTu2EnO27OeIX27PcjMHHLzA
 2wCd5e17codHk8ALXXCIJFTaysPAvH3vd26ONUCpfKNVDNHsgexu9Id/LgCwS8PX4BHE57TXOMu
 OHTat47fE1mEJFypZcT3ahTXEtz6U1GIuAbP3uv7hWREZu22Pf6mE9WYO
X-Gm-Gg: AYBFou1mVfoBn4stdxxv6IW0LDuUP2TxpVI4E45xO/w5ENXys1XQr92XjW1FPkRd1yV
 +4rJXO41py0kgtMTwtHqO+/1YRRx+9tmF9Plcmfdv2kHPAcG8C8JVqjGe4AQs2exoyudIfjnxbi
 xxWmhD3LInmaD6DT+OvjV+LRLdFKrTLRqbpKcLXqEcbg3phE/oVA+PhHMoTcwq6VNT7RLhyemhD
 QDsOe21Fc+ZzYv1hYOZrhkUcf5zOC8uxntkcEVV6rp0D3dgXnw4t+scPWboX3Dj1mdNFSTXGdEa
 MUUtt8vjAF8nONTeZpwDorv02Fsj0L+gxsdbLKe8BuEuPBWCrjXlMRYV4RnyD+x29f+VUaIShoG
 XHEAvjogrf95ail7AWq8kTm6WE+2VtPUBDnd4Di0=
X-Received: by 2002:a17:907:3fa6:b0:c1c:2218:f317 with SMTP id
 a640c23a62f3a-c25dc9bedbcmr83979766b.2.1788337666825; 
 Wed, 02 Sep 2026 01:27:46 -0700 (PDT)
X-Received: by 2002:a17:907:3fa6:b0:c1c:2218:f317 with SMTP id
 a640c23a62f3a-c25dc9bedbcmr83976766b.2.1788337666385; 
 Wed, 02 Sep 2026 01:27:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d0058a6bsm91899266b.24.2026.09.02.01.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 01:27:45 -0700 (PDT)
Message-ID: <7af10759-402d-43de-b590-dab0368d6273@redhat.com>
Date: Wed, 2 Sep 2026 10:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] s390x/pci: Reset a device in error state
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-5-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260831183151.12626-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 8/31/26 20:31, Farhan Ali wrote:
> For passthrough devices in error state, for a guest driven reset of the
> device we can attempt a reset to recover the device. A reset of the device
> will trigger a CLP disable/enable cycle on the host to bring the device
> into a recovered state.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          |  7 +++++++
>   hw/s390x/s390-pci-vfio-stubs.c   |  4 ++++
>   hw/s390x/s390-pci-vfio.c         | 10 ++++++++++
>   include/hw/s390x/s390-pci-vfio.h |  1 +
>   4 files changed, 22 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index b2db7f3df4..283b5b62b0 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1546,6 +1546,8 @@ static void s390_pci_device_reset(DeviceState *dev)
>           return;
>       case ZPCI_FS_STANDBY:
>           break;
> +    case ZPCI_FS_ERROR:
> +        break;
>       default:
>           pbdev->fh &= ~FH_MASK_ENABLE;
>           pbdev->state = ZPCI_FS_DISABLED;
> @@ -1558,6 +1560,11 @@ static void s390_pci_device_reset(DeviceState *dev)
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
> diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
> index 9fc84ca135..c68c612038 100644
> --- a/hw/s390x/s390-pci-vfio-stubs.c
> +++ b/hw/s390x/s390-pci-vfio-stubs.c
> @@ -36,3 +36,7 @@ bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
>       error_setg(errp, "VFIO not available, cannot setup error handler");
>       return false;
>   }
> +
> +void s390_pci_reset(S390PCIBusDevice *pbdev)
> +{
> +}
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 9a63040e22..64eb28104b 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
> @@ -172,6 +173,15 @@ static bool s390_pci_err_handler(VFIOPCIDevice *vfio_pci, Error **errp)
>       return success;
>   }
>   
> +void s390_pci_reset(S390PCIBusDevice *pbdev)
> +{
> +    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
> +    if (ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET)) {
> +        error_report("Failed to reset PCI device %s : %s ",
> +                      vfio_pci->vbasedev.name, strerror(errno));
> +    }

and pbdev->state remains  ZPCI_FS_ERROR ? I don't see it cleared.

C.

> +}
> +
>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>                                  struct vfio_device_info *info)
>   {
> diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
> index c7886b63ea..38ccf445ea 100644
> --- a/include/hw/s390x/s390-pci-vfio.h
> +++ b/include/hw/s390x/s390-pci-vfio.h
> @@ -21,5 +21,6 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
>   bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
> +void s390_pci_reset(S390PCIBusDevice *pbdev);
>   
>   #endif


