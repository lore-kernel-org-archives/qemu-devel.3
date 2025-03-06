Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5035EC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJI8-0006x6-J6; Thu, 06 Mar 2025 17:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJI5-0006wk-Ps
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:02:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJI3-0003M4-SE
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:02:05 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22355618fd9so22621325ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741298522; x=1741903322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PEHUVzRalVwyRZ5YF4ArengMdg/ugWoJp6n/mHhdcWk=;
 b=Mvj5BtXEPe6QlppLkT5vEe5KEB1mQa9f11KOOU8GanZHv/OhijnwPtO7PULXPKQyZC
 x+bHibCwkYHlRx2Z0UV/7lNa62VhNpb1Ub7DO+RWwynqF4XzzT5sOZHXbm58Ld7hbbAn
 kbQuN6+mPQ50a3YEEcnO16VYgWlxLCtKBdedTm0Qgs61nbBczi9YCZFiwdcAaHF6+ipa
 u54w0qDig7aH/2IFKbWJgH+eoMWq19y7Akp2nVebLE9eBfScx1I1JsH3uTSPfYhkQOou
 GBvU0w+dgxKhHl1M6rvQTeTHlUCuX4IcvvbRttVy0BJBbbL9xzLGbxH5gN0ISf98FndC
 GaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741298522; x=1741903322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PEHUVzRalVwyRZ5YF4ArengMdg/ugWoJp6n/mHhdcWk=;
 b=rQQMAnoNkLvX0u2HU2IvEQaLPtfyUPT3qCV+OA3HizpPW6sxQE1GBHqnCLSya9+hG4
 WTiZ3yoMo/q8L3O/mRf2m6RwkRhc5H2c9Rx0rTo2AGCaeEnk1Hw6K0efh/HxSlA93Rat
 wvrtxs6btXcq5X1g+JWAAETccnC1w2c+i1xTQYNvAq29lBSkOPiAu5ADB+bvCerjgP8M
 0qXdrRv+DnYHwZcGjMu2PGQHqRkfzaIYqeSu3AjnNvNLvs5IcSOnb3oI2d+1WEqHNUAN
 7O7BytzNrdAtBa2xKFIJEI2hFZd3ATXU/NqmSwsIQa6OBEFwjZ4Mbp1T9dfFIjjszEKL
 AmsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/krdlZqmzCR3bIZBXVmzq4ZAdyoWgpDGj95ytUy6H3hvJTucb/ExeXPTmlY+bXh1ud12R7xG7vJWG@nongnu.org
X-Gm-Message-State: AOJu0YwwmGqv3HcFOLqzW75wzrLLnQMkhBxqislcdwY9JhnE1b1Do7ga
 lHBL/GpFvOGO5uI5B4IFZZ0FZoXpPZGaqDr1ihaFIKu+9mGWjDlEM0E3bSM/5UOZPjAkdjWu0QP
 B
X-Gm-Gg: ASbGncvppkvdxG8bk9QGkczbdNiHMxeK2X2eiDwcRzN9V51Bg39ttKjHM/eGAcTuIBi
 v/UPZ8MA11eu/KDELGKyt/iNA7txLV6mcUT/kCSk5wtzd1UKL1ijemRoDCcI61Afg/mq5mt14fA
 Kl2l6gC+X+PDH4B+t3q4JLEwSeO5W1e+VUtpQ7EHqhJDkNO5f10ZSltM6OB0EGndioUlcgDm/4A
 ae7IZASNmnxmVMa13j/yd37mg3oZ0bOARuyBpIG/f/8qRLbKWf26PAxX6dJ8cDDvhPsjfXdzAvP
 H+nOQp/uSCVuPBxBkDIQ97k7YLK4XOgNGOXJnh5hLPzSRRB+8u5lEo3rAhVVq3l3F3IsUhoAyFC
 Ya4CGP2BR
X-Google-Smtp-Source: AGHT+IHsblbmDlEzdB5qd2nutva1w/VF9Wgo8fh18Znpac9yUQCxtXiqC28oNzcOXcvBf4lWNvZbtw==
X-Received: by 2002:a17:903:2405:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-22428bdb681mr13469565ad.39.1741298521686; 
 Thu, 06 Mar 2025 14:02:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af3ac1a7435sm260059a12.68.2025.03.06.14.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:02:01 -0800 (PST)
Message-ID: <e7127b41-f35e-4911-8b07-8080b30efb39@linaro.org>
Date: Thu, 6 Mar 2025 14:01:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/38] target/hexagon: Add privilege check, use
 tag_ignore()
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sidneym@quicinc.com, Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-7-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250301052628.1011210-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/28/25 21:25, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu_bits.h       |  2 ++
>   target/hexagon/gen_tcg_funcs.py | 32 +++++++++++++++++++-------------
>   2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index ff596e2a94..6582bb4f16 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -37,6 +37,8 @@ enum hex_cause {
>       HEX_CAUSE_PC_NOT_ALIGNED =  0x01e,
>       HEX_CAUSE_PRIV_NO_UREAD  =  0x024,
>       HEX_CAUSE_PRIV_NO_UWRITE =  0x025,
> +    HEX_CAUSE_PRIV_USER_NO_GINSN = 0x01a,
> +    HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,
>   };
>   
>   #define PACKET_WORDS_MAX         4
> diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
> index c2ba91ddc0..65bfa046b8 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -21,7 +21,7 @@
>   import re
>   import string
>   import hex_common
> -
> +from textwrap import dedent
>   
>   ##
>   ## Generate the TCG code to call the helper
> @@ -50,6 +50,18 @@ def gen_tcg_func(f, tag, regs, imms):
>   
>       f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
>   
> +    if "A_PRIV" in hex_common.attribdict[tag]:
> +        f.write(dedent("""\
> +#ifdef CONFIG_USER_ONLY
> +    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_SINSN);
> +#else
> +"""))
> +    if "A_GUEST" in hex_common.attribdict[tag]:
> +        f.write(dedent("""\
> +#ifdef CONFIG_USER_ONLY
> +    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_GINSN);
> +#else
> +"""))


You add new exceptions, but do not handle them in cpu_loop.

I suppose this is not actually a regression, because we already
fail to handle illegal instruction exceptions in cpu_loop.

But you'll want to fix both.  :-)


r~

