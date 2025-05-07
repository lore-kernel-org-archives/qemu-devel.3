Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E43C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgfk-0007u2-DJ; Wed, 07 May 2025 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgfg-0007pO-Kg
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:26:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgfd-0006qd-EP
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:26:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0b9625735so53227f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746631611; x=1747236411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ZT8Xy5cBt7B+o16iw1Z1+KFhXWVf1/GnM9h0ZEdFa0=;
 b=N4KCVAHuPwhKdwicqdfmT5MUomcp6ZrMXRFpplBcumxkrxsF/g/Yv7vUT82rF/AVYV
 +oaDVMD8WLPCSk4G4QOcluzCxVJsh5zUv21rD3y7tsgP+LWHLgTPG8kZgfG87vrJ/ksY
 rpASmfPpmfLFg6SDxTfWoFRXSgtEu9E3ltAgUKlqrrXvGENVU0hIgPQv+s5/siD/YakK
 MzuY3CIxxXIBOVZANQoiHwP4Ad7F2j9Qe6Oj6kKDGLZtfTg2fpr0anns60ey5f84sKQv
 uhRWQarq26aEukSEqL6GRkC1z/V7xz6tU3ahI9DJPdtfvl/nGqiI3dY1e0nd7f2OZ8wL
 C7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746631611; x=1747236411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZT8Xy5cBt7B+o16iw1Z1+KFhXWVf1/GnM9h0ZEdFa0=;
 b=Tnb88tinge62GrGDqUftIuCzrBoVosdupGCPfOBJkzOhoL097e5xs4Vdx7XAgIAtLS
 Huc5hxH/VXUpXdQLhKWEg32mvjk1ZWb0Nr+YapGSy+mRcM1BtMfGjyMHYbgU7897B6mc
 ShrXgA3eNu7TNn8d/wCtJd1syIOvDUmbbJQThsmGy+dxoMNK5i9flmlLuzmpNgpmWzu2
 hX5fCXYayG4oFzNeMjkBxNstVrb8M3IK5fZ0QpsUGs3Q22NdPihGae86KJO2MQUIc7/x
 qwedqNiK39Em/9PgrSMtuQlWjHlYuYt/eBp9F849H37BeaQL45BKOc0pp4bYXhRBBf1q
 Udmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZE1SjKYoY9QBlbF43fqhFggmzA7f+8N82AVO4fKzl22NWi7tED+foG4YObsx2gj0IlRstDscDQ1RH@nongnu.org
X-Gm-Message-State: AOJu0Ywd/96XbBU+xZpdPDkg0QM80ch9UOQv4UdRnz4Aqe6QcFCl3yin
 D1qvTESjYfkkXfV0B/7FQLtfT27V/6Q8eaGXzO7sRcFDN06vp741Ip8F2ezUglU=
X-Gm-Gg: ASbGncsPGl50m2yVSC9KLKc+Kbrp03gIspNrpqFGe0SrOFpxLTXGsUfP8w7sQUZn8Gn
 lzIML1oh7XCKoZwJiXKjqSScHZc88SKxCxudOGm4E5TRGlZmctMZJ5XtYD/XbtnN5YZlAGUfLT3
 yc14mM1vuqvA/xm8/jeT9TJgFAj3K8VpuHbMYPIwT2MZ3BY8ZqXfmBfGqXyDnliC8N4Ks8n2h2E
 CjJ9Hl1yDdvbjcJjhL0zKSWDbFpUysB1C7UcIdvcssdhyvlDyT5QsYTFFT8RM9axfAUAkWjDbnE
 vE7JABEEsXuxNPWYUTCKgCAekeZJ/XrZ/cl5xwH/jotq9414FzAecf1SDOxvDDdTLPdOcQ4GMa/
 nm9SznKFRdQcoUBfBiRSYnIwcdaBeQH8=
X-Google-Smtp-Source: AGHT+IEqMbvv45QaCs9n0tFq6w0oPZ+2VkUNKuKGlHtuuA6sutv/J+JsqRSHRxYEPxB6vTWRy8mkeA==
X-Received: by 2002:a05:6000:2088:b0:3a0:aee0:c640 with SMTP id
 ffacd0b85a97d-3a0b4a25e8dmr3722751f8f.56.1746631611035; 
 Wed, 07 May 2025 08:26:51 -0700 (PDT)
Received: from [192.168.1.70] (lputeaux-658-1-173-28.w92-154.abo.wanadoo.fr.
 [92.154.108.28]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b6e52796sm1514618f8f.37.2025.05.07.08.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 08:26:50 -0700 (PDT)
Message-ID: <5fdd8922-9ce4-4547-b909-88e3f2232d0b@linaro.org>
Date: Wed, 7 May 2025 17:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpu: Process float_muladd_negate_result after rounding
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: WANG Rui <wangrui@loongson.cn>
References: <20250507145013.4024038-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507145013.4024038-1-richard.henderson@linaro.org>
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

On 7/5/25 16:50, Richard Henderson wrote:
> Changing the sign before rounding affects the correctness of
> the asymmetric rouding modes: float_round_up and float_round_down.
> 
> Reported-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c                     | 54 +++++++++++++++++++++++------
>   tests/tcg/multiarch/fnmsub.c        | 36 +++++++++++++++++++
>   fpu/softfloat-parts.c.inc           |  4 ---
>   tests/tcg/multiarch/Makefile.target |  1 +
>   4 files changed, 81 insertions(+), 14 deletions(-)
>   create mode 100644 tests/tcg/multiarch/fnmsub.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


