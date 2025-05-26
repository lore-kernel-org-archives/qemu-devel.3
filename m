Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948F9C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJb8U-0002BE-83; Mon, 26 May 2025 12:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJb8S-0002AO-W4
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJb8Q-0003gY-QR
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748278629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XMvOBl4JBvP9rxwQP13NOL9Dl2rE+GAhZKC88UlUQtg=;
 b=d6CuKs6Ehsax2ke1MGUe81dIT8uvcU+w7Trql2XXGioyy7Y69RKQRCaF4W29VNVMLdc6BM
 c4RPlXRTvcYJK3qIjsL3FC3Md0Ei+59OBYkooU+iyrEf8snTJBamlKHgrIGRKkfMmy7C8L
 yIxe2LhgqmJacMDRi+FVgaRMUuT0QsU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-gQjxPzBFM_2OMbwqNfFY7g-1; Mon, 26 May 2025 12:57:07 -0400
X-MC-Unique: gQjxPzBFM_2OMbwqNfFY7g-1
X-Mimecast-MFC-AGG-ID: gQjxPzBFM_2OMbwqNfFY7g_1748278627
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso974444f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 09:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748278626; x=1748883426;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMvOBl4JBvP9rxwQP13NOL9Dl2rE+GAhZKC88UlUQtg=;
 b=WrkrHYAr7UfQKjnXjT/ysrRhj797LiNqFWEpgdiWICZu6uYCHslau5GQpsmVTPhubJ
 QpfphUUHG5hic1g24T+o6LzObgzA/RRerWl3olx6BBmFuYfsaCmyGh7LyqWDEKGGqZI2
 3kUN1gWbdA5Yu0yko3x3DZ12LphoPWzS1W/GpEWiX/fi2zicT/4hvTAd7ahnsPBlu/b+
 FSknkYzjxAh8SJZgqmK+h2fOURHnE3wTp0V3dO0fzKY8bb0xttPhHq5I8r0RDkbnAQZO
 0hRfmO1qbqL5qBs59nLGGmJfaH99ZwqkxtEtnsiZzjSCmzP7KMYwTUHEqE6EQkuGVcoy
 LhEQ==
X-Gm-Message-State: AOJu0YydJ3tIjsG+yVi/Qnsl4tutzizk+d5QJ+XnPRQbSx0MWDqkjck9
 ZXLlkCBupSVCiyC/6iwbGdSGV9q3N2AUvlZ0tqgOjR6/vZFRwYJxe9ZMm6/93Y0Nt1sdVJtusI2
 DDNWYQS8Zkgn6l2+WRcnpl+dnh6eJVeK8JloBsvoiQwtqNpQSfB63enRQ
X-Gm-Gg: ASbGnctU+VS3Hl2Y5NXytIIsX718g+zbho20SZ8VbHLO+1SLwWtLAZTF2MWNOjzm837
 pCXjlgR3Tl9wV0UjdLuh9exjHZok57N5BPkRDfidY58MxkuiF3bs6nxUw1gzt4zrMg71M9N/If8
 RNmFAblqoTgQm83IpVK7NezMGD+kXmpSsA4wEPSQo6769+tcEiTB3U14buBcQwboPQpGmo1nsd8
 JHIx9YmyMPRQvqNu7Ts29hdsL67Z64etkfXRtk/k+jFrDbcd7yLciI1TBetPmoB52BFISoLqe2K
 4PBUcLhEOSd3ZU29LPLJC0ky345DOYE8fc8QXlgUzcUjOLm/Vw==
X-Received: by 2002:a05:6000:3103:b0:3a4:c81:a075 with SMTP id
 ffacd0b85a97d-3a4cb49dde4mr7165575f8f.45.1748278626527; 
 Mon, 26 May 2025 09:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNI52F//zq18dl2306MvKO/2UjaZ08mBOUCXxQPEK31tH4VPYLPh7MY22AcFp/jt5t6N8i1A==
X-Received: by 2002:a05:6000:3103:b0:3a4:c81:a075 with SMTP id
 ffacd0b85a97d-3a4cb49dde4mr7165555f8f.45.1748278626030; 
 Mon, 26 May 2025 09:57:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c9dd7c27sm8507288f8f.45.2025.05.26.09.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 09:57:05 -0700 (PDT)
Message-ID: <22265d1d-207b-4e84-bd4d-7a2f56cb1348@redhat.com>
Date: Mon, 26 May 2025 18:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>, edmund.raile@proton.me,
 Edmund Raile <edmund.raile@protonmail.com>
References: <20250522151636.20001-1-tomitamoeko@gmail.com>
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
In-Reply-To: <20250522151636.20001-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/22/25 17:16, Tomita Moeko wrote:
> In vfio_pci_igd_opregion_detect(), errp will be set when the device does
> not have OpRegion or is hotplugged. This errp will be propagated to
> pci_qdev_realize(), which interprets it as failure, causing unexpected
> termination on devices without OpRegion like SR-IOV VFs or discrete
> GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().
> 
> This patch also checks if the device has OpRegion before hotplug status
> to prevent unwanted warning messages on non-IGD devices.
> 
> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> Reported-by: Edmund Raile <edmund.raile@protonmail.com>
> Link: https://lore.kernel.org/qemu-devel/30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com
> Tested-by: Edmund Raile <edmund.raile@protonmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> v2:
> * Add Tested-by from Edmund Raile. Thanks for the contribution.
> * Rebased on vfio-next
> * Fix typos.


Edmund, Alex,

Could you please send a R-b ?

Thanks,

C.



>   hw/vfio/igd.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 5b6341c5bf..e7a9d1ffc1 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>   }
>   
>   static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
> -                                         struct vfio_region_info **opregion,
> -                                         Error **errp)
> +                                         struct vfio_region_info **opregion)
>   {
>       int ret;
>   
> -    /* Hotplugging is not supported for opregion access */
> -    if (vdev->pdev.qdev.hotplugged) {
> -        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
> -        return false;
> -    }
> -
>       ret = vfio_device_get_region_info_type(&vdev->vbasedev,
>                       VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>                       VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
>       if (ret) {
> -        error_setg_errno(errp, -ret,
> -                         "Device does not support IGD OpRegion feature");
> +        return false;
> +    }
> +
> +    /* Hotplugging is not supported for opregion access */
> +    if (vdev->pdev.qdev.hotplugged) {
> +        warn_report("IGD device detected, but OpRegion is not supported "
> +                    "on hotplugged device.");
>           return false;
>       }
>   
> @@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>       }
>   
>       /* IGD device always comes with OpRegion */
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>           return true;
>       }
>       info_report("OpRegion detected on Intel display %x.", vdev->device_id);
> @@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>           return true;
>       }
>   
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>           /* Should never reach here, KVMGT always emulates OpRegion */
>           return false;
>       }


