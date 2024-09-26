Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FAFCDE006
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 13:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stomL-0002eW-8q; Thu, 26 Sep 2024 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stomG-0002dP-Hm
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 09:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stomE-0000eF-QE
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 09:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727358204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObesCQWwTesrjgqL1ssu7WDTVVohchSHRGqZaFMhK6M=;
 b=RPORwZXj3WFOpVJhnsoVM7EahNs+n6sPJDsvoGmyhqhVlAC5HPj5J5L7tUMT+FopmqdSsH
 /xtuz2IJFc3DaA+NxcEOPimhbJXv+BgJkqiHVIQ/fWd6Y5KXUDWWpUoDKiC5jOi358dNBj
 0Ol+1Zt2PYAW2ya83tcFqJ7jBhePP+c=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-BKJhvgwnMVuKuJ74wRFIWA-1; Thu, 26 Sep 2024 09:43:22 -0400
X-MC-Unique: BKJhvgwnMVuKuJ74wRFIWA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3e27a10adbfso868662b6e.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 06:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727358201; x=1727963001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ObesCQWwTesrjgqL1ssu7WDTVVohchSHRGqZaFMhK6M=;
 b=LMf+8q8wj0ybWumIdTwmJ1dk8QiCra8rxjWPWV01ilNlAwmH/Y7Kms3nZAbwv2NFeM
 K97Q2rs6dwyptLiluMxyRVG6Sdsw5NTxS/uatyxQ0wZUG1UBTzO8dCJrrD3T/Z/Akkp7
 yCCLDTukD4ea2/l1XaXZkHQ0HvN0v+hBDwKT0SBzZu7mi81vzIhIlDXS3/KdaZndNuzJ
 0fKRDWZLhUUHgEIWa1PY5uhk19m34UYyZ2GFPcp38+oHNb2KmotM48Kf3xgpXEmTw49V
 5I8XPvMcH67QZxJ4qbSczgu9IK/HaZCQTZ/JuwyyvckekfLk+iFElRL/LMEB02ArhMnC
 jG8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyWASN1ewwazq5Xdoi+7EDWNtz/2ZdmFCczelngJo9lTVS5zgq7WjoKr17LLNtNbPU1zQM8WtbdCCF@nongnu.org
X-Gm-Message-State: AOJu0Yz00BnYQrznXsuCg1/yKCi/kzN3vVXcQN/rdYA5rVo6I51K/h1u
 lYOXyFTqfJnuXN5V146hCA7iCI2n0jY0WjeuGuxz2equpqWss7gQz1BmnfgXkVa9B6l3fbF1opo
 dMXTMjk9fWzClJzmqSZaTBqCjTf2KAByCdRql2Wh9HC7sBC+5mJh7
X-Received: by 2002:a05:6808:2f14:b0:3e0:7d6a:a3d4 with SMTP id
 5614622812f47-3e29b7f360amr5772836b6e.32.1727358201683; 
 Thu, 26 Sep 2024 06:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqU9ubqrqvrTl5LE+vEYYLzhyZpVKZXxI5EoTo2dN6k4IrkWlEScYTAwgMttSvCkB+VE9azQ==
X-Received: by 2002:a05:6808:2f14:b0:3e0:7d6a:a3d4 with SMTP id
 5614622812f47-3e29b7f360amr5772811b6e.32.1727358201302; 
 Thu, 26 Sep 2024 06:43:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b526a61e7sm25898541cf.89.2024.09.26.06.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 06:43:20 -0700 (PDT)
Message-ID: <0cb27300-5246-4859-a888-e39b235764af@redhat.com>
Date: Thu, 26 Sep 2024 15:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of e500 machines
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
References: <20240926075948.2343-1-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240926075948.2343-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/26/24 09:59, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffacd60f40..0a191a03db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1430,8 +1430,9 @@ F: hw/pci-host/ppc4xx_pci.c
>   F: tests/functional/test_ppc_bamboo.py
>   
>   e500
> +M: Bernhard Beschow <shentey@gmail.com>
>   L: qemu-ppc@nongnu.org
> -S: Orphan
> +S: Odd Fixes
>   F: hw/ppc/e500*
>   F: hw/ppc/ppce500_spin.c
>   F: hw/gpio/mpc8xxx.c
> @@ -1446,8 +1447,9 @@ F: include/hw/ppc/openpic_kvm.h
>   F: docs/system/ppc/ppce500.rst
>   
>   mpc8544ds
> +M: Bernhard Beschow <shentey@gmail.com>
>   L: qemu-ppc@nongnu.org
> -S: Orphan
> +S: Odd Fixes
>   F: hw/ppc/mpc8544ds.c
>   F: hw/ppc/mpc8544_guts.c
>   F: tests/functional/test_ppc_mpc8544ds.py


