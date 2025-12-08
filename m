Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046E7D3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXzT-0005MO-1w; Mon, 08 Dec 2025 04:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXzH-0005Kl-Pn
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:56:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXzG-0000si-1w
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:56:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so55281435e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765187816; x=1765792616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q2ctYmhu88A9IZSkd1eRMRC56g9h6HnFCh66D5M/ICY=;
 b=s9LsGkLYqreOX7BZhqDJ8lmZhQWXn3rKgoXG1pLHccdYj6k6BETkykCOm6XN3Jx37Z
 72rfLUuOOsU8T/ylpfCUdrxLvNqrWgV44uqrnNl/gwhyMf/b0cLWreZjyKPN2p0TM2Sl
 tFGJoZQCvZXBNWAp0gqDU23hsT6MzqYdJRj26jnMgb2hb4HQW0sJtx3UnPDWAFY61mJF
 G6r/84x3jZzlIO6cpn9RC1CTg+B/B6kKoA5CCPYDtvN7b5UMtxZtX8Zro+IXvRbQ9nkM
 b5/4E9o6l3KpQaMItKbGCgXeccnGl2IJF5N0NngsqCPv8QoozBjCQDLT3X4rJhISIm+Z
 rb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765187816; x=1765792616;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q2ctYmhu88A9IZSkd1eRMRC56g9h6HnFCh66D5M/ICY=;
 b=cD/i4c2vYXjw++EWcBHC7hlkVNSHIiyQijmMAXx9UoomoNAHtag6m6TF9tU2ZRQuMA
 CE5Q4D/8hroX65IDYNv0P7hIrwVeXuneqSKVS5FIOAfpFWm2COxyW/8pMRsjfJF+9VTk
 GVuM+C2EbFtFznnM/99rdD9jL6oUBgkVWMwcjjwe1Ng12hUSC/11ATEI+qD2y0YqTQvF
 Jv2Ybqkru2sQW1gtDZ6yyz6bjYzh34Z69Ls/VY+QT9T0VCalfC7IR2cpDtrvv8Wx7B4K
 oHpNstuItTQ+RL0A2y7CI9v2qF+gLBobFNMv7oQvu/F+Gd9xL5qn+hU7b3I11TjgiTJC
 K50w==
X-Gm-Message-State: AOJu0YzqOuWr7XkJTX4A0nK2yCwFvGPWpvRBKbFHmtuONQAUJwRRFWjW
 eOcHUXBAMw0WAHj8gw+arlgIVUfyyomd4T80Go3HTHqd9Wu3ayJ2fy1cYJMvARm4rRLaFzGShit
 GeXKefhw=
X-Gm-Gg: ASbGnctEko1fXXU7oNE7EmULl6UebYkrtkTQFphy5C27mSwKtihY8e/uLVlEjBRmoTY
 uVvUZO98nkobAFueVbJGMOOzsDBsHWkz5RqygRVaeB8SyrMfjHa6SlZ3Nms8RwELPDn2D+8gmsX
 mKsUmF6LaE/D0Lrlt/6ALlgbJQviLQxM7JZxFZv3Z80lPG/ZQAdRWhG4zYubvwzVkiYtqpXAq1W
 Lea4JEar4lc83S4Ndw84Eney4Uj51hLufT6L9qyQA8QIKlBWNqD2qqSJA78ygoT0H0OVLQ2/mDY
 0eKUQXloaYKZPEPRPCZfeMj2u4Uu65OjSAknGBtEFj6349Gf9SvyxM3ZEzrGy3y7xEHkb6NN7b1
 4RvfoR22Rerj64bv0E0JoYXmLiEx1zrWNsCUfMgWqbZtw2Ub0lu504YlHPSFM3k5cf34LUrIb1z
 LK41mieGMzdhrwyUNtE+vaoLuHf6HD86C8iu64dsOZuQAqOBMRSbSE+g==
X-Google-Smtp-Source: AGHT+IFLsKBvAru5ucg3GHm8cQVg0mLIWNEkTXZFR7DXlQ/PtaqL9RpxDQI+tl9YwOOXb/MtsaDk1Q==
X-Received: by 2002:a05:600c:1c89:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-47939deca19mr80131035e9.6.1765187816014; 
 Mon, 08 Dec 2025 01:56:56 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311ed466sm228786905e9.13.2025.12.08.01.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 01:56:54 -0800 (PST)
Message-ID: <d2a657e6-6e52-494c-b43d-862b1812dbcc@linaro.org>
Date: Mon, 8 Dec 2025 10:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v2 2/2] tcg/loongarch64: Support every TCGCond
 for cmp_vec ops
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bingwu Zhang <xtexchooser@duck.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 WANG Xuerui <git@xen0n.name>
References: <20251208095354.25898-1-philmd@linaro.org>
 <20251208095354.25898-3-philmd@linaro.org>
 <669b6d4b-425f-4193-ae8c-1806060bdabb@linaro.org>
In-Reply-To: <669b6d4b-425f-4193-ae8c-1806060bdabb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 8/12/25 10:55, Philippe Mathieu-Daudé wrote:
> On 8/12/25 10:53, Philippe Mathieu-Daudé wrote:
>> From: WANG Xuerui <git@xen0n.name>
>>
>> Support for TCGCond's in loongarch64 cmp_vec codegen is not uniform: NE
>> is not supported at all and will trip over assertions, and legalization
>> (currently just operand-swapping) is not done for reg-imm comparisons.
>> Since the TCG middle-end will not legalize the comparison conditions for
>> us, we have to do it ourselves like other targets.
>>
>> Because EQ/LT/LTU/LE/LEU are natively supported, we only have to keep
>> the current operand swapping treatment for GT/GTU/GE/GEU but ensure it
>> is done for both reg-reg and reg-imm cases, and use a bitwise NOT to
>> help legalize NE.
>>
>> Fixes: d8b6fa593d2d ("tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3237
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reported-by: Bingwu Zhang <xtexchooser@duck.com>
>> Signed-off-by: WANG Xuerui <git@xen0n.name>
>> Message-ID: <20251207055626.3685415-1-i.qemu@xen0n.name>
>> [PMD: Split of bigger patch, part 2/2]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tcg/loongarch64/tcg-target.c.inc | 45 +++++++++++++++++++++++++-------
>>   1 file changed, 35 insertions(+), 10 deletions(-)
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


