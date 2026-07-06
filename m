Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B4AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghmm-000645-SZ; Mon, 06 Jul 2026 07:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wghmL-00061P-QR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wghmK-0003hk-0o
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783338381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZlwgE/kLAptfZ02Y9qDrhQ+GweU3O/Ib3qjuxBSPmiA=;
 b=JxUazxU9tfFo8WiKWbfPbojeyovLYAtEbuR2a0iM4b8TSHMvDzloQxdFzXbe/StKK4VzpW
 +k9GqhJQFz0xuLDOvyQlcmra2PTI/9Jx6oCydhOpOl7Y8TDbCMYKj/1WjtLr2d39b/r4Ux
 yuQ8QknGnLbNJ3uiBwcALwTBuuCXJZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-G8tPw7YbObu-Qq-UC16rrQ-1; Mon, 06 Jul 2026 07:46:18 -0400
X-MC-Unique: G8tPw7YbObu-Qq-UC16rrQ-1
X-Mimecast-MFC-AGG-ID: G8tPw7YbObu-Qq-UC16rrQ_1783338377
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493b786d550so31003875e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 04:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783338377; x=1783943177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZlwgE/kLAptfZ02Y9qDrhQ+GweU3O/Ib3qjuxBSPmiA=;
 b=NvD2hVPr0yGWBXj8uVv+tFneR/F5P/SEoziynhjSNEB23BwvM6eaoijZNnvrhLJIn5
 52VpdqgJESHz+PfkPd+33kRPl20oOjdMPx3KbGjn2mJgo9ZjHcOuZ3CmQMdvcxSt+OCS
 56kGfGSlBTm9BWFm16WIJVltnuKkaZvV0q+5hYpnL4vwOP+mOzCkq4NHQMqh0VlrCeIu
 VWzGCx+9juNjUU2VLJY4Qh6VNOE7OuZo4u7dQKehMLhDE1Z2Glqd2TGYsjE1o7rIZi7I
 NR9361xRl13DMvTAh7yw3qyeYMKOWK/YXWNriONN4q7tnoTavkNG94t2RsGYew2JYJmh
 2s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783338377; x=1783943177;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlwgE/kLAptfZ02Y9qDrhQ+GweU3O/Ib3qjuxBSPmiA=;
 b=SlKBWfsh2o1vbdQt1XmNmK+laBljKwCdpdn9ve5sB4v4WhKWQui619yDiuXLLDm82f
 Jiu75idZ3DgsbIilVcyT9VX8Z73UEzOwUqNYFygJNe1ozllM+6t9Asa3YbggO61btRGI
 UVnVr5b7kMbau6Rd+opkPLMcfIStXZAnROG8/7r+g+YZp4CQSXUDnw0depkP0Z8hMujR
 KUDlXaO30icIFD95KpsWl16/johD47bESwFmIknS0JSNgl6w+2B+OufM1SARnZQVBc/N
 yHXVsWpCTQJZ5lR5wTcniNOY3lm+DjkS8qHphOTrOjp+bQwjchELCvYSkUhtj6mxRs6w
 3hFg==
X-Gm-Message-State: AOJu0YxPwlguVAC8kgMXMli2xw9apNGXQX3P0E4XivyXxR3BZY8GZ7Vf
 T27HJjoSb/Amkgf33sGcijGEk4K70KpghorUlN39Wz6PMtKR7ichy+h7UgLDkSDPhtH61yiv6Zz
 eVM+xbFCSYLAOwcj9ev7P5bnCls2Wr3/tyMCrS+/0e6AuxCxxAVf50Yrh65ieHqGC4hzw4JP1S0
 KMybi0BRjw5HEzZvkEjyrUuY/EPsL7T73WJQ==
X-Gm-Gg: AfdE7cmsFvucP3/LwvUnDSuHWuo3w2jHL2BPYqc5CrC2k5l+fLwY7PfUp7VN5L/2ZJo
 k/VA2xQUW6hGXGw0bOherNoQfbbJdIfbQovMP0/Y1my6QqCxd8ltREDvxBk6UtiJFnmmfulX4SI
 F9spG1gP5ACZb+XRACBqViLUrRDA1k0mMaL63nDzPLSVVHhqjOUGOOcEoIE+vSNeYALtHlpUqtG
 ++vTJN8A2HhvkUcoWZAV0Ra5bIW5yOKp6UdqoAzJ1AiGiyirSRMlbwvKAAZaoUo9Vcs9GHQu47V
 FxpVl9BVFboah+glzG1aUevAMghsemZA59DBAk4wAvEoNss6UIgGM/uqS0V0JTfVuCHBF7wr18W
 MyvuMwYfpLlJA9JHa5BU9wWGmMw8SG66wUr6xxftDbSciA/PZFA==
X-Received: by 2002:a05:600c:1d0a:b0:493:bed7:6d7c with SMTP id
 5b1f17b1804b1-493df0a8eb6mr218755e9.25.1783338376874; 
 Mon, 06 Jul 2026 04:46:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0a:b0:493:bed7:6d7c with SMTP id
 5b1f17b1804b1-493df0a8eb6mr218385e9.25.1783338376354; 
 Mon, 06 Jul 2026 04:46:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm23461405f8f.14.2026.07.06.04.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:46:15 -0700 (PDT)
Message-ID: <cf072137-fd93-4149-befd-687df7046994@redhat.com>
Date: Mon, 6 Jul 2026 13:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260702160640.3875666-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260702160640.3875666-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello !

On 7/2/26 18:06, Cédric Le Goater wrote:
> Any device on the board can have non-page-aligned memory regions. The
> VFIO listener should not warn about misalignment for regions that are
> not VFIO-related.
> 
> Replace the vfio_known_safe_misalignment() whitelist with a
> vfio_get_vfio_device() ownership check: only warn when a VFIO device's
> own region is misaligned. For all other regions, emit a trace event
> and silently skip. Extract the misalignment test into a
> vfio_section_misaligned() helper for readability.
> 
> Note: vfio_get_vfio_device() currently only covers VFIO PCI devices,
> including vfio-user-pci.  Other VFIO backends (AP, CCW) don't expose
> memory regions through this path so this is sufficient for now.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/device.c     |  2 +-
>   hw/vfio/listener.c   | 33 +++++++++++++++------------------
>   hw/vfio/trace-events |  2 +-
>   3 files changed, 17 insertions(+), 20 deletions(-)

Could someone please take a look and Ack this change (or not :) ?

Thanks,

C.

> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 1a7f8088aad9583ee96fc303be917fdb2f100df9..3a47109efb35c6dc28719dcc19acb85bef1d26cd 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -439,7 +439,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
>   
>   VFIODevice *vfio_get_vfio_device(Object *obj)
>   {
> -    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> +    if (object_dynamic_cast(obj, TYPE_VFIO_PCI_DEVICE)) {
>           return &VFIO_PCI_DEVICE(obj)->vbasedev;
>       } else {
>           return NULL;
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..76b9b02f8163f18d20994e4ec1f914a4d148fa92 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -40,7 +40,6 @@
>   #include "migration/misc.h"
>   #include "migration/qemu-file.h"
>   #include "system/tcg.h"
> -#include "system/tpm.h"
>   #include "vfio-migration-internal.h"
>   #include "vfio-helpers.h"
>   #include "vfio-listener.h"
> @@ -352,20 +351,10 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
>       g_free(vrdl);
>   }
>   
> -static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
> +static bool vfio_section_misaligned(MemoryRegionSection *section)
>   {
> -    MemoryRegion *mr = section->mr;
> -
> -    if (!TPM_IS_CRB(mr->owner)) {
> -        return false;
> -    }
> -
> -    /* this is a known safe misaligned region, just trace for debug purpose */
> -    trace_vfio_known_safe_misalignment(memory_region_name(mr),
> -                                       section->offset_within_address_space,
> -                                       section->offset_within_region,
> -                                       qemu_real_host_page_size());
> -    return true;
> +    return (section->offset_within_address_space & ~qemu_real_host_page_mask()) !=
> +           (section->offset_within_region & ~qemu_real_host_page_mask());
>   }
>   
>   static bool vfio_listener_valid_section(MemoryRegionSection *section,
> @@ -379,10 +368,12 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
>           return false;
>       }
>   
> -    if (unlikely((section->offset_within_address_space &
> -                  ~qemu_real_host_page_mask()) !=
> -                 (section->offset_within_region & ~qemu_real_host_page_mask()))) {
> -        if (!vfio_known_safe_misalignment(section)) {
> +    if (unlikely(vfio_section_misaligned(section))) {
> +        /*
> +         * Only warn for VFIO device regions.  Other VFIO backends
> +         * (AP, CCW) don't expose memory regions through this path.
> +         */
> +        if (vfio_get_vfio_device(memory_region_owner(section->mr))) {
>               error_report("%s received unaligned region %s iova=0x%"PRIx64
>                            " offset_within_region=0x%"PRIx64
>                            " qemu_real_host_page_size=0x%"PRIxPTR,
> @@ -390,6 +381,12 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
>                            section->offset_within_address_space,
>                            section->offset_within_region,
>                            qemu_real_host_page_size());
> +        } else {
> +            trace_vfio_listener_region_misaligned(
> +                         memory_region_name(section->mr),
> +                         section->offset_within_address_space,
> +                         section->offset_within_region,
> +                         qemu_real_host_page_size());
>           }
>           return false;
>       }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index f71d0bbc0a5440e4ccd374fac4733af08438e7be..5056b9942027938cd6bc832198acc9809739399f 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -98,7 +98,7 @@ vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn
>   vfio_listener_region_add_iommu(const char* name, uint64_t start, uint64_t end) "region_add [iommu] %s 0x%"PRIx64" - 0x%"PRIx64
>   vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
>   vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
> -vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
> +vfio_listener_region_misaligned(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
>   vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>   vfio_listener_region_skip_dma_map(const char *name, uint64_t iova, uint64_t size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" marked to skip IOMMU mapping"
>   vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64


