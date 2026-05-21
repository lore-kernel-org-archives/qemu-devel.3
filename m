Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42157CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0Z2-0006Um-8S; Thu, 21 May 2026 06:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wQ0Z0-0006TU-QC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wQ0Yz-0001HD-Dn
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779359016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k+xSzXWseQ9yRRLcCKhpr4nOn7wn+Mk1lFBxVvUtJsI=;
 b=hVBNU9vSgiFxkNcx3fRzA44jxr8yD/Cy6OneaLxF7GK5tsWZc7LWiWL34U2iKyQIrZIQ52
 m04hIotCkEOlSJQ8aeYCbCVvQq9kgIvgYKKIbmCgwgiRBQHXPydl5mD/fkDZXX8PRk/is+
 EbNmM6ftWMlZY7FXP6oez2GJkUXUwhI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-rfsHyVEwNDeB4rj5f7agjQ-1; Thu, 21 May 2026 06:23:33 -0400
X-MC-Unique: rfsHyVEwNDeB4rj5f7agjQ-1
X-Mimecast-MFC-AGG-ID: rfsHyVEwNDeB4rj5f7agjQ_1779359012
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4518f777225so4549560f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779359012; x=1779963812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=k+xSzXWseQ9yRRLcCKhpr4nOn7wn+Mk1lFBxVvUtJsI=;
 b=Bn4m4WPz9zvGBpmAmLInZ7XRrHOSl8+mtg5Td9RThOyL1FaBzeaaA/xiAWnazMzseA
 iv433RlUD68K0lyZlP7YzkWdm/3+9PyJMXBO9MwgCtPsccURGkgWkZT2BagIiQm/UJG4
 PwK57RZdarC3AHh9WodxttrDfv5x1Tv83vITmGgwHkXs3qMwEFb1Y+q3I2maHoVjRO1F
 MmAa2OJzYQkvdo3LppMG5Nzg+1RBdiqZ6zKlWKkNmZive/oDRjjLMWKnniuiaV6UJdgH
 rz0/uFOKAhvuSwVofXTBNFXjrbcKGtglxO6TeZgT/ZLYLOVGWnWOrDdpxEOwnp1RtB52
 2dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779359012; x=1779963812;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+xSzXWseQ9yRRLcCKhpr4nOn7wn+Mk1lFBxVvUtJsI=;
 b=EGJGxIlQz0W+5kSHMYacTTWZk7spwJzu2dMqVXKUcaMOL8eBIxJeScS/GX6R1nDl2A
 cvc3PowytyEiW5KBP/SeTbvkdvYoWOeH7AmMbWcWhVSsC/StX+htkE1cWFavldTnIlQN
 fJniXZJXlGMvFJTuesr66M0gHrZpE1+1EOr3R73q9TwVkPojLuvDX1S9B4VmfTTH/qLa
 LOrTPn0TRiqDcxTpJa/Bl+8l9y6ur21r3oMd0AtmoqxPiBGihhhMlv+mluVHJUKOOCR3
 GKJtfWWDuVqqZzGh83vlFx5egNZfGD/gp4fV9nFJPzxSnxOS3dPeYPdVS8yNfuHx9tED
 GkoA==
X-Gm-Message-State: AOJu0YwHdS+q1eMMbGnhYW9wHH+OYvk0Qb0EN7Bhl8WESjq798ZDvLn1
 wiiHbQDuF8Kmt/VxjRQvY5X05kTOvLeAg9mYLmZB07K7vE/xYXgTozHUCAAR8toYtGBcQlmvTDR
 MQgH5ja/IIGc+7yinnnhzVdlPXbd2s0b4zN8w3tEoCAAn6UINKXnhV3RN
X-Gm-Gg: Acq92OFEDI68/ISyqNDCNuT4bR25cUe3wYz2DDbpwClxK0Q7qX03J6hO23tuWWUyxq5
 zcIo12rKznYwxx0nW6ZabIX1ZmC5QbXdtUOHbjwqPTkdIY7rAhFghpcN389jabzoQ3p+dat3lmg
 HaIthqBdZUdYtEt0HFwen/p5R5ZN3RIvRGM4Nup8HxFIlxOHmsRHskY13C30sHjto7pILUyVm8E
 HCXvaPU5yRHFNFtQedlzY7UzV6l/OVB2C1fKd5+FgZjuS3/9jL3IsZrC2KUlzuB3iXTAlqYSt+e
 ffxqnsj5O88UezTaDXUEjYHuSec4vJHJCjM/E1zk96Z49C/3LvQ/Jwnt651p62NlxkGoTCKthgQ
 cAbn6/gHTSjVx8BAp2zAW7PyfSZPvGxGDgRWThSN5vKJOk9e6huaZ0ad+XDta
X-Received: by 2002:a05:6000:22c2:b0:44f:d9f8:c0e7 with SMTP id
 ffacd0b85a97d-45ea36b42admr3771748f8f.5.1779359012488; 
 Thu, 21 May 2026 03:23:32 -0700 (PDT)
X-Received: by 2002:a05:6000:22c2:b0:44f:d9f8:c0e7 with SMTP id
 ffacd0b85a97d-45ea36b42admr3771710f8f.5.1779359012074; 
 Thu, 21 May 2026 03:23:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa756d61sm1820283f8f.0.2026.05.21.03.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 03:23:31 -0700 (PDT)
Message-ID: <39b66e7c-7b2b-48e0-bbe9-c52b2ab3f9a5@redhat.com>
Date: Thu, 21 May 2026 12:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Clean up vfio_region_unmap()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org
References: <20260519063540.1117808-1-xiaoyao.li@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260519063540.1117808-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/19/26 08:35, Xiaoyao Li wrote:
> Since commit 7429aebe1cff ("vfio/migration: Remove VFIO migration
> protocol v1"), vfio_region_unmap() lost all its callers.
> 
> Remove unused vfio_region_unmap().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/region.c      | 15 ---------------
>   hw/vfio/vfio-region.h |  1 -
>   2 files changed, 16 deletions(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 0342ca712acd..dbde33918026 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -468,21 +468,6 @@ no_mmap:
>       return ret;
>   }
>   
> -void vfio_region_unmap(VFIORegion *region)
> -{
> -    int i;
> -
> -    if (!region->mem) {
> -        return;
> -    }
> -
> -    for (i = 0; i < region->nr_mmaps; i++) {
> -        if (region->mmaps[i].mmap) {
> -            vfio_subregion_unmap(region, i);
> -        }
> -    }
> -}
> -
>   void vfio_region_exit(VFIORegion *region)
>   {
>       int i;
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index 9b21d4ee5ba1..58b236f1133e 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -41,7 +41,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                         int index, const char *name, Error **errp);
>   int vfio_region_mmap(VFIORegion *region);
>   void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
> -void vfio_region_unmap(VFIORegion *region);
>   void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   


