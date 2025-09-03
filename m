Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E4ECA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utg6I-0006p3-GW; Wed, 03 Sep 2025 01:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utg6G-0006oq-Cc
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:32:04 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utg6E-0007H3-OK
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:32:04 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b0439098469so392696466b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756877520; x=1757482320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fdH062GXoHT4fnrcNCXci2q8mWrDc7rYeRbbnMb3rdg=;
 b=EJvfxuL7ANEbWD8LAd2jMTnP6BRojlo0a5NALHr9bIVOD3QkeQPvTt60L9e8+ZZRQr
 SiPGxXnWDqe7aokfu6aNJw2GZedXngy/wbK5y+rAQsx/zA09Wxh6Ai1nZ2IwKP0iCWYl
 G3Ji4sWRl4Xf/aPJqEcwgZV2R4/IUAwipF5jOjo5+jPRmdrMre7CnrHKUV9f4qbprAfg
 be3hmh1XWLlcRsE+xs9yG3E9p5OHNy/PPeW5n28LFIrr8Zy4arAb229dLe1QWvmwknbK
 yceKBs0BKlDg2/1n54X67LeHzvX0k/KeSd8cwxHTToYozYd630/w4+U6yTWcm0kD8M/8
 Xd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756877520; x=1757482320;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdH062GXoHT4fnrcNCXci2q8mWrDc7rYeRbbnMb3rdg=;
 b=TP4XBTWCIZYDA4+0c1Ao5AUiP6sDfKNk3Es7BgL4IsetFUH0QYoqzO8urBgj3KSwfB
 ASMwwYju5NMvGofci9BprT58kfGSNezQTz/Rb69b3e8FLnMxsv9OVoH+0pWGToIeLb2X
 s6ES3ivP3Yhn3jlByDhOM+aJvTWkbqmYDDt80I6lLUM73yKX49L3n3T6V3NsSGQGieZv
 a6SdkHykRKeqqfPISYLoiLKmIJBpw65c1E7RZdHA3vZtZ6LaE9QrZuop+V++8rFqtzxa
 o5ozdbd7gjSKLFvdgPD5EELTB5F9b9flBjelNO4DHc2iWedHheYrKlnojdPkV5Yc33hO
 k3kg==
X-Gm-Message-State: AOJu0YwJeMXp+n0KZ+p06vTNpWOcR86zkatvjmkG0/XJ+YOeL65l4SA6
 3Mzb/puWOniToGw2MRTi92XKDbw2jy06K6FHSBL1HwJO7agxMnZPrSyE8+lPgThxaIbXmwZXs48
 5PsNdNLo=
X-Gm-Gg: ASbGncszo/WwMuxorREurMRAFvlJdZHthJXDxBGNFRiw7SdpdsxJL6idNjWbI/bn2mJ
 QvjexVGZeBJXO62j+FvFBS/fl/fAplKAZAsaLDxYKIycDlKWWjKfhdQwdPBkEDIWikAGQNK0Ovu
 eQb2EeXqMfv/mdxAnl6kwlWF/Md9CsLK1jVPWMNbKhrBMQLnmqBEhN+83xD4uU9gQCb8KMqB5RJ
 wknLiCNKFJXSD/0mBolZIxOJRA6NbeRn3quERXJxbYzHr4wYi4wJjXI+NnmL76q2rFE4qq7HZbD
 bGyiBc4Zb28r7sBtoyvSyl7yhWlYUCw0AIInrRVsQVkD3LG4Y5OL3/Xox6RyVh4tw7wp8tR8UZN
 M8aa0D3DoZo5D0a5ar3ApprppHH29Q9/xvwCodG1E8ve8lZ5WrSVqrM6T1TSsCiTmcBmjeTh4Oz
 ByLuPyx9WJb++cp6hd
X-Google-Smtp-Source: AGHT+IFroqKB/CZrAXJfbYEvcQ5fztwnqsN0+CZUEVcdHDBRocOZKomb2EpoC4Iu0y8jBU/XPBtAHg==
X-Received: by 2002:a17:907:7ba0:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-b01d8a30045mr1396311566b.5.1756877519922; 
 Tue, 02 Sep 2025 22:31:59 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0432937e0esm633759466b.3.2025.09.02.22.31.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 22:31:59 -0700 (PDT)
Message-ID: <49bf5320-37c9-4632-9165-0ced917ea64e@linaro.org>
Date: Wed, 3 Sep 2025 07:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] linux-user/riscv: Add extended state to sigcontext
To: qemu-devel@nongnu.org
References: <20250903042510.279954-1-npiggin@gmail.com>
 <20250903042510.279954-3-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903042510.279954-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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

On 9/3/25 06:25, Nicholas Piggin wrote:
>   static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
>   {
> +    struct target_ctx_hdr *hdr;
>       int i;
>   
> -    __get_user(env->pc, &sc->pc);
> +    __get_user(env->pc, &sc->sc_regs.pc);
>   
>       for (i = 1; i < 32; ++i) {
> -        __get_user(env->gpr[i], &sc->gpr[i - 1]);
> +        __get_user(env->gpr[i], &sc->sc_regs.gpr[i - 1]);
>       }
>       for (i = 0; i < 32; ++i) {
> -        __get_user(env->fpr[i], &sc->fpr[i]);
> +        __get_user(env->fpr[i], &sc->sc_fpregs.fpr[i]);
>       }
>   
>       uint32_t fcsr;
> -    __get_user(fcsr, &sc->fcsr);
> +    __get_user(fcsr, &sc->sc_fpregs.fcsr);
>       riscv_csr_write(env, CSR_FCSR, fcsr);
> +
> +    hdr = &sc->sc_extdesc.hdr;
> +    uint32_t rsv;
> +    __get_user(rsv, &sc->sc_extdesc.reserved);
> +    if (rsv != 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext reserved field is "
> +                                       "non-zero. Attempting restore anyway.");
> +    }

The kernel returns -EINVAL from restore_sigcontext, which causes rt_sigreturn to 
force_sig(SIGSEGV).  We don't need -ERRNO here, but returning bool success would be proper.


r~

