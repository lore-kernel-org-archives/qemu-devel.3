Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB15C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu51v-0001zf-8a; Wed, 12 Aug 2026 05:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wu51p-0001z5-WE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wu51m-0002CF-Dq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786526017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JashMbt5f7t6dVjqumVlIA2t8OiLOavPKv27WC+CApI=;
 b=CEqA5Kw/JLqTG/NBYcwleVMqe+lMEj8lojWr2bdHRhBJe0JJimmSrqrVMSZzK1nfE9efPK
 2efNlqH4Ix+3gpGoCcp6AW2UF17yog12WN/Kdbt3Rtm+swfobIfEKaUKcLzY2dBxi6HDFy
 Cmvg9tVL4Q/98K5G/MnQjB1DQNw7kmo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-CYg6BE1XPDGF3_WS2MhUWg-1; Wed, 12 Aug 2026 05:13:34 -0400
X-MC-Unique: CYg6BE1XPDGF3_WS2MhUWg-1
X-Mimecast-MFC-AGG-ID: CYg6BE1XPDGF3_WS2MhUWg_1786526013
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f84ac1990so446260f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786526013; x=1787130813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JashMbt5f7t6dVjqumVlIA2t8OiLOavPKv27WC+CApI=;
 b=kSQzVKTkt/3398i5nntg8N0XjFIrihs/YgA58Cf5cBnd3HXo3WgIQzbn3qCGl15JNo
 S0HeocnoPHf+9jNqx8aqq29dgEpPm5msUTvB9UeBZBImEUXkAHxVFM8XIf7HviJJnpks
 Hv2sQDrDpmtdFA/gRn6g2dP5jVF+2Hi4HTQ340FlSiM4wPl0tTEJQSo9xi5FJ7cAWhiF
 aQzd0JkG90KVFYe6GxowmUY2dHhZ8mr7t2CMfakvrPl4bv89zVzeiODN08koKE2x1BoN
 a3kCT6OpGq3uQnpt2D8+/RiGBdnjnT2E52RpDrP6auvu75pBRHYKer4VqTCT2zzoLvry
 e6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786526013; x=1787130813;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JashMbt5f7t6dVjqumVlIA2t8OiLOavPKv27WC+CApI=;
 b=sQJchPBbKlD1qxtEF5ylV1YOkNWB7kwUpGv6//YmS/NuXUzBOEKII8txfOKzac8mvW
 jfg+mI43lZgkXuXJvnDX6TuGn5GcE9UdlXZY1KiQVaFggSVqpqxtPGlcWgeOGG2c8ROh
 1k1xmIuCmWhDqE1+ai8DGwssNzQq3xyei8+F9WoiQ2HLgyA191Tr1cLU9amhcC/6FDS9
 1GFduW8SIGJMbsX4UiHJooIgJq6uynmyPq0gquvMs2FZhklMeT4TPGi3za6kgwkxJMN9
 52GSCmf4zo5y0qofInjOHAte6gFDqvBfwlwsq6LAFy2iMbFpcZyVYdakgjilBqA9fvzn
 untA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfMoquvorgEEM6ZNAJk+oNMFxrdwdjRNyN48xZPD8vL1Rv5osCzdnepljIqJX+2c3obPiBrQPTxOLk@nongnu.org
X-Gm-Message-State: AOJu0Yz9oht5aleWqAi43GfqEvyyRlD9Ug2ghaXzPCS6n2RNpKGYdq9j
 2dfNi0QdiKy26Eo8SUiFzsz9ir+7Hob9FRtf5cC6I7O2uT8KUKx77keLZxe6Qk/M8+4IPqdqlf7
 9ojqPpvjotpAcPO0kTCIOdIpNJiYULqnXnKYz4CC05LTlHNJqaaWsXahh
X-Gm-Gg: AR+sD13+dKSKCx/j6ZEPdPeCcIEWkskeODv6uIK4/0czWEdrteWP/lYSWxT5Ekbu/TH
 +Yezh48Y02fe/Dec+JIpKJ7dbMZjXJ3j0LU1o1Bgl6fXRf0hqfZPu2KBconXncFUCP78CXCofWG
 Mn7M5REldAx/nOIZd5ZyA6OKaMhgIXDR8Kn5REsEek0hvAVUtTdkRA1fiNOEsCnrKemZmcOC9V6
 katFNYBKY3lTgvY6UbNQ7ueRVZ9D5plOPS4NuEO4dK6OXNltGFEboyQ27lW2t87tcc3rAxlvGsE
 swyKg/ejlIIM8sj0N9foFmPQguHsMIoF51ehQcn4djhfxkpZ8WTxQ/CvX/aLh8Pjkb3VmvLz
X-Received: by 2002:a05:6000:2613:b0:47f:cb39:10c4 with SMTP id
 ffacd0b85a97d-48152c65dfbmr4558195f8f.12.1786526013239; 
 Wed, 12 Aug 2026 02:13:33 -0700 (PDT)
X-Received: by 2002:a05:6000:2613:b0:47f:cb39:10c4 with SMTP id
 ffacd0b85a97d-48152c65dfbmr4558112f8f.12.1786526012747; 
 Wed, 12 Aug 2026 02:13:32 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5c13sm5561771f8f.7.2026.08.12.02.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 02:13:32 -0700 (PDT)
Message-ID: <c3f0d138-ef6f-4b8c-bdcd-101f06ca5281@redhat.com>
Date: Wed, 12 Aug 2026 11:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] sponsors: update who hosts the Arm hardware
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260812083942.3833221-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260812083942.3833221-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/08/2026 10.39, Alex Bennée wrote:
> The WorksOnArm project retired some time ago and we are now hosting
> the Aarch64 CI at Linaro.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   sponsors.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sponsors.md b/sponsors.md
> index 8ac7d45..84b54ac 100644
> --- a/sponsors.md
> +++ b/sponsors.md
> @@ -13,7 +13,7 @@ QEMU's continuous integration is supported by:
>   * [Digital Ocean](https://digitalocean.com/) through the [DigitalOcean Open
>     Source Credits](https://www.digitalocean.com/open-source/credits-for-projects)
>     program
> -* [Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-arm?#Equinix),
> +* [Linaro](https://www.linaro.org/)
>   * [IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-started-with-ibm-linuxone/)
>   
>   The [Oregon State University Open Source Labs](https://www.osuosl.org)

Thanks, applied!

  Thomas


