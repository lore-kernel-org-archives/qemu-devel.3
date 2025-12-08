Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A538D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXxd-0003I2-RG; Mon, 08 Dec 2025 04:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXxM-0003BT-1l
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:55:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXxK-0000d1-Jr
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:54:59 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b32ff5d10so3328568f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765187696; x=1765792496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7nAtAMMEIDhIgbDWaPThCvJR2As0TOYP1/Kws9lzYHw=;
 b=F5426XXTMDTuvszosdIVP+6yeRLnF+HPbytgZrz5XtGOfYqgHsLcfxo69bY5lGQKrz
 mVHTdYGdQFL2OVO2pZ/k7GW0rlOafZKlCd2G60Un2nn/KjpGt7OtZyu+vgXW3jBhz2TW
 XSthFMslmujcNl8pJbRa/SvH5K1zYw+bBnJ2NxCyjSNX8/7OI3bKlZXhH8/S11xW4gI8
 nq/MpFkoyFqPl7Dtvwob3I2mxhcwgOVuzYMyHj+mWKAb5g9nuuVLOcOOFNAUGc7gyLeL
 l8/OW4Ysx8jcIlfZtPaGwtiKvkYYjysNYeKPq5smYhruFgFhi7YekVohdJNoQdte55JU
 k2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765187696; x=1765792496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nAtAMMEIDhIgbDWaPThCvJR2As0TOYP1/Kws9lzYHw=;
 b=YMNsjgXftaQrqLnCytaSWGOeUvnrGUULC4/9AFoEPlIGDOuk4mPGfy4e4rtpnjOUj7
 Z8Rfhz/GFiEdkkx1Lhu7kpmpzAQsyeLgjkafWtnnG06TS1Gfl9p4s4KeHr0s2b41IDXM
 MO2szGcOtiQ0MjvwlsN7+1vWGxRC85SqIw9Ij339ymj7+avr2pWvpaJTiEkeII3RwTaQ
 AnzukCAeFSZRsT54I9WPszaCpggjQc4BmyXJqBHYb/CoUU5hxvm3tB09YHNSCBa23vuv
 5YIGHNAp7bAxxekdvNLSYoBq/tYxS207wqIxcEluu1gv5qTWa8HE37+MDY8qTRYJFgNY
 Yu/Q==
X-Gm-Message-State: AOJu0YxOr67az0KJqQE+WpD0RxmflfL8Fqyg02eorxkMv+bwezJOxi4m
 AeEkQUVHUAx1iawHSvsOWNBY/WNhNSUC4HP6AU0xtVQ8+Yg6w9JsAcYPihLb4Z1jQAkpVkaNh0B
 22TCmQGs=
X-Gm-Gg: ASbGncuU1ZtLzw5r/IM7OIqZx6FG0egfii/IPKbySIfnis/lRkif7tPRmHsyzVmLmsj
 Bog/gR7ZnJhLkvyDP7zdjb+uY+1kAZc7l+BT33s+NkraiohNTV0/4nrfKrN/pP/qH8IPIsciySq
 +EmJvGi8huo6M89inLlrxQOIUwF8teSZGt+u+BCj632dBUBUGELGtFgsE5p54t+jVFAk+7btr5v
 ZcqF9vP4r0n379GeKZxDt9oMifBjeW10AWTplBkqXLt6vqWcRxHYNKY02yoJdJIwYYs9QzjEF9Q
 1HmKMhcIdtqkBm1rYe63E5SFuzGUX7GtJ1RAorRW2VEREaHbzth86idVTf09vlqhglZheVMITfp
 j96gh1MioDBzSShW1cDhuVvdng9OvjFnKiySfQPhNKB2+aAUrv3lDytcXqq+Tay82tY92mBNqzP
 MwgD3Q7pEe2nV6z7+EjxNTQv+ekviZM6H08ykuJR3ONeh2mt09+H0te/A5rrkJPKZ+
X-Google-Smtp-Source: AGHT+IGhV5/2Dw99cQBq3PsRZ+sh7ibCOeyGD8v7UuyEIW2hh0rFRE7lDdkAcVwlx69luw0a5nraLg==
X-Received: by 2002:a05:6000:40dc:b0:429:a89d:ecef with SMTP id
 ffacd0b85a97d-42f78875bbamr17528330f8f.13.1765187696190; 
 Mon, 08 Dec 2025 01:54:56 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm23824547f8f.3.2025.12.08.01.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 01:54:55 -0800 (PST)
Message-ID: <11aafc7a-a837-4d87-962f-fa3bc5b2f3aa@linaro.org>
Date: Mon, 8 Dec 2025 10:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v2 1/2] tcg/loongarch64: Factor tcg_out_cmp_vec()
 out of tcg_out_vec_op()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Bingwu Zhang <xtexchooser@duck.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 WANG Xuerui <git@xen0n.name>
References: <20251208095354.25898-1-philmd@linaro.org>
 <20251208095354.25898-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251208095354.25898-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 8/12/25 10:53, Philippe Mathieu-Daudé wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> Lift the cmp_vec handling to own function to make it easier
> for readers.
> 
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> Message-ID: <20251207055626.3685415-1-i.qemu@xen0n.name>
> [PMD: Split of bigger patch, part 1/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 94 +++++++++++++++++---------------
>   1 file changed, 50 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


