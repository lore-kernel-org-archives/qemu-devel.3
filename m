Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F7EC3ABDA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGTf-00034w-BK; Tue, 20 May 2025 02:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHGTd-00034g-3l
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHGTZ-0004he-Pp
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747722558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ovH1wt+15OtAcv3c+xR79YhdDUWJIZg4Yq9gipfHUZM=;
 b=BMyHCjEt9bGNYhroiVdjXe7CKtI6A+/04FCK1cGKbNAxB8PyXgaVhBImwwKs23eugn0INm
 R4lG/j3tQQEFHQ0QS0zNgcTw9W9zl3BAHWDH0fGGpAcLD0dlzy6PZUQ40jJu2cUGttGdmS
 lkAJA2feKJgWoxCPXO/yKKINfT25kM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-8y7Hw2AbM9OPgSWkasI4KQ-1; Tue, 20 May 2025 02:29:17 -0400
X-MC-Unique: 8y7Hw2AbM9OPgSWkasI4KQ-1
X-Mimecast-MFC-AGG-ID: 8y7Hw2AbM9OPgSWkasI4KQ_1747722556
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so30011825e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 23:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747722556; x=1748327356;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovH1wt+15OtAcv3c+xR79YhdDUWJIZg4Yq9gipfHUZM=;
 b=XkBiI8uXsDbMw3KnbME8sfgd7u1iTgmZUmyEUy/7fbwYs5AfjIemJSB1Gjkx6IM2xo
 y1tn3GXbW1Azhtz+NeVOxGHdaPSWk9IPLMA0prkCa6xbm4iho+onujlczKJvqMvGgUGH
 qFhb1TPJcOB05bGXThRKU/XiBFMNeCxnjpMEAN07RDKQ5e7LX4japRLLd+E47lXZD+qz
 OiLPugCkiNaDe75hwdbceii+FOc7tx5KWlE+hm/dNmSbn8xo7VjzgsOp17fKDH02Hr6w
 +p9WOznJlPVSORazXZXL7vX8+2aKZT8HZZCMA6b1SC7eovJwroDjZI6hPQbxcSLU7x6e
 E5MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv+UnEPZB5pUSWHqCcyjGGLIErNcuPmPAlGBV9VD+TzV3fpIr6VD2L9YaSNTV/Xg5cM2vnk/bWxY4U@nongnu.org
X-Gm-Message-State: AOJu0YzFQJw4qRkrxHg4MDCKBsqxBdE9M6Hwu2IeGgsB/dnrhrw/ovnM
 P/Aj0YlZjS16nlkVQT9Apr8nHEms4q02tGWM6llnxqCQd1bG+ue6z7MGHsOFFQcgNCfjPs3dujK
 qG41/nIn4/GCcd1hopPGVqWKQ8dnT75wQB1PLHoLSTSoRVSTfV5BaRDvN
X-Gm-Gg: ASbGncvpn4UROCwdEmyJEP8zrkGKD+TBJzXzog7WZVCTsB4vkj4MOUxVjCfJGEbN1ZW
 80lnBr2Ngte5g0n99YFhhCcRV24otHm6wHn5dLTTMglL5MX6ldHJXQv0GSxVoZahKU/XTaOhFSw
 NZgJ/OGUC5XQ/NExMXKzy0pgzwoe9R/y1izXWgwD4yx8MNmRPR62hYmGhk2Z/mIa+Lp5q1IKwW9
 HZRnCqE5koTuHUXNX1oGPUN1LPMSp1kDaZrKUXYTQPy1oDmjlO945SU7xExqIQmfWAkXPVE3sVt
 KMn1Pf1PHrgMTBiOVy0pVOyXYbeJFnEyheq8QgaEj8Y6XFP6ZA==
X-Received: by 2002:a05:600c:3d18:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-442fd6724dcmr119277895e9.23.1747722555602; 
 Mon, 19 May 2025 23:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK1X9AZ7iqGnuvkHWlFP0HSMI/2XthIdmlsLbBeZTYprg6I6zEQYtoO2O2lwICQb8DpBl5ng==
X-Received: by 2002:a05:600c:3d18:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-442fd6724dcmr119277665e9.23.1747722555110; 
 Mon, 19 May 2025 23:29:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4481ca9f2d9sm12683425e9.19.2025.05.19.23.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 23:29:14 -0700 (PDT)
Message-ID: <af8772de-5469-4736-99cd-ec917a855aac@redhat.com>
Date: Tue, 20 May 2025 08:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/42] vfio/container: recover from unmap-all-vaddr
 failure
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-13-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
In-Reply-To: <1747063973-124548-13-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/12/25 17:32, Steve Sistare wrote:
> If there are multiple containers and unmap-all fails for some container, we
> need to remap vaddr for the other containers for which unmap-all succeeded.
> Recover by walking all address ranges of all containers to restore the vaddr
> for each.  Do so by invoking the vfio listener callback, and passing a new
> "remap" flag that tells it to restore a mapping without re-allocating new
> userland data structures.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr-legacy.c                  | 91 +++++++++++++++++++++++++++++++++++
>   hw/vfio/listener.c                    | 19 +++++++-
>   include/hw/vfio/vfio-container-base.h |  3 ++
>   include/hw/vfio/vfio-cpr.h            | 10 ++++
>   4 files changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index bbcf71e..f8ddf78 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -31,6 +31,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>           error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
>           return false;
>       }
> +    container->cpr.vaddr_unmapped = true;
>       return true;
>   }
>   
> @@ -63,6 +64,14 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>       return 0;
>   }
>   
> +static void vfio_region_remap(MemoryListener *listener,
> +                              MemoryRegionSection *section)
> +{
> +    VFIOContainer *container = container_of(listener, VFIOContainer,
> +                                            cpr.remap_listener);
> +    vfio_container_region_add(&container->bcontainer, section, true);
> +}
> +
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>   {
>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
> @@ -131,6 +140,40 @@ static const VMStateDescription vfio_container_vmstate = {
>       }
>   };
>   
> +static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
> +                                  MigrationEvent *e, Error **errp)
> +{
> +    VFIOContainer *container =
> +        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
> +        return 0;
> +    }
> +
> +    if (container->cpr.vaddr_unmapped) {
> +        /*
> +         * Force a call to vfio_region_remap for each mapped section by
> +         * temporarily registering a listener, and temporarily diverting
> +         * dma_map to vfio_legacy_cpr_dma_map.  The latter restores vaddr.
> +         */
> +
> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
> +
> +        container->cpr.remap_listener = (MemoryListener) {
> +            .name = "vfio cpr recover",
> +            .region_add = vfio_region_remap
> +        };
> +        memory_listener_register(&container->cpr.remap_listener,
> +                                 bcontainer->space->as);
> +        memory_listener_unregister(&container->cpr.remap_listener);
> +        container->cpr.vaddr_unmapped = false;
> +        vioc->dma_map = vfio_legacy_dma_map;
> +    }
> +    return 0;
> +}
> +
>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -152,6 +195,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>           VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>       }
> +
> +    migration_add_notifier_mode(&container->cpr.transfer_notifier,
> +                                vfio_cpr_fail_notifier,
> +                                MIG_MODE_CPR_TRANSFER);
>       return true;
>   }
>   
> @@ -162,6 +209,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>       migrate_del_blocker(&container->cpr.blocker);
>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
> +    migration_remove_notifier(&container->cpr.transfer_notifier);
> +}
> +
> +/*
> + * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
> + * succeeding for others, so the latter have lost their vaddr.  Call this
> + * to restore vaddr for a section with a giommu.
> + *
> + * The giommu already exists.  Find it and replay it, which calls
> + * vfio_legacy_cpr_dma_map further down the stack.
> + */
> +void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
> +                           MemoryRegionSection *section)
> +{
> +    VFIOGuestIOMMU *giommu = NULL;
> +    hwaddr as_offset = section->offset_within_address_space;
> +    hwaddr iommu_offset = as_offset - section->offset_within_region;
> +
> +    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
> +        if (giommu->iommu_mr == IOMMU_MEMORY_REGION(section->mr) &&
> +            giommu->iommu_offset == iommu_offset) {
> +            break;
> +        }
> +    }
> +    g_assert(giommu);
> +    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
> +}
> +
> +/*
> + * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
> + * succeeding for others, so the latter have lost their vaddr.  Call this
> + * to restore vaddr for a section with a RamDiscardManager.
> + *
> + * The ram discard listener already exists.  Call its populate function
> + * directly, which calls vfio_legacy_cpr_dma_map.
> + */
> +bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
> +                                            MemoryRegionSection *section)
> +{
> +    VFIORamDiscardListener *vrdl =
> +        vfio_find_ram_discard_listener(bcontainer, section);
> +
> +    g_assert(vrdl);
> +    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
>   }
>   
>   static bool same_device(int fd1, int fd2)
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 5642d04..e86ffcf 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -474,6 +474,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>   {
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
> +    vfio_container_region_add(bcontainer, section, false);
> +}
> +
> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
> +                               MemoryRegionSection *section,
> +                               bool cpr_remap)
> +{
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       void *vaddr;
> @@ -509,6 +516,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           int iommu_idx;
>   
>           trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
> +
> +        if (cpr_remap) {
> +            vfio_cpr_giommu_remap(bcontainer, section);
> +        }
> +
>           /*
>            * FIXME: For VFIO iommu types which have KVM acceleration to
>            * avoid bouncing all map/unmaps through qemu this way, this
> @@ -551,7 +563,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
>        * about changes.
>        */
>       if (memory_region_has_ram_discard_manager(section->mr)) {
> -        vfio_ram_discard_register_listener(bcontainer, section);
> +        if (!cpr_remap) {
> +            vfio_ram_discard_register_listener(bcontainer, section);
> +        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
> +                                                           section)) {
> +            goto fail;
> +        }
>           return;
>       }
>   
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index a2f6c3a..5776fd7 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -189,4 +189,7 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
>   int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                           ram_addr_t size, void *vaddr, bool readonly);
>   
> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
> +                               MemoryRegionSection *section, bool cpr_remap);
> +
>   #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 0fc7ab2..d6d22f2 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -10,10 +10,14 @@
>   #define HW_VFIO_VFIO_CPR_H
>   
>   #include "migration/misc.h"
> +#include "system/memory.h"
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
>       bool reused;
> +    bool vaddr_unmapped;
> +    NotifierWithReturn transfer_notifier;
> +    MemoryListener remap_listener;
>   } VFIOContainerCPR;
>   
>   typedef struct VFIODeviceCPR {
> @@ -39,4 +43,10 @@ void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>   bool vfio_cpr_container_match(struct VFIOContainer *container,
>                                 struct VFIOGroup *group, int *fd);
>   
> +void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
> +                           MemoryRegionSection *section);
> +
> +bool vfio_cpr_ram_discard_register_listener(
> +    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
> +
>   #endif /* HW_VFIO_VFIO_CPR_H */

Please add to your .gitconfig :

[diff]
     orderFile = /path/to/qemu/scripts/git.orderfile




Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



