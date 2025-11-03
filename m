Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EADCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuCG-00051b-MU; Mon, 03 Nov 2025 08:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuBi-0004pd-1g
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:01:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuBS-0005Ko-Un
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762174870;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=443Oxkcwzfu/N9QI2OyLDoETdIrjbmLMUQKoFX8HPOA=;
 b=TxOW8XuIGRD7F5xV5HDAjLrQuanHTo7cOV//2mjj/u2gd0JrAei1GfbPZ7F7RgwQLqWnBw
 aUEe2swkgvJ9iYVAKhAnV3IA/lfiW9k9c04Vi684F5I8//J0HVA9G9FtIM5OpDWMW+Ck3e
 am1N6EAEpub7vMuE2Ga2lK2SdbsBP0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-YO9nR_U4ORSI6Y0RVsvj2g-1; Mon, 03 Nov 2025 08:01:09 -0500
X-MC-Unique: YO9nR_U4ORSI6Y0RVsvj2g-1
X-Mimecast-MFC-AGG-ID: YO9nR_U4ORSI6Y0RVsvj2g_1762174868
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47113dfdd20so19251135e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762174866; x=1762779666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=443Oxkcwzfu/N9QI2OyLDoETdIrjbmLMUQKoFX8HPOA=;
 b=aDMQe8fdSCmJ/TbaBMOGN9/5PqB0P2KG/HlYl96TtyjyoTpwILfLo5fRuoZuZIcuGL
 cu4nDGbbu6q0zcz/SMiObf06zl8siuKjy/myHHrIl1n5y0P91FRSPpVLIzJ+z9HPdvct
 mMx2LODKsJVtXMHplh9PJA7XJvik9/y1w2iHJW/uFFCla+ieYPxH5IMcyjSWaIwSQ63e
 vv5+xs58iXQA9eQPtdSH15vzAKHHrcK59VSfIIDZSYaqxw53gGlKj5uHooyjjlsSO0qr
 E84YxEOHLUFzKxW2IQ3X04grwV7m8Jve3LSjEKCZp4tdKiYVIKRW7NgZ5nqO8g5wAAGX
 cbZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6I1OR+nTffShpSwuRn1wopOpwzafYY4Yna92+VuFv8JNGBCFvbnptIW2nI5l6snEcNtcqxG31nvrs@nongnu.org
X-Gm-Message-State: AOJu0YzqXuGJ0TiRYvJDN26WtF1dMAK4qJRuv0jp7mv7d6MegA3SJvsU
 +14lOZIFvm3zV/EG8PJ2veAx6+rdhTsVjnrLB2WMdX1n10v6Lf5slTHhaGUbDss/KX1oCXHX9iZ
 NCoixJxf8Q/npX/E6Ms6ZhvktjcF/+n2DJNC0obA7ve+NOjYgI7Rho3G9G2i3b+zZ
X-Gm-Gg: ASbGncv3yPCGmHBEh8g4kRnHFBKyVxV/o5gd4K/H3rUJFBL63wPbzGVZyFaPBqLtsuO
 3sXXlgwuk0B0Mw2UaEef4lHg1BvbRxKec7tQpEF4X3whfZUtPV/Lsm1Nn6fZBhF/Qxok8/9IcWB
 bh1/Ec9TB/Wghn8S6R4tiEicB4US32fXLgelaa8QnFw7osJFhOD3tLekC60C5qy/KyMPRzRb8+J
 vkLr6Qn0juGJhZQBsiXb+XFpbaANscOOkkBeuHgGZ3YTbf62KAnTeSbd7C6RvrgBEJKpT+7d0sK
 dNA9Zm3XHqS4Fc9gDAR2XtCG/ifOI59gt5bGpaQBAABDMzjmkTO5gqB+zZswRW64l+ue6H04XBn
 ig7tcZmS4Cqc7pKxRqougVlnxehfHJcMw84iSNiTFGpUlKA==
X-Received: by 2002:a05:600d:4352:b0:477:429b:3b93 with SMTP id
 5b1f17b1804b1-477429b3fb5mr36625295e9.18.1762174865963; 
 Mon, 03 Nov 2025 05:01:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfI9dEuVKL3kT/8yMG/4pgPCf5MJlpuhIklO/hZyxx03bZ8fDPUf4kE2Yr30Q3j1KtNcd1LA==
X-Received: by 2002:a05:600d:4352:b0:477:429b:3b93 with SMTP id
 5b1f17b1804b1-477429b3fb5mr36624965e9.18.1762174865338; 
 Mon, 03 Nov 2025 05:01:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2ff79bsm153756145e9.6.2025.11.03.05.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:01:04 -0800 (PST)
Message-ID: <7e7063ce-3f29-4771-a808-3fdb38ac498e@redhat.com>
Date: Mon, 3 Nov 2025 14:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/23] vfio: Add a new element bypass_ro in
 VFIOContainer
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-19-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> When bypass_ro is true, readonly memory section is bypassed from mapping
> in the container.
>
> This is a preparing patch to workaround Intel ERRATA_772415, see changelog
> in next patch for details about the errata.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>  include/hw/vfio/vfio-container.h |  1 +
>  hw/vfio/listener.c               | 21 ++++++++++++++-------
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index 9f6e8cedfc..a7d5c5ed67 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -52,6 +52,7 @@ struct VFIOContainer {
>      QLIST_HEAD(, VFIODevice) device_list;
>      GList *iova_ranges;
>      NotifierWithReturn cpr_reboot_notifier;
> +    bool bypass_ro;
>  };
>  
>  #define TYPE_VFIO_IOMMU "vfio-iommu"
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 2109101158..0862b2b834 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainer *bcontainer)
>      return true;
>  }
>  
> -static bool vfio_listener_skipped_section(MemoryRegionSection *section)
> +static bool vfio_listener_skipped_section(MemoryRegionSection *section,
> +                                          bool bypass_ro)
>  {
> +    if (bypass_ro && section->readonly) {
> +        return true;
> +    }
> +
>      return (!memory_region_is_ram(section->mr) &&
>              !memory_region_is_iommu(section->mr)) ||
>             memory_region_is_protected(section->mr) ||
> @@ -368,9 +373,9 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
>  }
>  
>  static bool vfio_listener_valid_section(MemoryRegionSection *section,
> -                                        const char *name)
> +                                        bool bypass_ro, const char *name)
>  {
> -    if (vfio_listener_skipped_section(section)) {
> +    if (vfio_listener_skipped_section(section, bypass_ro)) {
>          trace_vfio_listener_region_skip(name,
>                  section->offset_within_address_space,
>                  section->offset_within_address_space +
> @@ -497,7 +502,8 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
>      int ret;
>      Error *err = NULL;
>  
> -    if (!vfio_listener_valid_section(section, "region_add")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_add")) {
>          return;
>      }
>  
> @@ -663,7 +669,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      int ret;
>      bool try_unmap = true;
>  
> -    if (!vfio_listener_valid_section(section, "region_del")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_del")) {
>          return;
>      }
>  
> @@ -821,7 +828,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>          container_of(listener, VFIODirtyRangesListener, listener);
>      hwaddr iova, end;
>  
> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
> +    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
I think you shall document in the commit msg and maybe here why we set
bypass_ro to false in that case

Eric
>          !vfio_get_section_iova_range(dirty->bcontainer, section,
>                                       &iova, &end, NULL)) {
>          return;
> @@ -1215,7 +1222,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (vfio_listener_skipped_section(section)) {
> +    if (vfio_listener_skipped_section(section, false)) {
>          return;
>      }
>  


