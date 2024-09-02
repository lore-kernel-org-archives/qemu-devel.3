Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95DCCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 19:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slCzM-0002el-MQ; Mon, 02 Sep 2024 15:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slCzB-0002dn-0l
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:45:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slCz5-0005lv-B0
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:45:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so38180395e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725306306; x=1725911106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KbeEd1FJSCDvgYbk3SHeYsIWUHUjSDuizEa3L2eFbCw=;
 b=y1xWCQdQGzwX/5qEbhew+YeJAHZxgkaRv/Hgc0CQiYbL4TWpWGCG8BnFJay3QDugWq
 AHfbxEtApGoFdQ5dRgo/eRpt9nF0U6wAv0m6pQnqN5ZhjoPFZg8f6WWDemQasETNW7oL
 eqa2mc8M1cjAhDlcaA4/BO7rYPuM71bwpDzO4ic8Xu0DUtCIKlC24As4Vb3RXj3ZtUBZ
 MjhZ8w54fSfqKsz69WCFCKPOBSWVpsLSki6cEnywVzfn4yYB/Eh8LhYr/pwprU8kNxbe
 QMY1vw/01YLSZhOw0+J2ooDTMibZIL3bQfwiDc7jQXtC4iOCGKOVuwcnNEuyLOPzOxSo
 YL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725306306; x=1725911106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KbeEd1FJSCDvgYbk3SHeYsIWUHUjSDuizEa3L2eFbCw=;
 b=RscRMaVzpOK8nZtSpZY7j7t0fBIzwfoE7Erdu9l6djpgAQp/VNEViVTMnITpmMLkir
 mir67trrlyVSdwE8OW/O3v2g40f9gC1nhl2VbDOh53AFOWby8VUjCRjH0gtQ9toHTlLq
 CKNxc0PKZzHm8Z4GJiE+0PfljLaukbWvFO4ly+F3bJFp+EnTy/HpohdSQVdf6sIzid9l
 EFPIFiHFzDKnTnxC2qvaJfigzA64B3h6wO0V12v5BUvZyr7tNOZvh6lbd/g1yoQBgl8Y
 7isB5niKq3BYJtOicQWQw7/z+4+fJXywCBcYT1CT0PY6BBORYn6257GJfrdYNtKMSnYt
 BKXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrJOj72H7ljIhIs24JP3gkgN+Fo05HCGpDk8dsMAel8J1LATL37vLuNWwG1WDwjmoXdCMt6b9j8Jsi@nongnu.org
X-Gm-Message-State: AOJu0YxSnEFu5X2nkOdl8WX2H8wQUqx7tLBMu6sdw22tC/XwJL6VIOVJ
 HqgLIxVZfe+NzQbYpJws4s22NCX2C9UP2qxZa3IdvkxZPuWU6lWcerPxxQDNY7ecGdCxrLfNz8+
 fsMw=
X-Google-Smtp-Source: AGHT+IGTwYz2O9IuIn5uhf7V/A+LhxiL3BfOM3gG6YFNa0NCjpkFtKNDdpjy33G4SPdXbzgxX9fz9Q==
X-Received: by 2002:a05:600c:3547:b0:426:5dd0:a1ea with SMTP id
 5b1f17b1804b1-42c7b5d8f34mr51354595e9.28.1725306305631; 
 Mon, 02 Sep 2024 12:45:05 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba642594dsm184314075e9.47.2024.09.02.12.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 12:45:05 -0700 (PDT)
Message-ID: <2d0ade1c-42db-49ce-85b1-9c73a34ef015@linaro.org>
Date: Mon, 2 Sep 2024 21:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/unit: always build the pbkdf crypto unit test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240830110533.2544070-1-berrange@redhat.com>
 <20240830110533.2544070-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830110533.2544070-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/8/24 13:05, Daniel P. Berrangé wrote:
> The meson rules were excluding the pbkdf crypto test when gnutls was the
> crypto backend. It was then excluded again in #if statements in the test
> file.
> 
> Rather than update these conditions, remove them all, and use the result
> of the qcrypto_pbkdf_supports() function to determine whether to skip
> test registration.
> 
> Also add CONFIG_DARWIN to the remaining condition, since we have a way
> to measure CPU time on this platform since commit bf98afc75efedf1.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/unit/meson.build         | 4 +---
>   tests/unit/test-crypto-pbkdf.c | 9 ++++++---
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 490ab8182d..972d792883 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -121,9 +121,7 @@ if have_block
>     if config_host_data.get('CONFIG_REPLICATION')
>       tests += {'test-replication': [testblock]}
>     endif
> -  if nettle.found() or gcrypt.found()
> -    tests += {'test-crypto-pbkdf': [io]}
> -  endif
> +  tests += {'test-crypto-pbkdf': [io]}
>   endif
>   
>   if have_system
> diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c
> index 43c417f6b4..034bb02422 100644
> --- a/tests/unit/test-crypto-pbkdf.c
> +++ b/tests/unit/test-crypto-pbkdf.c
> @@ -25,8 +25,7 @@
>   #include <sys/resource.h>
>   #endif
>   
> -#if ((defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)) && \
> -     (defined(_WIN32) || defined(RUSAGE_THREAD)))
> +#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWIN)

Add CONFIG_DARWIN in a subsequent commit?

>   #include "crypto/pbkdf.h"
>   
>   typedef struct QCryptoPbkdfTestData QCryptoPbkdfTestData;
> @@ -422,13 +421,17 @@ int main(int argc, char **argv)
>       g_assert(qcrypto_init(NULL) == 0);
>   
>       for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
> +        if (!qcrypto_pbkdf2_supports(test_data[i].hash)) {
> +            continue;
> +        }
> +
>           if (!test_data[i].slow ||
>               g_test_slow()) {
>               g_test_add_data_func(test_data[i].path, &test_data[i], test_pbkdf);
>           }
>       }
>   
> -    if (g_test_slow()) {
> +    if (g_test_slow() && qcrypto_pbkdf2_supports(QCRYPTO_HASH_ALG_SHA256)) {
>           g_test_add_func("/crypt0/pbkdf/timing", test_pbkdf_timing);

While here, rename test_pbkdf_timing -> test_pbkdf_sha256_timing?

>       }
>   

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


