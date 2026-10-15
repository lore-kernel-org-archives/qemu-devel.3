Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CBACC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHFDQ-0002sU-PG; Thu, 15 Oct 2026 02:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHFDG-0002s4-QC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:45:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHFDC-0007Lj-J6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:45:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48c14a06c95so3948483f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792046708; x=1792651508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OGYwt5XI641mePvE1up/w/p0sVL3c0UEBiy95XFSdhY=;
 b=uGmU7ftdYkX+HvC8hepyzrTaryZ+BSbjvOpFhyBVu4nY5BqUmCMRCge5RFLiYkBA9q
 tPucjJP0s+VAVW/2Yyk8vXh7DAkYSnPr3pidn9NJNnhwG0VSmnCy0+ThMaCZ9LYdwWRv
 ik48aUBAZPVxMrCJaNfHUiBXzbWo+ChcqDfl+q/Z8brMw1QXZEmOmqpOKZeMVId5BC6j
 0ghz8R87hHO7iFfarv8F/HEdqfHWmPlcwo5vz1bYOBI326pvfJ23k/lN3luFlisXbj4e
 VSYqpOjigkgkESrr/ovLDZQyUIXpdf8JfYAu4MlI+Ay8FpTAuwcDiHK4O0lhQ3IKg9Ni
 4UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792046708; x=1792651508;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OGYwt5XI641mePvE1up/w/p0sVL3c0UEBiy95XFSdhY=;
 b=Pq1YjxQreK/WD5RTzaO0qrKygizVdDPweqUs4hnbB85PFQYNGeygQcvQlsbJtzlctj
 9U+ztlv11RY9NESjQ+tw0RDiKLw/LyPq9u17HbfVcc9rHn917GZFanocLQhgbzmCz05Y
 O19gdjeBcBaNB8pNHvSGFPpSHZdPbibU4rvuH7OpLrmfUYDtjn+I16JZ1MzqxlnCvkaK
 1hW7d+/z+XFcC5T/kr1jAjNA76V11v9dXed0Ze9LpcWQR7deRWTiEvtHRYRbO/YYl0mg
 7trryHdO+CZvzWQkASjJgQpRU9BkG+8MGRAq9ZrmfIfIoGryDk/XBzCZZBegkCxFKan3
 nk3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2GkWBM90+HkIBHgYZveQKxPmVBWtx8NGuENM8bgV9d047I2BoMuFo/u3TUhjbTsoEPeSk030ng7xf@nongnu.org
X-Gm-Message-State: AFq9FYISYze2tyJ3Nd9DSG2tDkMbf4vhgsIsK6kRdPyrrS2WR2StKseA
 KZu8BK6ku+h/ao23qqsxzU+95NdCaHgIbzcIcH++R3FPT69yNrO/lcoo9q+1ac0o7tE=
X-Gm-Gg: AYBFou16Apue1USolCSQQ6b/JxEkKZc89vfNI1v2yDZmyJYlokTat1slZN33pFXfh+Z
 LuRWvr+4YTeIm78vnD/bBOCmk8Sqg8LOQcII9gaifhEnYPIeAMsImRE2rqIjsbTaZUx8XTDXPLl
 eWzh9+pb1wd9zhK3vsdjIeRtzm8qVVMR5CQL/2t5dLKs0jqeX4jsgm4wr36Gti6GnSZJf673tVX
 eZBpXZJTg4Rd6O/UW61ZXgvy4A7gOe2bnmO0jXgkYZ1Dt+hx/uPNBd19K22BXS+iTBsP7bICYmK
 nxvVHVOfvpNEa+7+vvWk+rRQzBl+WYCcrLhj9lekhQ4VyDWv+yiTIXhealZS9gt5+vAIb/+h+AW
 9GZrirGhXkDHmDNXbQQj+9qXDuqNUvfHini6CvDNFWP12V/ZkXM/SnQ6WSqQ65siyPnq0FxzPRI
 a0jeMyz7I13B6n+76Rx9jqRFDG68cFfprTWAI2xRBeBRJceKDrPL46AhiR47mq6EH2LR/+3JSsm
 +6dp5qRyY7QekQGS0pBYEbyqXwKsgUxFOmN36yRr9bAf0F7g+sKCf2X8TSbT0d1MhhmFZEaYGV4
 0O5v7IN2md/ouAF1mZlHgpfwxvxVyu3Sdq0Wfyec/r+f6OcX4Jw=
X-Received: by 2002:a05:600c:4f89:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4a1acaa9f79mr147563395e9.25.1792046708065; 
 Wed, 14 Oct 2026 23:45:08 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:a126:fdb7:f67:bb04?
 (p200300ca3f0f8b00a126fdb70f67bb04.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:a126:fdb7:f67:bb04])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967a0dsm16503624f8f.3.2026.10.14.23.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 23:45:07 -0700 (PDT)
Message-ID: <5abb88a7-ae1d-4a3c-80f2-90cbcefe2d25@linaro.org>
Date: Thu, 15 Oct 2026 08:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/alpha: Determine tininess from the delivered
 result
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
 <20261012-alpha-fpcr-status-s-v1-2-bc7efa6d5609@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261012-alpha-fpcr-status-s-v1-2-bc7efa6d5609@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 10/13/26 05:14, Matt Turner wrote:
> Alpha raises underflow only if the result it delivers is tiny.
> softfloat implements IEEE 754 tininess after rounding, which rounds as
> if the exponent range were unbounded.  The two disagree about a result
> that rounds up to the smallest normal:
> 
>    0x4p-1024 / 0x1.0000000000001p+0 in FE_UPWARD = 0x4p-1024
> 
> The binade below DBL_MIN has a finer spacing than the denormals, so
> with an unbounded exponent the quotient rounds to a value below
> DBL_MIN and softfloat raises underflow.  Alpha does not.  glibc marks
> math/test-float32x-float64-div as XFAIL on Alpha because of this
> (glibc commit a32db99a38), and under qemu that test unexpectedly
> passes.
> 
> Every result that is tiny by Alpha's rule is also tiny by the IEEE
> one, so there is no need for another tininess mode in softfloat.  Drop
> underflow in the S and T format add, sub, mul, div and cvtts helpers
> when the delivered result is normal.
> 
> An insn with a denormal operand is different.  Unless DNZ is set it
> traps for software completion and the kernel computes the result, and
> the kernel's emulation raises underflow in the same situation:
> 
>    0x3.ffffffffffffcp-1024 / 0x1.fffffffffffffp-1 in FE_UPWARD
>      = 0x4p-1024, FPCR_UNF set
> 
> That result is tiny whether tininess is detected before rounding, as
> math-emu does, or after rounding, as softfloat does.  linux-user
> computes these results in the helper instead of trapping, so keep
> softfloat's underflow when float_flag_input_denormal_used is set.  In
> system mode gen_ieee_input raises the trap before the helper runs.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   target/alpha/fpu_helper.c | 36 +++++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 643ce641e8..d902cdd9dc 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -55,6 +55,24 @@ static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
>       return ret;
>   }
>   
> +/*
> + * Alpha raises no underflow when the delivered result is normal.
> + * softfloat does when that result was rounded up to the smallest
> + * normal, so drop it, except when a denormal operand means the kernel
> + * computed the result.
> + */
> +static uint32_t soft_to_fpcr_exc_tiny(CPUAlphaState *env, bool normal)
> +{
> +    bool swc = get_float_exception_flags(&FP_STATUS)
> +               & float_flag_input_denormal_used;
> +    uint32_t ret = soft_to_fpcr_exc(env);
> +
> +    if (unlikely(ret & FPCR_UNF) && normal && !swc) {
> +        ret &= ~FPCR_UNF;
> +    }
> +    return ret;
> +}

You can't talk about what the kernel does without testing 
CONFIG_USER_ONLY in there somewhere.

swc doesn't need to be computed early -- ideally neither would normal, 
but that would require two helpers.

Is it possible to merge this with soft_to_fpcr_exc proper?  I see that 
the comparison results wouldn't have a result value to reference for 
normality, but they never raise underflow either, so you could just pass 0.


r~

