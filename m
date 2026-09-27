Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E061BC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAsXR-0004HJ-Gp; Sun, 27 Sep 2026 13:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAsX5-0004F9-07
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:19:23 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAsX3-0002xQ-73
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:19:22 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-3a0b0fa2055so1345542a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790529559; x=1791134359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kG6pRtO/2YP6MKP7OHLXrdIWCOygeGPp5IG9VC/pyqY=;
 b=UhefYJDqcKgLSBQVLIdcjS9/YLwpis0IOCBZbjqt+NqDUNsNsjm/jOc6f/hU2dX4Td
 0nPV0p7d1ajpEfQa0wJrx6MYSGQGuTe7xWo7liAGuW9fDtH6tA8bKp0w2hfd2q2IggE7
 w+D7HJr5qn4HZ8+xJHl5KsMGBWEBMQmNZx/QtFYW61dSOi8/+CQfJ1ui/+T6d/MXBVBO
 vpA+gzJo4udOlEmquHLM28O8rsZiDaOgdC6Iy3cZlTuBrROOH3lr5yzMTaTtqVq0XCaT
 6HptkFgUeVimzlVlev1bWir7xULU+yOpwwKerfDLwOMi+SvwbX9hkYr0nxQSL573xEA4
 /4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790529559; x=1791134359;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kG6pRtO/2YP6MKP7OHLXrdIWCOygeGPp5IG9VC/pyqY=;
 b=dsAFkGa017JPStohf9NwK0y1rAolE+Z0rEA0j6b/iAX7j7u4O8bwVWpDli9ssCe6EJ
 mqwE+ONU6tfrM+G9czdFWy5gkN0LqtKqjfZRkxQyOAVRZrAb+vb0U6Ifaw2zhf6HUZ7n
 CjGDsK5Eunt4mZbwM5awWP5u2UOX8A1amu2QM0hG/aBM14EVb7qcWNZEm+MJQpCgBQeG
 ZC9Qx5Kxq6tnFAHV8UkSY8TG+B6D93mu4EVYFCoYOqtYzyI/65kXBxnHYnWFKeTi5nwp
 KR77o3fASxq0x8HSYxltJFx75xSbyC4nYhiqQAe3KaDMCw68N6YHvRo+xWhzU7yAtXSm
 Uaqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAySRJ4uFyhHWiv1L80Gc08W2L2nCm4Ih0YKFtHLnIlqWJ+4Pajznh0MITohhM62eLMxixsj5ciDi6@nongnu.org
X-Gm-Message-State: AFq9FYKplCdC+Blzz21kxQJi/H7+XcWZEdHRjLvjpCbkzfBgUdKt0uZp
 pCAAp0fL4VZQxuFqNMfcCeab6FZhKoKr1wsVDQvFAgb3hav4ncEC1ppqeZ4QO1Yczjg=
X-Gm-Gg: AYBFou23GfS3FgXUa25pfYmnDBRw4jOu9ZaqO2xdmqLRTdYbjN7j7Za0jGkDjAyIY7Q
 CQ1ZFO0vi5xLyPWdM4jF44kh+IlanFztkoNer9GRuyStpXIFpF0ukIB8bV2d5cdskRlwlqceN0j
 Fl9DobIgnVqKQDhE/54GqwjLEvUiIHHeQGpH+mN1dpslOL0j5FeNsVSl9ZeSXEER4WbGGQzfDnp
 BfGsZU5BvO9+F9C8PeQvdQih9O+AApq+wk5EsAjckAm6La1frjgo1ZO6rkurxYrgzj7D+tdbyu0
 B528Ut2eSt7CE9uf/yvutqsagYIzkm5ogBmfO6R4PpVWSpfQzyCIshxSIxH/30iczA5znQW3m+k
 o2BOUApK/l8TpvoIaSO7H7MwJhhgVRHE26Ij268AG++x17qwjWee5A0bDyQW8LDjxLFldAHz16O
 tjz5C6ZO5FoWH7i6a2wn/JFLseLucblWAyHMnWubuol7j2Q55sLwFZ6M/ztlPH8Jnz+bZLlmY/9
 cEJkFOID431yCz4bg7pvIwtGPjMnaxCZtizW1H4MA==
X-Received: by 2002:a17:90b:530b:b0:3a2:ad6e:4435 with SMTP id
 98e67ed59e1d1-3a2ad6e455dmr1924225a91.5.1790529559435; 
 Sun, 27 Sep 2026 10:19:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b4f5b1aasm6019276a91.1.2026.09.27.10.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 10:19:18 -0700 (PDT)
Message-ID: <b840941d-8dec-4868-a069-ddba3f87b9c6@linaro.org>
Date: Sun, 27 Sep 2026 10:19:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: fix lea address calculation for CS
 register
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260927123807.492352-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260927123807.492352-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/27/26 05:36, Mark Cave-Ayland wrote:
> When the effective address calculation was simplified in commit 55a15eb3504
> ("target/i386/tcg: simplify effective address calculation") the refactoring
> accidentally introduced the ADDSEG() macro into the CS base address inclusion
> test.
> 
> Fix the logic in gen_lea_v_seg_dest() to use CODE64() instead of ADDSEG() for
> the CS base address inclusion test, and at the same time split it into a switch
> statement to make the logic easier to follow.
> 
> Fixes: 55a15eb3504 ("target/i386/tcg: simplify effective address calculation")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/i386/tcg/translate.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 192cf43215e..2d3fffeab7b 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -605,7 +605,25 @@ static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
>           ovr_seg = def_seg;
>       }
>   
> -    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
> +    switch (ovr_seg) {
> +    case R_DS:
> +    case R_ES:
> +    case R_SS:
> +        has_base = ADDSEG(s);
> +        break;
> +    case R_CS:
> +        has_base = !CODE64(s);

I suppose one slight improvement could be

     has_base = s->cs_base != 0;

since we know the value.  It's more rearrangement than it's worth to add 
a non-zero constant instead of the seg_base temp.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


> +        break;
> +    case R_FS:
> +    case R_GS:
> +        has_base = true;
> +        break;
> +    default:
> +        assert(ovr_seg < 0);
> +        has_base = false;
> +        break;
> +    }
> +
>       easize = CODE64(s) ? MO_64 : MO_32;
>   
>       if (has_base) {


