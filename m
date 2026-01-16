Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AF4D4A60E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfNA-0007Hr-Qx; Fri, 16 Jan 2026 03:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgfN9-0007GY-Bx
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgfN7-0004bV-NH
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768552796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vUnLKuPYKrJqqiWZ5/bmj3ajIXpMLx6/WlUNsvWXvYo=;
 b=D1QjZPEn5ELVTVTdvZknjZ2XqNgQXJwDwJYapiwODWH/KXGqf2HKkgtHxvCgJOV2fizXnN
 3WVzdsPaz2Vg9q8urF414/7E3UkO0/bAXCi9rSFxAhyTclEXaHPgdwHI890vaUgfJIoQIT
 d6CBp59thXSzcFWVn2V/qyZ1uLS8qxE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-1tm5--rnOryhi0rLQDtLPw-1; Fri, 16 Jan 2026 03:39:54 -0500
X-MC-Unique: 1tm5--rnOryhi0rLQDtLPw-1
X-Mimecast-MFC-AGG-ID: 1tm5--rnOryhi0rLQDtLPw_1768552793
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee056e5cfso14267415e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768552793; x=1769157593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vUnLKuPYKrJqqiWZ5/bmj3ajIXpMLx6/WlUNsvWXvYo=;
 b=YmGCWA/+o7LdmzGGqB0i1gimgVJofejWFn0ES4VOXoF8AvlB3KdlOG4A00c9Q7rpOo
 yA7xqrHkKTinrLGjVHzDNxZHccDC0kCtWBi28HRhrsCmaxhCOvg/2NcqdHu4MmZC7bEo
 ApBzdYEXWCJnsKOYphMATWmlbIU5ifwMQhH5XFzy8j0u6y2qT7W0+kb+ZewTdqhEGJc6
 ZTuFB+NjQQtTCV3zOiSuAyKDFuSXomkDk70N9Jssa50WHBWTckcTbL06SJAwQiA6BgsA
 5Cl/QVXB7yDlWXYjsh2LJQnlbC7lKb/35yfTDNXhW5I+2s+S+HxWciMueUMqmwo6sIbQ
 lVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768552793; x=1769157593;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUnLKuPYKrJqqiWZ5/bmj3ajIXpMLx6/WlUNsvWXvYo=;
 b=M5QXyC1FPENqidLutxb5XpcGaaz0FG5u49kA7a6+xlPnrroY/jN2ifk9Z3ntD6SzwT
 W8/xVlcEUio8GM/dD3gIN9W9IPVoTc258m9INDTgL+UVec5ROylnCELc3O4NOztEgLXZ
 oB1IarnT88eAXwvxL13LAK7bVBttRCltJ5V0+UY4b2raLMT/ieY6s2YKN+nVOw9k6F+8
 gJEjHXtU3rrUZcayi1+SETk1g+dKW9VArCabwMTmoySmoKXMxCm1+pKrppfRtZyq5YuF
 cYJv9v2bEmngaJXEHMsdUuZ+5Xmpc5hdELcHQftTg4P+Bexyr+Iv5nsCmpZfaN9BCfzj
 JSBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ76JnkF+SJx0ZxOmlj0u5mSg+aXpVykjv08bj4dALicLfqVcR6CMPfQzPuWW2Uj/y9dfUNNukBwXE@nongnu.org
X-Gm-Message-State: AOJu0YxgVq9iFqfegIigTJJJGwqTvFck6TGAZxPfiH9j1kZB1o9iiew+
 T0PkAtS0AyKiaKTR/658ct8EXDEO+5ejA2bWGGLq7qbMTW5dOryzkvBBVPbqsNEzmASLHup+9+E
 S4dwrkQmExWEQVkuD52RZsFeQzRa1mb51/0VPxbqLAN5QrBPDcnNSM758
X-Gm-Gg: AY/fxX4Xfg6MP2MxYfUc0JfTimMslm4ockCzQbS84a7Y4BTqJk4+JLn0RCQ6mtJ45mJ
 npxNE1cYuCvv1CCqbfLD6HZjj3E3xLB1CnuWqB6EpeDFCWl4FUjuhIwlSL23qAEubFnEXYBOFr6
 72O8Td6TCm3w3XXddpg0pq3/xpEY+GiHrKZUYKNx8+8Uo0skCCcQsiU3qgwVdOZJ9xn1u4wrZwb
 EzVO1y5tnFppOQdBTP1yEoz/epG/hMTCSCyp2YGyVOrhkn4pKP7vKSEv/koqATu1AMCPre430x7
 BpTiUFcJoXMM45cLaTq2+0trSIBjhGinIzdWeCMvgtgz+7JTC9KCaIOTtE/VtrEWdNYvAz1dhhg
 tKjQKoskM9xKUXLvGbHlS8jvPUX/ZtLvBzew8J7yIQWJDrRfR
X-Received: by 2002:a05:600c:3ba8:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-4801e34651dmr24822105e9.30.1768552793223; 
 Fri, 16 Jan 2026 00:39:53 -0800 (PST)
X-Received: by 2002:a05:600c:3ba8:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-4801e34651dmr24821885e9.30.1768552792856; 
 Fri, 16 Jan 2026 00:39:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe44b37sm11089795e9.12.2026.01.16.00.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 00:39:52 -0800 (PST)
Message-ID: <a3e3d4c8-c5f5-4da4-8762-a1f96ae40480@redhat.com>
Date: Fri, 16 Jan 2026 09:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 1/2] MAINTAINERS: Update ASPEED entry
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, kane_chen@aspeedtech.com,
 nabihestefan@google.com, komlodi@google.com
References: <20260116082431.3689035-1-jamin_lin@aspeedtech.com>
 <20260116082431.3689035-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260116082431.3689035-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/16/26 09:24, Jamin Lin wrote:
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f0..28046b457a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1248,11 +1248,13 @@ F: hw/net/ftgmac100.c
>   F: include/hw/net/ftgmac100.h
>   F: docs/system/arm/aspeed.rst
>   F: docs/system/arm/fby35.rst
> +F: docs/specs/aspeed*
>   F: tests/functional/*/*aspeed*
>   F: tests/*/*aspeed*
>   F: tests/*/*ast2700*
>   F: hw/arm/fby35.c
>   F: pc-bios/ast27x0_bootrom.bin
> +F: roms/vbootrom
>   
>   NRF51
>   M: Joel Stanley <joel@jms.id.au>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


