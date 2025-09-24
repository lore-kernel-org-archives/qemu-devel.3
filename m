Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E1CCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 03:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1G6d-0002nP-EH; Tue, 23 Sep 2025 23:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G6a-0002n6-T0
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:23:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G6U-00010o-4M
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:23:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f3a47b639aso2183233f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 20:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758684213; x=1759289013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=84golSrtDN1xCxvCo3p+wOX6I4RQ/i76j8MkRG4TPDY=;
 b=uc60wexTxcGS3DFp1/aYVyEHGXicijACWJOE6nymhkIwk8ToQPEJeIzNd6Q+g3xnhW
 iDn9TfLmqL+LDxnNGOLsJZtOnHtjLUp1nB1ZRXcducscjGqIW+NwOomOXyPNHjeMeZE7
 SQBhbJ2B7QXXKjUZe5IV2QUGsfmDH2j2N/fep4Yl6rYk7T6srlTqcBVxTLioNvDKvE47
 mmfbAkgXlYR0QSSrXrUNtdqpyIFlQVWT/TU0wtp0PvTmbmSQGTZZSAYAjAKG4mXxo4Ac
 ITjOpM4439zBW5EDDIMBFX5ZwPasrPtruLQqbGwwz+05h2bB6mR5Rcji+Tea0mH6OXAI
 xF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758684213; x=1759289013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84golSrtDN1xCxvCo3p+wOX6I4RQ/i76j8MkRG4TPDY=;
 b=HFEiQ5Jdvh5gdZGr+cUGAty1dxLdROktZhKY/N+Jxor4rrQf5KUZqsZjBe75T1KdU+
 TFx0CWmwLDwkvltZMX0myNk3PejmYM5WHfLuywKFZcEK08AtBfrygSzCGjegacRYp5HF
 XO14+agQcJbZYq7xsHMwek3wLTM30DGKeXOJtZWtrZtlTB1SU2dGwzvWkyKsSeUWNol2
 XhOCtAQP6AE+LE/QCbhyHJIFlrERQftgeTp3BFDZozBIzvlJsfuFmZbl39lOOcGfZuRt
 DunvG7CbkCarU5psRD6Z1BB3+g8Z7RllenXHObBkOIMQFznayuRbCef14Mtm2AsqiPvU
 uxiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5fX+hgkQ7wAPr28/G+dFeM8v3Q+6vwTIivWCqcaB/d+j5W8MGERSO8mungU3hUbEezj6praNvwJDs@nongnu.org
X-Gm-Message-State: AOJu0YzB6FKS37N6ALTrPcDJTWteDTxp5BX6r8rahWoqYvZAf6Ze8AdL
 wnETUQQjVg7337q4g+rweROI12nBKW4zHM0Exije5eTFFriAzGgoGwVYTwBpkg6l8GI=
X-Gm-Gg: ASbGncth+cyW3qgTytq93VSFqT2hHHm5YEatx9Ara2L8nlfj6l3PtFbHcw3Wrmdna+J
 W/WzdPBWRcye9kpY0Pd9SYHa5IOfQMgn6QBJKW/5XRxcw9FT7RqlFEFi2zEqutrx0JXT2QnFd3i
 ZJj9SUN5gwkSMd2cSHHLaQuvEgrmny29DyA7AESOVnnFpWsxmgVT41b0VXMH9JiCLRiq+ieELew
 k93StDBfynPvnnDzPWh0H7E72uXpzzx/EhLqOymvrhfAx+14rJXEeLXIy+Rkp2eq5Brssw427ab
 mKeOIgQK5HMDcU2k8GbL6vk3U57MtylXLUtmRgCbcHQTh+tyfQXHSP+/+V0E0WEx1v1TpupcTNF
 H+VTRb/lKueVERhjxHCKM/DMT+AHP7bmcLvFmTsjwRvO+GSP8zEifMWtxCj1widcgiUsGpoTXV8
 Rs
X-Google-Smtp-Source: AGHT+IG+vL/t6Z8dGe8bYGjgP8lSHUJL2XFsOMMIBPUxxCch61e1vGt/BbXim8MqjhkoYaljkH87aA==
X-Received: by 2002:a05:6000:26c9:b0:3ea:c893:95c6 with SMTP id
 ffacd0b85a97d-405c6d102a3mr3763628f8f.18.1758684213327; 
 Tue, 23 Sep 2025 20:23:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-402188ef7b2sm7757907f8f.34.2025.09.23.20.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 20:23:32 -0700 (PDT)
Message-ID: <8ace011a-eb3f-4c90-a63f-18eb1816ba6d@linaro.org>
Date: Wed, 24 Sep 2025 05:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] linux-user: Split out begin_parallel_context
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
 <20250923215425.3685950-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923215425.3685950-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/9/25 23:54, Richard Henderson wrote:
> Move the test/flush/set block to a new function.
> Use tb_flush__exclusive_or_serial while we're at it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/user-internals.h | 16 ++++++++++++++++
>   linux-user/mmap.c           | 13 ++-----------
>   linux-user/syscall.c        |  7 +------
>   3 files changed, 19 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


