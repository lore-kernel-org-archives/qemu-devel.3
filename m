Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D3EBFD0F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCP0-0001bd-Rw; Mon, 13 Apr 2026 04:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCOK-0001MB-Qt
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:11:33 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCOH-000898-Dr
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:11:32 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c76bc3e8de3so1552651a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776067860; x=1776672660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Raby3Q7Vpe048BYZRe5jFAuT6C7/4TOxXf23/h+9qR8=;
 b=EHwfYcWH167EqmWOyPdu0LcN/8HqOodlfBtLRCR2/DUV8JFu2TPJWVoZy3f3dIABec
 kvHaR7610QVmWNrXHIAe4MD3c2z+Qz8qDDbrZyAdloJKe+k2Eqi4Gbwv3TwdpfXOlVSg
 jeYdcp6jZPt4B8qxRM5LkQYVBm4bkgLHgoflAx4PK9pQrnl0o9G/sNAP1s/qt2Tyg1CO
 q/16mq1dbJtLL75ebxjIKBqV/lj29vFHfdsINgPdggk+sQmCqlZ/xloVVoBoAhsrpVGe
 5ESv9aBI6M203R6zOkYrw8XU84TauYxuW1OS0os9I+aRRYI4kxyW9Mzc3+TGsO3zWLHI
 MaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776067860; x=1776672660;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Raby3Q7Vpe048BYZRe5jFAuT6C7/4TOxXf23/h+9qR8=;
 b=ghJgijEWyE4xoB7VJT/7/uX+jRBLTJ5MXXeFIbgcTwEyX1WYyTzitvjrWyABi283MG
 L0+XyhNFxCS0iy+AltgO/a8+S88+r8/Mivku/iplM4SoUtpNhyueGa2zqPcS3nhAL9Tj
 IA/jp9DbPexJqpdoew7lrO26Iuf5SEVuvPlKedQKPvy9AkaybHxrHxuWt994H6zlsYKO
 6t22G/+i5wFj1e3FajmFjkQ9p++DKHB+zitoTDxG+iw8rigtYTnOKKauNQmg4wwLqzf2
 Yyi0+w4dYqvqQz2gKc8p5L6xa/nJGnFRftihx56gd9Hee++8JE6Tkde6QpqweVW+Nqh5
 zr6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+71QQQ5aNW/7kwHmHM43LiSFv/PiWO/XpAZ+/7j0iEXS8YuijCcbhZipfWsuTThK9GfjbBRguZ1B5Y@nongnu.org
X-Gm-Message-State: AOJu0YweYGTHpg2BCgYY5JK0PyGeE+T1JzMogk5iX/5MY3mattuC+PSG
 clXTcKmSpYy0bdl1ewP1hpRlGuLLDvPA+bFlXCW30EwmuuTrxGe+a2nQ1OopfLl7/0TUr2R4bf1
 lkYfvGKs=
X-Gm-Gg: AeBDieuj8YkfAZrh47em4oADmp5Ke55zrIYSjGJQ2GsKirsZg5+pj5HGGASfYBH8YJf
 SEG34XVop1ZySU1QXOUGQozQXBgDR8vaExfyi8T9Q0G/itEYUPpxdTNU5qBjM8yxErHlbvOZgYL
 Ugrnxaiw2jQJC1kKWTzy+v05RNowiRmcpSG6e6TJNu5dP1HLEFe9ZJ7IZNvXHlyGhaEiX1Eqtzb
 v12NNRVa3NsMY5smK/iBtPooqnfna5JqZt4zqW5WRSVQZJDyP7s2NMrT2SMZKBFXo/gfPQtXVji
 quotpmkfdNj7A6RhwGwiS2tjiTi1W9cITC8hsxq8pEraquwHoSt4fzhpSenFcYxvCCOmm8m1hLz
 94YaXq6dOAZdO0JJPD+M1HlylkO26J5siiOOT3GzWFoyNPuii0bHCfZJfbDTgeRfWFxoAlluo7H
 ETMruCx/O5baQGAnD+PUzLhKihbm+vdX+rUTao5g1RuyEQrRmk6aj6jbXOMDXRvI66FmsQdXvH2
 jEC88DGYhIamzg3DmJtImDcGHe0zkolqXX9kQj2ilJbDtses8NlXUE=
X-Received: by 2002:a05:6a20:72a6:b0:398:99cd:baa with SMTP id
 adf61e73a8af0-39fe408398bmr13605150637.47.1776067859855; 
 Mon, 13 Apr 2026 01:10:59 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7921a3e6d2sm8854815a12.32.2026.04.13.01.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:10:59 -0700 (PDT)
Message-ID: <31192f56-7d4e-4d5c-85a2-c7724796746f@linaro.org>
Date: Mon, 13 Apr 2026 18:10:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/27] monitor: Do not check TARGET_I386 to build 'info
 sev' command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-25-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-25-philmd@linaro.org>
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> This command is filtered at build-time for i386/x86_64 binaries.
> By using the recently introducedHMPCommand::arch_bitmask flag
> we can filter it at runtime, making it possible to compile
> hmp-commands-info.hx once.
> 
> Since the method depends on the CONFIG_SEV definition, define it
> in its own stub file.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                   |  1 +
>   stubs/hmp-cmd-info_sev.c      | 16 ++++++++++++++++
>   target/i386/sev-system-stub.c |  5 -----
>   hmp-commands-info.hx          |  3 +--
>   stubs/meson.build             |  1 +
>   5 files changed, 19 insertions(+), 7 deletions(-)
>   create mode 100644 stubs/hmp-cmd-info_sev.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

