Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDBFCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 20:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5Oi-0004wW-KJ; Tue, 09 Sep 2025 16:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uw5Of-0004vc-Ck
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 16:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uw5OZ-0001qg-G0
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 16:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757451403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d+9alRluVSppxGrcPFsqGD2ORqu4IPOenfkl6vfKMqs=;
 b=Uo5uFJn6s8/n77fQkwI0eQheHZ58TFrPDosAdgjbxozJRD8C24gukFIRx1Z1A0MLhH86Tv
 hhLFJyXg8hoE+w1zxybvp4uHyVijsBodofEOYCAEABA3CMhnEm0ZZk9Kn6pBqFT7NWxZLj
 /pv3AvwBxipS69CQzepjVkbxyCamOig=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-rKfl_z_1PdK_BaaFDV_S9A-1; Tue, 09 Sep 2025 16:56:42 -0400
X-MC-Unique: rKfl_z_1PdK_BaaFDV_S9A-1
X-Mimecast-MFC-AGG-ID: rKfl_z_1PdK_BaaFDV_S9A_1757451401
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e1e7752208so2937159f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 13:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757451401; x=1758056201;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+9alRluVSppxGrcPFsqGD2ORqu4IPOenfkl6vfKMqs=;
 b=myoS1qt6j/VBB1e4aLnGJE58e3opHerqsjDjGlpHdXcgLc2ntYmVqGPPPjZpaXvduP
 Gh+TXTAoYTtgLaWQMXapQvp4eyv3ShQDSbmv+DvgffY76qhFFVtY9U7iKJ/kZSoDFVOE
 G2VSQAZg0DnCw170UihHrjukF87IsA448vCuE5XFBsO6OxhC5YgC/Q5Q/18r+pL3NSzv
 tLzhRyi085T5A5QN4sVeIWGPfwaAS6JJNJwMwIloIS82gGlt8rELirYIzZbyPOiQLzJA
 FNGTHU7Qfmr+6SPYxasKd894T8U4R6xeXnoWFO7DITnCf1A0C7Xc2htUTUA8uOgCrByD
 +P/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv9UBkCl0VrzltPy0cLfEu3yKEBiks1+dbZGmudll15Ypfe0zwJIwC4bTNT5ZG1j189QL+p7ZOt3GJ@nongnu.org
X-Gm-Message-State: AOJu0YwjQVMS8qz9t+N/5SoNRbormcCtqeMW1PfGfbENV9EALAHbXaCn
 7z3APvKe4iIMS8JzVJNkaSsFQnB7sxgoAv5o+jwe0VkDk2eSz0GSQM57JQj2bvPicnkGFn2Yk6l
 SMbt9XEybTS85QAcnDVpsGwiXRzuESDpiTkxrabN8T5jyuRNI+g5X+vkM
X-Gm-Gg: ASbGncsZIy8tFMcamd6lWFwuxYiKSrzlLISy3ulYzQDdy7n14sAUFrlZ6UdLJIqnqPX
 hdBbb922IKA/bdKoqFD/rs1/OC9dRUmD+BVwzsSyZxNS+VBQAQYDUvvVLAEqch4Xiatm5Cn7R0k
 UP+iLwNDP6Wqaz9PWWYKnZ9WepcQ0/WEZDOZcQS+tN91HLuZsVio8X++5egm9w7SKIoG2ASBjVs
 i+r8Y0GKxYHO/gonkDV/TPfPNeHVaHJPHwm5kdJKxNJY44VSECcYhBmM/qOTqksMS1J9EitdDyq
 e0Wxd28SOyyoXMtg/52hqWW594yjhtf1iO5pB/Xb5mC1YORQqtf4KZ15J2GGW7yBwWpgPMOjjCx
 XRW4=
X-Received: by 2002:a05:6000:1786:b0:3cd:5815:68d4 with SMTP id
 ffacd0b85a97d-3e64c789447mr8935702f8f.57.1757451400996; 
 Tue, 09 Sep 2025 13:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJmSCmf4HVA/Tg8Th/M2yhqBSOc7EoVCF9Kx0SJ4l+U4l78xaxV7d9rZwHh7WbTqCX6UPCzA==
X-Received: by 2002:a05:6000:1786:b0:3cd:5815:68d4 with SMTP id
 ffacd0b85a97d-3e64c789447mr8935689f8f.57.1757451400630; 
 Tue, 09 Sep 2025 13:56:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7522562d1sm3842356f8f.63.2025.09.09.13.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 13:56:40 -0700 (PDT)
Message-ID: <01ec0eb8-62ae-495f-abe6-cb64f493a2df@redhat.com>
Date: Tue, 9 Sep 2025 22:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] vfio/pci: Add an architecture specific error
 handler
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-3-alifm@linux.ibm.com>
 <0699f897-3aeb-4104-919b-c96cdab4d4e7@redhat.com>
 <17b1213d-d076-4e0f-b43e-657abc002e9c@linux.ibm.com>
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
In-Reply-To: <17b1213d-d076-4e0f-b43e-657abc002e9c@linux.ibm.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/3/25 18:49, Farhan Ali wrote:
> 
> On 9/1/2025 4:28 AM, Cédric Le Goater wrote:
>> On 8/25/25 23:24, Farhan Ali wrote:
>>> Provide a architecture specific error handling callback, that can be used
>>> by platforms to handle PCI errors for passthrough devices.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   hw/vfio/pci.c | 5 +++++
>>>   hw/vfio/pci.h | 1 +
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 07257d0fa0..3c71d19306 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3026,6 +3026,11 @@ static void vfio_err_notifier_handler(void *opaque)
>>>           return;
>>>       }
>>>   +    if (vdev->arch_err_handler) {
>>> +        vdev->arch_err_handler(vdev);
>>
>>
>> I am not sure that the "architecture specific error handling"
>> will be implemented this way but we need to check for potential
>> errors.
> 
> Thanks for reviewing, do you have any suggestions on how to implement the architecture/device specific error handling?

The nature of VFIOPCIDevice is special, it's both a PCIDevice and
a VFIODevice and it's difficult to use QOM to customize some of
its behavior with device class handlers. I don't see a better
way for now.

I would drop the 'arch_' prefix from the name.


>> So, please make the handler return a bool and add an extra
>> 'Error **' parameter.
>>
>>
> Sure, I can change that. Are you suggesting the change to bool return for the handler to report any failures in the handler (through errp)?

yes. The error reported before the vm_stop() in vfio_err_notifier_handler()
should be updated too.

Thanks,

C.



