Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A727EC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKic-0007HL-TR; Wed, 11 Jun 2025 08:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPKia-0007Gk-Qq
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPKiX-0001YH-Vj
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749645488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Os7oDjbWuIVpcLQnAhOZQshI4Lay7PrVK2LXUSxOYy8=;
 b=NhwNXCcubeJxczD2EWpU15R27fLl/B/SvEgOqj8KqEVK/svaiiNiTCtJ/cwbPBikH1tGxG
 5EltbvXMh6KKDFe9AZ6VJaxjHaBbBBw4WQVCcT2L+1Z+eCV+gNwtVmzwgfLa18kNd5oHAV
 LmpX/9WM0/amWf8565v72kirypcNU7Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-q7U3Xo2APzuWIzzKX7zcwg-1; Wed, 11 Jun 2025 08:38:07 -0400
X-MC-Unique: q7U3Xo2APzuWIzzKX7zcwg-1
X-Mimecast-MFC-AGG-ID: q7U3Xo2APzuWIzzKX7zcwg_1749645485
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450787c8626so37979745e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749645484; x=1750250284;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Os7oDjbWuIVpcLQnAhOZQshI4Lay7PrVK2LXUSxOYy8=;
 b=EwPyCYIKb1/8fkM30roYmARVcOriWqlNrIrx1iw5A/URLX2vpXDCm93qJX6IDsk854
 UqoGdSymuuCfwATVde47/+HWyD/8xgar+91v4XTW7mIzdH+wVTPDmGtvFaJZyWcUDF/G
 ONfU9s/ERd1rhjyN+ONQw4t/R+OxnvVfGl5pyhQXGIy8pDYaByAd6D7KPX4WaksKKtr/
 RlhN/N7PHasgDJdnJ06FfBqmmmz56EnV1fOQKj+jL/qOZL2UOdq9o7E8qzM+niTeDcN9
 7z2TYDlDM1wqCwC+wxXpJo6hDEbc1lM4xkV1aAwO5N7spiMlKDav+OM0cPnpBFVQQ3/4
 fMJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJo4HXkI8rpbc6lR3ynxUJJ8CRvbcAYfsCpfrZGCpvH0z+xDENjogkjmc5YUuCKVSfyKgwbaseeBzn@nongnu.org
X-Gm-Message-State: AOJu0YwRTpgdTIq72WkOaVcrQVEiMjYAepM0on99qq73hqoqbFhw6Y3l
 2r1BmYSzUQwqzZ58yHRdbgieBRqBLERwNQ/6SSMbqynDlRERde4fZGfFe/L7XI+XBeJUzG/b5v3
 iJ7RDXqbt9ggbFJCPe3IXpem/rZY9KJjQsQXneqfeUdpgyUSZhrco1gWDVQUwS58b
X-Gm-Gg: ASbGncsMgAXIQLozXql7fZpwHTve4uT4w+aTumZCr0QaDhyYZmbq7iyjSwiLDomI2PO
 P6ZYrpKbX7cz7fiw2zDJUbS3MK91463Agwoh2vywzCsCTfzu1b0VXdHAYFNNAg/n6lnUiusEPq5
 ySxOo8QQ1rphn88HLqLFIG8dKUwhupkaH/QbmM78/bFgXXkEdn5l/HdqHGdPNtMmbnpY7J/txRd
 VFM5qMrhVvxZupmXuahkX5o0+8JQwPNGhDWNE6aEDqPZf+NUcq9Fc1X/57otzcyb4Rk8ecSsGxZ
 IQLe3NTdLTejH/7mA+UgiMmHa+exPwTbcNhcjicGSl1Qck/Gcdq89r6E3lkM
X-Received: by 2002:a05:6000:2006:b0:3a4:f786:4fa1 with SMTP id
 ffacd0b85a97d-3a5586f5dacmr2279094f8f.2.1749645484661; 
 Wed, 11 Jun 2025 05:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFi5cZ5eGnIecf6HS9N+h47pZmH7w5f0KiGDJmwHfs5Mv/wGn3+nfX2Wbc9NDfHaBUp9fqWA==
X-Received: by 2002:a05:6000:2006:b0:3a4:f786:4fa1 with SMTP id
 ffacd0b85a97d-3a5586f5dacmr2279070f8f.2.1749645484276; 
 Wed, 11 Jun 2025 05:38:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464575sm15294723f8f.97.2025.06.11.05.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 05:38:03 -0700 (PDT)
Message-ID: <95806737-f106-4a46-8f6f-5e5b7028a6c9@redhat.com>
Date: Wed, 11 Jun 2025 14:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 23/38] backends/iommufd: change process ioctl
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-24-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1749569991-25171-24-git-send-email-steven.sistare@oracle.com>
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

On 6/10/25 17:39, Steve Sistare wrote:
> Define the change process ioctl
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/system/iommufd.h |  3 +++
>   backends/iommufd.c       | 24 ++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   3 files changed, 28 insertions(+)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 2d24d93..db5f2c7 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -69,6 +69,9 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>                                         uint32_t *entry_num, void *data,
>                                         Error **errp);
>   
> +bool iommufd_change_process_capable(IOMMUFDBackend *be);
> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp);
> +
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
>                       HOST_IOMMU_DEVICE_IOMMUFD)
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 3a2ecc7..87f81a0 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -73,6 +73,30 @@ static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
>       object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>   }
>   
> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
> +{
> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
> +
> +    /*
> +     * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
> +     * This is a no-op if the process has not changed since DMA was mapped.
> +     */
> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
> +}
> +
> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
> +{
> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
> +
> +    if (!ret) {
> +        error_setg_errno(errp, errno, "IOMMU_IOAS_CHANGE_PROCESS fd %d failed",
> +                         be->fd);
> +    }
> +    trace_iommufd_change_process(be->fd, ret);
> +    return ret;
> +}
> +
>   bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>   {
>       int fd;
> diff --git a/backends/trace-events b/backends/trace-events
> index e5f3e70..56132d3 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
>   dbus_vmstate_saving(const char *id) "id: %s"
>   
>   # iommufd.c
> +iommufd_change_process(int fd, bool ret) "fd=%d (%d)"
>   iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
>   iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>   iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"


