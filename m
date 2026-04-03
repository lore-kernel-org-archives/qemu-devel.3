Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C73AE7E35D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8azD-0004Na-K5; Fri, 03 Apr 2026 05:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8azB-0004N6-Lt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8azA-0001WE-1V
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775209119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9ChlsuzrlaLirrhyu7Cp44ypPCu1mABhWMo+oaDm7ro=;
 b=Gby0qUmaH62LSpxDQr4SIC7BaKv4OE9fCO+vJuguNkbmmokmexK0b7A2mqMLaV73o8KOKb
 skhA54uqRRKNjTfPXvYTZN28gA8x2strezpMjXJ0528yqKxO4+E3WOojOcY4eZQVGzibuF
 ePYq3bEuYAotqIrSqKPapt2NIxSsk2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135--_7kWOg0NCGnLbeGqwolPQ-1; Fri, 03 Apr 2026 05:38:37 -0400
X-MC-Unique: -_7kWOg0NCGnLbeGqwolPQ-1
X-Mimecast-MFC-AGG-ID: -_7kWOg0NCGnLbeGqwolPQ_1775209116
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4889dabaa84so6890355e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775209116; x=1775813916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9ChlsuzrlaLirrhyu7Cp44ypPCu1mABhWMo+oaDm7ro=;
 b=knR1gD7z2ptqm6nQSV/Avs5yC2IqOqJHNQDthB9ql6dN3rF9spViucvwBM6LNL7CVP
 AUVAwa6k0g29mCXOGaXR+of57g6a6QyjSsgMJTViROBlnXdKWXrWUafLwt4C9ZE+/zFW
 Wba2VUYUXmFW0qqQnSDtun4dl/2RUUIjAIfrZWEnJmN9BtRlBOoiORItoB5IM6SkUFNd
 inptJWRKJlXFgtGGCl7HNr8gzAwllhZsyQ/rS+isTfsMRM/eIijYjK0gYto7dxxziI1v
 VfY2shAKXlM+Qsrm/gXyFYDmdHqiAu6m3n6APj91Q/byFvRKD2XvkPqQ+2elwUQ5oubk
 wlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775209116; x=1775813916;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ChlsuzrlaLirrhyu7Cp44ypPCu1mABhWMo+oaDm7ro=;
 b=jNeguLGCwkT1mQNNMHgKA3Kht+OMHwtzMz+/MPlFBiKUmocep5loCRdaYkrKcFmyEr
 qv1y+caKT3MWvBrehD9KCRlHXVnh9R3+wBhpsYrl3d+KQ8jcxEgqGnk+qnXpcx1e9jLA
 ss8wL/qo75stFTf1AkSfzNA3kPh7q2uJysmzAg+HLMa5M3s4aoyXWZI4EyAg0IFI0JUd
 /dgmGeWVlJ+T9curEADbd0I258jzK/Ao2Zu1HzLJ2UQ+x4/B5GJh+yd/ipaRrYluy0ZF
 3U2w7eWj61rb023LjAMiIk+bWvDNEFNhT8TjNiSs6mkQuGjF1zKdNet8ASPL2LHst3Kq
 221Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrHKnTbKZBAoZqM3HsamgBamLV9FeSPCnUS7fhNM0001RtCbs7Y3zKSRhVCczphU7GKiAwFE6xTujg@nongnu.org
X-Gm-Message-State: AOJu0YzYmLvlhsIUc8g5SnkpNNby/fXhsO4kaYIvXvnjPjxCyF98iGnw
 HjI5LIeLeEayHz3e/4vSDoLi4DLcYo8Br0FUWIbGHG9RsQBaaB3fK7YyK4p1ebxD64JbTWkd7mg
 21CH8k1S89H+leDjTQ9ystUDGn+dPw7Bd5DSpYg9Xrekkx3N5yCwe85uN
X-Gm-Gg: ATEYQzy+qKWEb5Ul54OZ3LselWAPR0r8etYufGoEtjgQ1cJIbTd3mS+6BWopsI5Opvu
 ibQw8oe4SLq2S9ideHRQxvP3OenbuA9tMeIpPCltQ3xeMpQaQjQhH7AwUDX9dysicSYNBd8rwrG
 iUNLXjPRwjwZ1hZuhfUyT4j+JvqHkhAaEAJbdJJ58rlIibJrQmL8Of0oW1evo+DBwgnmMOP1COn
 QLPaGEpXdqxEmrbLt4t6WfqX5lm6NljzOKU9nwWJTgUVRJefxjtrxsBxXtbu2sYaNznXfkI3HNM
 uv5zBnWXTEzGFkYxnZKZ3iX6xUt6abVRgY++HSiWN4pBUFDPHwZ2iW4xQocGjx1Dsu/io5JeHV2
 JWwN8JYFKpA+PRF8J8BiJrbusZssZJR4LfLqU/tS/Jl1VWclsXl27ZLZ2ZUhB
X-Received: by 2002:a05:600c:3549:b0:486:fbe1:2499 with SMTP id
 5b1f17b1804b1-488997d2d7cmr32634325e9.22.1775209116298; 
 Fri, 03 Apr 2026 02:38:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3549:b0:486:fbe1:2499 with SMTP id
 5b1f17b1804b1-488997d2d7cmr32633825e9.22.1775209115820; 
 Fri, 03 Apr 2026 02:38:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488980e7a29sm22511425e9.4.2026.04.03.02.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 02:38:35 -0700 (PDT)
Message-ID: <6e7013da-fae9-48a3-bdd0-9e19711cedaf@redhat.com>
Date: Fri, 3 Apr 2026 11:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-4-zhenzhong.duan@intel.com>
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
In-Reply-To: <20260403035541.18355-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Zhenzhong

On 4/3/26 05:55, Zhenzhong Duan wrote:
> When both device and vIOMMU have PASID enabled, then guest may setup
> pasid attached translation.
> 
> VFIO needs to be aware of potential pasid usage and should attach the
> non-pasid part of pasid-capable device to hwpt flagged with
> IOMMU_HWPT_ALLOC_PASID.
> 
> ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it. So
> we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED to
> determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
> flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by VTD.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   include/hw/core/iommu.h       |  1 +
>   include/hw/vfio/vfio-device.h |  1 +
>   hw/vfio/device.c              | 11 +++++++++++
>   hw/vfio/iommufd.c             |  8 +++++++-
>   4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index bfcd511013..67c575b08c 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -21,6 +21,7 @@ enum viommu_flags {
>       /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>       VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
>       VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
> +    VIOMMU_FLAG_WANT_PASID_ATTACH = BIT_ULL(2),

VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING was introduced since. The change
is on vfio-next.

You will need to rebase. While at it, I think the documentation of each
of these VIOMMU_FLAGs can be improved.

Thanks,

C.


>   };
>   
>   /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 828a31c006..d6e522f8b8 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
>   void vfio_device_unprepare(VFIODevice *vbasedev);
>   
>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev);
>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 973fc35b59..bc1d37e776 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -533,6 +533,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>       return false;
>   }
>   
> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
> +                  VIOMMU_FLAG_WANT_PASID_ATTACH);
> +    }
> +    return false;
> +}
> +
>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index ecabc33064..ead40b6617 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -363,6 +363,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       VendorCaps caps;
>       VFIOIOASHwpt *hwpt;
>       uint32_t hwpt_id;
> +    uint8_t max_pasid_log2 = 0;
>       int ret;
>   
>       /* Try to find a domain */
> @@ -408,7 +409,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        */
>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>                                            &type, &caps, sizeof(caps), &hw_caps,
> -                                         NULL, errp)) {
> +                                         &max_pasid_log2, errp)) {
>           return false;
>       }
>   
> @@ -430,6 +431,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           }
>       }
>   
> +    if (max_pasid_log2 &&
> +        vfio_device_get_viommu_flags_want_pasid_attach(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_PASID;
> +    }
> +
>       if (cpr_is_incoming()) {
>           hwpt_id = vbasedev->cpr.hwpt_id;
>           goto skip_alloc;


