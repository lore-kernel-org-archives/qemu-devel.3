Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3115DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RAh-00030v-8D; Wed, 24 Sep 2025 11:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAc-0002zb-NJ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAV-0003Ny-2W
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e1iC+GeKJnCBRYqb0gMROkQufL9LXk5fmVYtcq1J8OI=;
 b=WvVw4tRqhAUXhauw31WIrTU6io4G7ZoWOjxBuRzQTEJVyPZtjRg1x/iYCFc0CF5XQGnT6i
 jAOJQY3C5r177e2AwkESi4R+g6FbfrExnINoeJPky/2Yn+QsSa23lMT1txY8zHRfL+4OAV
 /IE3c+bHgc+VftoUVrsUUKXuXGfbjHk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-6NvMqZrFNYSYiHcRUyFAuw-1; Wed, 24 Sep 2025 11:12:26 -0400
X-MC-Unique: 6NvMqZrFNYSYiHcRUyFAuw-1
X-Mimecast-MFC-AGG-ID: 6NvMqZrFNYSYiHcRUyFAuw_1758726746
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b990eb77cso7170335e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726745; x=1759331545;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e1iC+GeKJnCBRYqb0gMROkQufL9LXk5fmVYtcq1J8OI=;
 b=M2FjuQ4n48Rf9OuUTBA9OpvK7IbZgy2MZkOw8UFwC3mtj+lIVLKWt5DHPp1A23CRvN
 18MXi56+uCtAvePWcx2ET2eUFjk4TudoxW6Qpfyog72u+5MCCHBPdljQaPfW6dI2z/ok
 kZ5Ps1ywvWlr/KAxhalXs5Vsyr5gEax9tAUhwaVFLq0xJUTytgWRKSz7IrMLX35qeT9y
 0gO247G7ajnUtZkxy2/cjmk0ftKzQgOYYM50yFMZGjHQxWbEcCulk8TVGWkPjdRoCEqK
 zSfZSrWTIw5iatkatwhvt82aCHrpm8/gH81eTj3Qk7a9c1CFAf4Xj0obig+eagWhWQOZ
 CsNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmzYuBjBrHjpQbmcTlKE+rMOeagZnrJ8oXKfqyjPX924K1kcq6llNPBbw3rB0YJuod0ItnhUBR8/Ck@nongnu.org
X-Gm-Message-State: AOJu0Ywo/u346J/hJVD0X83xZJAJg6Bh2m3UNxBYhz2P2AryEfboIXBb
 6kR8KTyXtZJ7KI6/+5qRxRoimAgp2Ce4qY2xVvZ8VShoMD9RF67ovFiEjZbmtQAzhBAgWqwn8qJ
 OrR6O7zKP5irDDvhg48KWVzK51L6BqroCDgAzV2dz87eKSAeAA8r7JmZf
X-Gm-Gg: ASbGncuHmFySvKZhdfvwyaAb9tMUCurGxZnBDNu7S5qY6qbpK28A+x+WwhwAgUfiXPV
 nwrRyR6pMCKJHR0Rrwx6/aDO7uZrwDO+L0msUF0+QZXoArWw782XMbyihb5ajYQFFyFn/XTcRQh
 TvU6zDv4dZTjtyZ+o8UWE2vHUYlphfnxa3HrayT5pI90YRahvk2MQWagaC0R90ElQ1GHrtIL8yO
 VCWVX8vEwMaB+RmjTyuDQMFIO3sbIe8CkNH0Cu2tTabbqJf3RNQ2l6cL+tniF3p/DfoB4bCcHQw
 vfXi0kH4QoFMPG7aRvId6IdRJZpuiqEBdg7IkXTMgH3P/G5iBDF2PJCcU/LuIFjBkMJW8Wi9Ona
 aaaQ=
X-Received: by 2002:a05:600c:b90:b0:45d:d259:9a48 with SMTP id
 5b1f17b1804b1-46e32b4d706mr583255e9.9.1758726745492; 
 Wed, 24 Sep 2025 08:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlNkRSg2M8KHPerzhy6DI9ECtBdhHiqA7t9OkxwlVihrpf5RtY3NQXbfxEyUw8Jf5ZrkDlUA==
X-Received: by 2002:a05:600c:b90:b0:45d:d259:9a48 with SMTP id
 5b1f17b1804b1-46e32b4d706mr582955e9.9.1758726745091; 
 Wed, 24 Sep 2025 08:12:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407fa3sm28401351f8f.21.2025.09.24.08.12.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:12:24 -0700 (PDT)
Message-ID: <f9ff2d85-b11d-4f90-867f-d3be14329f51@redhat.com>
Date: Wed, 24 Sep 2025 17:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/27] vfio/pci.c: rename vfio_pci_base_dev_class_init()
 to vfio_pci_device_class_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-18-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-18-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This changes the function prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6d2ca710c8..a511f99a2c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3660,7 +3660,7 @@ static void vfio_pci_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_SKIP_RESET_ON_CPR;
>   }
>   
> -static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
> +static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> @@ -3677,7 +3677,7 @@ static const TypeInfo vfio_pci_base_dev_info = {
>       .parent = TYPE_PCI_DEVICE,
>       .instance_size = sizeof(VFIOPCIDevice),
>       .abstract = true,
> -    .class_init = vfio_pci_base_dev_class_init,
> +    .class_init = vfio_pci_device_class_init,
>       .interfaces = (const InterfaceInfo[]) {
>           { INTERFACE_PCIE_DEVICE },
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



