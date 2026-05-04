Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4990BCD343A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJv4Z-0003ip-1j; Mon, 04 May 2026 11:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJv4X-0003iS-J2
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJv4V-0000IX-Ui
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777907938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+YyeOQQ4fHcj9FzNGU3ALAYKB5kBjjZIt5m4YV9btuI=;
 b=YZ7q79TdrxGEhNhrGopTKRu7+Uz+OLuPiNtaX5J2MxRhmN1PcMPSVLnE4xF8MvARjwhDv8
 1bXfpcboRdRr7PzVL/y59twYoL5i7uVr6Q2GxV1xBmfB4aEWrUMEz2l0bCpTbGcIOyp5MQ
 mOoTFMicbk2Q7AJGEC35TKzRJxqxdm4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-OjriymRjOrqFFZCe4Bthlw-1; Mon, 04 May 2026 11:18:56 -0400
X-MC-Unique: OjriymRjOrqFFZCe4Bthlw-1
X-Mimecast-MFC-AGG-ID: OjriymRjOrqFFZCe4Bthlw_1777907936
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48d046fac74so8149085e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777907935; x=1778512735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+YyeOQQ4fHcj9FzNGU3ALAYKB5kBjjZIt5m4YV9btuI=;
 b=WZL8MU5/+x0i9AnppQeC0NtgXZ9xSdpx1YHHmCucyjCUKZ4b2fg+uNLz6ugwobRsdK
 7OtssuKrWxXMRr59SCB0O9WABS7c2kpiKivC7HrTyNQsbQnhkugGd5SRt/ok3OccDBtC
 m57OktDN6AUabdGyd3CySeQ48//NGAYSv1qHyhEP4/LymiIB9gN7Ulfo97mJ0ksqiCeX
 +w7nR+TeTYDtXmFevOYiGankywQv/dagkUQ7nOiWOVadaxfI6kOKipd/YTuxMZBRSfn+
 Plwwv2wlHsb6qSiMGgwQkjKl5P0nhLzgoH5f5Z/vP/IeAr/H5Sl21fG2hbO/1fJsVIjI
 X9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907935; x=1778512735;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+YyeOQQ4fHcj9FzNGU3ALAYKB5kBjjZIt5m4YV9btuI=;
 b=YYrFszSBUxZ5ts4hy3nFMo5E3ebXt4HmT8SNNTYYulhDLh/sSVWrgKqremmfWgHdJK
 55HrMrNlvCuaJQM8AXepCjktAg+JdeOgU5qniqiq8aUxyc6R07TIGjgFa1WtKIhXXpsv
 c6RAZMRIfFmUMBMOHsqTGJHexriCHAplILBkVRHPXdLGhxc46ANweMa7+/rsBne0wmwa
 zDl+MyjjB2x5WWl8byucAqVj1wDBeEFD6/wPMSfmir+hZhNnPn8rAm1d2qoxXJhPVx4x
 MF+wWiNatL47L7aJ5WsPhSiXqYgggsCEKdiqV+hD3inRXcaoQBJJBMrFz5HoF/MK/5Uy
 oKKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6wiXrW0cfkyyzoLSovN0lGiGj92wVEKu7rKwp1ztZWGoCv018GAfMYv3e2gn4oN49bLcIBftRchTd@nongnu.org
X-Gm-Message-State: AOJu0Yw46Bh9403V6eDnNuUhoxEffcaox37LGyPIzK2b9UDqEVW/HXyD
 R/Lcj9ZMjTD167f7M+izY5OcVeE0KhkR0y4rYIl/I913aUsJvYC5gltjB584yaWm6yXRKhU0Is6
 lAFYOzidps8SsYEQqY706SjjezEVC/q+HjFL1t4qqXzdTWF3fviBxucKQ
X-Gm-Gg: AeBDiev8M4h2/pryHOgUt5vlNTkqRYvTl70NQULYDPaJyK1XZbyuKQBklJTa6Q3XGA2
 yKxwrpuVCfxBEyVCHzW7/hBpCrodhmv+uXgA5JvQo1Yw962V/qaDuWWipxFaZ239qrSO0bXMBeB
 kI3QzzlICiVw6Kr3OpuKs5xZ/FBTTm+GLB7Ok1ox0qx2TKL7LxGpnJDOb2C1L+zz5U4VvzkVbaJ
 LyCoDwDvyJOkmTNtIDNp9N+8mwlD9thklr5IAvn/L+tDK98Pn6m/UNWgrV+pAj1abljg/dVa+iu
 81LCrmL5G8CFNN8NRhpU0gVAFNFBX089MZYLjAynL24m5F6ohrjN3k5DaIFdkiF+5BAixYTvr9s
 P3MwyB3b1nq0T7Q5A7b7YJww1InsjWCKcN5Ivd7stO8PYHm55fVssmzpHXP2se1uV7v0igGE=
X-Received: by 2002:a05:600c:3e07:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a98640536mr163231665e9.12.1777907935657; 
 Mon, 04 May 2026 08:18:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3e07:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a98640536mr163230945e9.12.1777907935198; 
 Mon, 04 May 2026 08:18:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm362379235e9.7.2026.05.04.08.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:18:54 -0700 (PDT)
Message-ID: <7f97dba6-ac40-493d-9715-e3a9b4a80e9c@redhat.com>
Date: Mon, 4 May 2026 17:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: propagate IRQ notifier registration failure
To: zhaoguohan@kylinos.cn, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Alex Williamson <alex@shazbot.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260424023904.261258-1-zhaoguohan@kylinos.cn>
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
In-Reply-To: <20260424023904.261258-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On 4/24/26 04:39, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> vfio_ap_register_irq_notifier() and vfio_ccw_register_irq_notifier() clean
> up the fd handler and EventNotifier when vfio_device_irq_set_signaling()
> fails, but still return true to their callers.
> 
> Return false after cleanup so callers can handle the failed registration
> path instead of treating it as a successful notifier setup.
> 
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/vfio/ap.c  | 1 +
>   hw/vfio/ccw.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 276ae8c207bf..6e2a1223ea8d 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -193,6 +193,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                          errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>           event_notifier_cleanup(notifier);
> +        return false;
>       }
>   
>       return true;
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index ff6ab9a7408f..c3dc7c196235 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -431,6 +431,7 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>           event_notifier_cleanup(notifier);
> +        return false;
>       }
>   
>       return true;


The issue was introduced by :

   Fixes: cbd470f0aac5 ("vfio/ap: Make vfio_ap_register_irq_notifier() return a bool")
   Fixes: 8aaeff97acee ("vfio/ccw: Make vfio_ccw_register_irq_notifier() return a bool")

Could you please resend two patches ?

thanks,

C.


