Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DD6D3A66F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 16:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5p7s-00010L-Kn; Tue, 29 Oct 2024 12:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5p7o-0000zp-KW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:31:21 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5p7m-0000pe-HE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:31:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so4093561b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730219476; x=1730824276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GluvrkFpzjprinBJrorJ6GPoWP4Kppr9WPEXb916Ol8=;
 b=AxhMNeJMfLItRp6z0s+7leViic04Oz3nynfDuC2raNGgC1z8iIZ00B3nuB7w2hBv6U
 W4EMju7WGIWtSuHFqYmx0Ye6Cl9l26xyf770aWdHezevvQ8LhPXpOGIi/Cidv9v3CgqU
 k+VslFg4QmxFqYv58GztbY3Yz4ZtVlnfFxDq9Ob0jyWRmksP6IDk88F6QwDS6a0Fd3aM
 ddD8GtuIu8EMAbpogQJ6NL3Cc5XVSKDDKO+ubItlusy7pIUr4LY5hIh/XgSqJPE5jkRl
 uwyw7jYG082vU+6sr4UcndRPZkrHKJd5Fl2OGjAppBvhAxHkKGX57znhZFGxHX4XbmHT
 lHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219476; x=1730824276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GluvrkFpzjprinBJrorJ6GPoWP4Kppr9WPEXb916Ol8=;
 b=kZ8HyJgZSE+iPb9Fsrll5DY6VI7L5z3hcAy1kCESKQVikX1NypImU/k8+uZE/ZQ3VX
 iUhn5JNvqxrFhdPT1w9Bbq2sYj9eBP/4gFXUOKuW2Vsna/m0q11mmH2xDdFZwSgDpqGx
 z8y/eR0t+bF9sEchn7oNxDGnJoMgaOytxz9ax5ZW1Dj11YavWJt60bZL+3K8IctbIL2i
 jCQ9bt2v4vrw4zwkrBgABfKmE/7re77IEJesmxMVJtEHoM5Hsn8DS0gR1DXkbVWXGaDe
 pLs6pqmm7EJIQkE58OS7T9lRT60hd82JJbIXjhd9GfD+Tl3AP1w6SZIE39zPf8+OfWJ6
 AHTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUC3o8SFyPF3SBZ1qXmyKsdFtN+je1I+tATemITGMo6kbA63cxYmxNYR/wc48da7eS9npOJ/jc4mCk@nongnu.org
X-Gm-Message-State: AOJu0YykO4dTNfnOiCCrqjZ/U1LqCOczPBJNQko4BYwbJluHDNTBgjR2
 f1II2CvjyDr5pXkFYtPDhiNPhigUQzCXJRm+MKcWGteHgamYgVwctJZpwW+zGpA=
X-Google-Smtp-Source: AGHT+IF0OZUtFM5HbXrxMxCFkvz81regxiylae73oX4bdOf9tftE7gOu/u23BmMdlqlg8COXG8Khew==
X-Received: by 2002:a05:6a20:439f:b0:1d9:a72:87e9 with SMTP id
 adf61e73a8af0-1d9a83a3dc9mr19430899637.10.1730219476344; 
 Tue, 29 Oct 2024 09:31:16 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a3c2c9sm7710532b3a.196.2024.10.29.09.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 09:31:15 -0700 (PDT)
Message-ID: <c5ff463d-c5fb-4d00-95fc-f3c3ce9178d5@linaro.org>
Date: Tue, 29 Oct 2024 09:31:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Convert the BananaPi and OrangePi Avacodo tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Joel Stanley <joel@jms.id.au>
References: <20241029092440.25021-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241029092440.25021-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Hi Thomas,

On 10/29/24 02:24, Thomas Huth wrote:
> Some of the URLs in the Avocado tests stopped working since the
> original assets have been removed from the servers or moved location,
> see:
> 
>   https://lore.kernel.org/qemu-devel/CACPK8Xc=jsz5iT_WR7s-rcu1cRzryiK+-0o=6vUK_D_qMMrP3A@mail.gmail.com/
> 
> Since we are currently in progress of converting the Avocado tests
> to the new functional framework, this is a good opportunity to convert
> these tests and adjust the URLs (and hashsums) along the way to make
> these tests work again.
> 
> Thomas Huth (2):
>    tests/functional: Convert BananaPi tests to the functional framework
>    tests/functional: Convert the OrangePi tests to the functional
>      framework
> 
>   MAINTAINERS                           |   1 +
>   tests/avocado/boot_linux_console.py   | 411 --------------------------
>   tests/functional/meson.build          |   4 +
>   tests/functional/qemu_test/utils.py   |  21 ++
>   tests/functional/test_arm_bpim2u.py   | 206 +++++++++++++
>   tests/functional/test_arm_orangepi.py | 270 +++++++++++++++++
>   6 files changed, 502 insertions(+), 411 deletions(-)
>   create mode 100755 tests/functional/test_arm_bpim2u.py
>   create mode 100755 tests/functional/test_arm_orangepi.py
> 

I have a general question regarding tests in QEMU.
Is the current goal to convert all avocado tests to functional ones, and 
then remove avocado from codebase?

Thanks,
Pierrick

