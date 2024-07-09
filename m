Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4430C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4rd-0004rU-0x; Tue, 09 Jul 2024 03:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4rb-0004qS-EE
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4rY-0007TF-HG
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720508527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWwgFjzhD3o3v0lRiHDImtphB5RQTvSbGCO4lUq2HwU=;
 b=ISXWN0y/1GUX7vT+rhRH2s8KH38+DIsHlm5/PgjoiaYwg5K1LjWZoE4Rv8o8RJ1jaAsi1L
 REkUVPNLiQlINW9/HH9pTUNZx3WTHjsGW+X3jiydqG0XZwQd75LMCBR2PEJGqG+eLttyR0
 rSl7Eh791+EtDt+SuHupz9PyQqwZbuU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-bBfkMxQcNV6MiaAcdAYMxw-1; Tue, 09 Jul 2024 03:02:05 -0400
X-MC-Unique: bBfkMxQcNV6MiaAcdAYMxw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265e9de046so19858435e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720508524; x=1721113324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWwgFjzhD3o3v0lRiHDImtphB5RQTvSbGCO4lUq2HwU=;
 b=STZ6IUos2owaR4sNCJxrctaNm0rDOTdYDM1/LK65VvqzZ5cpKDT0+NHBVKDKxGV4J9
 4lPmN9l+Nj1JAlnX2T+H2lEYZvfODf/AqYTbQ3ugEZ0+z9KReaP9VQaoEExGMIu7HcJ6
 cYZBJN25hKtAMHerPOnCYuhklUaiWjt9QatvtBGQVRhHx7oYcIEMYJvhraB4cDMO3PRg
 wPFLk8A9Y9tZ31Hqcx3+tmzFojcphS9YtdOBwyJxRwW7ndXDk14VcHYFV8N4qN5SdCFh
 knBhtwBCbiDdlRQrYIkGJdiYoDyQ9r2XR4+p7ZCxBulG3PexxjIqnt2hMqJ0lozFqgOA
 ogow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe4H2EAzq31oEGO3wHjqzoLQ8x7lhW5d3OoUfGbiB1b5WN3K5nXN3MX4BO9BXqo9dIe+8XMqLZJRvntnquKGZmYpt8z0c=
X-Gm-Message-State: AOJu0YwiMivTwk+qOFsA7edGJC1Yp2uzQXqc4hKu2AEqyqhHajO85aj3
 ttmjK4naZUuwt1HIBrxOUhAHjhqNKSH5kCvRAC8v8xDC81CKHc1BN8OhlEP6++fsPJUHI3Mwr6z
 TMZMXBFHNBn6bIKf9v9ALEklDA79MCRZYpHcdChvMXB1ze++hWlH3
X-Received: by 2002:a7b:cc87:0:b0:426:6379:3b4f with SMTP id
 5b1f17b1804b1-426707f910amr10506685e9.31.1720508524072; 
 Tue, 09 Jul 2024 00:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdN/9Mln6C27gNYImOtAiNoy+lsLDQSAXg6scr7YdGibHISifF6fhdiYBk95JeAnBriYhTkw==
X-Received: by 2002:a7b:cc87:0:b0:426:6379:3b4f with SMTP id
 5b1f17b1804b1-426707f910amr10506535e9.31.1720508523751; 
 Tue, 09 Jul 2024 00:02:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f7420cesm25947985e9.46.2024.07.09.00.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 00:02:03 -0700 (PDT)
Message-ID: <5f6ec773-536d-48f3-8d11-1acefe17abb8@redhat.com>
Date: Tue, 9 Jul 2024 09:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-10-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240708143420.16953-10-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/8/24 4:34 PM, Joao Martins wrote:
> By default VFIO migration is set to auto, which will support live
> migration if the migration capability is set *and* also dirty page
> tracking is supported.
> 
> For testing purposes one can force enable without dirty page tracking
> via enable-migration=on, but that option is generally left for testing
> purposes.
> 
> So starting with IOMMU dirty tracking it can use to acomodate the lack of
> VF dirty page tracking allowing us to minimize the VF requirements for
> migration and thus enabling migration by default for those.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/migration.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 34d4be2ce1b1..89195928666f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1012,6 +1012,7 @@ void vfio_reset_bytes_transferred(void)
>    */
>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(vbasedev->hiod);
>       Error *err = NULL;
>       int ret;
>   
> @@ -1036,7 +1037,10 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
> -    if (!vbasedev->dirty_pages_supported) {
> +    if (!vbasedev->dirty_pages_supported &&
> +        (vbasedev->iommufd &&


I don't think we need to check ->iommufd. The class handler below will
return false for the vfio/legacy backend.

Thanks,

C.



> +         !hiodc->get_cap(vbasedev->hiod,
> +                         HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL))) {
>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>               error_setg(&err,
>                          "%s: VFIO device doesn't support device dirty tracking",


