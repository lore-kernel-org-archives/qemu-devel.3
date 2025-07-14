Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C88C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNfp-0006m6-Lt; Mon, 14 Jul 2025 14:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubMgl-00055I-Cw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:10:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubMgi-0003Eh-CA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:10:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23602481460so43240275ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752512998; x=1753117798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNN1lvm+Y2jpleCJEcqOLiMG8jaqVBdTzjyRJ3A18tc=;
 b=vDGtgfYwpmA0BLbe8o2T4nr2ebzi9ljTFvXQVhyctl72tPu/S0NtvL8vwAckr6TUJr
 oc+gAmxsyS4H0PPi+lxwfpuPnGiE6pdKYdTnb3F6yoDXvcIL+1VcPtLUr3/SFn1Bf22S
 n7SWaGnv92K566iT6HTxFqqJfVLAiKSCutv0FprMcFeRuD8oAwmQzMdpgZabtAN1Ew9o
 mGYZDN4FuMqOoAtpEe/7TgWSI1CoHZlgSm46CptQTzXTf0Rz+lJmL1EM1kjKld8wHDXu
 d5WeO4dq3EE8mKNUvgE9iLVKHeXbgLy1pnfakpmQU4m34Au6PwWdmdJlNPqF+uCrNk0P
 YMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752512998; x=1753117798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNN1lvm+Y2jpleCJEcqOLiMG8jaqVBdTzjyRJ3A18tc=;
 b=oilaeYiig5Ostm0XW6cv/A6VGtYIuiSUT8FzKnxldl4gPn90hnHtBGAMbmd/3Hoq9E
 yqbnciHoKdveiFEHTgE8pEuhsFN8+8+CgfQszaSWePdqo265LjfPwv47MqXkAnYJxzx+
 IfVP+VBWrcDdxqIXyEHbPv0Z+PKj+gom9IdSfFu3SPASqGtj50GonMi9rgHXomH9oTqw
 qM5etfRxGqQhvt1qmerDVndcChUiUu/LVCnqi2klf7/irpDLmtl6ghlzMf5/X34efmZK
 JEzYv6WPogLpK/Pq7VxXHrfg3aNTUcVb5ayxP80goracVlE65BUdMmRwleo/a9v2hxqT
 CmUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwhSeaGIHEGHSgphuD4INpKf7mMSKMM0Uef2Jh/uAltAYNODQ8V/H0H5KSVvoW9kcAt2szMc9eiRkL@nongnu.org
X-Gm-Message-State: AOJu0YzEDrm5IgmZ8yV0705JaqX+z1lWsO2YZ8d9BrCzSssb3H5Sq4v0
 0vvYuIsbf0F1v/ARl4HhHE3nAgEb1GiInrQm7HonhT1KVgrsMgT92ddnFTaV8JIiRYU=
X-Gm-Gg: ASbGnctK9mX5D1A7+geh8y18teLuzslSpVVFsCwfATCd1Y/SV7t6nZuHu73BsMpPIz0
 In1KcwNmVTPZ0aCGtjn6wpnil+CAD9iQ1vGGEQ8t8iPLiJE162o6HFd9mos4n1+Vl5p4QOHwEyr
 wpOO3qoj9E9MMMoXVZoYfeEImGgMgBQeYn+C5D4nHy93jG7LLe30dXdTSARAAol/ED4FEXS7tHy
 NDIQWDJWgoc92i/gr1Jv/tk/AuERrFK/aQJAEij1PrcYpV5FqOO9snuEy+8sI6IOU+YsZIeyDg6
 AnpMbcXPDRCGJN03BRFN/C+BOk2arHAGYeF1vST+77JQllYLdlBHjOkuNx81VJE+NgG9CQ4NL0w
 qc13IV31BztI1tO9IjP3ZgRpjIYFU3lE5GT0=
X-Google-Smtp-Source: AGHT+IG6sXBZYTHHFZUmPuGrI304YdOobQl274T8IcD6F7DDcC0FCASMIyNZsoChpVkR1jtEL9SqUQ==
X-Received: by 2002:a17:902:d584:b0:233:d1e6:4d12 with SMTP id
 d9443c01a7336-23df0807799mr139975665ad.13.1752512998382; 
 Mon, 14 Jul 2025 10:09:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c220f0be0sm7239405a91.0.2025.07.14.10.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 10:09:57 -0700 (PDT)
Message-ID: <97292e35-b7f2-40ca-aed6-34ef39396433@linaro.org>
Date: Mon, 14 Jul 2025 10:09:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] target/arm: Add FEAT_MEC to max cpu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250714155836.1514748-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/14/25 8:58 AM, Richard Henderson wrote:
> Changes for v8:
>    - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
>    - Enable the SCTLR2 and TCR2 enable bits.
>    - Squash 3 smaller MEC patches together.
> 
> This still fails the RME tests, because we still need TF-A rebuilt
> with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
> have just done such a build, could you re-test with this series?
>

I tested that on my local Realm enabled setup and I can confirm this 
solved the issue and current series works.
Both flags are needed in TF-A. ENABLE_FEAT_TCR2 is needed to boot host, 
and ENABLE_FEAT_SCTLR2 is needed to boot nested guest.

As I'm off today, I'll update that properly tomorrow when I have time, 
and not rush things. I'll update RME images for sbsa and virt tests + 
device passthrough test, and post associated patches.

Thanks,
Pierrick

