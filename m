Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C1EC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjQr-00024B-Cw; Wed, 05 Mar 2025 02:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpjQp-00023y-AZ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpjQn-0006GO-JA
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741160679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yEV0gKxZhIzwOxcU9FlfMaouzjmBMQo+hhJ9nGuxSl8=;
 b=MUGKGtQWfaKtRk2O5Fsu/dN4by+d74h+2nT3ku/g4TnB0VCxF5qvOTzRXjmZCC0q3Jd+PT
 q6FAswg0q5JNM8BLfjlrtbXJ9F1cKAFn6GRRFfo1eD/Trgfw68Dl93V8NkZi+BF4qiJK7Y
 ZPzcHUnHJcv9HzhEHjGgQJ7RpzU04fM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-iOQB3tkWPCqBH2E5ftNW-g-1; Wed, 05 Mar 2025 02:44:32 -0500
X-MC-Unique: iOQB3tkWPCqBH2E5ftNW-g-1
X-Mimecast-MFC-AGG-ID: iOQB3tkWPCqBH2E5ftNW-g_1741160671
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bcd9a46feso6490845e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741160671; x=1741765471;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEV0gKxZhIzwOxcU9FlfMaouzjmBMQo+hhJ9nGuxSl8=;
 b=LpwOwvxTc9Rc9fB7kKQXEIHm3esVSJJ7zySNhZ6r1OoBgFfXGVva+3tQMFm8tW1p4p
 Mp+2MnMTERXyNA1A+YlGcrQ0WfQhK9dDhMLuQrG2Pj2ChuBaZKwtKlfA5id39+JYNRja
 Yv0N4qDBfTyk/M2Nom/x0g6/4Wlgzki1h4/y6yzhm2/ppkjSPjamvmlAJ2AXqeDjljYK
 h1xXVrJ0IR9cEkE6nRKGs9t8xrkAkjsDjEs76wUxsJ5ni9TXMTeC+v54LK0ioJW3CKvE
 PKioZ+hoydrBOlnSXiuLp5Ds10GG0T0llQwqf6JyWYymCdFyfF6oIGwVWfqq/G4LUexw
 fwuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG7JC0ksojyRGknCJuqY8GzAFZ0wT6Flk/MEJlGibvpuujO+bZNb1Q9eRLujOctvgHCMtv1e95yRYq@nongnu.org
X-Gm-Message-State: AOJu0YzZ8NWOfpRGJrsX6aFEIYEbM8HPCZopyi7hZLGp7n/Cc2k3FLLa
 iS2dDWFyPyD8bAu5lLnIJZnf4wD+N2kFphQSTu9KTeZo+Tq4TSSD/S71h+7BjG415sC91FuB+ub
 8UOvnw0A4y0MgxeXjs0wWn1TmuR1WGrZod3yxED1oWerQ1lk7LIBg
X-Gm-Gg: ASbGncsgKhNSG4OxExAdNL8Qjvd70iG+AVNpFFquKKInR2HpEyFjxpQ3IjBcTOq4JQR
 /g8IXwOrGGH4YkEIi+k/83Ksh3Zk95nAk3BH1z6paMibgrnS+uJ8TR+1jUBum3mJwWlsmuW0z9y
 dTIMZ4fkbHP0Mg65Xwnsq8i98PHKUju/o8nDlQvAS8CAqrDYdi7yHQ57wmIyOJWq1a/eniDD8gy
 gfz9v5wqDwITcJgTBklWeyNYL7BJpjsnv9BEEDXglZ8soxXj69uMmAl/Bc7UQE15dJgDbuHExry
 GlQdQjqcflzLVr6LBIs4sTLbaqPtvoM5ddflbJv+OA2T9+FvgxFHKg==
X-Received: by 2002:a05:600c:1e27:b0:43b:c1ac:aeeb with SMTP id
 5b1f17b1804b1-43bd294dd59mr12104355e9.2.1741160671335; 
 Tue, 04 Mar 2025 23:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjfNd3G3sgm2Jzf4CbXNjS8QR3sZLlZhW80+82oXojLAo0msnhcOB1yzsK6zuih14BwempHg==
X-Received: by 2002:a05:600c:1e27:b0:43b:c1ac:aeeb with SMTP id
 5b1f17b1804b1-43bd294dd59mr12104095e9.2.1741160670977; 
 Tue, 04 Mar 2025 23:44:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391212eb81esm1173836f8f.9.2025.03.04.23.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 23:44:30 -0800 (PST)
Message-ID: <67b73250-81e1-4d69-8668-13e26dda2e02@redhat.com>
Date: Wed, 5 Mar 2025 08:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/36] vfio/migration: Add vfio_add_bytes_transferred()
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <d1fbc27ac2417b49892f354ba20f6c6b3f7209f8.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d1fbc27ac2417b49892f354ba20f6c6b3f7209f8.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This way bytes_transferred can also be incremented in other translation
> units than migration.c.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration.c           | 7 ++++++-
>   include/hw/vfio/vfio-common.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 5532787be63b..51c056e152aa 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -391,7 +391,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>       qemu_put_be64(f, data_size);
>       qemu_put_buffer(f, migration->data_buffer, data_size);
> -    qatomic_add(&bytes_transferred, data_size);
> +    vfio_mig_add_bytes_transferred(data_size);
>   
>       trace_vfio_save_block(migration->vbasedev->name, data_size);
>   
> @@ -1021,6 +1021,11 @@ void vfio_reset_bytes_transferred(void)
>       qatomic_set(&bytes_transferred, 0);
>   }
>   
> +void vfio_mig_add_bytes_transferred(unsigned long val)
> +{
> +    qatomic_add(&bytes_transferred, val);
> +}
> +
>   /*
>    * Return true when either migration initialized or blocker registered.
>    * Currently only return false when adding blocker fails which will
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ac35136a1105..5c84ebb00298 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -274,6 +274,7 @@ void vfio_unblock_multiple_devices_migration(void);
>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
>   void vfio_reset_bytes_transferred(void);
> +void vfio_mig_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>   
> 


