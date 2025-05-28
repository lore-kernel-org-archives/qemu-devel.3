Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BE5C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDZZ-0006il-0h; Wed, 28 May 2025 05:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKDZV-0006hy-1S
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKDZS-00062j-RR
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dahe3dLhd+sJ98TnE710M5fLANUTVKeTTSA8S61gmBA=;
 b=K4QXGhS9mZPGm5fxtQiHn4aU3DDkAX8SFQ495W8beXTNwXIlFaGFhsL7dJmpVS7/2adAHU
 jL6u4Sba8HTB0a1DB04/ZwSKuYCVeMXNmn8jxSvUgUEkfVzcwkcIotqlH6YySDZRQfIFt5
 gkdPaYrDOVhUtwB0ZmlAC62imnc+5WM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-DjBDX0VDORWR4VQxOZKQxA-1; Wed, 28 May 2025 05:59:34 -0400
X-MC-Unique: DjBDX0VDORWR4VQxOZKQxA-1
X-Mimecast-MFC-AGG-ID: DjBDX0VDORWR4VQxOZKQxA_1748426373
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eb9c80deso168828f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 02:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748426368; x=1749031168;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dahe3dLhd+sJ98TnE710M5fLANUTVKeTTSA8S61gmBA=;
 b=MTIBtFn2o2+dXIEbSpaCh+nts1mCScwvBZI5jLBGWkHpfwsE1dM2C6l0KqqWdlyaKv
 K54qqH3GwiFBoWPjolLpi7oUJOmqG+6X28V+Bg+TvBOZ+QrLEMi7VdrsMBHXe7e1FnwW
 X94eO3VH8WpVe/Su4BhWJ6eYmZkGwX7Ff2qNrc7EVnEyqsyfmlq2oI62mIEFKC2wxsAm
 SOrqAPtOT3VgHYxqECt1JxloziwqUW8JTL1/EjGb7h6XQtW5Kdd4KWg6I5Aq3zibYQPC
 I0gEQEhavFWD1qO1cf9ZxgN7P2BKtqEMb0obyHPBBHzu/alUdaInamblvaJBK3MWKSlW
 8NJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWPfz65oGVJjb4JC9yAJVMTFfpfNTAac3X1b7ZlO0jxLND6Jgi/zMv6VBLvbFGaVujRuP5YoJs/q18@nongnu.org
X-Gm-Message-State: AOJu0YxBlFCJUuuLhBWMGwNnl6us/X+Ku5cAQKJs7IylWSW19YDw7JUy
 1qOdF7ootiFLNZAWIe8zSxg0c39isYzaCEWQR/HC4tbom17Iu06qhcABkUulp0hicWQNugxzTbo
 nhSM0zGA+7KwtuwRPVSn6PgHTduVBvGELP3LO8hX35QfhMCYjI/j8fy9D
X-Gm-Gg: ASbGncuw1fyreGtKYMMUrLvJrDah0i+0Rk9uX4ePFgwoQpGGBFdCyqzW+Jr5ZIw4He1
 vZFixo1h9OMvQ9ox7Uw9vNB0eHqfd0fGkvJ/KjgoFD/aey2luGUYLeCe4UgwT+ZKL+SDvYxE4af
 I9YXCRz9WClQ9iP6r43x6o2qy7svLPfl2O+G+xpR3bpxUWmQaDkPY21nATx+aQHwcXQ3Ky19D79
 TwividJn5rgabDaLN0A4W13Pv8YkZhP2ffn9bsFaiGp6kMttngxGXn3dPzKy1ErtvjxpaZGpQdt
 GnvQVw==
X-Received: by 2002:a05:6000:1888:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a4ead45f69mr1024094f8f.24.1748426367818; 
 Wed, 28 May 2025 02:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcoe84qjKmg5vOfUhLNnzh7CU9JM9BUivi+ee1D46boo0OaQzfZSjYU+Tu4l538DPPi5hNfg==
X-Received: by 2002:a05:6000:1888:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a4ead45f69mr1024071f8f.24.1748426367356; 
 Wed, 28 May 2025 02:59:27 -0700 (PDT)
Received: from [10.0.5.211] ([91.126.222.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6e354sm1049729f8f.10.2025.05.28.02.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 02:59:26 -0700 (PDT)
Message-ID: <538e848b-148a-49f1-bf06-f534ff44bf87@redhat.com>
Date: Wed, 28 May 2025 11:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-2-zhenzhong.duan@intel.com>
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
In-Reply-To: <20250528060409.3710008-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Zhenzhong,

On 5/28/25 08:04, Zhenzhong Duan wrote:
> This helper passes cache invalidation request from guest to invalidate
> stage-1 page table cache in host hardware.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/iommufd.h |  4 ++++
>   backends/iommufd.c       | 33 +++++++++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   3 files changed, 38 insertions(+)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..5399519626 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -61,6 +61,10 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                         uint64_t iova, ram_addr_t size,
>                                         uint64_t page_size, uint64_t *data,
>                                         Error **errp);
> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
> +                                      uint32_t data_type, uint32_t entry_len,
> +                                      uint32_t *entry_num, void *data_ptr,
> +                                      Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index b73f75cd0b..c8788a6438 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -311,6 +311,39 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>       return true;
>   }
>   
> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
> +                                      uint32_t data_type, uint32_t entry_len,
> +                                      uint32_t *entry_num, void *data_ptr,
> +                                      Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    uint32_t total_entries = *entry_num;
> +    struct iommu_hwpt_invalidate cache = {
> +        .size = sizeof(cache),
> +        .hwpt_id = id,
> +        .data_type = data_type,
> +        .entry_len = entry_len,
> +        .entry_num = total_entries,
> +        .data_uptr = (uintptr_t)data_ptr,

Minor, other helpers use a 'data' variable name.

> +    };
> +
> +    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
> +    trace_iommufd_backend_invalidate_cache(fd, id, data_type, entry_len,
> +                                           total_entries, cache.entry_num,
> +                                           (uintptr_t)data_ptr,
> +                                           ret ? errno : 0);
> +    if (ret) {
> +        *entry_num = cache.entry_num;
> +        error_setg_errno(errp, errno, "IOMMU_HWPT_INVALIDATE failed:"
> +                         " totally %d entries, processed %d entries",
> +                         total_entries, cache.entry_num);
> +    } else {
> +        g_assert(total_entries == cache.entry_num);

Killing the VMM because a kernel device ioctl failed is brute force.
Can't we update the 'Error *' parameter instead to report that the
invalidation is partial or something went wrong ?

What kind of errors are we trying to catch ?

Looking at the kernel iommufd_hwpt_invalidate() routine and
intel_nested_cache_invalidate_user(), it doesn't seem possible to
return a different number of cache entries. Are you anticipating
other implementations (sMMU) ?

Thanks,

C.


