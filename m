Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F31FDEE52
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2Cs-0003QR-PR; Thu, 23 Apr 2026 18:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Cr-0003Py-9b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:07:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Cp-00006s-Sd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:07:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so3848427b3a.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776982050; x=1777586850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMIV2i+OE3URGyO4xgT0waGwjqUFAK+EWkaTNEuZse0=;
 b=nxvH3jxVLPFinJLQc06O1BXBNyMmlj4Q6mUo2EFLxSTV8n8d9WkoZmYHW18Cpl9Rui
 CZEUosl/4d5TPx05nb+besB2Hp5iK+E7g2Iq4CsvxZsNMGfflBOQnbNMZMiB4izygDQr
 orX+B5bxZs64Ord9mHMtlF+MEFh2Wi0/2WhMnh0ScHSv7Lpe31cYnuzg9FebVvaNL9N1
 gKp/m0kh7q02/sVr1+RCtF9wlLHjkhWvbv2emBu/+JYAvNgLxfBXBVcX+vrqpUfQQ6Cq
 NtzdP++PUBUFyuud3xUynuL4YxMKwGpFnR/REUCegyyW4RE8kAwZqANV5SJSK4mGT4HO
 otog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776982050; x=1777586850;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMIV2i+OE3URGyO4xgT0waGwjqUFAK+EWkaTNEuZse0=;
 b=RRNuRy64RZHShzestXQcHmFj2t6zEz+lVKlI2VCQibCgPzGlnmKv0GhvN8hew6OCJB
 nybdupzhiOp4cJAIlcUoL0oDKoWTkD+s3JDr9amVcY9jXXWkfxbyMh9UnF4hMJIAyyuW
 0iOdjZluo1GrgrUejVIyWXoul67SlOGafTa9jJrzS55EBbKSkYKdZ65s187hjifXaEt8
 AiHR1wMB9JgMMCdfxXsmfZYtlKWHb9QirBdZaW4e4tJP1MZ5mxoyEFwRsEEuley/VABw
 ED5Iy9b62Kn+RP9ltMuBqWgSiHOZ7OB59r9/cZjAELFTuNZGF79YD99cYdueT7nBDJSg
 uiCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XLFD0XY/fR8dJCyNT7nn/EQ0/6XAWoXDUQZ1BHzT2T3vMcoSmIAmVCOQvISME2qMLcz81OfAOI6qN@nongnu.org
X-Gm-Message-State: AOJu0YzQvTom3Z/wJp/Qz1NSRBnwUB096si782aoPMt4P+ow9HkWyeyj
 QAnDC6a17qlCEx4i59E4pDviNx2cRdB9tv8YqoJVy/QeQ/7QyxPVLuwLFiVYY2dkqDQ=
X-Gm-Gg: AeBDieuYNur7coL+xkDWDTVIVfwFnsJizejwMJFP4BwgeO9TPj1AINydb79Q1aSXPS0
 v2KGLcWzfbs+zmu9h/fEwoBVEAH1UFNXhQxh6/koTaAXXFBTvNCyouMW9yS/F0nqcJttHzneKgG
 ErC29TKUdOdEp5i1IHzhqL/chq/JXmkZAT6ta2XInBz5s0MPzTh2tK9+97UxSAAHKUGMbk3Re2s
 Yht6WlbPH6CsOxweBLCOJ7mNdyG4Cytb70d/sVn6LklAGHBRI7HBgMAQwMOFrV5e9HjuwVzCT42
 5NsG5flQuYxaVEG1CaZayssgjJz9Hrr6Bj/2yt16YnJzusubEjdQFWK6x0yRs58tKkoMUBsewYo
 JWKE467mIwX27K+R9IOLX74MztkqUXjRRVGay+imvqCC+qbm/CQrY3Il4TomdkEAWwcILAJoobE
 kBd+jEb9BJ2WlyL7D08rOLdyiRYlEEl40DnXaPfkw+b9fo1Yswhg==
X-Received: by 2002:a05:6a00:1f09:b0:82f:3828:a009 with SMTP id
 d2e1a72fcca58-82f8c7dd504mr28337141b3a.3.1776982049853; 
 Thu, 23 Apr 2026 15:07:29 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb3fa2sm21411860b3a.29.2026.04.23.15.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:07:29 -0700 (PDT)
Message-ID: <64b4d115-d33f-45cf-93e4-a3ff81741244@linaro.org>
Date: Fri, 24 Apr 2026 08:07:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Remove unused tcg_gen_vec_*_tl() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260423101904.36131-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423101904.36131-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/23/26 20:19, Philippe Mathieu-Daudé wrote:
> No code uses the tcg_gen_vec_*_tl() API. Better to
> remove it now, since to compile as translation unit
> files once we need to avoid target_ulong uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Now this file only defines tcg_gen_gvec_dup_tl(), which
> is used only once in target/riscv/insn_trans/trans_rvv.c.inc:

Queued to tcg-next.


r~

