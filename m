Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107E1C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYXk-0002GM-H5; Tue, 15 Jul 2025 01:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYXb-0002Dl-Ut
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYXY-0003y6-6y
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752558558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fo46b5+UjCMfv2rA1zAYNoTilvuWbqd/pMx37ppzMOI=;
 b=EzIW5HJxzz225zwTu70QnDd8un/Lt0yTuH0vKwhMYydV5O/+DV3OsVO9s+XfZgMJXzkC+d
 ymOoSbRxJE2lY4JZNbHsusAhMahBLnpBGT9FCV4MRtc3tW6HeH91QJGorSAYZQyyYfCZzq
 zz6Zeee5a4+SuXSZHLNR2mACxdYXJ5M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-LOW_z48bPESE7TisPuAwwQ-1; Tue, 15 Jul 2025 01:49:17 -0400
X-MC-Unique: LOW_z48bPESE7TisPuAwwQ-1
X-Mimecast-MFC-AGG-ID: LOW_z48bPESE7TisPuAwwQ_1752558556
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso2635728f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 22:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752558556; x=1753163356;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fo46b5+UjCMfv2rA1zAYNoTilvuWbqd/pMx37ppzMOI=;
 b=mtwNlyV+CAaABONMepEUWqA7wqM7lESUK9JosThcAjMBOTmyb93MzxplDUmpn7+SI6
 JwLiCfoW06a612gQ2u9EP8YRL4IjtKLOH64oZqSTtSfN54r9DK5BBk5uuY+aJZG6lrsN
 xzv9Ym4ROV2t3WlED6CgzxbuEe0ixALJzxVjZw28ngZR0sFFi4RTec5ea801v2AihEba
 Au5uNWZBjT+TP9qpK+4fa3LfRbkBcQqJeY1vowuj3SV3Vzm0mVUu2gkCilOI5hELelc7
 R2pTt8bkTTM0c9qF2nUGP0b0/dUwILvMyYWcP/H8Zf/seWG5PjbhR8rGeZiAnNOM308R
 qVSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiH9ClvlhjSCDtBRI3eGwvW8aIJ9LnekiBTcDEBOnwscCs2DL4q+xUtCADmOFXXReWMGDBjbC4o7cS@nongnu.org
X-Gm-Message-State: AOJu0YzYZwLk7dZCU+tTDdiV7nPVSCXeEybdbobwzuDIJhk3kMTTEr8m
 t6s8BqLVW/fBxwnaXeYPkhzHDJT8m9Znj+QkXmmEfj3ytbREQWZh+RHAgH1psicxy2urjNhSe8/
 J3JU2wZD0RMApoFjQ2w2oIbuab1CnpJWfgZxLmmJBKFoXUT6hYFZeuPl1
X-Gm-Gg: ASbGncsieGqSsfJIJ4/HuCRCJG9sGs6ocVLDvCj+DIKpaQxIuDE5iRtMmvIwqDdv5Zq
 zKwCnl+2FLf9Br4aDW8MeKo0I6O6J/904fm3WEerJbp5IyhCL9aBbGJJHGAyOFgLjYozTCm0+6j
 4/1u34+os1jYr1qnfjr+H0qfL1bcAu5I9MsPKa0XFht8AQuKotWZJRMXBsrozM6v964MV4cqGDF
 7EnP69e/D4PK+F5Oe3y7Qjmo0LU7z9vCjh0eD8d1xzEUAdEU3eFHd7c6zhHMx/dgJ/w7Eqt6bIP
 BloKVBIyavL2n7/Q5YvVQCuky23+YMkO0NoPPXi79mdojw0Ziy0b6hT91eC8+4Js02VFzaT76yE
 =
X-Received: by 2002:a05:6000:2c10:b0:3b3:a0f6:e8d0 with SMTP id
 ffacd0b85a97d-3b60a1bae46mr846956f8f.54.1752558555979; 
 Mon, 14 Jul 2025 22:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Phaah38sGvYPhpo/I/bzS68w5QjFtL1N08o3Ol1serUoDsDQULEv6Yd8koOXqcFlzKjUGA==
X-Received: by 2002:a05:6000:2c10:b0:3b3:a0f6:e8d0 with SMTP id
 ffacd0b85a97d-3b60a1bae46mr846942f8f.54.1752558555501; 
 Mon, 14 Jul 2025 22:49:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm13941149f8f.46.2025.07.14.22.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 22:49:14 -0700 (PDT)
Message-ID: <cc3be6c4-82c5-4152-8206-f475e8762616@redhat.com>
Date: Tue, 15 Jul 2025 07:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: wait for proxy close correctly
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250710154731.1266732-1-john.levon@nutanix.com>
 <cdf4931c-cf7b-4849-8aff-0f73fc3d1189@nutanix.com>
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
In-Reply-To: <cdf4931c-cf7b-4849-8aff-0f73fc3d1189@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/11/25 13:38, Mark Cave-Ayland wrote:
> On 10/07/2025 16:47, John Levon wrote:
> 
> (added Cedric)

ah. Thanks Mark.

This reminds me that we should have maintainers/reviewers
that can send PRs for the vfio-user component.

John,

Could you please send a patch adding me and Mark may be ?

> 
>> Coverity reported:
>>
>> CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)

Please prefer :

   Resolves: Coverity CID 1611805

>>
>> A wait is performed without a loop. If there is a spurious wakeup, the
>> condition may not be satisfied.
>>
>> Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.
>>
>> Signed-off-by: John Levon <john.levon@nutanix.com>
>> ---
>>   hw/vfio-user/proxy.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
>> index c418954440..2275d3fe39 100644
>> --- a/hw/vfio-user/proxy.c
>> +++ b/hw/vfio-user/proxy.c
>> @@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
>>   static void vfio_user_recv(void *opaque);
>>   static void vfio_user_send(void *opaque);
>> -static void vfio_user_cb(void *opaque);
>>   static void vfio_user_request(void *opaque);
>> @@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
>>       }
>>   }
>> -static void vfio_user_cb(void *opaque)
>> +static void vfio_user_close_cb(void *opaque)
>>   {
>>       VFIOUserProxy *proxy = opaque;
>> @@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
>>        * handler to run after the proxy fd handlers were
>>        * deleted above.
>>        */
>> -    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
>> -    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
>> +    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
>> +
>> +    while (proxy->state != VFIO_PROXY_CLOSED) {
>> +        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
>> +    }
>>       /* we now hold the only ref to proxy */
>>       qemu_mutex_unlock(&proxy->lock);
> 
> It think it is worth mentioning the function rename in the commit message, otherwise looks good to me:
> 
> Reviewed-by: Mark Cave-Ayland <markcaveayland@nutanix.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



