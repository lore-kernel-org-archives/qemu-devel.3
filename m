Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C218EC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 11:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Hun-0003Ko-GJ; Sat, 18 May 2024 07:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Huf-0003Jn-Kf
 for qemu-devel@nongnu.org; Sat, 18 May 2024 07:07:43 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Hud-0006L9-N5
 for qemu-devel@nongnu.org; Sat, 18 May 2024 07:07:41 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57230faeb81so3659481a12.0
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716030457; x=1716635257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4dET/NmGtzyD+ACaXmhoU/hPOHENM88UtISuGsnyJ+o=;
 b=fUaPVAQRSzdk/AVKrk/U2zCFDgJQELz0mpgvwR21kr3MrMyGTpvaxEmH9ec5b6c8SM
 tXUim+1p2Esan6Y+nKVmmgYOlSI5nllTdp5+vcktako7lsUBBHgGC4dNmXBvebMNzkiq
 kh1mCQFvpt+HxJkGZeDVNLCdl/TNUbJNyUxm4jtBXTSuH0PGLhtAMznvqrsiBmXP0jxS
 MrVfUCFoHvYPNTBmYF74t8eusFWZsM8HfNhYsYKODEnZ32e2pIf/cryEa0j37DVfii2S
 Sv9RFoV7Yb5fcJaUgnHJdY5kXAhIYUE7dd3xGumVOJgI/7hM07QU7MNBn3u+5T4Hcsk6
 ONIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716030457; x=1716635257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4dET/NmGtzyD+ACaXmhoU/hPOHENM88UtISuGsnyJ+o=;
 b=uAJiA6PRbnEqfyShzssdvZnQsul9Yv1KI4D1Z4qqtMygENvub2ZsSfufWzjfjgO45/
 jmGuZSbRFogYFNz/ydLUAIBjI5TXOhEQuUfQyFFXKvwJ0PX0HEv6xyDswiF5DWvp1Ikd
 QUFznxGPk7EDSjnA5mK1Qj7/bolvNnFgoN8FHLlpg8nABIk3pOj8ao50wIjv5qYdtKJU
 Z4A+Kl9mG1xJaR+tJVxgdgD7yNgg6HPif0b49uEiox58AsKnA8TiCZwXLsrBX2D00wkz
 D+UqUlq6iiyhM+Rkn3xscqJ3EwShCPx/ix2EXr5aU0Z1ZQ2mVKJBl1FFbPGGSWDrHzGc
 p6YQ==
X-Gm-Message-State: AOJu0YxSvQ8Wyf60/mwSzhyQXkSL7qzgLTR/wHaUGkoF90fI7CvFh3bY
 qj9lD/wn2tDmJIiKYez0kN/sj8YMsKkQ1IOIKppUmUHRjT6/6+/u/kDDMRI7avk=
X-Google-Smtp-Source: AGHT+IFv7+uBRngP8CDypa26nFFRW6eGEijtjsaeI/L2XW/TGCqB3kIDGtJK7Q3RW9tfN+w4Y+qzYg==
X-Received: by 2002:a50:d741:0:b0:572:983e:4aaa with SMTP id
 4fb4d7f45d1cf-5734d67f615mr21160707a12.31.1716030457222; 
 Sat, 18 May 2024 04:07:37 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bed0035sm12820311a12.50.2024.05.18.04.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 04:07:36 -0700 (PDT)
Message-ID: <9e431f9a-10db-4fb2-b2b7-a4deeff5dfa5@linaro.org>
Date: Sat, 18 May 2024 13:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] target/ppc: Implement attn instruction on BookS
 64-bit processors
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-6-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240518093157.407144-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

On 5/18/24 11:31, Nicholas Piggin wrote:
> +static void gen_attn(DisasContext *ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    GEN_PRIV(ctx);
> +#else
> +    gen_helper_attn(tcg_env);
> +#endif
> +}

You forgot to check priv in system mode.
Better as

     GEN_PRIV(ctx);
#ifndef CONFIG_USER_ONLY
     gen_helper_attn(...)
#endif


r~

