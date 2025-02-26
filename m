Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E9C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCdX-0008EU-Ge; Wed, 26 Feb 2025 03:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCdT-0008E6-73
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCdR-0002W1-HZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740557956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qkrAFL3CpS47TqGfQWk9ngn80Wj/eKFgHYUapCsKxrQ=;
 b=UzBDwKlo9ntT4RP4CSQ5t7AKIGj5Y6ux7t4ganOB7o9WBmkvRUFI3BgrwP5+TuGeMgkv+L
 irZnS+4g9T/q8/bbIYe6F/0u0QOEPCSUBoMKSf+3jFzXlYQT6rvsPG2P1V612xNqJJ8wMi
 GPwq+biJs9CZ8tjAL+7n5EJ8xNCMWFc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-7x7FzDvmN9qGGNcG1XKKJQ-1; Wed, 26 Feb 2025 03:19:14 -0500
X-MC-Unique: 7x7FzDvmN9qGGNcG1XKKJQ-1
X-Mimecast-MFC-AGG-ID: 7x7FzDvmN9qGGNcG1XKKJQ_1740557954
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394c489babso35139625e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740557954; x=1741162754;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkrAFL3CpS47TqGfQWk9ngn80Wj/eKFgHYUapCsKxrQ=;
 b=kmcd/HXpZUBrdZ6cqkvmZgFv8mk8xEgxMW07KdJ1g2a9F3jQUUEq/F9BHME6dKOsbF
 iqc12tiJwsrhbRVc95HJ1M/bdtnCk3/YPAcLVXzC1GwHdKAjY/puFO9ZbRYFQqOB1Jni
 UQ+YiVgyIKshf96TWmlwi79gOa85+HI8aRdEr7ae1sfgHdDD4bCF1hVCpens+kzZZ2GX
 qzzihdHuORN9da6lMQVDxXKRD5Faze4sEqdn+XwbPXmtGY7E0otgy8D0/zhte2yVtL6M
 wjrmV74m7GTsBrHMtm7Rjgnh1uauJnbAYhESbKARkjewgOk28PZQps7piMlQfnpMHBk7
 g5Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3WyhuLp9xWCQSLlQjhejU2bEheFyDG0VD8F086ucaVogUpKCBfRoEzIhfhLVgv/EJ4wk/EPe+GSwT@nongnu.org
X-Gm-Message-State: AOJu0YzzX8n+/wbHK04Nx5SU3FMAClqhAFHcuTUOHdFLoKQmQEnoBfdB
 63+WhaOvtVt+OsBw5oAf3GDpvBY/joZhhBdNBPInVCvbU9zEK5LFiiOnBmBl7bPMqhuYEYdRNee
 RVCLOXb7YBYdGAn0q9gByQZpI6XQbYUYL4q2ArmDYiEcfFgdHtD/t
X-Gm-Gg: ASbGncsugnfAGBwj8pK8zPFiF3lWi2VZcPsW1Ub9KZokdwGzOBHWNRUZ+iTxG3zq6FJ
 UutajA7RddqXfSBMktiz7ScTybhQBbBHIxwfaJzgZUOib+xrk5gbi/weTKwE99h4Jb/ddxkMdMx
 MwVgQA2dI9vOxZndspsyQwCTprK+xFsxnI9RRJMxEfHuIxcfLvs8Rc428iYUs30ft/zzIdZXP8u
 L/afzCECHrKw6W6Pu52BWasEKC+w8DFQV16aM0yJMnlvn59WTFwLWzsmcPSzNz8doK1ZVUNChhS
 XVyI4qYcdYIJ1HXXp+K41XUMYmpzEsfQqOyn4XQ+D3IP/L9JfNEm+qu6zEs=
X-Received: by 2002:a05:600c:4ecf:b0:439:a1c7:7b27 with SMTP id
 5b1f17b1804b1-43ab0f28895mr45900305e9.1.1740557953765; 
 Wed, 26 Feb 2025 00:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYgZ/8+ymJOYqho8SjcIbTwmAygFX+YnXh5NEcgR+50eyfp4p7hau1jyI86IJ8uEYGwE7qqQ==
X-Received: by 2002:a05:600c:4ecf:b0:439:a1c7:7b27 with SMTP id
 5b1f17b1804b1-43ab0f28895mr45900095e9.1.1740557953416; 
 Wed, 26 Feb 2025 00:19:13 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e70a7sm4649657f8f.77.2025.02.26.00.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:19:12 -0800 (PST)
Message-ID: <dc07772a-8c79-45a8-ba7f-d537e1319829@redhat.com>
Date: Wed, 26 Feb 2025 09:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/36] vfio/migration: Move migration channel flags to
 vfio-common.h header file
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <fefebe82e9be5b1c281a40ea7e2cd86eda064942.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <fefebe82e9be5b1c281a40ea7e2cd86eda064942.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This way they can also be referenced in other translation
> units than migration.c.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration.c           | 17 -----------------
>   include/hw/vfio/vfio-common.h | 17 +++++++++++++++++
>   2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e9645cb9d088..46adb798352f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -31,23 +31,6 @@
>   #include "trace.h"
>   #include "hw/hw.h"
>   
> -/*
> - * Flags to be used as unique delimiters for VFIO devices in the migration
> - * stream. These flags are composed as:
> - * 0xffffffff => MSB 32-bit all 1s
> - * 0xef10     => Magic ID, represents emulated (virtual) function IO
> - * 0x0000     => 16-bits reserved for flags
> - *
> - * The beginning of state information is marked by _DEV_CONFIG_STATE,
> - * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
> - * certain state information is marked by _END_OF_STATE.
> - */
> -#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> -#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> -#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> -#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> -#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> -
>   /*
>    * This is an arbitrary size based on migration of mlx5 devices, where typically
>    * total device migration size is on the order of 100s of MB. Testing with
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 70f2a1891ed1..64ee3b1a2547 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -36,6 +36,23 @@
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> +/*
> + * Flags to be used as unique delimiters for VFIO devices in the migration
> + * stream. These flags are composed as:
> + * 0xffffffff => MSB 32-bit all 1s
> + * 0xef10     => Magic ID, represents emulated (virtual) function IO
> + * 0x0000     => 16-bits reserved for flags
> + *
> + * The beginning of state information is marked by _DEV_CONFIG_STATE,
> + * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
> + * certain state information is marked by _END_OF_STATE.
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> +
>   enum {
>       VFIO_DEVICE_TYPE_PCI = 0,
>       VFIO_DEVICE_TYPE_PLATFORM = 1,
> 


