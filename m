Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC05C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 18:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnLhQ-00080y-FS; Wed, 26 Feb 2025 13:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnLhL-0007vq-2p
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnLhJ-0004oM-LM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740592791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VYT4SPikEOqNkm8egAuZGdlWcXE3XhS/F3+r9b9uDGE=;
 b=aATTfdRjXQUwUMKyMgGHAl8l7Q5vnHjJPRgXoTMiuhMKXkzG/GBeSujZFOdUYwHfgMrRbi
 xi81hB6HU85YE2Y7U6QUbfCG0Ac03TpxTHU8VwKQxwZuF4DJ4uuNbJfnfvPu/1tWdkKXTE
 JqTKN8a+NULRm1CN+ezIWX5Ag3gCvIA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-HkpFTAVfOae9Pfp5AACUEQ-1; Wed, 26 Feb 2025 12:59:50 -0500
X-MC-Unique: HkpFTAVfOae9Pfp5AACUEQ-1
X-Mimecast-MFC-AGG-ID: HkpFTAVfOae9Pfp5AACUEQ_1740592789
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so5248475e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740592789; x=1741197589;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYT4SPikEOqNkm8egAuZGdlWcXE3XhS/F3+r9b9uDGE=;
 b=XiuQbXb3k/ixYlOr8Z7A5GBzuYSxhJxIbVA03cmi1p7Z2V499wFs5tY/qR+/WFjlTy
 LZ3YSULymWj3FsNrICdQs3/hJjMKpyCF9T3oV04ytNz7TCnJlNmmMznBJj5jwk6PFwMO
 9bP3aqcA1McYINgzLGZMeknZtnvBsOUDbjY5Jj9sLRr9unJmpNR1ZnycpPX7tQ4HusqA
 1p8D+mFMJDh2Fi2k6ydfggBeRVJgU7YF0Y7YC79twBkmFgNYfaKri63yoi2yxDyhMzv7
 Xs/6AE4dRMUjkjn+ah4wh4CYD5ifPzCNZILcFWiwGdnSDdip1GUusoLHErX9R/jd54NN
 3lpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN3HosgJ1BX86gD8yqASUK3zYyteBy0oK7qcENbSCD4LhLV1KMeV/QC5rW6aFsP9nk7+BqQM6qis/c@nongnu.org
X-Gm-Message-State: AOJu0Yz+dvAb3iyUuMx+Yq4qn56Avc7IKZICEAIcyOwpeHP/nBnJ76Hw
 NmdM1orLZqCDEDVayaFrQwNHezuKX3/UhfXQdsq0fys3RyZpHCHn9v6e9ahKAloSStvLQOIDnu7
 SWSoY7pW6eELyoyVUV3+rjWUDihesiD/PyoVzd64SZc8ImaSBVkec
X-Gm-Gg: ASbGnct5q34rkO3lo+M6lxF7ZVLK4iTi6e+Urba8kAYyNpkMQ3HQPcV5HwIzLL2Z7xg
 Xw5AvRbTx9JgYJ4YhjIVzQjyEd7yln5s5EYf1GQ5DzaK9SABC3p5lCHioCC+QXEJlZowhW7jGpe
 qChgAN1MTryp43az1hIKUlF61yRp/CcH64PQzfunVXHVVzKy/ppE5MTZb0vhicG+S/YuOrlPbJq
 vqpHj+9UoS6D8iBKj12+kyie0aygvzSRZ9aUeZnDieWvS4BQJvgKcKczdNQIrGCVgijcBd2OdGy
 W+pexWPSYeHlqjzcmbpmsB9ZMn02l489xbbk0+m6/uggo0qOy34rk2QxodQ=
X-Received: by 2002:a05:600c:1552:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-43afddcb3e2mr2841135e9.8.1740592788953; 
 Wed, 26 Feb 2025 09:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSmgjPFjUUSD/kFJcaARC8sPk0PJqJCEznTVeg8xMxQQfnVOQ3boUaDE7DCoV0ycYoCANfMQ==
X-Received: by 2002:a05:600c:1552:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-43afddcb3e2mr2840985e9.8.1740592788651; 
 Wed, 26 Feb 2025 09:59:48 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86cc31sm6536343f8f.38.2025.02.26.09.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:59:48 -0800 (PST)
Message-ID: <2c59be25-860d-4bac-aa8d-3068b12b6cb8@redhat.com>
Date: Wed, 26 Feb 2025 18:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 33/36] hw/core/machine: Add compat for
 x-migration-multifd-transfer VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <57d0b587299e27bd022ee2a04660a44868f5be06.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <57d0b587299e27bd022ee2a04660a44868f5be06.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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
> Add a hw_compat entry for recently added x-migration-multifd-transfer VFIO
> property.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/core/machine.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 21c3bde92f08..d0a87f5ccbaa 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -44,6 +44,7 @@ GlobalProperty hw_compat_9_2[] = {
>       { "virtio-mem-pci", "vectors", "0" },
>       { "migration", "multifd-clean-tls-termination", "false" },
>       { "migration", "send-switchover-start", "off"},
> +    { "vfio-pci", "x-migration-multifd-transfer", "off" },
>   };
>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>   
> 


