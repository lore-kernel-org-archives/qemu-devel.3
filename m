Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38243C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 16:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhWBB-0002RN-Gv; Thu, 31 Jul 2025 12:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhUqX-0001th-9w
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 11:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhUqV-0007A9-8i
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 11:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753974324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XCVknrCzZ/8CPTuz3OsFRtCrgYRo5fUS4nf+SODsFG0=;
 b=aFMipgZcF3uC9rOUXTHn2EIWRANHekE/hEZ701haCyUcQzqCod/IGINyWaOv5VaRW/LzCr
 mMjnVsBG5MTTeEIs6lFFnmhFkyC3ISvjJ26qeDPwKhnoAivMKs9XfvvSkHWpjtUAaNBpFa
 Teg0+K1imaRhH/QHFIQ4s1F0vi5zohY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-F5CchtidMvmbpnPQVs0qgQ-1; Thu, 31 Jul 2025 11:05:23 -0400
X-MC-Unique: F5CchtidMvmbpnPQVs0qgQ-1
X-Mimecast-MFC-AGG-ID: F5CchtidMvmbpnPQVs0qgQ_1753974322
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4561611dc2aso10054975e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 08:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753974322; x=1754579122;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCVknrCzZ/8CPTuz3OsFRtCrgYRo5fUS4nf+SODsFG0=;
 b=ONjii4pTTEya0g2sLx7N94h/R9u2aae/lK0A03hgMguzQYI3uU7wT5pndRCC5o+zY5
 /JpHDeZFMV57Mgf40g3DLiFclTqeRfQt32Yg7s7/+ER7tNNqDBgDED/fRNb2nPn4MCF1
 Saxm6BiTmbkITmBrdUxT+jo9sBf/WuMZBpbxGG1wbI/zQKK0x+KIDmYmaCMOUXUXmtTP
 3gCxXQTjYxEIRv7kmpcqrNqu8AU+3AlbUNEdylYxTa5cjYXmVAKiNgdxgUUT9RGwT77F
 d4V6AwAyFUdqXTr8EhBl5clcB3ZOEHM7Hs/AwiZ3DRMduyA6KZI1ADQHTy5YK1FmMqKk
 aH+g==
X-Gm-Message-State: AOJu0YwNxzE1HQPtMazR2sn5TbMNSo0oHzacfU3lDIK+/nEmOpvKXp5M
 7uNkHRr/gU/JbN5eZ5HDO4IbQ/KScwDYPhTR5oOw71T471C+lWVeiO1fATqAIsBKF2h3rX0SAkQ
 dKTQvcjHu7NHjxoMJiYlG//SQRKgDVSMO5bWgGRd422prNRv/B75Zy4P0
X-Gm-Gg: ASbGnctAj5mD3BtCmUSPONqNFi3y7iG3IYczRoOVY1SkRA7kX7i2dJ0HchTkUdASAeh
 JZ4+carF4/EdfvmTo30F4ZUXFFDzbVCy7EKshtLsadAiw55N7d1B6tNCbo7Il4nArjA1RCiMlpq
 uBsoD8j88k78cI/eAXPiXi1ZdiWbK3oipNhuUwZy0Mg/uzIFzauPz0aSCy9/uwRqSoLhz7Zo6cb
 DQfKxtez1D3E5SSzzMFAHbsEnIMNpxIG0DheqRmuSasbaEfBe8j6wv3oYueIc3pC0yKCFlSD4Ze
 dpTOujWeIF0OaVdpHfu5YAVcH3Khs3yhdZwTB31s56CJCbrfQwheVB4A5vs1wxABGvFuK5nm3qH
 K0UqjcbA=
X-Received: by 2002:a05:600c:1e01:b0:456:1efa:8fe9 with SMTP id
 5b1f17b1804b1-45892ce4323mr76956185e9.2.1753974321518; 
 Thu, 31 Jul 2025 08:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4zrBs2jY/6msgfaoN8eIuByhuMTiUkd23Ta+NhDWz++h6AlvhftIKBxkqVb24taklDYuGbA==
X-Received: by 2002:a05:600c:1e01:b0:456:1efa:8fe9 with SMTP id
 5b1f17b1804b1-45892ce4323mr76955795e9.2.1753974321018; 
 Thu, 31 Jul 2025 08:05:21 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm2683605f8f.15.2025.07.31.08.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 08:05:20 -0700 (PDT)
Message-ID: <cbca91b4-691b-4e2c-9588-99509a4278ae@redhat.com>
Date: Thu, 31 Jul 2025 17:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2] hw/arm/virt: Include 'system/system.h'
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250731144019.1403591-1-clg@redhat.com>
 <CAFEAcA-FZq4RJrDfDiSqC5-L3720cYALamJGU5fQXQnV9J_-Rw@mail.gmail.com>
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
In-Reply-To: <CAFEAcA-FZq4RJrDfDiSqC5-L3720cYALamJGU5fQXQnV9J_-Rw@mail.gmail.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/31/25 16:55, Peter Maydell wrote:
> On Thu, 31 Jul 2025 at 15:40, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> hw/arm/virt.c should include 'system/system.h' for :
>>
>>    serial_hd()
>>    qemu_add_machine_init_done_notifier()
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/arm/virt.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index ef6be3660f5fb38da84235c32dc2d13a5c61889c..e1b6241f7bee4c2fddde31c512561e87229cebc2 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -50,6 +50,7 @@
>>   #include "system/kvm.h"
>>   #include "system/hvf.h"
>>   #include "system/qtest.h"
>> +#include "system/system.h"
>>   #include "hw/loader.h"
>>   #include "qapi/error.h"
>>   #include "qemu/bitops.h"
> 
> Presumably we're currently pulling in this header
> indirectly via some other header (the vfio ones)?

yes.

> Might be helpful to say which.
> 
> If this is a dependency for your vfio-platform removal
> patches, feel free to include it in there.

I will do that and improve the commit log.

> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> -- PMM
> 



Thanks,

C.




