Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2437BC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxBlA-0007EH-Hc; Thu, 20 Aug 2026 19:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxBl8-0007Ds-MM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:01:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxBl6-0004OF-Us
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:01:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so2738765ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787266875; x=1787871675; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GKF0KelZwmmv8EDXQCPoTyCFlDIClrj7B4GGn77f+kM=;
 b=dngSERJyn0WXsnCfaaPc0PkVvvUVaztxJFe3Ot4WH9jU6plZb7s7vUltxTl5xn3BL4
 VF2hptucjS0JnFgEfzMrTFsvihEUKEY0ZZUy2qDhf/DVkg352qVWxuwa46Uu8qOM+vM7
 kKZGDYl2pwCG3R8Num6KZKBaTRkBMLp6umbQN6wP2Me79uD2CU+yqx/Kuvwya6RxIT4e
 O6UxEkhU/PKPHv5wA3uWfink6sMGiAeURfXKO1ls0QOO2tVNiKZKX1bfrrqbkPRtIciy
 5kCgJTPtD84gk887x7sscZVjbC3z1ODXvsK9WM9XCcnWqpl3zlCXVqIuNsGC3C+T5Xd1
 sg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787266875; x=1787871675;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GKF0KelZwmmv8EDXQCPoTyCFlDIClrj7B4GGn77f+kM=;
 b=VBmsxUFWQwPztvd3XsViaCKU5uLJTOPWIHJqd8WTVGVMXC0X3WgSx3EszT6hDNIoJn
 BYIwrnBaH+4/smvHeJ9XC8iIdwo6zp9xSucN3WxekBKVHulVszqlZdgvScfYudsNFMSA
 lhNZsb8Z0gCriwy+jhaD8ZYtmSsF1trfzNlEfxx7NsO8rI6+UUmhP1fC2AH7DWlWxqf7
 mhNYF3WkVB+Yzx6/GC2OqtqYd4YXcwik0yULCXcyQufoobHhUNY4ukeNWi9h8nXaGPLF
 zX5PLeh1ZfKkky58ynljLOjbSVUuSeaSYtkKbumlLuSMF01k712MgkO5xfUUS6q7ZY/V
 OE4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXQzw9cekkWQ9p7QHMS2cLxVMD3XE6lh8SCCnBWVG9ZHH7XGIssCTy209JwEbgacUOp2RbuUxa2iZO@nongnu.org
X-Gm-Message-State: AFuF++lsBQ03kGzdIyEMlcNNBk4pSIRIRhWRsRuoHEvBVxqO7HJwGXM+
 OvrClU9LoWkcBk9u94TBNWJ9KVRrFHcnsXs9QG2rZU5kgkuL4NjkqW/vdAgJw5wKKnE=
X-Gm-Gg: AR+sD13sTu+SHhNwJoCwzIdtvtYNAbJptFiAKgDBDRMGAAu+yxpYyKOvP2OlEI4dNb5
 0Bpx1nGT67VUACTf3M1js+LkgPi72nI3kdBlmDkwxNkKyKSXtH7HvxSmMsptFNaat5eEh/3C4Kn
 8cdSdRZAcz2NSaGAIRGtQYDQFt1e+6OPlxpFUaAMX26Hl0pdwLAHLP2OG3P/Josg84NDeVsACzu
 DjNfbBOlkg4wLHFwKuznzAXE2W4KJ7xP89aP1lXb+E7BxCJElPWomPcbofsrKNjsxMayyhOaA+T
 0hBscHOttNxwD+xLp3PZ/zl5S3mcLmW46/cd0pKxMDVzQOeQRWqYfC0g0Uog0f8UtQMG9KHeEcv
 QpCnglrgz7+aiU8Q+Y0FydiqabDsfWzClJavShlbKAzKGouby1G9tQytMq4pypW9bmH6QHWNltw
 20HsYUzUVsi1ViidreK27M3LOZ1H1mUOL0Hf+SGJz0BS848kj3n3QZ7iHSSEhtzerkoiN6B0Yjr
 k7x
X-Received: by 2002:a17:903:3b85:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2d61a0da51fmr125147195ad.8.1787266875068; 
 Thu, 20 Aug 2026 16:01:15 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d555b51sm12020745ad.7.2026.08.20.16.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:01:14 -0700 (PDT)
Message-ID: <d1523f32-9ba6-494d-a9bc-f0479f42fbae@linaro.org>
Date: Thu, 20 Aug 2026 16:01:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] loongarch queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20260820111109.786405-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820111109.786405-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/20/26 04:11, Song Gao wrote:
> The following changes since commit ae4f3443209ab154b48b706a146e5f557ab147cb:
> 
>    Merge tag 'qtest-20260819-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2026-08-19 08:21:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260820
> 
> for you to fetch changes up to 215a4fc08f2aafce54c168cf41c64c79187430c1:
> 
>    target/loongarch: check FPE before reading fcc in bceqz/bcnez (2026-08-20 07:24:34 -0400)
> 
> ----------------------------------------------------------------
> pull-loongarch-20260820


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

