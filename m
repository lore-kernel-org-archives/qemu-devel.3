Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88319C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOKZ-0004zi-Hb; Mon, 27 Jul 2026 12:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1woOKQ-0004ye-T1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:37:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1woOKP-0003G7-5y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:37:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso28007615ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785170239; x=1785775039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4jnxglhyKUgPO5jsfkPq45fM2sc8PvSKPtn+tkRTtmY=;
 b=t+gnoqjIrrO6YTkRQRsiIhdqwOPlNoXrACRwrks1hAVg2NjN8uHkmrWteGn5yBL+EB
 ZjopIeIXlKzoAzpxh7CyOx5292W1JgH7b5wzA2HAkxcaY3xkvP6FUQTw40dE3wU85oOC
 F/PMa8mKbyA+BiIWtOUaaOcPl3HY7UFqC7vIwXlQ574wv5phTKnDHdJ/x3so+V5VYupC
 ZSMZz1ecyOCj0tg2uhYLbK14Zv+j9OSKA//oPtFfQARUuo0b/fgDTqUKa5IMpZvoiXV7
 kreaRb9MgVJMoQgu7BOIzEbyNyeOgYQ9mM4CRCBwPIqdRWMBBcKdqIAtp8W95zEWJgch
 2H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785170239; x=1785775039;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4jnxglhyKUgPO5jsfkPq45fM2sc8PvSKPtn+tkRTtmY=;
 b=P94O19JF+CS5NQMoB0TgchfY6dmvjhwVdQIRnM5ytgauVMCDgvd8o/f6koa9WMnx7q
 Y/nTkgbCnMomr6a/j15lf6QJgk0CEO7QYN35EV+F00H4OtvX1RPzJ4j+ciUutnIqsAMX
 tcF142ZHHSn70+0L6xz9/onKmlBuXMvdTf4sc0FBpncNdO0MGt/zfdTRmYmTF9fHcgQe
 9YW1BG0VZBVY5SYJZm/BFs243xB3PZCisV8C0PgO9lGTKmE9Vz92KD2T6eLnAViaLT8b
 l7DYiI9u2qdNtq8qEJejfgJUaUUdoN5Iq7ujDM4twmyyjfZyenE+C1nH851qUPS4irGs
 0Xiw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9HG4gtbwYXT7twpwcmv6ZZiwwzWG/B77NEGraZU3CXEOJnumPeYUWCLGkYjnCgFrGrCv/0J21a4LL@nongnu.org
X-Gm-Message-State: AOJu0YyOk+yuKUJyA8jDuo+1umnWewZJPlwAqfTzVAAJJMlzpzXaEKM7
 Fap79rIqbecB9JVx3f2EDg0gQ5r2/fcpLiRHt9fsRsF4vyGXiIlqAlqFAWSeJL+zUSQ=
X-Gm-Gg: AR+sD10qWICSG3gpyLvjCThzME/2i4U7zeewYId2Gk+5FGvkMXpVheD/R4E/F1y+Gdo
 pJKWqEOubN6N9tLQsScJvlg5ZrEIlgt1SshwigyKN9nSA8qy3atIF7q1ugxbD0F6lXxINkhgr+p
 fO+D+OtIvA7PEby/O5CEBtQwHniYrwQa/bH/V8Wq2uCc28i5Nmj5iH0GaZXEB+GcxDfGwr89hG2
 pdVJD8fLk6qG+VwspkYEXagZOjM5YQOcQlE4i2vT8pn1lRqhsbNE9PmOdn1G47Awz96ZIdOj/a0
 If568W4JbdWuU1vqmM8tR8efK1wIjVW/wvyGMiG6sjyhHi+e2lZBUzd8J90fiyBWfR7gBjNBPyv
 xhdDbCDCEDKXO8L7+O1qJ0EhvYRydN4JNz3ksL+95lwGFUblEWLmzg3bWfxxjpXOoBE1eUQbLiE
 tRq8Z3waeK0ujfUxcpPaukPglEcnQR12fYEGFc6x2Quw==
X-Received: by 2002:a17:902:e843:b0:2ca:f44b:63be with SMTP id
 d9443c01a7336-2d00f2bdd93mr314175ad.3.1785170239236; 
 Mon, 27 Jul 2026 09:37:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde80306esm37781355ad.75.2026.07.27.09.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 09:37:18 -0700 (PDT)
Message-ID: <9d303310-ed24-42b6-8912-f218da98db76@linaro.org>
Date: Mon, 27 Jul 2026 09:37:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: do not trap on Inf inputs to bare FP
 arithmetic
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
References: <20260726005601.2513662-1-mattst88@gmail.com>
 <484d9db5-7602-4f1f-b323-0ba0e5c86219@linaro.org>
 <CAFEAcA_i+zBEBQHgrjzyTCf7WdpLaFC4eh4uJEFwkUtheBsZKA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_i+zBEBQHgrjzyTCf7WdpLaFC4eh4uJEFwkUtheBsZKA@mail.gmail.com>
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

On 7/27/26 02:20, Peter Maydell wrote:
> On Sun, 26 Jul 2026 at 19:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 7/25/26 17:56, Matt Turner wrote:
>>> helper_ieee_input is called for each operand of bare (non-/S) T-floating
>>> arithmetic instructions.  It was raising EXC_M_INV for any value with
>>> exp == 0x7ff, which covers both NaN and Infinity.
>>>
>>> This is wrong for Infinity.  Infinity is a valid arithmetic operand;
>>> operations like Inf + finite, Inf + Inf, or Inf * finite produce well-
>>> defined IEEE results with no invalid-operation exception.  Only NaN
>>> inputs and indeterminate forms (Inf - Inf, 0 * Inf) are invalid.
>>
>> No, this is modeling actual Alpha floating-point, not IEEE arithmetic.
>> Only normal finites are handled in hardware; everything else needs software assitance.
> 
> Do we emulate that software-assist in linux-user ? I couldn't see
> any code for that at a quick glance.

Well, that's complicated by the fact that there are both software assist (/s) and 
non-software assist (non-/s) instructions.

For software assist, we skip the input trap handling in linux-user:

#ifndef CONFIG_USER_ONLY
             /* In system mode, raise exceptions for denormals like real
                hardware.  In user mode, proceed as if the OS completion
                handler is handling the denormal as per spec.  */
             gen_helper_ieee_input_s(tcg_env, val);
#endif

For non-software assist, per above, there's no difference: always trap.

Some truly horrible decisions were made back in the 80's in the name of FOPS.


r~

