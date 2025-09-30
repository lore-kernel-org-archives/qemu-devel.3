Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FBECCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Yj5-0007Er-Rx; Tue, 30 Sep 2025 07:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Yiq-0007Cj-Jl
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Yif-0004Lx-Tn
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759232430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t6ES20LFf5SLiUj7MMyN/MR9MroR4Ce9aSPxX7u6mHA=;
 b=Lsb+5IzsPhN8YUSV+CcQsf8ShrwVGlRTZAURQughs+uqQfm76QEc1Yo44hV80U112cS3Ep
 ZWftmkouxKi4pAAAI2C7g1oHlAfDrleawnpz/7nz/0Y+GFcTIi5VjO187x+5GVKNMPHfD3
 m2f/ofc9SEgqYqdt2AAWfgHryklGRSg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-U4EkrLvHPemtM3ZOo2T2fQ-1; Tue, 30 Sep 2025 07:40:28 -0400
X-MC-Unique: U4EkrLvHPemtM3ZOo2T2fQ-1
X-Mimecast-MFC-AGG-ID: U4EkrLvHPemtM3ZOo2T2fQ_1759232424
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee1365964cso4103473f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759232423; x=1759837223;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6ES20LFf5SLiUj7MMyN/MR9MroR4Ce9aSPxX7u6mHA=;
 b=EFSeAeIkc/EmvZ5pzHGdSADeTmpbt+oHRqRlpSwRZyeDCkByfkvHYQr5fnFFCLVvX9
 vjy0g5I95rp/23/NEzlH9LhL60W8hWSo6yG5j1hAm6SSK18dQ7EGgcRHKAeDhdrsjGPS
 dx/M0naSmO2NWcT+4KPwSfloGldX6INFXtpxw9PSjsT9zEAPDCNv42Fkkb/C7w1RVlmA
 2FWaSIcK7TLQL45tiFjlBRKuApoVOSsVpzR5H0AOecllFC/ARDSVQt7YQiGYLnmgsZEL
 wGiFAs/z+EpODy5RlOopI/KrSorlOF6QppW0il5HnK29/WMHv3T6nBz7XxAAQshqKeKI
 LhTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4SsJtyPaBq6ODkMW5dneRLEAS3XhX7lkTtGmS2GFM+7zySwK4S/PaMYG4FbY5FVqX/37gEpklC8js@nongnu.org
X-Gm-Message-State: AOJu0YxRdu2toG6jLO7jLuwS9SXP9UJMQwKpsKyP5LByZb6Qd8hF/ur7
 S9TwqoWPTY5TFZiTrrYBiclNr+FWqi3kRkxWDkDNEahIlRCijxFdUDXOVq4zCoJyOdZDmB+poS5
 TwNjYSgVxkNbmw7Bjd1px3eMpNplIH4ymdS41yK2XBDTpMvp3gHigLWjb
X-Gm-Gg: ASbGncvrJbE+39jgThNlAAhj1to44P3twWhK51YVycjjllvaSzWzdOa9qqac/6U2dsm
 6Q8rroIzIUUSmYhWyBL+vW1Ps12nCUywkFRU+xcPnz/cbVSVyeyAcQn6jO+5ESzRC9j3dVUqzLM
 HGG8I1Dx19cwl0jEFlKSkwsZmSO5NgLeMH/mGHmbmmQNSbjXVj6OP3ig0KKfGowIq57fHTOaOOz
 JKNn59RIUqGBfmnKsfso4TC2LKRZb56+5GfXwHyJQoUJX5ZICcx99zEGlz5v4rxKIloJqKY6IWy
 IkOZhvQxd/u+/adjlFWnWJ7/uxF7Zfmc9k4hrpSqBhkcWPbaQ5qtR7WziPVoj6Mepu5PCWM1ap2
 hXvy3uFpd
X-Received: by 2002:a05:6000:268a:b0:3e2:c41c:bfe3 with SMTP id
 ffacd0b85a97d-40e47ee1e0emr19425177f8f.38.1759232423650; 
 Tue, 30 Sep 2025 04:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWygNJdYvwn4403qW4bYSXD0RUMfhGT/puzE3nI2Llc5a0PNFl30trbv/jGmlqocxXC7/xxw==
X-Received: by 2002:a05:6000:268a:b0:3e2:c41c:bfe3 with SMTP id
 ffacd0b85a97d-40e47ee1e0emr19425146f8f.38.1759232423219; 
 Tue, 30 Sep 2025 04:40:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb2eesm22962298f8f.12.2025.09.30.04.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 04:40:22 -0700 (PDT)
Message-ID: <35b38466-bd6a-49ee-98fb-56c8ac613796@redhat.com>
Date: Tue, 30 Sep 2025 13:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, John Levon <john.levon@nutanix.com>
References: <20250930091456.34524-1-philmd@linaro.org>
 <20250930091456.34524-4-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250930091456.34524-4-philmd@linaro.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 11:14, Philippe Mathieu-Daudé wrote:
> The 'ram_addr_t' type is described as:
> 
>    a QEMU internal address space that maps guest RAM physical
>    addresses into an intermediate address space that can map
>    to host virtual address spaces.
> 
> This doesn't represent well an IOVA mapping size. Simply use
> the uint64_t type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/vfio/vfio-container.h | 10 +++++-----
>   include/hw/vfio/vfio-cpr.h       |  2 +-
>   hw/vfio-user/container.c         |  4 ++--
>   hw/vfio/container-legacy.c       |  8 ++++----
>   hw/vfio/container.c              |  4 ++--
>   hw/vfio/cpr-legacy.c             |  2 +-
>   hw/vfio/iommufd.c                |  6 +++---
>   7 files changed, 18 insertions(+), 18 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



