Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45AAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOTt-0007MS-Aq; Thu, 02 Jul 2026 16:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOTr-0007MD-CY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:57:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOTp-0005iS-EY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:57:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c8017e981fso20489515ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025872; x=1783630672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OTA0mO8pofWOJw4jK0JW10DbJ55kuKX0VZuBexYn80Y=;
 b=gvvSCEDxjH62kvSt2IhGry6tPWDyeFFmo0Z6D85bROLYrFu9S+AhLLLIg8oF299Nit
 awBqZoaDlppceirRa0zV32XamJ1spt/f5fER07tkgBAZVaQcD2GjTRIFGiTlF7GbU2Dp
 6S7IuyvwMh3SkGlwZfIg6RIjIz8Cg7vmNESw5mT1Gj8iOW2z5lK8v36PDTFPe1EvLKQJ
 87Wj8ySEfqTib3i98SsV/QsUc/0nmIrChiPwVcEn95NC4sp1TqpdSPR+PNrASHdOK+Y4
 SA/6u/ZXTuSPlEIg6pNRAWOX3Ik6hgVo0ALQold+j/ZnUPp1hN1g6zhRgYGRamG0SLxc
 c4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025872; x=1783630672;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OTA0mO8pofWOJw4jK0JW10DbJ55kuKX0VZuBexYn80Y=;
 b=Z6V4lMCLJjeI6B/iOiUcvpWZXSf062zv7Rpjm2gw1olgHqK1lqR+nc0xZYB0KvU0UR
 lC0pjNVAOUZiJd5G5TzlzsOOLR6u4xrzBqn0wm9iN6nVwMk6kFpWNVl5lHPGeUW6+R9C
 lV3oRDkufiScLLJrCyTCn0MSOvvJmwlBI+HaDuzxfTY7tsy+nlfGQpyLWbIFmg+r9P0j
 Y9570LVFdG5gEQKpct7hSX80pL8E4lUM37cxTPQPLan1E2AIAoSvGnjjPyKdiUB8eGid
 sERK7kRIOwYBfyUzwOPZCXSJe1IEmzReV9Ia2rnKGGHywTWU/57ToYzC6AdlwF1/Fufw
 N0xw==
X-Gm-Message-State: AOJu0YyTDV5uoreuNYEdo1VsJzJ0nwSmM7O1buDsNhvaw68qexdv+EvB
 Fle/MxnJHvJ4wC+21H74SLsFfazi9ExvJ2YPiSjSEFWBH7g5XudTnfz3ZvhOxEqCrM2YHr/Ahu9
 UNP6E
X-Gm-Gg: AfdE7cmO/EssTlNIGFBAPN8TCUodVVakdjugxq8f+6ls3u56N7vJaTuKgQtrJnduH95
 6BDlt5SqKfsTLMxb2CRhs9KuEFIhlp0+zw3P0po7fTZQiFFLw1SEIawJJgRDTCnZTPgji2C1oDI
 bfmUL427VXoymkjnm66lbdZWJS0MQ11XVhlldZhUbN1oIVLoZeLOG6kl5+xMjyvZaRxilMx6vbF
 uh6P0fXGKfiqRnO1sP6lWuYw3exTnPfZ297IoWWN5Ufx88FgHlG7lgA3gVrKlCUSD7OGsllvzCZ
 V60DlCZMmYaKAi7kiIHZUnsfTiTTi0JdVYsVdY5n7R5nbUn+pbW9yI6CPBS0o2Sv74uqh1t/a+F
 7bOGjXeWFAHaBGvir3BFXdk3LtxBBXhaxj3Tx6Mjo6BfrHBDxp0PJ6CqbbhJnssU4hsWJtOhkM9
 /nTH+8s4miwNztUYIVVOjcfwFT5hJwh1hran9nBj97zB9AW4B4rfNbKzR1ow==
X-Received: by 2002:a17:902:d481:b0:2c9:854c:a45c with SMTP id
 d9443c01a7336-2ca911f59b6mr64300615ad.34.1783025871111; 
 Thu, 02 Jul 2026 13:57:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cacf1dd901sm2296585ad.37.2026.07.02.13.57.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 13:57:50 -0700 (PDT)
Message-ID: <3ff5f710-e80c-4d3a-b316-806aa7e730d3@linaro.org>
Date: Thu, 2 Jul 2026 13:57:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] target/arm: Report correct syndrome to AArch32 EL2
 for trapped Neon/VFP insns
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> When an AArch32 Neon or VFP insn is trapped to AArch64 EL2, bits
> [19:0] of the syndrome in ESR_EL2 are RES0.  However, when it is
> trapped to AArch32 EL2, the HSR syndrome information defines some
> extra fields:
>   [5] : TA
>   [3:0] : coproc
> 
> where the TA bit is 1 for a trapped Neon insn and 0 for a trapped
> VFP insn, and the coproc field is 0b1010 when TA is 0, and 0 when
> TA is 1.
> 
> We attempted to address this in commit fa33eead ("target/arm: Add
> coproc parameter to syn_fp_access_trap"), but got it wrong: we
> thought the RES0 condition was "is v8A" rather than "is EL2 AArch32",
> and we made all insns be TA=0 coproc = 0b1010 rather than only the
> VFP ones.  Correct the condition we use to decide the coproc and TA
> fields.  We set these fields unconditionally; later on in
> arm_cpu_do_interrupt_aarch64() we will squash them to zero if we are
> taking the exception to AArch64.
> 
> NB: there is some disagreement between different revisions of the
> Arm ARM about the exact handling of 'coproc':
>   * the v8A Arm ARM text says coproc is 0b1010 when TA is 1
>   * the v8A Arm ARM pseudocode in AArch32_CheckFPAdvSIMDTrap()
>     sets coproc to 0b1010 when TA is 0
>   * the v7A Arm ARM text says coproc is 0b1010 when TA is 0
>   * the v7A Arm ARM pseudocode sets coproc to 0b1010 when TA is 0
> 
> The v7A Arm ARM pseudocode also disagrees with the v7A text, v8A text
> and v8A pseudocode in only setting TA to 1 for traps caused by
> HCPTR.TASE; the others set Ta for all trapped AdvSIMD insns
> (i.e. including traps caused by HCPTR.TCP10).
> 
> We assume that the v8A pseudocode is incorrect about coproc (as it is
> the odd one out) and that the v7A pseudocode is incorrect about when
> TA is set (again, as it is the odd one out).
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/1153
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-vfp.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

