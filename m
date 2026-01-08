Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC65D1D48D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwVP-0002kY-BC; Thu, 08 Jan 2026 15:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwVO-0002jc-Hx
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:21:14 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwVN-0003Xx-4G
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:21:14 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso3079875b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903671; x=1768508471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WMf6DRFdOMfzLaGzyv0wK85ooz+ryUSaaw10unpt1vA=;
 b=m43lL5i7DIHUFfvu1ZC/cuXM5gRyZVwS0gaiT4e8xbN9AjEz/rxnzeEJTMZyrssCh7
 JgkIt+gO3s3ArHOKmamtG2neKCXOvIkooauiQAPuYCELA6HqVTXVOB9S5PTX38rf77JG
 psW4mBw1ZrsPkemm7lJcHEH2DUTGFbXJBPGoUbva/rl8dlVItE5A2dbAfRv5D+HhEqp0
 gf1RqPOxP1T6ctlkC4mU2PYASXQR5rBiqJwf8QyKknPiaMmIvAm/1dFI87z3QWkRDOEz
 KGO/zgc3nXmk3dXcSAXU3/MvcY1y9S0qksg1Do5tY7tUwqNuQRNjG4ahzcbt+SluOmRs
 tc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903671; x=1768508471;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WMf6DRFdOMfzLaGzyv0wK85ooz+ryUSaaw10unpt1vA=;
 b=ZjlfZ3BzpGDq8JX1tc3a6qD0yrbWoZb6rrE5G52HU79Q8aHLy+MqX/BAwdkqrsPkEv
 UQzkcptcu56zatt12b2XFNlcRRozneLmmNonPXohQuZisOZunaYfnsUEF7ouznhDuIux
 zeIyETkBbe7Lyt0fkvaPO9+PpWE3tGwTk4Kgq1LGRWDnezQDn3yelRJYEYkhoIp+oEF6
 ZeHKO4C+5cykxJt2KHpQ/UDPgVVPYKlOhQLnjPIGdU5u9JEIXNlnki7CdJt9Nf4EwYU3
 DSvv8yULzJbUbGeg3LmnW7yKkj07jBjX9DZGts4LKj0bGwhEHarCsDHQBVp6iyziyjuM
 SYuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMh665QI5GvavwV5RiPQ4tVYIdwEACAX0Ft4XtX7fylRbrP6miFF8ewMTWyFbR85d1AERsF6zgF4ok@nongnu.org
X-Gm-Message-State: AOJu0Yy+822oXIQuhZlMKNwSp6lpD7EX51l19x/US/zexoDJtPC1GUTU
 nHRateL/oV2R+S/sgTi/8Lc7QJw6W7J/DMmABGhlePukz0XZEJy+VbMxy+uFmrrGJsw=
X-Gm-Gg: AY/fxX5gPdfdrinT6LoNRElKqWiMW8C6mGcxUp34Q5WIVasaWYCVEnM9WgpytVUYE2F
 wBMczjO1yBM4Zh201LDNaMTjeOrr7XDqkv25HrPJXPBmZjnyBd+EI5Uj5PjWuPGrG/sKjutNI0q
 CEmpOw1U5zlOskvERwdd+949Yrc22MYNPGG62tpP5skWqkxK7BeEbF72uuNTL6cDjVW1BZrkDyk
 4Nbr6JiI2ZzcENBj6R9lbitSFnKBJMvGtxXj/Tva27XigafHOJfL10AmH9VOsosyKjWfi3HWtg3
 DmFchNvCKFT8uOo4+8N4QNDzgYg2kdTtKXRvHHDrD8YedXAP/J1JV6D0eUAMBDUVZ7VGnIGNF3E
 7u0MJix/FU6DQlfO/wyWzdAA/Ws7C+v+xO1FvIN9xulW2REX7rX32BmSp07NqolkU+MQGrmnA8P
 XqcEhgjwLMdwlUFnwusTyoJsqJaSbFgz0g0M8A7YGgI/YUdm6nkL+DyQ2H
X-Google-Smtp-Source: AGHT+IGv78/UJ9fpSS0OrYV0D6YDnJbWSrRgmrdWdrNzSJIZ0DtuhZivdmaTgxI0jj5+/g15fQfRUg==
X-Received: by 2002:a05:6a20:6a1f:b0:371:53a7:a4ab with SMTP id
 adf61e73a8af0-3898f8d5f1amr7372598637.4.1767903671201; 
 Thu, 08 Jan 2026 12:21:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cca06b77bsm8788937a12.33.2026.01.08.12.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:21:10 -0800 (PST)
Message-ID: <8542c01d-b5c0-4ad2-b42d-a072efec46b7@linaro.org>
Date: Thu, 8 Jan 2026 12:21:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/50] tcg: Make TCG_TARGET_REG_BITS common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Since we only support 64-bit hosts, there's no real need
> to parameterize TCG_TARGET_REG_BITS.  It seems worth holding
> on to the identifier though, for documentation purposes.
> 
> Move one tcg/*/tcg-target-reg-bits.h to tcg/target-reg-bits.h
> and remove the others.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/helper-info.h                     |  2 +-
>   .../tcg/target-reg-bits.h                     |  8 +++----
>   include/tcg/tcg.h                             |  2 +-
>   tcg/aarch64/tcg-target-reg-bits.h             | 12 -----------
>   tcg/loongarch64/tcg-target-reg-bits.h         | 21 -------------------
>   tcg/mips64/tcg-target-reg-bits.h              | 16 --------------
>   tcg/riscv64/tcg-target-reg-bits.h             | 19 -----------------
>   tcg/s390x/tcg-target-reg-bits.h               | 17 ---------------
>   tcg/sparc64/tcg-target-reg-bits.h             | 12 -----------
>   tcg/tci/tcg-target-reg-bits.h                 | 18 ----------------
>   tcg/x86_64/tcg-target-reg-bits.h              | 16 --------------
>   11 files changed, 6 insertions(+), 137 deletions(-)
>   rename tcg/ppc64/tcg-target-reg-bits.h => include/tcg/target-reg-bits.h (71%)
>   delete mode 100644 tcg/aarch64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/mips64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/riscv64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/s390x/tcg-target-reg-bits.h
>   delete mode 100644 tcg/sparc64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/tci/tcg-target-reg-bits.h
>   delete mode 100644 tcg/x86_64/tcg-target-reg-bits.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

