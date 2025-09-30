Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A2ACCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YhA-0006Zh-T3; Tue, 30 Sep 2025 07:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Yh8-0006ZY-RX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Yh2-0003NB-F9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759232323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s9TN9TZeQjktmd6QWuTV4gF6Ocin9z3f2O7pXCiqRtI=;
 b=PdVb61gfjsjOWHpzWGjxcxA8yom/lZKivsXvKeOSDldw/Op/Uvl/MapoB5CHFMfXk67WUs
 yuzOpjsxs5LEyaE5pYIoi0v1VnoxEiBvsR+JXQrVWTRO9P3mu6OLP9/0brbpnk1Q7N56Vd
 JiByxFX9UO6UwCKtmxRBDomXoE3FnSs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-q519jA4aOOuocveaySIHrw-1; Tue, 30 Sep 2025 07:38:42 -0400
X-MC-Unique: q519jA4aOOuocveaySIHrw-1
X-Mimecast-MFC-AGG-ID: q519jA4aOOuocveaySIHrw_1759232321
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4943d713so17948965e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759232321; x=1759837121;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9TN9TZeQjktmd6QWuTV4gF6Ocin9z3f2O7pXCiqRtI=;
 b=ZNChhofrtsgXB9h06wCR+hQmZ1cS0dmyE+R+G0DF5HsMq1MBb7vI3FnEl7fS4zNB8a
 U7TZ5Vsv2DRHdChybqCteEyqwUY0/JqaDSmuy0JptLCaXFawfDaQOMnly49YOmQQN4fi
 AD5nZw5zBAZc4gr5fBsygGhMEpnxu2lsiFgtQIjZoEqQHEhIHR9jDx4C7OyLMBevSvdu
 FtJm367inNJ7y8CI7jjAdTSewcNWtQ7ggClqqOhjYzGht1rkPfhB5z9ZyUjo8NStatmh
 VqEVuHyT3ivrOYJkRRvRnylhrFaHrF+UNg7hl5zLxw/aea09B2PGemtVFo3YnHQEY8FC
 uOXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeBfa8vzpQuXl0S3Mc8Z8kDrAOVJw8nl2myjX13eAx+AewjeoViUpsvw1rG4cZqLmpy4wR4ok3Ivfu@nongnu.org
X-Gm-Message-State: AOJu0Yzelwz4wrwtO6zFLATfhZ/BQbuZRsalDjkinnwolV7d2eL0SC2o
 /YStKvEoFKCe/ZfjrFeZH5wfAXFdC6BlVbSUTFESB2xR8kIkx4RzxReY3o3XXkyRVR5oE4mZkmQ
 twSCk1TtO5VkpzTIHRt83p6GLRufBRCS6SceL+RARlyBELbEKMQEOHT9g7jRaKATw
X-Gm-Gg: ASbGncvADHYr6qVnishhvhAscR/xoTu1BpQx2dwMralh2+o8JHvZyLALVEL/waarRyo
 zFAO15JmrxXzUF/uZ6DemAmDPJ3DA/zmAju7zeTIq8F+ItYZ35BixcoYpEC/PRW69D4p7vFcg72
 ezIrEU1MB74GbyPsRT+3/6kthQhOMOQQR4RkLfpduHN60KRNBbinljvcTGRpf3YgmdM5XFkRkCA
 wm2bpHvfYz+k4OuNXa1dnlXAqTjAAVM2vBin9gFabNm5Ml46lRQx2OmIPBKvIBRA6zaUiaWk435
 0TrEK3W8fCZImpS1vMdaj2qew9X0nVh8yBjUhfY0/J4RYc62NEfNUvk1wjTG9jwG0BF4g3+wIGm
 ZGgPEAURi
X-Received: by 2002:a05:600c:4748:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46e43fa2e79mr110760035e9.24.1759232320683; 
 Tue, 30 Sep 2025 04:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdY6KwQFQLlozfTW5uZlxtzZgRMZAc+14zrffISPJx0UY+E063oljvtfEvVg5B50QMio9SwA==
X-Received: by 2002:a05:600c:4748:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46e43fa2e79mr110759765e9.24.1759232320237; 
 Tue, 30 Sep 2025 04:38:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a7c8531sm266630785e9.0.2025.09.30.04.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 04:38:39 -0700 (PDT)
Message-ID: <30ac36dd-8a08-41f0-8189-6b555aea38e7@redhat.com>
Date: Tue, 30 Sep 2025 13:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/vfio: Avoid ram_addr_t in
 vfio_container_query_dirty_bitmap()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, John Levon <john.levon@nutanix.com>
References: <20250930091456.34524-1-philmd@linaro.org>
 <20250930091456.34524-3-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250930091456.34524-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/30/25 11:14, Philippe Mathieu-Daudé wrote:
> The 'ram_addr_t' type is described as:
> 
>    a QEMU internal address space that maps guest RAM physical
>    addresses into an intermediate address space that can map
>    to host virtual address spaces.
> 
> vfio_container_query_dirty_bitmap() doesn't expect such QEMU
> intermediate address, but a guest physical addresses. Use the
> appropriate 'hwaddr' type, rename as @translated_addr for
> clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/vfio/vfio-container.h |  3 ++-
>   hw/vfio/container.c              | 11 ++++++-----
>   hw/vfio/listener.c               | 12 ++++++------
>   3 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index b8fb2b8b5d7..093c360f0ee 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -98,7 +98,8 @@ bool vfio_container_dirty_tracking_is_started(
>   bool vfio_container_devices_dirty_tracking_is_supported(
>       const VFIOContainer *bcontainer);
>   int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
> -    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
> +                                      uint64_t iova, uint64_t size,
> +                                      hwaddr translated_addr, Error **errp);
>   
>   GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
>   
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 250b20f4245..9d694393714 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -246,7 +246,7 @@ static int vfio_container_devices_query_dirty_bitmap(
>   
>   int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
>                                         uint64_t iova, uint64_t size,
> -                                      ram_addr_t ram_addr, Error **errp)
> +                                      hwaddr translated_addr, Error **errp)
>   {
>       bool all_device_dirty_tracking =
>           vfio_container_devices_dirty_tracking_is_supported(bcontainer);
> @@ -255,7 +255,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
>       int ret;
>   
>       if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
> -        cpu_physical_memory_set_dirty_range(ram_addr, size,
> +        cpu_physical_memory_set_dirty_range(translated_addr, size,
>                                               tcg_enabled() ? DIRTY_CLIENTS_ALL :
>                                               DIRTY_CLIENTS_NOCODE);
>           return 0;
> @@ -280,11 +280,12 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
>           goto out;
>       }
>   
> -    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> +    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
> +                                                         translated_addr,
>                                                            vbmap.pages);
>   
> -    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
> -                                            dirty_pages);
> +    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
> +                                            translated_addr, dirty_pages);
>   out:
>       g_free(vbmap.bitmap);
>   
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 3b6f17f0c3a..4e2565905e0 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -1059,7 +1059,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOGuestIOMMU *giommu = gdn->giommu;
>       VFIOContainer *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
> -    ram_addr_t translated_addr;
> +    hwaddr translated_addr;
>       Error *local_err = NULL;
>       int ret = -EINVAL;
>       MemoryRegion *mr;
> @@ -1108,7 +1108,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
>   {
>       const hwaddr size = int128_get64(section->size);
>       const hwaddr iova = section->offset_within_address_space;
> -    const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
> +    const hwaddr addr = memory_region_get_ram_addr(section->mr) +
>                                   section->offset_within_region;

While we're at it, could I ask, for consistency with other callers
of vfio_container_query_dirty_bitmap(), that you rename 'addr' to
'translated_addr' here and below as well ?

Feel free to ignore.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


>       VFIORamDiscardListener *vrdl = opaque;
>       Error *local_err = NULL;
> @@ -1118,7 +1118,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
>        * Sync the whole mapped region (spanning multiple individual mappings)
>        * in one go.
>        */
> -    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> +    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, addr,
>                                   &local_err);
>       if (ret) {
>           error_report_err(local_err);
> @@ -1183,7 +1183,7 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *bcontainer,
>   static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
>                                     MemoryRegionSection *section, Error **errp)
>   {
> -    ram_addr_t ram_addr;
> +    hwaddr addr;
>   
>       if (memory_region_is_iommu(section->mr)) {
>           return vfio_sync_iommu_dirty_bitmap(bcontainer, section);
> @@ -1198,12 +1198,12 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
>           return ret;
>       }
>   
> -    ram_addr = memory_region_get_ram_addr(section->mr) +
> +    addr = memory_region_get_ram_addr(section->mr) +
>                  section->offset_within_region;
>   
>       return vfio_container_query_dirty_bitmap(bcontainer,
>                      REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
> -                                 int128_get64(section->size), ram_addr, errp);
> +                                 int128_get64(section->size), addr, errp);
>   }
>   
>   static void vfio_listener_log_sync(MemoryListener *listener,


