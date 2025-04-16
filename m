Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58910C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4zAQ-0005Io-Gt; Wed, 16 Apr 2025 05:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zAA-00056G-Rt
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:34:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zA9-0003ib-5s
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:34:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so31386285e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744796071; x=1745400871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8RE67alAjoASMhiOcaVhVadwtMNesEy3c/I5HlCpwY=;
 b=r9PGPyshFHCO7mlqNafiG2gNt8fxfsNY7Hh6jQRR5rQSQP2xBjH+kfghq12fTDugUC
 ENAnN2FgorFf62roP+lnl3m2U3JVHLr/sV3I2OgCC+GZyd73I4Adw2reDTJgbA3uylZr
 dOuMqEkop4nMGUjrdiXSbYYwddn/UnjUSXiFVcHsfALINCLBLMHkJ0hXOPoec0wwhgc9
 +B5Pq6mOML91pn8BYnDBDbO2WP8accg2G41nUtGpDk6L3jGWjND2gSjm/PPlQN+p0Uhj
 3z7XmPjqwCDg4j9ngqUZ4Z0A21ITtfLTrelc+TlXyusEPhoLfMJ5UyRiub8+rdTM5p9Q
 fqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744796071; x=1745400871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8RE67alAjoASMhiOcaVhVadwtMNesEy3c/I5HlCpwY=;
 b=WJH7XRna+xSSKcMEznfIDtd+HEtqhTTP8afyxW/1VsfhuHPvVgbUvkJm01dO/OQtPl
 F+wsTCCpVhXu7W+3TD6rQcfYt0F76o5sitQ/BqOFBJfjtQ4xd+BTBTAvrddmn0oZvMTb
 gp0+WRyeTVDACZKP+1ZA+PLwCEousr3EiMxQdnX/GByD/2m7zPV5GXxl7ykcAvLEVDhS
 6id5xn/dlyHjtlOfgLRD/pBwstvPvdJQN0efTHyxlGWxfn0/yJjSaT8zEByoCyYx7oDs
 SVWb5If2ugJw8OgPTM0PsDnWMasD6s2SnuNOFYhrr7JbqNtMMqb3uJD1MWxJsP/IY5BW
 6yhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZGxYRNdHaRJBm3uEF0iW2hTgbeW2uNHtWmeLwNOxphQjKkCRb2bdLzP80NGWE2KNW7WSB+UcfTYd7@nongnu.org
X-Gm-Message-State: AOJu0Yx71WF39jJZaezbrdZq4HfoOERCXEucZkgqrHybxbGm+CvAp5c5
 W/U+jmoVqnjhc0f8DnriAOsY6iBjfuIJF4ZhmhPgQdhv3Bh5ewMR6Ntv2Q+IjEs=
X-Gm-Gg: ASbGncsfgBEIXmic2OdGzg6FGcSwFT480GI4x2im59/rLqv2bY/OoDPLKLf01aZ6KMj
 DJoa4pFXly7Qms4GviJr16HUt48v4yQRLVrBVOm9e/PzaxgAcHTG6RPZ48WwMd8mKfZP5XmmS9n
 XFWVAKGcFtshr6KTINJ6CTOweN+a1Ab1mQZUxFzFTAGcQgU9q7cpzsOk+oBEfaQ3WMi9PsCNRUP
 g6GUrIoTEyDHf+GxGzxUXKMfIghnj1r2aAXE6UKTloOg2yML9Zw4v1F8mMCVbHUjWlqEUjOPGzK
 HsWqJ3vidbU2F3/zsL11MhZKaYNgSoanl82mfioyY72gvy6KPk4dKKtLWE+5Iz9Gqya4HIlmyck
 DnOFHru8V7phYMA==
X-Google-Smtp-Source: AGHT+IFZ9m6cCDolsj2GC6HuIetgLaP77+2IWEgalQBgBKiqcyrAmQoQnlwdOI3bHxToFTefBT8Pxg==
X-Received: by 2002:a05:600c:c0e:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-4405d616849mr11611425e9.8.1744796071495; 
 Wed, 16 Apr 2025 02:34:31 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c7ef9sm15769595e9.6.2025.04.16.02.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:34:30 -0700 (PDT)
Message-ID: <4962b53d-c507-49df-91b4-cf51d724e8ea@linaro.org>
Date: Wed, 16 Apr 2025 11:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] MAINTAINERS: Update MAINTAINERS file for
 wasm-related files
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <185cfff812b952abb24e25dfcc8bab7c65da6214.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <185cfff812b952abb24e25dfcc8bab7c65da6214.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/4/25 10:14, Kohei Tokunaga wrote:
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f8..74a102c594 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3903,6 +3903,16 @@ F: tcg/tci/
>   F: tcg/tci.c
>   F: disas/tci.c
>   
> +WebAssembly TCG target

Just "WebAssembly target"? (I'd add the future
tcg/wasm/ files in another MAINTAINERS section).

Maybe better to squash with patch 17? Or start adding
the section when you add a new file, then update for
each new file added?

> +M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> +S: Maintained
> +F: configs/meson/emscripten.txt
> +F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
> +F: util/coroutine-wasm.c
> +F: os-wasm.c
> +F: include/system/os-wasm.h
> +F: stubs/emscripten.c
> +
>   Block drivers
>   -------------
>   VMDK


