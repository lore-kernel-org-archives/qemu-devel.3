Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A57CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9zZ-0007Ss-Gs; Fri, 09 Oct 2026 08:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF9zY-0007Sb-Ff
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF9zV-0007nJ-Sg
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791549984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7UJ/cFQghE6o7TBjJPi2WaSS0vh+o1X1YjHPD4c62eQ=;
 b=EJdGMm097hWAvIJ6lwl5ln2SBjyYNugfeNCVlmqd4WG1arcs0D27NzVbM6RbdOAFAYQ5R7
 J28fJMGj6N9i3iYLWxBI/vMJWnZJGHPedr9g+oHXpdw9ej5FCvWmvEZNRTrzcEyL+q39FK
 Y2ly3WE7z25iysm1JHQuczo/gLdHbn0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-rTzCxhqxM-WEauevKV12zw-1; Fri, 9 Oct 2026 12:46:17 +0000
X-MC-Unique: rTzCxhqxM-WEauevKV12zw-1
X-Mimecast-MFC-AGG-ID: rTzCxhqxM-WEauevKV12zw_1791549976
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4887e5afd67so4966333f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791549976; x=1792154776; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7UJ/cFQghE6o7TBjJPi2WaSS0vh+o1X1YjHPD4c62eQ=;
 b=MYdDx3Nyw6FEUZoTRaOCu7duQ7nL8l8u5/AFq5A5gqxmvceVlXZamOkzStoPot9wCI
 N7sAlfnIx8AbI9b0qyZJDL5hDK05mXoNW9u784q26iJl1XNik1CV1749cxXxLI0mU7RT
 vHUbt96g/7s3AzW+obOEcK7E3hIH0yb04UMjKbH9DkRoqllI1LTCkVSDoL1SWoxUAMUm
 q+E8HPgjgsC5/BjW8YPBaaoj594QgzqfUiUlfvsPCHYMiUmImuqJba4b38nrkR52j0qV
 2jd/sqE5OCUtqtGNqwutJA/tAxUxYPQ5mue6VU1h6Zvbi5rSVmyBwvavhBudir36FAXb
 1AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791549976; x=1792154776;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7UJ/cFQghE6o7TBjJPi2WaSS0vh+o1X1YjHPD4c62eQ=;
 b=UIVKuq/fNqi0dNvEm3DpCgNaci9JnY6MWdcC3X0jsZQC0Q4uUmvE4Qr/IeX49VtnlE
 IYYUU3tAleQCadCA4ayOPNwFkgFT9Z336EdeK20l7zEDiMWT21BJOyxPLkYrzYYlw3tf
 KEjsl9lMj2DSBkCmptHe8+lyKk1gq6NrvBAev8c/x5RIe1dax9dkh2uebpZQSFEQXSzE
 HD/zJ65j8dKV1j/8EjrE+MTpXYKoAJ3hDL7jL9h/vpkOcOgKLT2lkRoUsGhL2kmnmMZR
 zjbt1pQF2KXoVWKL2FS36P/PBUb9ry+vBJwBVI+9t+NpshLQc60WWpmeXs316BPh/0Dy
 aQFw==
X-Gm-Message-State: AFq9FYJnTk8vXxG/P+Sf/B5WDLJyJ80b2XopOczZSgD1n+ZE0LiBTqM4
 8zfULiPSChSioYqpbz8Qin+uQM5Ny+qlq53NJAcog5FqKCQ8Nj1aEn/nmLV9zuYcPmPENbsleuQ
 eQYLnWWt/c31C3/tIkWgpQbXVeAEc1tDLPUGbVIxd5KhVm2pd8V3V+5YB
X-Gm-Gg: AYBFou2/zxPXCcTrWb0YphTW//kzlzJAZeBH0bI1IYbu8DuaOEB81niVX/FkdMBzbg/
 QO4FLkRUte8DpE/63Kfxp14dkO4MFe9cGE9NunR4xbIHg5blW6B2Nctz000mF3bCt+FJQ4BOxvB
 9GkbcFt62pX2jBhgCeTq6cpl1x2ds7c9AN4XkAMstUWbPSarsWuR4Bky3Uj8Qzdp58VlJ17ef1G
 0f8Wu1ghwoVYfAsQhNWt6lPAUb28bwXQnVexHWX7WN1DKYoO9lbPoq5/goc6lhgqIuG5E1YZTEC
 Npl3hqFOA9Oll+wfQjjtPXcHcZb2/UdmRfQV361SXuKobEH8S9NGJl7c8bYUt8i2lcXUI5bRB3o
 U19aLimjMUNf3frbun1SMM2OhymOnDKF7v0wE7gWj
X-Received: by 2002:a05:6000:4287:b0:48b:68:592e with SMTP id
 ffacd0b85a97d-48dba77cf6dmr4515186f8f.4.1791549975599; 
 Fri, 09 Oct 2026 05:46:15 -0700 (PDT)
X-Received: by 2002:a05:6000:4287:b0:48b:68:592e with SMTP id
 ffacd0b85a97d-48dba77cf6dmr4515143f8f.4.1791549975209; 
 Fri, 09 Oct 2026 05:46:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ac025esm3694862f8f.38.2026.10.09.05.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 05:46:14 -0700 (PDT)
Message-ID: <296e6216-bded-4fe2-a91a-977b8d889599@redhat.com>
Date: Fri, 9 Oct 2026 14:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Don't reset a device on a declined stop
 transition
To: Pankaj Kumar <pshit@nvidia.com>, alex@shazbot.org
Cc: qemu-devel@nongnu.org, pmohite@nvidia.com, dnigam@nvidia.com,
 avihaih@nvidia.com, alwilliamson@nvidia.com
References: <20261008024329.1996536-1-pshit@nvidia.com>
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
In-Reply-To: <20261008024329.1996536-1-pshit@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Pankaj

On 10/8/26 04:43, Pankaj Kumar wrote:
> QEMU resets a VFIO device whenever a migration state transition it requests
> fails. This is done by vfio_migration_set_state_or_reset(), which passes
> VFIO_DEVICE_STATE_ERROR as the recover state, forcing an immediate
> VFIO_DEVICE_RESET.
> 
> However, a device may legitimately decline a state transition, e.g. a vGPU
> that refuses to stop while a profiling/debug session is active in the guest.
> Such a device is still healthy and running the guest, so resetting it destroys
> a perfectly good VM.
> 
> Instead of resetting on a declined stop, recover the device to its current
> state. The current device state is always a valid, already-reached state, so
> recovering to it is effectively a no-op transition that cannot itself fail and
> trigger a reset:
> 
>   - vfio_vmstate_change() and vfio_vmstate_change_prepare() recover to the
>     current device state for the stop direction. The resume direction keeps
>     ERROR as the recover state, since a device that cannot resume is genuinely
>     broken.
> 
>   - vfio_save_complete_precopy() recovers to the current device state rather
>     than STOP. If it runs after an earlier stop was declined (the device still
>     in a running state), the stop-copy attempt is then rolled back instead of
>     resetting the device.
> 
> This lets vendor drivers decline a stop as a matter of policy without losing
> the guest, and lets such drivers drop their own workarounds that swallowed the
> spurious reset.
> 
> Signed-off-by: Pankaj Kumar <pshit@nvidia.com>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>

I don't remember seeing this change before. If so please remove any
trailers before sending. Reviews should be done on the list, even
more so when the reviewer is a well known and trusted contributor !

> ---
>   hw/vfio/migration.c | 37 +++++++++++++++++++++++++++++++++----
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 73c49d8c24..4a98afa7c2 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -771,9 +771,16 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>   
> -    /* We reach here with device state STOP or STOP_COPY only */
> +    /*
> +     * We normally reach here with the device in STOP or STOP_COPY. However, if
> +     * an earlier stop transition was declined by the device, it may still be in
> +     * a running state. Recover to the current device state rather than STOP, so
> +     * a device that declines the stop-copy transition is rolled back to its
> +     * current state instead of being reset out from under the guest.
> +     */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP, &local_err);
> +                                   vbasedev->migration->device_state,
> +                                   &local_err);
>       if (ret) {
>           error_report_err(local_err);
>           return ret;
> @@ -993,6 +1000,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
> +    enum vfio_device_mig_state recover_state;
>       Error *local_err = NULL;
>       int ret;
>   
> @@ -1009,7 +1017,15 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>           vfio_final_precopy_reinit_check(vbasedev);
>       }
>   
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> +    /*
> +     * If the device declines a stop-direction transition, roll it back to its
> +     * current state instead of resetting it out from under the guest. On resume
> +     * (running), a device that cannot transition is genuinely broken, so reset
> +     * it by using ERROR as the recover state.
> +     */
> +    recover_state = running ? VFIO_DEVICE_STATE_ERROR : migration->device_state;
> +    ret = vfio_migration_set_state(vbasedev, new_state, recover_state,
> +                                   &local_err);

How about introducing a common helper :

   static int vfio_migration_set_state_or_recover(VFIODevice *vbasedev,
                                       enum vfio_device_mig_state new_state,
                                       bool running, Error **errp)
   {
       VFIOMigration *migration = vbasedev->migration;
       enum vfio_device_mig_state recover_state =
           running ? VFIO_DEVICE_STATE_ERROR : migration->device_state;

       return vfio_migration_set_state(vbasedev, new_state, recover_state, errp);
   }


C.


>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
> @@ -1026,21 +1042,34 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>   static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
> +    enum vfio_device_mig_state recover_state;
>       Error *local_err = NULL;
>       int ret;
>   
>       if (running) {
>           new_state = VFIO_DEVICE_STATE_RUNNING;
> +        /*
> +         * If the device fails to resume, it is genuinely broken, so reset it
> +         * by using ERROR as the recover state.
> +         */
> +        recover_state = VFIO_DEVICE_STATE_ERROR;
>       } else {
>           new_state =
>               (vfio_device_state_is_precopy(vbasedev) &&
>                (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
>                   VFIO_DEVICE_STATE_STOP_COPY :
>                   VFIO_DEVICE_STATE_STOP;
> +        /*
> +         * A device may decline to stop (e.g. it is busy). Roll it back to its
> +         * current state rather than resetting it out from under the guest.
> +         */
> +        recover_state = migration->device_state;
>       }
>   
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> +    ret = vfio_migration_set_state(vbasedev, new_state, recover_state,
> +                                   &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()


