Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F0ECD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVmk-0008E8-9N; Tue, 16 Jun 2026 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVmi-00087Z-2S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:33:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVmg-0004Es-HU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:33:03 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf125989f2so35157315ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781623981; x=1782228781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H2YyalrwFNEv7D034cKZG4YMW/b3G6Bqmn7fAphQxDs=;
 b=GP0NA2lMQ+Q90q5Pku6nVh2h/TIdlJFh+5x49fJRVQk30pWPYvMDo7mPsCz/225eYq
 4T8FRm5s3Ny6jtkuMefW4XDRxt2eG/tF3ffDT46LaGpks79tkXjflyWxsqKNu9+sV2JZ
 3Vd0Eks9HBIEAe8mhMIJxSJRBfqE61qRj5P5pRLfBFYH2GAw8hG6yTOHmLkf2xTI1LqV
 NrwDcK+IoQiD8NXVUVdMoPXrA/IAtoogA/71Dye9SfgV5kQZqRJskC7nnSg2AfmABjSS
 GvF0H894MfB6CUuKT2pERCKp7PWHAEVJ9xItexAsXEEeyJvkjzA+NUfNzWs7EoUYGEY+
 wX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623981; x=1782228781;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2YyalrwFNEv7D034cKZG4YMW/b3G6Bqmn7fAphQxDs=;
 b=Te9/ZIImYylAQG/eTxDq8INKB7Bs+gYfU+s0gEdsbdJF19pEBGPFLuZVvsPRsSGUm2
 KjmxDau1nuOAShRzaLrB4cHKQ8KcAuSaHznt+6quZ5LwXWQRR9fgKkzGCaB5/5t2m3JZ
 i5Y68HHGdG9RjpsUtpsYvI8JU9291/wbBRckdVtwJu/L4E2Ls1pSGBeux4rwKQ+gqnXP
 iKB4gjl+rIqMA3jZ3oxV3MYIjQmx5PnjV9X6yTUk6sg/9pVt6NlWKBVxcLOTTTZUVkVq
 Sw89mLQ8MYMgqUohBmF4FmYFwAktwUbVOKEVtXEGRFnzMuB5UfLv4cKvR6i+qqvNDet0
 jINg==
X-Gm-Message-State: AOJu0YxMqPSWd5hz4tfd1tIi7Mk0lYy9GjNptAQPD0tw/V9Paa/RlfPK
 E1tV9QMC/S/+7KO34Y2q/a8ilpRt1PCjXaupjubjTqMpyQeATNwcJ2NA0jHH/9wpvZM=
X-Gm-Gg: Acq92OFJ/J0OoidBCFQiK84KLLbamXB38RpbS20FruWHH0lZBup1ppUgPTtyenoOu0q
 pflYJF36r0jGVi6SXNo3mbSKEOWrvj1+WjF38dfjOuRtJyR5TEGTBiPLT87WmT7/2KAlwNh3g5w
 ViEr236gUfWitIo9CF0OeBF7H471tUaZzSlPr/LZaoAB+WLF1qOWQ0cIpTttxJw/7U0cIJJSEwq
 vlDyF2UmdVxBvhEGBTCnSXb1u4w8eGkSW6kpJQSFdmGgw3KgDxYpWaVgkRqUs6crlNwQXFFasfA
 bIZ5CfrefEWB2mtyQCD8UhmfoWQz9Q0Buvi3u3EG58xlN3MUmsxPzDT7USfpl0vm5QGZjvG4mH9
 L/PyF/c7Q7UFbAoVF1RmUbWt+RqohFuoUNiJItpG5xnDGrAs9TJydQeSK7g2NRjRTIVLXXkCn7t
 6f3pRGmPVO6LUZMZe4qyvrIhMvIhg6VAqY/Q6Gd9sS3p/WnHleLd7AyzYdOLerFqnqNzez
X-Received: by 2002:a17:902:ea07:b0:2be:22cc:e227 with SMTP id
 d9443c01a7336-2c69a0d455fmr38792325ad.4.1781623980779; 
 Tue, 16 Jun 2026 08:33:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4332694fdsm127026365ad.69.2026.06.16.08.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 08:33:00 -0700 (PDT)
Message-ID: <cea5b694-3f2a-432b-81c8-e44ad6fec70c@linaro.org>
Date: Tue, 16 Jun 2026 08:32:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/25] target/arm: Enable FEAT_SVE2p2 for -cpu max
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-24-richard.henderson@linaro.org>
 <CAFEAcA9zRtLb_judmNjvXSq_ZgASNyQZJMGmhcgaQ+p2RkcKKw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9zRtLb_judmNjvXSq_ZgASNyQZJMGmhcgaQ+p2RkcKKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/16/26 06:43, Peter Maydell wrote:
> On Fri, 5 Jun 2026 at 00:52, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/aarch64/elfload.c  | 1 +
>>   target/arm/tcg/cpu64.c        | 2 +-
>>   docs/system/arm/emulation.rst | 1 +
>>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
> This is fine as a patch, so
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> but maybe we should hold off on enabling SVE2p2 for "max"
> until we have SME2p2 ? Architecturally if you have SVE2p2
> and SME then you're supposed to also have SME2p2.
> I know we usually don't worry about that kind of "feature X
> implies feature Y" when adding a new feature, trusting the
> guest to check separately for X and Y being present, but
> I feel like SVE/SME versions are particularly likely to be
> something guest software might make assumptions about here.

Fair enough.  I wondered about that myself.


r~

