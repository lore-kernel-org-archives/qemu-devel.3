Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F80D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k9t-0000VR-Dk; Wed, 06 Nov 2024 12:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8k9r-0000UV-QX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:49:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8k9q-0007xy-0g
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:49:31 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so70009f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730915368; x=1731520168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z3zZTuAWMPqZtLStShkxuibSjf2uSZo4ezuSk39jN+A=;
 b=T9ZT4CmOwiZ5AfvftTh86CYmr6hHpDGulZv0q3Zhv92lnPwB74YoQIIel6nQ/ttpVI
 U73aHSWY0BefTxfc9pDZEg/2Rstd71d4YmGL9/O3TqzsZZIrb0L5/MIOAZ/qoV4WfJYy
 3jCkvxNSAGbFNlRUjIrNxooK8g8LFWL9d4CW8TE9X6cjT+kCu4n7YbgRGeMUQJxbbQlE
 Wy9ne78dX6G/SaiMqvIbpPl7tW5nhNSi98mHV/Bj+v25KC22Nv9qNHf5t3f/pq232+aM
 ZL2ZZrUN9qOBYuAtbQ2QNEM5rfLmEoNvAXmjFg0/V3rCi32lynyjXeGoRjPvVx6YvEVX
 aISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915368; x=1731520168;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3zZTuAWMPqZtLStShkxuibSjf2uSZo4ezuSk39jN+A=;
 b=hFuddUj7wp9QXsaoSLf+vPiQBqHFQYHrXNfzY08xqKbHX6HUZz9xb23CQLAOCfA8J2
 KQXnGLrKDFjZUU0HeaN8dEBMey1Et1XM3ez79scmmuAPhrUjRATtGydWItDagRTHjwpr
 KzYw5Lijyuaup7Fh4mku8TUvHgvaO0udME0Kd75VaAzfesbdEZCxDxijzhZqu3G6FPjf
 KqzCuRnGqWjID6orhE/dvGAQj1dmnh0ABoN9TN45mI2KF08EovbTsuMFSW1xKsiMfJqB
 h7q26e60Glm8zkUxHVro5rNmLr8QzgsH7lb+inx0hmRz6iIn5rY+i+uPIEuQvsUTLVxI
 mG2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7u13qkPvpBzwcnt0pX1NZ2f92StCNO8u2HugMDSBUuzjjdeQJkx74Wab6l20FECJ3f2UgKIwvuij0@nongnu.org
X-Gm-Message-State: AOJu0YwUhv5jNRo/10loUfVRjQoLED+UPQnfDe6fDCugm+HmcNDX8OnR
 ZI7t6s9B8ukXicONQtBAnNypUtS33kBKw4a7NFOa9nL6VLxbW0Y4PTSl/dhynFo=
X-Google-Smtp-Source: AGHT+IHI9Do4cUezWn1dmEIX8tOY51ymGD3kIOVIbMfEe/idaUC9m6KlKjtbl0nwzYu70lL4N3wKUA==
X-Received: by 2002:a5d:59a2:0:b0:37d:3780:31d2 with SMTP id
 ffacd0b85a97d-381ec5e266fmr100253f8f.15.1730915368446; 
 Wed, 06 Nov 2024 09:49:28 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5e3dsm31385925e9.9.2024.11.06.09.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:49:28 -0800 (PST)
Message-ID: <c13cff41-d413-4977-ba2d-2be20de33aba@linaro.org>
Date: Wed, 6 Nov 2024 09:49:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: add meson_version to all subprojects
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241106174531.558197-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241106174531.558197-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

On 11/6/24 09:45, Paolo Bonzini wrote:
> Otherwise, newer releases of meson complain.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   subprojects/packagefiles/arbitrary-int-1-rs/meson.build         | 1 +
>   subprojects/packagefiles/bilge-0.2-rs/meson.build               | 1 +
>   subprojects/packagefiles/bilge-impl-0.2-rs/meson.build          | 1 +
>   subprojects/packagefiles/either-1-rs/meson.build                | 1 +
>   subprojects/packagefiles/itertools-0.11-rs/meson.build          | 1 +
>   subprojects/packagefiles/proc-macro-error-1-rs/meson.build      | 1 +
>   subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build | 1 +
>   subprojects/packagefiles/proc-macro2-1-rs/meson.build           | 1 +
>   subprojects/packagefiles/quote-1-rs/meson.build                 | 1 +
>   subprojects/packagefiles/syn-2-rs/meson.build                   | 1 +
>   subprojects/packagefiles/unicode-ident-1-rs/meson.build         | 1 +
>   11 files changed, 11 insertions(+)
> 
> diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> index 34a189cbaec..cff3f62ce74 100644
> --- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> +++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('arbitrary-int-1-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '1.2.7',
>     license: 'MIT',
>     default_options: [])
> diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
> index a6ed4a8f0cd..e69bac91b40 100644
> --- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
> +++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
> @@ -1,6 +1,7 @@
>   project(
>     'bilge-0.2-rs',
>     'rust',
> +  meson_version: '>=1.5.0',
>     version : '0.2.0',
>     license : 'MIT or Apache-2.0',
>   )
> diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> index 80243c7024d..f8f3486fc08 100644
> --- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> +++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('bilge-impl-0.2-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '0.2.0',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
> index a5842eb3a6a..608e64e31fc 100644
> --- a/subprojects/packagefiles/either-1-rs/meson.build
> +++ b/subprojects/packagefiles/either-1-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('either-1-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '1.12.0',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
> index 13d2d27019d..30982a4ee76 100644
> --- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
> +++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('itertools-0.11-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '0.11.0',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> index 38ea7b89d39..ae27a696862 100644
> --- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> +++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('proc-macro-error-1-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '1.0.4',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> index d900c54cfd1..3281b264333 100644
> --- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> +++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('proc-macro-error-attr-1-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '1.12.0',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> index 818ec59336b..288323eaba8 100644
> --- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> +++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('proc-macro2-1-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '1.0.84',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
> index d36609bd3c8..7f7792569b9 100644
> --- a/subprojects/packagefiles/quote-1-rs/meson.build
> +++ b/subprojects/packagefiles/quote-1-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('quote-1-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '1.12.0',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
> index a53335f3092..bb3c15539be 100644
> --- a/subprojects/packagefiles/syn-2-rs/meson.build
> +++ b/subprojects/packagefiles/syn-2-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('syn-2-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '2.0.66',
>     license: 'MIT OR Apache-2.0',
>     default_options: [])
> diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
> index 54f23768545..9d76ebbd1ad 100644
> --- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
> +++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
> @@ -1,4 +1,5 @@
>   project('unicode-ident-1-rs', 'rust',
> +  meson_version: '>=1.5.0',
>     version: '1.0.12',
>     license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
>     default_options: [])

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


