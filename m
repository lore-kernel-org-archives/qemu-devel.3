Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91189C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7W54-00055X-CD; Wed, 23 Apr 2025 05:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7W52-00054z-5g
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:07:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7W50-0004k2-By
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:07:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so45508075e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745399258; x=1746004058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LAyNtd5DexVM7p6anwg6URInbY87ocKpc520Xkvx/7w=;
 b=SWZ+jtuQ27bWiVIlXyDNGubsO4namx7Wam6jgEb5HkCJuz4N2rfgn0msxKOsU/K4pc
 9TcJPBs81MxYjcrX8hJMaJdQQZJ0nKcgGkUY+3P1YEdacHbolO02GPN14C62oVYwBYYe
 kaJZOVqzl8pxYMpc0kwZ8DVRHyA/lbmhDQZPaN0+t+cRl3j/pwZfV4K35Gbxu3Mna3ni
 u2++i3oKNllQxVerkYb/AejdYwlMZFLH+kfCN4MsvGgKFAKpEn5ySuXrpMWObpClINtJ
 TVL5XZ82kgVSi3g3KOPSrP4xohNYruheRFz4nULc+w0HUgo330kOsEZYLYh4rn43PdhP
 uP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745399258; x=1746004058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LAyNtd5DexVM7p6anwg6URInbY87ocKpc520Xkvx/7w=;
 b=aS/oyZvGWjb/AMQ2wJLpLuvs8c3+6tY67vhH6Md0rZOual64A0EH67ObO6MPa+sflA
 He2kuq0QPvLInEBcxSCld3ydsCRadNuzzL4AcoyACWXgsRbBf26zjOoNyyZmp5aj/cAi
 gvu7kX+w9jtr6GLjor26UXG1XJUz2HpfraCX78RrvBdECTSFKXWheOtslH+nC8Yu9qkT
 Kixzd/SjsWOOt9OoGz7lUUyjtU/kg/TeY4HlhEEwYbma86LSse7HgBiDCvEsv85fXB4R
 vPQl3NliBGs0Iad8tfMwO2UtNmQgMvYheBBXvnjlgmBEcWeUor+AP1Zh+EmcRVqet4iY
 zN0Q==
X-Gm-Message-State: AOJu0Yw9FfcRtI9q1B0GV1MFqGt1RvRZ4OQXv7H90jqqBUJtgANZHtAo
 pl384tpDzjNkkN0Y/r0Lk2+bxiNodj3SPgO5FHvQt9+WHNVUmvC73e0OTcSsVcoKDmqEs9NUW4f
 4
X-Gm-Gg: ASbGncvGOblbGw/7p0q0wi95a3qBLcWOOdGP4RuoHiiVAXTCGvSu8xuDlikanp0sD7W
 UoiY6aD6MjpGawKJXRj4wabO+B3L6F1RuFBBCnSomQ2Uqd/CHI01hcbUmnLKJEMRwpw4ZFifOx6
 hlFUluGaD4gLvdtigpn08+WpJgX8lGoLVt3EPnUR5NFE1XcLFTgeRga0XxDJqY+/80AnIHmApfx
 rekHRg1jBQmughAnKVTpAT6vnxadnB53HHoII4eeDvuheLfxgQrJznRtifSwBiqE0w+rWhkyqWj
 FiUzZITxzd9AG37izQuPwRFMQ9DLcqpP7KN7iOuwM3UdgL6pilQCSJoGkZN4mMMltQ6epdK/IMv
 YvXE08KGX3+lVsgwVIG0=
X-Google-Smtp-Source: AGHT+IFWRJ3ZJz6hKLXQrevHKUjKOwRB//xXw1G6xUaZ1Tuf9mNe1qCwsRe8BumkAX0+jK6hjmXdOw==
X-Received: by 2002:a05:600c:a143:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-4408a6565e9mr51649995e9.16.1745399258206; 
 Wed, 23 Apr 2025 02:07:38 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d46afcsm18265965e9.39.2025.04.23.02.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:07:37 -0700 (PDT)
Message-ID: <b31a44d3-b921-4335-9598-7565fb39f1a2@linaro.org>
Date: Wed, 23 Apr 2025 11:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] target/loongarch: Define function
 loongarch_get_addr_from_tlb() non-static
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250423080417.3739809-1-maobibo@loongson.cn>
 <20250423080417.3739809-7-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250423080417.3739809-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/4/25 10:04, Bibo Mao wrote:
> Define function loongarch_get_addr_from_tlb() non-static, and add its
> definition in header file tcg/tcg_loongarch.h
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c        | 10 ++--------
>   target/loongarch/tcg/tcg_loongarch.h |  5 +++++
>   2 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


