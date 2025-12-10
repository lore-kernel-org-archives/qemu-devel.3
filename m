Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E9AD3C912
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLko-0003bW-BY; Wed, 10 Dec 2025 10:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTLkm-0003aj-Lv
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:05:20 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTLkl-0006Ni-2k
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:05:20 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c76d855ddbso2440015a34.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 07:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765379117; x=1765983917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sDINPTPGVlW2yvHPICN4ETrOtXvkA3kdVWReoU/2Fi0=;
 b=ogB3WTYNbV2S36wfZN8FZWhOVe1hjpe7h4iSNuYvuqInRJx6xs/Cr746mMW3Y2R/S5
 RSd1RtgtNOw5+jGBnvJA17ZXj8l8U1zv/jJsCQzWlnZoW/AernNQ9xrGxBQ0s9vOxXw9
 GKjOORaWr7/oebf6Wq3pwuhkpf21kn6+XGVP8bS7GWS1p2d1HKAnKGBDnjuc5cdfBGcj
 5rIjOWOhv0KiuNOHQkA2bjD5ak5FwbzdT+cLC+4zGeuG5msuuHeBqXFQ3xdluSdkZAcq
 H51P8c7aqXBu0mpQBJsqQdSFQL0V7ujIPHhj3Awtm4qODaiG7FZH6ftPAIkQQXrBzURZ
 /fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765379117; x=1765983917;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDINPTPGVlW2yvHPICN4ETrOtXvkA3kdVWReoU/2Fi0=;
 b=FMm0aao20YqLDcJsRDpHEi1A6lieFJ7/2lvG1Impdle/ME8oqVH3/PztWVvuzKNTJ/
 h41CZLj4XHRo03jGhw0rjFxkq7QGpPk1ZMe12OIshX8mspA163XXw3KV2U/SedhJ5F48
 /VYToKCaHOUqYqxRrlM0oDgXxy1YHLDRnDz29Y6lxHqIt38N+FpuCy9lDl2ZixdylHPy
 SPfmTnjH679IGrQTkqbLANnZz6GeHf0mhpUGThE7WJSvuuwKlB2+dagM2fEdMbezWQRZ
 w6KTTMqGfeD2uHHEQ87E8FuU8YkCaPs77SD+K5XQdht83PoZMTtB0581eXHfWr1AlQZH
 zofw==
X-Gm-Message-State: AOJu0YyxnvAJjvu2AJ5hwl5163HO0trEpGdZvNy0CVCftd+rPCTadj3k
 BraC0zCPg9aVe2u05IJuvHIombrk7LQCQNqT28aodsHMdP9+TuT5Qx42fZR4t8abdRQ=
X-Gm-Gg: ASbGnctIEcsvfnUtiwO8DFfAuRK7Eql17KOKpb0VkIYWuHX1Ku2Lm1Xd+VnvkzmjBGD
 CPRVvx+DOsN2Zi2aOFxZmhnWD+T6uWaCxuKdvbluisFfEoDnsMxpN/ZK/lm0dCc2VW22+6qE3rm
 VYKJq8YtbWcHVwfBCDzX0+mN2wf2URQMP5Kp7iSIPzQA24iNEqNPIg5l09qGR7piT3puW5VbZE3
 hlINzpfzzjPWmYs7hgmqxc7XLsMbZnplUyNSN/Yr9lOtM3i9O2sKqdA90wkz7Efou5Jm1qgTvJS
 BpMRpot4XQxKA6tDY0+OKCFQSIFoWdExSnfrdsQlEsa8bFDbL/ASDwfryvLudNCtQYHfW6NAlbv
 ZDt2EmoaWtc6QmDnzC1Y/0rSfT5sGqUNlHdIFSOzBI2P0ugkJx1Ms2R/a2EHPktbCGDhX0qmTg0
 V8LrcSMhsnS0Zq1A9S2CSM6liJsqmTsO2X+4/8AHEQhovrmkWhXbDQSAcE1iatrpGi
X-Google-Smtp-Source: AGHT+IGsNNavdVp4Kp4evSbNBgu4fJktpL9t+KgdU2zICwDuNGnaIMPOSXM4XJF4HnwgYzsymmvdjA==
X-Received: by 2002:a05:6830:6ec2:b0:7c7:32d:975d with SMTP id
 46e09a7af769-7cacec15265mr1685381a34.31.1765379117248; 
 Wed, 10 Dec 2025 07:05:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91d475sm14834639a34.7.2025.12.10.07.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 07:05:16 -0800 (PST)
Message-ID: <ef44f931-1f76-4cfb-a347-c6d5737d3adb@linaro.org>
Date: Wed, 10 Dec 2025 09:05:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v2] migration: Replace g_malloc0_n by g_new0
 (fixes compiler warning)
To: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20251209210017.768535-1-sw@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251209210017.768535-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/9/25 15:00, Stefan Weil via wrote:
> This fixes a compiler error when higher warning levels are enabled:
> 
> ../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
> ../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>   1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
>        |                                                  ^~~~~~~~~~~~~~~
> ../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element
> 
> Avoid also a related int/unsigned mismatch by fixing the type of
> two local variables.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> ---
> 
> v2: Replace g_malloc0_n by g_new0.
> 
> Thanks for all comments and reviews.
> 
> Stefan
> 
> 
>   migration/postcopy-ram.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 3f98dcb6fd..8bef0192aa 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1467,7 +1467,8 @@ retry:
>   static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>   {
>       PostcopyTmpPage *tmp_page;
> -    int err, i, channels;
> +    int err;
> +    unsigned i, channels;
>       void *temp_page;
>   
>       if (migrate_postcopy_preempt()) {
> @@ -1479,7 +1480,7 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>       }
>   
>       channels = mis->postcopy_channels;
> -    mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
> +    mis->postcopy_tmp_pages = g_new0(PostcopyTmpPage, channels);
>   
>       for (i = 0; i < channels; i++) {
>           tmp_page = &mis->postcopy_tmp_pages[i];


