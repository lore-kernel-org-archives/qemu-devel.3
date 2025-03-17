Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36463C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCbU-0003gk-Mg; Mon, 17 Mar 2025 11:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCbA-0003b7-J0
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:41:53 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCb8-0006Vs-Uv
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:41:52 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46c8474d8daso40284121cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742226109; x=1742830909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VTMMap8G1h+27iOmQaDryC+9L7h0iGzRq3RCXHITEj0=;
 b=y11892wylAtuQAStg/ZMFQFlvFlgVJ5kkTfBs85U2cvBs/Uw+KPqAbCJoyzMehPmxT
 pDbAFD8cdWgzv7G0bYXjAih3D6os7NY0Nqae5hPISpdJNasrXu1fS+iH9uUjN2a2ycXZ
 F3Jqc7j6IaAoxeKABo6v9e+MLKk9EkBTh2AZ4WZD4WXSQHpvAmvcoW7+8Z5YwCPiRqcE
 eZcaI099rM8f/jBDWBbjRhMa5rUmZajcHiYicWbK9ykKeFBM+4ZsoMjrgTvZ/PeI4Gp0
 ip5rb0btbkHUaq0LCHw9VANfXJ2gdGlbajbSgBmYJsQ7Wh8i3/qhckkqbr7UmJ+GyS6y
 mM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742226109; x=1742830909;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTMMap8G1h+27iOmQaDryC+9L7h0iGzRq3RCXHITEj0=;
 b=EQSQzTwVngq76Nf8/jCumo+kZmwaW+XzzAng7okU/G3Uq2h4bcR4H/wMT8O/5blTXp
 DYCW5TDRgtEKksC3TMSYpR24QpD2e062P1BTxyO2nDq7gBLZabNS9n1e6w+m5vawDqOL
 ozbLvKTheu8fk4HOfCWavJFWeWncOuohQ0Vv4HdzecwNY7Rn5zMeZxbkjOpIRsxxcbcb
 PJLPZ861euKmGOOcpM82ZAygRT7fFunIeZg3Mwg1PFuM2zHutplDUeXPwrALqyijrnzU
 rA2QcZEyPg3bK3xhOAFpfzM+BRYSMC9fPvXBsehmWWSWWJcFpvANvoq5GIIEIRsi6aJB
 vugA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYoLVdlXNdRciWp7wIn5pZbqpuGz68sFwIAABMQEdqf2hS9byF2RpXmWmvXTF9Jjk7D1Fqr7iOL60w@nongnu.org
X-Gm-Message-State: AOJu0YwZjhxQm/4f0HVIgRMGI4zSW/LubOD8tIQyAFy3KZ8rI3HsUcqB
 HJzS40dckdH5Wt90pJb/BZ1jDsDBMRgersVC5kGt6QI1fjzsAss1YQNbVpqR6+E=
X-Gm-Gg: ASbGncvCHM5bRRQJx6Y9rDQi3MuWzkUcqULdQur2fwiKyfBC6NlGZVQITpZ2fe0ZonK
 k8bLt90gF4/kHHh+JXtMwT2OunJsNvCAQiQVpAD4T5aaFUauTWN2nys6s8Yu/6RS1pHl6f8Yj3X
 NC/7LUTnG0UGQaox97tDEj4fTyouqctpkutkuSzr9ryhwX5a5/dfuCkqzhSULt4DEd4NGtmP5B8
 0L1Epc2DzADX7i2lpTJnlZG6jHD5pw9VBg2m5yVuxuejDqdK6C1aD5mzoWasanmvfiOEz9jmusz
 g+MzAnlK35HfJUCBd+hDHEFN42zWO3CSF6IqoQ/3Vt0U9z6yjawxYgLkjB4G/mlp3knU3TFv1EA
 qSOVnsCa1JQ==
X-Google-Smtp-Source: AGHT+IECOPcrHEoPottYvvrxCyIYb96Rv/jdNVHWa11isf00pG0CapI5axFiDCVa6picY0fYYpAUlw==
X-Received: by 2002:a05:622a:4d06:b0:476:b7e2:385e with SMTP id
 d75a77b69052e-476fc9a374fmr2711cf.17.1742226108836; 
 Mon, 17 Mar 2025 08:41:48 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm55119001cf.56.2025.03.17.08.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:41:48 -0700 (PDT)
Message-ID: <d7824899-fd1f-4223-9234-223eb3eae0dc@linaro.org>
Date: Mon, 17 Mar 2025 16:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 5/9] target/arm: Handle AArch64 gdb read/write
 regs in TYPE_ARM_CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x833.google.com
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

On 17/3/25 15:28, Peter Maydell wrote:
> Instead of having the TYPE_AARCH64_CPU subclass set
> CPUClass::gdb_read_register and ::gdb_write_register to different
> methods from those of the TYPE_ARM_CPU parent class, have the
> TYPE_ARM_CPU methods handle either AArch32 or AArch64 at runtime.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu64.c   |  5 -----
>   target/arm/gdbstub.c | 12 ++++++++++++
>   2 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


