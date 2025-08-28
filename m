Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2D2C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZSp-00066a-2n; Thu, 28 Aug 2025 06:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urZSb-00063Z-0E
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urZSZ-0002wN-9l
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756375341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGvOjx+EiwfGOe68elXHUjM0BRlPK3s4OTokE9I08y8=;
 b=TOOWliV0b1/Zkqi+4MVgyxRvL5sL77h/FfUQbZuO4RtH3PMetYyAdtrG7HIoL5jXRnEM2H
 /m4xlxzvLMyfrULgqhrjNCAYGCWOZWpELyQvn+Y9fdUeFkmXj21v6OCMHY9FjDitd3jHr/
 1PQk8vzV0QCyx+OdRKvDXYgNtEWXDCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-BepPHKmjMIa2qbG40FuOwA-1; Thu, 28 Aug 2025 06:02:19 -0400
X-MC-Unique: BepPHKmjMIa2qbG40FuOwA-1
X-Mimecast-MFC-AGG-ID: BepPHKmjMIa2qbG40FuOwA_1756375338
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b71fe31ffso4454935e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 03:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756375338; x=1756980138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CGvOjx+EiwfGOe68elXHUjM0BRlPK3s4OTokE9I08y8=;
 b=VIMnVTfKE7fFxhyEm7QwSYZpHJ4tJExKJ7nzZ0+t5AMtlOuKZj5ibGI416BUTjn42p
 pGn9FS4xd3j8S+XdpNBdqeAS2EaZkfSvGo48BKxycJi895qlAK2CpYvOFyzcRozGgYdW
 n3aNOHS1msIL2PL85eNmVLare6p5HcT+xRtRTPAGVhyqx+Mv76xKb7w4Tjr/v9m/7ysw
 MoKtIjgUr14maAvghxuplVptN466sSMqDSeMUtvHJtiAtLsmWn8Z5ULiSGYjmNPa+mAG
 He5NVlwIIwQuvdtGX1g110Nu3SYB0MriwMvP8V45FD+ERudKjUTKL0z+koVO1wxb7q4R
 f71g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgRoxMKSTsxx/y02j2GBw/I0BonVabdyHA4ZtmpaFOEk68lhkB/WNOTopm0/bs/XcqmIW2o9ihNktJ@nongnu.org
X-Gm-Message-State: AOJu0Yz5n7xqwuixMnROD3YNlnNA7Nhz9KJBznl1GFuornNXPMXvO/7F
 rwkvOOxbJuimK3afR1NYdzp/4NmHafS1sOJrsQ5G6XgZSRtL0jGWCf3/acwqv4S5+5MxCJdJIh+
 uB0dfVCvrAfz9ty2iTLPikqWjr2wlFAqj8YkY7glTvDaNxoyWbOnfUz52
X-Gm-Gg: ASbGncu9dbCRIVfilLUe0fNWG5EyAX41q31TOAUN8i8wZkEOWP6S5eDuIGhyfhz7Fqd
 BX8JzsRuMqk72uDESC1KWzbLsA/aswsFlylicqGk7mVesBQdDP7cft/NhKnAiGKAkX2d0kmHawt
 1g9bdq5OwpEEJi64MYlh1F9K2RDM/+hp2HY5Rm6+zHIUE9SU0FiYuatlCGmpxB/V7MeGe7fLV6B
 jbZAALhsiW9WAWvQClKHeQKCgH6Ok6PD+3xjWZ2ZvBXdG/S6prZ4Av8tb/wVh8jzh0dpSh1yoky
 QjYYsPHBODsubUWI2ZJhqV4iFMUevRMcAVwVeYJkVXeJ0Q73evO5lAiVTRdpRJkGQ+LXbDSC37H
 QW3kuuV9oxRA=
X-Received: by 2002:a05:600c:3b15:b0:458:c059:7db1 with SMTP id
 5b1f17b1804b1-45b517d4580mr219184105e9.30.1756375338306; 
 Thu, 28 Aug 2025 03:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsKHg2XUKyJjFPtdEFYGYKLwuRYFUZA95kiFl6EFECyU996RK8rEQlOIcsx/3hB87EAcwAFQ==
X-Received: by 2002:a05:600c:3b15:b0:458:c059:7db1 with SMTP id
 5b1f17b1804b1-45b517d4580mr219183275e9.30.1756375337539; 
 Thu, 28 Aug 2025 03:02:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cca0dd7014sm6588044f8f.13.2025.08.28.03.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 03:02:16 -0700 (PDT)
Message-ID: <5b3253fc-b3ea-4120-aad8-7287af6ad04a@redhat.com>
Date: Thu, 28 Aug 2025 12:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/21] intel_iommu: Replay all pasid bindings when
 either SRTP or TE bit is changed
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-19-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-19-zhenzhong.duan@intel.com>
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



On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> When either 'Set Root Table Pointer' or 'Translation Enable' bit is changed,
> all pasid bindings on host side become stale and need to be updated.
>
> Introduce a helper function vtd_replay_pasid_bindings_all() to go through all
> pasid entries in all passthrough devices to update host side bindings.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/intel_iommu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 7efa22f4ec..f9cb13e945 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -89,6 +89,7 @@ struct vtd_iotlb_key {
>  
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> +static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s);
>  
>  static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
>  static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> @@ -3050,6 +3051,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
>      vtd_reset_caches(s);
>      vtd_address_space_refresh_all(s);
> +    vtd_replay_pasid_bindings_all(s);
>  }
>  
>  /* Set Interrupt Remap Table Pointer */
> @@ -3084,6 +3086,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>  
>      vtd_reset_caches(s);
>      vtd_address_space_refresh_all(s);
> +    vtd_replay_pasid_bindings_all(s);
>  }
>  
>  /* Handle Interrupt Remap Enable/Disable */
> @@ -3777,6 +3780,17 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>      }
>  }
>  
> +static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
> +{
> +    VTDPASIDCacheInfo pc_info = { .type = VTD_PASID_CACHE_GLOBAL_INV };
> +
> +    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    vtd_replay_guest_pasid_bindings(s, &pc_info);
> +}
> +
>  /*
>   * For a PASID cache invalidation, this function handles below scenarios:
>   * a) a present cached pasid entry needs to be removed


