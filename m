Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1016FC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7tC-0000WB-F8; Fri, 27 Jun 2025 08:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7tA-0000VG-4g
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7t3-0004Ah-Cu
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751026135;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCd3s/hIu3T8xTe2GEFTw+4ocd3vQcHSEOXXbYEjSyI=;
 b=GiNo47MHpm9O1uF9ZemEFWkSTf8i9wYRAYrmdGfbyP+TsT3QnVLQa8yehcDF+wedupwCwC
 gDYGeeci92+0ZTrFBYuQ0FWdUJ4ATHaYJOoW8QIqXxT/S1p/QLHYnXhiTNb+BkzY/yuOig
 XyH+PCtfJB/NigyFKsZhXZJUU/G0mtw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-NMeMnM9vPfe2bNq-VrCUAw-1; Fri, 27 Jun 2025 08:08:51 -0400
X-MC-Unique: NMeMnM9vPfe2bNq-VrCUAw-1
X-Mimecast-MFC-AGG-ID: NMeMnM9vPfe2bNq-VrCUAw_1751026130
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso14678505e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751026130; x=1751630930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCd3s/hIu3T8xTe2GEFTw+4ocd3vQcHSEOXXbYEjSyI=;
 b=UQcbUIbPnTHYkHfsQ2Rzq9fm9g9mdcUoD945toWRnAHd6Q86wdIu3B+aAS3LHWKJtM
 UHt1p7fAfVjvjx63yfj8eBn4ogWgGsiqCw5zOcrGtE5dCrycy6GH0B694rgayx4xWcir
 lMHR9TGdXex3cY2kaNzcJLrY46FmlJgK/iNpXLyrAKSSFApuUhaj6aMpGKrvMy7S+fcE
 U4RNedS3DZSuivEhGJM0MCe8JyBedYskTBIgwk0RRyLepT07gA/f2Mveng5Q/gl8okTa
 00Rjb75uzWtLPB4ul9cEgjYRlJC/ojCAAK+fZSQ4cQdBsEycciNzLTONEltel8+SWV43
 47Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEkR+pNR/FnPrbmppHA5kSlvsl3snsYskdeVxSW/g5v4u6Lrc/Gf1fTM5ipiH+DVAsls5ha1ag7Wsz@nongnu.org
X-Gm-Message-State: AOJu0Yxte5uWhOqhgIcCpjyucZA3rabfFPH0FtCqHdkzqRxX7QBhqtQk
 VRMBHgZrncNd23H+mkAQp0a8g5KJ6DcwEiuepSeA6z8kEu6Ujrs2tGvM+usJgrbv347RYCMx0fC
 Y5kiPLLw60/vp8fYGGislxzp/kcXgCF1ZidCf3PuKZrHWFGFI9JXIyqzx
X-Gm-Gg: ASbGnctBbDX1XiOHj105LObkxRnVW5mhZQS3V96FQj8IdxLOO/QMEfiQ527Xgm4+Lfy
 RtYl8ibHY4B4O1yc+rOv3/WHuDCL+6RATyAFRABkTVs17aKYQn4y4mtN0XslRzc0cwLeOatrdIF
 i+nGPTXKxBUgUkVQiC6QPtDQxIVQa8QlgYfKST0yS6FtZn4QdTx/vnl23hfsUGE3ddKX85igKZZ
 OcwwlnjhTwSTXyy0gbQSJgETuvQcYUQC6PjF8wpTg4fEwgza/2RN3Wz17p5OGqGTMgyovx7+OOW
 GLdDEelEAZmD68Y//T4td6nClr4ag1GLqwTtuLRHbWgmIBfojZc/AAyQHzXPZyNPBOgiJw==
X-Received: by 2002:a05:600c:37c5:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-4538f30fefdmr27046495e9.16.1751026130259; 
 Fri, 27 Jun 2025 05:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq2qZ97TnjrXgQ8zPfcQctcwFPSOVPerJXZON2dHO/MHt0GCXuQKnln1GlfToWygIGd6sa+Q==
X-Received: by 2002:a05:600c:37c5:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-4538f30fefdmr27046065e9.16.1751026129857; 
 Fri, 27 Jun 2025 05:08:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a423abbsm49892465e9.39.2025.06.27.05.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 05:08:49 -0700 (PDT)
Message-ID: <38955beb-bbd5-4bc9-9996-ffde0b310d54@redhat.com>
Date: Fri, 27 Jun 2025 14:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] qemu-options.hx: Document the arm-smmuv3 device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-9-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> Now that arm,virt can have user-creatable smmuv3 devices, document it.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  qemu-options.hx | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 7eb8e02b4b..7d1a12f7ef 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1226,6 +1226,13 @@ SRST
>      ``aw-bits=val`` (val between 32 and 64, default depends on machine)
>          This decides the address width of the IOVA address space.
>  
> +``-device arm-smmuv3,primary-bus=id``
> +    This is only supported by ``-machine virt`` (ARM).
> +
> +    ``primary-bus=id``
> +        Accepts either the default root complex (pcie.0) or a
> +        pxb-pcie based root complex.
> +
>  ERST
>  
>  DEF("name", HAS_ARG, QEMU_OPTION_name,


