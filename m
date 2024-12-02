Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE670D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAGp-0006xn-M7; Mon, 02 Dec 2024 12:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAGl-0006uL-Lm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:31:36 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAGj-0001ct-Aa
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:31:34 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea43811488so2044486b6e.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160692; x=1733765492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=es0N1fwqvUHRfgCZK8xemmMR7Yj3671PmPOFtLTwAoQ=;
 b=sqjGNJiyQLX/k2hXM0C9YO8mZC92XkHBVXFoqEc8NAWgl20RQFA+xz8ihQJj+Jn2xx
 /m6y6MaEfYemTt97l6J0VByqASMTXFMTZAUwVdycxWQyOUaWvjXD0pTWJV9Imss+Zm7k
 BMeZwuJlyH0Zbs2Zg+Bqg3Nths4DNE4n4ds/TK0wJJCDhYSCSdu01oQ2QY/0rnWt90v8
 +JsxLIYtqjcXyYxpP2lH+nss5CGUr1moqFI6fQQQhZp1umPK3dO5Voi3jW2wIXrCogeZ
 VJLKJeTJi2dlZQaOG5pQv8CfcHLdXXAxuur4lB+7UKs837HY+escrjeZZR3UZ8Pjqyui
 7bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160692; x=1733765492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=es0N1fwqvUHRfgCZK8xemmMR7Yj3671PmPOFtLTwAoQ=;
 b=JXyI2clHwWuWsHcN4oP8+mmjcxDgwVR3haW6AKGZaBSDT4ptfceue/+qgUVEkubd6r
 6BqprC60piEZPh3VwTh+oHPp50fLEMNJFncI4wtEQ95OFurDvkrOL+eW7m+ZPAYKF5Hx
 8ck12tRX2RwXUvhHgXdvzeszDvR5/lTYMg//jTdCFFuQ/5cdn2jK4FfHU0u5XGOKf1L8
 xU8aRy+XWQ9GoGNfzk+SHKVMDtjWS/HoqOzlGdzhlbT0aSOrLwPhYQY2Xa0S3X/j88gB
 K5dC/AmWwDQT1N4qE9A0ovYaFMPmv5yabwSsLp7CS6kIHoRlQtBerTq4W1ZeTWA9Seil
 wsfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzXD5s8RWRy0J5AIPPj9WGumDV4D6Ad9yFoyKhmoxbYeuXNgJlR7atvgGViZLtIJy+dpccwd4PaDsH@nongnu.org
X-Gm-Message-State: AOJu0YyKxefiRm/rKLqX5uFZXQPqXWaN8JQ7+iBqJ4qaG5CCUNncBwS6
 dtoF0zIU0/mBXFW67UGw6QXgB3iZFPKYW8E3iztnyQVMCsihpDwq8WVnT/wH0/M=
X-Gm-Gg: ASbGncsGFr1mJUB8VjdxuztATQLF10+5Pr9szJ5cPt3Wk9d7cN4lBdSG86Wmv5mpUXc
 eVLzmVESsj0EhVSI4ELU/4+ZnZ1o8Ae9ShAz2gpfN7SlshwbHfQsaJmyGRw+BdTPKHcsjMyqPpK
 BD7PnuGLJajNiMMI5tmnXsrYBEcurKsWWZNhovcwvY9ujYg5IqaQ8OSETUFe9lwlaoGVU9+s5wn
 rehtqHUNZpIkK2HF0YfL6MreoDeserM6EwUMmMOs8EyXzupxlx2V+wbJ7MnHusGhM5Uvrc=
X-Google-Smtp-Source: AGHT+IG53Et3kvannqcn603gzlrO8ififHUNdEMCQAck8Z1cplnsCoD0k3PgLN9X1FwIk0WRw7dssQ==
X-Received: by 2002:a05:6808:3087:b0:3e7:f020:e19b with SMTP id
 5614622812f47-3ea6dd4f0afmr19584375b6e.32.1733160692188; 
 Mon, 02 Dec 2024 09:31:32 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725602f9sm2362753a34.39.2024.12.02.09.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:31:31 -0800 (PST)
Message-ID: <c182b1bd-5fc7-4382-acec-aeddb00ca179@linaro.org>
Date: Mon, 2 Dec 2024 11:31:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 43/54] target/mips: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-44-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-44-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for MIPS. Note that this
> is our only target which currently changes the default NaN
> at runtime (which it was previously doing indirectly when it
> changed the snan_bit_is_one setting).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/mips/fpu_helper.h | 7 +++++++
>   target/mips/msa.c        | 3 +++
>   2 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


