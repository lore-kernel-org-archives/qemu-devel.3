Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4084CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 06:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uocL8-0000FZ-PB; Wed, 20 Aug 2025 02:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uocKx-0000F8-I1
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:30:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uocKr-0003Pe-OJ
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:30:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a286135c8so2888265e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755671409; x=1756276209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/7aYLJAc1O2xFPqnMJ5KD1C5NrrVkvgdB8/Ub+jtNM=;
 b=jw0DLN0BrY7fM12jF/2eCWwyXCXxXjsFyjmrF9UHu0+lAgURQfyTFOVC4e0p46NMQZ
 WiIt4AZtYZoarv5C+m/xhpFuk6BmOcC38Cov9s0ZvndJ0KxEu2WT2DaK473+3qALBUNQ
 DVIZdwTbuWpd/DAZIeukdthxSXRy62xIPAbRNf2hrRgWBO+bVZqPTzoru80O/EobMUXZ
 +ajIFgBEIlXL2ZFkeF9l4PSu0Ltaz8tiUu9ANp/FumbEMw2QNSDURfvZoS1eubZmj7c0
 6ZYvX496OI089UEUDdB6SBLwhwuLCzkNEQm/8ZmqGJxL4o1031pijy8+vRcRhX6FiNKK
 shYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755671409; x=1756276209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/7aYLJAc1O2xFPqnMJ5KD1C5NrrVkvgdB8/Ub+jtNM=;
 b=q74clWKVYFgUKowP/YiFG1ClZwsks7fIhtnwQ6WmtjsSm+XR0JE9Q5JpVhOxch1haP
 Jiea5sDnXqJDLSwSZN8+aVpzQAYWSjsa4a9kbSGUiYKLpc1PhCEVxx6GzxB0dwIeoTnT
 ezBuDQ3f1cSX2VfvShQPMqrG8Uj6vSCSsXSlxH0uJf2qhyb0KZlFbjM4gtzosQBP+Ycj
 nanKbVayd7DUcNp4mr5/yMuPnnJBa/vQiK2m0jTnKyZC7kJv/v9SOq/mubLKtNY3j4xL
 XtopbYLQcrnlm8B+6q3opKcNQPFh+O0D4ONC6gqlnOZqpyEgaWgQz/8l13T8E+ZnBNnE
 x2oQ==
X-Gm-Message-State: AOJu0Yw1di+CTM5iTeh0VsaTgVBgw5DvGirbjIbuu3Jniu6d09ZMKI99
 3ZAtr9vKHmQe/YvELaIbTWQkk7qx+mGQEjcIoSeywsTAI8/6ghNnBJwfEj2xMuAEXmU=
X-Gm-Gg: ASbGncv6D7hV0GEA4v4VqypiwMmexKRWeT4AdGfqJah/UtuHX0i+Vb+jAAIIiQV9UR8
 2he5I+P7py4kbkCM4ZvOI8SIsxH7hkc+WICgy1OechW4WINJrQNKUdltf4GWeQPSIzBwyZdNnXV
 lm03KhZOVulOpYXaGPoe0g2CL9vE/vefnjz6bLFGaaTIvzLjtUX8JB5ZnV1S+mjasMJLIj6aE0q
 7RgDJKbSs56IMHin7hxuh9uKnnhwB/EwAWvIamvMHCS5I4Nu4npc08/hOA0iWPVoxfLSss4FRkQ
 wCCSUkkWGz11KW3pPkv+PnG2haTGu16mCoO/TpHryX25Tle0PhWlJLlrgACGh0Um7QM373QlZrV
 FrgttZTWNHea6lZGUWOwxfP6pguVkrxM+G7y8QWNb1YcoP/2ASIRbQKip0PXuCOK3ZQ==
X-Google-Smtp-Source: AGHT+IH08XllcXPWcgoujKd5Ukm7J/vNqOWC4gqikiaom2sA4uEKxkvFWOc/LwVdoLocB9xXjIa09Q==
X-Received: by 2002:a05:600c:1554:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-45b480c68c3mr8602775e9.6.1755671409363; 
 Tue, 19 Aug 2025 23:30:09 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c8e98dsm17944125e9.14.2025.08.19.23.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 23:30:08 -0700 (PDT)
Message-ID: <bf4a3994-1cb7-4c00-9f01-e114acf559ca@linaro.org>
Date: Wed, 20 Aug 2025 08:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] net/tap: net_init_tap_one(): add return value
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com
Cc: qemu-devel@nongnu.org
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <20250818140645.27904-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250818140645.27904-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Vladimir,

On 18/8/25 16:06, Vladimir Sementsov-Ogievskiy wrote:
> To avoid error propagation, let's follow common recommendation to
> use return value together with errp.

(looking at commit e3fe3988d78 "error: Document Error API usage rules"
again). While not return a boolean?

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   net/tap.c | 55 +++++++++++++++++++++++++------------------------------
>   1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/net/tap.c b/net/tap.c
> index f7df702f97..531ef75e91 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -680,11 +680,11 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
>   
>   #define MAX_TAP_QUEUES 1024
>   
> -static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
> -                             const char *model, const char *name,
> -                             const char *ifname, const char *script,
> -                             const char *downscript, const char *vhostfdname,
> -                             int vnet_hdr, int fd, Error **errp)
> +static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
> +                            const char *model, const char *name,
> +                            const char *ifname, const char *script,
> +                            const char *downscript, const char *vhostfdname,
> +                            int vnet_hdr, int fd, Error **errp)
>   {
>       Error *err = NULL;
>       TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
> @@ -765,10 +765,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>           goto failed;
>       }
>   
> -    return;
> +    return 0;
>   
>   failed:
>       qemu_del_net_client(&s->nc);
> +    return -1;
>   }


