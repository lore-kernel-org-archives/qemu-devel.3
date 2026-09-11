Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBB3C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4u9e-0001E0-2y; Fri, 11 Sep 2026 01:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x4u9b-0001Dd-Ib
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 01:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x4u9Z-0007xi-4W
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 01:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789105822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VbZMwa//0B45I7b1jcXpfDgGK1I1IRU0W8Q78f73tcw=;
 b=RTnbYbuGN/uZia0dyg9A9zv0wi7dTQB28N2T/3nhBX+9d7Zxccvcd7W0sc40xTYosk4lBJ
 uG1g9P7vrArLIRWUvvSXrWByW7ib2CcRjK19OKk9puc08FL3qLc0f9CxaEETWEX4SWb9Vu
 4AULky/8Bzv6y2JDgW+AuLrzTlnWn3Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-AN0oBl4IOlSLsPM8e7tmDg-1; Fri, 11 Sep 2026 01:50:20 -0400
X-MC-Unique: AN0oBl4IOlSLsPM8e7tmDg-1
X-Mimecast-MFC-AGG-ID: AN0oBl4IOlSLsPM8e7tmDg_1789105819
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso2633705e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 22:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789105819; x=1789710619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VbZMwa//0B45I7b1jcXpfDgGK1I1IRU0W8Q78f73tcw=;
 b=OYmqGm9PyDeNV6KQ77L0k1rHP7yC2TgmpXmaSaogJGlXxo799tTSOC0Eum6gnFZcRd
 O5HD/Uq6lA1EamJyVZUP1DW9gtTpom31FFk7YUPD52XUPFNM0IgPox+ferMAqQusFw36
 q7VO2+NPDwLICrJ3A4OuwOwq3QF5foOtFi/nTawkNj2cqKAav57EWYSe0jAHCCzZTHOi
 O8wOWgNYwzOl0a27xtg+aCBtFP8OwgzerUydUuPzmQCa/hfJPn+zGSuloSkBbmNsmY4s
 3+9YygD18HD9ApCwiSN3Wm3Jv1+T3X9Np6rmKOMRrbBiZ79zjfhIsgS3VhecBlj2OS37
 ASPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789105819; x=1789710619;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VbZMwa//0B45I7b1jcXpfDgGK1I1IRU0W8Q78f73tcw=;
 b=IgCTva6ekJUK9IHIKgrbvUSDbQXlIBMhfWXfYXtCW/m6A+JCy3IqYFSQ+gSb+ncsar
 JjC485WLdhmV+VE4aYZ1tqqUul2sbY4N3yGrGBLZx3jCHDdVVwdma+ZqVnLFoU+mazSe
 L8g1kfDBe5fjCgw9kjYvJ6sVI0WCbG5xXvPGMa8KAfaQo947JL6ZkpsDREQIrgDWT4jr
 5gBzHY6QAWEaFQx3pzloqPi3wwpfD74bPrtSGGgZ7dIcLduSXmCpMGWrMBZ02tug44bn
 VBl+8Dujchz5PA5dS6fA0FxWiC0nu938tyB31dIeiy3E9fhNfD7D6bwp9tRLT++D3IlV
 vqEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5R31zkM7Q3Jndu26yd7tVsjBwTMlMe2pmlyMkVWDXbLZVpCHK52LbFA6pcCzNcXmo+NKXAcKLBGFS@nongnu.org
X-Gm-Message-State: AFuF++lJAnX5baY68KVyL4s8WAjVGEyBQKrYCDT9qkPvyfh/LwjYlPKQ
 WzGXmQVIrYEvWzWV7Jw8Z7cWRc53q1g18amj7N2OCZjnSBgyFqmtLdY0MazKxjTGYErv8ztZxnM
 nkkiSn8lvPIgIFkC/cJm3v69ivcnYdktSpyRKV7SLfHniVtdkH4TldzLY
X-Gm-Gg: AYBFou2CRl4wm0fSqLNGDZqPPd47yQJCwbw2oM/vOtO8yweOQ5x1G2aF3OojBm7EY8u
 HkY65OV+6rd9q+MmnssaKJP/GHQQ3zeg14izQOz1h8GFCSvc2HKprY8+LWmEdQczL7w21nTuO9P
 ximhEzls9Ipbaylb9hDiBADpTR8vDZvVRXlmT9smsXRtEax9Q4KMx0v7zNK+aELzn2EJNgeiyOD
 5EGotsbx3hRwPloqNnhE6JsSoLUTjzShtvxPVoz2NXqyAhkF/oQYpDMPHlqqDFOr9d10Tpahyb2
 cQApLsOIRn/HiijG7Dw+seRqlvuzXfq7qFvtxTB/RFp0+zSJVBZSXtYIjC+mxIUXtEKIpauEhvh
 naeEJPKCqT1zq7qKz8ZRUpEpeokXsre03TIXA4a5mEQ==
X-Received: by 2002:a05:600c:3b23:b0:49c:dada:f581 with SMTP id
 5b1f17b1804b1-49e61644361mr24892855e9.0.1789105819376; 
 Thu, 10 Sep 2026 22:50:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3b23:b0:49c:dada:f581 with SMTP id
 5b1f17b1804b1-49e61644361mr24892595e9.0.1789105818983; 
 Thu, 10 Sep 2026 22:50:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e641fb3d1sm8808415e9.2.2026.09.10.22.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 22:50:18 -0700 (PDT)
Message-ID: <81385deb-6cc0-4637-85f1-90db1111ec71@redhat.com>
Date: Fri, 11 Sep 2026 07:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/vfio: thread vf-token through iommufd bind
To: Tushar Dave <tdave@nvidia.com>, alex@shazbot.org, qemu-devel@nongnu.org,
 skolothumtho@nvidia.com
Cc: jgg@nvidia.com
References: <20260908160731.1658621-1-tdave@nvidia.com>
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
In-Reply-To: <20260908160731.1658621-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/26 18:07, Tushar Dave wrote:
> A VF fails to bind through the iommufd/cdev backend when its PF is
> bound to vfio-pci and requires a matching VF token.
> 
> QEMU currently initializes struct vfio_device_bind_iommufd without
> the token flag or token UUID.
> 
> Pass the existing vf-token device property to the IOMMUFD bind ioctl
> for PCI devices.
> 
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>   hw/vfio/iommufd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 242644aa00..de482128bf 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -155,6 +155,7 @@ static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
>   
>   static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>   {
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
>       IOMMUFDBackend *iommufd = vbasedev->iommufd;
>       struct vfio_device_bind_iommufd bind = {
>           .argsz = sizeof(bind),
> @@ -180,6 +181,15 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>   
>       /* Bind device to iommufd */
>       bind.iommufd = iommufd->fd;
> +
> +    /*
> +     * Pass the VF token when binding a PCI device.
> +     */
> +    if (vdev && !qemu_uuid_is_null(&vdev->vf_token)) {
> +        bind.flags |= VFIO_DEVICE_BIND_FLAG_TOKEN;
> +        bind.token_uuid_ptr = (uintptr_t)&vdev->vf_token;
> +    }
> +
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
>           error_setg_errno(errp, errno, "error bind device fd=%d to iommufd=%d",
>                            vbasedev->fd, bind.iommufd);

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


