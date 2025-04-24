Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389ABC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 15:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yMT-0000mx-2u; Thu, 24 Apr 2025 11:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yMQ-0000mj-Bl
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yMN-0000WD-Fc
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745507970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/3VIMlkUXZ4XwaOuyKdmkq4ZLB5P6VqRsbo3dlPC0nY=;
 b=KBEO+kRMwOL0VZCcC85ULarQznRd7lbIlDAqe8TkEUpc3S0eklYFpRlbJpAfPzH7O7Lgfl
 4R8xOn3avYd5G7jPzVdhg0TowtWY/+wEm2wrZhtlwhfGtABkdS8BW9to8JFgiZFV2aQTpT
 h96EXi/f+mr/tpHAaUUsj84kYBJ3JAY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-CjPYmiclNs-XvDd_2TOorg-1; Thu, 24 Apr 2025 11:19:27 -0400
X-MC-Unique: CjPYmiclNs-XvDd_2TOorg-1
X-Mimecast-MFC-AGG-ID: CjPYmiclNs-XvDd_2TOorg_1745507966
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so6342095e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 08:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745507966; x=1746112766;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3VIMlkUXZ4XwaOuyKdmkq4ZLB5P6VqRsbo3dlPC0nY=;
 b=CY6NcjQWCZxhlWw1QIBjMdB0EeRk/O63v12epDSp7TVljGbBhhu8lBhhnOGrjjOn98
 fOp77VVq7icvkd2t1vR7l3fEm0yo3u6APbJlGZzm3qKFeVMB3NxenWpWTSYg1c+BII8F
 TnevYzCKbMoNkq97bX8HwGybCDG4mqTwVvZQdfqYrP2EMYOohYx8m9gYK2EioyHUBfGK
 dfWJCb6VMKWqr1kv7fRpgyQ3rvaNn1HNGuDwyG5p3KOsnDt6n7aVY5Yow7XzXWwrm4bq
 qvPEXbYiJS1mn5KVHDb1JtKA5khBdbn5T1VwcShNEu0XfQYL7IbP0jXei2JkcBBLPETq
 HeDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMhXpIr4ZJv+x/zUTxXr2IbSsbc9Rf4vPdjNuRSoZLrG0YWstI71/97+pVzo1PrBXiBYRzk96LHlOb@nongnu.org
X-Gm-Message-State: AOJu0YyXzutPhTs12EAA29rTOAeoO3ppSiocizgo3Vkglgnj43KmfHhd
 8M+WGTCapwllAVSJi6Y8SoY20Ov0KMdnoLQKhlLaqAQAI8U+JWs1HaNG51fqjc1iyFyvJwfA3RN
 hqlckM2TgJub2CCYONJYj5tbbbpXUGcTuxdc6sEzMU3tWzDuzLwPM
X-Gm-Gg: ASbGnct43Tk+T2fkfHsWYyHFMQUMPl5BHAcIwKMLDdQUWnOyuEdxWa3olQmtKwluE0a
 QoQXNUZjgTpq166HZ/DiW7a0oSs0yhob2/bKhpCqnT0+u46VsAZA704tTIyMqHwsSLCrUvY/pG1
 q2VH/Jwkmlio/kx67PVwIvzTLsWMo7LSLaJubnXn6vFrMg7bIsn+KXWHeIg3wecUr8gjHq/2Jeq
 9m8TCSk7P+iFa/sEkvMTTNLkRql7a7JZA7sAZRGgbpOD3abR+IM5Rm2u0zqdBVQervD0epoLGN8
 8hR5d3VCxUsxCj7Ga8CeLyziSa0FOn3fQHvg1VRvL9Fu0AE=
X-Received: by 2002:a05:600c:4e14:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-4409bd324ffmr32445905e9.18.1745507966377; 
 Thu, 24 Apr 2025 08:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSci/yoxwQiP4buO5PLkvFNjwtRW/IwxJM1okoxm4MICIZULfK8/iy0qz/HcZzOxa4h0+dIw==
X-Received: by 2002:a05:600c:4e14:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-4409bd324ffmr32445545e9.18.1745507965895; 
 Thu, 24 Apr 2025 08:19:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2c07a2sm24646225e9.39.2025.04.24.08.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 08:19:24 -0700 (PDT)
Message-ID: <791befee-6aea-4215-8d4e-9a5e2905d01d@redhat.com>
Date: Thu, 24 Apr 2025 17:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] vfio: consistently handle return value for helpers
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-11-john.levon@nutanix.com>
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
In-Reply-To: <20250409134814.478903-11-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On 4/9/25 15:48, John Levon wrote:
> Various bits of code that call vfio device APIs should consistently use
> the "return -errno" approach for passing errors back, rather than
> presuming errno is (still) set correctly.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/pci.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ac53c43f2b..ddeee33aa9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -398,7 +398,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>   
>       ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>   
> -    return ret;
> +    return ret < 0 ? -errno : ret;
>   }
>   
>   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
> @@ -459,7 +459,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>   
>       g_free(irq_set);
>   
> -    return ret;
> +    return ret < 0 ? -errno : ret;
>   }
>   
>   static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> @@ -581,7 +581,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>               vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
>               ret = vfio_enable_vectors(vdev, true);
>               if (ret) {
> -                error_report("vfio: failed to enable vectors, %d", ret);
> +                error_report("vfio: failed to enable vectors, %d", -ret);

while at changing error reports, could you please add literal errors using
strerror() here and below.

Thanks,

C.



>               }
>           } else {
>               Error *err = NULL;
> @@ -695,7 +695,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>       if (vdev->nr_vectors) {
>           ret = vfio_enable_vectors(vdev, true);
>           if (ret) {
> -            error_report("vfio: failed to enable vectors, %d", ret);
> +            error_report("vfio: failed to enable vectors, %d", -ret);
>           }
>       } else {
>           /*
> @@ -712,7 +712,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>            */
>           ret = vfio_enable_msix_no_vec(vdev);
>           if (ret) {
> -            error_report("vfio: failed to enable MSI-X, %d", ret);
> +            error_report("vfio: failed to enable MSI-X, %d", -ret);
>           }
>       }
>   
> @@ -765,7 +765,8 @@ retry:
>       ret = vfio_enable_vectors(vdev, false);
>       if (ret) {
>           if (ret < 0) {
> -            error_report("vfio: Error: Failed to setup MSI fds: %m");
> +            error_report("vfio: Error: Failed to setup MSI fds: %s",
> +                         strerror(-ret));
>           } else {
>               error_report("vfio: Error: Failed to enable %d "
>                            "MSI vectors, retry with %d", vdev->nr_vectors, ret);
> @@ -882,17 +883,21 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
>       g_autofree struct vfio_region_info *reg_info = NULL;
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> +    int ret;
> +
> +    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
> +                                      &reg_info);
>   
> -    if (vfio_device_get_region_info(&vdev->vbasedev,
> -                                    VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
> -        error_report("vfio: Error getting ROM info: %m");
> +    if (ret != 0) {
> +        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
>           return;
>       }
>   
> -    trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
> +    trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
>                               (unsigned long)reg_info->offset,
>                               (unsigned long)reg_info->flags);
>   
> @@ -901,8 +906,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   
>       if (!vdev->rom_size) {
>           vdev->rom_read_failed = true;
> -        error_report("vfio-pci: Cannot read device rom at "
> -                    "%s", vdev->vbasedev.name);
> +        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
>           error_printf("Device option ROM contents are probably invalid "
>                       "(check dmesg).\nSkip option ROM probe with rombar=0, "
>                       "or load from file with romfile=\n");
> @@ -913,7 +917,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       memset(vdev->rom, 0xff, size);
>   
>       while (size) {
> -        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
> +        bytes = pread(vbasedev->fd, vdev->rom + off,
>                         size, vdev->rom_offset + off);
>           if (bytes == 0) {
>               break;


