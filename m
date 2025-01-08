Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDB7E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeZy-0006wX-PT; Wed, 08 Jan 2025 17:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVeZx-0006wA-C0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:31:09 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVeZs-0006iR-Sl
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:31:09 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163bd70069so4172885ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736375463; x=1736980263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYUFSLv3GwUO7MiseREWUI3dupxKvsjIOGMdPgCEudU=;
 b=smVp9AsJgZx+Oii85c0zIeITgQV6eFjijbqWlV05HXmgqLQ++A5ELS6wnxxZSSpj+J
 aLtPXAi1/92VtwslVzhSdza/paL7iTdz/o5uz5I0PkR0RCjRiOhgEJwxjzcIfSVRx8Ds
 N0X4xY0QOK3YQxDI32aKpM+c689o+tBbQrKvQZncD8AJD+sbV8Y7nmH45qOemjOXpBcG
 axPkz3fplwzO3gM+ETYinhmena7ipQiIelEs9G1RPzQeN3t65LdlhQbgyVbHCNBBSZLV
 /uJtcukWRJkVDWJAw4fvnpCd9fK10e5oGfDdp/U9u3367bzVpcLT4cZN5mA8vditAbOb
 OWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736375463; x=1736980263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OYUFSLv3GwUO7MiseREWUI3dupxKvsjIOGMdPgCEudU=;
 b=Tuh6zctGdmwgDiJW8ThKBmLwnFqS615f6a3FkN3nZNHkFt8BqNaJDQHJ3fgFCXLMIe
 ofHPf1D6med2smx5dlEirKcmnjM7spaU+dnF8dYnH3UB68eqIyDpeZ6NMP+GNEF7m8ef
 iCIGI++KtQiThRJP1iyGvk3taESOJph/KCzYY588I/QePAJgUEEt8v6AZDSTvoEm78Gb
 zK3u8pRl+HA4F4o70zBC3YN7giri9IX1SEiJsqjCtH57Jj51fmTRrSU2z/od0ncl45A+
 3YpB1+2MfHk3h749HKUNSvpu+3stMej7PVrD2QjFnCs+jsKLaSv+uPgidbuJyHMIoJXn
 Awdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZgrP6PPX45nYBSqTrHHkPesqgIt0/XV2RJx1/HqFC6epLr3xlQUeymbOaaQbFDcFIYtpK0PyMCnND@nongnu.org
X-Gm-Message-State: AOJu0Yw3pBvsHldEMSDiJGR/A/cL5IYAvDgfh2BYECc21Ox8q2yPk7r7
 Zh3e5VK6O1erC+crCUKt+8QjxN4WZwV5XfuIRZhAlobpc1bqdmENPJvZncgEFmY=
X-Gm-Gg: ASbGncuhPFo+Fvln+U9ghzx7dIiVS1DNT7jtlKShFkObpM3oddVPUqiBgI/+tAgdF/v
 2RqUEyIYvjGxwTHHon/hPxUtUZi6TIHZ939X2Ocr3gb6bWDDiBmNlV1W8I4qF/HISfnrpBrjtS9
 4OBfK96SZoJAKLH+7/a99w+NjRG+8EYdsk/zgzpcsjWeakwtOkwzMYlKM1AE5KgCH9bWwyXlF+O
 8/6Tke21cBLvCcIoELZHFlexMuZg4qn+t272bMK47OpwVbeVo++OjyNz6EdSv6RezuHY1JmAXMx
 Bs6S+PU312qTO91cFxTGt8sVSZTgXes=
X-Google-Smtp-Source: AGHT+IGfh2D9EYCWZksz2iTrGpkwD+eHEDu/wxzcgD3jfLfAS2PUgU6jzYp85TL4JWuEKB/br7m/sA==
X-Received: by 2002:a05:6a21:1087:b0:1e1:b727:181a with SMTP id
 adf61e73a8af0-1e88cfd3cb1mr7796227637.24.1736375462670; 
 Wed, 08 Jan 2025 14:31:02 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90b302sm35783560b3a.175.2025.01.08.14.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:31:02 -0800 (PST)
Message-ID: <05806359-d54c-486a-bf40-6efe79253283@linaro.org>
Date: Wed, 8 Jan 2025 14:30:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/81] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-8-richard.henderson@linaro.org>
 <eed31d9e-7c0f-4a96-9442-48bb2c56337f@linaro.org>
 <393fb699-a360-416e-b1d1-df9372685c16@linaro.org>
 <2353d8be-843a-4054-86e8-a961aab62769@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2353d8be-843a-4054-86e8-a961aab62769@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/8/25 14:14, Philippe Mathieu-Daudé wrote:
>>>>   static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
>>>>                             TCGv_vec m, TCGv_vec k)
>>>>   {
>>>> -    if (TCG_TARGET_HAS_bitsel_vec) {
>>>> -        tcg_gen_not_vec(vece, n, n);
>>>> -        tcg_gen_bitsel_vec(vece, d, k, n, m);
>>>> -    } else {
>>>
>>> Why aren't we doing the NOT n operation here?
>>>
>>>> -        tcg_gen_andc_vec(vece, n, k, n);
>>>> -        tcg_gen_andc_vec(vece, m, m, k);
>>>> -        tcg_gen_or_vec(vece, d, n, m);
>>>> -    }
>>>> +    tcg_gen_not_vec(vece, n, n);
>>>> +    tcg_gen_bitsel_vec(vece, d, k, n, m);
>>
>> Pardon?  It's right there, unindented.
> 
> Sorry I'm not clear. Previous to your change, in the
> TCG_TARGET_HAS_bitsel_vec side we use the NOT opcode,
> but not in the other side where we expand, why?

Are you asking about the code being removed?

Recall that bitsel = (n & k) | (m & ~k).

Passing n = ~n' we get (~n & k) | (m & ~k),
                      = (k & ~n) | (m & ~k).

which is the two andc + or operations above.


r~

