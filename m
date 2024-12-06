Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E294E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJacu-0000xv-Tv; Fri, 06 Dec 2024 10:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJacr-0000xA-Dy
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:52:18 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJacp-0005Ax-Vv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:52:17 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29e585968a8so1465653fac.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500334; x=1734105134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XdltCTPHzLMm1n4AZMtJeV/UGx6c3dxI1zrnE7uPklM=;
 b=Qt1pDWOmJqPZyMK0bjLBKu/w7vUGdSteG2zw99OvfpWimQdDxx2q827/KnQLV/rPts
 mNBj+3xHp4GWoYhhZysD/gq2BgGjTmOAzhXbavT1YLrBxA9ECDjeFPpL17GRwhLlHp0M
 UGaau6r/kor32SEEGYGJk9ZJjFqSLgimfMK+2sPtq5Gr5eBvZOqjupWAXOAFA9lQqqaJ
 R9MHsVN5FXt0taIiEkhlLpiZikZfSCkCqkOR1VhSsxknfWpPSTnYECwNrV8YqI3vPdVf
 hVJGGGbBWF9NhDqTKIMs0336IY4z9+w4WqjGAasRec6GolCRPHMp2t3Ljt1iAda45TPx
 YTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500334; x=1734105134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XdltCTPHzLMm1n4AZMtJeV/UGx6c3dxI1zrnE7uPklM=;
 b=ZybhEIS3AKcLYzn30HrzlCieKrTvUiFwIqbDzv4Wet48m/5tk9sSL+OBH+v2j4zeHu
 U8nroUSN6hsjPYCTG3XhM2PnLBRXMQoxIeDjlhR1dCLEOSjZ5KPHqwKiDYxMMd0idRwh
 99x+K1Jfmo62oLJ2YlzdvCMP9nAwxdSOvipGBoQgT9clwPXughYpdMBUHezRmmwVZ0Xm
 XdeMbW3xr8ki/Vl1gk5qI/idIYdzYwfPWLMwNGe3aJogk2yW/hCd+V30cjRGxK/ed/lf
 /ysKMlM+Z1BgRGa3fQJicy32XpcdIesTOyWQV3yypqGMJ0BZPFUDbWSl3GGPEIybQOLm
 4AIQ==
X-Gm-Message-State: AOJu0YwAsAx84vxidSCBeSXzlMj7fVbgjSoy9TaP2yE0pFg1ETQGXU7D
 moAx7/19gorwGJ6xlartJBsX95AJcHHKGYKyZiZMF8q7VMz4u59YMQ5Y7x8/Fbc=
X-Gm-Gg: ASbGncu8lBFxZeiLqgmci9BwD8uqsQ+7xGgIHgnXVYtSH3jlT6++wZ3/aCAhKXs392G
 Y53A03vYQVaKWC907g3XsN8RIVoh4ofQQZxLPfY5BQHDj581eNPoPaHbbAMiUoukGDSdBoxBjfe
 4WBOspBGsADoK3Q1mpNjxf4a1pifSuEl9gnHbBebSycJZGUyE2gZjfuwS3tRj12c2K3qRTfLTlj
 ROYSqKbFgKcGaDUpCoZjKL+ZnO3XJLkqsR/vJKRWvLDQBkRU0gTsf7cnv7PzkhbHTIX2mpAiFcX
 upQGsOo2qKmAT9Apdt/9Zoy6LzJf
X-Google-Smtp-Source: AGHT+IEXE/tEFaipopl0TYrkgZ+s318LIMXNPk69HfAYovS1iCDoykmiiLxVX6KnvqtME1mjnbXmXA==
X-Received: by 2002:a05:6871:460f:b0:29e:6d29:d3ff with SMTP id
 586e51a60fabf-29f731de43cmr4037027fac.7.1733500334535; 
 Fri, 06 Dec 2024 07:52:14 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f5666594dsm891598fac.9.2024.12.06.07.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 07:52:14 -0800 (PST)
Message-ID: <ca91f57b-1cb2-4867-b8ab-6255caec7fdc@linaro.org>
Date: Fri, 6 Dec 2024 09:52:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/67] target/arm: Convert CLS, CLZ (vector) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-38-richard.henderson@linaro.org>
 <CAFEAcA8-GkpSxLc98y8ZopV9PMej7U4+Ruk8D+zUoEDPZYJ8aA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8-GkpSxLc98y8ZopV9PMej7U4+Ruk8D+zUoEDPZYJ8aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 12/6/24 08:40, Peter Maydell wrote:
>> @@ -9219,13 +9233,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
>>       TCGCond cond;
>>
>>       switch (opcode) {
>> -    case 0x4: /* CLS, CLZ */
>> -        if (u) {
>> -            tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
>> -        } else {
>> -            tcg_gen_clrsb_i64(tcg_rd, tcg_rn);
>> -        }
>> -        break;
>>       case 0x5: /* NOT */
> 
> This was dead code, right? We only call handle_2misc_64()
> for size == 3, but size == 3 is an unallocated encoding for
> "CLS/CLZ (vector)", which only deals with elements sizes up
> to 32 bits. Worth mentioning in the commit message, I think.
> 
> (I was wondering why the new code doesn't have any cases for
> operating on 64-bit elements whereas this old code did seem
> to handle it.)

I had been wondering if I had failed to remove it earlier, but this has been dead code 
since the day it was added: b05c3068577.


r~


