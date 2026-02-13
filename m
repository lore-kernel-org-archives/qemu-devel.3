Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5D7EDF150
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqKd-0006o7-PL; Fri, 13 Feb 2026 05:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqqKX-0006nc-Sk
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:23:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqqKW-00067g-79
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770978199;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhbkgIVTODtdM/8vqOpF+twX5FJAdT3VVoEh9Hw27vo=;
 b=GlcdRHEo9tLIW0QPovVkRYHPhf/MHbgMj0Xd3UmrHX2zOMD3d9+5C0/g+LOOgRdA6KRelM
 jgkLuBH65hwY2na6btgcNWLh0PuoqMHRPSqY9bM7WFiAStrpajKELxR/18SEnULMS4IvFO
 mnZvR4umPRhZStpuV/1rAx24UFXWHAU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-EnH9aiCKOZ6kjYUgoZqMlA-1; Fri, 13 Feb 2026 05:23:18 -0500
X-MC-Unique: EnH9aiCKOZ6kjYUgoZqMlA-1
X-Mimecast-MFC-AGG-ID: EnH9aiCKOZ6kjYUgoZqMlA_1770978197
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so7619495e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770978197; x=1771582997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhbkgIVTODtdM/8vqOpF+twX5FJAdT3VVoEh9Hw27vo=;
 b=EBfSvfSFCtvkOQjGXAZ29pDph3y2g1MKEkFur+I+IkhLWyQ40TDFlrxTXJLJ0I2gpO
 v0/69oMu1KTXTni2md0/TeWkn6Deb0jFhpWHVka1uE5uFB047IGABccN0u7NiNnXkBxl
 0Da3cD4V1bufXQsghkvaJBea1mRa5Dl2XbYCBXJZG6LKn26SZ2g0NaHvdxdsvHxBEfYH
 O/6PYe/O9q7yuaiIMxgm9SPuRAU8+VMsR+Oqsf3YtopOnEQuL++PD2ZxvvF/9RPsLLig
 VCGUpbQSxssWaESrkPxUTTrnUx1yZvHYloSRMOjxsEBSjUtQH78wI7K7uVtyJl9USP8Z
 BLvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4betTtyoL4rxU5unEwnRVUSzmDR27SpVeyET7x1Mxqy16X3IwLXTe9GfS8rurhzLcEEMNSb2Jn5m+@nongnu.org
X-Gm-Message-State: AOJu0Yxuu6UEt5L4QJ4YPQTA/TC9+vZu6O3liKkz5Lrm+TrdPQZmkoNf
 WIFYlwccVl6C0N2jPcIQT7ei1S+tdSPIcpENi4FcocAUth2YUjgaPqEsvQJ19T7yI3N3nZPJqc2
 VhYynjM7qJ4CcBCO0ZgnXo3Zaue6051XvlLdQDfWvlOMny4QsZTt1mpTT
X-Gm-Gg: AZuq6aKi8U41vo5TnfxVKVuGDdexLBmMLYs1bQa0LP24vvtIjusr4Pr4BLe2jdrIUrG
 FmbsJf/5WO/dI56GC0wvh2mNOnuertABTdsUZPz1CJPCpEjJ4tRI9p9i8rbRAzArxKF88eCICEy
 Rfa6fWa+8E9gTyOAKPle0DT8aYtlNWJzQ/RLyOkFs7jNBDm6Ao7yMsXGiR1pRpbuSTxxC2PSC/5
 lMTrhMKfMjsjEwO/cYqdOI3meYnudRqogxBEzuh4YgsQsR5IQLcuncFkbbPOjnBxHk3FYfyVVub
 HbdojeDInZjpAM48Q1XDqCKhUXa0dHGNBuL5ZI5D99WAktCorg9a8s6NwFfgf6p0WKbSt5TWsuV
 9IhjCZQsudojA3y0SU5g1SteXAA2BZbVGLZpMD7GmD4Xxu3OMEN5ggXsfJ6IokgWscjlZew==
X-Received: by 2002:a05:600c:34c6:b0:483:6ff1:18b with SMTP id
 5b1f17b1804b1-483737bde90mr19102675e9.0.1770978196779; 
 Fri, 13 Feb 2026 02:23:16 -0800 (PST)
X-Received: by 2002:a05:600c:34c6:b0:483:6ff1:18b with SMTP id
 5b1f17b1804b1-483737bde90mr19102325e9.0.1770978196396; 
 Fri, 13 Feb 2026 02:23:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm22660625e9.15.2026.02.13.02.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 02:23:15 -0800 (PST)
Message-ID: <3168c3ad-81e1-4749-a168-1ca3d059a464@redhat.com>
Date: Fri, 13 Feb 2026 11:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/24] system/physmem: Add address_space_is_ram() helper
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-14-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-14-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> Introduce address_space_is_ram(), a helper to determine whether
> a guest physical address resolves to a RAM-backed MemoryRegion within
> an AddressSpace.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/system/memory.h | 10 ++++++++++
>  system/physmem.c        | 11 +++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 0562af3136..02b2e83fd7 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2900,6 +2900,16 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
>   */
>  bool address_space_is_io(AddressSpace *as, hwaddr addr);
>  
> +/**
> + * address_space_is_ram: check whether a guest physical address whithin
> + *                       an address space is RAM.
> + *
> + * @as: #AddressSpace to be accessed
> + * @addr: address within that address space
> + */
> +
> +bool address_space_is_ram(AddressSpace *as, hwaddr addr);
> +
>  /* address_space_map: map a physical memory region into a host virtual address
>   *
>   * May map a subset of the requested range, given by and returned in @plen.
> diff --git a/system/physmem.c b/system/physmem.c
> index 2fb0c25c93..ddcf921311 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3646,6 +3646,17 @@ bool address_space_is_io(AddressSpace *as, hwaddr addr)
>      return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
>  }
>  
> +bool address_space_is_ram(AddressSpace *as, hwaddr addr)
> +{
> +    MemoryRegion *mr;
> +
> +    RCU_READ_LOCK_GUARD();
> +    mr = address_space_translate(as, addr, &addr, NULL, false,
> +                                 MEMTXATTRS_UNSPECIFIED);
> +
> +    return memory_region_is_ram(mr);
> +}
> +
>  static hwaddr
>  flatview_extend_translation(FlatView *fv, hwaddr addr,
>                              hwaddr target_len,


