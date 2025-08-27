Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98F1CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJje-0004iQ-It; Wed, 27 Aug 2025 13:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urJjb-0004gt-B2
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urJjX-0001Jt-VK
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756314886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZ0w3wgUp+bocnfozpMpppiSvKiDWQu4zJ9c97AIZyg=;
 b=LC18IJT0hLGwLCwwtpRs9WEM2S0mO19+Psjce9eBig5mbjveAmuHP/DOqfyBbsQ3Ust2TM
 eelEw5oyJPyb9HsClWDeiqhz53/YHcd872PPkeOdzANK1ktMInsjwprd70kUEf6yA/fOLd
 dPiona5UF1sTEzACmzEPSqQkNdZuyic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-rknsjoGJOM-AHcpm4SZB6g-1; Wed, 27 Aug 2025 13:14:44 -0400
X-MC-Unique: rknsjoGJOM-AHcpm4SZB6g-1
X-Mimecast-MFC-AGG-ID: rknsjoGJOM-AHcpm4SZB6g_1756314884
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b645707f1so178055e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 10:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756314883; x=1756919683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZ0w3wgUp+bocnfozpMpppiSvKiDWQu4zJ9c97AIZyg=;
 b=X35flq46AUrQvnUUZ4MfuMT8GlK9zXMMnP1V2CJIu65sUOvUc+lPpAeQW+dxfXZ5ZR
 LRGA3Lz5gIbHDVyfA+QU1Ai29PPIgjh36jumkKICaUL2nw+JNcTgfYfj2qMr7lAWZmQi
 5OIOY7hySSUOHrmu7eF+Vnurzm/SgGxvFUVzOEhZY29kl/NczgKiI/jcPefJZKpaOER4
 djmbKZDmrtyD703Dwyj9tlAA91vVpVO2qzGCtwydYzDx8FXP9kChRpC4fBv79zwZr0Be
 WLXIr+wX2aGk2YJgZW8KW1Iq9BDZdxzoUVzudCNFj9vIO53peMCwBTUQDqdpvAaFR+yu
 CVtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIUbqz73pg4bgOfBXm4B/xBhDQfpswMpZzDQpXCnulq3dii1HhJoyUGnSjWZ5EwKYM7Tg7HGfyVoES@nongnu.org
X-Gm-Message-State: AOJu0YxQCELFmfv/gtzYYndeqqHJ5cyKcqtrdzCEKzo41cUkT6fy25sW
 CCYAqCTLrRPn0+Q0zfibd9d0Evq0K2aP0Wgeznyb0flPEJW99mVe3PuKpwRTVTx2m0+F1m1Mw/f
 +szgf16aQfnoUCca5HdLfZpqeG77l/68tJkT+Vpa/g5GvJPS6ZVIaOSWn
X-Gm-Gg: ASbGncvvp/J7RSgeLuI/3rAand9vdJ158QxWBfekbQFXVDvGcGMNxbQqWE9pHti1Z87
 oNQRY0tki1eZWc/Cv+5bvHwZyc37PjyspgVVO6wtXtLXsrCfXIJ+SJfIagwxSm4eMBBz2eZK15+
 8pDbbtXmlTcOmMKxNlB6vP02fYF1HLxLSzOkLVN3ekgMpjxadjeIKDxwwuanrA9Tw9eAI9hKa5K
 C6F9bcwKh6MEKvCEaGfbOxslODLV9JbHVG2gcB8oEpQexpD0OTh3WqsCaHObXwmg2tZ/igRcdIA
 nC2GWtwuhHxXmjMgT/eTgLb9kcEmHdF6gXWBYIRUf2AE/vCZreot7Gfpe/hAkUuGrpjKZqZ6uYI
 hIBMmy0+c4Po=
X-Received: by 2002:a05:600c:1e85:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-45b5179d004mr152355135e9.14.1756314883593; 
 Wed, 27 Aug 2025 10:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDj3U84I0chPxSeMAtEl+LG/nrBuFFZps1pdrnFQSc4p2o8Du61498esK9Z8v4mr1/NivhYQ==
X-Received: by 2002:a05:600c:1e85:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-45b5179d004mr152354845e9.14.1756314883146; 
 Wed, 27 Aug 2025 10:14:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6ee67251sm43520765e9.0.2025.08.27.10.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 10:14:42 -0700 (PDT)
Message-ID: <d223683d-d7ab-4e66-8e7c-907ad1ba7457@redhat.com>
Date: Wed, 27 Aug 2025 19:14:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/21] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-15-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> When guest in scalable mode and x-flts=on, we stick to system MR for IOMMUFD
when x-flts is set on the iommu and guest uses scalable mode we don't
want to use IOMMU MR but rather continue using the system MR or
something alike

To me this deserves more explanation about we don't want IOMMU MR
anymore, from a qemu infrastructure point of view.
> backed host device. Then its default hwpt contains GPA->HPA mappings which is
> used directly if PGTT=PT and used as nested parent if PGTT=FLT. Otherwise
> fallback to original processing.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index af384ce7f0..15582977b8 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1773,6 +1773,28 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>  
>  }
>  
> +static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(IntelIOMMUState *s,
> +                                                 VTDAddressSpace *as)
> +{
> +    struct vtd_as_key key = {
> +        .bus = as->bus,
> +        .devfn = as->devfn,
> +    };
> +    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
> +                                                       &key);
> +
> +    if (vtd_hiod && vtd_hiod->hiod &&
> +        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        return vtd_hiod;
> +    }
> +    return NULL;
> +}
> +
> +/*
> + * vtd_switch_address_space() calls vtd_as_pt_enabled() to determine which
> + * MR to switch to. Switch to system MR if return true, iommu MR otherwise.
I would use a proper doc comment and refer to this function first
> + */
>  static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>  {
>      IntelIOMMUState *s;
> @@ -1781,6 +1803,18 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>      assert(as);
>  
>      s = as->iommu_state;
> +
> +    /*
> +     * When guest in scalable mode and x-flts=on, we stick to system MR
> +     * for IOMMUFD backed host device. Then its default hwpt contains
> +     * GPA->HPA mappings which is used directly if PGTT=PT and used as
> +     * nested parent if PGTT=FLT. Otherwise fallback to original
> +     * processing.
> +     */
> +    if (s->root_scalable && s->flts && vtd_find_hiod_iommufd(s, as)) {
> +        return true;
> +    }
> +
>      if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
>                                   &ce)) {
>          /*
Thanks

Eric


