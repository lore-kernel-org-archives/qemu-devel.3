Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43714D35691
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 08:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0xJ-0002hm-GG; Wed, 28 Jan 2026 03:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vl0x4-0002Uk-V9
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vl0x3-0000y7-89
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769589060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XThkBxuD0RENE8Kq4u11ofOoltb/1k9hKWtMhzNg6o0=;
 b=Wqf9A2h8t17LCLuZClC4IsoWRcXT/4BV37MqI9lqWIu91JT+iZqyTtjY+WVtaQdsmbrOeX
 NS7E3bV4SyuGZqaLSNMToGTRg8QRjl+Bx8b1pjdO7nychaLAk9CX5YOw8Grb3/nBtZHgzw
 wY/nkh4bPodJ2LAji2Xz/L/E2hW//Gs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-1VS1siKsNbuqeAc05AKJFQ-1; Wed, 28 Jan 2026 03:30:57 -0500
X-MC-Unique: 1VS1siKsNbuqeAc05AKJFQ-1
X-Mimecast-MFC-AGG-ID: 1VS1siKsNbuqeAc05AKJFQ_1769589057
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435a6c0c794so5037672f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 00:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769589056; x=1770193856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XThkBxuD0RENE8Kq4u11ofOoltb/1k9hKWtMhzNg6o0=;
 b=Nh3IMmuHFungQ6/Q+ZSrxJCgj2p2/fQu/KSTWZbecTP/YYxibc1GpgS6nvNTDgkr8h
 6qfene6xsx7jguWZZGY71tidGU0rM3lxptOXH/m6ITAP53/d78g6HC7h95TPBFO/hQxH
 NjOGyg5d40NpgOBkvupph1Vo1x4j47DG+dEbQgccW8+7OsP/AT2bc3tkAxs3ItB21i2/
 ptCTt1S0cXpIe0McguydlzbIP0bDmwfWERPVuuvzopuBcFwgWgUPp8k2J+oR7sUUfyT3
 b0sSRrFDLFPGxaBHEtF+8PzDUHyxxTpik9RvvvnUQsmRlVFMlaqwAglcfWIe5I4a1INv
 rr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769589056; x=1770193856;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XThkBxuD0RENE8Kq4u11ofOoltb/1k9hKWtMhzNg6o0=;
 b=tLue1YLXIwzXz6d8u74+VMPnmhlg1+n77PK0a2MPJMMJMip80AePXJnu5Pn8KaQzXj
 9TDCSq5iecsErtg5WlbBGEip72up8ZNGMPpYllgpip0iDFaPjhqViaAFQCrk6phQ07s5
 Sq+O5euAPsO5UNDZAUTM2taYlFb7F+dPny37Hft+75S7sFgeHmB1qYmTLx2YfrZR2Zht
 XhIF8jWmSwLRPbrpfH/Jabou1RtLh9xspXmk41sJkrldyWTZA2WKpaH772Cb9Yf3tNJ0
 rmdylOtTN4m0LN6RibGM3kYeNJZ+Tz3qxbWWW4odjDuw5psF/MMqg/JYxKl8FMPIJzAz
 Hlpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1iwB0Um1cj9rL+McuRUH01VJDac/OSiDoLjJrUGpSSudpXbIH3YtuSDnZ95ebFmszm4yRCKg7YL61@nongnu.org
X-Gm-Message-State: AOJu0YwJyvkFpxYWS0aruBLwfspsjhKUX0cRzN8XO8hA4BAYOAlOC9Qw
 Zgw8gLZ6rlWpUu6LnxpoOQ9QoAIy35eDgGeUXldE+2iHNn3rXmh6+POU9+m14rYPAglplmdWvHy
 FEwvaj3tLoql5VtGqQMNJ+Vo8dzmJCe0um94m1EiSvyH19LkoKOCFZ8gVg/ndlCmR
X-Gm-Gg: AZuq6aKIBspNjvl7pH8hNgzYqj1Hw2pUzd79EUWzMKpfGu7tJ3SBXaKCT0UebOMF2wV
 3TeIW2FBmX3wyI2jOJL9Y7dioW+7AHDuDKqUxpik8qz2G9MczzpcZzus5eN8DWPlgTNk4eThoMO
 2+vQxc8l2ZG7SN22BumBpDRJ53p+wz4t3ODRtveVQt8L+FyGOLEZ17RE2fvgJhtYALGrNaFRnS6
 rLLmS5u10njkk6GqTveraVc6TvTnvsTT9n8eCql+LEYVmB3AhUESM+25Zekf8gR9xdeIGlCHvQb
 fDqGbnPqza7ac4pH6xwX9Yvb3aZ5B0bsGoqlB9D9P3WmbmRHmI7h9jrzhgtwfMmsTlw6iA9mRIf
 O6DDL5sb60F4WHfJMhu36OE3phIJ8bMwO8BPoi9lXOZGp1p8+
X-Received: by 2002:a05:6000:2004:b0:434:2569:275d with SMTP id
 ffacd0b85a97d-435dd0909e1mr6737993f8f.26.1769589056307; 
 Wed, 28 Jan 2026 00:30:56 -0800 (PST)
X-Received: by 2002:a05:6000:2004:b0:434:2569:275d with SMTP id
 ffacd0b85a97d-435dd0909e1mr6737934f8f.26.1769589055848; 
 Wed, 28 Jan 2026 00:30:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132303fsm4828346f8f.36.2026.01.28.00.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 00:30:55 -0800 (PST)
Message-ID: <a55ac27f-c117-4bb3-89e7-4a4f7f3d080c@redhat.com>
Date: Wed, 28 Jan 2026 09:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] vfio: Document vfio_device_get_region_info()
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-4-vivek.kasireddy@intel.com>
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
In-Reply-To: <20260123062042.568703-4-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/23/26 07:17, Vivek Kasireddy wrote:
> Add documentation for vfio_device_get_region_info() and clarify the
> expectations around its usage.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   include/hw/vfio/vfio-device.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 35a5ec6d92..828a31c006 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -275,6 +275,19 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>   int vfio_device_get_feature(VFIODevice *vbasedev,
>                               struct vfio_device_feature *feature);
>   
> +/**
> + * Return the region info for a given region index. The region info includes
> + * details such as size, offset, and capabilities. Note that the returned
> + * info pointer is either a cached copy or newly allocated by
> + * vfio_device_get_region_info(), so the caller is not expected to allocate
> + * or free it.
> + *
> + * @vbasedev: #VFIODevice to use
> + * @index: region index
> + * @info: pointer to store the region info
> + *
> + * Returns 0 on success or a negative value on error.
> + */
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info);
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


