Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFxWh-0004Ty-Io; Sun, 11 Oct 2026 13:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xFxWX-0004TZ-2G
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 13:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xFxWV-0004PG-BI
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 13:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791740386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4nsupO1hYHvGbTu7rv7mZw5DFJ3OvrDT9/wWccfeIwc=;
 b=YGzKQdS/5vbAwrmH8TtLkX0tVzP23XAsge0rh/CDGXXAOV131Eyb6EkqFCAAKLS390jWQs
 l7MoA4JGUl7I8sMqrhCD/7cxboJnJ80ge3LtQbhmZD1CbtqwgJVsorslDj75Keg/IstNWy
 nNrJ2QAUzFy+xto31eC0zKJVc1SD1ts=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-6Zk1UROrNgeB0s_CWU4mdQ-1; Sun, 11 Oct 2026 17:39:43 +0000
X-MC-Unique: 6Zk1UROrNgeB0s_CWU4mdQ-1
X-Mimecast-MFC-AGG-ID: 6Zk1UROrNgeB0s_CWU4mdQ_1791740382
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48afcecb035so174825f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791740382; x=1792345182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4nsupO1hYHvGbTu7rv7mZw5DFJ3OvrDT9/wWccfeIwc=;
 b=PP7bQ4wBuCTOfeI4jH7osvs121Vpe9PbyAPzqdbDtIcCytelCGOrERcEjqq2RwVyDi
 1AxshwvAS6iIdrms0x4L2iYQ6xPS4LwBwlyY/sZKCWN+UttyNtxoXEK+R+14b0Pt22ZF
 ozl7hiHwT5wYoG8vWz0Y2S1QApuJVgsw69QdvC8dxsGhLaNLW0OsKfitzFF6WKlbrzJG
 tgDFzd86DXFs7EOWUPDryp3xqwLyScLO90hF+xMboFiZrQekk+pUT5UWLzOy+tesenIn
 vPVxc796pcQ/bOwexHHhy5j1A7PTrOEveRrXG0n5opccVEbyLIEzX8qxBEVSONnc5thX
 DyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791740382; x=1792345182;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4nsupO1hYHvGbTu7rv7mZw5DFJ3OvrDT9/wWccfeIwc=;
 b=hteXvF3OykvGty3sqIck/GfzFC5MWsCH7CpsADArMOvzYHbQg8a87aTjKOQm4AqFPJ
 bqZA++VjLoTZ9JZtMrCvLtyWyOPHZTgyqzPvSc1pKj5L9vJiJ3YAOPHDwZbaCBz6oYWH
 22vzHk5yswg42t40fXNiVV6VWq71SikfRHGgQIU6cImUpm/Y+Wca3mSOsxz9HKSgQye7
 opC/Yfzocln43zVxavag3zt2QvHjUVmkQ2EhVu6Z7f4Kmwf9NZMG5FNLvpLmstQjL6wM
 XKJOmRfqp9nQhsI+Dlhdatd5MbKepOuJ0ytSMhLlt/SIG2nsqIjgGxhk+PlKiBS14+JR
 gMDw==
X-Forwarded-Encrypted: i=1;
 AKwUvByUcogYndK8z4M+RH4UIErYETK6kBXiKkZ6nh2sxVfdL1jisHEHWDGAtVfZ1VQsA0Zdc2dzmI8TLcPz@nongnu.org
X-Gm-Message-State: AFq9FYKdHPwgNdlzDf6wq3W2J7MXc0XuH5akZm7cIgQZXOgx+OpIdGex
 sGp2rC5qSxereWnZDr8eEG5gxHH9FnZ22HaTH5EwbQ7uTxilkBzrzaT26tibKbQBLgmFDOPpgm1
 GlLX1aLql+CYFTwcVhTP5J7Xi1mSCIsKtia/IthHR47JZga3nTffyI6W3
X-Gm-Gg: AYBFou1IpC3jeGS1/ytGvCXp8AkljPcMkEJ42c5vas/izdDruzBhfaHaFFTxDOVb9Tl
 jdEC/tijbw2YQ4EjnLKJnvRAfMdnbhuwlk53Az9GfmltngWM+8iIetBzHN6lESd51iFinUcGRBR
 6LMSYnrhUzv8QXWlWICMO1+XqMs+B6J+WoAFvhAqeG3vMLqJE1AjvLKlF4Cob8VzpVCMKQABAs2
 +pkAMMaH6cma4EcSLGS3GLqFSEkD9pMOEjaDoucViw6cJx413cMq5msdqNgjzKJ9WKDPGqIV4jq
 oxipKCjlGftceKEga60H0O8PlfIlmwoVSJjR/O+GCRs1WnYfEXm6fXWPyAQL/cf8oXrb++z+FLe
 NOY9uCzDUelvV++CuvjY+nA7v6AyjLxc9IpUv/Rpm
X-Received: by 2002:a05:6000:188a:b0:48c:72fc:3644 with SMTP id
 ffacd0b85a97d-48dbacf555bmr16339320f8f.22.1791740381566; 
 Sun, 11 Oct 2026 10:39:41 -0700 (PDT)
X-Received: by 2002:a05:6000:188a:b0:48c:72fc:3644 with SMTP id
 ffacd0b85a97d-48dbacf555bmr16339279f8f.22.1791740380972; 
 Sun, 11 Oct 2026 10:39:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db99b820asm16319122f8f.24.2026.10.11.10.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 10:39:39 -0700 (PDT)
Message-ID: <9bfb90b4-7ed5-4400-abf6-d01e110e840d@redhat.com>
Date: Sun, 11 Oct 2026 19:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] vfio: add setup_sparse_mmaps hook to
 VFIODeviceIOOps
To: Naman Gulati <namangulati@google.com>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20261009175314.1823347-1-namangulati@google.com>
 <20261009175314.1823347-4-namangulati@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261009175314.1823347-4-namangulati@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/9/26 19:53, Naman Gulati wrote:
> Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
> backends (such as vfio-user) can parse custom sparse mmap capabilities,
> falling back to vfio_default_setup_sparse_mmaps() to process shared
> VFIO mmap capabilities.
> 
> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
>   hw/vfio/vfio-region.h         |  5 +++++
>   include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
>   hw/vfio/region.c              | 25 ++++++++++++++++++++++---
>   3 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index 9f6a5cf7d5..a0c9533f9f 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -46,4 +46,9 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
>   void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   
> +struct vfio_region_info;
> +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> +                                    struct vfio_region_info *info,
> +                                    Error **errp);
> +
>   #endif /* HW_VFIO_REGION_H */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 8472420d3f..3136e152f2 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -43,6 +43,7 @@ enum {
>   
>   typedef struct VFIODeviceOps VFIODeviceOps;
>   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> +typedef struct VFIORegion VFIORegion;
>   typedef struct VFIOMigration VFIOMigration;
>   
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
> @@ -218,6 +219,21 @@ struct VFIODeviceIOOps {
>       int (*get_region_info)(VFIODevice *vdev,
>                              struct vfio_region_info *info, int *fd);
>   
> +    /**
> +     * @setup_sparse_mmaps
> +     *
> +     * Parse sparse mmap capabilities for a region and initialize region->mmaps.
> +     *
> +     * @region: #VFIORegion to set up
> +     * @info: region info struct containing capabilities
> +     * @errp: pointer to Error*, to store an error if it happens
> +     *
> +     * Returns 0 on success, -ENODEV if not sparse, or negative error code.
> +     */
> +    int (*setup_sparse_mmaps)(VFIORegion *region,
> +                              struct vfio_region_info *info,
> +                              Error **errp);
> +
>       /**
>        * @get_irq_info
>        *
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 16efed2fce..d6cd5d4743 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a, const void *b)
>       return 0;
>   }
>   
> -static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> -                                          struct vfio_region_info *info,
> -                                          Error **errp)
> +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> +                                    struct vfio_region_info *info,
> +                                    Error **errp)
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_region_info_cap_sparse_mmap *sparse;
> @@ -198,6 +198,25 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   
>       region->nr_mmaps = j;
>       region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
> +    return 0;
> +}
> +
> +static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> +                                          struct vfio_region_info *info,
> +                                          Error **errp)
> +{
> +    int ret, i;
> +
> +    if (region->vbasedev->io_ops &&
> +        region->vbasedev->io_ops->setup_sparse_mmaps) {

Every other hook is a mandatory field. This should add :
  
   .setup_sparse_mmaps = vfio_default_setup_sparse_mmaps

in the kernel VFIO io_ops to be consistent with the rest of the code.

Thanks,

C.

> +        ret = region->vbasedev->io_ops->setup_sparse_mmaps(region, info, errp);
> +    } else {
> +        ret = vfio_default_setup_sparse_mmaps(region, info, errp);
> +    }
> +
> +    if (ret) {
> +        return ret;
> +    }
>   
>       /*
>        * Sort sparse mmaps by offset to ensure proper handling of gaps


