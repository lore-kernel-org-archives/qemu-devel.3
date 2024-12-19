Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95721E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 23:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOPfU-0000UF-L0; Thu, 19 Dec 2024 18:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOPfR-0000Tp-PZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:10:54 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOPfQ-0000JT-2K
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:10:53 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216728b1836so11411415ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 15:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734649850; x=1735254650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ExRLMyVWQwYdcgJsDMXyiRZassTTIjM94alMy1HAyDA=;
 b=KHx5Es8CBLYi+a5o7BmaAPGgO087BLPJNaPmdD4CZZ2M/nbEiMSEiLZBPj//Ldmmwj
 CPfTdzRpSY50d6ZQjAFJpD+nDq/kgICb9pUx0f8UrIv/jd54lpc7f9WcAxzQHbvdqAfs
 WTM6DYlLs7oL1VmGs2piTE0WvekcHvpqyPiGMCdjT1vijz1vxhKA5OJmJa7JWblnCo7s
 M9Lex9+ISF0C2GW/K6nTXuwqdgZjAqUePTq3IS8p8ZGRLwNPzcRN3S03focPS/jfq7Qs
 KG45g2P6CILghAWY68ItLIo0JxzIrL01gITe6I9a8rkfIrs55AQ/HjIOtfD7k4wwTIeD
 ET7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734649850; x=1735254650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExRLMyVWQwYdcgJsDMXyiRZassTTIjM94alMy1HAyDA=;
 b=uoGaa4IQZg+o97jVX0la0IG1xrnooUdBU3knFBzNF2zqw/5nvth9Z3PTxsmqTJKZQJ
 jjrkfz9CAjW/gOgTorthm499JxuGed1RKN8Y7TYRJ3tLL+nVlQ8N3gpRmFpX18tdDazR
 PLWxXye8i6ay5PCiCPzqK3t3b/a6gj9uxe4mRMatf9jicQ78z+2G7D7IlcQBYpvlU0hy
 Nkljxe1DtfC2ZCHoKY6IzbVD7Robzfe4Kk9h1op1vh2NOpFQByc9hLpl1rXyPfOvVBbU
 VmhzhKle1Cibr0ezVuJr5jHNwJTRePOL1UDlka3k60WcdhGQvjp622UEK9bbhWaVFDOy
 QG4g==
X-Gm-Message-State: AOJu0YzQMdd/DhA2eCCZmNMmH+xZysa0DOGbPW4LBcFi7giyibM9if53
 eCOqTZEsZJyoElGo2zA5e1V216/85xNFqrvjrX9Jdgyn3pfsv7egCtkvDpLlrC+gnt/ZhQYUTyo
 W
X-Gm-Gg: ASbGncsbua7o3ULcCAY/CTpH9hLR+5xykCXrcH5aNKVNJmUhgcVsex6rLEQ45u0q/Sp
 0X1gwEVsD/7ex/Ag0o0yo4uIoYiigdvRBJ9MyjJoXJIkpG7OyizdhORBWW4gqZLQFw49QSoYzbC
 YZUunVpg0lCKbor7V9xfge9qxM8JpiqixHTP2jQomQP1yrslvcuP/4u3D3IscGZSMXlxrhaf4Jq
 QGaZAS+D3cUnSMvot7nZvNaFIbgt7woTpGjk0wecPAyF9qCF0n93SkJFIWPbcsM7qlMCDA=
X-Google-Smtp-Source: AGHT+IGh5FwFfJJVxPsVWCd/7iAQFyoX/r8gYex6u23pU2MPbYMxB+JGpwhV+pjy741Sy5x1HxWzTA==
X-Received: by 2002:a17:902:e5c7:b0:216:393b:23e0 with SMTP id
 d9443c01a7336-219e6f2e9d4mr7587175ad.36.1734649850292; 
 Thu, 19 Dec 2024 15:10:50 -0800 (PST)
Received: from [192.168.0.4] ([71.212.144.252])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842aba72f71sm1716281a12.9.2024.12.19.15.10.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 15:10:49 -0800 (PST)
Message-ID: <65c2fdd8-f14a-4392-ad4c-a01dbd2e011d@linaro.org>
Date: Thu, 19 Dec 2024 15:10:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/arm: change default pauth algorithm to
 impdef
To: qemu-devel@nongnu.org
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241219183211.3493974-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/19/24 10:32, Pierrick Bouvier wrote:
> Pointer authentication on aarch64 is pretty expensive (up to 50% of
> execution time) when running a virtual machine with tcg and -cpu max
> (which enables pauth=on).
> 
> The advice is always: use pauth-impdef=on.
> Our documentation even mentions it "by default" in
> docs/system/introduction.rst.
> 
> Thus, we change the default to use impdef by default. This does not
> affect kvm or hvf acceleration, since pauth algorithm used is the one
> from host cpu.
> 
> This change is retro compatible, in terms of cli, with previous
> versions, as the semantic of using -cpu max,pauth-impdef=on, and -cpu
> max,pauth-qarma3=on is preserved.
> The new option introduced in previous patch and matching old default is
> -cpu max,pauth-qarma5=on.
> It is retro compatible with migration as well, by defining a backcompat
> property, that will use qarma5 by default for virt machine <= 9.2.
> Tested by saving and restoring a vm from qemu 9.2.0 into qemu-master
> (10.0) for cpus neoverse-n2 and max.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/cpu-features.rst |  2 +-
>   docs/system/introduction.rst     |  2 +-
>   target/arm/cpu.h                 |  3 +++
>   hw/core/machine.c                |  4 +++-
>   target/arm/cpu.c                 |  2 ++
>   target/arm/cpu64.c               | 22 ++++++++++++++++------
>   6 files changed, 26 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

