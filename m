Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C167C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22T4-0005gJ-Rt; Tue, 08 Apr 2025 02:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u22T3-0005fn-Pm
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u22T0-00040W-Ub
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744093789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ni8jlYGbpKhbedTtipHAZo3MttXvmKU5tMGoQKAYPV4=;
 b=OCOq8E0VNzc+F/enzAQudkJJxFPaqfdKar9gAbkCdGFtYFmqEX839dt5ZxO58Smdty4VQ/
 Jfyrx60hdHlpUD5oD1y6zLNG6HdjzhLfMbB3+PxFNf3/PBmWkAeXwawl8Nuxc8nJMr5kdF
 NXnkwOHka/zwn6qKtUgIsgsqqApWX/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-e5IUtT8_N4i-_AsmlYKYYA-1; Tue, 08 Apr 2025 02:29:46 -0400
X-MC-Unique: e5IUtT8_N4i-_AsmlYKYYA-1
X-Mimecast-MFC-AGG-ID: e5IUtT8_N4i-_AsmlYKYYA_1744093785
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so1964058f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 23:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744093785; x=1744698585;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ni8jlYGbpKhbedTtipHAZo3MttXvmKU5tMGoQKAYPV4=;
 b=oGnUCfkcLL881EwNVsJprgmpbRHbWb8UAZ5kKdU+XJFU66vTxXrNMCKwcBSHH742Be
 oLjLvXmewWPD3yMKIwUhcvgVXFRD6UbLx2TrKq57enB+r4Esqj+ysAL3VC1dY0FOMGgS
 0ctpnRB4u5rvB8/1/w4gkKntilw7xuQ7lVXTC8cAS+RO5GAV/U2J0FUCAikjap0Lu4yt
 nvOVJrvqCtjfTgWjdYHPyp6tJbi6L4Fde+KTcC6clirPTPu0saVE/v64Xkjn/QQlsW1N
 VuhwKuYaYtSKHF4J5DyVVJ5nSrLKx85mB5EusLnBzXaixHJ9ZYJRuEnEl8RrgTEQzGLW
 WAuA==
X-Gm-Message-State: AOJu0Ywrq8hrFWqn4+23cH8ccuZjDddVisTTKBOcN1IFaW3bYRo0qo86
 bB6W1v4Tjn0sshcvSciZENvFFWS4ZMdWHTDwk6RRpKlD71y/zegKv1HEZ6rQ+/kWj+nd4HCQG9m
 cPJFXSNbroMbCwFpRMe4VK1q+BAZdrTl833lrj3mYI0qDiMKY9TOG
X-Gm-Gg: ASbGncuroqQ7H5nTxYbdpjIl1052AKq7ehXtoL2HO0WIXbQs/BL6/klezyihlZJfXS6
 x8J7Fv3HoCQsAwPnNNP65FgZb7hCy1XIubAx2dAC/TLh/sONHI6JMBm0R3bpRx1T3YZy32snlqn
 EVezzbpJqMOwifeMptEwd7MtsnpSpppnYFxhhAhLI0VPQsYsslPNPRgh1vCEVwSUv/vy6KsQvv+
 hXkLxuTRQXfl0Q0/EO4YTHJQMUjeGcCKg9FGd6oA1Y7lXAZsdhaqEIBOLLAGx/jBOT8ShrH2PfE
 bGTSZnJdr6wlUuTR/h5BECQ6XSGBodsMpigtq3xseEbGxhieCblkpw==
X-Received: by 2002:a5d:5c84:0:b0:39c:2665:2bfc with SMTP id
 ffacd0b85a97d-39d146624demr11773612f8f.52.1744093785170; 
 Mon, 07 Apr 2025 23:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCs457wcFuYpm593CwZoMlk9LjDSwf7yGBqAUCixibTuviabD88SIZgYE9+y6ffANaWya95w==
X-Received: by 2002:a5d:5c84:0:b0:39c:2665:2bfc with SMTP id
 ffacd0b85a97d-39d146624demr11773593f8f.52.1744093784783; 
 Mon, 07 Apr 2025 23:29:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226a07sm13668890f8f.84.2025.04.07.23.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 23:29:44 -0700 (PDT)
Message-ID: <10a60957-21a1-4254-885b-21829d9746e6@redhat.com>
Date: Tue, 8 Apr 2025 08:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250407143119.1304513-1-amachhiw@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250407143119.1304513-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Amit,

Please use --cover-letter for the next spin.


On 4/7/25 16:31, Amit Machhiwal wrote:
> Introduce an Error ** parameter to vfio_spapr_create_window() to enable
> structured error reporting. This allows the function to propagate
> detailed errors back to callers.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   hw/vfio/spapr.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 1a5d1611f2cd..4f2858b43f36 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -232,7 +232,7 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
>   
>   static int vfio_spapr_create_window(VFIOContainer *container,

This routine can return a bool since vfio_spapr_container_add_section_window()
does not check the returned errno.

>                                       MemoryRegionSection *section,
> -                                    hwaddr *pgsize)
> +                                    hwaddr *pgsize, Error **errp)
>   {
>       int ret = 0;
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -252,10 +252,10 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>       pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
>       pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>       if (!pagesize) {
> -        error_report("Host doesn't support page size 0x%"PRIx64
> -                     ", the supported mask is 0x%lx",
> -                     memory_region_iommu_get_min_page_size(iommu_mr),
> -                     bcontainer->pgsizes);
> +        error_setg(errp, "Host doesn't support page size 0x%"PRIx64
> +                   ", the supported mask is 0x%lx",
> +                   memory_region_iommu_get_min_page_size(iommu_mr),
> +                   bcontainer->pgsizes);

This can use error_setg_errno(errp, EINVAL, ... ) instead of
returning -EINVAL.

>           return -EINVAL;
>       }
>   
> @@ -302,16 +302,16 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>           }
>       }
>       if (ret) {
> -        error_report("Failed to create a window, ret = %d (%m)", ret);
> +        error_setg_errno(errp, -ret, "Failed to create a window, ret = %d (%m)", ret);
>           return -errno;
>       }
>   
>       if (create.start_addr != section->offset_within_address_space) {
>           vfio_spapr_remove_window(container, create.start_addr);
>   
> -        error_report("Host doesn't support DMA window at %"HWADDR_PRIx", must be %"PRIx64,
> -                     section->offset_within_address_space,
> -                     (uint64_t)create.start_addr);
> +        error_setg(errp, "Host doesn't support DMA window at %"HWADDR_PRIx
> +                   ", must be %"PRIx64, section->offset_within_address_space,
> +                   (uint64_t)create.start_addr);

This can use error_setg_errno(errp, EINVAL, ... ) instead of
returning -EINVAL.

>           return -EINVAL;
>       }
>       trace_vfio_spapr_create_window(create.page_shift,
> @@ -334,6 +334,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>                                                     container);
>       VFIOHostDMAWindow *hostwin;
>       hwaddr pgsize = 0;
> +    Error *local_err = NULL;
>       int ret;>   
>       /*
> @@ -377,9 +378,9 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>           }
>       }
>   
> -    ret = vfio_spapr_create_window(container, section, &pgsize);
> +    ret = vfio_spapr_create_window(container, section, &pgsize, &local_err);

please pass errp instead.

>       if (ret) {
> -        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
> +        error_propagate(errp, local_err);

no need to propagate if errp is passed to vfio_spapr_create_window()


Thanks,

C.


>           return false;
>       }
>   
> 
> base-commit: 53f3a13ac1069975ad47cf8bd05cc96b4ac09962


