Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C4FCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBz5-0008Jl-SJ; Wed, 13 May 2026 11:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wNBz3-0008Im-Re
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wNBz2-000597-5B
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778687930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cZSz6iImT0bHujjHsShnMOR8QBb9wZmqKBRXt3CInbc=;
 b=S9PvTptqDM9PWyB7P9phoO4zI82Yhh7muxIWwTwdYXDPbeVHE7zeXo+TaDEHLhHnyah9TJ
 H4KNOTX168ZecC5Dh8DKoHk5Hmd8CAnTRmat5ZUnIoZ6oPgrENPpyytGqITumvLoVXhXaA
 uNAHCzYlMp2ktoZMgFRJ8gTOXSmHdt4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-0vmj_HlSNnWolck-2U9HKw-1; Wed, 13 May 2026 11:58:49 -0400
X-MC-Unique: 0vmj_HlSNnWolck-2U9HKw-1
X-Mimecast-MFC-AGG-ID: 0vmj_HlSNnWolck-2U9HKw_1778687928
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd233d1e2so5571385e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778687928; x=1779292728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cZSz6iImT0bHujjHsShnMOR8QBb9wZmqKBRXt3CInbc=;
 b=epWaLVmCcHgfuLgZ45TVWY/euQA7NiFpcq0nFYZvecfR19oXI0cUv5HH+UIfJrCJXd
 NXxRN1nobvTLO4BQ1ovjrDOO4Srin4exFhyLFJJFfROLqjZkMXg1BOhJ6fwy24xQQwpc
 hkB2vOUux2FjDlbNTL4LD0/9b/dYQiFKLYiwOAACGqDQeA1Zwo1OnN0ybF6NeoZa3iwn
 Zyiwlt8TtpGrAJLHHsYpPirDw/pXSWfMD0+3aLzQt8n/Vy+KxBIejGZLU6T3BZIIEGv/
 kYGW4kYj24dBbAshhVKmNa0rbi2v4vlH3ImFK3HoEATX5Nop+8ayOCCFGxixnNmqX9S+
 Rteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778687928; x=1779292728;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZSz6iImT0bHujjHsShnMOR8QBb9wZmqKBRXt3CInbc=;
 b=s+vg13/ueJXHXZbOsv8ZZtXXw/DC8tXXHA3lhMfLxLocJ3ED3bRS3lg6t5KiUanWwa
 yd8lLDw3qquAhEbslkm30pNQBb+WKNgjCpld0AACyzFgLMvEf3t4GcCgIMLELan59ghe
 yHXtksSIOgy8EsOmzkICZwQWI/PryaB3hHQK8LSK/fEd+tt7Hhtjx3MMhNWmGDQ8HXLo
 ZovmfAT3f8NWvYOxrr2YzQ54tLovhHm6ihOrnEU302NPtQ5ewtPSTV3bjf/nPHAXMSp3
 XyqMlnOXrQ0ZMj6bfuj/HUlKQcyy3bo7aOSGS3xYVZADMT30Z2GvEY5b6IijTvbafqsI
 yLTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xBF/HHwvJQ+grqmpU1Y16RS3bZGP9BzREBjRzTKLJBhQo8Sax3NR/Wfjv6OO5nZXnUyiRUvvZzsXN@nongnu.org
X-Gm-Message-State: AOJu0Yy177zl0J6FWPxtjAVgO7Ywn8WU0YG236UK+GZ/Wyb9lO/G6PJM
 oNrC2uMihYO79kDYCfpLXjkN4WXXz1RXfvQtzLGczSosb2Wki+1E/mce/rhNgwOc0en8vlYOKiI
 /vgKOuSTVvM+87ztYGtGReOLqodoUqsKPOtJ2rl/st8OD1QhMgN5Gqfft
X-Gm-Gg: Acq92OFCo33G6mkw790AERS6csP8M6w7JvuBVma1g+jKSj07fLVEAAaiTmeDYlQhZMj
 Xw1nr5z2FsKDcO1GM8vtmfb0zCFMvm/0PIb3Hmn0Duv3kcCfyFfo7BB3QNKSy+8yxYcYxmJuIvk
 1Com9rLT4YTzQbWFWZ8TKYlk3wTm5OPu568sWK4F0x+OSw7m++V7YqQQFzPBXwxA1p1AMrw7i7D
 19lTpeRw1weqUJnqMcyhenrysb7owFak+P/3EAiXtqNmR1SEZ+URrgkfmt0Ya101OhUejIWtL2o
 xdlop4qCnMTRAOIqB1CTNNbWgXIAIOrbIGUoR3+Qx7G2y+0AJEeYu6hOnqdV/MllaOb5sgFmkzi
 5bkkNFxnSIucmYUV8jjn+nDVQc0fesbOLw59ujr9HYqHDmo//tOVge5NyaxL0
X-Received: by 2002:a05:600c:821b:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-48fc9a030fbmr62080765e9.2.1778687928022; 
 Wed, 13 May 2026 08:58:48 -0700 (PDT)
X-Received: by 2002:a05:600c:821b:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-48fc9a030fbmr62080305e9.2.1778687927540; 
 Wed, 13 May 2026 08:58:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64abdb0sm234685e9.12.2026.05.13.08.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 08:58:47 -0700 (PDT)
Message-ID: <e6032725-f06d-4298-a1e6-e54ac3b92dae@redhat.com>
Date: Wed, 13 May 2026 17:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Make Maciej CPR maintainer
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 qemu-devel@nongnu.org
References: <ebe67053f4bdf92eedab1e5839603b7137e36970.1778687091.git.maciej.szmigiero@oracle.com>
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
In-Reply-To: <ebe67053f4bdf92eedab1e5839603b7137e36970.1778687091.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 5/13/26 17:46, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Since Steve has retired last year I will take the CPR maintainership - with
> kind help of Mark who remains a reviewer.
> 
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced84d..dacb332bb65d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3177,6 +3177,7 @@ T: git https://gitlab.com/jsnow/qemu.git jobs
>   T: git https://gitlab.com/vsementsov/qemu.git block
>   
>   CheckPoint and Restart (CPR)
> +M: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>   R: Peter Xu <peterx@redhat.com>
>   R: Fabiano Rosas <farosas@suse.de>
>   R: Mark Kanda <mark.kanda@oracle.com>
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks Maciej !


C.


