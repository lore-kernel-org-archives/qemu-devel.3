Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270F9CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RB6-000389-RU; Wed, 24 Sep 2025 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAs-00034h-Rw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAp-0003QE-Ov
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=us+P3iJERuOyPKXri6HE+c6P3DAPmFCks2JgCL8MJ4k=;
 b=Lo8WGUb/rT9FUy/4GtljsgvCix0q7hn3XQrSQvcgUi1UYJNo30OgS7dXp1dW/I/pLqKKrA
 cYLcvC4oR9C8BCYJ0zhnQfBVZZI8gngm4Qi2n2AWUXuhdQZhijh1m9xstFTnZH2Tz7Jc6+
 UpR6MJ/a8jaKtnuVzHe95QAivopkZR0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-DZySXMi1PBKqZceAd7unDw-1; Wed, 24 Sep 2025 11:12:47 -0400
X-MC-Unique: DZySXMi1PBKqZceAd7unDw-1
X-Mimecast-MFC-AGG-ID: DZySXMi1PBKqZceAd7unDw_1758726766
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e19ee1094so27523435e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726766; x=1759331566;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=us+P3iJERuOyPKXri6HE+c6P3DAPmFCks2JgCL8MJ4k=;
 b=MftnJsbUgOWuiLKtGZfHad44UdqH7wUv7U0RGqfouH7ZqAb/mbuVI7XKUZtkJWGuqU
 VdwGDiIe7RXYnPbJIsbbelFanmM8mQvLMaCAR8rtQgYdOg3iHAYAbvM2y3/f3tbr655d
 7TET7zgUysxjlEOS8O64krZbZm6IB7wxR7S6/iMJN8w9w6ckuOsKzGnbpxhHPWJrJx+k
 ou3ItL4kHlatx1ZWogudvXW3ZYh8NIv/mkMk+2Tb4mVlsGHAZP2ZCgpGVlVhLE6FunjE
 e47QtsF1T33AoHeMs6KZbxXhv1DZtZm2MpJ3l8FN3+ok8TW8kYHv4O1hUEZ3StuYukjK
 1VcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbwBDzcNNjt4WhveZTH6ispciDRfTVEPG4JvOEBbYwKqW5Sk2Kxmc9ty4GKLxGcpNjCDgQhkdjMcM/@nongnu.org
X-Gm-Message-State: AOJu0Yyu7hgThbJDR9v7W0pOCspqxgsQFkdJAA0RfNLswtoE/8GfgTuw
 ujeFMucaavHFYMKgzmttXzK266HJYgmGsYqYfwagmq5i2sPW5iCoDagOddvsLfzm+w9pY6Ubuln
 51/BRGXO3eqkf5rrjaHorj54qk02IW8H5nZmOYIDyRQAce78dudJ3S3kv
X-Gm-Gg: ASbGncua9ogGMsu7L2PgxoZ3iDp9LxtQ2szA5d2RxoEsgLH4OO6Vkd5I7HnGpJ1ULgH
 lde7V49oze8JSQmHV4VKlCp7iWhxu6jx8mAknSvstb0uwGTjr7U0Wy3NLLt46woq6q//as12vPq
 FaQ8VhYpz2uPQ7rfz/Y2CwajJWKCg8kQdwq0sx6QWx2b8uoTaE6NWj7f9hkMNCfztzR68fHtxNk
 iwtd5vkalJhgZhlfSTslaV2QhqGMm3TM7OW9UPgFDKP6ibqY+DVZeZgGn5OEQ6AD23+lBFJLY9m
 t3eykL8yhHx7fHlysyoMKI6v0X+newjltC8w9QIiSfasRDX1uOSXcMc5ICrdLANmVaejqR1kxMf
 uZPc=
X-Received: by 2002:a05:600c:4e4c:b0:46d:27b7:e7e5 with SMTP id
 5b1f17b1804b1-46e32a51741mr1589775e9.32.1758726766311; 
 Wed, 24 Sep 2025 08:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjcdQIREvs/+gYrKw+WJmy2VLwU3FWTXY0iKCnGo2ehMpx1qSPssUkjULZMMdwuPnakgMy/Q==
X-Received: by 2002:a05:600c:4e4c:b0:46d:27b7:e7e5 with SMTP id
 5b1f17b1804b1-46e32a51741mr1589445e9.32.1758726765900; 
 Wed, 24 Sep 2025 08:12:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f0e28c83d6sm23772422f8f.56.2025.09.24.08.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:12:45 -0700 (PDT)
Message-ID: <f2871edb-24f0-4bb5-802b-9a1c4038e503@redhat.com>
Date: Wed, 24 Sep 2025 17:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/27] vfio/pci.c: rename vfio_pci_dev_properties[] to
 vfio_pci_properties[]
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-20-mark.caveayland@nutanix.com>
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
In-Reply-To: <20250923135352.1157250-20-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This changes the prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e8d2e36df0..839b5af339 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3687,7 +3687,7 @@ static const TypeInfo vfio_pci_device_info = {
>   
>   static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
>   
> -static const Property vfio_pci_dev_properties[] = {
> +static const Property vfio_pci_properties[] = {
>       DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>       DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
>       DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> @@ -3773,7 +3773,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>       PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
>   
>       device_class_set_legacy_reset(dc, vfio_pci_reset);
> -    device_class_set_props(dc, vfio_pci_dev_properties);
> +    device_class_set_props(dc, vfio_pci_properties);
>   #ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>   #endif


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



