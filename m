Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A4FD2E02B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XQw-0006Rz-Br; Wed, 23 Oct 2024 05:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3XQv-0006Rp-05
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3XQs-0001xt-FE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729674812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NZZzrh+5FfDXV5sKPgomJ5a/uS2HEWOMtpN8RzoyxTI=;
 b=WTRh3GNDML4/DE+QCSUcOYgvHJB94dZfjB2AJcs3faYcufk6TeitTroBA9G1lTv8NqyjCQ
 zsG6GLWDq+W4NWFsXF2a9l+qfq0T5Fa39285UL/acKrg02FcaH6JtXaWn/xbtVycCfha85
 v64zUhDRw5nEA6cPejDuqZXAgXgS5J0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-HGcEaVePPASp9lSqLYaJ0w-1; Wed, 23 Oct 2024 05:13:31 -0400
X-MC-Unique: HGcEaVePPASp9lSqLYaJ0w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so48826095e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 02:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729674810; x=1730279610;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZZzrh+5FfDXV5sKPgomJ5a/uS2HEWOMtpN8RzoyxTI=;
 b=VMD/12RYO/dajgbv1kNqy3nrTAboNCESmoeqruSqMI9DPWIZ0mWh9RBlVN82PltvmD
 AXQX6ejqzjEVhiV319QX1xwXP7F1CYA832V91VCCMPsCkwgLYd10Y5eefzmRnAxAxi0L
 NALLLoGofaW20zZ6qIpaH12ktD9UBbROAKM7ublQd/ZH9n9wPuPlJ93PC7Soauk4MmNj
 JRYf91XPA/NMUO4GuHuncc8stGjdq+VuyVIxuV05gX/eVrRi447dzXxncUtHL2KDkzUD
 VYW+0dPWs1SzZuRHOwRhMj/FJ/4ppCakun2y6nDWwCbM1tPhDBnBR9hn8OY9oeeF5FUC
 Hp2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDrj6eLUyH6tc1y9KmGCQyL2bJqfvyiXOXwowSvrIOl9Gj0PZx4/TH6CrQ7GDlyHvfgrOQI5X0bY59@nongnu.org
X-Gm-Message-State: AOJu0YyRf4OkgK01vUj0OAiahsp7R99dj8IKiNA0EfQuUfdvnCKbGrKz
 6gyZZod/wMRnHVPkiy5ZfGAtXsgJDt8RThIFsKyIIUxNUIDx9qDLU76mBu9hnw3YaRXDb/naJIC
 s1Yh/7o38PWJKNFjLM5A9XzbL8hiv2ViMlFqGqNTp7GXiIdMuDHbq
X-Received: by 2002:a05:600c:4747:b0:431:588a:44a2 with SMTP id
 5b1f17b1804b1-4318414a572mr17359655e9.12.1729674809918; 
 Wed, 23 Oct 2024 02:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcTp3ptQtLiSONPQTF/d70ne2sbArasLjLhU58vVkkri+Hlo3raDR41MG0b+nI2Jgyu3vbGQ==
X-Received: by 2002:a05:600c:4747:b0:431:588a:44a2 with SMTP id
 5b1f17b1804b1-4318414a572mr17359435e9.12.1729674809494; 
 Wed, 23 Oct 2024 02:13:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a48564sm8460152f8f.29.2024.10.23.02.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 02:13:28 -0700 (PDT)
Message-ID: <c2659817-d35a-4353-a57c-e29738747278@redhat.com>
Date: Wed, 23 Oct 2024 11:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/helpers: Refactor vfio_region_mmap() error
 handling
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
 <20241022200830.4129598-2-alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241022200830.4129598-2-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/22/24 22:08, Alex Williamson wrote:
> Move error handling code to the end of the function so that it can more
> easily be shared by new mmap failure conditions.  No functional change
> intended.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/helpers.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index ea15c79db0a3..b9e606e364a2 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -395,7 +395,7 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
>   
>   int vfio_region_mmap(VFIORegion *region)
>   {
> -    int i, prot = 0;
> +    int i, ret, prot = 0;
>       char *name;
>   
>       if (!region->mem) {
> @@ -411,22 +411,8 @@ int vfio_region_mmap(VFIORegion *region)
>                                        region->fd_offset +
>                                        region->mmaps[i].offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {
> -            int ret = -errno;
> -
> -            trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
> -                                         region->fd_offset +
> -                                         region->mmaps[i].offset,
> -                                         region->fd_offset +
> -                                         region->mmaps[i].offset +
> -                                         region->mmaps[i].size - 1, ret);
> -
> -            region->mmaps[i].mmap = NULL;
> -
> -            for (i--; i >= 0; i--) {
> -                vfio_subregion_unmap(region, i);
> -            }
> -
> -            return ret;
> +            ret = -errno;
> +            goto no_mmap;
>           }
>   
>           name = g_strdup_printf("%s mmaps[%d]",
> @@ -446,6 +432,20 @@ int vfio_region_mmap(VFIORegion *region)
>       }
>   
>       return 0;
> +
> +no_mmap:
> +    trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
> +                                 region->fd_offset + region->mmaps[i].offset,
> +                                 region->fd_offset + region->mmaps[i].offset +
> +                                 region->mmaps[i].size - 1, ret);
> +
> +    region->mmaps[i].mmap = NULL;
> +
> +    for (i--; i >= 0; i--) {
> +        vfio_subregion_unmap(region, i);
> +    }
> +
> +    return ret;
>   }
>   
>   void vfio_region_unmap(VFIORegion *region)


