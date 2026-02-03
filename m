Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94035E7FDF3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn50p-0002Bf-VV; Mon, 02 Feb 2026 20:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn50j-0002Ao-1j
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 20:15:26 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn50e-0000K1-2H
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 20:15:17 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3530f597ea3so2125397a91.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 17:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770081313; x=1770686113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hUL/tekxYZTVlaXybo6qNTHFQdXyKb3ZbeZaLq9CcUQ=;
 b=USDHym31JaHBuAxqJnLC7SY1DJKyrK201YVGoWU8P7huG+XRNTAp0HOyiRzzaxQQbR
 mw5HbkZouBAD8uNLTT0S85AQRIIFPMI/oehZHucT/QlbZD7vKXgFJoWLOpr5M/gOHDdo
 SGlnzImkOeiReXWsPuRcrHMyVQS4/sp2KbQ95w2LSbR2DfiegmaLAOvdG5NE362PpTFu
 R+7pIofoJhDefRl5eMPurRImhjViqS3wUW/7J7VhutQi2u4/P0roBWE42UwcCLnpH4WC
 OBr3nEGWaYwjQWnxy6HTfo3NFb+0b/RXWnbT5SuHQ9UXGNOD4GiJt/6WgiU8HrPFl20Z
 8ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770081313; x=1770686113;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hUL/tekxYZTVlaXybo6qNTHFQdXyKb3ZbeZaLq9CcUQ=;
 b=tDuA9tnEyfLbTpVpYVZYFgIcf4fYzxndFAMzjQCFCD2PqC6cUgfRpgmo/0/XTSrWnu
 9pNNCteGSFUKF8WobtTozllw1pxwwm7HJ3WopWaGdnTje3edzHR4X7kHs38x3XrFlFn2
 VrX34HKr3KFJQHE+iJojlx1Mruhjc2OcS+r8SsOzrfevnUY7F5rw8mC3x1hSh4hXp1jk
 qgztrqd2PJ2DCX4zR1DWvo12sRBXogDcXEXJznxIio6RHFe2LczR1Pq+qIfmgg5B7GIN
 tpq//tZMvumL0RexngqBy07xAeC9A8XR8v0i90+xWOmClvAeBbIQkbQPdg6hjH5zqr9t
 26ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzI6pkxj8vAxkYx2w669CBogImB9fA3ZtJtF9dbiKikgzAiAzM/OsqajGL5FOB7EzIsbOlRPR3HbLr@nongnu.org
X-Gm-Message-State: AOJu0YwdtNNJJ42DfFSa+KXk3aJsHyxCoH5j4Huph4fNH2SGI0zYHWEy
 QuXxlVGc2J7KseXlpFXovjwqkNpnEpCEOD8ElSnCI9LOzhIZlgU8yfKQQlqPKQEuFDc=
X-Gm-Gg: AZuq6aIcUIJOWbXy755Id72PcwCtGUEwQoRq/yytcl7tjW3W5L5QpkyWssGs+1EtTNt
 qQwC2Xfhi24LFthjNSlgIK+aodhitCopWHBX3UwSE9CEWlhGsRgWnQl2cGIJSKYh+rrpDzyukwI
 2+5tHfS6jjcweoKU0H3tQYRSrc8BVe3waE4rP9XWULjDDRWXd1FMZ17LFc2FPGjKJ/gI57UStgw
 AaJjkqCaVGJ7HqS6tt0qQ3UTQHYb0/BvyzMMi6GQryCDeY4SGS6coDkvGV/NBtxeB7JujRUpX9X
 fZ15DQoypsJMe96HLOzpp4QQlFnkAEnj6e7SGyVDfDgtk/7/vOv98uHJjQCoqG+sFFfDpz6iK6h
 ZyN7yhv7BjIZqaTsjbKwaQhTCZZ26VZm07/zlIcl6RIhhrpz+rm0dB3Qmxm40aKnMkkXh7Qd7uy
 MgpIFuVwBbAmzRv9vJEwPpt5JFC5+iBVPdDZve0Hn/n9+Luce+mOFRNGESBoI+OVWh3NXuTNtBr
 ctYacB9TTE=
X-Received: by 2002:a17:90b:2d4c:b0:353:2e1:95f4 with SMTP id
 98e67ed59e1d1-3543b308529mr11155524a91.13.1770081312638; 
 Mon, 02 Feb 2026 17:15:12 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 ([2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35477615e26sm622939a91.2.2026.02.02.17.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 17:15:12 -0800 (PST)
Message-ID: <7b65cfff-3255-4fc7-b151-80ab284dbc1e@linaro.org>
Date: Tue, 3 Feb 2026 11:15:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-2-jim.shu@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260128152348.2095427-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 1/29/26 01:23, Jim Shu wrote:
> To let io_prepare() function use the multiple members in
> CPUTLBEntryFull struct, send the full struct instead of 'xlat_section'
> member as the argument.
> 
> It is the preliminary patch of next commit.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   accel/tcg/cputlb.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6900a126827..82c9b6389dc 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1270,14 +1270,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
>   }
>   
>   static MemoryRegionSection *
> -io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
> +io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
>              MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
>   {
>       MemoryRegionSection *section;
>       hwaddr mr_offset;
>   
> -    section = iotlb_to_section(cpu, xlat, attrs);
> -    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
> +    section = iotlb_to_section(cpu, full->xlat_section, attrs);
> +    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;

attrs is also present in CPUTLBEntryFull; you can also drop that parameter.


r~

