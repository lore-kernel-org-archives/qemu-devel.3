Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFD9C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4E1-0004R6-Ii; Wed, 17 Jul 2024 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4Dn-0004M5-2b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4Dk-00080I-60
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721221041;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DU2B3z889cJ1vNbbXbKWWwQ2HNoooeVdo2/nDVmRJvQ=;
 b=FUDa6y5D/+0S8igByTkyKOzzEG/Z1ZJ1ZQpZScmvvNaGZ6nW3Pwj02iaQ8JuV0NEZVO8tC
 O6j6xNvuJ5v8XeyV3F40xgtyxhwIFdpcEKq2DQ8JXgpoksZ7mvxaHwKVIdfhPYv6QME6Uz
 BODi1g3HdfdUTnchnaQhTKvY3yErqWk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-GY4kr_EPOJiWmzbfe_HiHQ-1; Wed, 17 Jul 2024 08:57:20 -0400
X-MC-Unique: GY4kr_EPOJiWmzbfe_HiHQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42794cb8251so44359735e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721221039; x=1721825839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DU2B3z889cJ1vNbbXbKWWwQ2HNoooeVdo2/nDVmRJvQ=;
 b=Ck0BywflMQFPqegGGNvj2hpyjzc2Mx7clLGVtXQ9GJZ6bObMOgEUUfaQ6N41n1HRYl
 vbq2toKfumNFw8i0SmkSAD2E5HSL8eje2JSsIdn2x1zO1nObQgiAtQdj4ONa7/HEz8Me
 gFjk+hjdFK06p2PXTH4AHuH1AXJchhCmN3TIFyqsq6qY8duER2U5zikuoJlA41tQ5PRi
 U3feDEjudiUsyfEs5ukiSVVw/wduCPJK+BKi9kRi/n0tQ1FXZv4Y0GLVcdZrDt8dMaV8
 5r/+B2uFp7TTYY5Sljze2MXa/gvE4c0xi/nVCbb52hpMKA/YRLDdVUl6F1i/AXbacbgs
 G7tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ1loSC6IOzfcLqg3MKmNt9b+uXJ0gk+ES0O179B2lZKMJd6UyQ6xMjmaRLT9oVE6LhJd7qwUnPIOF2ujLpG8jQkPjQmQ=
X-Gm-Message-State: AOJu0Yydr0wl8x2jD8ORfuwVAev4YK6l76GRHjmrMmnv9OJj04xMsrxB
 QhcaJaflw+WqVJ17exSpjOjb937t//vmS8wnDLCcQClaOR4WC6EJ7qLuOkS4ISUPh9q5+R2O0ef
 HiYqCASM/X/jLhlcf30s8WQcZrQBrmZelkIsyuiYmsSnZvUeejoER
X-Received: by 2002:a05:600c:b8d:b0:426:62df:bdf0 with SMTP id
 5b1f17b1804b1-427c2cb0186mr11282365e9.10.1721221038844; 
 Wed, 17 Jul 2024 05:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETD05g3ffEI9fz94XyDdTs8uxVfZmBeuH1fRj8nLo6GeBYiIC+5DZqdEaeMYS6sjmAVmw8Wg==
X-Received: by 2002:a05:600c:b8d:b0:426:62df:bdf0 with SMTP id
 5b1f17b1804b1-427c2cb0186mr11282245e9.10.1721221038537; 
 Wed, 17 Jul 2024 05:57:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23999csm206538305e9.8.2024.07.17.05.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 05:57:17 -0700 (PDT)
Message-ID: <a0bf8925-58fb-4acf-a53f-03b3b3c0494a@redhat.com>
Date: Wed, 17 Jul 2024 14:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-12-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/12/24 13:47, Joao Martins wrote:
> By default VFIO migration is set to auto, which will support live
> migration if the migration capability is set *and* also dirty page
> tracking is supported.
>
> For testing purposes one can force enable without dirty page tracking
> via enable-migration=on, but that option is generally left for testing
> purposes.
>
> So starting with IOMMU dirty tracking it can use to acomodate the lack of
accomodate

Eric
> VF dirty page tracking allowing us to minimize the VF requirements for
> migration and thus enabling migration by default for those too.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  hw/vfio/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 34d4be2ce1b1..ce3d1b6e9a25 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>          return !vfio_block_migration(vbasedev, err, errp);
>      }
>  
> -    if (!vbasedev->dirty_pages_supported) {
> +    if (!vbasedev->dirty_pages_supported &&
> +        !vbasedev->bcontainer->dirty_pages_supported) {
>          if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>              error_setg(&err,
>                         "%s: VFIO device doesn't support device dirty tracking",


