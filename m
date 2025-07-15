Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB89FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubitx-0008Fq-C9; Tue, 15 Jul 2025 12:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubiaH-0000S7-A2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubiaE-0001oX-Jq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597164;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTq7bVNHOWGoAGHx8Gz1rQmpRWFQFi8ecsyAHowojaw=;
 b=E3GEkX0idXz+jvwWl/nQ7gqQCpN0A7HDzwltVBL/NrLdSADaTqgG91JIgCUvafHT0mJLlI
 ez60DOzNYc8fmFM0lFrtGNqePnG9EbbqZ8MMuJNrDfEB7R9lEgCglq6QfIiOZUgUDW7xx+
 ki3EudtyVuWplvQ/NlgRFSq7sWeQCw4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588--56BjbIwOyqqktYi-XkHyw-1; Tue, 15 Jul 2025 12:32:43 -0400
X-MC-Unique: -56BjbIwOyqqktYi-XkHyw-1
X-Mimecast-MFC-AGG-ID: -56BjbIwOyqqktYi-XkHyw_1752597162
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so3748341f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752597162; x=1753201962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTq7bVNHOWGoAGHx8Gz1rQmpRWFQFi8ecsyAHowojaw=;
 b=JinKIK8J2I9W4tUlxyCXXdpsWt7Ni2OeIL+3rBDaFbcp3DVUD2PJITYzLZaI/Cwvz8
 jPEdI3AHGyDn4uK6jtqaNtyGN6bF0A86Yb+DudumXB1e4Tj65Hh2bF8ZfoOPbAkihAZI
 IVusggf4EgcCFUbyCfloStLkm2PpTIQ6rUDRv7XWDszjV/kN7wH9sXBn+ctF2JaBNFD4
 Y0HjS4CcVSpYuyXyxFM8rMW2tyalx3ll4ppZncjy4mQ1NZCuaBdVRA0T2F/a18ffYNQW
 xf8HTtjSx9/Hc2BtoNlhK7Vlh+g3Qrkwc2ttyaHhKmkxEgxwUnrVAWQbp0nfnal66T2s
 /WJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0nlcdHpDlA29w2qf4Cv6RfpUCnui19utWetX0ZH9b7nKGfYybFabarCidXCXmCMnTrOjBq1yEp6lD@nongnu.org
X-Gm-Message-State: AOJu0YxvEWX7Osxz/FB5Q1YpME2xGlirQiFf+kD8t3yoLCwo4bKsjltW
 BYC3VF82xggQnBAk2LyHHWJhHyPFNALl9QS2oX0TeZQd68y/ZQSHLRFF18UpBPQguIL+9pAFoK9
 cxnl+/VUQjCQ4p/+svhxfv/DvS42xeFi4OH03ce0Rtc/7SKbAckQjj1CA
X-Gm-Gg: ASbGncuOQgihEo66ZCbnajH/KR2uJ+loqepIiXqe440o2U56gDZ50Vx14at5iCVYE47
 T3I0oykNxQ7i/RfDgK0v6U8foX8Kxim2B0lVUGnVG6vT82zDG2CIrrcbDsLg+8159CUsTrsYcV2
 NowFuQuE8EN7yyA25b8YpYIYpXPMTrooLssy+AR+xPLP268QkZ4WlHXgYxSgKzEDbMwuNeYDsLK
 uWqBadYwjDjii0ItuQ3AE7DzIJBJJ5F7zUnBG0WaZKdwwQnPs78jejB9GPxQETZ554/ilBeKLs/
 OtaZf5Rl3Wt4Db5iMXlfSldKTVPrtOWDjm+lPXAH7womDgoWJusIq0f0sZXvOMHwbrkrjy6Dyno
 yhJyKx3G23UM=
X-Received: by 2002:a05:6000:290b:b0:3a4:eb92:39b6 with SMTP id
 ffacd0b85a97d-3b5f2e3a4cemr13815821f8f.54.1752597162349; 
 Tue, 15 Jul 2025 09:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwTpJ2azlTSmrNOO+Au0S5WywKcGyeTbLN+9Oq2VnDj4/cIxApwwFxkFX2RBxTeWmmKzuEvw==
X-Received: by 2002:a05:6000:290b:b0:3a4:eb92:39b6 with SMTP id
 ffacd0b85a97d-3b5f2e3a4cemr13815790f8f.54.1752597161881; 
 Tue, 15 Jul 2025 09:32:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e3bdsm15327796f8f.81.2025.07.15.09.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 09:32:41 -0700 (PDT)
Message-ID: <ca4a9fc0-162f-44a4-9f3b-86f0020bb483@redhat.com>
Date: Tue, 15 Jul 2025 18:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] intel_iommu: Implement get_viommu_cap() callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708110601.633308-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
> Implement get_viommu_cap() callback and expose stage-1 capability for now.
>
> VFIO uses it to create nested parent domain which is further used to create
> nested domain in vIOMMU. All these will be implemented in following patches.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f0b1f90eff..702973da5c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -24,6 +24,7 @@
>  #include "qemu/main-loop.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
> +#include "hw/iommu.h"
>  #include "intel_iommu_internal.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> @@ -4412,6 +4413,16 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>      vtd_iommu_unlock(s);
>  }
>  
> +static uint64_t vtd_get_viommu_cap(void *opaque)
> +{
> +    IntelIOMMUState *s = opaque;
> +    uint64_t caps;
> +
> +    caps = s->flts ? VIOMMU_CAP_STAGE1 : 0;
with CAP_HW_NESTED
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
> +
> +    return caps;
> +}
> +
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> @@ -4734,6 +4745,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
>      .get_address_space = vtd_host_dma_iommu,
>      .set_iommu_device = vtd_dev_set_iommu_device,
>      .unset_iommu_device = vtd_dev_unset_iommu_device,
> +    .get_viommu_cap = vtd_get_viommu_cap,
>  };
>  
>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)


