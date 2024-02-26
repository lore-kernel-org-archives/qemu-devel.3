Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6638EC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reXay-0005p0-Ok; Mon, 26 Feb 2024 04:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reXat-0005ml-Ce
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:48:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reXar-0002Ba-QG
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:48:19 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so1982328f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708940896; x=1709545696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L2Y5I6pfV08TFTJVMY4z5FkHj01zJWSR77Daet5fXvo=;
 b=D2uZbJjmiof/GWvdeM+/HIj+ZarT5xsKgRsVmaz5FXaIaRyPOAowkekKPZhaXcCcoE
 H1EbkRM/VEPVB2R/w4vt+5EuhhYtG6HPy3epX/pMpX3dcuzqvBxkslL044wBofgphuf1
 ldguxP8v9Qs6J/UlswFsmhUxtmJGpqVqDExW/uBh6FNu2SvFaR19CVz55VKYweYZLgRB
 OdOKR6agSzHGeh3yEGgE4PWFobB80zB+FOxoAX6shDFIySUEGTIFdv3WVQWnlPyNKA7Y
 TPT2tH48Rby3hfVJH5EK22pNeKdJCIhOoCA3AkOSGJNkkyaN7CePRwEl3wwTi3OPF/BR
 dPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708940896; x=1709545696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2Y5I6pfV08TFTJVMY4z5FkHj01zJWSR77Daet5fXvo=;
 b=ItLOHiqAif4yVXlAvS5Ijr6llkhrt0Yn197+0c05hw1fOjHsXZldsNcEjsSe0X5dN8
 MV6PSkVd5egh28ptYjE95AVHfTbxpr9L+R3cxVTEfRzGY3IFi3XlFyC8feM7YYVRZ50Q
 uQpnol/16uziuLMYUr8w/Ngh8WX2Sq08mEXEMSKJzNwLAyVn7tn5WbF/ckoxu1w5st2m
 C2JrWp1ww7C/Wo74bVX32V9+OG4t68YRskmG9Yh43PyTOc7ye7MkgVQOWAll38bDUejD
 PRklyHKlauVSc0GwSXF/hz+4N9z5cfgtDvFlxJgpo1Lfr4TMpIPVJCpQPVHwgLD0KukI
 CgSw==
X-Gm-Message-State: AOJu0Yw5pokYoj8DAT3tZxHIa2mYcbjt32mygcHUpUF/itxABN3zMvz2
 D55Nhj5LC3eq2PZCwG5Yzof59SvgBL6vv7rgrEzUvYjlkRSOyggk+PuShBY5gJk=
X-Google-Smtp-Source: AGHT+IGx05avEH/seaOYx3JEl9kBNhHeuWT1t21H50/Ce4NSC7AqPakTFpdahNcHtBQVG5MHzNehlA==
X-Received: by 2002:a5d:528f:0:b0:33d:e1d2:2694 with SMTP id
 c15-20020a5d528f000000b0033de1d22694mr648421wrv.63.1708940896119; 
 Mon, 26 Feb 2024 01:48:16 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 bw1-20020a0560001f8100b0033af3a43e91sm7819078wrb.46.2024.02.26.01.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 01:48:15 -0800 (PST)
Message-ID: <2b3f15a8-93ba-4d4f-bfd6-7af11aade2dc@linaro.org>
Date: Mon, 26 Feb 2024 10:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc
Content-Language: en-US
To: dinglimin <dinglimin@cmss.chinamobile.com>, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240226090628.1986-1-dinglimin@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226090628.1986-1-dinglimin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On 26/2/24 10:06, dinglimin wrote:
> Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> ---
>   semihosting/uaccess.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index dc587d73bc..7788ead9b2 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -14,10 +14,10 @@
>   void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
>                           target_ulong len, bool copy)
>   {
> -    void *p = malloc(len);
> +    void *p = g_try_malloc(len);
>       if (p && copy) {
>           if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> -            free(p);
> +            g_free(p);
>               p = NULL;
>           }
>       }

This seems dangerous, now all users of uaccess_lock_user() must
use g_free(), in particular lock_user_string() which is used more
than a hundred of times:

$ git grep -w lock_user_string | wc -l
      116

> @@ -87,5 +87,5 @@ void uaccess_unlock_user(CPUArchState *env, void *p,
>       if (len) {
>           cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
>       }
> -    free(p);
> +    g_free(p);
>   }


