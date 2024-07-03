Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329D4C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0iE-0006zu-63; Wed, 03 Jul 2024 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0iC-0006yn-JR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:11:56 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0i4-00024Q-3M
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:11:55 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a729d9d7086so128742266b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720015906; x=1720620706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xrStVSR/S6iqC36MaUVaGjHdT8yj8NhP0BQvwC2mvCA=;
 b=Wb4InHC8gMonmWdW5OA1lmcB/3g0nZKIgHWaKDZeicz6Oyk7Bs6HfkvdJg8TFnksCv
 DMINOOR64Lij/q07BucgHyaNtlzWK89Fc1dz1j3GrEo6l7ib+MN90kTqC0XU70+fli9j
 w+8cskyufK3y4xIZZFGWXaH/J+mjbSbiCzplrAkpEqvUnoCn8AhzbhLZEUU/8w95fsl0
 cru10yPYRGgnGKQFPwSO5AzhSCJYC/q3YXgxSocgXsxO28G0wFsKi/hL991d5uBA/QBD
 OTs5LN5jRqUXjgGeB0L1GFD6M492TEGQvfnYJxMu5OoeOmU3GMAcrqYixGFj6uvXPFMu
 gh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720015906; x=1720620706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xrStVSR/S6iqC36MaUVaGjHdT8yj8NhP0BQvwC2mvCA=;
 b=dz4YowLZZkELQLRr4iLT76gYogEVH+mC4aCLXJdbaXQsN5cIuvcvuu3Oj9pcH4Fs22
 2qSKGdazD1gX27KLB+pjnMVy7qLsg2+YRsoJJUKrJ4/0LqSNhjVSI6LmXn682TwoT5U6
 jqNv93yNZ20Jr46m5NcPMEGishU2jiKHEz8eFUa10NoZV6/pHTJEZIxLjkokfdRivtp9
 1APB1t7++kEL9nHk1QYDXdTy4C1V+ojqJ2AAmdtlLvkWw0lgRaZUgTqdas3LwxLS8Rv1
 KZCrrQzgkay6kCnPBsqvLgEOufbBs1HAQnT9QjZTgu5lyNXFxpGhoFaVX33snNnROLss
 SKqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+xyTbWrqv8YKVU50+iyGncxy4rcjQLuNWBBgqrq+8WcTc9DvLUNRq6Uy7b5Wsx8f+7Mvr6l9oYNKd9d4dEEjX5rzCrOo=
X-Gm-Message-State: AOJu0YyavG5ig2+hDGWN9tmH2JD46KGPoMvIME6neljeaKlxYTT0QEbt
 /DYjpMzMV9SUpiH5DtIAY9vskWVmyf/MvmcqudH6eQyBRziNSZ2d9QMHVJcp8HM=
X-Google-Smtp-Source: AGHT+IFrdVKuU76o3YheW3gXgrWdbNWjNXMf8DNPpG2FQgpNya5O/sal/muOTIOEytAgQFHEaLE28g==
X-Received: by 2002:a17:906:6bcf:b0:a72:5f3f:27a2 with SMTP id
 a640c23a62f3a-a77a24804a0mr143784866b.26.1720015906254; 
 Wed, 03 Jul 2024 07:11:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08cc07sm519403666b.149.2024.07.03.07.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 07:11:45 -0700 (PDT)
Message-ID: <6f231ac5-bbe1-44ab-9acf-37cddbc1ad6d@linaro.org>
Date: Wed, 3 Jul 2024 16:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] tests/avocado: add test for default sbsa-ref cpu
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240703-b4-move-to-freebsd-v4-0-07191f958530@linaro.org>
 <20240703-b4-move-to-freebsd-v4-2-07191f958530@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240703-b4-move-to-freebsd-v4-2-07191f958530@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/7/24 16:06, Marcin Juszkiewicz wrote:
> We changed sbsa-ref cpu several times already and may do it again in a
> future. To newer core or to enable/disable some properties.
> 
> This change switches Neoverse-N2 tests to 'let test default cpu' ones.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 2e27d37cb8..46a1d982f3 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -113,7 +113,7 @@ def test_sbsaref_edk2_firmware(self):
>       # This tests the whole boot chain from EFI to Userspace
>       # We only boot a whole OS for the current top level CPU and GIC
>       # Other test profiles should use more minimal boots
> -    def boot_alpine_linux(self, cpu):
> +    def boot_alpine_linux(self, cpu=False):
>           self.fetch_firmware()
>   
>           iso_url = (
> @@ -126,12 +126,14 @@ def boot_alpine_linux(self, cpu):
>   
>           self.vm.set_console()
>           self.vm.add_args(
> -            "-cpu",
> -            cpu,
>               "-drive",
>               f"file={iso_path},format=raw",
>           )
>   
> +        # let allow test which will use default cpu of platform
> +        if cpu:
> +            self.vm.add_args("-cpu", cpu)

I think the pythonic way is to initialize cpu=None instead of False.

> +
>           self.vm.launch()
>           wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")


