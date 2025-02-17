Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EBEC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk67r-0005oz-HQ; Mon, 17 Feb 2025 13:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk67k-0005oq-IJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:45:44 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk67i-0002qO-O8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:45:44 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22113560c57so35021105ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739817940; x=1740422740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OfKOJ/yrttpcnKbFJG+U9Op4nn4q1PmgZ+97nCruyJM=;
 b=sGOGQzUabys6yEZq5zL49KQpLyZyXOG4qmuq7FQur7rf0aZCHakzdFfnVTBaknrS0o
 BQHU0lB0hoHLOI4Di+Dy27mV88+WpwE6Kfpl1wLlbDDx2rulL13ZPqRtcD2wVKfZnQxl
 eTiKtf//PEvDHR80IV8IMgwzMViM6YHrODNXr7jlv/fqVtrfxSJzHgkIoOwtK8oaQp0x
 o9vV+1NGKP4ASbnWkCtLRg/XsFXv1oT/UkEo8u3crMQh6+zQFduhAtYD7JaG4HJDysFQ
 FxS10/fZjC9/FTmv1ieumkDARv2c1qa566B3Xuy2ju4ZM1dc3m8VVA9xk2KxCwLFICeU
 YnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817940; x=1740422740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OfKOJ/yrttpcnKbFJG+U9Op4nn4q1PmgZ+97nCruyJM=;
 b=tlLiFYgD7JZyNfHOXxR+fCE5sJ6PFdKleWeikAskxSxhmD6yEw5f8DQ4JCYSYppU41
 fh+8NRun8yopqPs0yMifatgoZHLatEZWJqwzSV4cWOq8dPnXrdbywRlOobhsy2yLIBNG
 cEi3j9z40qOsbqyOdO1Z2gXx1ko7G/4Zj2fva2tZaSaZDSsp3VId9MRhMt9+1kfg9WSO
 2ji09Y80BZdNufgJgsEy67NPDdBo/YgAeCeEkzfWrQ8rwuijpyT5bt/IigTzPcF7TvFy
 kRLZIFSN6XuQSs4TbR1qT0xQZwgrNhVjp2oI6KTErzPOLRCYTRMWEgmrkpJIaJ039RMV
 qNhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2pKDNbeo2lZ1dkyevACw+fCp9FESqLdwIs0XiNbp2Pokgn5aHO9IMumn6w3VexjVTh5yzQYKM3MaF@nongnu.org
X-Gm-Message-State: AOJu0YzPIlgJuTmFQDlwN9j2Q7MJoyk22LoT4ZAJ71LmAFgaPUA/9MwM
 rsdAqMVSTZwX33pYwEE06EQvq+uQ10Ug5afV17NSm71TibZ+vH3gtYis2/MXT90hRK9Jbgu19yj
 f
X-Gm-Gg: ASbGncsFkSq2RQ3uKKuvABeDdCBlHbSIpnJcgFxq3wBFfcQSxhRMNgu7MON9T7WHNLS
 4qXqnskMt491zeubHpjPufzHGZMGuHzgn8Ll1Sy4+ZpW5uN1oesjgF7jvXrPi5XbUYQfzVNd8Nz
 KpM4k57yLqM+p1u4/86nZLzqK+CgMR01zx8skXjXMyvF/neKAxx++gwhePX6sObW05YkppGLCvh
 VSbIVZxjpwuMxDbDuLNGy2aF1VlrlTb92dCxIHtmPEOWO7rEqrrQXXBOZDA8JqcNcaBxXThnoo2
 yfDrNuVA4A1+diTAcXVistCH0ObTLC6qNE+TBXO63jvx1gYiw8FU2sc=
X-Google-Smtp-Source: AGHT+IEsmw7Y41Mec3N1jAcWleA5kNmXb+5Ftjyn4WivYnBkqivzRaZlFwHId+6CgdgofLBlxiZYzw==
X-Received: by 2002:a17:902:e80b:b0:220:cd9a:a167 with SMTP id
 d9443c01a7336-22103ef5284mr179077825ad.4.1739817939812; 
 Mon, 17 Feb 2025 10:45:39 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d534935csm75150715ad.50.2025.02.17.10.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:45:39 -0800 (PST)
Message-ID: <1f45661f-4aff-40fc-a86d-fc5abea8e019@linaro.org>
Date: Mon, 17 Feb 2025 10:45:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] fpu: Make floatx80 invalid encoding settable at
 runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/17/25 04:50, Peter Maydell wrote:
> Because floatx80 has an explicit integer bit, this permits some
> odd encodings where the integer bit is not set correctly for the
> floating point value type. In In Intel terminology the
>   categories are:
>    exp == 0, int = 0, mantissa == 0 : zeroes
>    exp == 0, int = 0, mantissa != 0 : denormals
>    exp == 0, int = 1 : pseudo-denormals
>    0 < exp < 0x7fff, int = 0 : unnormals
>    0 < exp < 0x7fff, int = 1 : normals
>    exp == 0x7fff, int = 0, mantissa == 0 : pseudo-infinities
>    exp == 0x7fff, int = 1, mantissa == 0 : infinities
>    exp == 0x7fff, int = 0, mantissa != 0 : pseudo-NaNs
>    exp == 0x7fff, int = 1, mantissa == 0 : NaNs
> 
> The usual IEEE cases of zero, denormal, normal, inf and NaN are always valid.
> x87 permits as input also pseudo-denormals.
> m68k permits all those and also pseudo-infinities, pseudo-NaNs and unnormals.
> 
> Currently we have an ifdef in floatx80_invalid_encoding() to select
> the x86 vs m68k behaviour.  Add new floatx80_behaviour flags to
> select whether pseudo-NaN and unnormal are valid, and use these
> (plus the existing pseudo_inf_valid flag) to decide whether these
> encodings are invalid at runtime.
> 
> We leave pseudo-denormals as always-valid, since both x86 and m68k
> accept them.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h | 14 +++++++
>   include/fpu/softfloat.h       | 70 ++++++++++++++++++-----------------
>   fpu/softfloat.c               |  2 +-
>   target/i386/tcg/fpu_helper.c  | 24 ++++++------
>   target/m68k/cpu.c             | 28 +++++++++++++-
>   5 files changed, 92 insertions(+), 46 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

