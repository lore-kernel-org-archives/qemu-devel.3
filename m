Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7EEC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpk9E-0001pk-HR; Wed, 05 Mar 2025 03:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpk90-0001nR-3G
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpk8x-0007u5-Ma
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741163418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AQoiaLfcbYSYwL7Qy6FoNGZorxxZ1RizsWGFrg9fNNU=;
 b=BDFi3bJuCJpzJRukND+tUoFiNcYfletN/vm1R90ILUxvCMCGxCkgLh0opuSaJZ5oNINXX0
 pa02ZEJQJMh4Hdo4bXEA0Y4K75mjrPuf8Dif89UlAYWZ3Q2arZBTXPe//pPAcWyJm6ASpk
 IoRT7MJqbIKM3cujFaXM0nS3ZGldBKU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-wMzKtkc_ORKDWyUgK6qc-A-1; Wed, 05 Mar 2025 03:30:15 -0500
X-MC-Unique: wMzKtkc_ORKDWyUgK6qc-A-1
X-Mimecast-MFC-AGG-ID: wMzKtkc_ORKDWyUgK6qc-A_1741163414
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bcde3f887so9837745e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741163414; x=1741768214;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQoiaLfcbYSYwL7Qy6FoNGZorxxZ1RizsWGFrg9fNNU=;
 b=i5dKFp8gZ/qmcn0+u83ZRprwfy3fifJjzTdl1pRsC3ei0Op+woTT9mKt1BA6fO+Wmv
 axacOMfUWiqNuv5DVmbmEXtVpPRtdk5dZj1Xs5cOUqVQv9RO5Y43dR9MEA3DZqVhHkTA
 x2ESOPBoK88KcMJPISQOmlc6ZZ/9oe/UqKDvUlBDmQZUCZm0FO7kq28NjjWptJSZ76Eg
 EJLxy/oVMrKd6k5gHUgkGEO4ZK/gKapCoVILATx3nKTjjAqADQPZdmV/LEp1U7uxs9wC
 wV2TzmMd5Q/GBC0EH/8oFCeliFTKU8QTSXPJH196U50TbZn3NgpA0gKBbA5jiun5YKNG
 GpUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFLE5KB0Rmf1fSfBAh0Ono0093DbIlSeqxww1dEYFbrfzT57hepIBchNY4yRT7eJ4G7l7uH5nQex/h@nongnu.org
X-Gm-Message-State: AOJu0Ywj2C7CXtZjC2y7f9NVxmD29Q97Ng1Udr2ZBqus/RckJ1ANZJLI
 XXmBMn3Jd/1/d4f0COjqEC8MLY6kg3S/cBlXMtLWsmv0zNPCgo1Qovr07By3siqEKTIcmFMXdGA
 65RQdWh0KVqNEqSo/JN+8R/IaqCTYpK0vSxAjjr0udFCSsXooVony
X-Gm-Gg: ASbGncshztbXaiEEUfZkmVC/myXExdzGKp/x/QUemOg5gFqUChbgjTvECgLFXi9ZG6b
 VqMixirK7rMtPYOuO7K/bCJdeirpUyeMh9ntGHHsjtWz9bjQqCct4EPZfdP0V1CnOI+RfixLCaE
 h2nVSWp91HrZ4ua9X1tY6Y3HafcDluNoot2zRbvv38rg9tdQiG61xeiSIsm7DoN4oUxA7QN/1X2
 6cOGBoMkUI7C1kMrnacEZkgmGca/SMYp5vPOVk7oDShH8hhUJU2b2osu7zSQpRcNq1i8W5E5biA
 Ne71Xa1V+0E3GLI4gQKOEsF9XmW0yOkvkN7eiFKsW6xu65l5Q3BDqQ==
X-Received: by 2002:a05:600c:1c81:b0:439:84f8:60d7 with SMTP id
 5b1f17b1804b1-43bd29806a4mr15792865e9.10.1741163414196; 
 Wed, 05 Mar 2025 00:30:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpJRDVzxn9Hf/+JWastbXCtPtsdx8F/10sF1FqS3nIkMsFNVllKi2oeXzrnqwUSlRo4nKxPw==
X-Received: by 2002:a05:600c:1c81:b0:439:84f8:60d7 with SMTP id
 5b1f17b1804b1-43bd29806a4mr15792485e9.10.1741163413825; 
 Wed, 05 Mar 2025 00:30:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcbcbfb2asm24596425e9.0.2025.03.05.00.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:30:13 -0800 (PST)
Message-ID: <d1149c6f-546f-4b33-8c2c-d6b669be2348@redhat.com>
Date: Wed, 5 Mar 2025 09:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/36] vfio/migration: Setup and cleanup multifd
 transfer in these general methods
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <b1f864a65fafd4fdab1f89230df52e46ae41f2ac.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b1f864a65fafd4fdab1f89230df52e46ae41f2ac.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Wire VFIO multifd transfer specific setup and cleanup functions into
> general VFIO load/save setup and cleanup methods.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index dc1fe4e717a4..3c8286ae6230 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -453,6 +453,10 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>       int ret;
>   
> +    if (!vfio_multifd_setup(vbasedev, false, errp)) {
> +        return -EINVAL;
> +    }
> +
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>   
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> @@ -509,6 +513,9 @@ static void vfio_save_cleanup(void *opaque)
>       Error *local_err = NULL;
>       int ret;
>   
> +    /* Currently a NOP, done for symmetry with load_cleanup() */
> +    vfio_multifd_cleanup(vbasedev);
> +
>       /*
>        * Changing device state from STOP_COPY to STOP can take time. Do it here,
>        * after migration has completed, so it won't increase downtime.
> @@ -674,15 +681,28 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
>   
> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                    vbasedev->migration->device_state, errp);
> +    if (!vfio_multifd_setup(vbasedev, true, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> +                                   migration->device_state, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
>   }
>   
>   static int vfio_load_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>   
> +    vfio_multifd_cleanup(vbasedev);
> +
>       vfio_migration_cleanup(vbasedev);
>       trace_vfio_load_cleanup(vbasedev->name);
>   
> 


