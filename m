Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B65CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPall-00088J-PR; Wed, 20 May 2026 02:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPalE-0004xX-G4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:50:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPalC-0002QO-8Y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:50:32 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so25463175e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779259828; x=1779864628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vEEX0BGeOpdC6PRMC79+AEmIE2D1bdgwq6Zx6MnU4bI=;
 b=sXrKD7Yyh91AUeHNkF4zcthKcyzaah4yEERZnJOPtgabwrxGhE+wukUlNBCT0tCGPc
 /gXGlzzom3wgIXOylpzo5jKu740OQH5PXAxzzAXu9dOHFZvYdiO7gzLJX6eUbfBvFrjp
 qlYg+8Fib/u72SQ+fp5K6TECym1Jk1rqIRoXc80s0+wiAZtIFFET294PKD3aYmtzHZA4
 0gLb4JCSRZ66hKgVPHYFtWEG8fGFrSVStWsi9USl/40Qg62PiQwk/jZwI7lyZrXm+CCz
 /SExfDTK1i00i0Tz28mucDPFmhaTQNPqlYinv38a3VewhC/aUMX1YCJXwCO41dVZfphq
 XJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259828; x=1779864628;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEEX0BGeOpdC6PRMC79+AEmIE2D1bdgwq6Zx6MnU4bI=;
 b=iTOx28lu0dweQ4Ror7x+wcVNn1G1HHKMwsggBBOavk9EDIb9bP62p1twGxSRzdqjv4
 6XMTMkusxJVcNE2FJh3gRRsbYSkSoIcYft3QuruGb7GYayPZeAFAbH/6W7gaT+I/fGkx
 D0hHj7kRGdikaZeZq3bHD1NyuAcVoSntjlegsK6rx4XrktZC3U+W+0zmYLeAEAqxOnZB
 DURnV5b12kcT7AtidBnzZDBAEL51LqK46pcmiW6iXmPGAJqROqJcR3TOreYGMaz352wu
 u5cPNJg9AZJmbhbQ4fNuXGM24nJdrq/fqwOwqmGwIGDl+w9215XHOVqDxEWNAbPF9oH3
 iTHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fcGUdWz2PySfhy915gktRwErFZTQMgfnbCFMCIJv73nMSkGruqRShkUSAjN8pqA6R6U+QPmzl/XFX@nongnu.org
X-Gm-Message-State: AOJu0YzWgNvTR5wRKASNtRALwmZ4yreTnJPJM9PyP7Xp6kP1sX6DSnfP
 udeTznPR0iAnGVGa5tHL4ets3ynTz02NaJu+jgn6zgeruEmxJRpPRk1/JipH7WfS2WhYRbAavYm
 ivv/Uib8=
X-Gm-Gg: Acq92OEshp5U2/2/4CJDG6F5iXVF1X+TL5sIBsnRBNiPdimd/mVK380ni8FH8ShPs4P
 Ufo/rbSTQpUG4ubMDy+KRafwkrSPoB4RDCDyQqWCjfwYi5XOXNL678VIJjFbraAqh6n6Yjr/ejs
 lH8lGJ+9+BNg5wV809nLa+zfC75qT64IaZ7tr8PTTw2050BPrTSrGkMTodj4IQoOyhymPo4seU8
 Sv2xlRp+k4oRk5WdY9aWwPwKHyAhaTeY+QuuvFzczA5Ux2GLi5pyrot5vLtJ2kyszYSIZ7rM2rc
 s7B81CJstO0V4EbqQlFgVke8wfYBVCbMA+ALYRd/c1F4zBwAVWBOnPC3preMnIUQQQWc4+tQZM4
 Afr1qBWxEm+g8Rzu7ZtWtziX63vdbXsLoGfJQHfaTjvw/jPSiZl2VHwrta2Ce/W/Y8rykL5DHRf
 p+mIYdQUAtz/RIu3ckNv9O8s5ZdWkaLkkY4gDgm/XbKsIejpdm5A5To1WY9To8jCntzQ==
X-Received: by 2002:a05:600c:46d0:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48fe4dad784mr313171325e9.5.1779259827740; 
 Tue, 19 May 2026 23:50:27 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe74a53sm126170235e9.27.2026.05.19.23.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 23:50:27 -0700 (PDT)
Message-ID: <c9144f6f-5414-4f15-bca7-6284b50e605d@linaro.org>
Date: Wed, 20 May 2026 08:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] target/riscv: Fix PMP address alignment
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260520063606.36600-1-jay.chang@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520063606.36600-1-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 20/5/26 08:36, Jay Chang wrote:
> This series fixes PMP address alignment to comply with the RISC-V
> specification WARL (Write-Any, Read-Legal) semantics.
> 
> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> value is smaller than the PMP granularity, it needs to be aligned
> to the PMP granularity.
> 
> Chagnes in v5:
> - Use uint64_t for granule, in preparation for upcoming single-binary work:
>    https://lore.kernel.org/qemu-devel/20260515180437.23620-1-anjo@rev.ng/

Thank you! Series LGTM.


