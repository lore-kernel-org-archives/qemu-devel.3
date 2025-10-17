Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60539CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lyD-0002SV-Or; Fri, 17 Oct 2025 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9ly3-0002P1-OA
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:02:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9lxv-0004jK-Ro
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:02:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27ee41e074dso24868135ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760713310; x=1761318110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MDtjB7BWmW9MfKm6fCWkzHH7AMYlVmTgFy2gFDI3M44=;
 b=q24+ry9ATphWlRRT4gxV50+SJ26n9w37kb+E7xt3zu61ignPYyKvpGp6s8/kwidDoL
 g+kSEYOExgD9thIVHYlWzLa1nszsRzRzQl5JccdnynbPjuCmP6DfMWtSbL8wNP2QUO1E
 s2FwxO6GBFxnBhFBga5/nJ0FONLnLE8JQ0zMfV9wqTyFaIbFJ0YFWulPedAEHAvN/m2o
 C/z9NrnuCZCPeKVgb7+7OY7Fx6AkmKynihwqwQbyy3LA7oSPAllZzJS+5GyRxNnPoZmt
 OTUJepw4jaZgECr50aOZru9pu94Lzi9nxiE5X9qcMEixAIsMzJS+3Ei+sop2VWhOnaun
 PRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713310; x=1761318110;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MDtjB7BWmW9MfKm6fCWkzHH7AMYlVmTgFy2gFDI3M44=;
 b=a1uKO7SorXxD5hROr/CUqZs+qUCQcMurquLKjSmUZ1Xmz/uBcD4fre9/A8jIO1K7eF
 9QXQeqXClU40aL/2cNaaYNuxwgT3SAgkqai2L0aOFdLLnvc3lIRWcMrPRoNHz03azaZV
 2k1g6wlHoLckdfgiAModgA2zVuqzuMF1TNlnb0OjpcVOnlvNxgiXwR4UiQymA1OOS+qJ
 uqJhD+nGR4+nXh8sw1YlBrGYAbHD5nvUtnWEASMRudW6AJjtUVdUP92ljPVdrRagZ/yC
 pU6C5AUTbqA0ykvsnTLLYzG7IT30rzDgp4M7xZ78oIkjmIrctEWMuFRFc5i7YDduImiz
 2ZHg==
X-Gm-Message-State: AOJu0YyegDXiMXSnDp3g29nLhfxX8Isgrrok9kBbVQ9ZnOh5EuOFJdvS
 r7tumELjUeOoP81apWr2dpXOX3Q9/HCvFIlRRBhBXXkprocy/60dyvorPq/XVKvYEBk=
X-Gm-Gg: ASbGncs0+cfaRuCI+K9mgFFRGSFg1QMb5ItuyfQPggJTJwK+CO/OgU1nZe4lxWZkT02
 3MK1w4H6ox/9L96qiZDbsU2lCoyywKT6VEzhLXPSnZk3An74d3DjQZWHHZt7TnaU8DlRTzrqDSh
 kEyAlivDp+4g5CQXt0ETPeig3JBjFF8xo7pPONao3t9+ho99nN7wZHabjyfXpmVrSc0z/RxYYtV
 48sf/yTnbT6cQdVahZj3iOQlMvtSf/3Ro+EEAOO5Y3GSB9yyk8samDrGdfXuYvF12jFUKCOnXry
 G4vQrTmp0cYYR0dyr5/3GVh/95IbeXnp9GT5fpb2Jz9Kb+RHwLcF2itg6tQzK7bZFgk5r3tPBeD
 GRbCeD/4pS3YP9iApoHOIRfYxvckIDp8rkWL9iHsrmbx72+Ru69vcvN+S7ZcM6o6kT5ITLxdTBh
 rA2elXx25Ilvx37csOAFSlEsaV
X-Google-Smtp-Source: AGHT+IH8FjVqmKL+m9ZKw9PckeHysrYmB53LsNkpPQQyvU7DR5pKX4ZdmEbn4tBvw//iIk69xZOnag==
X-Received: by 2002:a17:902:e78b:b0:288:e46d:b325 with SMTP id
 d9443c01a7336-290caf858bcmr50921135ad.43.1760713309698; 
 Fri, 17 Oct 2025 08:01:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba99asm66272675ad.87.2025.10.17.08.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:01:49 -0700 (PDT)
Message-ID: <87479dcd-8db2-44a7-858e-acdebbadff55@linaro.org>
Date: Fri, 17 Oct 2025 08:01:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/37] target/arm: Asserts for ARM_CP_128BIT in
 define_one_arm_cp_reg
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-5-richard.henderson@linaro.org>
 <CAFEAcA_YRU8F02wM2z_DvR-0hryUYEZYA99fy1c+H3M6xzqN0Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_YRU8F02wM2z_DvR-0hryUYEZYA99fy1c+H3M6xzqN0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/17/25 05:59, Peter Maydell wrote:
>> +        assert(r->resetvalue == 0);
>> +        assert(r->resetfn == NULL);
> 
> 
> I assume that not permitting a non-zero reset value is just
> "we don't need this yet, so don't bother writing code for it" ?

Yes.

r~

