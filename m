Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27Wf-0008Gj-S5; Fri, 26 Sep 2025 08:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v27WW-0008Ei-Um
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v27WO-0001mJ-Pw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758889552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G5JU/92u4s3yiJRWpFY+A/rsCW2wno6nr50WCmGPNdM=;
 b=MfK5CRt+RI2brJOqmKih8ruh4iC/D55+ZOkDz5h81eD4oMK5YWpNUhJs3BiCdMQfYSGmvM
 3AetZ0UxFNpTj57yV3q1PCAXPlX+2ERBChAbBxTvPha9q73Hbys7PgtOayihhbZ2vdt+9F
 ICXvxtJCd7r3WTvBu4ed98W5X4U3PNs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-LcCQU1RiO8yw1PpvrKOKZQ-1; Fri, 26 Sep 2025 08:25:50 -0400
X-MC-Unique: LcCQU1RiO8yw1PpvrKOKZQ-1
X-Mimecast-MFC-AGG-ID: LcCQU1RiO8yw1PpvrKOKZQ_1758889550
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ece14b9231so1367123f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758889549; x=1759494349;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G5JU/92u4s3yiJRWpFY+A/rsCW2wno6nr50WCmGPNdM=;
 b=uWsplKquF9OQ4ZbgVXR2PWFQuUk4JC1CZqcknZyJizrdlR692axcBl477V5vkob6Ld
 Cir1t7TPlsnBZLSepol9EJsaQAWozh7aAe5u+dYm4DehF9IlP21YYoAsx7bQmoXgHsy2
 Zwy4gSLefEriMjaeug54Ilnk4mkukE1bvqnmscL14YJUCniB3BkT7qLmnK8b8nd75STW
 ybC4GQW0UE4SK48Ntx6+BdjYq5Yoa8c0K7rOwSbpm/rTNC0De1cCPqfRUaqMvLGacP6z
 WLFOlvyka2yla22yF5PJRrBxLNIYo/ET+Y/BhwpyqGtvKcC2uIJ16Atn1rCJDYA67asB
 BaxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDj/BZMw1AsyTWmXG7BWwmCY3wf+YLOMYwV/A/JVRupyZm7nNyGnnUFaotm8RnwbZ4ZlIIxJw1er4o@nongnu.org
X-Gm-Message-State: AOJu0Yz26oNHj6Z8dl9AgnTz6Rh1H708GHdWdqyawxnZXXF7ASaUvHY4
 5EG6UXqeUFmtOyXkOY8bwvbPgTQ1kD2g1lz+ZAMW6c/e3AtGQc0Xsvwa+ZAXmjJf368WdpinHAC
 4lZdjqNIJ6dZbPwqO/b9qDmbvzkXYS/5mv4puIwZ+uWANYbO5//FUQUX7
X-Gm-Gg: ASbGncs34GRt04P2wmOW5p2MTr0Cz0INe1BdKsgB7Isy3wHooz3rzn8p2sMFRxLV1At
 +9GHzdR5ZeaziZxRbdHOakFGNMlHCTPvH9AwvHr03UNNAGwFrtqEb4Paa6J/2geNjwr2xMQGImO
 D8Imo8I0Tgle58H7Vy3fz1mvbUus7Ec6f9zIC1ZcQ7vC3Qx3ATvH9kE/mhvheeob2+LjvcE3PRg
 Pp09eHxOQXoPmGiMJQrcUIkjXx4+n2tCWy1r+AvM4nuPKLH4vh0VzRwI3lH80cn1NA6CL3R7JAs
 B+w7IXsZOfHi9ej2SQMFPCk3HHsi3edlroBeH4Zx8aTaalhJN6Gk/4cHMskRviPFiDlIqOPmC4K
 Th9M=
X-Received: by 2002:a05:6000:2284:b0:3ec:b384:322b with SMTP id
 ffacd0b85a97d-40e4ff19bebmr6661632f8f.46.1758889549500; 
 Fri, 26 Sep 2025 05:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3nH81jKLVyJvoVqF1Yx9WA8UYqiv8SKCAR0oqTJIZziAYRNwXBW0tFOh8bzuLNWBit6OlQg==
X-Received: by 2002:a05:6000:2284:b0:3ec:b384:322b with SMTP id
 ffacd0b85a97d-40e4ff19bebmr6661591f8f.46.1758889549049; 
 Fri, 26 Sep 2025 05:25:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2ff6sm6823136f8f.56.2025.09.26.05.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 05:25:48 -0700 (PDT)
Message-ID: <076fb297-2c05-404c-b2e1-15f4587b03d3@redhat.com>
Date: Fri, 26 Sep 2025 14:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] vfio: Add a new element bypass_ro in
 VFIOContainerBase
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-20-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250918085803.796942-20-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

On 9/18/25 10:57, Zhenzhong Duan wrote:
> When bypass_ro is true, readonly memory section is bypassed from mapping
> in the container.
> 
> This is a preparing patch to workaround Intel ERRATA_772415, see changelog
> in next patch for details about the errata.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container-base.h |  1 +
>   hw/vfio/listener.c                    | 21 ++++++++++++++-------
>   2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index acbd48a18a..2b9fec217a 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -52,6 +52,7 @@ struct VFIOContainerBase {
>       QLIST_HEAD(, VFIODevice) device_list;
>       GList *iova_ranges;
>       NotifierWithReturn cpr_reboot_notifier;
> +    bool bypass_ro;
>   };
>   
>   #define TYPE_VFIO_IOMMU "vfio-iommu"
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index e093833165..581ebfda36 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>       return true;
>   }
>   
> -static bool vfio_listener_skipped_section(MemoryRegionSection *section)
> +static bool vfio_listener_skipped_section(MemoryRegionSection *section,
> +                                          bool bypass_ro)
>   {
> +    if (bypass_ro && section->readonly) {
> +        return true;
> +    }
> +
>       return (!memory_region_is_ram(section->mr) &&
>               !memory_region_is_iommu(section->mr)) ||
>              memory_region_is_protected(section->mr) ||
> @@ -368,9 +373,9 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
>   }
>   
>   static bool vfio_listener_valid_section(MemoryRegionSection *section,
> -                                        const char *name)
> +                                        bool bypass_ro, const char *name)
>   {
> -    if (vfio_listener_skipped_section(section)) {
> +    if (vfio_listener_skipped_section(section, bypass_ro)) {
>           trace_vfio_listener_region_skip(name,
>                   section->offset_within_address_space,
>                   section->offset_within_address_space +
> @@ -497,7 +502,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>       int ret;
>       Error *err = NULL;
>   
> -    if (!vfio_listener_valid_section(section, "region_add")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_add")) {
>           return;
>       }
>   
> @@ -663,7 +669,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       int ret;
>       bool try_unmap = true;
>   
> -    if (!vfio_listener_valid_section(section, "region_del")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_del")) {
>           return;
>       }
>   
> @@ -820,7 +827,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>           container_of(listener, VFIODirtyRangesListener, listener);
>       hwaddr iova, end;
>   
> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
> +    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
>           !vfio_get_section_iova_range(dirty->bcontainer, section,
>                                        &iova, &end, NULL)) {
>           return;
> @@ -1214,7 +1221,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>       int ret;
>       Error *local_err = NULL;
>   
> -    if (vfio_listener_skipped_section(section)) {
> +    if (vfio_listener_skipped_section(section, false)) {
>           return;
>       }
>   


