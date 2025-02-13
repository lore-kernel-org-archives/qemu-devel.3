Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BC0C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiXSS-0000am-LN; Thu, 13 Feb 2025 06:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tiXSQ-0000ab-W6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:32:39 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tiXSP-0004HJ-5I
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:32:38 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-726f989dc12so438433a34.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 03:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1739446353; x=1740051153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqhwDScs3lFuaFv5vu9mrKpFQ9HDO2UAWFUu3zZf7hI=;
 b=WdibVJEDoRs25U3CSd1GUnBEyuScEwEzBWFCYsmT78jTKtMCDw3extCHoPXxuVIwVQ
 2ia/udY6a8hm6CO3yhtO9QrU6NPcU52eXc5qsujpDewn35di4hLeOErZJe/o+BFM343A
 kw4SV5pbfZr21hmcoJwEKDoVrccLiJHHvCMsxi1Zxezw/oAn5g2DPAJa/VkUzEeLKTAm
 VgQ1QlKnCW/oe2TgkROqOls42zw8IkuiAmPZz3BgqDV+u5WYTTjEKyDJf2g2cOw8qy+R
 A+kTtxk3OfkWXmvbwb4hW9ZSnLYNvZh8Ox9H+kTOcCMMc94GPvKCKME2IlwRpywuou0T
 oQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739446353; x=1740051153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BqhwDScs3lFuaFv5vu9mrKpFQ9HDO2UAWFUu3zZf7hI=;
 b=pU63xXdw8ZinL06YQva97dYNg34Bjj3qLuiv8WOwtMEjd6pUJz89mhbuWU8Y5wj1N+
 b5lRKWgyTWMqNR9pSiH9MvDIsCkM0Q0JeqBe0x3nb70EtkEPktSelxcLjvqjJ0/Icclg
 6ZdzOniSf63H04OMGaQsiU/pz3KPP67Q5ak/g8j68glrpDBY5l/be1HXZXP7qX8tb1g+
 NCSopMhjLxF8NiuR7hE7biiuzyf+Xoh3OrBluPCuhFXs0oS3HpstIR7EohuCDzIPHWlQ
 zFkT5Ek01KBB1kAzKAzVNbBHsUgV37mdJVhtsjM1l989G2o+WFA8Lk6HXHDKyVUonaVO
 IkCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBVXWKHem/DbAWhvuCDJetsPtN/8yYu1O7m+1KSRK8ip/T0reMhrn/znzgj4i2Rdq5TkKOdig+PdW7@nongnu.org
X-Gm-Message-State: AOJu0YyeC75Jq04RsORht0D4pOjgN8z0+OXZphrzt9Z5xuGW+HM9J1+O
 Ey0zQoKo9w9bXpqmAPbSaUHUqhVYrVssxAvPhG3hND7sWD6iPg/ULkWeGq9gKDg=
X-Gm-Gg: ASbGnctvX71SfDv+PrNZ8jTOPt7g1TXUGCTOohYgkvjL48ZwqYG4OySqfFzR0Ovmxgk
 MEpqcN1MCTSolSXadNC8oLS4WuFrDCnoiCoG9ylkaYTHkJH89PDRfUk/sESyZpA64NTbYth+PRS
 9s2HlORyjdA79VhSoEi41Uv7Ko2hFgQGLp+m75SgBcFOwZ4q4EN2eXL+h9+kE2hKPCh1L7WJzLQ
 iwW6qTrxfaUPjrZZkI1HXuGZYfzH15HkkP+sdwQh5otQALpiFy/AZQ5NFIUApFyP2HFnyj49fRI
 M8YjRX18Lb95o6qpXajsa1ECgga+6R3wI5rW0ZRe4yUu7Ksd6moPlrgCXqev1sBl
X-Google-Smtp-Source: AGHT+IGK+tKZYLs3IEma9hN31YWaTpq9wY0nVWf+mi6HBK9c7b4xj672Q7gqT1omET8RIPlAZUwWdg==
X-Received: by 2002:a05:6830:4425:b0:718:d31:feb8 with SMTP id
 46e09a7af769-726fe76d416mr1587717a34.7.1739446353702; 
 Thu, 13 Feb 2025 03:32:33 -0800 (PST)
Received: from [192.168.68.110] (201-68-240-180.dsl.telesp.net.br.
 [201.68.240.180]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-727001fc69dsm478795a34.36.2025.02.13.03.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 03:32:33 -0800 (PST)
Message-ID: <6ac67c25-9ad7-42f6-b246-24053ce37ddc@ventanamicro.com>
Date: Thu, 13 Feb 2025 08:32:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: silent warnings about Smdbltrp/Smrnmi being
 disabled
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Tommy Wu <tommy.wu@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250213075221.622676-1-cleger@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250213075221.622676-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
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



On 2/13/25 4:52 AM, Clément Léger wrote:
> As raised by Richard Henderson, these warnings are displayed in user
> only as well. Disable them for CONFIG_USER_ONLY.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---

I'm second guessing having these warnings at all.

Sure they serve as a warning for us, developers, that something needs to
be revisited (e.g. after an OpenSBI update). However it will degrade user
experience with warnings related to something out of the user control.

Instead of adding CONFIG_USER_ONLY gates for these warnings I believe we're
better of removing them. We can add TODO/FIXME tags in the code if there's
something that we need to revisit at a later time.


Thanks,

Daniel


>   target/riscv/tcg/tcg-cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 0a137281de..4d0d16576d 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1437,7 +1437,9 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>        */
>       if (cpu->cfg.ext_smrnmi) {
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
> +#ifndef CONFIG_USER_ONLY
>           qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
> +#endif
>       }
>   
>       /*
> @@ -1447,7 +1449,9 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>        */
>       if (cpu->cfg.ext_smdbltrp) {
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
> +#ifndef CONFIG_USER_ONLY
>           qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
> +#endif
>       }
>   }
>   


