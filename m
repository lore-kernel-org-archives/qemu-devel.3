Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F4EC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0jCd-0004MT-MR; Fri, 04 Apr 2025 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0jCc-0004MB-9s
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0jCW-0000I9-7d
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743781402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x60PhJeVB8ZRgaD/4LcS0cwBT57GlAHhGqnfhqWHyO8=;
 b=C0lSDs4O2gQwoKWJ/sR2pLQvx9Siq5EtRnJ3Hmvj36aOpjAtXKF9CZWR8rHDOx7wod3hDj
 cmoEoz26Shc3+e9fwzDcJHA1Z8X8tui/jwwhchQg0exsSXUDr/jkzNS3J8XRsznQooYSZK
 fBXILOjMpMX3yzVczcgRH1yMQcwygIU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Bwy3FyvvPEubx0g4Gbud3g-1; Fri, 04 Apr 2025 11:43:19 -0400
X-MC-Unique: Bwy3FyvvPEubx0g4Gbud3g-1
X-Mimecast-MFC-AGG-ID: Bwy3FyvvPEubx0g4Gbud3g_1743781398
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d3b211d0eso17259275e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743781398; x=1744386198;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x60PhJeVB8ZRgaD/4LcS0cwBT57GlAHhGqnfhqWHyO8=;
 b=g8xfBJsgVqaD8NQ2BN9uvko1Yr8wG6w9xFlnpNh31/UAuejJ6T4r9jBbimV2p7uWnK
 EhVVZiWTyHM40fJC04yu2crArUDW9ARQYnb9jLLQq23a33XSiLCrrjudWb9wI5a4uM5r
 LSlrWv3JVpE+uigVCmK+1405bQIMz2TaDcTV2WE8ScJ1K1FMp7H6U+xUGh7/eP3de48b
 F+LCaMqOhcR/8x8djInTf+ENrvJyUYsnAB35EpFOwefJDfjcJKmFCytRL9j0zIv0Zw2w
 rgBJXBhSa0poIOWQl0iM9rPpLkX1DKqTC8VbCvWqRkqfiDdEcNS/ZX1C9rKc8kNzf/bR
 RI5g==
X-Gm-Message-State: AOJu0YwkiGU7UbbTsWs/O0vCe4qiSOaVQda6ooQdeY5a4AXp9s0jxMua
 Mttbnr6bO1gsD0AYg4/9CFJsz/dl/988mRyPMK7gOl0SBbNzLaS0O8ny+eu+peM0U3ZW+jGBbS0
 0mE8ewaTxmCQqAC1R4+jrogOwLW0UGJlf7xuVhjOL2DxZD6R6yCAD
X-Gm-Gg: ASbGncuoao7wkmhVWy4n86Fr1aqcXIKQ+XZjQmkJcuidN+GTtW50AvEJTQNHNkZd976
 C8QvvY+p4UAGZHOVqefNjpQfv10cXhNqAWujGLdexV9plqpIojV6PB7SyPR8KxNqTEqqGbO00zq
 ulI4jib/pOL3KmdRY0SqpeOHVXtDnREPvzI29t48lTR30vjuhYWz5j0AVMOMYMPR53T5uxgzLLa
 tzahW++mhFMPEspHD7rud2hHEsA1o9/oE1k3py8AiNleFrneDFglq1F4yz+VgOa0fmQIPmK4Q3H
 CDyxwmn3IAV/qFCt0NCXGVt9b30r2Dnpt3RiQox4cXyjrYDSU81FRg==
X-Received: by 2002:a05:6000:1aca:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-39cba942a77mr2891054f8f.18.1743781398428; 
 Fri, 04 Apr 2025 08:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyzzOiLkmHukLdsN2aKedhEBtiIdFaY1SdNHtoJ1HcZcJDtlpXch1i0qSvry145pfrQS96gg==
X-Received: by 2002:a05:6000:1aca:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-39cba942a77mr2891034f8f.18.1743781398080; 
 Fri, 04 Apr 2025 08:43:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c300968cfsm4721145f8f.16.2025.04.04.08.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 08:43:17 -0700 (PDT)
Message-ID: <e1655b70-64d7-4757-9106-f23dd2391633@redhat.com>
Date: Fri, 4 Apr 2025 17:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/28] vfio/container: support VFIO_DMA_UNMAP_FLAG_ALL
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-4-john.levon@nutanix.com>
 <7aee0391-256c-40dc-a2a1-328065d6dd08@redhat.com>
 <Z+5YsQ0kWIuMpMic@movementarian.org>
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
In-Reply-To: <Z+5YsQ0kWIuMpMic@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/3/25 11:45, John Levon wrote:
> On Wed, Apr 02, 2025 at 06:49:50PM +0200, Cédric Le Goater wrote:
> 
>> On 2/19/25 15:48, John Levon wrote:
>>> Some containers can directly implement unmapping all regions;
>>> add a new flag to support this.
>>>
>>> Originally-by: John Johnson <john.g.johnson@oracle.com>
>>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>> ---
>>>    hw/vfio/common.c                      | 24 +++++++----------
>>>    hw/vfio/container-base.c              |  4 +--
>>>    hw/vfio/container.c                   | 38 +++++++++++++++++++++++++--
>>>    hw/vfio/iommufd.c                     | 19 +++++++++++++-
>>>    include/hw/vfio/vfio-common.h         |  1 +
>>>    include/hw/vfio/vfio-container-base.h |  4 +--
>>>    6 files changed, 68 insertions(+), 22 deletions(-)
>>
>> This is difficult to understand. There are no functional changes right ?
> 
> +    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
> 
> This is new, we previously never even tried to use this.
> 
>> I think it should be broken down further to clarify the changes.
> 
> patch 1: add a flags param to the callbacks, always zero
> patch 2: pass through unmap all flag to callbacks
> patch 3: check for unmap_all extension and use it
> 
> That sound better?

yes. Let's see at next respin.

Thanks,

C.


