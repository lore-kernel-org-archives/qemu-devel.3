Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3F2E9D828
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Wxk-0002Dh-Ot; Sun, 05 Apr 2026 19:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Wxi-0002DP-VE
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:33:03 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Wxh-0004UA-0S
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:33:02 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso1264770a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775431979; x=1776036779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pyQhdJg0SPHm4TEi9biMUzRYaQaogkcfwbskQIUWamQ=;
 b=WDdvOtuXN2AECfFxrKykfZDS4aealYvn73aDNe8gsEvEl3CPszPngbuaPzO6WXLteP
 Pdz/fEf2ynkXBmO9tsyF8ffGtPJQEtbC7IqnIG2H3yBRpYUKXubMoKAsNZK0Y+uDNVT7
 48uO4w5qvyMuMRdjT/35WgxlRXmg5OEvmmHT9lJZ76TNdZcu74hQHvB1ZqLgeId8TUup
 dK0fSk5tJ2A9TrigBBn5sMyLiK7ZZuUgwkHZuNNEj7py0g8Szyz+FsTX+p/NLNWVexXJ
 1p7cWY/aIEGyYwjdQ12cVO+NpPaO9wm9N6lqENyOAjQnZdc9rlwWQ1IYI+kY/HvPBPuw
 sY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431979; x=1776036779;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pyQhdJg0SPHm4TEi9biMUzRYaQaogkcfwbskQIUWamQ=;
 b=Mp734gnJmAcRmrrit9TKXr3O2Yj4Mlc0DPitcWEw+yc3TwABjs16udSZHhBQSftazA
 XBjydzHi6KRTCt1ppgCEwfihRMbIEnVBk4D894DGu2oOA/UXMOShPu/H0WGHnRrr5RUL
 /KTDZrYAM9U6got15ahe+dhavhgnUZTav34oKqfeZD+ZWDLgqgw4ybQCkFQH5oJCTdUU
 wE0yJ/Y9h7vfVuZJk7Q798EWDPkGAAVoQ0xT9DQZ/Xgy9qPLHYxDf/rfPA4UpLeU8YUg
 bWQoDoBhPItLTwvMMjybbrmnLuN2oshbu5wDWf0dZrPthsT8WZ/kDXWyQ0X1Sc7qVl4j
 IGTg==
X-Gm-Message-State: AOJu0Yy0EEJcyYk6DmWfwwAToYu1GLxCPWM4MjdExwImRb33hmmISRjm
 Syl182FR/1AOpF9+Q6ROPSS0jx+W0hvVz+aQd1rQrmhUrHcjBLA3bYS8e6sP88JlOgM73GFNYGx
 VlJv4
X-Gm-Gg: AeBDievetF8Bs7xo9CcS7a6Hao41sXxNBEJ1oohoo77kEOjdEf53RX0Aa3vyZ+m9BD4
 dE8Q1A/P8M4EGFjGGPMHyM//RqOnWRXTcXEvUOm6Nko+VLSOJbWHhpI28wit/HNwsdjVF8/gOma
 w411h+hpmXHJWFbH8bC1JmiRul9Xo67rOwAVIr46zImFIAkgsVqZLjwF/xeB3SCjebZFSPTvKzh
 xO/lAx3P0oKfC0TSKvZ0tAN+fafNs5hCL0GuAE4ClUqWvJxRJ8vKwQlhEmuBRjmbQBIHzwK1cc3
 LWurH5DXQF1Ia8Mo1rkle8Vb1k8RQd24vqOUbVo/sonQnf5uMKOyyAGSvLF25F3VOItAU1Z2cW8
 sTLjgN0uyuEmL1r3DoEQea0hH+Wdnp4WZ60a+NuCFeGva1d1B27a7xJ7qckF4w6ssOFn/zddNwh
 2AzAedrAnQkeeaRPPeo8XxyWlMvfKu1R9hPf5MZHDIkSt3RIMp9JS6CEZe1lyhI2MG5JE=
X-Received: by 2002:a05:6a00:3902:b0:82c:8c6a:682b with SMTP id
 d2e1a72fcca58-82d0da6a4efmr9426692b3a.19.1775431979471; 
 Sun, 05 Apr 2026 16:32:59 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b589b8sm11991523b3a.24.2026.04.05.16.32.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:32:59 -0700 (PDT)
Message-ID: <31234279-3a60-418c-ba37-661ee1a17444@linaro.org>
Date: Mon, 6 Apr 2026 09:32:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/35] target/arm: migrate fault syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Migrate syn_insn_abort and syn_data_abort_* to the registerfields API.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 87 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 74 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


