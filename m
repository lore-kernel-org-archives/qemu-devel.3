Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB1DD3DEA1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 06:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mE1-0004bH-8x; Mon, 21 Oct 2024 02:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t2mDy-0004b5-OY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t2mDx-0001xW-4B
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729493342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9c0oDs7P9vWzE7FGbKcBEbCMSd7nRvNCYwNwx22Gvpw=;
 b=D5GqIBWEZvVNVIRGNhxP0AONPaOgPinS8PFQDIp9a0iOZFRJvJ2UWBhw5PZ8UR4inzVW55
 5RJcjBOsYsTKszLu6RdDEqMY2hoW02USFiDsGaFsg8Mxsd9jSN6egM6xL8vfoVmNRmghSN
 adyPkX1PYtLK9Ma5rZeU3yCZgm9YknM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-rmfHcP3nP2S0_L1V4tCzwg-1; Mon, 21 Oct 2024 02:49:00 -0400
X-MC-Unique: rmfHcP3nP2S0_L1V4tCzwg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so30185335e9.3
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 23:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729493339; x=1730098139;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9c0oDs7P9vWzE7FGbKcBEbCMSd7nRvNCYwNwx22Gvpw=;
 b=eV4c9WIcNvtHJsXBlsdMn9ZtZs5SQuLFvX+gZwkZtE8OuVeyhBkeypWGaxnaaWjKXx
 ekiTpZZwXdDpJjH0ifMe6NO/RdSDoNNSOIypv3wPPYbfPQktLglBLEa/G91EsqxMUE4R
 S5Iu+B7PFcHJchHpAS0PmBtNv+pnBk8DpmoLb93Yu7t2hYvSTjd3IwJgCYjMk0gYOlLa
 JQrXQmjjfwct/enfDDkXCqPX5c6cGz4RnoF4MEHKWeRjtuoh4tcPj/s+fWb5f0wTfNOt
 rdmePuJSVtrcUApQJBoYPbK5N+TPyx48gKmgTD0cx/xxg4+cQh+rPI0HiROqxcuQW2qa
 sUsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuJTXgQYfyi+vh+r5M5qRllN75ZyHjed8YTdznVDusB8clFK4vosU5n/EylzJwQNLzkzOYAw1PiOO+@nongnu.org
X-Gm-Message-State: AOJu0YwdNe7GQ5czntpA2f5sxso+zk5a44qfAdLuVLo/btSIRlldkahb
 AjhrCTeR6l2rsEsPt8DjK7SXadToaPEKXs8R7f0Ehz1A7sN/m21AF0NT6HFY6Df/kl8U5uszPfe
 vZorGGXkmdMk3O/QkUf9GRhbhbLiNGTrqr7aMaaVZx8la1q7DjZ79
X-Received: by 2002:a05:600c:674a:b0:431:508a:1a7b with SMTP id
 5b1f17b1804b1-431616a3f91mr75803715e9.34.1729493339630; 
 Sun, 20 Oct 2024 23:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw7sq1nsVfqc2YxIDlMBEhtkCCrrQDszUMamWqN26ZP86psESxs/R0WUm9j9HeRUuj08ngkQ==
X-Received: by 2002:a05:600c:674a:b0:431:508a:1a7b with SMTP id
 5b1f17b1804b1-431616a3f91mr75803535e9.34.1729493339291; 
 Sun, 20 Oct 2024 23:48:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0ba7c27sm3448704f8f.115.2024.10.20.23.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 23:48:58 -0700 (PDT)
Message-ID: <59275410-e818-4a50-a98d-041e55bb36cc@redhat.com>
Date: Mon, 21 Oct 2024 08:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio/migration: Report only stop-copy size in
 vfio_state_pending_exact()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhiyi Guo <zhguo@redhat.com>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-2-avihaih@nvidia.com>
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
In-Reply-To: <20241020130108.27148-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

+Zhiyi

On 10/20/24 15:01, Avihai Horon wrote:
> vfio_state_pending_exact() is used to update migration core how much
> device data is left for the device migration. Currently, the sum of
> pre-copy and stop-copy sizes of the VFIO device are reported.
> 
> The pre-copy size is obtained via the VFIO_MIG_GET_PRECOPY_INFO ioctl,
> which returns the amount of device data available to be transferred
> while the device is in the PRE_COPY states.
> 
> The stop-copy size is obtained via the VFIO_DEVICE_FEATURE_MIG_DATA_SIZE
> ioctl, which returns the total amount of device data left to be
> transferred in order to complete the device migration.
> 
> According to the above, current implementation is wrong -- it reports
> extra overlapping data because pre-copy size is already contained in
> stop-copy size. Fix it by reporting only stop-copy size.
> 
> Fixes: eda7362af959 ("vfio/migration: Add VFIO migration pre-copy support")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> --->   hw/vfio/migration.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 17199b73ae..992dc3b102 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -576,9 +576,6 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>   
>       if (vfio_device_state_is_precopy(vbasedev)) {
>           vfio_query_precopy_size(migration);
> -
> -        *must_precopy +=
> -            migration->precopy_init_size + migration->precopy_dirty_size;
>       }
>   
>       trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,


