Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCABC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 13:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnHqR-0005Ri-0G; Wed, 26 Feb 2025 08:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnHqP-0005RG-6W
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnHqN-0004Fs-FK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740577978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aUincokfNx45Wadwz1r/N34ms9Ti+BsCB5MtiU3fyXc=;
 b=B6Ed9TKEyUymmfdJ8fWeuzAXe81CbUZtlO2YstQNuuD+zQF7h+SHIwWII533PRLWG1Q1TV
 b3zDMIpMhd9Xbm0gznL/Ky0jyZPlfQf/TeZp+kmrj5UpFfpBvjaa+ayaPj8pZA0TJszEIW
 Ab1iiCGuLxLWfG2qqFTN3Qrw3IUKcuE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-l7cjXtXRMzmQRyW3t_bUxg-1; Wed, 26 Feb 2025 08:52:57 -0500
X-MC-Unique: l7cjXtXRMzmQRyW3t_bUxg-1
X-Mimecast-MFC-AGG-ID: l7cjXtXRMzmQRyW3t_bUxg_1740577976
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43945f32e2dso62645905e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 05:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740577975; x=1741182775;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUincokfNx45Wadwz1r/N34ms9Ti+BsCB5MtiU3fyXc=;
 b=XPqGpMmfmLZaaQWeXBHeYRkz9WT3zfp1oEp+jSMXJH5sdW2yo/zdqiB6131NvpXe3h
 bVqv9keW/BcZ4tJlsnDmtHV+plv/orA4vVdVcFvXXS6J2lx/6OQJcEGpzr9o2KAt79a1
 lRk3wgjFirxA2pRWASAZzeuG2C1xfXVNH0yVC1lX+6lq7a5YCmZ856HGzczq5itJNn2e
 lJG4dluxABKtbRdi+a9dvJzUG8ZF7Zg2shN8k46mK+VngfxZCz8wlgM9VZX1I9PQEMtz
 fCp/ZBaqFK6vly4XPNYdDX+dtogfOVIbad9zI/thLUbAL7ssIXBP4FKMSAOuKyUFJufq
 /5XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI6o5FeHD7B5hkeaEUcK+dmXoSnwTky0TCman0Zp1pZSm4ZfJwSAu+sRP/tZSG8AgHhgffSToRiUyw@nongnu.org
X-Gm-Message-State: AOJu0Yy27pS1KX8Gw6QfziDP6GCtfXhBbq/0XnxCDrfnQyxTs64Ob+ZX
 IWW/TVjX9JaSzxOME/T+s2chKwabtKlnjHBMNBnDPEyiQwO4MdMUlfW1oxGA/XV/FH6vjqQ4iWx
 sjUSmYrrU2oopjrRMtv95BOhHlssFpUOYyimmjSq8q2Diz2TCt1jzjYKOxpQW
X-Gm-Gg: ASbGncsx93bMiDahrjgaGKXtUQ8+UbjhmvyBPadFc9vCL6HuoKMUNmzWX8dSsavMluJ
 nBmOlYv9+ZF+dG6pE5cUx0w4dulcU7yc2U5z4J5Tb7rgYbLGvzf7CYtuiyllIc0bi5J6TwUFZO1
 A8IOBeCs8WQnLM6VlTEL9jLOBBkmLezH/PJqCZ+q+XZGpPyt+4qGzWOD9Kc6BBQFIR6k9n2odwr
 9ZfaYwdprHtqC9GKdKRsntOAvfqlA+R0/NpunK9THagOBU7vURLg3cYaMJ/3SN2kNyeCSimjhGX
 A+QR/fQX/KhOAlo71X4azZbRGEMDJd0xdQGlaIa8IAJzjtnTo2R4XChvddo=
X-Received: by 2002:a05:600c:138d:b0:439:9ee1:86bf with SMTP id
 5b1f17b1804b1-43ab0f2db6cmr81465715e9.7.1740577975623; 
 Wed, 26 Feb 2025 05:52:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIfPoOxNywiwcoX95levNE2SG/KUNaUecoqbIrbddyFox6yaGTzzVjqFqNbTMPKtL8e5pjrg==
X-Received: by 2002:a05:600c:138d:b0:439:9ee1:86bf with SMTP id
 5b1f17b1804b1-43ab0f2db6cmr81465405e9.7.1740577975284; 
 Wed, 26 Feb 2025 05:52:55 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba543fecsm23051715e9.30.2025.02.26.05.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 05:52:54 -0800 (PST)
Message-ID: <96a45aae-ca5f-4830-8ab8-496fd08b1a62@redhat.com>
Date: Wed, 26 Feb 2025 14:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/36] vfio/migration: Multifd device state transfer
 support - config loading support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <47be7bf2f46923e2a9d2b75b1d35c6b2915c20c8.1739994627.git.maciej.szmigiero@oracle.com>
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
In-Reply-To: <47be7bf2f46923e2a9d2b75b1d35c6b2915c20c8.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Load device config received via multifd using the existing machinery
> behind vfio_load_device_config_state().
> 
> Also, make sure to process the relevant main migration channel flags.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 47 ++++++++++++++++++++++++++++++++++-
>   hw/vfio/migration.c           |  8 +++++-
>   include/hw/vfio/vfio-common.h |  2 ++
>   3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index b3a88c062769..7200f6f1c2a2 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -15,6 +15,7 @@
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/thread.h"
> +#include "io/channel-buffer.h"
>   #include "migration/qemu-file.h"
>   #include "migration-multifd.h"
>   #include "trace.h"
> @@ -186,7 +187,51 @@ bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>   
>   static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)

please modify to return a bool and take a "Error **errp" parameter.


Thanks,

C.


>   {
> -    return -EINVAL;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    QEMUFile *f_out = NULL, *f_in = NULL;
> +    uint64_t mig_header;
> +    int ret;
> +
> +    assert(multifd->load_buf_idx == multifd->load_buf_idx_last);
> +    lb = vfio_state_buffers_at(&multifd->load_bufs, multifd->load_buf_idx);
> +    assert(lb->is_present);
> +
> +    bioc = qio_channel_buffer_new(lb->len);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
> +
> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
> +
> +    ret = qemu_fflush(f_out);
> +    if (ret) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        return ret;
> +    }
> +
> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
> +
> +    mig_header = qemu_get_be64(f_in);
> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        g_clear_pointer(&f_in, qemu_fclose);
> +        return -EINVAL;
> +    }
> +
> +    bql_lock();
> +    ret = vfio_load_device_config_state(f_in, vbasedev);
> +    bql_unlock();
> +
> +    g_clear_pointer(&f_out, qemu_fclose);
> +    g_clear_pointer(&f_in, qemu_fclose);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return 0;
>   }
>   
>   static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 85f54cb22df2..b962309f7c27 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -264,7 +264,7 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>       return ret;
>   }
>   
> -static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>       uint64_t data;
> @@ -728,6 +728,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            if (vfio_multifd_transfer_enabled(vbasedev)) {
> +                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
> +                             vbasedev->name);
> +                return -EINVAL;
> +            }
> +
>               return vfio_load_device_config_state(f, opaque);
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ab110198bd6b..ce2bdea8a2c2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -298,6 +298,8 @@ void vfio_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>   
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
>   #ifdef CONFIG_LINUX
>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                            struct vfio_region_info **info);
> 


