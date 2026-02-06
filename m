Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D9EEE6B5E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTTy-0002He-Is; Fri, 06 Feb 2026 16:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTTv-0002Gn-VH
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:35:15 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTTu-0008JB-57
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:35:15 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4362507f396so1868482f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770413709; x=1771018509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c2zcVYAj5jk7dYFRPpkMr+tt5b2E+Q9puhBUBWZ/9jY=;
 b=Yint9Z8U0OglKUKKyqBE6aofLmvC/rmbstjnwqlaxkUhr1y5m0ZEZ9jPWlsmmuEwYd
 lDfQZu/KKA/Kkq9UPA6NaY9ijg8MYXdQ47w74+7rhq1/Gue5CmIn4o6sfa0sTgH5lPab
 v6DEVEiXW29M+jg/s9JKqQ4bpJZMxtvVuv1OzccziHJ1ZxSC30U4dfqpqO8JwBaNBmYs
 QkPvfMcWWodwpTTEukI5SmGerD85VAa6PKrnjOEgK8NqQW32L6Y3+VSejddBbvSNFNXC
 cU0c4jLPo7HeWLtDoUH7NpMpmrke5SRRE7OxNJsdlgHjo1Z0Np+Kb54C6kHi8ViVAZqm
 D10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770413709; x=1771018509;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2zcVYAj5jk7dYFRPpkMr+tt5b2E+Q9puhBUBWZ/9jY=;
 b=Nm+ToUbuMpGc9yLWwJWmtzzkcVbmMY6VehACfEknKhQV39eTMppSPj5pwnk2HUWd5g
 dm+FyJSZojpsiZei6sni8WEzKl9shMnaxXvaopR25rb6F2hHE8wNWheLO/kCsI/e5OBb
 zei7nD1hFGqEPo0xEVUaEF1oJFwfex9FDHllhFoyLdPqVkofHlcatKuH2roTCZPalPrM
 PPi942TyLh3zK+RWysVOjJg/0paIxdDeH+iXo49SXDieOk5iv7tiA+NxV2af4cuClrxM
 x/Xe8jQrTd+Do8lAsmDy4OoSB2LyHJhXjHF6eHfxDh0KNa818pcAZuWyR65JfDckXJr+
 C9QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnHBPetgPtva6XqB9tPXhb44r0d/Wx1bckkoqw5YiZlp63+R6mFdOkZwByPskegy/YpwUnzD0bViYK@nongnu.org
X-Gm-Message-State: AOJu0YzFIH9vCO4C5ha96YImkVI+gXQCDwt2UB5mNPftl+YMGpo1lJt7
 UWZjeo6zzPJOF3joHJFnJugKIOtD0I1LoAWt3bJe+YEC+mbOggSsdSwv9Pm0zQhjdbA=
X-Gm-Gg: AZuq6aLYKSCJpTJCCY9VPbQa6Ez11X2Ygchu5If48JMwWzrzf5cCeZMmmzmN2Fc9p1T
 g+3xgMAsznPIVylAybtQZiNdp8wtS4lZ7JgqRln9DF851aKCoaf2+kFNUzfHQfLmtMrf3PIbKEn
 nZSW73gVvR+OJZL4Fv/HQsJuIPQXT7g7hqY8PKSDF8zGnUCOXMCfJD9NWeABikIL9okqRVlfo3b
 xdRjpn6GPGd8xH4nF9AeoYx++IP7o/KIJyE79KI1a9/2zfCcl2GrMvzfjVtQEtiSv64e6N7e0f7
 AhkBFGF/VvK41hV77FS1kXSq/Z80XvvHOklaPSyKZwuvjwiO5t4jXN+mS03pHYmVx9WmkrA4tlq
 yKWNZdZ0doMXdLPVXR+qgnylxx6WrlMGoHmjwJk3sdhvox4fO1awKe4rlmxGbJtjX0btMCZUn+l
 +tOsPRudLBI7bQWXxE1ceyY1fM+18qnJB/26Bq6jEGLU+8QwIDZN7yZQ==
X-Received: by 2002:a05:6000:1a8c:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-43629345a06mr6878311f8f.26.1770413708885; 
 Fri, 06 Feb 2026 13:35:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436297462a8sm8192083f8f.30.2026.02.06.13.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 13:35:08 -0800 (PST)
Message-ID: <5f996b99-eccf-4b61-93a7-527e42bc405e@linaro.org>
Date: Fri, 6 Feb 2026 22:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv64/test_boston.py: fix intermitent test timeout
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 djordje.todorovic@htecgroup.com, thuth@redhat.com
References: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 26/1/26 18:45, Daniel Henrique Barboza wrote:
> The recently added Boston MIPS board selftest times out consistently in a
> machine running 'make check-functional' with -j 16:
> 
> 18/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
>        TIMEOUT        120.09s   killed by signal 15 SIGTERM
> 
> The reason is quite boring: it is testing too much stuff.
> 
> Note that functional tests aren't supposed to be used as stress tests,
> e.g. it doesn't have to test every single corner case that might hit the
> board. It is supposed to catch most common user ooopsies. A timeout, in
> this context, is most likely to be considered something abnormal slowing
> down the emulation, not a lack of CPU horsepower to run all the tests
> before timeout.
> 
> Some of the tests claim to test odd CPU SMP numbers to either "ensures
> proper core distribution across clusters" or "validating proper handling
> of larger asymmetric SMP configurations". But there's no SMP/NUMA check
> made anywhere after boot, so in the end we're just testing whether the
> board is able to boot with 7/35 CPUs. As far as these tests are concerned
> we could have a completely broken, but bootable, SMP topology with 7/35
> CPUS, and we're oblivious about it.
> 
> Remove the 7 and 35 SMP tests, keeping the minimal CPUs (2) and maximum
> (64) tests. With these changes we're now able to run the test with a
> good TIMEOUT margin:
> 
> 17/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
>        OK              61.28s   3 subtests passed
> 
> Fixes: e71111e26b ("test/functional: Add test for boston-aia board")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   tests/functional/riscv64/test_boston.py | 19 -------------------
>   1 file changed, 19 deletions(-)

As CI often fails without this patch, I'm going to merge it via my tree.

Regards,

Phil.

