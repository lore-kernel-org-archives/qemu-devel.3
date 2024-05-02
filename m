Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348EFC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Rhl-0008NV-L0; Thu, 02 May 2024 04:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Rhj-0008K4-Es
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:22:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Rhg-0000GO-9A
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:22:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34d7d04808bso1473626f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714638125; x=1715242925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EHY18lh0BUVGF0HFA0xXc+cjO6AHTJfJWccfF6f/gR0=;
 b=R48ZAalggbVySECk7Za6mVeR5YlUMnzdaFuk5onHsG64/9wvPta3gxVSdfCLYTZpN+
 6MiDzB7jBUF2YVuL8X84Y+3cUAyG+NTUtGqw9VQBg09WKCGMv5OeGuMMbU/KjeMl7TA4
 QfiV+3Kczfq5FmLQ8OoUUoI+iKNKiygbMoKsTCs9lwpf1wCFKnsjEdHZXUfloz9pqPI6
 kgfHHLM2wDyIVHBa2yDBduP8GVP97CGozLAn3hNtER41svE8VIcgMuwZGS5RxQhVV2UN
 utHaEe48QQE/+9DUP+rEq3pRFQyBqaaLJJe3QcgAhVydkXSyvuSdNSvH/Z2sJe6J976H
 ht8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714638125; x=1715242925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EHY18lh0BUVGF0HFA0xXc+cjO6AHTJfJWccfF6f/gR0=;
 b=fOQwS64Qu3gTOVOmjse/p5X4U963gMsTDlCA7yl7sNxoFZqTk5UZFxZwxJJPFaZW+v
 BSLzvK9iHVZFDUyz5BX+Z9P831El+cLWq06HO2FOMJRO7BPxjfZszHtmA2AKZ4mkGmxb
 aLJ3MDxihASyehGCVAqN2kwHWRqSK0r/g+fy26USfmDQi2hzBVriImQWoZFAbRY4pIFr
 z4+wT1/vzwqAkYNiYKzsQBNzKIea1kvx8K5Lu0pFlsC7yNnTC1y1zQMdr4e1l7fMvziE
 lEM+gD5DJq6dBVi30W8+GGv3vzUuRlxPCCoGsrHideSGbclzhAEEluMvkcWDpCFnRTPx
 MStg==
X-Gm-Message-State: AOJu0YzJeF/nIHPQgKOJtKZQiclc7NaxCKXsG73KrSGTKE3y8wpMsCP0
 FVXsdkIf8cuMcDZX8EX5/LEFS+0yI1xdV4l03fECB+1T9Af5pmu5lqPsg4aC3dB847w6ws/4XFn
 h
X-Google-Smtp-Source: AGHT+IEdzuqVSoxv6aG3LhmNDECIviYecXTTUSd2D8tqOfQscUT0ht2PjHN26Zx2b6MBGGWUeuqmEA==
X-Received: by 2002:a5d:5405:0:b0:34d:ac04:5aed with SMTP id
 g5-20020a5d5405000000b0034dac045aedmr1054814wrv.66.1714638125284; 
 Thu, 02 May 2024 01:22:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a5d5267000000b0034dd13d7a5esm644531wrc.65.2024.05.02.01.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 01:22:04 -0700 (PDT)
Message-ID: <d67338f5-a13a-4663-b77d-f9dac2b2936c@linaro.org>
Date: Thu, 2 May 2024 10:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: Allow building with GnuTLS but without Libtasn1
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240502081144.86599-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502081144.86599-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 2/5/24 10:11, Philippe Mathieu-Daudé wrote:
> We only use Libtasn1 in unit tests. As noted in commit d47b83b118
> ("tests: add migration tests of TLS with x509 credentials"), having
> GnuTLS without Libtasn1 is a valid configuration, so do not require
> Libtasn1, to avoid:
> 
>    Dependency gnutls found: YES 3.7.1 (cached)
>    Run-time dependency libtasn1 found: NO (tried pkgconfig)
> 
>    ../meson.build:1914:10: ERROR: Dependency "libtasn1" not found, tried pkgconfig
> 
> Restrict the unit test pkix_asn1_tab[] variable to CONFIG_TASN1.

Otherwise we get:

   In file included from tests/unit/crypto-tls-psk-helpers.c:23:
   tests/unit/crypto-tls-x509-helpers.h:26:10: fatal error:
   libtasn1.h: No such file or directory
      26 | #include <libtasn1.h>
         |          ^~~~~~~~~~~~
   compilation terminated.

> Fixes: ba7ed407e6 ("configure, meson: convert libtasn1 detection to meson")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build                          | 1 +
>   tests/unit/crypto-tls-x509-helpers.h | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 5db2dbc12e..837a2bdb56 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1912,6 +1912,7 @@ endif
>   tasn1 = not_found
>   if gnutls.found()
>     tasn1 = dependency('libtasn1',
> +                     required: false,
>                        method: 'pkg-config')
>   endif
>   keyutils = not_found
> diff --git a/tests/unit/crypto-tls-x509-helpers.h b/tests/unit/crypto-tls-x509-helpers.h
> index 247e7160eb..bddf00d392 100644
> --- a/tests/unit/crypto-tls-x509-helpers.h
> +++ b/tests/unit/crypto-tls-x509-helpers.h
> @@ -23,7 +23,6 @@
>   
>   #include <gnutls/gnutls.h>
>   #include <gnutls/x509.h>
> -#include <libtasn1.h>
>   
>   
>   #define QCRYPTO_TLS_TEST_CLIENT_NAME "ACME QEMU Client"
> @@ -171,6 +170,9 @@ void test_tls_cleanup(const char *keyfile);
>       };                                                                  \
>       test_tls_generate_cert(&varname, cavarname.crt)
>   
> +#ifdef CONFIG_TASN1
> +#include <libtasn1.h>
>   extern const asn1_static_node pkix_asn1_tab[];
> +#endif
>   
>   #endif


