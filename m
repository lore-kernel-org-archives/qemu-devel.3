Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E4FC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjHI-0003u2-28; Wed, 05 Feb 2025 12:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjHD-0003ti-Vt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjHA-00011i-34
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738776802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0CU4oy5mUkfx0mQm3mDCSSG9/YIUHJUqi5VcwZ7K4jo=;
 b=LIZIXbLCRs/n7GAXDs9Q79BDBBmqFlTjaUMLzYfA/I3SWPTxne7YrvltBJw8a/zCkIdRZy
 XyLmEdayf69dTSz/f2imHQcci0cGzPpPGYFoaEfFhR3A6tqCh0YQLWRkp/s8s42hx4qwys
 jE4zRJUJLo+uQdkFQe5c6aNXXFHJUe8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-kE0PojGpMrKnjb_wg4WVXg-1; Wed, 05 Feb 2025 12:33:20 -0500
X-MC-Unique: kE0PojGpMrKnjb_wg4WVXg-1
X-Mimecast-MFC-AGG-ID: kE0PojGpMrKnjb_wg4WVXg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6eeef7c38so1520926585a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776800; x=1739381600;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CU4oy5mUkfx0mQm3mDCSSG9/YIUHJUqi5VcwZ7K4jo=;
 b=TOd561tKApCFRwuAaIFsiXFHkdtzG2NOGoCyeWLTOQTYS5wFCIi0TsF292tYbg/AKO
 fC+JDPKJxAgt5wWWYiuyMA2+40UYOtrn5vIAeF2MJ8XI22roVQlW13VTsvfllJXBOcZ4
 z3g/xCncmf4soD2muE6L0jcvrUSurdHqtp9pm6amBN0pHzHnwUTJVjFZcrCvsWWmSOro
 yhz5QhYHUzbbBGX+lVY29aK+iP6kuS6eARlWilhp9iYUwrOj4gMm7uILKRniaa34FR+9
 4gSvSwwMix8JEckHHUtPKsiA8idgrYiimk6N+4uBe/4lwM876LqaEY/VNTXAf1wJp5mR
 /N6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG+4pxoeEFli/0kVTFK1Ccwct+Tv/lHYsGhrjElcBUE/lihrgG9kNm0j5UIh1OAkSfiH7Zv5Besbgi@nongnu.org
X-Gm-Message-State: AOJu0Yyq89itcvoWpEZPuE+OkynMZf/wtg5V+ISjWUkrNOJ92vqVIGkp
 MArtXF7WZd7SaHCklResmSU6GkUuvhXgoRJR+bRM//Qq4OhM7Jb8jYWgmx0UvQj8GDHl+5siigh
 raQaG01ZooZCZvLjzGoHO0l8+snEOeKsS1UXv/zybpwJwe1i47GW1
X-Gm-Gg: ASbGncsVmFHcy+hmJqgDLaGIV4bSWTBd4C7cKap4KsaCa/5kYxEBqYR3tQAZNqmUGNZ
 lGXWmr8QLrf/W/vUaBVUJqIMWLEMEUYQKLwpJKnSd0I+Fgj20hS+UJ3UV1TJ+nV/Tqut99xxvkd
 z0+Ftha3v6NFGg1k863yOVku4lTWiOYv3uB+6NKCaBKZi02odbtTCzyegMKDYTfj2juQo4CeU9q
 OI6J0v7pQrqC7Pm8HtH7HuAeORz8M0bRdGRYkqoXZcSy8ZYxBamj57NrGblc4/nnEZDcfDJDK4a
 ZqW/WmzFwTa1Kh5Yq8eJlWW4i1J4JH5GQ5b306zP6J8=
X-Received: by 2002:a05:620a:3946:b0:7c0:4f:f194 with SMTP id
 af79cd13be357-7c03a049dc7mr578480885a.58.1738776800379; 
 Wed, 05 Feb 2025 09:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZDpHI8EKCAyByFzCsgmXD8Bb/6V7UyIhAI1VZFQaapYqOFCVZl5dk/vHCyU7Nq2htzoBe2A==
X-Received: by 2002:a05:620a:3946:b0:7c0:4f:f194 with SMTP id
 af79cd13be357-7c03a049dc7mr578477785a.58.1738776800082; 
 Wed, 05 Feb 2025 09:33:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a9047eesm778334985a.72.2025.02.05.09.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:33:19 -0800 (PST)
Message-ID: <c0999ca5-d10d-403a-8b8b-46bb881673aa@redhat.com>
Date: Wed, 5 Feb 2025 18:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 20/26] vfio/iommufd: export
 iommufd_cdev_get_info_iova_range
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-21-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-21-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Export iommufd_cdev_get_info_iova_range for use by CPR.

why does CPR need access to the IOVA ranges ?


Thanks,

C.



> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/iommufd.c             | 4 ++--
>   include/hw/vfio/vfio-common.h | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index a3e7edb..2f888e5 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -442,8 +442,8 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
>       return ram_block_uncoordinated_discard_disable(state);
>   }
>   
> -static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> -                                             uint32_t ioas_id, Error **errp)
> +bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> +                                      uint32_t ioas_id, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
>       g_autofree struct iommu_ioas_iova_ranges *info = NULL;
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 5a89aca..ca10abc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -268,6 +268,8 @@ bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
>   void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
> +bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> +                                      uint32_t ioas_id, Error **errp);
>   
>   extern const MemoryRegionOps vfio_region_ops;
>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;


