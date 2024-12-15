Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5ADE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpHo-0007Xc-OK; Sun, 15 Dec 2024 09:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpHm-0007Tw-Tn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:07:54 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpHi-0003ZX-9F
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:07:54 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71e17ab806bso1826819a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734271668; x=1734876468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KKQR3G64OI76Tq4BsVNVV7vsJIYyPmz19YlysjnN6pE=;
 b=RUjYMQOmxosSPuXIGdgwZmurDWo8CBtVYh2yRHRWHrwa98g8rxM2x3SCl/LgIDGFcU
 EUz5CTvrtTKUUt9efSSyeeFxh3oX7pR2Weqx/Wb4TjAy11ICpAhB36I+9WPaW4sRkt2C
 qK7bi6wKUGhmN9V2ng9HppE0mQBLSK7cPbzACPj/XLMwRYUWDPosnemV7errYjPOSSq/
 gC6rW7cBHYhPUWOl2wg71qfqOdjylPFaZqzzQrAXCVeXHUwafdoaMypC/hrx84BdgbR+
 RM+8b+mlRetOVBM/JHqmVNnz704JAvX8oDYW05oTqTHK0q97uEs++SKZhY4TulZuhWma
 oDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734271668; x=1734876468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KKQR3G64OI76Tq4BsVNVV7vsJIYyPmz19YlysjnN6pE=;
 b=LicOGcQZ/BB1PBpXfOkIGxk4tzrq+L8yFCukMXqhb/nb7HGGvl4o0NSgi9NmatvtSJ
 RBeW0Byu01UA/NRywl8ZnKfmeZlaUK2xMt/iRZauDUGFAvW4pOlaVke1NS/WnRZti9y0
 F0wwh+c6zxjKmKNoOtxU/GYOuGg/57jblrhl9f3h68VVgCTz1aL+dGQCSpYdwb1JEI0l
 k6oaaK8hh0HfQJgpENihzWb7zMtu/lkb7Zjh+KwD8/MaLGp/UUuMnx/4QffzjWMg+3G9
 qof1A0w8d2gzpYkqesbs7qgoflDn3rxjYIYkWus3G7zVhulthk9NYOVZyoe2MMaj0PwP
 Z3/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr7vFW8nsyUlyyg6FlJQu5tZ/Oe/uaBejoSsOOT0bshOXISjqL99RwElMBJFNXHvOEKUt75lHS1JW+@nongnu.org
X-Gm-Message-State: AOJu0YyZOTyURPfbkGSKt7eOi3qzTN4SZt5amwDF8Fw9AactJ82wtCiZ
 8x3wuprNVFGVwCmjapPMmbFRPEI96fSC7fr2VmlKy4UrdsLxoUJWw27GWxvDQUOMNtzFuk039Ol
 NXvtaWmfU
X-Gm-Gg: ASbGncsUxiBY0q5lzlOtr1TdAY+F+0XG90LSlaKJQqkdnhImpJQa3qwywYnTEBH/Sdg
 5Q5HQIDqLmlwjqQtQKVIw3ixmxmsbGN5Z55WYjPQvWZui1sQYHtXJPlBGn4OLGCRagt7LW1FmCT
 m3/03o498oN+UQRBN1S9pUDun55UN32CZPlpdJRXL2N7jJqTOqoEsVNvFppNMQ3zutNnvVMwJr3
 EZD2b+T4ALa5R85yVObWDr9LDuO8P/h9xF2fs4h91/FhuNezphsjs1KZvR2fxH68TScJrv/6mOe
 qQYr2NmZvouAckasGZBdQqXGRYuR8zFHmrA=
X-Google-Smtp-Source: AGHT+IE6lozy+ZlXdSIc8RsbwcldtEH1/301tDpWlCH5aA1CJMYaqjHY7+bxjJuYELspVH+XRd1XOA==
X-Received: by 2002:a05:6830:700f:b0:71d:e900:2322 with SMTP id
 46e09a7af769-71e3b858131mr5592801a34.8.1734271667890; 
 Sun, 15 Dec 2024 06:07:47 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e484ae1easm857318a34.46.2024.12.15.06.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:07:47 -0800 (PST)
Message-ID: <d3437749-604e-46de-b92a-ba0a4e18113b@linaro.org>
Date: Sun, 15 Dec 2024 08:07:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] target/i386: unify REP and REPZ/REPNZ generation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> It only differs in a single call to gen_jcc, so use a "bool" argument
> to distinguish the two cases; do not duplicate code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 39 +++++++++++++++++++------------------
>   1 file changed, 20 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

