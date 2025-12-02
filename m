Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B38BD12679
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 22:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQYta-0003kD-BF; Tue, 02 Dec 2025 17:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQYtZ-0003jx-5U
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 17:30:53 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQYtX-0004QT-Fz
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 17:30:52 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3ed15120e55so3674385fac.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 14:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764714650; x=1765319450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=491M1MMKif/og9SD2X+oox6ypjy+LJ56gB+lCOA76rE=;
 b=bOk3IHZfAI3KWL1wSHN86o/JtUsGK4El6qfLzd1xCPNqvki1Kihei/4bslE5Lw8hKo
 mZ9DLILD4RXFpHn4ZDBmT3XEKNPh5sSfFRrGwPkSASmy3aZhyIhq0mP98KDA628i8DJj
 GNxxn+b3PuJnse+piOFF5w09Wze8n1M3u7ncncXYDusBUtMvs7UFfm1MFklt4wnIUlUd
 ojUmGjgrZ8TbpjzocpMOKxlrlNKItRLIMhfPmMzZx3FK940+X+Mjtx1IyrJH3e6U+wyv
 8NUp8NGpRyVIwL2ILEle/hOfASBnFlPlh9hQ9r0zsb3l28VV+71lNDpVZVmEzBWUf8pW
 9Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764714650; x=1765319450;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=491M1MMKif/og9SD2X+oox6ypjy+LJ56gB+lCOA76rE=;
 b=MiY9IatHWCxinmtENmyECdtrz7C/YXq6ww2sPp08dSlbEUNNpWC4x3so+YMtTxrDPo
 DLTb/mAcBQ+hwsZWu5/ii8ydVQ4HvjF3xklnk//+FiKXmEU2btg1fdGBbROLN5fDRm1Z
 iAeK+6asGxAh5sNAFhPXhj0g9jks2dMgKEbYHEP4CO8XCTKM9DRB1pc+2EOPHGjtO/3Y
 c4aAjmn2lLU6VwN6NytVV7mK+Swq+Zk+yTIaRO6M4kHGjVPXoZEa0huCRnxmWaBHzwp0
 GmF+Ly643p7W8B8oBqIH8UPqx+jA7U/G8qlJKk0oPeTATekglsedeJ+c/Ja5lVCLugGy
 1nDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDkVZ1GwqDjPb4Vmp4K2q7l6Z5xUGdDnL7bXJyzEA6VC3gI5RzZ8Yh+Xlgocibo8zBfwh/8f46risP@nongnu.org
X-Gm-Message-State: AOJu0Yy++hqdscPRHPshvpYHfs2gBbAw/ECOgatHGNFqd55g8K/7iA5U
 jmVDnuFSTWv2arms7nUeuqy8bAw9e5UniXS30uybO2gkZzXCGWZJVgkOsjNE5xM03s8=
X-Gm-Gg: ASbGncsC9qnMMr239kD7AOX9HKmKPzTA8sxaIIhj0BoQWW2VUx4A78lh6j3kO2nKskt
 HEsTMdP61YxDGtTXVd8/6OQh/++iw4mt/H1tg7bo4Mx0pz1DoWn6GSFZfdbeKgMpgCM6Ciw4Pb4
 2+CaT8xqWs05IZ1gW5YRyFjEHql51sKpyIaUArT14jbDJYNDWl8NJsVwlHTTsVMPDMC0a71lvbl
 ijGFMit+0HSzmeSt8xkTwWJwaEx76wdN1k9KQxsKxnhhDsQh1eK2LR7sLucY1REwVgnbYZmvhaV
 /7vly+3Jri4cKoN410SQqf+gHPwbJ46VZNOR8SkWAZnoxca+XwBKjJ5eti2AqYQGt9RCJyX1HGH
 e1UyFcjId0gFmTyaD+uPWMlLB4SZjGnMXy+7m1NhFn0HyF/koSiwZjYm9kh3EvNtuOgH+0Dn0AG
 Zh3aKfivlsIWqZE78SgKcmZpJ2Ag==
X-Google-Smtp-Source: AGHT+IELQZ+XP7KfiQ93b3Y0bsuuHu/ujjujJ1Uf+O3eJ6Li4uZOIxR06A10MAcqAibUijRtyAylYg==
X-Received: by 2002:a05:6870:9495:b0:3ec:4089:f963 with SMTP id
 586e51a60fabf-3f1693e5f69mr38672fac.44.1764714649886; 
 Tue, 02 Dec 2025 14:30:49 -0800 (PST)
Received: from [10.27.3.244] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dc766dc3sm8788853fac.0.2025.12.02.14.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 14:30:49 -0800 (PST)
Message-ID: <2f307b46-42d8-445a-8aec-91fa101244f2@linaro.org>
Date: Tue, 2 Dec 2025 14:30:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 2/2] tcg/tci: Disable Int128 support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251202184653.33998-1-philmd@linaro.org>
 <20251202184653.33998-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251202184653.33998-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

On 12/2/25 10:46, Philippe Mathieu-Daudé wrote:
> Disable Int128 on TCI, otherwise build fails:
> 
>    In file included from ../../tcg/optimize.c:29:
>    In file included from include/tcg/tcg-op-common.h:12:
>    In file included from include/exec/helper-proto-common.h:10:
>    In file included from include/qemu/atomic128.h:62:
>    In file included from host/include/aarch64/host/atomic128-cas.h.inc:16:
>    host/include/generic/host/atomic128-cas.h.inc:37:12: error: initializing 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka '__int128')
>       37 |     Int128 old = *ptr_align;
>          |            ^     ~~~~~~~~~~
>    host/include/generic/host/atomic128-cas.h.inc:39:52: warning: incompatible pointer types passing 'Int128 *' (aka 'struct Int128 *') to parameter of type '__int128_t *' (aka '__int128 *') [-Wincompatible-pointer-types]
>       39 |     while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
>          |                                                    ^~~~
>    host/include/generic/host/atomic128-cas.h.inc:39:58: error: passing 'Int128' (aka 'struct Int128') to parameter of incompatible type '__int128_t' (aka '__int128')
>       39 |     while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
>          |                                                          ^~~
>    host/include/generic/host/atomic128-cas.h.inc:50:12: error: initializing 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka '__int128')
>       50 |     Int128 old = *ptr_align;
>          |            ^     ~~~~~~~~~~
>    host/include/generic/host/atomic128-cas.h.inc:52:62: error: invalid operands to binary expression ('Int128' (aka 'struct Int128') and 'Int128')
>       52 |     while (!__atomic_compare_exchange_n(ptr_align, &old, old & val, true,
>          |                                                          ~~~ ^ ~~~
>    host/include/generic/host/atomic128-cas.h.inc:63:12: error: initializing 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka '__int128')
>       63 |     Int128 old = *ptr_align;
>          |            ^     ~~~~~~~~~~
>    host/include/generic/host/atomic128-cas.h.inc:65:62: error: invalid operands to binary expression ('Int128' (aka 'struct Int128') and 'Int128')
>       65 |     while (!__atomic_compare_exchange_n(ptr_align, &old, old | val, true,
>          |                                                          ~~~ ^ ~~~
>    1 warning and 6 errors generated.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And what of the CONFIG_TCG_INTERPRETER test that already exists in int128.h?

There's got to be more to this than that.


r~

> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index d9293294d8e..692a62e6c18 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2996,7 +2996,7 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
>   
>   # has_int128_type is set to false on Emscripten to avoid errors by libffi
>   # during runtime.
> -has_int128_type = host_os != 'emscripten' and cc.compiles('''
> +has_int128_type = host_os != 'emscripten' and tcg_arch != 'tci' and cc.compiles('''
>     __int128_t a;
>     __uint128_t b;
>     int main(void) { b = a; }''')


