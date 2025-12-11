Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7F2D41D61
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjAA-0000RM-S4; Thu, 11 Dec 2025 11:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj9d-0000Em-35
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:04:33 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj9Z-000593-PG
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:04:31 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso227994a34.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765469068; x=1766073868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BmitcQb1V5rb54cGQXvsCZVm1Y1YGXc8fFkzyOmKBUI=;
 b=iNOeD4aSE30c7AaCfyGZ+QOrb7ldpagnC9XYfaSrp4ZwVYytjjYuEQwrJvITfCOSIF
 cNeV9fUvqx5wrKdFbqGixBy6e5usoBJrIwWp8WkDBL6dO/9oxmDFO6i6q5go7s85Nb+o
 pBra4u71OgU2uj8BXFnZkZdb8gvlGQ4Nmb6ajGTzSq2I5wA74ki8B/1HB2TP3WV0Ag92
 Uue8g4rrF7mwlP9v/NK9tPBWrvoC685r01SWrUqKGjc8WtUMk86CkaM6BQ+D/cVK+wo2
 kRDvr16Tip0bC7JjWBEHOPSvu/3sHGx1LoF7GTLxelDE/o/lomRd1eudGceLiLtON3SN
 FdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765469068; x=1766073868;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmitcQb1V5rb54cGQXvsCZVm1Y1YGXc8fFkzyOmKBUI=;
 b=eLbfOm2/xSZ1C75ayj+I3JDmVm9ly8+LhiECqK6ualxIWrB5GAtIeYEgQF+RgeQ6Td
 dI7RnXbQSgdVpYg1sKyFxtSZrpsCRjurm75DZI+PT703TvB3PSsfaIItYsU9WhLWszIh
 Nerqx5SBam8rI8YE6T5C6kz7Z5g6wLZK4JEqoJw+1dXRBOxFirYxj4OJ/GZsh/4BT8SO
 uWpri+K/bKzR1ZYG5rDVuO9uCIB03s8QS8HixcZ1aLYl0ac51vIOep5+6jaMx2wePiHZ
 djKfXRwnMniaspjN55chwKrQyZ+GNine5RJA50GLc76TpjXhDmDV/AGITg4d8mGni6tJ
 A7Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/UX+hFGdsR6zVR+fS/voegXjDvZoBhbyTUNWcYfqx4/wFk5sgryw5wK68aS5mmQZWQCcxyNvPz67A@nongnu.org
X-Gm-Message-State: AOJu0YzU3WlHXznW0t5I9FR+NAapKcS3HRyeGNO5LGfmXzEifsyGiL0l
 A0az790JOkeCeKcGhDY13XP7Q0xv1tS1l6MP7/7yCE7jHGBoRDmF3gwf8BxnuD/ad0bfDtwmhvg
 W37nK/fQ=
X-Gm-Gg: AY/fxX4v60gopsxqofxGClE0H3Bb7+d9tbQM12ClJUBx0cDAy41PtQGwu2tLjJRsXoV
 T8D6llg3hU60Lek8H8JOzDSfP1JwCeznOHPYcC+ORWshpx+k13KVvQikYpvk0zxTz3al1nEp8DB
 GfB/OEEhUnn5Wnz94TqLp9slcU4eSx5ejIYqV8ga3kPgkyoxG8y913XiOxACyIyZLiKiYXEjX5h
 MACxzBq0vpQTGtJkKwDgMW71tnnLBLazbKTEiV3GF173Wb9CIXKZ3GMQLDaBvhdLRWthMg6zsSM
 eKlHOjeF2bdaLRx03JG3FW+SVc4MdUvHqyWNsRpQUQar8Hjgxcxb8riX32AieQTmAQYHMhu6Cu4
 zl5ECCYX3fsoMRmBZTITYKeZE1Ra5p0EVXYtrVazYdR0gu3kS54sXxrjIjFVhu4TkjVEcj1FTmb
 +KmsCPsCExn7hBdXSSchbtQkYUDhJIf9LoteKSkLbA0IBqLQ4W9aBot0Z1n8Rn79akc7YsACu4A
 hI=
X-Google-Smtp-Source: AGHT+IHYrljbkga2vbK7oZg4d2RzhMxPxaEfwmVI6uK3q7CiVCqxKN14CjjlqfnoglSXb5gBGF7blA==
X-Received: by 2002:a05:6830:43a1:b0:7c7:6626:b599 with SMTP id
 46e09a7af769-7cadcdff87fmr1408056a34.1.1765469066807; 
 Thu, 11 Dec 2025 08:04:26 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb2fc086sm1650858a34.18.2025.12.11.08.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:04:26 -0800 (PST)
Message-ID: <58e15332-6eed-474b-b440-bc8cf4bf79d9@linaro.org>
Date: Thu, 11 Dec 2025 10:04:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] target/i386/tcg: move and expand misplaced comment
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-8-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> @@ -2222,6 +2217,10 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
>   {
>       X86OpEntry *e = &decode->e;
>   
> +    /*
> +     * Each step decodes part of the opcode and place the last not-fully-decoded

places

> +     * byte in decode->b.  If the modrm byte is read, it is placed in s->modrm.
> +     */
>       decode_func(s, env, e, &decode->b);
>       while (e->is_decode) {
>           e->is_decode = false;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

