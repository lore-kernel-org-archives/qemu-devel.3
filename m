Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A44C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhnf-000280-Gs; Fri, 17 Jul 2026 08:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wkhnb-00025Y-V7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wkhnZ-0000ob-1j
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784291772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y6NuUY2yoajIq6Jem7NgNyXTkJYgCTjXPYkiC5jy2dg=;
 b=Z9oIY2MpiL53Ms/RU/GuLRgCT+2fKFRANPEf2PWl9sRNumXWQK6ACqR3ZdlgW17HfesQMR
 x/673e00IMe+e0lp7n+1oTfYIxerZr3Lx/yTCHxBsxMyCAFlPbIU3toFjTnTUBFRzM4GeB
 k11mVp0TCOHjKbfa80nEz/tjx8uqs+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-bT2fJiQgPYawUf7wcG2OSg-1; Fri, 17 Jul 2026 08:36:10 -0400
X-MC-Unique: bT2fJiQgPYawUf7wcG2OSg-1
X-Mimecast-MFC-AGG-ID: bT2fJiQgPYawUf7wcG2OSg_1784291769
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47345535410so7613725f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784291769; x=1784896569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y6NuUY2yoajIq6Jem7NgNyXTkJYgCTjXPYkiC5jy2dg=;
 b=aNacLr8MIRQsjbPaZApyG3a0ka4EoHiX9J5p/XXVriyLazAm9Uzq6wR61d23XGINcB
 bZWUtAciZFgqAnnBB4An1m928ZXOdrMaQsL+P18JHY7VZRrv1nCcr/pMEl//ub5Ls/7+
 eYROJSD6wlYdB6Jxd4eIsf7IA8sBWcWT0AtzeZ7+xAInz4SuxK6+KKx3anefYjPGYSeT
 M1TbVfi3tpSXEgsvtHcLnS7XwRgvok0JFCr73r55tghWxr7kdRPh08eMrdU9qab2rUEb
 4o73ArIczfFJZh8W1BRV3n/qXGaddLsjP+jd+nojm9wvRWeMgFGY/jic6n2+ekQnslET
 prUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291769; x=1784896569;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y6NuUY2yoajIq6Jem7NgNyXTkJYgCTjXPYkiC5jy2dg=;
 b=PbJ5DEXTnAwVDWCNz6m7cBj7D17u+lyVsipHDCVUC19v+CopwRIzjQkPAxXxmY8iv9
 rkiwt4PC8Zq7B9Bed6uacWQK0+H6BuSUhwDrsy3DL6Fo3oNDmOcjVwgud0ptVXGZar2Z
 wYY4bn5XyzxwlLGKDeMdMy53SgvAFXFD+Osn7SnxZa0in7sekKhIlTPvXbcqdDEnoBIO
 l465vNWxR4CwMNBi68DgF0do9cbkdeoOAe7t6hZHsXTa68D9URTldnC9OVTWvXDJJ7bD
 D3IkkNH3gZ4t6rhlyJaSQoBA7jYq3NWwZPFki7u8juDZ/G2cAaqVgBa6Mgw2B/84C6H8
 0/YQ==
X-Gm-Message-State: AOJu0YxoircUIIuhKEZU5BD1pk3qcZUqN0fIzukfjvuSZD5txww52mT7
 tkWwN84eDMxIf2/hWRdYlwv/3walRkl5Ar4+k/nlWllEWXBLQBiNmmxihgK1myPFw1cKxKvBJiJ
 TWNuGPKTpj8tVts3fk0Nmw2WAxzrRbRWUimt+LsNYgvr9mZSUiXHSrDydbHavtY18a4BxruXWNn
 lUpGgIY9vkk48vqiwBWDbBGw2/PKvT1Nn2Ag==
X-Gm-Gg: AfdE7cl0plTEgWy8p6ZdBv5a8fOg4/Y3PtwXdPDhkzWEQtIeWvl0W6JFkCFbx18hZpc
 4+B5hTYp1KqTVdes0shxmUNRCHo2fH8+IubST0LEorLLPwCdO1PVu2AcaQH3j/QN4iQYs7H5nsV
 pBftt5cSpVz4fbBAyGo7XQml1VJ/tP4ovElNwgUIjOS68MXNucvZ6ULYkBQwvfEK9O3wfWv2ltL
 A6qg8Vpoxz+b8REVRUNF+YQZanEHW+upmQH7wFBKqK3naubjMKfms5lIpJn2hqMOYqecjE2EaoJ
 P7l9Pn3+zaIe9SftWkI60wtbOQAeHyl3A1ZipajdAqJwUAxFtK1vPe25CXq6SU+nOyG7B/KyBp3
 ptoji4znXU3kib15RL2JtoSSFBseFh7iEzJ1Z33M=
X-Received: by 2002:a05:6000:18a3:b0:47d:f02a:99c8 with SMTP id
 ffacd0b85a97d-47f62316577mr3616426f8f.23.1784291769202; 
 Fri, 17 Jul 2026 05:36:09 -0700 (PDT)
X-Received: by 2002:a05:6000:18a3:b0:47d:f02a:99c8 with SMTP id
 ffacd0b85a97d-47f62316577mr3616369f8f.23.1784291768552; 
 Fri, 17 Jul 2026 05:36:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eea8afsm3744472f8f.33.2026.07.17.05.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 05:36:08 -0700 (PDT)
Message-ID: <6689baff-331a-47ef-abc5-de0be217b812@redhat.com>
Date: Fri, 17 Jul 2026 14:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/region: Clarify dma-buf failure messages
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260715070622.198400-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260715070622.198400-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/15/26 09:06, Cédric Le Goater wrote:
> The dma-buf failure messages in vfio_region_create_dma_buf() say "PCI
> BAR IOMMU mappings may fail", which suggests the BAR is broken. In
> practice, only P2P DMA is affected -- normal passthrough uses the mmap
> fallback.
> 
> Reword both messages to mention P2P DMA explicitly and clarify that
> the mmap fallback is in use. Use warn_report_err_once() at the call
> site so per-BAR repetition on mdev devices is suppressed.
> 
> Fixes: dcf1b77e834d ("hw/vfio/region: Create dmabuf for PCI BAR per region")
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/region.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index dbde3391802691888ca31d5e329aba5ba680feb4..54ad11a6c8ed8e04fa365262ccb8bd694bdb45f7 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -321,13 +321,12 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
>       ret = vfio_device_get_feature(vbasedev, feature);
>       if (ret < 0) {
>           if (ret == -ENOTTY) {
> -            warn_report_once("VFIO dma-buf not supported in kernel: "
> -                             "PCI BAR IOMMU mappings may fail");
> +            warn_report_once("VFIO dma-buf not supported in kernel, "
> +                             "using mmap fallback, P2P DMA will not work");
>               return true;
>           }
> -        /* P2P DMA or exposing device memory use cases are not supported. */
> -        error_setg_errno(errp, -ret, "%s: failed to create dma-buf: "
> -                         "PCI BAR IOMMU mappings may fail",
> +        error_setg_errno(errp, -ret, "%s: dma-buf unavailable, "
> +                         "using mmap fallback, P2P DMA will not work",
>                            memory_region_name(region->mem));
>           return false;
>       }
> @@ -448,7 +447,7 @@ int vfio_region_mmap(VFIORegion *region)
>       }
>   
>       if (!vfio_region_create_dma_buf(region, &local_err)) {
> -        error_report_err(local_err);
> +        warn_report_err_once(local_err);
>       }
>   
>       return 0;

Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


