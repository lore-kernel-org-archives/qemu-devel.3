Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74F7CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsrk-0000a1-5P; Fri, 29 May 2026 04:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSsrj-0000Yv-7E
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:46:51 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSsrh-0001tY-MC
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:46:50 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so2322726866b.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780044406; x=1780649206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6PqvvwEUHi+azGAQwwZuD9staGNK/d/4ItdLLxqb14=;
 b=cfdK/qMi8Ir2S7hEZHj3u+3XEVgXqi3IbP0kQtys02ARNK6ThqR7pL+Ans+wSj7GFh
 NGXdJLn1XbAIspkjZHxXT1wHkF9l2TW0Qi03UhIuwrHXz5gT//o70XeAMHX4OybSI1pb
 nUfcU3Lva1dO88UoGVXiH2XkEhkEBJ+fCpZZwkZ38Vns3ojiimDELHiDEIYwzMpMatle
 oc34TTq5ZTPBqejChuFg9x7ql83WR0TaaTrr0X431qHwvkBz5j1j5XkjrurCMrW3wWod
 s4KZUX6zOraur3sBBPlsnPWIg95YrhdYKb1M0N4JsQkLmSRYdlNnmL3LzVXdSUzvNRjJ
 8+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780044406; x=1780649206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6PqvvwEUHi+azGAQwwZuD9staGNK/d/4ItdLLxqb14=;
 b=XZ4asrbxx5Z/g3QNbpDz8nkOXgZPuHop3UFLWgme1en9UZV4VHlbcdb/KxR072+qEm
 MvjEzvJi2oPxS3/1TYnlNpnp7DE14UORAf2bY0x46F7thDX5eN+YBKqjFXxD8SrRjj7l
 4ZwBoctmdj1nphMNeidcfub+I5RWXLBBiR+zKLyhNoK5HGzVhAxGp0D8k2wNZd+tyO6u
 lsVA015euCajf7B1JVZdfl3xKocsicvl/QjZ9dtrovfWJh5OsWEiYWQy4TxEmZrFnIvh
 nAhdnUagC6uwdB9X5A5dGupPK7Gyy9WnBaUGagS5OiVqA1RmmMjTw2RMnfnPL/ZlI5Go
 vn/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EWZYHM8ljzdnJJsslhxg0O/rtGmAqrF4S1egTudTY0kq4CEDSkmbrjeNwJyVRCHqA6yaJAOl4uL6M@nongnu.org
X-Gm-Message-State: AOJu0YzZfYpEfjLPYJUbgrDoXYjM3gO75ehaPAFf+pQXnOOBjQp6m7rs
 JQKf/DPofonwKCwTKea8pUnkyDK/NvTS86wwLDBOsBFqCpQhTAnwB7jmB4a168Ip6EA8Grcowa0
 f21s8Y/smJQ==
X-Gm-Gg: Acq92OEpl1JhoNWyDU/3briPRo20enOiIzPQry3Djo0F9KkbyQjHvqiy8IZQuas1VFg
 IHUd2pOEqLIUr4/rZTFzMCBXoEmpno1pX3CjZZJzvxMqBta728U9qx2dFndfgh+bplXWJyNiVT3
 5GSGstnE6F6gtccaVtLIUA2lD9YuQcFQUiRvStmbYPkVllITqhI90NXjsSApP4sShGy90u4TRfw
 lSHy7jpt9zRjWj+qgjxoLl/iNP4eTYF3ye9F6HXLOpvQRtKxwjvxZ319hAwqI64cMRfmFC5kPZ/
 tNLQxTt0ekNnNq2MsUSsX5FXNsuDCWnmtDyiMWbfKCBu3UR6tkIRHmmpLV3uOP0u+UJ4X688NJR
 9dvDxIKG+o0WZ4o+V5fLIZXrN1SIY09nsGIkWiu4uC1fehkn9vHOWZOqF6EndqHRvSN4hFpFFEL
 jDiqt3WWVcXqzEV7Vhd+D2ggBCftOPk8d13q7R1HbQp6CT63bbKFmfOLsY4No5L2Lqbzi75ySDB
 SNfb76VZw==
X-Received: by 2002:a05:600c:41d2:b0:490:46bf:17ab with SMTP id
 5b1f17b1804b1-4909c0cebbamr20992915e9.29.1780043985687; 
 Fri, 29 May 2026 01:39:45 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356a4c4sm1899041f8f.31.2026.05.29.01.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 01:39:45 -0700 (PDT)
Message-ID: <cac90947-4f58-4fa4-aecf-44ead131c57c@linaro.org>
Date: Fri, 29 May 2026 10:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cutils: drop qemu_strnlen() in favor of strnlen()
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, kevans@freebsd.org, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com
References: <20260529072803.99475-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529072803.99475-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 29/5/26 09:28, Bin Guo wrote:
> There are only three call sites, and strnlen() is available on all
> supported platforms (POSIX.1-2008, Windows via UCRT, MinGW).  Remove
> the hand-rolled wrapper and use the standard function directly.
> 
> While here, align bsd-user/uaccess.c to use size_t for max_len/len,
> matching linux-user/uaccess.c and eliminating a signed/unsigned mismatch.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   bsd-user/uaccess.c    |  4 ++--
>   include/qemu/cutils.h | 16 ----------------
>   linux-user/uaccess.c  |  2 +-
>   util/cutils.c         | 15 +--------------
>   4 files changed, 4 insertions(+), 33 deletions(-)


> diff --git a/util/cutils.c b/util/cutils.c
> index 76a9442085..a89213966e 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -54,7 +54,7 @@
>   
>   void strpadcpy(char *buf, int buf_size, const char *str, char pad)
>   {
> -    int len = qemu_strnlen(str, buf_size);
> +    int len = strnlen(str, buf_size);

Using size_t here and removing the line in docs/devel/style.rst:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

>       memcpy(buf, str, len);
>       memset(buf + len, pad, buf_size - len);
>   }


