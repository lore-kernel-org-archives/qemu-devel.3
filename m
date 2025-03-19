Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F098AC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tunfW-0007AO-6n; Wed, 19 Mar 2025 03:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunes-00075F-Tt
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:16:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuner-0000t6-5I
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:16:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so36727505e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742368567; x=1742973367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wRjZbo//ZxL//lxqofF8+uotMc1kFwCOefcv7YfssE=;
 b=Qherd+LNoO3rIgi3+C11FLmRjtg/ztj46nGfnJRKK08tLKU96YG4lHNJFI8exF56CZ
 wr9sGkbBISwUcXBGq2P9aeD7nEexkzJ2rfisX8l72Pxd+IMOuF7BnI0Spfar7VkjxE28
 MY1h7rPrgE+2JVw9KyL+oXmWLTOwid+E9QqoHME85Btku2QWPsia3axL2sZZYIDs91nh
 9Avvol1evHGDHq27whT25yeGxf6OWnijFoP46S4N2XeKuLiYnJq8SIPxTRsL7kwtvpGF
 GHNAOc3+18u1oCTPxC/QR6kz4EZOMmM9VfcrGM2fiEYV3tgcy6fvus2XHhoZg5M5XlgV
 yuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742368567; x=1742973367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wRjZbo//ZxL//lxqofF8+uotMc1kFwCOefcv7YfssE=;
 b=cSYlhKvrOV1fHhkAfgUAE7GfH+Reh8B7gsDz9zlS4H/xfSmUUb2CnfcCGyrnH6SBDL
 NfkL7PUo6pinWZX0fjg8C9sHoouGqaBMAvu9o1/rP/IWkw9r1uUBwE0yhEe7Ju9IQlg7
 Ek8L7LSi2UhsphwGCkVLmkBDdJArjDMpI7NIWMFbXwdfmHfvQcMmKtuHNI1p+SdOnLEx
 gAQEMalbgZLVyCT7zUld60m+ovLhcbkWqJ9/miGpYinbj52Zcys4S+KRLZP3FKF/DVra
 1l7sDCvTFIjM7WrWm/h1g4Ov9E7FpbngQyA3YzugqnQyn6X1vQ/5HBfOJMisL8/l9KcF
 cgUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnShCxkW7yOx3y0i5xz+LDkW+sLQBkRxBcNNDmFYBv3hz5IV9sds2cjzqTYtEY0hC2cuAqzSqwa0qS@nongnu.org
X-Gm-Message-State: AOJu0Yxhayc9H2jzH388RGpYm6xhY1KX5LcSamTsu8IANNWGzCIxQRbM
 SWEYu1zL2bAPqMIeRTUaoSCv1/CrQdbw4K/+9GQC+RuIljRXOeVO2woe87vVzt8=
X-Gm-Gg: ASbGncuUSC9HtN0+oGGtTQfaGKswsfzVI2+XPby0cOkN/Xup+/vtC2byK7MtWjeqjAb
 RTBPyOZM4yR/DWSb1NR2RTMXsoJRYp4ptnyE/OEzsjiO/xY/Iopg5+5QsbtaWGiVOlxnYkgKURA
 q/C2IIhbodL50PWurekJ4kjSgOjufc5Gy7eFw1y+g/6DaZsh/DzQueEwr7BRu1oa4z1p/l2HwFf
 q1IgMAxcRPFxik6bX/Qr9Igo3EGWbVri60aDXKmSST6MyChBZHY9lag/T1AHeCJgYJHekCjdP+P
 IggS/C9X212htuptn6uGRIDbxh+JGtFIOiMg+zQ02yjv625UJ62irmmXfYRegkyIyLgurVapJGP
 cNAfEjtkgkx1n
X-Google-Smtp-Source: AGHT+IEZaH/lTEvvEw9ODzu8bQNug+j/mzAK6vTbQWzME0qgmD4BZfl2NcyTuQgCMvqqiDP2Tb9NDw==
X-Received: by 2002:a05:600c:1f83:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-43d437a9783mr11931405e9.12.1742368566999; 
 Wed, 19 Mar 2025 00:16:06 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975b90sm20560300f8f.53.2025.03.19.00.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:16:06 -0700 (PDT)
Message-ID: <e788d7b9-d115-4252-aa91-187c4df096cc@linaro.org>
Date: Wed, 19 Mar 2025 08:16:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/42] semihosting: Move user-only implementation
 out-of-line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-27-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318213209.2579218-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/3/25 22:31, Richard Henderson wrote:
> Avoid testing CONFIG_USER_ONLY in semihost.h.
> The only function that's required is semihosting_enabled.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/semihosting/semihost.h | 29 ++---------------------------
>   semihosting/user.c             | 15 +++++++++++++++
>   semihosting/meson.build        |  2 ++
>   3 files changed, 19 insertions(+), 27 deletions(-)
>   create mode 100644 semihosting/user.c


> diff --git a/semihosting/user.c b/semihosting/user.c
> new file mode 100644
> index 0000000000..9473729beb
> --- /dev/null
> +++ b/semihosting/user.c
> @@ -0,0 +1,15 @@
> +/*
> + * Semihosting for user emulation
> + *
> + * Copyright (c) 2019 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "semihosting/semihost.h"
> +
> +bool semihosting_enabled(bool is_user)
> +{

While moving this code, we could also add:

        assert(is_user);

> +    return true;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


