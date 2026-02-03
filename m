Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F0E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHa2-0006wK-29; Tue, 03 Feb 2026 09:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHZz-0006vw-Ri
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:40:35 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHZy-0001El-EX
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:40:35 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-658381b28e8so7944596a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770129633; x=1770734433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CbAZMZ0PGJoI1St7AnSFtSEn8KWbGy2NJPOS2StUTXE=;
 b=CqBBQBHqQC1j8mDd13VIoIJDI8QRuZ9NBm95C9XgaTX/s8jKByiQURGa060n1LIGmz
 96vjhO5kjTIk37ReXWrLryWm7esUNO8KFEHhvL36RArCbZT5r/sss/PHe8qyA5gZUSAO
 avC4YuTopTWPiq2rA7nvdG5YO2iLRhusmzEvNlcExrnP4GmjqV7Hzn2OXhtvLCx6jTLI
 E0rrMddoCn+OrDUkXdAywEIHBWUxfl3ofk8Yx1gqjnEvBkDCHvWwTqNPhyVNmTi/M6ed
 PyV3wWO/6YfdEgo5gSraXTnTjACFWZGi1jeWZffm21zJk3rEGX2mRHIbcl2VW6PUnHn3
 Bpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770129633; x=1770734433;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CbAZMZ0PGJoI1St7AnSFtSEn8KWbGy2NJPOS2StUTXE=;
 b=KqdkJLzgnMjP3TX1sZnFVLFVE2ZF8QtzpG4v6Z6rFGpa4s5Iv39kje1XtVR31hnWkK
 mN9pkYsebTe1HscywUlQr5R3WKmYken1e+9VJrhUOPUN9/VWgX4t8SV0xbio5qeevaF9
 Cq532vYyp2/K7rpjdJu2KYzomQ6SlSzYDGwyTFa6eU3AHygKK0R1QqqE92YhPig5Yrnv
 r+ZahpE2Rkj9DrSVI7VLqT10ZKdv4IVkkJ+Qf5xlGeOpnydN2RkDpYE5OO3zAtMd4Qhq
 wx152EKrNnWL7V6jGimoX6ae8cokr+YZd7v/LmE5c8oolEjCs5kWgiczNLX+aNIGYQBA
 DAfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTKLwN225cWRlzoCrAxttNVAr2one8v9auGKqGEnaLSj9+1hixdOSRP7QR+DN6MTTug/HItuqWLG2k@nongnu.org
X-Gm-Message-State: AOJu0YwdRgiFUWAG+FuSWY1BLfO9z5bpaYOoKkcmVAxoYHczhD2OFMmr
 pupQMAOXIhKk9ElUuoYSQvLNQLiVj+dvwu5nsiNd8BdMW892oe9sa+loPCFkYu5aMTg=
X-Gm-Gg: AZuq6aJvAZ4X41M7scJw2Z9qXn1cDK1wjhHsFlDaf9HNuZqKxhp2b1O+od5mppDOLiJ
 me8zCm5z4eh6umMH4yYygBoMR9SSbynbzGfGXwPdq9ZZ//wqNsHv00fRsb47sWtF19ojKLHk5zF
 I5dMFBcNdnef8AEmzgTBirrI+vTLuD2C0eeGcUAho7M/07V8oj+9csP0L+7L9GUPpRxPxx/BosC
 sGWslOFZMaMYTc40d3lOqLWvcM4WBnSn0akqM3jYFXJKJdXyuNG+zotbKrjZlqNK8akLC6olkf3
 7jKQrUvJlPgLxrkXvi79CVKDsWsICLBjvI+1yqnZtG6aC+62F1FgWjRBe7nT9kfKaYCd9unNJG3
 r/gWe+Ht1R6rL4XWXT0ZXUdmXHyMpHXjBzQwdkg8eTSGzpHZpKKW9o4AKwB7E2w6+QsAT5WnYI+
 rsC+PBgc/FEig+9eo8i4j166NCLOHUoMKzAQ1YoOUXCD+YNHNBuh9hcQ==
X-Received: by 2002:a05:6402:f03:b0:64d:3b22:a5c2 with SMTP id
 4fb4d7f45d1cf-658de5b64a4mr6992850a12.25.1770129632601; 
 Tue, 03 Feb 2026 06:40:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-658b4691db4sm9227695a12.22.2026.02.03.06.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 06:40:31 -0800 (PST)
Message-ID: <860a055d-6a3e-4eca-8b3c-e997ee14b102@linaro.org>
Date: Tue, 3 Feb 2026 15:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Remove a redundant argument attrs in
 io_prepare()
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260203142737.2164763-1-jim.shu@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203142737.2164763-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/2/26 15:27, Jim Shu wrote:
> attrs is already in CPUTLBEntryFull, so this argument is redundant.
> Just remove it.
> 
> Clean up commit 94c6e9cf04409e38563080348d6136879f91ffee
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   accel/tcg/cputlb.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

