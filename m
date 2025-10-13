Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09B7CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 14:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8JHB-0006Y5-TR; Mon, 13 Oct 2025 10:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8JHA-0006Xx-M9
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:11:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8JH5-0002yI-2R
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:11:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso22746865e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760364694; x=1760969494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RxS0jvDhxWNFhdGQzx7kmaTSuq7EX1uqyPJfynODXvA=;
 b=IyrlIQ9IXY3QbskEQqIJdNgxPC8UzxxT7lChsqfpsHMLTFSSSywDupIoUR7NuIzH3B
 Yh4wfjAcdq0oCk1rKgZC12yh2dDQgHYtrhU9QlNx6dJ23qPiLwL9jo35wBv3TxxooejZ
 M/yWVwMNLirvHHG+4rJtth6xwkDXYgakkrCfbvh0XrtaShYs5oG+4rBZaGW6h8atpiPC
 7OU5m3xPb8VFKvZ7W2+lmmnnR+UkBAt5kiB5lEfl5pJX+Ga39iFrAy0wzhl1U2VwxTt9
 +t6/ix1wTbB+dU0ugH/NrkL5j9UyTi9DZLb25jB2SPFN0y8gcPQ71hZEUnaeJfc3mdoH
 PKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760364694; x=1760969494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxS0jvDhxWNFhdGQzx7kmaTSuq7EX1uqyPJfynODXvA=;
 b=mwODp+ATGwb4W33559ru36lRSO+iviEWDvZXNp/lxGignlG3Eoyyrzp70UkZvtdNmr
 +azJtPIExcf5Y59PpFU7prCHf6BRAe4QtMH027C5I5oI+ZeG2D1D40zftKbGO/xFT/vM
 /2KkJjXjemDq/TIKu065L3kHFw5dek2YBFGutz8xdhhOxRyGFigRbkG1McCzjwQLKsNB
 VNY3z/5gMSfS0z4MwpI6zM1LdEV3WJzs5PFOBzAl99m6rtWDRUqZh91A9GpAiVa0HmE9
 C3N50KNVGu1uZbNmQf/6F84U3yYsXUCNTp/3t2bLHZ7atLRF7WmeIcEqurgQY6WecZTT
 87nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxSZgnmBQT5sQWgQrblkwmWfSBPTRhnBiUTW1AR/HjB6KEug5LudHnAlAqPjdCSdxZDqqdDQc5gFcS@nongnu.org
X-Gm-Message-State: AOJu0YzNc8XafW1ae/ptoAycBMpmOwRvZKluzafMqULJlYHR8CMEyZds
 1jnCZ+YqMYAjTWgpZc0I3wm0ZZkP6F3TSvdy4rFkAApYZR/vQS6fokKkEXphOc9YAgY=
X-Gm-Gg: ASbGnctvI/WDWEUhOZGXRmPKQxqG9wGCyM8PT4IsyOder1PRXczuiKQp86XuykO1AJM
 AgUFNNq94qqrB777DA//WXv/fD+xBdv9Yr9EbF2PSVNunMBki8R9xbxDevJWs30LFZ83Wf5Kfny
 rUzzidVq2YVBRkV57siVzZczGWUrpLOr0K2c2yapTF7H8ssmHNqv2Xfr0z6xejdR9gQOAZfFbjw
 BkHaxMcUzTGCRllTX6lLj8UHZEzayj7ckpLEZlbIxZ9c8tNtKBrX1KQ+yvSN2V3FjB5Lvi3ItLO
 v2y/+iw3fFDEO+YEPWaPIftQeNnOCDHOIdptM7ZZ85AYyNBwfO/4/vMHqlnyfE1qELmwA+kQX7g
 tuytY25QTOeobmcvNmkwM13xVS9I6QwLk+GNqlHJPaZ7HgpsL+Sm3/6K/rnb3GED1temNUa51SK
 j46lcZ49Nb7E429wyE4Y651jc=
X-Google-Smtp-Source: AGHT+IFK3hob+g1mmBEGu3QsXORDZ+6JyQuRyatKOlH33GhFUjbPskb+/aYFew0M5XK2A8Um5B53Lg==
X-Received: by 2002:a05:600c:83c9:b0:46f:b42e:edd0 with SMTP id
 5b1f17b1804b1-46fb42eee2emr100222875e9.41.1760364694353; 
 Mon, 13 Oct 2025 07:11:34 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm18445134f8f.42.2025.10.13.07.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 07:11:33 -0700 (PDT)
Message-ID: <2831438d-9ca2-4629-b708-65874cf3a4a7@linaro.org>
Date: Mon, 13 Oct 2025 16:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Bernhard Beschow <shentey@gmail.com>
References: <20251013112102.2396012-1-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251013112102.2396012-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/10/25 13:21, Markus Armbruster wrote:
> Reported-by: Bernhard Beschow <shentey@gmail.com>
> Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixman_shareable_free())
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   ui/qemu-pixman.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> index e46c6232cf..aea09755b9 100644
> --- a/ui/qemu-pixman.c
> +++ b/ui/qemu-pixman.c
> @@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable handle,
>       Error *err = NULL;
>   
>       qemu_win32_map_free(ptr, handle, &err);

Slightly better if qemu_win32_map_free(), as per commit e3fe3988d78
("error: Document Error API usage rules") recommended style:

+ *  We recommend
+ *   • bool-valued functions return true on success / false on failure,
+ *   • pointer-valued functions return non-null / null pointer, and
+ *   • integer-valued functions return non-negative / negative.

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -    error_report_err(err);
> +    if (err) {
> +        error_report_err(err);
> +    }
>   #else
>       qemu_memfd_free(ptr, size, handle);
>   #endif


