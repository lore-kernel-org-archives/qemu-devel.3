Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E50C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKel-0006yj-BS; Fri, 09 May 2025 06:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKej-0006uO-Be
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKeh-0001DX-AD
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746785313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HgPP23tXDOTtMTMEt3+tksa+FKIfay3jutz49pZzGIo=;
 b=Ds5hAVNy34XAUtX5y6jcLBaEVAYg8lIKC8M5Uyzd+OA/q6NR8c39Uxy4uVV2ogzoZwDnG5
 Vi/FAB/IcKjgK72NCdC2x28npMzLZt8nBCCT/kE3CPvqEmIGnTw8wiAVx527XgG2CfIeOO
 rh3m/8EhL39/xIN8OcnuWUdq5cR0r+o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-KOzG75FOO9K9gU7Vf9kkFQ-1; Fri, 09 May 2025 06:08:32 -0400
X-MC-Unique: KOzG75FOO9K9gU7Vf9kkFQ-1
X-Mimecast-MFC-AGG-ID: KOzG75FOO9K9gU7Vf9kkFQ_1746785311
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso1329461f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 03:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746785311; x=1747390111;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgPP23tXDOTtMTMEt3+tksa+FKIfay3jutz49pZzGIo=;
 b=wB/kfsypUj8sxOAXWDbtbaPfnj01B0ssLNn2dCdzzlBM6h4Wv9+4hV+njB2DmCEeol
 pfh+O6vFoewlU5KZGZjjz3fQdGYkSp29U8eQoz4xotmSiwnfoWit28M/leQnsUk3Uafd
 U7eMHRa2ybd5OAxQW/kHm+bRQcO4W/30A71tH25uWCxq2j4EhXOlHs9Ck9D9dqKI/Rjj
 wytcHHNt69vL7IPQG1+CTJeY+mULdKiP68U1pnDtmwrRYMT8Y9hkeywlyrPbzTYyR7OM
 3J22PeVz4O1XpuTTvnUmOiWM+sfDjDUDDVdgdrhgMDghsu49tCbe1B0m3wYArUC7CYjy
 ixoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUILjtjXnxl2oNAm4e+8EZC74IxuG498iEfZozS40KH2rZQpX/MgGu/oesY4c5ATFGQUfNBdxCvMSLd@nongnu.org
X-Gm-Message-State: AOJu0YzeImcXeAGj2Xd9as8Pwl9sYPEcQ+Ry4/+2wVK5vhxzab0Brhlh
 XlIyaweyukJ++aZqB+D2cdr+wzGAUa1Eo8q+3M49CzYc1qQ58IkIt1/aX30Ejt4TNqnBiygXrlc
 GaMgxKTNbii0fXFc3fVhp5RAQN19LTEeNIbTU8AwTPwR54+D+C81xG5y9QreYPBI=
X-Gm-Gg: ASbGncsvYHe1x3TUHZmsHRRpbvNHni+3/0CgJTinLYFbpGBe4O4fgFI9mUw2nz1Kerw
 tfdZY+U2g6SfzgfjtggNC42MVYXigpebPIFD8YGdmG8x6dfBRKzsuQVtJ8vWQTLAmJJwNP0GH9S
 y7z71QY3sE/8luJJ4tf/wIIrZxBkrurlxtG3IidJhpUreUhGP+DKjT3+EtaXbsZRxYUvrxtTeQW
 2nsHampKDW74H5SXr/19KzmXpAvnub86do5+mInj1meJ3AbZJwoiUnGoW0TZPHTXqkIGPpKTkKi
 uzTHKXWIMtOORQ8FtgW47I+TXkmi8R/FeIY/v9HDzuXDdKnCd+6JD4mG
X-Received: by 2002:a05:6000:2dc7:b0:3a0:b84f:46de with SMTP id
 ffacd0b85a97d-3a0b9941bd0mr5764911f8f.21.1746785310981; 
 Fri, 09 May 2025 03:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR7nu6qSBlLShZwpYQJOSY18NQsvKg4qoalHNEfSzE2RZeiijaZqEO5DIdQzx88cvfB3kWiA==
X-Received: by 2002:a05:6000:2dc7:b0:3a0:b84f:46de with SMTP id
 ffacd0b85a97d-3a0b9941bd0mr5764883f8f.21.1746785310581; 
 Fri, 09 May 2025 03:08:30 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f?
 ([2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f3369sm2808103f8f.57.2025.05.09.03.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:08:30 -0700 (PDT)
Message-ID: <489cb5c3-2916-471f-8dfb-76add7318acc@redhat.com>
Date: Fri, 9 May 2025 12:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] vfio: implement unmap all for DMA unmap callbacks
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
 <20250507152020.1254632-10-john.levon@nutanix.com>
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
In-Reply-To: <20250507152020.1254632-10-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/7/25 17:20, John Levon wrote:
> Handle unmap_all in the DMA unmap handlers rather than in the caller.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 41 +++++++++++++++++++++++++++++++----------
>   hw/vfio/iommufd.c   | 15 ++++++++++++++-
>   hw/vfio/listener.c  | 19 ++++++-------------
>   3 files changed, 51 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index d5f4e66f1c..a9f0dbaec4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -119,12 +119,9 @@ unmap_exit:
>       return ret;
>   }
>   
> -/*
> - * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
> - */
> -static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> -                                 hwaddr iova, ram_addr_t size,
> -                                 IOMMUTLBEntry *iotlb, bool unmap_all)
> +static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
> +                                     hwaddr iova, ram_addr_t size,
> +                                     IOMMUTLBEntry *iotlb)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> @@ -138,10 +135,6 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       int ret;
>       Error *local_err = NULL;
>   
> -    if (unmap_all) {
> -        return -ENOTSUP;
> -    }
> -
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> @@ -185,6 +178,34 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       return 0;
>   }
>   
> +/*
> + * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
> + */
> +static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 IOMMUTLBEntry *iotlb, bool unmap_all)
> +{
> +    int ret;
> +
> +    if (unmap_all) {
> +        /* The unmap ioctl doesn't accept a full 64-bit span. */
> +        Int128 llsize = int128_rshift(int128_2_64(), 1);
> +
> +        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
> +                                        iotlb);
> +
> +        if (ret == 0) {
> +            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
> +                                            int128_get64(llsize), iotlb);
> +        }
> +
> +    } else {
> +        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
> +    }
> +
> +    return ret;
> +}
> +
>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                  ram_addr_t size, void *vaddr, bool readonly)
>   {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 6b2764c044..af1c7ab10a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -51,8 +51,21 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>   
> +    /* unmap in halves */
>       if (unmap_all) {
> -        return -ENOTSUP;
> +        Int128 llsize = int128_rshift(int128_2_64(), 1);
> +        int ret;
> +
> +        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> +                                        0, int128_get64(llsize));
> +
> +        if (ret == 0) {
> +            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> +                                            int128_get64(llsize),
> +                                            int128_get64(llsize));
> +        }
> +
> +        return ret;
>       }
>   
>       /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c5183700db..e7ade7d62e 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -634,21 +634,14 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       }
>   
>       if (try_unmap) {
> +        bool unmap_all = false;
> +
>           if (int128_eq(llsize, int128_2_64())) {
> -            /* The unmap ioctl doesn't accept a full 64-bit span. */
> -            llsize = int128_rshift(llsize, 1);
> -            ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                           int128_get64(llsize), NULL, false);
> -            if (ret) {
> -                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                             "0x%"HWADDR_PRIx") = %d (%s)",
> -                             bcontainer, iova, int128_get64(llsize), ret,
> -                             strerror(-ret));
> -            }
> -            iova += int128_get64(llsize);
> +            unmap_all = true;
> +            llsize = int128_zero();
>           }
> -        ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                       int128_get64(llsize), NULL, false);
> +        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
> +                                       NULL, unmap_all);
>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",


