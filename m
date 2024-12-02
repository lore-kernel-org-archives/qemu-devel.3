Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732E1D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIA5f-000654-3q; Mon, 02 Dec 2024 12:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA5d-00064V-OV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:20:05 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA5b-00074C-Mg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:20:05 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-466847440a6so29367101cf.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160001; x=1733764801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ocHoVc5arOHpYl/z7DK5DZyXUNb6y1d1VHVocGTbeVY=;
 b=cVa9iM6EbVe37w4Jnu4FRUoNmGgCvtUq9CzbQN9laOPrbiT6SyO/e8rTmBI5JmwkRL
 t1tJityqNycT/LhP0RLP8PHQpMEU6u2cD632VylpD4OtcC8zqiU3I/+9JKM1zeJ8ms37
 Fx7kXlpxGH3Nw18acWMermRkoNn0N0cQM5GwZ3whFEkZW5FvItHAcRDcrxerwpHkQVOD
 iO6lH9p7XxXiR1LKdIl/RwZqlPA//93QBPy7Bpy6X3Tpt/+AhFpBelq4SsI9Hle6HzcO
 oEuOvv98i1WYpV8vfIKiB0nV52hFUNyY4TJOZWNXxMBQenXsFzDW62mqC0TQQV/qwoKJ
 cCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160001; x=1733764801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocHoVc5arOHpYl/z7DK5DZyXUNb6y1d1VHVocGTbeVY=;
 b=ZkrNOF1B4ZZpuWuqjPamG72s0wfKcZLkCbuF641A+xwgOYTrDM+1PzzAIJluG2OLyw
 v22ymEvUcRX3y9JNGH3FZYv46/FvJ8bMUe9igx7SoLI2NXD+wS335VQ5hNilTN2cNZi/
 +5TjHeTqMmWiq/7hhcWq9GneBFeg9sn8yICKhnd9G6fjAMhsQ9H5RWXgMOgYlcyJOceE
 DM0U6ikNdYnh2e6FuQYROD/tzkNB70204c6xcwTJesl+8G44aQevoaSJbWkCQ38rqsNB
 TYsAy62Ij7nFFyppcuKEIH3GZH8fIRBvSLObcDOo5klcpIuyoum8UhZh4BVGunfLayhD
 wUsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1cwY+esaLZtuSQlF4GQmzHGrJkiR9XFRrHkN7U6ZUXeDRpWQQgbfqInSHiDJIyuL2NyV2FIiEFuit@nongnu.org
X-Gm-Message-State: AOJu0Yz5MB605HqRHYuyRd26vpMbQFXlQpeDKA1h0wGUn34KwDFJKJ/m
 ejSkoEiwM7mBhyhCvPhZYzB1f5K1pU5jbd1IgWC8GXmEzv2/yQu2OH+XMJE+Dtg=
X-Gm-Gg: ASbGncuqSBjhboJUBsL7rq2quHBqZfHbwxIR4b09lmUQ9gPiMKHu4zBH9nJ7Jn39XvA
 1MEfqGGfMQQ+XfuL2yUFtxkqR31JOq0cLDxYILVzjXhbnWGOTKvzZVVF1B6rW7lNl3jaD7OaeyN
 Ud/xOqqePNFfRGUelijr0G6xTTZb6lnkq8q4wF8spyT1QtK6TNub6u+n+gUr+MfFCMTjGmGvSBe
 R7b4/+2DQPDjzg3SNUGiw/JxevHeB1h+MW8poKBioqhF9RvVvyFwOejArdgD0m1zt1Pmbk=
X-Google-Smtp-Source: AGHT+IEhVjzZkbQyPixxY/di8OtHfg1XnJxqyuIM0yfJSeu0z1S+JZp4wFdP/+aX1BjFQQGCkSguoQ==
X-Received: by 2002:ac8:5803:0:b0:466:77d0:592c with SMTP id
 d75a77b69052e-466b34dc56amr376130121cf.8.1733160000868; 
 Mon, 02 Dec 2024 09:20:00 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407dfe0sm50897511cf.51.2024.12.02.09.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:20:00 -0800 (PST)
Message-ID: <b28cbc2f-4a92-4a86-a5ec-5dff0fd0024d@linaro.org>
Date: Mon, 2 Dec 2024 11:19:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 28/54] softfloat: Create floatx80 default NaN
 from parts64_default_nan
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-29-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-29-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
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
> We create our 128-bit default NaN by calling parts64_default_nan()
> and then adjusting the result.  We can do the same trick for creating
> the floatx80 default NaN, which lets us drop a target ifdef.
> 
> floatx80 is used only by:
>   i386
>   m68k
>   arm nwfpe old floating-point emulation emulation support
>      (which is essentially dead, especially the parts involving floatx80)
>   PPC (only in the xsrqpxp instruction, which just rounds an input
>      value by converting to floatx80 and back, so will never generate
>      the default NaN)
> 
> The floatx80 default NaN as currently implemented is:
>   m68k: sign = 0, exp = 1...1, int = 1, frac = 1....1
>   i386: sign = 1, exp = 1...1, int = 1, frac = 10...0
> 
> These are the same as the parts64_default_nan for these architectures.
> 
> This is technically a possible behaviour change for arm linux-user
> nwfpe emulation emulation, because the default NaN will now have the
> sign bit clear.  But we were already generating a different floatx80
> default NaN from the real kernel emulation we are supposedly
> following, which appears to use an all-bits-1 value:
>   https://elixir.bootlin.com/linux/v6.12/source/arch/arm/nwfpe/softfloat-specialize#L267
> 
> This won't affect the only "real" use of the nwfpe emulation, which
> is ancient binaries that used it as part of the old floating point
> calling convention; that only uses loads and stores of 32 and 64 bit
> floats, not any of the floatx80 behaviour the original hardware had.
> We also get the nwfpe float64 default NaN value wrong:
>   https://elixir.bootlin.com/linux/v6.12/source/arch/arm/nwfpe/softfloat-specialize#L166
> so if we ever cared about this obscure corner the right fix would be
> to correct that so nwfpe used its own default-NaN setting rather
> than the Arm VFP one.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat-specialize.c.inc | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

