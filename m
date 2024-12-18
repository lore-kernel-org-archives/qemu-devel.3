Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE55E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 03:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNkcS-0001AS-NE; Tue, 17 Dec 2024 22:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNkcQ-0001AA-MU
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 22:21:02 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNkcK-0005xf-JG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 22:21:02 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71e2a32297dso195568a34.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 19:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734492054; x=1735096854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l9Gs5939KdWOiyzBIhFayRd6sPveSpvp6F/s/j87HVw=;
 b=v8hHp1mJhnqlgoc1WGwdb91jmXVdFY/s917jjcuBuVUddI/FB64mUM7VAK2bXZzksU
 hOxnM1sPFzXnC5nxbXmw5QPzejgL8XgGSp+N54KUM9Tdi6+HaNxLdGyhpa6RKQ/Uwg63
 clWDQdyN3yGcE9TLltSsKlk4lzwyN3w/KCB7ZJkLtTQbXXjmcYJ41tVlflZjIp/r+iiS
 iotdqJjda+GVpu8pEBE0k1xA++0Mk1PVZwo+l87Zr1MuoAlGTajEMJVqYFOMoy+8TB3N
 F+lC4AmgYZhUYYdH9l0takzWAyAp48q2JbTwNrm7dFoatHPj/cCiNjFw4Pkgv4vcJMw9
 pSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734492054; x=1735096854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l9Gs5939KdWOiyzBIhFayRd6sPveSpvp6F/s/j87HVw=;
 b=hEWeoMiLtIxGVLMVi9VAbCrlFAdAUChsPM4LsJFYnmIRHx51S4kBK7a3bv7EwbrFOk
 XyM7Xn8E/wmxB1G/MnQK+59/7WOUgWQDlkcH0RY13SfqHLouQEfRKP3ngzOJxwbOcHcV
 Qc5gckdS+2kCwvweEDjYyP6W0hU5y729EyNAvWx0aCctoxCcub2vtfRYiEdcxTacoDK4
 z+Ir0wCJINd3TheYFHhYiOp6O+fjtegyYv0oNQ8v9AmDZSRXx1CzuJizunbQKWc0i5ZQ
 ZUKkowVbTk9Gky+wloIyqPYMA98PCvx2ME+liF4F0YWEFNvaBaNZMitcraazCKGUu07t
 scwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjamVikT5FhMsDYfPRrsCJYzZDbS0krJPLTmJFknOHRZt6AqCA2PGmL4plGp4rhP0pvrFw4fM+cT4E@nongnu.org
X-Gm-Message-State: AOJu0YwLwvVVq1sQfakSqhyHb6eofFcxa3vReJFHdabpqIq4WnMlkezZ
 q6+dllQAKdAimxf/Mb/R6dNaaq4VadxPfGhmYD2CIdWnK/ZwTxnG0LRUOZuAPP4=
X-Gm-Gg: ASbGnct2uCcAAVJTkIUq3ZfJdUTIuP0QbtsYod+xADhMflyH7v7swLaaTc4UWj7kqzR
 X4TNNlK0fRN+9Q/5K0uaVHPY1CMWOK299p3SKjFcbVPGucZmq8WpIyr7Ncena93t9J8HUcIpLBl
 AVB87JblIRA2qoW5H5tasb101LSjqhVaj0pPTkLDekYzb7WOb7twmyOAYur6EJEWIW9n431C/5j
 HkOQQr60ylFLcp0wS5JW3Dr5yfl1ADTr5RP4yx++p7JqPyfhUvl5iyNs4cHCCR6xJsgVeODtA==
X-Google-Smtp-Source: AGHT+IGt7nikiLN90I0zGq9IrGZ9BePyGB6Z4WryltmqF0wZYmIFkxHKIeEz5lesmBJ0Y5r9JlPx8A==
X-Received: by 2002:a05:6830:7003:b0:70f:7375:e2b5 with SMTP id
 46e09a7af769-71fb7a58b28mr593619a34.6.1734492053901; 
 Tue, 17 Dec 2024 19:20:53 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e484a9edcsm2463868a34.48.2024.12.17.19.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 19:20:53 -0800 (PST)
Message-ID: <1b14277a-987e-4f69-b8a1-5a6891ff6fd6@linaro.org>
Date: Tue, 17 Dec 2024 21:20:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/46] tcg/optimize: Add fold_masks_zsa, fold_masks_zs,
 fold_masks_z
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-4-richard.henderson@linaro.org>
 <f64769f6-ce7e-4502-9ce9-19bb57306752@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f64769f6-ce7e-4502-9ce9-19bb57306752@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/17/24 14:03, Pierrick Bouvier wrote:
>> +__attribute__((unused))
>> +static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
>> +                          uint64_t z_mask, uint64_t s_mask)
>> +{
>> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, -1);
>> +}
>> +
>> +__attribute__((unused))
>> +static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
>> +{
>> +    return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
>> +}
>> +
>> +static bool fold_masks(OptContext *ctx, TCGOp *op)
>> +{
>> +    return fold_masks_zsa(ctx, op, ctx->z_mask, ctx->s_mask, ctx->a_mask);
>> +}
>> +
>>   /*
>>    * Convert @op to NOT, if NOT is supported by the host.
>>    * Return true f the conversion is successful, which will still
> 
> I see the direction, but why not simply use a structure for this?
> 
> If I understand correctly, we'll only pass the masks to callees, so it's easy to pass the 
> pointer down (without any heap allocation needed), and we can have associated builder 
> functions to create the struct only with a limited set of masks, or directly from an 
> existing "ctx".

Why would we want to use a structure?  I'm confused by the question.


r~

