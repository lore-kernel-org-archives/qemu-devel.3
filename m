Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0FBD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSxNO-0003LX-2G; Tue, 09 Dec 2025 08:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSxNM-0003Kf-9N
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:03:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSxNK-0007WD-P9
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:03:32 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so52680005e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 05:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765285409; x=1765890209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kfTqjnDXaKP0zy93qD7BWjefZePS+85EsfBwtvP8MlA=;
 b=p+7wQ2ICYcLMyB8iP7LetOXKWo/ei8X7REmN4UA9SRS0+5kKEKKpFom7OhsU58c/3E
 45//58uGAEzSwrrmdy1+V63urbnvBs82/fUj8GTZ4qda+yR0lGLXVUHq+wFH9q36EX0y
 z24wzpa5g2pr1PJ9X23eNazILq6Xh3/ncaLy+iho6tmbacCAUBBkyYnEWSfYx8j60CF4
 WZnohHFqao9B2QWgEcDa2VqWDtCU+u0Fe74G3i8osFSr80mPORKx76L/4pJMpGrpx99i
 2wShjX+GRACe7JTX5MrBkEfk8TpTCz8VvOwFsrxQ3AmIK+ZxoN3eG2a7NrQo3sL8mYiq
 zFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765285409; x=1765890209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kfTqjnDXaKP0zy93qD7BWjefZePS+85EsfBwtvP8MlA=;
 b=Elkqfm5CbP3fQbWMvKpMFcQTt2M8akorNWpB27Ay5pqkZAiCm9jgzH5uIhTatX73Mg
 n8rvFVFtPYFm7ZZRieLqsOSXiQthGHGjWobwglrtuFk7E8prSsMUROa98Cd4rYX/m4sq
 AmNsiS1mZ1+t0u54zd24NGluobAjIIcydTSi2IkIENGTgGZ0x17delt9hvW7TuRYfd8F
 +rbJJt5z7dlA5AC4bwOiQcE8++VyyRg13VRbt8oWjXjeVK7P7pa8SyZWfzhEcz8MIJNF
 4S1N9l408KFmO4/0hvi3L4nfU6B1Di+vSvtoUJQrYe9ZfO0dbJnb6/YBbGkcShzYzkEi
 CX3Q==
X-Gm-Message-State: AOJu0YySwDad3IlVFiK++N8WkHemGZzHO1Ysyr2L3SSXR1gJIxU1PRJQ
 ah0+D6jAewPQMbZAMqRz52UykWxdvHiNDj7N/gLCHUkejRkECb+yF7ugR+P3OugQloQ=
X-Gm-Gg: ASbGncvxZkG103SqBXIUuGi8Z4yFtQC1J0YePFAzyPhSTaHUp5JFaVZ2C4heBb2tIip
 7v3nIwr4nGJcCIcrQi+EKDd/Zeaxtv7rAJyCQCdJuVCBY9xdHKPNvgTnsIdzpG5h+S8saGC3i4B
 CRSChIQkLT+6tjK5FiYMKf6AaUQs1SMBfB/GlakW++SsXKbB8Tkt/t2D541suHCnS5nL6rw0nwM
 TLwCJmjF8On8DWd2c7fvUoX/DXRyhcrCvKJE4OaNU05ictpfBfmgkr7pzVoYD8PiCTw9e4dtI1R
 8a49QNcl9zJZhEGSb+Ap2OIU5bbtQ9rWLj38wT5+ls7mAdqMas6zz9CHg4uVUa7ToUPCRGbQiio
 Ug2vv/G9zPhDKlsfvP2JcI566gZV2MBTJsSS0dUZu7MPTb95+awR5iwmhT/QefHANikQ3Fv0Vka
 2qg/RYIzLOv0zTyW7yEmACmNwZuFKygxLm26PoT1Gw5YVAF+NEo1udSQ==
X-Google-Smtp-Source: AGHT+IE6xqfBWoPrf0ftkUN+yh4Ucy/o1Y3HeM5TWeBtZZFZFLQqyycXzu40VreGFHLzx16UuUfRog==
X-Received: by 2002:a05:600c:1c9e:b0:477:7b30:a6fc with SMTP id
 5b1f17b1804b1-47939e4d0camr138040905e9.30.1765285408986; 
 Tue, 09 Dec 2025 05:03:28 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d36e2d3sm19164505e9.2.2025.12.09.05.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 05:03:28 -0800 (PST)
Message-ID: <96877ee7-21b4-4a33-bbe4-33cd1304c177@linaro.org>
Date: Tue, 9 Dec 2025 14:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] Fix order of function arguments
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251209125049.764095-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251209125049.764095-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/12/25 13:50, Stefan Weil via wrote:
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
> ---
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
> +    mis->postcopy_tmp_pages = g_malloc0_n(channels, sizeof(PostcopyTmpPage));

I suppose we wanted to use:

     g_new0(PostcopyTmpPage, channels)

What is the benefit of g_malloc0_n() over g_new0()?

>   
>       for (i = 0; i < channels; i++) {
>           tmp_page = &mis->postcopy_tmp_pages[i];

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


