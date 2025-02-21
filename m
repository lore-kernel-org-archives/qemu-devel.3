Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF4BC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQ19-0003fp-H5; Fri, 21 Feb 2025 05:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlQ0u-0003dC-U2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:12:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlQ0s-0005i9-Ij
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740132723;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKUGaH1/YlPITyKa31PBCWqIN54Qu5lMgKGyY02DRCM=;
 b=Qj6JZt1K2dM/n5X0yvwr6+LZsHo9ACHn8elz8Zn0zPSpfkIlF4f3akvoz6g/RRCzQ/vP8H
 +FVLb66ziWbpg8PtT52FzHIkedC6jB3pSIwbnGvGDx68obfr2Yx3ZlLdar0DNYnDj91jiy
 QESdx0GchQ0siSmLqOXSjlkFmL3kbEM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-TTtOLaVJM_S4eOqhNLUgIg-1; Fri, 21 Feb 2025 05:12:01 -0500
X-MC-Unique: TTtOLaVJM_S4eOqhNLUgIg-1
X-Mimecast-MFC-AGG-ID: TTtOLaVJM_S4eOqhNLUgIg_1740132720
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so9634645e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 02:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740132720; x=1740737520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JKUGaH1/YlPITyKa31PBCWqIN54Qu5lMgKGyY02DRCM=;
 b=KyPAA9nGmy1gPDQBvSdLapzoORnUtXoK2Sd9NScz4hlUBszHaXPiOPozO1xNgepqTa
 b4A626V5rq8Orl4wL0XwS+ClaBs4wlWDNKxdVI6EPtXfVlPgaLK8ZcC+147k3hmdvTVm
 9XSMgEjsLGWexq62V2QQ0gowfEbIwzjyFmUFpkL18+zWFLYEd9cz0d8ZZDhuNUG0MC3O
 MmMuC4e3emlEmL50wI3UR1ohRePaBpvWtamjCfICasKpDxRriDyljVwTV5SFY3v/Fjaf
 PLHFr9NGU22s/M+enlJ5zgFjp+vHOVkt/ZDyVvkoT/WiMLVf5oFDzZH3jlGqotNosIZk
 CwwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSngZf66anf3mfBmsay2ZbvJnVKfinw6Ueh/GA/gDT2AnnZ6Y5QAUyANrLmWouFcWP2Z+K0bMIOAJE@nongnu.org
X-Gm-Message-State: AOJu0YwNBGlqqGRKDvDWez5F6KdVv3Cbay4yVNNZyKUk8w1pfphex3In
 wfyNDXfwPDb5LuB48bKBJkgSLD/ensbLV6tluh4h6goxMu6akz1lCrtHJDyPJt6caF78mAVH2AO
 YBHUFrVkROUvD/D8o2eUDz1oG5G7IWghTvm6sND58j+7knDgOihQC
X-Gm-Gg: ASbGncur1wLfBNvwgN5+bBWGY3yYOyvXuNWYsHj7ijXFCs+t8536XsIy+MoOaRKugfu
 jI3Yl3X8XQ3mfSz2rs6B7PLWip1MGthbDKZch8MIdTa4OQnN/mQSAWQFJCrrQPU1yKhETvbhu14
 h9O28SzeMdxSztkuOOkJoQ9HWC24A8xjhIGClk9sdIqSEwFcHFzpYFKrQDMCrGNMPBlcCGVFGZ3
 WGCemhaPPz/Zr+VY76JzXKv2RlJtY/+XhTEpZrObcISJDcQuGAPsW6H89q2VxnKBZotZiVIxzkm
 1rrKPsuzabf+TrQj4cotVSxgl2s7ZHjMbklN8MEf87tV6p7uud5/jz+V+7b265U=
X-Received: by 2002:a05:6000:1543:b0:38d:b610:190b with SMTP id
 ffacd0b85a97d-38f6f0bec4emr2174772f8f.46.1740132720405; 
 Fri, 21 Feb 2025 02:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHtK7Xy1fzyOMVc48JBOK/Ga9P+pTISirn+UnM1C8LGDi94Gy+bgP8+JvcaRV6fFauZttq9Q==
X-Received: by 2002:a05:6000:1543:b0:38d:b610:190b with SMTP id
 ffacd0b85a97d-38f6f0bec4emr2174758f8f.46.1740132719996; 
 Fri, 21 Feb 2025 02:11:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399bea8577sm62359265e9.0.2025.02.21.02.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:11:59 -0800 (PST)
Message-ID: <950f4531-7614-4327-856f-45a2a2f9cd21@redhat.com>
Date: Fri, 21 Feb 2025 11:11:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 09/20] intel_iommu: Rename
 vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,


On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> In early days vtd_ce_get_rid2pasid_entry() is used to get pasid entry of
is/was
> rid2pasid, then extend to any pasid. So a new name vtd_ce_get_pasid_entry
then it was extended to get any pasid entry?
> is better to match its functions.
to match what it actually does?

I do not know the vtd spec very well so I searched for rid2pasid and I
did not find any reference. I think I understand what is the pasid entry
from the pasid table though so the renaming does make sense to me.

Eric
>
> No functional change intended.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 7fde0603bf..df5fb30bc8 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -944,7 +944,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
> +static int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
>                                        VTDContextEntry *ce,
>                                        VTDPASIDEntry *pe,
>                                        uint32_t pasid)
> @@ -1025,7 +1025,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (s->flts) {
>              return VTD_PE_GET_FL_LEVEL(&pe);
>          } else {
> @@ -1048,7 +1048,7 @@ static uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          return 30 + ((pe.val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9;
>      }
>  
> @@ -1116,7 +1116,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (s->flts) {
>              return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
>          } else {
> @@ -1522,7 +1522,7 @@ static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
>       * has valid rid2pasid setting, which includes valid
>       * rid2pasid field and corresponding pasid entry setting
>       */
> -    return vtd_ce_get_rid2pasid_entry(s, ce, &pe, PCI_NO_PASID);
> +    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
>  }
>  
>  /* Map a device to its corresponding domain (context-entry) */
> @@ -1611,7 +1611,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>      }
>  
> @@ -1687,7 +1687,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>      int ret;
>  
>      if (s->root_scalable) {
> -        ret = vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        ret = vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (ret) {
>              /*
>               * This error is guest triggerable. We should assumt PT


