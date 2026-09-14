Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5A2C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x61b0-0006pQ-VB; Mon, 14 Sep 2026 03:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x61ay-0006oy-Mg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x61aw-0005TQ-LL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789372757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=secwxCcSC5/MaWohFXsHniwuhUBhIR6i9QKferZgNHk=;
 b=Q+ybsfhsiU1/fdJAOSAbuUX0hWVTwVPfiRIDRMbzuJ9UKWkMYSjRs+ZN853+dUd55K10Ga
 tuUae6K5a//meB2N7Czyl3gZy8Kcdb1h0wC9n6+F2MOGF4ouV3HHwmN2F7TkR55P39ZS1A
 luKkpoonnESLzn8OeHnTPhCeYNTEN8E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PP7lbP0iPaajLvTNz_tN3g-1; Mon, 14 Sep 2026 03:59:13 -0400
X-MC-Unique: PP7lbP0iPaajLvTNz_tN3g-1
X-Mimecast-MFC-AGG-ID: PP7lbP0iPaajLvTNz_tN3g_1789372752
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49d156c917cso25208495e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789372752; x=1789977552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=secwxCcSC5/MaWohFXsHniwuhUBhIR6i9QKferZgNHk=;
 b=Dnm5+e2+z31drTCMoIIZhUIOoxahtbDAh5EygYfD/KfM9MSOge0g3YMhfBJNTcoDQH
 yhFdE9epYhzk/ojr0aGvoqhayQFjX5Xi+5XlJf+Kw9gWG9GSRwF3V6fiK6hvQWQKI62E
 RgUUA2q7crYBBHMk3svf4TzTI6Dz6t71RcIVUmJTa7LKAxVFS7r/i+hUgoSO6YypHlSm
 qCjDJFgs5EylgUbPvSzubn93McmGLwz+hcZgUC2hjm+jSqJ/VT4ku0o2OIL0Lv15DgFG
 my2zuotmON4nk2XDAIaNzyDM/fnlrEXnPjsBPw6wxp+UH4QFfs5nTFYFcO/wV/5OWXj1
 RV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789372752; x=1789977552;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=secwxCcSC5/MaWohFXsHniwuhUBhIR6i9QKferZgNHk=;
 b=DPzwNfKxxZHLh3rvY1ZR3gH9LWhTgVJPOKgQFORCOC6P/s4T5fPTMpof2+3pCcUI+5
 pm5H/v3fA7qzRZiWoxnSYeTSdxABC+VJ0ZyQ8G7ssLvp55jcxFFp5BzQAShX5Am5V6nO
 en8/4b4LynWd8dAYBlLZSu7BTDLM19NDHf25trhOGR1MSwqdhCwNoMNPguGZuOLxyKzt
 PlaRZL6buKymBeMLhkxTkSEFTOLLDrWysNUbbCYog17kbfuT/i1fFw+xZeki+oZ2jvoz
 wfekjI1awggrgzPwjZ2MCTce2ALv2YiYXaH+FNWvruujccz0zQAneL9E91MQoy/eDDj0
 50RA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFeF2hstH135qtZCAuOLuTL5vRI3H6hybVToDPWSyvdNp+DLmRWjvzU7EWGJK6+kLfNvTS4u6yiSus@nongnu.org
X-Gm-Message-State: AFuF++l5jLRMjaFpKu71FC2ZJPONWwc3pQ2EjV2CqTFdkQ5KY4R82dtx
 glFpWtqfT54uUGF1sDItKUmWPTVXoR7qdfe+zotsKkPpctJalPbd6DW+H+s+de7QPG9Uv4cMPVs
 T5FKQZX6HdPcxVqEWYKQNBgVGjV3yiSWHw1/RVu9veRT+Es2CvKtHvV++
X-Gm-Gg: AYBFou1moHFEs2BIpResXSfcgjHhzJD25ttkdnQPlQiW1F/8Lj92lilIVcqg9echBkZ
 7Cnjf4i1EFhn8uFjwaRxnD4kxvAS9sF4D90HeaToktiEREtv5LXxEi0GVhx5cHj+XVHPDEgbhJL
 kby0BJWq8PzW5dJfD4badFECCa3sOfG5K1H0XA6emtQPdKh/F2hlHx+gx+OxgR/HMh0iZlRew0S
 fF15BggZRGsG0idelUY5tt7I2XXZOFQ/oxg9YTaFH46I5QNhwHzdwzdHKvqDuYgFwIiiSAhCQVp
 82NzYRpIQGJUNeLnJnjC+j0kNwa092VnzTEWHj3GfyIgV9vwDtflo63aFu/AIfGlZTCAJCtc8ht
 CvAy7m5W9LS2e1fbEhsk5oBlRn9B5nyAzwIVLY+gjCw==
X-Received: by 2002:a05:600c:1387:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49e7a65d32cmr14645725e9.8.1789372752339; 
 Mon, 14 Sep 2026 00:59:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1387:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49e7a65d32cmr14645425e9.8.1789372751880; 
 Mon, 14 Sep 2026 00:59:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ad0614sm319618085e9.10.2026.09.14.00.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 00:59:10 -0700 (PDT)
Message-ID: <017b012c-4c94-4f08-b902-9dc7cfe5eaf1@redhat.com>
Date: Mon, 14 Sep 2026 09:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] vfio: use io_ops abstraction for migration related
 ioctls
To: Hugo Komatsu <hugo.komatsu@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>, Thanos Makatos
 <thanos.makatos@nutanix.com>, Tony Krowiak <akrowiak@linux.ibm.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
 <20260911140710.2348139-6-hugo.komatsu@nutanix.com>
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
In-Reply-To: <20260911140710.2348139-6-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/11/26 16:19, Hugo Komatsu wrote:
> The generic VFIO migration code in hw/vfio/migration.c issued read()
> and qemu_file_get_to_fd() directly, hardcoding the kernel as the only
> transport. Route these through the VFIODeviceIOOps table so an
> alternate transport (vfio-user) can supply its own implementations.
> 
> Add three migration slots - get_precopy_info, mig_data_read, and
> mig_data_write_from_file - and guarded public wrappers that dispatch to
> the selected backend. Implement the kernel callbacks around the existing
> calls. vfio_query_precopy_size() and vfio_save_block() now take a
> VFIODevice so they can call the wrappers.
> 
> This is a pure refactor: the kernel path is unchanged.
> 
> Co-authored-by: Rafael Castillo <rafael@trfs.me>
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>
> ---
>   hw/vfio/device.c              | 64 +++++++++++++++++++++++++++++++++++
>   hw/vfio/migration.c           | 37 ++++++++++----------
>   include/hw/vfio/vfio-device.h | 45 ++++++++++++++++++++++++
>   3 files changed, 127 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index b2123a0443..ddd7508359 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -30,8 +30,10 @@
>   #include "qemu/units.h"
>   #include "migration/cpr.h"
>   #include "migration/blocker.h"
> +#include "migration/qemu-file.h"
>   #include "monitor/monitor.h"
>   #include "vfio-helpers.h"
> +#include "vfio-migration-internal.h"
>   
>   VFIODeviceList vfio_device_list =
>       QLIST_HEAD_INITIALIZER(vfio_device_list);
> @@ -576,6 +578,34 @@ int vfio_device_reset(VFIODevice *vbasedev)
>       return vbasedev->io_ops->device_reset(vbasedev);
>   }
>   
> +int vfio_device_get_precopy_info(VFIODevice *vbasedev,
> +                                 struct vfio_precopy_info *info)
> +{
> +    if (!vbasedev->io_ops || !vbasedev->io_ops->get_precopy_info) {
> +        return -EINVAL;
> +    }
> +    return vbasedev->io_ops->get_precopy_info(vbasedev, info);
> +}
> +
> +ssize_t vfio_device_mig_data_read(VFIODevice *vbasedev, void *buf,
> +                                  size_t buf_size)
> +{
> +    if (!vbasedev->io_ops || !vbasedev->io_ops->mig_data_read) {
> +        return -EINVAL;
> +    }
> +    return vbasedev->io_ops->mig_data_read(vbasedev, buf, buf_size);
> +}
> +
> +int vfio_device_mig_data_write_from_file(VFIODevice *vbasedev, QEMUFile *f,
> +                                         size_t data_size)
> +{
> +    if (!vbasedev->io_ops ||
> +        !vbasedev->io_ops->mig_data_write_from_file) {
> +        return -EINVAL;
> +    }
> +    return vbasedev->io_ops->mig_data_write_from_file(vbasedev, f, data_size);
> +}
> +
>   int vfio_device_get_feature(VFIODevice *vbasedev,
>                               struct vfio_device_feature *feature)
>   {
> @@ -598,6 +628,37 @@ static int vfio_device_io_device_reset(VFIODevice *vbasedev)
>       return ret < 0 ? -errno : ret;
>   }
>   
> +static ssize_t vfio_device_io_mig_data_read(VFIODevice *vbasedev, void *buf,
> +                                            size_t buf_size)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    ssize_t ret;
> +
> +    ret = read(migration->data_fd, buf, buf_size);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_mig_data_write_from_file(VFIODevice *vbasedev,
> +                                                   QEMUFile *f,
> +                                                   size_t data_size)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return qemu_file_get_to_fd(f, migration->data_fd, data_size);
> +}
> +
> +static int vfio_device_io_get_precopy_info(VFIODevice *vbasedev,
> +                                           struct vfio_precopy_info *info)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    ret = ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
>   static int vfio_device_io_device_feature(VFIODevice *vbasedev,
>                                            struct vfio_device_feature *feature)
>   {
> @@ -678,6 +739,9 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .capabilities = VFIO_IO_CAP_DMA_BUF,
>   
>       .device_reset = vfio_device_io_device_reset,
> +    .mig_data_read = vfio_device_io_mig_data_read,
> +    .mig_data_write_from_file = vfio_device_io_mig_data_write_from_file,
> +    .get_precopy_info = vfio_device_io_get_precopy_info,
>       .device_feature = vfio_device_io_device_feature,
>       .get_region_info = vfio_device_io_get_region_info,
>       .get_irq_info = vfio_device_io_get_irq_info,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 25acb6dca4..257f9253aa 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -247,10 +247,9 @@ vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>                               uint64_t data_size)
>   {
> -    VFIOMigration *migration = vbasedev->migration;
>       int ret;
>   
> -    ret = qemu_file_get_to_fd(f, migration->data_fd, data_size);
> +    ret = vfio_device_mig_data_write_from_file(vbasedev, f, data_size);
>       trace_vfio_load_state_device_data(vbasedev->name, data_size, ret);
>   
>       return ret;
> @@ -369,20 +368,20 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>       return ret;
>   }
>   
> -static int vfio_query_precopy_size(VFIOMigration *migration)
> +static int vfio_query_precopy_size(VFIODevice *vbasedev)
>   {
> -    VFIODevice *vbasedev = migration->vbasedev;
> +    VFIOMigration *migration = vbasedev->migration;
>       struct vfio_precopy_info precopy = {
>           .argsz = sizeof(precopy),
>       };
>       bool reinit = false;
>       int ret = 0;
>   
> -    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
> +    ret = vfio_device_get_precopy_info(vbasedev, &precopy);
> +    if (ret) {
>           migration->precopy_init_size = 0;
>           migration->precopy_dirty_size = 0;
> -        ret = -errno;
> -        warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
> +        warn_report_once("VFIO device %s get_precopy_info "
>                            "failed (%d)", vbasedev->name, ret);
>       } else {
>           bool overflow;
> @@ -425,18 +424,20 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>   }
>   
>   /* Returns the size of saved data on success and -errno on error */
> -static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
> +static ssize_t vfio_save_block(QEMUFile *f, VFIODevice *vbasedev)
>   {
> +    VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>   
> -    data_size = read(migration->data_fd, migration->data_buffer,
> -                     migration->data_buffer_size);
> +    data_size = vfio_device_mig_data_read(vbasedev,
> +                                          migration->data_buffer,
> +                                          migration->data_buffer_size);
>       if (data_size < 0) {
>           /*
>            * Pre-copy emptied all the device state for now. For more information,
>            * please refer to the Linux kernel VFIO uAPI.
>            */
> -        if (errno == ENOMSG) {
> +        if (data_size == -ENOMSG) {
>               if (!migration->event_precopy_empty_hit) {
>                   trace_vfio_save_block_precopy_empty_hit(migration->vbasedev->name);
>                   migration->event_precopy_empty_hit = true;
> @@ -444,7 +445,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>               return 0;
>           }
>   
> -        return -errno;
> +        return data_size;
>       }
>       if (data_size == 0) {
>           return 0;
> @@ -599,7 +600,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>                   return ret;
>               }
>   
> -            vfio_query_precopy_size(migration);
> +            vfio_query_precopy_size(vbasedev);
>               if (migrate_switchover_ack() && !migrate_switchover_ack_legacy()) {
>                   migration->request_switchover_ack = true;
>               }
> @@ -662,12 +663,10 @@ static void vfio_save_cleanup(void *opaque)
>   
>   static void vfio_state_pending_sync(VFIODevice *vbasedev)
>   {
> -    VFIOMigration *migration = vbasedev->migration;
> -
>       vfio_query_stop_copy_size(vbasedev);
>   
>       if (vfio_device_state_is_precopy(vbasedev)) {
> -        vfio_query_precopy_size(migration);
> +        vfio_query_precopy_size(vbasedev);
>       }
>   }
>   
> @@ -738,7 +737,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>           migration->event_save_iterate_started = true;
>       }
>   
> -    data_size = vfio_save_block(f, migration);
> +    data_size = vfio_save_block(f, vbasedev);
>       if (data_size < 0) {
>           return data_size;
>       }
> @@ -778,7 +777,7 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       }
>   
>       do {
> -        data_size = vfio_save_block(f, vbasedev->migration);
> +        data_size = vfio_save_block(f, vbasedev);
>           if (data_size < 0) {
>               return data_size;
>           }
> @@ -975,7 +974,7 @@ static void vfio_final_precopy_reinit_check(VFIODevice *vbasedev)
>           return;
>       }
>   
> -    ret = vfio_query_precopy_size(migration);
> +    ret = vfio_query_precopy_size(vbasedev);
>       if (ret) {
>           error_report("%s: Final precopy reinit check failed (err: %d)",
>                        vbasedev->name, ret);
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 6dc596c9fc..f0add3fd84 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -202,6 +202,18 @@ struct VFIODeviceIOOps {
>        */
>       int (*device_reset)(VFIODevice *vdev);
>   
> +    /**
> +     * @get_precopy_info
> +     *
> +     * Get information about pre-copy migration data transfer progress.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @info: pointer to struct vfio_precopy_info to fill in
> +     *
> +     * Returns 0 on success or -errno.
> +     */
> +    int (*get_precopy_info)(VFIODevice *vdev, struct vfio_precopy_info *info);
> +
>       /**
>        * @device_feature
>        *
> @@ -268,6 +280,33 @@ struct VFIODeviceIOOps {
>       int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
>                          void *data);
>   
> +    /**
> +     * @mig_data_read
> +     *
> +     * Read migration data from the device.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @buf: buffer to read into
> +     * @buf_size: maximum number of bytes to read
> +     *
> +     * Returns the number of bytes read on success or -errno.
> +     */
> +    ssize_t (*mig_data_read)(VFIODevice *vdev, void *buf, size_t buf_size);
> +
> +    /**
> +     * @mig_data_write_from_file
> +     *
> +     * Write migration data to the device, reading the data from a QEMUFile.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @f: source to read the migration data from
> +     * @data_size: number of bytes to write
> +     *
> +     * Returns 0 on success or -errno.
> +     */
> +    int (*mig_data_write_from_file)(VFIODevice *vdev, QEMUFile *f,
> +                                    size_t data_size);
> +
>       /**
>        * @region_write
>        *
> @@ -299,6 +338,12 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t size);
>   
>   int vfio_device_reset(VFIODevice *vbasedev);
> +int vfio_device_get_precopy_info(VFIODevice *vbasedev,
> +                                 struct vfio_precopy_info *info);
> +ssize_t vfio_device_mig_data_read(VFIODevice *vbasedev, void *buf,
> +                                  size_t buf_size);
> +int vfio_device_mig_data_write_from_file(VFIODevice *vbasedev, QEMUFile *f,
> +                                         size_t data_size);
>   int vfio_device_get_feature(VFIODevice *vbasedev,
>                               struct vfio_device_feature *feature);
>   

I would prefer one patch per op please.

Thanks,

C.


