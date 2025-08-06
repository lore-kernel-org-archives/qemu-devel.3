Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A382AC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYA7-000722-JB; Wed, 06 Aug 2025 03:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYA0-0006z0-4P
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:02:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujY9y-0007qb-1a
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:02:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b77b8750acso393822f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754463720; x=1755068520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YMmbs0AJOQ1PJnetP8zgjNmqNEKkDyDpVl5S892by74=;
 b=CfqpvvDGYIBVFGLIb5eYtpHSlfZQRnaxZ+gqRkKS0oEj73FPexgdupvDhQwP5z3iT6
 KG1gaKM10BxAPqrRnMHcpaZpGU1z3Sd650Lln7nU0UgnCdqIhPxxAzQqnkDyMkx4qNGh
 sO1aWxCbgeo88xfLUSwYsHj/IMuMgrcE/1/+6hRZTiBKfcQkhGIC+AWVOtRjVovddibw
 4ZmRGTWvbpO4XLfR/w9wR6y8AM2puNSUuYGy/PUoFXps4rQECKyz423wXQb0kWM1rWMP
 pP3AhWULmg+uz3+MjZRhPd65cKiZyifwPM5uqsnnk1zzJRoGKd8+msaxPvqTnF+KuXZO
 Sf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754463720; x=1755068520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMmbs0AJOQ1PJnetP8zgjNmqNEKkDyDpVl5S892by74=;
 b=W9Wq8/ROxZ/C5GUwOLKWrkQLzCxpt3BazNyRakMMlUtG5ShBRfDOgFF7cT+YBCWM88
 grUxYXtMJAnplWFxPZvgnK2dYvKoz8ITTmeoTJPiOMjF+ijw2gVr7Mepsnc9vuVl1DWV
 cqUuS7I4tgmQf2k9Ik+NzY3JvdN0E3Q2eKqxbNf+mcFtvaYs+0fEQG5yWtaon2wnRFxq
 168PwDrs4V8Mxl2sQGJgzuhbesdHWgQOshRw1g7/BQDpyjHjkQqsrCuh5yE7QUQdq3lu
 bF6da2WCokl++wEvMVeExVtHto4sK/c+ghsVOIpYkjA/rKqnbwKY7fJhXdJTMEuHj1Vh
 SdPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDB4A3oujfi5Kdas/JhZ0mGxF1r+A6ueIaMClJOSjxpyZAQwzpictE5wpbJwqMJZ5XB2T3K8RWTmmY@nongnu.org
X-Gm-Message-State: AOJu0Yx6OiifRMRUJ5v/j9URyJKQiYGklL20A2l+xw3GTQHI2QOc7f31
 Gw5vGelz0tm66VyzkSi7Y7/EBp6ddqD31cKaVGIAawtxgBhvzVEidF821ncASuOI7BQ=
X-Gm-Gg: ASbGncvqZsdUVITZ86wPIgzUo763R0k0x69ATSgZ1NOY62eeKxAtED3vH6mU0sCv7rv
 haumTxSRVh7Y3CaSSSEFNRgEQA5DbUDc1R0IR1LcPyK1O0r1sCmUA4uQA68IHCTg7zNyyJ5EwIn
 OiGPgOo1mbI5zjPGQ1aV0gC6jY9gvPSAtqPXY/Bmq0QoNBBMiAG5FdryE3wrRaHKA6h6T7AAmMA
 3gkcwxfnhoDjcND0pe9vFKyTmkHBktKEOg3pJeUfCAQ0XKWSCHOnfMUsndNiTsRhhCSE6HVUTK0
 Rv/cO6N1LZJ2sRXpO55FebPfdawPzO+RMPzHGtAeYJ5b40jfPBgl8qhxlDQDmuKaQxUCl1L+i0O
 0ESePDE1FuHNx4SrDVEmx9yjm3kXTzZa0TSH4kF9uFujwE9Afh49+/6G8NrADKMb0Tg==
X-Google-Smtp-Source: AGHT+IEUvLBfveGLZDDIPD0fBuvSxTu359gsp/Al3uXsDWOn86VFhShAklxGozcCpiwEuZh22RrbyA==
X-Received: by 2002:a5d:588a:0:b0:3b7:8646:eeb3 with SMTP id
 ffacd0b85a97d-3b8f434dbfcmr1489389f8f.15.1754463719870; 
 Wed, 06 Aug 2025 00:01:59 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm21704574f8f.25.2025.08.06.00.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 00:01:59 -0700 (PDT)
Message-ID: <fb2867b2-4e4b-43df-9cd6-ba476cde6379@linaro.org>
Date: Wed, 6 Aug 2025 09:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <9e9d4d6e10a2eaaca2d741184ba292d699ddff7b.1754310749.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9e9d4d6e10a2eaaca2d741184ba292d699ddff7b.1754310749.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Kohei,

On 4/8/25 14:57, Kohei Tokunaga wrote:
> Currently there are some engines that don't support wasm64 (e.g. unsupported
> on Safari[1]). To mitigate this issue, the configure script allows the user
> to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].
> 
> Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
> this flag lowers the output binary into wasm32, with limiting the maximum
> memory size to 4GB. So QEMU can run on wasm32 engines.
> 
> This commit adds "--wasm64-memory64" flag to the configure script. This
> takes the value to propagate to Emscripten's -sMEMORY64. 1(default) targets
> wasm64 engines and 2 targets wasm32 engines with still enabling 64bit
> pointers.
> 
> [1] https://webassembly.org/features/
> [2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   configure | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 7f3893a42f..8573f84e26 100755
> --- a/configure
> +++ b/configure
> @@ -182,6 +182,8 @@ EXTRA_CXXFLAGS=""
>   EXTRA_OBJCFLAGS=""
>   EXTRA_LDFLAGS=""
>   
> +wasm64_memory64=1
> +
>   # Default value for a variable defining feature "foo".
>   #  * foo="no"  feature will only be used if --enable-foo arg is given
>   #  * foo=""    feature will be searched for, and if found, will be used
> @@ -239,6 +241,8 @@ for opt do
>     ;;
>     --without-default-features) default_feature="no"
>     ;;
> +  --wasm64-memory64=*) wasm64_memory64="$optarg"
> +  ;;
>     esac
>   done
>   
> @@ -537,7 +541,7 @@ case "$cpu" in
>       CPU_CFLAGS="-m32"
>       ;;
>     wasm64)
> -    CPU_CFLAGS="-m64 -sMEMORY64=1"
> +    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
>       ;;
>   esac
>   
> @@ -795,6 +799,8 @@ for opt do
>     ;;
>     --disable-rust) rust=disabled
>     ;;
> +  --wasm64-memory64=*)
> +  ;;
>     # everything else has the same name in configure and meson
>     --*) meson_option_parse "$opt" "$optarg"
>     ;;
> @@ -920,6 +926,8 @@ Advanced options (experts only):
>     --disable-containers     don't use containers for cross-building
>     --container-engine=TYPE  which container engine to use [$container_engine]
>     --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
> +  --wasm64-memory64        Used only for wasm64 build. Set -sMEMORY64 of
> +                           Emscripten to 1(default) or 2 (choices: 1/2)

I wouldn't expose "1" or "2" to the users. Instead, keep 1 as internal
default, and provide the --wasm64-32bit-address-limit option which sets
internal value to 2. Configure help could be:

    --wasm64-32bit-address-limit    Restrict wasm64 address space to
                                    32-bit (default is to use the whole
                                    64-bit range).

WDYT?

