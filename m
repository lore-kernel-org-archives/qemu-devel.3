Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CB3C02197
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezZm-0008PF-CO; Mon, 03 Feb 2025 11:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezZU-0008Jw-6J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:45:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezZS-00087h-95
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:45:15 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so33146215e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738601112; x=1739205912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K2huIyCIvHwLAJXOtgyL0NwBZmXW7RVzQ/ZAmobOuZg=;
 b=sVq+9ws8jac7vlpezRcxFFhaxDgtjt0nJt9zOxwh2qnw3ntjMARwR3rC6y+7bzxZuj
 g1rlcTACGKLx88dluP+sYLcC7eihOy7Fn1/IWQZqW5fm0hdrmAO5MOcfMDZMpFzZvOwx
 mqS8rEKNOS50L/gAtRouAmYhm/xlt0FGUtlPfbOoFeR4xanzFbRgr1d3+nXDroKFjoaQ
 S8rOIoatwaKxo4ukd/o/7da9TaAqnp86dk/YVVie9bsqLOpQ/YrCOpjLbj9650ePATd3
 1bAB3IQ3Q04MISxr5ZWsldLaW2FrOFymH4HdC0r13bV7ceTocvdIVVtkCI/xBUrj0VNb
 JHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601112; x=1739205912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K2huIyCIvHwLAJXOtgyL0NwBZmXW7RVzQ/ZAmobOuZg=;
 b=JxcEaDW77zD40p/Q7TthSGClYXzS695An6EN4GONWjgAZBy6UwTV12qYqEsZthci3f
 0LY9m9acPqSMoHKqsFfR5PZpGe32xQawK/tTIpFFgfEjRV4wkXgC1ksoBZEs8yIYtKjw
 yzvFbu05Km4KLk4PE9MGEMa287SbcXPKvGsXONq5Bv0izZi4BnPr4Dg2JdFRnhpqd4QM
 UPo8azAhliWEoDzCz3B3IvAzKxtgMOSSLV1Zoi6xEVvnXqYhvHkrnUvqPQWyb4RWMiFB
 bhWYir/GGMptjh/kLlHs5CowdECW5LZvpw0GsVbk46wRyXsjiPTUmhv3sAeNLy29UK2a
 bQZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi02jKLrIvmtR/JIoKYMJ0uarmtpfg625DvrdNtMclGIpsomPfYGa/D3JrgfK21NIu3SLytZ9v8yDV@nongnu.org
X-Gm-Message-State: AOJu0Ywpnx7iEJEc8+WzeQ8H7Bfd92dFjTtlWHr6NGouwnJphDqpuMkq
 SJu6KtpD8xomy7sgxajLihxaI5LLEFdRRZVtvNBooocY3u1Su2HwmosSqeR/XnA=
X-Gm-Gg: ASbGnctBD6tdX+vOzooLKeIMsmdzehDoqoWlqaqTMQOg411PiCsHolU/yA3vhrUdxbW
 kIzazj96dcR07oOiHIgFwqEagniUyozAFLPAvxSOAV5O0CagKYu/a2PaaPLKOKptJtUp8A+K/0X
 zl0Ti24kPDFjk5z0Dwg77lHlnhN+QLqk74Q/inkS83XU1ZQPBcMIZa+X/lQs26ycAt7xncOdLFX
 e6oYe0WrbiMheqiCENe/ja9pcTEJb2gIWqF1EtV73J6xQXyyJMxHiQWovlialzz6DIH+h7+R1kI
 Abf0wmZEpLQ5riE1zebMfOs5UCVCnfQR+kSRX/upFuaKB1B8BlvFjadZmT8=
X-Google-Smtp-Source: AGHT+IHK1tjrD8UJaJcWAs+nVbyzYO1l9aFefUUfWN9/49zzSDe1r/xOrvICyBFIyqjgGsjysBg5yw==
X-Received: by 2002:a05:6000:4013:b0:385:f631:612 with SMTP id
 ffacd0b85a97d-38c5195f2e5mr17217671f8f.17.1738601112142; 
 Mon, 03 Feb 2025 08:45:12 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102d2esm13489851f8f.33.2025.02.03.08.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:45:11 -0800 (PST)
Message-ID: <75647ca0-164b-42ff-9d5f-368e1b838a62@linaro.org>
Date: Mon, 3 Feb 2025 17:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 3/5] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, mst@redhat.com
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
 <20250203161908.145406-4-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203161908.145406-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 3/2/25 17:19, Jonathan Cameron via wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> Address a memory leak issue by ensuring `regs->special_ops` is freed when
> `msix_init_exclusive_bar()` encounters an error during CXL Type3 device
> initialization.
> 
> Additionally, this patch renames err_address_space_free to err_msix_uninit
> for better clarity and logical flow
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/mem/cxl_type3.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


