Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AABCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Q0B-0004P9-Cm; Wed, 24 Sep 2025 09:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1Q04-0004H9-Gu
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1Pzw-0007dN-Vn
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758722251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dK2otoFvHDloCAA3ff91P3DylTJnTxRr6qT4omBo7+E=;
 b=OWvoQsIJldiL8RMGPUk5qAAS3B1Kpzg6CPO4FvkEcOR2uZYfDY2BQN8cvcmlBZyu6cq9iV
 uCbvZadKir0qtg3oM7mtSi6b+F3tnpeAcXHri5YME3NGSCapyAkvy6ARIFcv2nOOGyQw4J
 8pTxebebBo1Pvq+F94tlkKttGJWwNsI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-3UkeR9mDNO6g2hPiUzuufQ-1; Wed, 24 Sep 2025 09:57:30 -0400
X-MC-Unique: 3UkeR9mDNO6g2hPiUzuufQ-1
X-Mimecast-MFC-AGG-ID: 3UkeR9mDNO6g2hPiUzuufQ_1758722249
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46da436df64so23674955e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 06:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758722249; x=1759327049;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dK2otoFvHDloCAA3ff91P3DylTJnTxRr6qT4omBo7+E=;
 b=UTLSmhlPOYvs/A+SPWdCJ+/F+paMLhvtc0IvH7p+ebd4RGqwVDTjks08GDOHJpcC+a
 T+tKdHFRDZdshJJNELzFG34w0B4h1CmGFYmRAsI6kWTkd8N5eW1FyHu6ZaRTYiuaTwr3
 sxE/0eoaMf3PrwMnMUdATGgomQ7VRkPq1m9Ul7rpaA5FUvEcz+/dFQrR3XVz+Nkd+0ZB
 LrKDZMDa+JYjfG+5SZy8dB1y2xNMHUT/EvxrhQ7N9hso0gUARpOk94KGDAlTsPxjQ3Ko
 YYUt/Cw12O3TMVO730TYIrwyIvfAgPq4qKLaoMHWxeOy+9Li/BT9jG5YmGh0npC09uUs
 +GYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaxn20u9YASCx6DZYUDURsEX6Cea2Q2qdxq14TSsicco5l1zYW6AarcJXm0DEMNu50u+3DzsITXNep@nongnu.org
X-Gm-Message-State: AOJu0YzMZfDySXSYkU8nQmG5QyPb001IpcxGJ/ZHJ041DHQpYwyx1gQC
 Jc/s1M/75vYSrGqYH7DRZyiF3iGCLi9vkaVwZp0nX78YYnhtntk4wcZrZHwD0LbUgVnMmjEOvU0
 LL8FGKKQVg9k3J64xjfuc8VVlizSBwSR6LeNB6UNQx+b287TTHrlQwcaY
X-Gm-Gg: ASbGncsjEikU1sPIbqdGHo/67sqfFhzolQ1/mWRX19GcAU5+6WlX0G6ZJ11ZAMIXZ7n
 bp2MihsfzOi52kk4f3qwHlH1lX5OnY/eUOfskAOboq1RCktUFSMYqbg2UMc2EbVHihvqbcO2w3x
 oeW9RpBuwHn91Sf8Iw1yhqyCblGO/dZzcH36pnfqKp3SilGXv9Qv7LD15GH8dyVrpdQdsdYCUeL
 D15vPKobq71SlsybCzUTnBX8mDGo3ZsnBKNkKfkqvIaFEwCY7rv2l11wpzyCWTcJesBKP2JzBKI
 pgvyHJZtsGUlUhnwSgmzzVBuzoHLuM5FZPbqxuxo35X72GEpBYpuqBPv3CAdEraX9VJSPcx1zPN
 MzTc=
X-Received: by 2002:a05:600c:c48f:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e1d994375mr86512725e9.16.1758722248680; 
 Wed, 24 Sep 2025 06:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0f2F/Olzol0zRtRyt35GwfPawVDjplI3BYBraUsMQoDZglyO8f3qtcNh0etXl3pXrnN5weA==
X-Received: by 2002:a05:600c:c48f:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e1d994375mr86512395e9.16.1758722248258; 
 Wed, 24 Sep 2025 06:57:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a998321sm32327375e9.1.2025.09.24.06.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 06:57:27 -0700 (PDT)
Message-ID: <da26ee88-9608-422c-be1c-bdf13e57e51b@redhat.com>
Date: Wed, 24 Sep 2025 15:57:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] vfio/spapr.c: rename VFIOContainer bcontainer field
 to parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-12-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-12-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> Now that nothing accesses the bcontainer field directly, rename bcontainer to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/spapr.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index c883ba6da9..8d9d68da4e 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -30,12 +30,13 @@ typedef struct VFIOHostDMAWindow {
>       QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
>   } VFIOHostDMAWindow;
>   
> -typedef struct VFIOSpaprContainer {
> -    VFIOLegacyContainer container;
> +struct VFIOSpaprContainer {
> +    VFIOLegacyContainer parent_obj;
> +
>       MemoryListener prereg_listener;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       unsigned int levels;
> -} VFIOSpaprContainer;
> +};
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



