Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83B0CD3439
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJuqA-0000Le-OG; Mon, 04 May 2026 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJupk-0000JW-Rz
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJupi-0006Qy-DH
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777907020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7NWbYUlfYojAUrCSDBQDDaYJHdo6iDEYC4YMeGUXHFA=;
 b=JfgATXdNJMwqRw0yRQQshYeqkHN/DC4I4C8UKDaBlr+AWB2/n0wAqvuB3kGqmeLXMNdTr3
 s1esK3sy0l0RlkCEUT31FvEbrhu4Kg0keJkF003PjexejXsSBpIHDHFUtuOlITPGqacU3H
 Ouz+985Te7pKO6flvNn0Op4OwbC95Sk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-zbXW0ytvM9iBNKobmiv5fA-1; Mon, 04 May 2026 11:03:38 -0400
X-MC-Unique: zbXW0ytvM9iBNKobmiv5fA-1
X-Mimecast-MFC-AGG-ID: zbXW0ytvM9iBNKobmiv5fA_1777907017
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c2a4e257so27288265e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777907017; x=1778511817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7NWbYUlfYojAUrCSDBQDDaYJHdo6iDEYC4YMeGUXHFA=;
 b=E5789IWMFDD3ubcTuRA/AmkM60MAPMtNWdbNZjDukrPWMciR8RiLu9x9nvQMzwCgBh
 93kMI+28D+ecQexe+GNCDk+zYhJAS7AwIApVOCS++wZ+4/4r91jdPKOk4G/Ug2A/kVV/
 5aeAOQLSkJqKabpF/q7O/ylaIOb62sjTXeUEyuObvSdyKlkycEQm5nZ6xc8i3N3HiWN8
 shPaas1K9S8ntpbulNAsw7bCXugdkbvWiUd290SCh+dWCiPLLkH+CfsvXsw0qRQxO/41
 FDLZbYnj68OzGaIk7Kd0NLFMLjGKADW3bMXzukuSn9WTqzZe4gYtntvTOLUMlKb2HA3u
 TMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907017; x=1778511817;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NWbYUlfYojAUrCSDBQDDaYJHdo6iDEYC4YMeGUXHFA=;
 b=tMCNGKwQ43iyWgeK68VvT7cZdMm90lq1ymfzIcsjXVhRIrsSCCF5NNsTpKOsljTv3w
 qTXfbXiF3AJvEbce5EGwIlRtyyxcvaQ+AKEccPVSC3KcyW/l2uXFT8yal4KBeurBn/3U
 h03JxdIn2LWAoPzQOpES8oiXEMnOlsPVIoWYzhRxAFHka4+jM71YuAvdRobnQJ9v1W/F
 0K2QFyKHBdoO7Y/70ngXmmD+Jzq9pK2D5ysL6dCqu1VoJn0y+afkiYV7ByDBD5h1I0X1
 8Ym11+TjPZZSMzIxGhPg5OyZIe/JdT9QKyL5XUvpKBtvd0pXZ3bFQeS1wwBDYih1SHqQ
 I/sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9sqdW/7MGRqzoasDQrx4lGtBLo7OyKUouDAIHHjrRXpHTStM3C7QBxJWtSWYMn9DDOx1JywEwi637@nongnu.org
X-Gm-Message-State: AOJu0YxahUdoNiFWd3v5b1Xv5B3EWSxrbAbBOY7wYdsr/ywajgkfavhx
 u4lBGMekcPa0DX6otaYX/gZIqbUBnyyHoEzu4zP6kB/V6Ctap0PSXiHI3KGGcsDnKEEe6tZxAXk
 CnfiWnQDso+pRFHehG3AgdKTMm/Ogky4fWW7a6l0oyjTdz5LUnPWjTJa6
X-Gm-Gg: AeBDieu/z8drg5EUoDjN5h8fvJ4J//g1UaFfoCV6kb4xeLv65Ytw3hUQFO2Mdwg0jKo
 9j2MpTdTSGa9rhC2wAeCyj8JS3IkLhDhr2AXEud3+jw2osHtGa2a75GypzIOrRHBZ2GyM9jF2OS
 if/XFK57syFapsO8X2jokgpI3AaUx50rTa17I0WYGs/qi2e+ENpy5lrUIhVLrtiCIEBa+Z8prxo
 nAFc7bHneRrZmyvNyfjBWRg5vx6oiDevD7ZY3p2HL8K0amUQMqCcD7A6XeBqIVknEtPD8mASZ6H
 eo5NKHxUY4z9158KAdt/nvzQ9TKyXQIF/P8H3XAk127clyp1aBKP6111+CjI3Dnvc2sEqzrK4VO
 2MPSCphWeyKcIcJ+WHVW6lLzhkGO8FN4G72xFo/FO16erbUtXVHz7gxknAP8NuyrMKf+Bue0=
X-Received: by 2002:a05:600c:33a2:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48d0640ec5emr53436735e9.21.1777907017386; 
 Mon, 04 May 2026 08:03:37 -0700 (PDT)
X-Received: by 2002:a05:600c:33a2:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48d0640ec5emr53436235e9.21.1777907016807; 
 Mon, 04 May 2026 08:03:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ef5299fsm25735600f8f.13.2026.05.04.08.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:03:36 -0700 (PDT)
Message-ID: <64e966e3-8450-40ff-98fd-479eee458b38@redhat.com>
Date: Mon, 4 May 2026 17:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: Drop superfluous inclusion of hw-error.h
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Tomita Moeko <tomitamoeko@gmail.com>, 
 qemu-trivial@nongnu.org
References: <20260428163702.3224323-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260428163702.3224323-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/28/26 18:37, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> None of these files use the hw_error() function, so there is no
> need to include hw-error.h here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/vfio/device.c      | 1 -
>   hw/vfio/helpers.c     | 1 -
>   hw/vfio/igd.c         | 1 -
>   hw/vfio/kvm-helpers.c | 1 -
>   4 files changed, 4 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 3ffd69a579b..ccf14743e95 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -24,7 +24,6 @@
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/pci.h"
>   #include "hw/core/iommu.h"
> -#include "hw/core/hw-error.h"
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 65c6dba0428..c719864b92f 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -24,7 +24,6 @@
>   
>   #include "exec/cpu-common.h"
>   #include "hw/vfio/vfio-device.h"
> -#include "hw/core/hw-error.h"
>   #include "qapi/error.h"
>   #include "vfio-helpers.h"
>   
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 6aacf27284f..e091f21b6a3 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -16,7 +16,6 @@
>   #include "qapi/error.h"
>   #include "qapi/qmp/qerror.h"
>   #include "hw/core/boards.h"
> -#include "hw/core/hw-error.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "pci.h"
>   #include "pci-quirks.h"
> diff --git a/hw/vfio/kvm-helpers.c b/hw/vfio/kvm-helpers.c
> index d71c9590aaa..5e73dddc418 100644
> --- a/hw/vfio/kvm-helpers.c
> +++ b/hw/vfio/kvm-helpers.c
> @@ -25,7 +25,6 @@
>   #include "system/kvm.h"
>   #include "exec/cpu-common.h"
>   #include "hw/vfio/vfio-device.h"
> -#include "hw/core/hw-error.h"
>   #include "qapi/error.h"
>   #include "vfio-helpers.h"
>   


Applied to

     https://github.com/legoater/qemu vfio-next

Please base future contributions on this branch.

Thanks,

C.



