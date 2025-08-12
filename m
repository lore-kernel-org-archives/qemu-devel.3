Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA93CA0EDA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliOw-0006h8-H3; Tue, 12 Aug 2025 02:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliOt-0006fd-Qs
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:22:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliOq-0006Pv-HZ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:22:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b91325d79fso91503f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979730; x=1755584530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U80tQRzzMeHvXCfuLUWdnMALn05gCIwvOWs1XXm+OfQ=;
 b=Kxm/I3pY5dlOhtQHQQjKqDpo5erDfeA7X84FPtrUD54QijOTN19H3hm1+vybW9/XOV
 e60XuQzi/JEumiYzNWLPp4tLLbb97SBk335DkU34bOEyCu+890xSH1EVT5FI/F2TKkgA
 okvP1Lx64b9a1wmXJBs7MuUpAEp8kLmc07I0nX5aR7Y7Jmh/Na6Q668XHU+Obi5TDSK+
 Ry4wOm6dC53oemHkGvDsSyYRyjM2a022A8H2ywsDONXOdZr8I6eb/YU+/70wORovSmH/
 EyNaBj7tPVdEdKizCSikjwa/uBKQMEQlfHGH8csx/rHJOFLlQ/sMBq+MWqfALkz48Hou
 Z4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979730; x=1755584530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U80tQRzzMeHvXCfuLUWdnMALn05gCIwvOWs1XXm+OfQ=;
 b=RvesF8SwuGbLn5jDmJcYdrcLuVr7CCcNPX0RxSWwxO3ce5OuZoyED8ht0gh26ZuFmx
 8L8MSzho1tncM4/qkzz/tjqrBu2GrZwqzveDQzFqTDzrloIu3vckscBjyYq/Yr9dcKkV
 BOmSpqNC4/erG92g2iEhA5kmkthqg2/rEHrYH8NaQi7us6XE2rFfI+zMJzXgxBGAjkTq
 m33AXKkP4Kah11oX3N3xdLO7t392FCCGdbuQ0Y+ZtEwcbB2VCDMFCT0ENHnOuONerCLI
 FcKyd2iRt6QXvCeRNmOVU2SSnK2HMDnMw7qrnG628CnDOKFjmr7Z4XYJNuX3LYwbm3Ur
 rxWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUYOkCuAl/j/KgukRHdRZIJkdDhHb56KGWCXfQ1TXoBx4GmmYnIb0VYAKQr2Bjc0npISKLryoEe7lb@nongnu.org
X-Gm-Message-State: AOJu0YyCGszo2ImKVnj2OS9hhJfLse7244+rMqQEslOX65AKdA6DbtTt
 QCAmyZWo/oqPMBjwS9bxLI/5TNXJO4mrdqOhIhTJhMLG1UVuI/eoP2PwfOCuffj5xmI=
X-Gm-Gg: ASbGnctZrpITJaq4iwy/V6vUwxfQxc79nrM5GiYmjI8BI/7uiGz1qUqOva5hnZmy9Du
 J4gRRAZF0q/0JS8Y6FoZQsJC+r+NNNcDfe35UFWEN7noR0DZdnQbZag9uUkDv2OjyhgKCLMZoEk
 3G5B5Mh3VS0oDIb86oLf++W50eYJ2UyhH/PjymU9KM6MrIkVw/3dZThIBYQFPlvxzCwo4kR2BdK
 zPO1ImXzcT49YpmOAU166KVwBEqyckJRFMNE5LHwcdA+DwtKNQR7aJqZi6YhGeERbQ1Ir664mb9
 l3UyqQISj5+mleG0IzdgEZi7L0wCkeKBCLrHyWW+XMv5rCxNnvMFYbv2MpkgPoBulPE2RE6IT+A
 4It4rz8T+Ll+QnGnl+cyy0cT41PVhKaFvUhI81QyrnBmUEfTmmHHAWh4gIMG4kNJtXQ==
X-Google-Smtp-Source: AGHT+IH6hLGjvsAG4FhK4+mOSSANR8QXFfyV1EpIiM9jnIEytMRw98n4UbeZT0UrG9JymIPi8Foegg==
X-Received: by 2002:a05:6000:1a8f:b0:3b7:8851:659 with SMTP id
 ffacd0b85a97d-3b910fd9b66mr1622627f8f.19.1754979730489; 
 Mon, 11 Aug 2025 23:22:10 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac574sm42988810f8f.5.2025.08.11.23.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:22:09 -0700 (PDT)
Message-ID: <a56148d4-0076-47a3-86cf-90e870c101eb@linaro.org>
Date: Tue, 12 Aug 2025 08:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/85] include/hw/core/cpu: Introduce MMUIdxMap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-27-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-27-richard.henderson@linaro.org>
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

On 3/8/25 01:28, Richard Henderson wrote:
> Use a typedef instead of uint16_t directly when
> describing sets of mmu indexes.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cputlb.h | 32 ++++++++++++++++----------------
>   include/hw/core/cpu.h |  6 +++---
>   accel/tcg/cputlb.c    | 30 +++++++++++++++---------------
>   3 files changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


