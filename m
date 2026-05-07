Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE2DCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKu2K-0007cf-4q; Thu, 07 May 2026 04:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKu2I-0007cX-Jk
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKu2G-0001xY-4n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778142281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lhbNvIhICfqw3FPnX3X0TQxwJOxWRCtKlIHOZZi0vXE=;
 b=hhiuUSUopwCvV5JC5t85WHuBLFODeajpo319GBnJZZKtD6v8sISVTo/AgXsuAoYzUYm7eI
 e6X/LKFsf3SvKQzsnVI+/BUX4FwH279Ua8a+qwj5ZWPPo4WD0mPT8pdopBoDaABSkKmvkG
 6mxS+WKDT8vUNHOnEnmDwRnKRYEP3Y8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-UQw0JVwFOOCaGz8syf7VJg-1; Thu, 07 May 2026 04:24:40 -0400
X-MC-Unique: UQw0JVwFOOCaGz8syf7VJg-1
X-Mimecast-MFC-AGG-ID: UQw0JVwFOOCaGz8syf7VJg_1778142279
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48e5df7e6ecso3126515e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778142279; x=1778747079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lhbNvIhICfqw3FPnX3X0TQxwJOxWRCtKlIHOZZi0vXE=;
 b=jxpud/4IyPdDlKlK9TPltDw6GFPLcQ56Ri9XoUaF4+152Lfqn23koNDTLi1IV/nEFV
 OASb9gtrGSCxBngylMoLQ0Hv+IRi55CCe8gHGtGEzGf9WmSxVSO/HFR3yDs15KAMtGds
 Cz7qk52/EoXBXcAuPRr+FDpqTCaUIJgiu7b4FcvEhQgeJVCnKtm/Wjqcr8Elwl2pcF7W
 mAyuNIQ5nocePQuH+/NqOWyfg2IYsfDfZiQChwinDyFXQX0Eou20/01lIQerZ1oVQN6A
 L1My2RL8Ex/q4DX+xtXANYcW7dy9AZHv9se/qby1L5wTAbeJ9hd1a4648cK5Hwbty6fM
 DNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142279; x=1778747079;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhbNvIhICfqw3FPnX3X0TQxwJOxWRCtKlIHOZZi0vXE=;
 b=ivL4b2VCnFNVht4Fv52Ah9MTVq62X6gpOSV2gGro8anzjxlCdg2OOveimbiWX+Hl8q
 /v1nmu9EVAC8goSjdv+VDr5PN0AeOkbySznJPA6MOuB1zwCAT6nsDyI3s/usGkgqoRaP
 hk8X25tOZjTVnDpEHZciXQDMCgWOQDmVqp3Hi9DPRWbrr1V80sUo/KT533j3NNU94qjZ
 pfQQjDCRgDH9aaKi2Zu4wid673ZY2JXarN6VSYC8bw1jtMwyPF3RkM6SqetkbEYlQLid
 NIhVY9Arz4LBxmfPlHGd6+zPHw9t2l6i1cEIf3iahZfkr1foYgu+fVNHmG5O1c6+dMlT
 6BUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wh+e3XJQI0ostiPouB++Um5yb7s3hTsplKnL2X5LcY/5vaUvpwsTLGTYNa4duanTd6VYkIeDMhYZC@nongnu.org
X-Gm-Message-State: AOJu0Yyq6bIbnLWi29zaj+3Cmh/HpmdBd3DvRbxUstTqt2x6FWhBsetL
 HizNXFpuLoNMnfrKZfLPmsW5hO76tOOqWOpUfH+BW86fPS4oaMRu0gV65bL/eWvI745VX0Xk4JK
 w/kDPMJDEGz9amxN0OmUrSM3Y6GUBy4VVaJdiPpz0ZnGH3ieuGPkNQ0hg
X-Gm-Gg: AeBDietv5WJtip7ZhuVsrqshFq6DC7XG+gC/+OJ8LwP3jRM3r6V7vhdFyvkxtKzLqze
 P+RsMeJ5Hft3PgLoyItUxEf3kJJgqDsABvg/pAvW4fQULB+QKeDx/avR+7ngEozsdW+T3aGX/Qq
 BcoKTnTYMAd6NiSkkfzHWu27giIBML2d3CBFq1r7vqjH1N8xYqKeH7kV+d70lgYzd1bWj+yckkQ
 zVE1pKOe08ZAv3lEABirqssT1LzYDdS42uXhauAa8ggitta8Sr1v61xx5dCpjkKuweCeh7RAfzn
 ZFiRf76nwCkHZzYDAfacYWlcyEjkmR+3iWnKo5CYfDpBMFBMvRBrlk/zw/o/Vfzf/P3oG3mstE1
 5wPPeGAMrcAQXgfp+xpaFDm6cEDs0C2bgECiwW28LSeUAhT9OFKfrvnoHR+O4bHiZcTCnGvk=
X-Received: by 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48e51e19668mr112025925e9.8.1778142279098; 
 Thu, 07 May 2026 01:24:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48e51e19668mr112025235e9.8.1778142278355; 
 Thu, 07 May 2026 01:24:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb1a7sm186110985e9.9.2026.05.07.01.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 01:24:37 -0700 (PDT)
Message-ID: <d76a2215-d06a-4ab0-9031-2e81f08690d9@redhat.com>
Date: Thu, 7 May 2026 10:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] vfio/migration: Re-query precopy size before
 sending VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-10-avihaih@nvidia.com>
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
In-Reply-To: <20260505081423.28326-10-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Avihai

On 5/5/26 10:14, Avihai Horon wrote:
> When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> flag is sent to the destination to indicate that initial data has been
> sent, so destination can indicate back to source when it finished
> loading it.
> 
> To get a more accurate estimation of initial_bytes, re-query precopy
> size before sending the flag. Extract the flag sending logic from
> vfio_save_iterate() to a new helper for clarity.

I would prefer to separate the changes, so a patch for this new routine,
and then :

> 
> This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> flag if, for example, the previously queried initial_bytes was lower
> than actually is. Additionally, it prevents sending the flag if
> vfio_query_precopy_size() failed.


Thanks,

C.


> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
>   hw/vfio/trace-events |  1 +
>   2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2911583ee1..243624b5fe 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
>                                            data_size);
>   }
>   
> +/* Returns true if the init data flag was sent, false otherwise */
> +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
> +{
> +    VFIODevice *vbasedev = migration->vbasedev;
> +    int ret;
> +
> +    if (!migrate_switchover_ack()) {
> +        return false;
> +    }
> +
> +    if (migration->precopy_init_size || migration->initial_data_sent) {
> +        return false;
> +    }
> +
> +    /*
> +     * precopy_init_size holds an estimation of the initial data size, re-query
> +     * precopy size to ensure it's really zero before sending init data flag.
> +     * Don't send the flag if query fails.
> +     */
> +    ret = vfio_query_precopy_size(migration);
> +    if (ret || migration->precopy_init_size) {
> +        return false;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
> +    migration->initial_data_sent = true;
> +    trace_vfio_send_init_data_flag(vbasedev->name);
> +
> +    return true;
> +}
> +
>   static bool vfio_precopy_supported(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
> @@ -664,11 +695,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>   
>       vfio_update_estimated_pending_data(migration, data_size);
>   
> -    if (migrate_switchover_ack() && !migration->precopy_init_size &&
> -        !migration->initial_data_sent) {
> -        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
> -        migration->initial_data_sent = true;
> -    } else {
> +    if (!vfio_send_init_data_flag(f, migration)) {
>           qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>       }
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ab27ff5ea2..e91858354c 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -176,6 +176,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
>   vfio_save_iterate_start(const char *name) " (%s)"
>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
>   vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
> +vfio_send_init_data_flag(const char *name) " (%s)"
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   


