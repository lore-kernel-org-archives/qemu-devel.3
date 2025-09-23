Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D815CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13ad-0003Uz-D5; Tue, 23 Sep 2025 10:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v13Zc-0002wW-23
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v13ZZ-0005PL-SS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758636048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AxPOvCe3JzXAmTLeoQfDt3vDwcdgYKfpGI2jOpstdOM=;
 b=KEqfY+0RGMMnalsp+HnekCU1EBVcclU/H22lrQJXiHbuH2Cjas/aKBDtfZfeWYv1bBoLdW
 OIRqJGS19HDSd7gO0aNxOSPwzb6LesF0oUpxG3fQT6wTLmwUNdGitNfleo63dkxgyE2V4N
 zZ66O/kLbpRGJn4mmtlPWu3T8R8b54E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-V1UeV5hIOHGl0jQo8XvEmw-1; Tue, 23 Sep 2025 10:00:47 -0400
X-MC-Unique: V1UeV5hIOHGl0jQo8XvEmw-1
X-Mimecast-MFC-AGG-ID: V1UeV5hIOHGl0jQo8XvEmw_1758636043
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2b9b99f0so17819035e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 07:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758636043; x=1759240843;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AxPOvCe3JzXAmTLeoQfDt3vDwcdgYKfpGI2jOpstdOM=;
 b=fJ6PublA3sYxtC/Im3bkYjj5cEm94ncetwsHpE05sSHyILTbVAk+DueuSAI7PnsEJp
 BQSqx8cldtTU/BiS971xNsaaA7p0+YwrhnRDNxmiinlFGl61UIsFIfnm3f++S2qy0gKJ
 +zqnOWCN193l8aqJdGyjGrTuOkSLk73hUnn9k6YGHA6utsmR5t/vqaZEZxcF647pOAUz
 k1aqlOw/4gtcp8d/DyKpFmfdAvVZTw6uuiYbdTXSWdJrXVJ7JLUozOB/qGx9fCKeRjBi
 KF4ftQgxAbs38rNI97rJSZxRTeQxHd+6eVvZBG+P6Fedo667C/O7IBvtAXqCcXPfC9Hw
 CB2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfmnd4P9chJg7q1HJ3a7fSoA8pBket91NZVEaLJGauFcJddBcc/6ghHfnv5aMhW1e2acSPEy+rzmp3@nongnu.org
X-Gm-Message-State: AOJu0YzJTKJ5FZGXqPRQSFl9ZEnmdodKbvSntfUrpzklqJy0VDtXPfXG
 LoUFETl5TvYMJbLsPSxvnYxMgyceARhudUHiETLFM60RSDr7pp4fspBXB+75QFrYp4AjMPkHxzj
 CIliLn983R0Z0IFaUI2LTQwP4rGQrO2HMFrLR5I0GhMT/95zwn9FMJp4C
X-Gm-Gg: ASbGncsIeZEhf949HcvOCEE4lM0++0hVbx32e2DQ07O8BTkiD/6/3bCLw+oo0yITcMm
 r9JQLBygwbaTX4ovdr3uaIt2bEEAVnmHDB+Ei6izgG3/h/p7f3uBzkBFufuUcGsStIcnetSarrC
 YQd+LF1ZYsHKEQI3fUkjnBYLfqq65GdJVOhfh1WgAiTJraKAjGJe82aLCU6E09Kj6zcEBPrJ6JV
 0JQ4cAZM2rC8CNlzMcQpi9tUKVLpoYA+CzJ+eKpwezQjLL80epBRsgirMn1lx/BXp2tvNb6/Pwd
 06HG0TrIfyYBk2VkchH5D877TULo9BrfvQ50idt1CBWO9DljIImpWc+jcpBAi/E/Cgc9oYXIpsL
 Wsf0=
X-Received: by 2002:a05:600c:1f82:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-46e1e15f33bmr24658245e9.11.1758636042847; 
 Tue, 23 Sep 2025 07:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvwBagm5fqCasYl1jN5HHHr1NwSHlUDz4qFg7Oh3KM1g61eSgUA1qsSCIByCzewr/FhMnGXg==
X-Received: by 2002:a05:600c:1f82:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-46e1e15f33bmr24657695e9.11.1758636042288; 
 Tue, 23 Sep 2025 07:00:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1b578ac3sm47723765e9.9.2025.09.23.07.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 07:00:41 -0700 (PDT)
Message-ID: <ef1aaf1a-1e9c-43f1-b971-012440c36389@redhat.com>
Date: Tue, 23 Sep 2025 16:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] vfio: improve naming conventions
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
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
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This series aims to further improve the naming conventions for some
> QOM-related parts of VFIO so that it is easier to understand the
> object model.
> 
> The first part of the series renames VFIOContainer to VFIOLegacyContainer
> as the existing name is misleading, particularly in the context of classes
> that are derived from it. Following on from this the VFIOContainerBase
> struct is now renamed to VFIOContainer as it represents the parent of
> other VFIOFOOContainer types.
> 
> The next part of the series adds some extra QOM casts that were missed
> from my last patchset, which then allows us to rename the QOM parent
> object to parent_obj as per our current coding guidelines.
> 
> After this there are some more renames for various QOM/qdev declarations
> so that the function names correspond with the underlying QOM type
> name: this makes it easier to locate them within the source tree.
> 
> Finally there is also a rename of TYPE_VFIO_PCI_BASE to
> TYPE_VFIO_PCI_DEVICE since that allows the QOM type (and cast) to match
> the name of the underlying VFIOPCIDevice struct.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> 
> Mark Cave-Ayland (27):
>    include/hw/vfio/vfio-container.h: rename VFIOContainer to
>      VFIOLegacyContainer
>    include/hw/vfio/vfio-container-base.h: rename VFIOContainerBase to
>      VFIOContainer
>    include/hw/vfio/vfio-container.h: rename file to
>      vfio-container-legacy.h
>    include/hw/vfio/vfio-container-base.h: rename file to vfio-container.h
>    hw/vfio/container.c: rename file to container-legacy.c
>    hw/vfio/container-base.c: rename file to container.c
>    vfio/iommufd.c: use QOM casts where appropriate
>    vfio/cpr-iommufd.c: use QOM casts where appropriate
>    vfio/vfio-iommufd.h: rename VFIOContainer bcontainer field to
>      parent_obj
>    vfio/spapr.c: use QOM casts where appropriate
>    vfio/spapr.c: rename VFIOContainer bcontainer field to parent_obj
>    vfio/pci.c: rename vfio_instance_init() to vfio_pci_init()
>    vfio/pci.c: rename vfio_instance_finalize() to vfio_pci_finalize()
>    vfio/pci.c: rename vfio_pci_dev_class_init() to vfio_pci_class_init()
>    vfio/pci.c: rename vfio_pci_dev_info to vfio_pci_info
>    hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to TYPE_VFIO_PCI_DEVICE
>    vfio/pci.c: rename vfio_pci_base_dev_class_init() to
>      vfio_pci_device_class_init()
>    vfio/pci.c: rename vfio_pci_base_dev_info to vfio_pci_device_info
>    vfio/pci.c: rename vfio_pci_dev_properties[] to vfio_pci_properties[]
>    vfio/pci.c: rename vfio_pci_dev_nohotplug_properties[] to
>      vfio_pci_nohotplug_properties[]
>    vfio/pci.c: rename vfio_pci_nohotplug_dev_class_init() to
>      vfio_pci_nohotplug_class_init()
>    vfio/pci.c: rename vfio_pci_nohotplug_dev_info to
>      vfio_pci_nohotplug_info
>    vfio-user/pci.c: rename vfio_user_pci_dev_class_init() to
>      vfio_user_pci_class_init()
>    vfio-user/pci.c: rename vfio_user_pci_dev_properties[] to
>      vfio_user_pci_properties[]
>    vfio-user/pci.c: rename vfio_user_instance_init() to
>      vfio_user_pci_init()
>    vfio-user/pci.c: rename vfio_user_instance_finalize() to
>      vfio_user_pci_finalize()
>    vfio-user/pci.c: rename vfio_user_pci_dev_info to vfio_user_pci_info
> 
>   hw/ppc/spapr_pci_vfio.c                 |   14 +-
>   hw/s390x/s390-pci-vfio.c                |   16 +-
>   hw/vfio-user/container.c                |   18 +-
>   hw/vfio-user/container.h                |    4 +-
>   hw/vfio-user/pci.c                      |   35 +-
>   hw/vfio/container-base.c                |  347 ------
>   hw/vfio/container-legacy.c              | 1277 ++++++++++++++++++++++
>   hw/vfio/container.c                     | 1325 ++++-------------------
>   hw/vfio/cpr-iommufd.c                   |    4 +-
>   hw/vfio/cpr-legacy.c                    |   43 +-
>   hw/vfio/device.c                        |    4 +-
>   hw/vfio/iommufd.c                       |   48 +-
>   hw/vfio/listener.c                      |   74 +-
>   hw/vfio/meson.build                     |    2 +-
>   hw/vfio/pci.c                           |   68 +-
>   hw/vfio/pci.h                           |    2 +-
>   hw/vfio/spapr.c                         |   52 +-
>   hw/vfio/types.h                         |    4 +-
>   hw/vfio/vfio-iommufd.h                  |    9 +-
>   hw/vfio/vfio-listener.h                 |    4 +-
>   include/hw/vfio/vfio-container-base.h   |  279 -----
>   include/hw/vfio/vfio-container-legacy.h |   39 +
>   include/hw/vfio/vfio-container.h        |  286 ++++-
>   include/hw/vfio/vfio-cpr.h              |   15 +-
>   include/hw/vfio/vfio-device.h           |    6 +-
>   25 files changed, 1988 insertions(+), 1987 deletions(-)
>   delete mode 100644 hw/vfio/container-base.c
>   create mode 100644 hw/vfio/container-legacy.c
>   delete mode 100644 include/hw/vfio/vfio-container-base.h
>   create mode 100644 include/hw/vfio/vfio-container-legacy.h

oh my ... ! Let's get that in first :) I will move it at the top of
the TODO list.

Thanks,

C.


  


