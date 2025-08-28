Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492F7CA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDy-0005WO-3F; Thu, 28 Aug 2025 13:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urc26-0007Vk-Ek
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urc23-000755-FO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756385229;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQHCXqjm4zIM8dZntivUPtrmx6PsmOO0Jbe3R2x3L2Q=;
 b=IDuSVLnf93sJDU2UQ7Au3cfeli+ef/rv0wiUL24NfZpnEE0vnSv0DPxUo0h6E7EqI7L6/y
 GYDO6goSg3RSD91Ou/9XTvAyhOehHoqNMAhGL4NxhYEtdfCq63Y56ZdnMUShq3iqGj37D2
 Uq4qIvzvpPmEVOUfg5E3vU3QG1DkPpQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-38kp50sEPgiMg6oAMjRBGw-1; Thu, 28 Aug 2025 08:47:07 -0400
X-MC-Unique: 38kp50sEPgiMg6oAMjRBGw-1
X-Mimecast-MFC-AGG-ID: 38kp50sEPgiMg6oAMjRBGw_1756385227
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7f6a341c9b8so235540285a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756385227; x=1756990027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LQHCXqjm4zIM8dZntivUPtrmx6PsmOO0Jbe3R2x3L2Q=;
 b=jgmjuleVlYORTBlrS0CGMydNUK8itCCawJaKnD/ED/TqjMLglZUx98LBi5h8vn9JV6
 ELeDhyYNhnl6aqwMemnMQG7BlKDs0mCHA0S5osTwdv+81fIRJ58Hf4z07s5ZOoJ4bbSQ
 87yA+IC2Rw482IiRTZVYAVGVdYciSm7NsvguqIXyoL+5VdeU9Ko8GG9GLgzITFW6KLTz
 V/LPnmQf5QKFOSiymC9qDUEYhSjiwjtCkia4OxMDf/kml+u5kvmLmY1RH3TGxcbosNuK
 fT2iZBdzONsCal7xe+EoFyixnJJn9FEggIK8gtNV+pD77VV3xNHTr9LufICefCq4cIAy
 QapA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnqJv3SzRn9fQVP84XcJTe2Gn6VBehm6J/tsIxxyvL9KDFiUSHc3hBrFOUOaSMC3YiY+RppUaRz+Ux@nongnu.org
X-Gm-Message-State: AOJu0YySaCug7VoZ8FrS+2VN6d+St/Jr/rCw1WO4/1nxpcF9r6Wo8aqG
 3SoBWNMJSNfCtOkV1LGWmwQY8xEV7SYQGoy15ea59quD8kH4Vbrv4XDWWd2EAeN14Pzdm/sB5GO
 l2dzVV60xaQqgNy6VL2+hywzpoFgRRdYNmbQe5SPDETCG1JXb+Q2rKaC5
X-Gm-Gg: ASbGncv1l2tISsI1WhizUbJp4TfHlyOKbIetLQ09fTJogMzM7zb2h/Ih6TpUKVfZlYC
 QUOTMqwveZ41leM7/TSQKUD1t+tManr3kOAbMSV9vASOjiQc57UEeFYyTjkRKlJQXfOmXrwGsme
 bWv5sDE2XI5hJJ5mdEyJ6BLbJB4/1GIBghyNitC55WGY2sReziPPOBAgsv8EN+eKoMT+0YJBMoJ
 ty+7DAcOqRv4OLzrh8wS15uYOhXs1rn4XccJJblzqMVkuw3RCWg1xdZv0xjl1Kznksfh009BkSy
 hX9E+4dHv8c8A8bvbp2M7+8jJ0cOs7CFwk9B6rhPkMIdAyJMPTsfnzNrPmN2c02xZqG96TnXHku
 PSO6yHDaPbBI=
X-Received: by 2002:a05:620a:c4e:b0:7e7:fd8a:ae7c with SMTP id
 af79cd13be357-7ea10fa1446mr2405198885a.7.1756385226623; 
 Thu, 28 Aug 2025 05:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4VdNbBmYNEP+DUi1v0PM8gQvy8TOYo+o/bH3CHCTQfKOHQ6w1g2MM/UAsd7NQy0hyiyqNcw==
X-Received: by 2002:a05:620a:c4e:b0:7e7:fd8a:ae7c with SMTP id
 af79cd13be357-7ea10fa1446mr2405196185a.7.1756385226186; 
 Thu, 28 Aug 2025 05:47:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70da72ca086sm103138106d6.61.2025.08.28.05.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 05:47:04 -0700 (PDT)
Message-ID: <0ff48782-4e89-40c0-b233-d36d69724786@redhat.com>
Date: Thu, 28 Aug 2025 14:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/21] vfio: Add a new element bypass_ro in
 VFIOContainerBase
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-20-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-20-zhenzhong.duan@intel.com>
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
> When bypass_ro is true, readonly memory section is bypassed from
> mapping in the container.
>
> This is a preparing patch to workaround Intel ERRATA_772415.
I would explain what this ERRATA needs to implement

Thanks

Eric
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-container-base.h |  1 +
>  hw/vfio/listener.c                    | 21 ++++++++++++++-------
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index bded6e993f..31fd784d76 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -51,6 +51,7 @@ typedef struct VFIOContainerBase {
>      QLIST_HEAD(, VFIODevice) device_list;
>      GList *iova_ranges;
>      NotifierWithReturn cpr_reboot_notifier;
> +    bool bypass_ro;
>  } VFIOContainerBase;
>  
>  typedef struct VFIOGuestIOMMU {
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 903dfd8bf2..5fa2bb7f1a 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
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
> @@ -365,9 +370,9 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
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
> @@ -494,7 +499,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>      int ret;
>      Error *err = NULL;
>  
> -    if (!vfio_listener_valid_section(section, "region_add")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_add")) {
>          return;
>      }
>  
> @@ -655,7 +661,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      int ret;
>      bool try_unmap = true;
>  
> -    if (!vfio_listener_valid_section(section, "region_del")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_del")) {
>          return;
>      }
>  
> @@ -812,7 +819,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>          container_of(listener, VFIODirtyRangesListener, listener);
>      hwaddr iova, end;
>  
> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
> +    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
>          !vfio_get_section_iova_range(dirty->bcontainer, section,
>                                       &iova, &end, NULL)) {
>          return;
> @@ -1206,7 +1213,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (vfio_listener_skipped_section(section)) {
> +    if (vfio_listener_skipped_section(section, false)) {
>          return;
>      }
>  


