Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6F0CA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 21:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upCRd-0006xq-R7; Thu, 21 Aug 2025 17:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upCRc-0006vX-CP
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 17:03:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upCRa-0002RU-Tw
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 17:03:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so1489181b3a.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755810213; x=1756415013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e9JV+Zw6bQsztDmUV+QeFJ8up6RWZ80029voAs5cwn8=;
 b=Vk9TyB8dILq7xERrtE+Xz6jXczK2DaIRyeh8lN1kN3cnNqwVrmC3OY4DG8k/tTJoGC
 g4/4vgpI27yA6Khq1U3pZv0ZtyiP6AB+RAC7asybU4EfkwrRIMpTmhH8bllN+NfHe2FB
 ZKU+GwpILANX58hqhWs3mPlwzliIhiNaZgqBcVAby3W3HT4A0YudDYXU/2mczTBHYpCw
 V75uybszv92Ftqv73TNVaUcA8mFP7z5Dt1iojEWlO0RHgCncePVBoLXlEtIW6w4TRGqe
 zxMYGTJzRNWP3qPi7hsqjtIo2HyB7NINpORFb/4gfM6bwjoyDPcnMQQc5/3c0a5mpJH+
 rljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755810213; x=1756415013;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e9JV+Zw6bQsztDmUV+QeFJ8up6RWZ80029voAs5cwn8=;
 b=f/vEizlXmriwS+RNmCOAASSdBBbnC77ieE9K7G6bChvnmSLrzHTGKlkDOZSDEqz0AT
 JuA7xG/LMRNPlYXS2cHLuILpS2RaclbQbxi0LTf94t14G3fo4CkkK8O1hmScDnb1+FgU
 HuqTTB3yrZf+FKtEEAde/j8vIvCELqVJhOEpj2Q0d8bAzxiesvndQkSHQgPI1O9kcJTt
 FocX6A0ihn3fafKmCFwgaTjcdvIBsO9RoM3d4+quhdH0MIUm2iv0N3mEgS6NwG9BvHyb
 YQxHNBaOPvfqUb0s2hBM8X9F5eZ1eVq39msoVyIIZBgO/pDymr+bfegOgr3rdB8RqOPq
 /Ihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuGcw4WZERnXbcnhcPO3B5YIkWT1Qm+1GL+KdTQyUYD0+fi2LL4eSf9TCp4YpbreBiSSZCKpHTA+cz@nongnu.org
X-Gm-Message-State: AOJu0YyjuxbgdRqNZ40UO4WPCfgtZiFiuH11So9jTbyYIYLRp8EPsm5k
 07HU4X2uHFPr67/VKCWc3YTNSIIwgJAwc8nGi+5KaCZXl8KzGvlAnvxPrgwDy5BuNQM=
X-Gm-Gg: ASbGnct89yRye5DEWnyu7cz9i5ndWUMlgBBOJqPuG+TXEWThLdS+lFvl50QfIaP32xX
 rERvpx37xE2ZkUw7MXBh+sHj9FR4m7RKnBQCY/6uq5M2IieGRxqKLh1VoaYxL634yr5CJJJTq0+
 hj9xQzU/1lSlAcEjjTnfj7k9K2fOg7j4SKqu9uI4YH4NPpf+lMhR7baalAjEHVJPEWjxjEmEVyC
 rDXLsMP1tfNz96uEs99zO5cPgApil24sBQqSxFL4iRGRKiu8S/01JF3PfQrr/xkGJOte7wer1F0
 yBsL3E9Syi0JcXuveKwrCVy6qhqqN3vIfTt8Gfgo1qwBvZ1PszXOxk5PohEtuCYB4C/6BxEw7Nz
 HYSk7G9vTJE5Gs8+eD768ftld0yDaBknSdg==
X-Google-Smtp-Source: AGHT+IGl9aTRZlvepfirgrWre1tJWvrWRYxzODISJJvFA/UpmLAV/Otus407i1JN/w9e5fYnchEzjA==
X-Received: by 2002:a05:6a00:3392:b0:746:195b:bf1c with SMTP id
 d2e1a72fcca58-76ea30ca590mr4351043b3a.10.1755810213068; 
 Thu, 21 Aug 2025 14:03:33 -0700 (PDT)
Received: from [10.0.0.90] ([120.159.20.238]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d11c77csm9083104b3a.34.2025.08.21.14.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 14:03:32 -0700 (PDT)
Message-ID: <3848374c-d327-42ef-a040-5890e902f34f@linaro.org>
Date: Fri, 22 Aug 2025 06:48:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] tcg/mips: Remove support for 32-bit hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250820142108.46639-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250820142108.46639-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/21/25 00:21, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (5):
>    docker: Remove 32-bit MIPS toolchain from debian-all-test image
>    gitlab: Stop cross-testing for 32-bit MIPS hosts
>    docker: Stop building 32-bit MIPS images
>    tcg/mips: Check O32/N32/64 ABI definitions actually exist
>    tcg/mips: Remove support for 32-bit hosts

Modulo the ld2/st2 thing,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

