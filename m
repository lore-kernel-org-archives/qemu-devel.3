Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520BBD5B85D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCQt-000406-DT; Mon, 15 Dec 2025 12:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVCQN-0003v7-AF
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:32:04 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVCQK-0000d2-NP
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:31:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so28733295e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765819911; x=1766424711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=utk3Qx5d7Bzekg4ne1zgrzBmGVruPDI7zIygOkpdbyo=;
 b=s0GZJakw1y6dU2R7e2nLqUGuKhZ2/AwKsEOrcUacyiQkZogG/JFXifPqyfpgDkfY3e
 TaVbfLCttLX8p7m4B+pPJC4gjy571L4Qfeh9svR7B58FlMTOZRClpp35NOcDg6JiHjN3
 tlbvqP6A1yX3cM/7SKdnJ3y0WcJG8yPO2MaaS0VdH71L09n77BO6r71Dwfwbt8CuIVUI
 4YsrJKSCzQcMk1IVkSnRFCr6DCRYz1WkvC6XoKZJbh3oWr7cuPLcsMBmEe21TUTkENG5
 viH8pd6Nb8ErIQSylAIMZdi6ZoAN9kiO8NvDQ80vAu62F8q3r9etTuA08WtVNLhX9HnT
 iINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765819911; x=1766424711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=utk3Qx5d7Bzekg4ne1zgrzBmGVruPDI7zIygOkpdbyo=;
 b=EMXcBdyKvBbx7trWSJKHRgIelt7905pQDCw+huyBPZZ3yQfe/uLceM9E5Z3J7QKLDN
 ElJ1wxA2Vd0wQZEks2mAipaGHRkmZJYBGZ/xlZct2aRkWbKv2Eeee8ZxPqMjfKCYiXpb
 W5TTD1+gWApQ8vTkgwlb+4YpKax5uWd01WYe76AvAjqDlLFgPDYSwjvheEOs+o93S26w
 tesMb5IHfXwRs8tse7DuQDJ+e0yTwNeFaz9XAHGXhlcauDogsnt9txvJjmF4d+k0nI03
 gv1CSu5kqJlpYlXxkaYV6bfH4aLwlltg7BjIkhoOrtgs6PACkAM13+O6dKypMIuKf2Vc
 +tuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrlzpw6+rzkUruEtAubrVpXaVlsKJaLGhELFJYiD3l2JDQabxw5ubgWrSgYAhej1dF4Ylk2JrpiKMQ@nongnu.org
X-Gm-Message-State: AOJu0Ywgxo6Pl1KbKbx6HA12eqqpm8xhQsXs4372bbyec88RKfKdC2PK
 n2QeISmf32HSIzKcNyk6S7UerF5zjVP0T/U9okknFUlhokGxT5ytzLqdi4ACfejuWvA=
X-Gm-Gg: AY/fxX77yEUq6Bvn/g0AxYIGs45UdOZJYkShrlzQkq1BeSu7MiTj1IMRrHSRMlNHVCu
 JfGAMvwg2+LK1zWEUQJqQ/CYzme8uEAjSDgBybIUjKq9L+Lw5JgsDZOahknJKwCE0PivrCpoe7m
 afYuWw6zOabwXekp4d8GiFOunqlSWlALiO4AQEGae2HVDROluiguYfkTxV5YaWptArlE59bXxRm
 EjOq4UYMr56E0HRsrpHDvO1z/g/oiWN/3Wz2Gj2CG4L8JYJ2+n0Szh9ID3go5nmwqn43gFC0ytt
 obh3Wunq3fA+5WazpbrI0jlz5LJRFlNum+t5tbZ+Vv2MhUPUThBxfgY4fa/qH+jZocq2cUxlVGq
 ShMja8u7t7ZUl4HSjxdTI/oEg1jIVgjegYReMAXv8gf4l5/qmH6UNXUFpsNzts6qeFvZLA7War3
 hZmj/3o2sfxJ5qIkDjlspr74kWM3TYg0HwHqIc2UgD+z72NvuEp+sqeg==
X-Google-Smtp-Source: AGHT+IH9h5hz60ia6mDCmEyHEwDc4k9tIve52UJKgVrlhMNDAMhPZLgsS6wsonV94nInykNTI0fBAg==
X-Received: by 2002:a05:600c:4f86:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47a8f9071c6mr123764175e9.21.1765819911036; 
 Mon, 15 Dec 2025 09:31:51 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f7676ffsm201659355e9.4.2025.12.15.09.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 09:31:50 -0800 (PST)
Message-ID: <4ff1ac43-a00f-4353-85c8-6a99aa14658b@linaro.org>
Date: Mon, 15 Dec 2025 18:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/misc: make the tz-ppc-port names more useful
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>
References: <20251215170548.2594651-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251215170548.2594651-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 15/12/25 18:05, Alex Bennée wrote:
> The TrustZone peripheral protection controller (tz-ppc) sits between
> peripherals and the main system. However this results in "info mtree"
> looking at bit confusing, especially as the sequence numbers can
> overlap and miss steps:
> 
>        0000000000000000-ffffffffffffffff (prio -2, i/o): system
>          0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
>          0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-alias @tz-mpc-upstream 0000000000000000-00000000003fffff
>          0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
>          0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
>          0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns-regs
>          0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[1]
>          0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[2]
>          0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[3]
>          0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[4]
>          0000000040110000-0000000040110fff (prio 0, i/o): tz-ppc-port[0]
>          0000000040111000-0000000040111fff (prio 0, i/o): tz-ppc-port[1]
>          0000000040112000-0000000040112fff (prio 0, i/o): tz-ppc-port[2]
>          0000000040113000-0000000040113fff (prio 0, i/o): tz-ppc-port[3]
>          0000000040200000-0000000040200fff (prio 0, i/o): tz-ppc-port[5]
>          0000000040201000-0000000040201fff (prio 0, i/o): tz-ppc-port[6]
>          0000000040202000-0000000040202fff (prio 0, i/o): tz-ppc-port[7]
>          0000000040203000-0000000040203fff (prio 0, i/o): tz-ppc-port[8]
>          0000000040204000-0000000040204fff (prio 0, i/o): tz-ppc-port[9]
>          0000000040205000-0000000040205fff (prio 0, i/o): tz-ppc-port[0]
>          0000000040206000-0000000040206fff (prio 0, i/o): tz-ppc-port[1]
>          0000000040207000-0000000040207fff (prio 0, i/o): tz-ppc-port[10]
>          0000000040208000-0000000040208fff (prio 0, i/o): tz-ppc-port[11]
>          0000000040209000-0000000040209fff (prio 0, i/o): tz-ppc-port[2]
>          000000004020a000-000000004020afff (prio 0, i/o): tz-ppc-port[3]
>          000000004020b000-000000004020bfff (prio 0, i/o): tz-ppc-port[4]
>          000000004020c000-000000004020cfff (prio 0, i/o): tz-ppc-port[12]
>          000000004020d000-000000004020dfff (prio 0, i/o): tz-ppc-port[13]
>          0000000040300000-0000000040300fff (prio 0, i/o): tz-ppc-port[0]
>          0000000040301000-0000000040301fff (prio 0, i/o): tz-ppc-port[1]
>          0000000040302000-0000000040302fff (prio 0, i/o): tz-ppc-port[2]
>          0000000041000000-000000004113ffff (prio 0, i/o): tz-ppc-port[0]
>          0000000042000000-00000000420000ff (prio 0, i/o): tz-ppc-port[5]
>          0000000048007000-0000000048007fff (prio -1000, i/o): FPGA NS PC
>          0000000050080000-0000000050080fff (prio 0, i/o): iotkit-secctl-s-regs
>          0000000058007000-0000000058007fff (prio 0, i/o): tz-ppc-port[0]
>          0000000058008000-0000000058008fff (prio 0, i/o): tz-ppc-port[1]
>          0000000058009000-0000000058009fff (prio 0, i/o): tz-ppc-port[2]
>          0000000080000000-0000000080ffffff (prio 0, ram): mps.ram
> 
> So as a quality of life feature lets expose the name of the underlying
> region so we get something more useful:
> 
>      0000000000000000-ffffffffffffffff (prio -2, i/o): system
>        0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
>        0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-alias @tz-mpc-upstream 0000000000000000-00000000003fffff
>        0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
>        0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
>        0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns-regs
>        0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[gpio0]
>        0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[gpio1]
>        0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[gpio2]
>        0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[gpio3]
>        0000000040110000-0000000040110fff (prio 0, i/o): tz-ppc-port[pl080]
>        0000000040111000-0000000040111fff (prio 0, i/o): tz-ppc-port[pl080]
>        0000000040112000-0000000040112fff (prio 0, i/o): tz-ppc-port[pl080]
>        0000000040113000-0000000040113fff (prio 0, i/o): tz-ppc-port[pl080]
>        0000000040200000-0000000040200fff (prio 0, i/o): tz-ppc-port[uart]
>        0000000040201000-0000000040201fff (prio 0, i/o): tz-ppc-port[uart]
>        0000000040202000-0000000040202fff (prio 0, i/o): tz-ppc-port[uart]
>        0000000040203000-0000000040203fff (prio 0, i/o): tz-ppc-port[uart]
>        0000000040204000-0000000040204fff (prio 0, i/o): tz-ppc-port[uart]
>        0000000040205000-0000000040205fff (prio 0, i/o): tz-ppc-port[pl022]
>        0000000040206000-0000000040206fff (prio 0, i/o): tz-ppc-port[pl022]
>        0000000040207000-0000000040207fff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
>        0000000040208000-0000000040208fff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
>        0000000040209000-0000000040209fff (prio 0, i/o): tz-ppc-port[pl022]
>        000000004020a000-000000004020afff (prio 0, i/o): tz-ppc-port[pl022]
>        000000004020b000-000000004020bfff (prio 0, i/o): tz-ppc-port[pl022]
>        000000004020c000-000000004020cfff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
>        000000004020d000-000000004020dfff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
>        0000000040300000-0000000040300fff (prio 0, i/o): tz-ppc-port[mps2-scc]
>        0000000040301000-0000000040301fff (prio 0, i/o): tz-ppc-port[i2s-audio]
>        0000000040302000-0000000040302fff (prio 0, i/o): tz-ppc-port[mps2-fpgaio]
>        0000000041000000-000000004113ffff (prio 0, i/o): tz-ppc-port[gfx]
>        0000000042000000-00000000420000ff (prio 0, i/o): tz-ppc-port[lan9118-mmio]
>        0000000048007000-0000000048007fff (prio -1000, i/o): FPGA NS PC
>        0000000050080000-0000000050080fff (prio 0, i/o): iotkit-secctl-s-regs
>        0000000058007000-0000000058007fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
>        0000000058008000-0000000058008fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
>        0000000058009000-0000000058009fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
>        0000000080000000-0000000080ffffff (prio 0, ram): mps.ram
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   hw/misc/tz-ppc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


