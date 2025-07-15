Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C26C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhGQ-0005Qb-QH; Tue, 15 Jul 2025 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubggn-0003ZB-3I
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubggh-0006W4-UW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752589878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=azCJHLe/JYXupwnnFEzuqsFjQpGpFs4MrVsK4SL0Dhw=;
 b=WGC1EflQGSkbDHGNVkA1Nkr6e2eOGShWwKGha/d94Jy6vIxuSEAxbZ6hmlm8tJMEvNkJgI
 vR0cXG230ZQ1fUtk4WjG31IMLyAN78uRlLGNkd9KwB4VZGnzf46yM+yXOBU1KkvyVFyzZl
 CCRuxkGm5XqOVmjlJ3N6D7GCjrvoZhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-goJp9vG-MWm8i4xmg-o8fQ-1; Tue, 15 Jul 2025 10:31:17 -0400
X-MC-Unique: goJp9vG-MWm8i4xmg-o8fQ-1
X-Mimecast-MFC-AGG-ID: goJp9vG-MWm8i4xmg-o8fQ_1752589875
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso2724099f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752589875; x=1753194675;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=azCJHLe/JYXupwnnFEzuqsFjQpGpFs4MrVsK4SL0Dhw=;
 b=sUV49JIkCQhOblpSqcf+0JzSWg1P4218rzLs0eQvZ2fapwhu0tPi7g1QDjOj7Csddx
 cUhNTTht81aU5mLcour517ZRGuqrEc7TmpsPJFPBsT9HZ/GyTeoIIqBc8f4D4rlOtlQa
 tYBRp4o4UXcjhHknMJiA/2CMR/pSML9Dy3EsfIv8eMjARlFJUu+Ohq9S2m+fpUjQX4Qj
 3FNXM+MlpPCaI/yKRwLOpgb2iKC18p1WWGc5VyHXV34hygTdOnhYfP3C6KUcKgU0O0E4
 4Ze2jcN7fLQI1vcqfVIdusCP29sI4wS0p+ubC93c7jQ09DKCvtRrisF3ZQI4A/AJIHMs
 yuMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU56YDFmLDf68gIccHpc8CR3rjGAdVC8SmEHEgLcTJoOs1nYRx7SFSMBilYh5y9MsnfxWInj/SNmpZS@nongnu.org
X-Gm-Message-State: AOJu0Ywi6BQ17oF1btxRMlpnOv84pLNm7ZoQJDXAtbouCRYpq+ibd1g3
 S4MtMXHHuQyIh4/J+2hBG4IRJTm8fExqe55q6USad1fOqaJ7AHawV26lLz5FvXmJYUOlhVfCgiy
 Vsr4HInpu/GoscYD0dxN87JwtB70jR/UJ+1iLJcEs0BIhGgElTXkFTftu
X-Gm-Gg: ASbGncuSxeAKrwVHw1e3dt4L/9twJJKDprthF4Up+nbRPuR9tZlvGl5kJF9KRBMJ6K8
 L7OoLX3Lenb0CfxypwkohhZjpDDzSxWq2jl226XsIUIElUNOOuAujNKsIJsQEQ4P4N5WxfVVTVC
 Mq/yUtq1mfN3tE3BbT71nGM6YHTSxYBsL+JBe1HDWcRDC9ObaA1VOA7R+RCK/grDZVce7XxGcMj
 jKYpguAzN5xQF5DmDryUzAFnQCILNQtUEPwzEHxztA9AoiYnoVrTydXtVgjrcpiIgbFuSAjiOQp
 xaFIj+KQ1OvCnu4OAfugTpTsukxGJ8rIWVSTQ9WpNASg+VpAJVH18OM0KiJFoAzKk4MR3imPuVM
 =
X-Received: by 2002:a05:6000:2502:b0:3b5:e6f2:ab4d with SMTP id
 ffacd0b85a97d-3b5f35856e6mr11835778f8f.42.1752589874961; 
 Tue, 15 Jul 2025 07:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxS7ncj/g44NyVVhmA8u9Kh4T9lsAUx8bVM1nwijBgIutYGz8WFoAXZmZLPB2hM7FLfqNmbA==
X-Received: by 2002:a05:6000:2502:b0:3b5:e6f2:ab4d with SMTP id
 ffacd0b85a97d-3b5f35856e6mr11835726f8f.42.1752589874268; 
 Tue, 15 Jul 2025 07:31:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d571sm15551026f8f.57.2025.07.15.07.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 07:31:13 -0700 (PDT)
Message-ID: <4f23d947-e0ae-4eca-95eb-6090ace150db@redhat.com>
Date: Tue, 15 Jul 2025 16:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] vfio: improve use of QOM and coding guidelines
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
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
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> This series attempts to improve use of QOM within the vfio subsystem which
> appears to have been added at a later date. It's mostly mechanical changes
> that do the following:
> 
>    1) Format the QOM structs per our coding guidelines
> 
>    2) Ensure the parent object is called parent_obj
> 
>    3) Use QOM casts to access the parent object, instead of accessing
>       the parent struct member directly
> 
> The benefits of this are that the QOM casts included type checking to help
> ensure the right object is being passed into the cast, and it also becomes
> much easier to infer the class hierarchy from reading the code.
> 
> Having produced this series, it feels to me that the readability could be
> further improved by renaming the structs as follows:
> 
>     VFIOContainer     -> VFIOLegacyContainer
>     VFIOContainerBase -> VFIOContainer

Yes.

> However I have left this for now given how close that we are to freeze.

I think this is too much of a change to QEMU 10.1 too. Let's keep it
as the first QEMU 10.2 series. Feel free to extend it.

Thanks,

C.


> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> 
> Mark Cave-Ayland (22):
>    vfio/vfio-container-base.h: update VFIOContainerBase declaration
>    vfio/vfio-container.h: update VFIOContainer declaration
>    hw/vfio/cpr-legacy.c: use QOM casts where appropriate
>    hw/vfio/container.c: use QOM casts where appropriate
>    ppc/spapr_pci_vfio.c: use QOM casts where appropriate
>    vfio/spapr.c: use QOM casts where appropriate
>    vfio/vfio-container.h: rename VFIOContainer bcontainer field to
>      parent_obj
>    vfio-user/container.h: update VFIOUserContainer declaration
>    vfio/container.c: use QOM casts where appropriate
>    vfio-user/container.h: rename VFIOUserContainer bcontainer field to
>      parent_obj
>    vfio-user/pci.c: update VFIOUserPCIDevice declaration
>    vfio-user/pci.c: use QOM casts where appropriate
>    vfio-user/pci.c: rename VFIOUserPCIDevice device field to parent_obj
>    vfio/pci.h: update VFIOPCIDevice declaration
>    vfio/pci.h: use QOM casts where appropriate
>    vfio/pci.c: use QOM casts where appropriate
>    vfio/pci-quirks.c: use QOM casts where appropriate
>    vfio/cpr.c: use QOM casts where appropriate
>    vfio/igd.c: use QOM casts where appropriate
>    vfio-user/pci.c: use QOM casts where appropriate
>    s390x/s390-pci-vfio.c: use QOM casts where appropriate
>    vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj
> 
>   hw/ppc/spapr_pci_vfio.c               |   2 +-
>   hw/s390x/s390-pci-vfio.c              |  14 +-
>   hw/vfio-user/container.c              |  26 ++--
>   hw/vfio-user/container.h              |   7 +-
>   hw/vfio-user/pci.c                    |  16 +-
>   hw/vfio/container.c                   |  31 ++--
>   hw/vfio/cpr-legacy.c                  |  14 +-
>   hw/vfio/cpr.c                         |  10 +-
>   hw/vfio/igd.c                         |  38 ++---
>   hw/vfio/pci-quirks.c                  |  48 +++---
>   hw/vfio/pci.c                         | 206 +++++++++++++++-----------
>   hw/vfio/pci.h                         |   5 +-
>   hw/vfio/spapr.c                       |  16 +-
>   include/hw/vfio/vfio-container-base.h |  13 +-
>   include/hw/vfio/vfio-container.h      |   7 +-
>   15 files changed, 249 insertions(+), 204 deletions(-)
> 


