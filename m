Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FABC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbvU-0001Y7-6m; Sun, 04 May 2025 12:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBbvS-0001XT-Ib
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:10:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBbvQ-0005jY-KK
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:10:46 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso3609059b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375042; x=1746979842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+FZX6BzeDziVYSdULWMnyjCncL0tE+7MUysxymXwBwQ=;
 b=eSwP3l3JR0B+vLfr9GTxbpi04KafCR34jVz2c0QfQNUaJ4k/gYnZEM8N67BZ+R1Y8j
 XH3Abu1LTOE9ewzR1w+i1BB/9u11g4YEYws6eIXf9Ow+tddCUxdEfqP+iM2ucVPSafWx
 rrvrAucwfChA7esuD6gRFD/IBFE+peE1m6m3a++PFAU3iQwkz+q2PQ2bddE7DRyELEE2
 u+KXHFjZvofYivEWDQY42igbWh0aCWDlbp1E5D/+3qIvKZYgULh0RDImBENHfX4648sM
 wp3lY6eZn9Jva1yAwoDUpTrWHllKRzecnAJwOQp4U+09VddVmS6BVt8AqlK+CyLN7CwV
 eYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375042; x=1746979842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+FZX6BzeDziVYSdULWMnyjCncL0tE+7MUysxymXwBwQ=;
 b=sYKT9hIdt+sf6dpS9pnhYb4kxoT4Ut5mkTN05zNFLLu3oW6UWilEdnMyfNOIm14kjA
 qRCah0zFUBMGxKOgF4ApuZntAVWuJ84fPiq6tDNJJkQWnkxkC9tM380kOssw/9veSFvv
 N0U79uAZit2UxaR6faPT76pZeZBNmosgmk8SYa3P4fMH/J5w38D+itbZhvyOfWwTPgh2
 Y52r4I/1zM5AQXzoZrJLfpHpg40MncBNz9vBCdsa5qr3ecBvple67qTRn3LQszUKImyf
 VeAT0ddEhtP48ktm1X8LwlG8KWqUo7Wb4KzvCI+s/8aKI5VVL473qrX2RG1r/b4FVsPg
 Hf1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVTCxJ9Y/bL1Psnu+L170GLD5wuq9S8GuQnXtn5cTSWodY/RggPLFYW3xA6WIqJGOAjb/uGAFhKElW@nongnu.org
X-Gm-Message-State: AOJu0YwGULpMKucbSKmV1X5lNTZsSg5yA1Ujr9Y7r8o5PaTA217lBn7Z
 hY2+ksTj2Bq4312rzufz3WxHzx9rZ8D9aG8xqEUkWFB7uwRbHIyzfEQcNoAzG7E=
X-Gm-Gg: ASbGncs19+ThDvSSwqnZAWunb+TfGHbVnB+ck42g0i8QiGf+e+Hoh42Sn3R9Ds/8iSj
 a1+xb/96dSDHYf/P2MCSnf0HkFFCYS05l6DBJx+f0XuaOVrxQXZYSlWf5rRM0oRUNLnXFWdQ0yh
 Gs6r6nA4uuhWWnDlSAtgqSm59muXbVzSokxpyHvwsm24nQOokmoRNNlUfA0fPmDb5hDR34gNxtG
 mlj/iNsKM9JzVPPCgR/QYCEGin/z0N2GzURVc71M5HBnJYwgu+00x7sEK3vVq3+MlwqY0pebcEL
 W6swJkI29VnG8ChvddvaZKVqsge9r1Z9DzehuhLXP/JSEuDP8wa8tI0TM4DGlN6uxYE1oVAeYEd
 dsFHIUa4=
X-Google-Smtp-Source: AGHT+IF4DmVjYxU5OMHreWY3DuhJ0ArIP4/yXiQNLAIHsXqebkehUJ5U+ALGFOWSzRbbxKy+kOzWxQ==
X-Received: by 2002:a05:6a00:331b:b0:736:5f75:4a44 with SMTP id
 d2e1a72fcca58-7406f1a38ffmr5483346b3a.22.1746375042534; 
 Sun, 04 May 2025 09:10:42 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590a463fsm5223665b3a.173.2025.05.04.09.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:10:42 -0700 (PDT)
Message-ID: <ceab3632-61d3-4c34-a381-7c460d91dee4@linaro.org>
Date: Sun, 4 May 2025 09:10:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/40] tcg: add vaddr type for helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-15-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/3/25 22:28, Pierrick Bouvier wrote:
> diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
> index bce5db06ef3..b15256ce14d 100644
> --- a/include/exec/helper-head.h.inc
> +++ b/include/exec/helper-head.h.inc
> @@ -21,6 +21,7 @@
>   #define dh_alias_f32 i32
>   #define dh_alias_f64 i64
>   #define dh_alias_ptr ptr
> +#define dh_alias_vaddr vaddr

Use __SIZEOF_POINTER__ to make vaddr alias to i32 or i64.

> +TCGv_vaddr tcg_constant_vaddr(vaddr val)
> +{
> +    TCGType type = __SIZEOF_POINTER__ == 8 ? TCG_TYPE_I64 : TCG_TYPE_I32;
> +    return temp_tcgv_vaddr(tcg_constant_internal(type, val));
> +}

TCG_TYPE_PTR will work here.


r~

