Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF93C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpS3g-0001yh-Lo; Thu, 30 Jul 2026 10:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpS3R-0001xw-2L
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:48:13 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpS3N-0001Q8-KW
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:48:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso2599573b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785422888; x=1786027688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3gn3HYZ5hzQgQcFKlOAn8q+P8RK3JWAS4+JHwXjcNGI=;
 b=Dv+7gQQXh/APEDIMPTMq23AJUb2P0ENxdUt40KUywufgScsb9z8WdZcmfJJ9meyDYb
 5Qg5YmXzdvDGvwiitl91Bt2iZFUORPazIOUziZx6yFuQb8drGWxJlnIf/VVthsb1Jfre
 6VMLuuLAhC1JCcuii1A/YG4QdCQ4mfjnw89AxdifwEBe6szeBQ7uqesLuMHm6FJodUca
 O9gHK8detNLPAePqDiEWgSqVUf9IAyZMpeqXqPPSb6PHoGoipngBPqjJdrDVFttKIZjT
 SfhyqY1jrJ1sL/Mc5cgjGlViEcnaclhMt1X71is4PsoH5Zm/R4N7NzrCqtctMkC2ij+j
 FKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785422888; x=1786027688;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3gn3HYZ5hzQgQcFKlOAn8q+P8RK3JWAS4+JHwXjcNGI=;
 b=sv+UY9tVE0sCBMspEQuAVche/TKvaGBafS0/CdDy2bgBn/oNWdWc2HlIlvjogCxpyn
 gAWwnzszVORBsyIPQMrsI12OKo3tMApA+E3qEy0y9fEEePhlGcyI8ZYytDOXLkwKqdcN
 G5KGK4cNup8d/d3OVv4w04K96cED/SfP4XznQoBdCaijUQ5cyD+PmlEWRC60FxiXqGLK
 eL0gtxk+J6gl55jP8Z9QcMoFXSJ73YaUmatY5wJKRwBeGJ58vyoA6HSBRNjkfjxdpYg6
 ivqQCSacG2WLNaR0sBTT9RSEntPvE0OgvBbF8PNCd5iaK6YF4zMoerWnoFxiOHpxxTBI
 KiQw==
X-Gm-Message-State: AOJu0Yz6KF92EfUJmo919TLKhIbiNNwaYkM1S7gFHNmRxFJ+BZiTo5k4
 Trs3/21nyd2Cj9t6+SWA5D9Mtf3mNxtWdV8VTycmAr6Wh5I5k+QAs9nGswjG/RT5KvLQBYulVWC
 YwUHE
X-Gm-Gg: AR+sD13mt68RDIHt2oM/wlTEuCjrTB7BqIvpicBjYAAK7w70vCwz9uGRZA6I85atd2u
 VKO09dtpBbw2I2J8Guaz1erq9AV0BvSEcl83B0SyBi/WJ6a3blBiGwABm60lVPh4my/T4uvScfS
 6RgWROWbdU4ofgnxo0VkPxRU8mo4a8x5IQeTOQVLM1F5/gLzrdB9MySUsc/6vx4CZ4WBpGzjXwq
 e13hvnRkKq4in0DwohY17u1Ro18SIhLP0+JL6rIBw9couA4Us3+PSSedSfHxmhF/RxZlutimE8h
 /U2MHzBkG1F1y7T1bahJgRfu4C02IrOAr+EIchVhHFI195neISSle2nSCf2OHt6CGRuVRpe83IQ
 ESfaAJZZiyyS6IZnpGm9wTxALvIxtbY2M3oWPhMqWslwf4oUqM7fQm7zBHgPFOmADIBToIetIMh
 rXGMVANPNQs1Dgj2xo19nTi9JcrBi1Fu8cyXNLd7y6cEoEb0sA0EzbIUEYXkXZ56s08dYHiTu33
 7lbQUJhMTs3foMXSW7XIvaqiKVIg2GMPz1Jp5o=
X-Received: by 2002:a05:6a00:3495:b0:847:9aa8:d3bb with SMTP id
 d2e1a72fcca58-84ebc1f5e37mr3022647b3a.12.1785422887950; 
 Thu, 30 Jul 2026 07:48:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea03ca2c0sm3179421b3a.60.2026.07.30.07.48.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 07:48:07 -0700 (PDT)
Message-ID: <76b67992-50d6-4324-a6db-28c71d5c8cb6@linaro.org>
Date: Thu, 30 Jul 2026 07:48:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/50] accel/tcg: Add getpc helper
To: qemu-devel@nongnu.org
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-3-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260730031025.12926-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/29/26 20:09, Anton Johansson via qemu development wrote:
> Introduces a helper function to return the current pc (returnaddress of
> the helper), this allows helper-to-tcg to correctly translate nested
> helper functions that checks for faulting memory operations.
> 
> This is useful as an optimization where a helper functions has a
> commonly taken fast path that doesn't fault e.g.
> 
>    void HELPER(outer)(...)
>    {
>        ... // non faulting operations
>        if (some_uncommon_condition) {
>            helper_inner(..., GETPC())
>        }
>    }
> 
> the outer helper along with the condition can then be emitted as TCG,
> and helper_inner() will be emitted as a gen_helper_inner(, ra), where ra
> is the result of gen_helper_getpc().
> 
> NOTE: This is not ideal since we're introducing extra helper calls,
>        and the solution doesn't deal with the "inner" function not being
>        a helper.  A better solution and what we'll probably do in the
>        next version of the patchset is to instead emit a helper
>        definition for the "inner" function that uses GETPC().

This is both confusing and wrong.

If you're transforming outer to hot tcg + cold helper, the cold helper would *still* use 
GETPC(), which would still produce an address within the jit code block for the guest 
instruction.


r~

