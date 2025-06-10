Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95923C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtdI-00040h-ET; Tue, 10 Jun 2025 03:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOtdF-000405-Pq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOtdD-0004T1-5Q
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749541369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i/pl6OJwJEpx4WJT5OkOIZqS1FZCt1E61ckVEkTHUMM=;
 b=dMa7H7jE35smjAukgEVLTiC0ZIOs7Zpi2wldVl1pKqbrk0gjkXrEMp+pdzr4A6ePKvRovL
 B1aKNtWsAAlKefsYkvknwAaWq5DpmiEO8WwNqjjnyjDvI9g5MLeXzdfxGOCfU9DNQ37I6v
 NAVK3IuVoIDeiNunmHVorqGfUlJCUgg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-kKzgYMrgNledb1iG1Qa30w-1; Tue, 10 Jun 2025 03:42:44 -0400
X-MC-Unique: kKzgYMrgNledb1iG1Qa30w-1
X-Mimecast-MFC-AGG-ID: kKzgYMrgNledb1iG1Qa30w_1749541363
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so3522509f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541363; x=1750146163;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/pl6OJwJEpx4WJT5OkOIZqS1FZCt1E61ckVEkTHUMM=;
 b=s4vrdBOOq3k7lrm2DmN+alfYSso/sl/h+gbBO3V8ePm7s8ypV1szfYpLOzPOwpW9Wp
 VMDVO56nxEFu7dT6rAyI8D//e6pG1N6ENjNXXlOHtCF3i/T0iC1j4DtR0jkYAYkvB7dz
 YAc4Ia2A9CBFX6QCjUz/Uutj5mXzP0W5/wDWVKDWMK8EqRFhbqBYl/iwoco5LR0SXzQa
 Ci/AFRk4luJp2kKxX+l9Etzh5NQ4BcFQwQcrw5gzxfnrzQLWRIiXFeDWP2Rkuc5uBM7p
 ZSqN/mI4YIboG2nOkly+05WRJsccOUkMEysM+uh5I91LY6DtOQ+VfId4ZW+q9+e7Yvd/
 QYMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp8fWkQUOKD7NBskcsVij/Xml7pkFP+bffzEYK/yHNnaBetaUQiuaj6SlTzQfC8LIuxJX51kikjw9B@nongnu.org
X-Gm-Message-State: AOJu0YxH1A56Y2bXwR2PLqrct5wdKZYb2m/DPdv+BvhuTvJCH3GHM9Xw
 zHIzMrGdjO9VxaM5lKgMj2aAsSUa2xoUnzh3KULfG4SswmNAbpNaW6mvax/CR88ESt3BIVJKst5
 gWr60HwME2aidTrBi+1x79v8qzyEzhd5gx6ftD6bWCFtcD5Ya41aQr70V
X-Gm-Gg: ASbGncvaPmSsJ0HanERoZcaXSMuvXH0D0t8YiLauyUX1B3Rk/B1Qb3anNnQw4ZOcgFn
 nzxJHFoBx3Mdo9K+W36I6uQlC3ks3tOwmgBGHPN4tBDB2OijZSb61at0RsA8L4O4a2aNKl4fSbA
 rrWseWUNTXeIAQ6GPlFqutGr/tMp7mMXe8BIVZ+4Xu4ZxzoPeXztgKduznpJAbK0I5roEM4+lu4
 Hrste8LO3YyTBkjXpt/E80Qvz5/yCB6KZZQjLc6Uy46Aaw0Yy6TqpyZ+FH2jXls62q7nq+Ej/6s
 GitgtxuDUbJBStwwY0W3bgPCl43dJnvdQfuO0LSGYmOgoFiUevEcNp72dGJ9
X-Received: by 2002:a05:6000:4027:b0:3a0:7d39:c23f with SMTP id
 ffacd0b85a97d-3a55227af20mr1245145f8f.21.1749541363064; 
 Tue, 10 Jun 2025 00:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQo0e3ReHLBwz5ZYQuHHZYa7rOsVxrNvUkz1VMg8j7vKNK4QjvKdm+eQ/NY9nVEKpoL3unKg==
X-Received: by 2002:a05:6000:4027:b0:3a0:7d39:c23f with SMTP id
 ffacd0b85a97d-3a55227af20mr1245122f8f.21.1749541362651; 
 Tue, 10 Jun 2025 00:42:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de53sm11439708f8f.8.2025.06.10.00.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:42:42 -0700 (PDT)
Message-ID: <44882230-0e48-4232-9549-9c24c09d3749@redhat.com>
Date: Tue, 10 Jun 2025 09:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
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
In-Reply-To: <20250607001056.335310-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/7/25 02:10, John Levon wrote:
> For vfio-user, each region has its own fd rather than sharing
> vbasedev's. Add the necessary plumbing to support this, and use the
> correct fd in vfio_region_mmap().
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   include/hw/vfio/vfio-device.h |  7 +++++--
>   hw/vfio/device.c              | 29 +++++++++++++++++++++++++----
>   hw/vfio/region.c              |  9 +++++++--
>   3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 923f9cd116..5cb817fd6a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -66,6 +66,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
> +    bool use_region_fds;
>       VFIODeviceOps *ops;
>       VFIODeviceIOOps *io_ops;
>       unsigned int num_irqs;
> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
>       struct vfio_region_info **reginfo;
> +    int *region_fds;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> @@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
>       /**
>        * @get_region_info
>        *
> -     * Fill in @info with information on the region given by @info->index.
> +     * Fill in @info (and optionally @fd) with information on the region given
> +     * by @info->index.
>        */

Could you please update the whole documentation of the VFIODeviceIOOps
struct and document each parameter ?


>       int (*get_region_info)(VFIODevice *vdev,
> -                           struct vfio_region_info *info);
> +                           struct vfio_region_info *info, int *fd);
>   
>       /**
>        * @get_irq_info
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index d0068086ae..29a8d72deb 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -226,6 +226,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
> +    int fd = -1;
>       int ret;
>   
>       /* check cache */
> @@ -240,7 +241,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   retry:
>       (*info)->argsz = argsz;
>   
> -    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
> +    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
>       if (ret != 0) {
>           g_free(*info);
>           *info = NULL;
> @@ -251,11 +252,19 @@ retry:
>           argsz = (*info)->argsz;
>           *info = g_realloc(*info, argsz);
>   
> +        if (fd != -1) {
> +            close(fd);
> +            fd = -1;
> +        }
> +
>           goto retry;
>       }
>   
>       /* fill cache */
>       vbasedev->reginfo[index] = *info;
> +    if (vbasedev->region_fds != NULL) {
> +        vbasedev->region_fds[index] = fd;
> +    }
>   
>       return 0;
>   }
> @@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>       vbasedev->io_ops = &vfio_device_io_ops_ioctl;
>       vbasedev->dev = dev;
>       vbasedev->fd = -1;
> +    vbasedev->use_region_fds = false;

why not extend vfio_device_init() with a 'region_fd_cache' bool
parameter instead ? and avoid the extra VFIODevice attribute.

>   
>       vbasedev->ram_block_discard_allowed = ram_discard;
>   }
> @@ -470,6 +480,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>   
>       vbasedev->reginfo = g_new0(struct vfio_region_info *,
>                                  vbasedev->num_regions);
> +    if (vbasedev->use_region_fds) {
> +        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
> +    }
>   }
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev)
> @@ -478,9 +491,14 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>   
>       for (i = 0; i < vbasedev->num_regions; i++) {
>           g_free(vbasedev->reginfo[i]);
> +        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
> +            close(vbasedev->region_fds[i]);
> +        }
> +

Adding a small helper to retrieve the region fd from the cache,
would hide some of the implementation details here and below in
vfio_region_mmap()


>       }
> -    g_free(vbasedev->reginfo);
> -    vbasedev->reginfo = NULL;
> +
> +    g_clear_pointer(&vbasedev->reginfo, g_free);

unrelated change.


Thanks,

C.



> +    g_clear_pointer(&vbasedev->region_fds, g_free);
>   
>       QLIST_REMOVE(vbasedev, container_next);
>       QLIST_REMOVE(vbasedev, global_next);
> @@ -502,10 +520,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
>   }
>   
>   static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
> -                                          struct vfio_region_info *info)
> +                                          struct vfio_region_info *info,
> +                                          int *fd)
>   {
>       int ret;
>   
> +    *fd = -1;
> +
>       ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
>   
>       return ret < 0 ? -errno : ret;
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 34752c3f65..cb172f2136 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -241,6 +241,7 @@ int vfio_region_mmap(VFIORegion *region)
>   {
>       int i, ret, prot = 0;
>       char *name;
> +    int fd;
>   
>       if (!region->mem) {
>           return 0;
> @@ -271,14 +272,18 @@ int vfio_region_mmap(VFIORegion *region)
>               goto no_mmap;
>           }
>   
> +        /* Use the per-region fd if set, or the shared fd. */
> +        fd = region->vbasedev->region_fds ?
> +             region->vbasedev->region_fds[region->nr] :
> +             region->vbasedev->fd,
> +
>           map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
>           munmap(map_base, map_align - map_base);
>           munmap(map_align + region->mmaps[i].size,
>                  align - (map_align - map_base));
>   
>           region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
> -                                     MAP_SHARED | MAP_FIXED,
> -                                     region->vbasedev->fd,
> +                                     MAP_SHARED | MAP_FIXED, fd,
>                                        region->fd_offset +
>                                        region->mmaps[i].offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {


