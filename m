Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2650DCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwFX-0006M7-A5; Fri, 12 Jun 2026 03:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwFU-0006Lq-QJ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwFT-0008Ad-8X
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781249054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bd+izQaSce4ApwA8dSEs+MZ+NzPG97yKKlDbWNCx25U=;
 b=JgLfzXWXz+jmcsONs3y8Qg8wjjHqAqSmGTa56HHGpzRIqRrawM34/x+sOMmUQhrV1u2Ve5
 IbQP0ICIu94xW2NBQfIaIXGTxIttnTDRYBozZ0qSxrO8+tX+lMdUI9+LFYzU1nTLIIg4lO
 CRoIUhP0PFpO2XCPTE9eRyzFA5CA6KA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-58z1KOhwNKyfn-JNmLylXQ-1; Fri, 12 Jun 2026 03:24:13 -0400
X-MC-Unique: 58z1KOhwNKyfn-JNmLylXQ-1
X-Mimecast-MFC-AGG-ID: 58z1KOhwNKyfn-JNmLylXQ_1781249052
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so5196425e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781249052; x=1781853852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bd+izQaSce4ApwA8dSEs+MZ+NzPG97yKKlDbWNCx25U=;
 b=jEI7CUyZe68uQJwzRlKJ9Fglhj3qrGQjQGFVJGEckk3R2h4mv3Q3EPRRuk1abvjgnk
 RqQOmG6GBSGeVDzhYprwtdZcJUTzJk1QTTkmyS+mYbFraGw0K2BsFoCQSOQaUp21/QlA
 ypt2xAMULzZbEK5Tnl5mm/Y6IsuUIytTcAt7v3te6afjxZSRpcHZRjvdRLrfcHRl+9sa
 wNZqAJ4TwYdM53NIyXF/DB8BhpL+s8uX4kT7PA5G5OnVgFzSMs0PAN67WWDnepAtDCRA
 CNAnHzfhOntDBVoNvGRkJKroSCNG1Ko729t60q6ZCe0S+PMnSxuikoMcBTRtlzsKlV4F
 uTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781249052; x=1781853852;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bd+izQaSce4ApwA8dSEs+MZ+NzPG97yKKlDbWNCx25U=;
 b=kHy79DyiMmgc7N+0Qv5cb7unajdrJAc1rA3BrNuv3n0xdFtlGKnfjA5CQzfIa2KvD8
 ugIe+x8YPv8N9yg9T46zTCJx/S8CVX2X1X66plI225AM/aEXpI+sWxy04J9MAp2VELAy
 C4bqT8gGQSbJI4zKF7VkqeSM1IVrOEQagHmRWD/DxCnnYsKofVC/M8FSr5uVRxeyMZdP
 nOQHd1bgYya9/1tUn4jgy+f+Sr2XtpiriSeMZ+eWplW7nFACUzDFBgX0jXaqJ1WB9K6u
 92KqT/4yGdp5mZr1SXYzQIC+0FjaJethBiMzr05M3Vp3xUwZCYmKDeMjOkg9Hu0tzBVk
 coDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ot+Lj5kWp/pOec12lZtWKFzRwL3+X4w/9zy9QxCF4kWWl2ZxIhnzttkxiThJ77SvttRgyEgl0SW7E@nongnu.org
X-Gm-Message-State: AOJu0Yx08NYOzQDim2mu3uvpbq96onv7e95MngGDBAojdE6DINVvCETK
 JiPQBF/dLhiZhld3SC79o5ko4gfvUtk8otyvmVixErv6J5v9B+pYtAOklHv3CyU4Cl0l7abxtjA
 6Uj94kIdy9DetGbhICFdhOyoejsvIrEcjr3pZbG+7gqxWSN5Dfds9Jby6
X-Gm-Gg: Acq92OHDNQEYCO6WiQN5pDs1MEZdaRET/V1BJxkw0CwMM2HAfO9cTsxazfz5dw+gch/
 aEiDiiGKiLOezD0XLBGI26Bd7jKX8wlPLSN8V3V/bmHoA5VIwj5/WgdBniDO/l1CZAPT5/D2rMU
 MdsgREVhNG6fjX4hLKcIdHHC7kFcRqFs0g0TUryu8cYGCteRZz9gL6KYk+dU6W1aYYphlhr9UaA
 uBhCafd0XlFLqFBi9szvMX5zN9l3I6SR/crTBZiIVpZQgWFfXNks3zjUCtnxfXj67skr1Pye40C
 b4HQ6NgKwS+t9IYyh4Tx7T4IJ4ol279j0Z7GQN1Khv1dW/SqwIbHzcDYJ2TakdxzpuysUJCozCm
 zkWsfMjNq4a89T8wKWv7hCni9PA87699yzsECn6XAF0UzUowKNL8Fu3bEr/J7
X-Received: by 2002:a05:600c:c04b:20b0:490:e974:e01f with SMTP id
 5b1f17b1804b1-490ec502167mr12338165e9.28.1781249052075; 
 Fri, 12 Jun 2026 00:24:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c04b:20b0:490:e974:e01f with SMTP id
 5b1f17b1804b1-490ec502167mr12337625e9.28.1781249051571; 
 Fri, 12 Jun 2026 00:24:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea52sm132133155e9.2.2026.06.12.00.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 00:24:11 -0700 (PDT)
Message-ID: <f158c795-8b68-4aa0-9853-022bcf115c7a@redhat.com>
Date: Fri, 12 Jun 2026 09:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommufd: Introduce handler for device ATS support
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-2-nathanc@nvidia.com>
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
In-Reply-To: <20260612014322.2918836-2-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/12/26 03:43, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Introduce a support_ats() handler that returns whether ATS is supported
> for a device associated with a host IOMMU device, checking if the
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
> 
> Implement this handler in a new function for iommufd.
> 
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   include/system/host_iommu_device.h | 10 ++++++++++
>   backends/iommufd.c                 |  8 ++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index f000301583..5615d6cb57 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -133,6 +133,16 @@ struct HostIOMMUDeviceClass {
>        * Returns: true on success, false on failure.
>        */
>       bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
> +    /**
> +     *  @support_ats: Return whether ATS is supported for the device
> +     *  associated with @hiod host IOMMU device, checking if the
> +     *  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.

IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is low level implementation detail,
which could differ on a future host IOMMU backend.

I would remove "checking if the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
capability bit is set."

Something like this is more generic :

   Returns true if ATS can be used by the device, false if the host IOMMU
   reports it is unavailable.

Thanks,

C.

> +     *
> +     *  @hiod: handle to the host IOMMU device
> +     *
> +     *  Returns: true if ATS is supported, false otherwise
> +     */
> +    bool (*support_ats)(HostIOMMUDevice *hiod);
>   };
>   
>   /*
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 410b044370..7cc6767b4b 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -573,6 +573,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>       }
>   }
>   
> +static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
> +}
> +
>   static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
>                                           PasidInfo *pasid_info)
>   {
> @@ -595,6 +602,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
>   
>       hiodc->get_cap = hiod_iommufd_get_cap;
>       hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
> +    hiodc->support_ats = hiod_iommufd_support_ats;
>   };
>   
>   static const TypeInfo types[] = {


