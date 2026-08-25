Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C9EC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 23:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz0HK-000132-OW; Tue, 25 Aug 2026 19:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wz0HI-00012E-Ie
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 19:10:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wz0HH-0006wX-3A
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 19:10:00 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso402945a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787699397; x=1788304197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PZHVtUiOjBvf1w5Hfx02DNbLnTHGvE3AeKOf9ga3n+8=;
 b=LdZCs00IS0ySi6ZiootuoWxzAhQkak8QwA9XmW3b+xKsGEf2Yoxf1lHv4xtroIcxlB
 ktl4lUh7tApzPsYfSdZR9UnRp10N0ZCJdupPH5ZTikgKUuyTUcgSBTIYHJTCqFg1vYwr
 K7CUxZiFqa63e21/B5Vso40WJ0iTRlCFr+JZXfnaPABatOBEX1hSZcQyPW3QgmeXQy/j
 Ji0JR2fR8cIrHLSMH+bDz7OM8reeSN6MVD4RewwmM8wDQRqXY+XgdiZBend4EMk5rvKI
 FdRurd849RZaf6Q+dHK2iHrk3sCpA07eFtotH+Eyf8u4zSplIlZO9ydT5ak3MnZA4lPv
 yrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787699398; x=1788304198;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PZHVtUiOjBvf1w5Hfx02DNbLnTHGvE3AeKOf9ga3n+8=;
 b=l4KjuOOCfjtadMgOdSTn1ToD9yp3iFRLfEv2aZjlZlPe68D/nqUnpOlMmzaeLzb/HU
 b3UgwqJ5fsRUel3v9MtE5r+YtFE9kRZwfXBY2oSycxzDtzzVd9pKkFq1Kyc83Vk/U0Gu
 eH4FQIJrgIUIMTrVsYsU70frAdoBHlKSm0E8qYOrFGnZqkrt5IcYq3Bzo7MzoARBVZEz
 wtSYzFgaq258QHrrapdAKQf9jbcwOeRq747FCb4/IGwYP7MpiB1jj1l1TZg8mISCHJgh
 zFVaeFp1rRSBGcCiCDeEOQ9vylQK2HFRUEAT7qYcwbfZ5y17JdR6sEFnnuPwCasQVrLn
 xyiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgwHBHF91nYDmhcL4fHu1GsnokSjuqMbM7JJMUP+IBhVlKp6c9JCwqvO4egM53IHZjJE7lSBTsSMQL@nongnu.org
X-Gm-Message-State: AFuF++mQd69m3L/0fNaSuzQYaxp1DNHZoRYRsS7OXOVaandPl6RFm2wj
 uSO/M3FujYKgGpjwdrs2o/TSOxBpmBdAsMRLwAMB5gH43X8+ID5J9mIaOdsCJAG2umM=
X-Gm-Gg: AR+sD10BX1ssAt5S6Oq+OouPm8JSiroieX2DU3Ep8mhuXVia2tBwwoJdvEhIuhUe7eg
 HsrRPpEETSAcZYT0ZIhyuroqztZKyBB8ymq7vd0WrrdjynrrrrgshHREddQWsSg/KyHQG72HTq2
 6+nLOkDOv1L/jrd4u0n70XNouM6IMmlHTBaZSjVgWhJxPLW0/OERqsOGwz0bEyPn3wRrde3G6Aw
 NHk6v1m8wmRvKHvxwEKA8+5fusRnylqDA2EaF0TpXkLoQ2o4ZbS+m7gBdKOwRTmcWA/qgRSScbK
 tzFqPGem86ysYje9JNRen5v2ZAMhnT+W/kJG8d+cL42qh8UFipibMcaml+V3v1K8ATNaERxBGmi
 IzIbkAJBapSR4A0Q6ZgAlBHAJ+u7+1G9zb+YigTJ0zyIC09wa1t4HwCvCaD4H/hiypJ5uYYqNLt
 WfnKD36JFgCHozYb/GbgRNQQAES64i9v6OvbAdGv25UiSq7uy2UoMjpY55Sd5U1U+EhHxsHjfzB
 vbponAeyAWDO2IYT5W09SFPKSbH
X-Received: by 2002:a17:90b:554f:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-3966d9e151dmr2689194a91.10.1787699397577; 
 Tue, 25 Aug 2026 16:09:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39646138f87sm5323835a91.3.2026.08.25.16.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 16:09:57 -0700 (PDT)
Message-ID: <df1e94ad-458a-465c-a244-8017c5ce5cae@linaro.org>
Date: Tue, 25 Aug 2026 16:09:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] target/i386/tcg: inline gen_ext_tl
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260825122921.431739-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 8/25/26 05:29, Paolo Bonzini wrote:
> It has been mostly replaced by tcg_gen_ext_tl(), other than for a single
> appearance in gen_op_j_ecx().  No need to have a separate function.
>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 22 ++++++++--------------
>   target/i386/tcg/emit.c.inc  |  4 ----
>   2 files changed, 8 insertions(+), 18 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

