Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FA0D43FEC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 08:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCwyH-0007NC-7M; Mon, 18 Nov 2024 03:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tCwxz-0007MT-TA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:18:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tCwxw-0001se-Cs
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731917911;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbyfFJ0O6zR9shsuQWIOj4nM97sb1IVrNMN4Ro63CWA=;
 b=KfdrhTctG02iZ7G+2BNJTnc5IN3BLERUr9O9FuKfYg9vcasNtVOY1gqGAced2oQQYR/c5Y
 /gbdJiHRIsc45BVu6L7h4JTWLOhFKpGBetPT6hKsoIjZPdak6MpYrSfcSRGijEkhZE/5qn
 h7jRWerdu4PjQZ/aYg11atvnHGwwUWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-dYh4XP_nPNqWkp4tnRHDOw-1; Mon, 18 Nov 2024 03:18:29 -0500
X-MC-Unique: dYh4XP_nPNqWkp4tnRHDOw-1
X-Mimecast-MFC-AGG-ID: dYh4XP_nPNqWkp4tnRHDOw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f023f55so26947575e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 00:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731917908; x=1732522708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbyfFJ0O6zR9shsuQWIOj4nM97sb1IVrNMN4Ro63CWA=;
 b=HViH15EdPkniV3n59O9My0zCyOgCsHYQjG3fAbNd8WyBPxc/BO7dKFnF/4YXfuhJmN
 1e8tNVSgScLcYjZOMUd6sQEobal3ZfTGXlmO++UIee6L3MDuwVHd9QnXUKxYAjNitvmo
 etaDPr556Iu5NBQI8DhTsT8sN39yAAXVkZfyEuBkUaeEuBRbTc9z2udI5DrUxBr3o0d9
 7N7OrPuXSIMDrsGAi8ZBj8BMMvdstwX/4wAwySZ89rUJ5SGPa0IyW9clNYhm4W6oV5n9
 +RcLwYDrNHD6UAIWmJZN0hHQfv5hTdSbh16ILWqbv+4AWBTYac3femR4/9DXYM0qQ/VD
 Ft5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1iuRVtSsX0OZy/Qbs2NGmpevHfE8z2927p5HDKmi2n+xTAsf/qBgmwVmeCXrQLrWxjL6qSObXHKan@nongnu.org
X-Gm-Message-State: AOJu0YxHCTI0xQrBFokyS4O9zfSFJ4CX8dBJCrMAOoavOrhZld7XzY+Y
 kBR+i1qIYCUYj6ZQST5lCsZyJRb2jj2nU8xp9ZAkJJXpqTCZTeWLbMSoLf117roX1eQr/X9t0Nj
 MZ66XRnxhxSW8z0olb8+Whzw+gJHTfAECt8POjRfYzkB7L/2QimMr
X-Received: by 2002:a05:600c:a06:b0:431:55bf:feb with SMTP id
 5b1f17b1804b1-432df78c3f6mr96493765e9.25.1731917908112; 
 Mon, 18 Nov 2024 00:18:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxxRA3kNuHQ53ESWk9kTs7fAqwQn47bnTcp/dxTV4jYMeqDmD9pAeRzlOcGYiN/4fmLvFO4g==
X-Received: by 2002:a05:600c:a06:b0:431:55bf:feb with SMTP id
 5b1f17b1804b1-432df78c3f6mr96493565e9.25.1731917907788; 
 Mon, 18 Nov 2024 00:18:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28b76fsm152537365e9.28.2024.11.18.00.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 00:18:26 -0800 (PST)
Message-ID: <84e7211a-82c3-4992-9320-eb50ffd025e9@redhat.com>
Date: Mon, 18 Nov 2024 09:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/container: Fix container object destruction
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20241115083440.2236669-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241115083440.2236669-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,

On 11/15/24 09:34, Cédric Le Goater wrote:
> When commit 96b7af4388b3 intoduced a .instance_finalize() handler,
> it did not take into account that the container was not necessarily
> inserted into the container list of the address space. Hence, if
> the container object is destroyed, by calling object_unref() for
> example, before vfio_address_space_insert() is called, QEMU may
> crash when removing the container from the list as done in
> vfio_container_instance_finalize(). This was seen with an SEV-SNP
> guest for which discarding of RAM fails.
>
> To resolve this issue, use the safe version of QLIST_REMOVE().
>
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Fixes: 96b7af4388b3 ("vfio/container: Move vfio_container_destroy() to an instance_finalize() handler")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>
>  Changes in v2:
>
>  - use the safe version of QLIST_REMOVE() instead of calling
>    vfio_address_space_insert() earlier.
>
>  hw/vfio/container-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 809b15767425a48f2404b08fc409ee5684af2094..6f86c37d971ec38426dacd471bca837c0d0df806 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -103,7 +103,7 @@ static void vfio_container_instance_finalize(Object *obj)
>      VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
>      VFIOGuestIOMMU *giommu, *tmp;
>  
> -    QLIST_REMOVE(bcontainer, next);
> +    QLIST_SAFE_REMOVE(bcontainer, next);
>  
>      QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
>          memory_region_unregister_iommu_notifier(


