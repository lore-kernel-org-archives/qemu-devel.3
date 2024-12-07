Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC2FE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 18:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJzWq-0002fF-Ct; Sat, 07 Dec 2024 13:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJzWo-0002ew-Cb
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 13:27:42 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJzWm-0002Ir-9y
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 13:27:41 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f2164a68bbso1601517eaf.0
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 10:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733596058; x=1734200858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1AE2XRTOYwfSiGEyDciwj/dqJZ2o3komGRZtdfarFnk=;
 b=b29qmeiU8+NT1wf233cyDBm90+ae/M1ZoJi+UCbNER6zcyZ1YjAuAWpCaC/9EkwiTz
 5+D2Qk6cLh6KonruaRVOkMmu+f01Zizc9dUhs8rgRvr4vYBWDGiAa1QX7xl9NidtbiJs
 c096xtJOkY4kisFkL3RNualBRGYV2xWO9Hc9InhWcrJAKe3qPeYiDpA8mrpuQKNM1QmW
 m/yBzMSEYGIfVKFs3pqJaHDTejca6mH6YGdpLWUbQ0flDxmsRzsYP42M2BVETQ3iAbZr
 E4HjEwz/Uvx1CnL26ShdBT3vUDHv0LFffpdUkLvKInCUsrDJsGL4pVd2uuaVF1xDQa86
 3prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733596058; x=1734200858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1AE2XRTOYwfSiGEyDciwj/dqJZ2o3komGRZtdfarFnk=;
 b=GrFOkTeKAoOpEpQYmSNSIlRkKIwaV1DC7iO/tKTXxAUZDJXfWYV1lna73N3TpzctRP
 4QDh039sFGfaBVYu/YuIT0DB6bQ5yianmzeClCI9fdlcaDZlYuB8hqNUter8C/QzDluo
 pniQT1x/EB1cLDaXXLa2Z+dfZF19QuWlSXVNaxiUHx0dHOPP7HQPoNPuKJjYPyngetbz
 NlwBRVMPVf9YgMs8RECeSGehOGS7AOL3SKKgkEVP+b5CDm0Hfr35uOtkhA0mW8mt+ln5
 wENrf+GJ7zcl59Z7K44zV6xJYbOgeFjKUIl+UcC8kobfg09CzcSXOkDMU5/zk3vccS3C
 baGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJajmVktvapKvdAtlk7VF5lsUR884HNdeN4EQqT8yik1id6S+CBc69g2PI2+zvZ5yBrTdiGfHV5NEK@nongnu.org
X-Gm-Message-State: AOJu0Yx3QV7p2kosCTtSKuYWhjYzlF2aXaPjmZmhoiw+qFz+we2XzQH+
 jGFaFmRJcbx4kbIkrS0HlsrT0iSZBM06hejXn7y3qs0aEUgS2WPx99b9JwFPCCc=
X-Gm-Gg: ASbGncu4NBKfjiMS/VXupPRnEqTHsD6Jv6Bu0UFRnbj4HXZgO0AOWvvjXRMHoPLgjkm
 x0TGsXSqrvtU9dS97VARvAhtCYVyJhCsmuqrbEVyusVpEg8Bp2eELy/Vm5vx57GrXygJXS6+v5R
 dt4xzmmO6biOWA+0DSCw+46ip8WvTDNQfqDUujeKfl6xESLjQU/TS2+pOghggxSaYML/dqc1IfN
 uRyJG1pnFpNcLA/kAckYGS/7/TAKMowSi2vSFvKbtmpUWEkWrkSv+C9Xgmgdvj+DkTsgbzDgSq8
 Ih7JCXtO9LB6L9wB6epQr7N22Nyn
X-Google-Smtp-Source: AGHT+IE518WKAvEbdYkcUwQc8H3LUqM0/R4D9NdAYg8uH0ddYdwSq/v6Fza64jXpWSsIVcncPYxvIA==
X-Received: by 2002:a05:6870:9d94:b0:29d:c5e8:e41f with SMTP id
 586e51a60fabf-29f731a292bmr6664321fac.5.1733596057945; 
 Sat, 07 Dec 2024 10:27:37 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f569a64a1sm1587214fac.47.2024.12.07.10.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Dec 2024 10:27:37 -0800 (PST)
Message-ID: <7f8d7f1b-8c5d-42de-8d5c-137b2d281719@linaro.org>
Date: Sat, 7 Dec 2024 12:27:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix constant folding of setcond
To: wannacu <wannacu2049@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20241206095824.281216-1-wannacu2049@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241206095824.281216-1-wannacu2049@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 12/6/24 03:58, wannacu wrote:
> The `z_mask` field of TCGTemp argument needs to be
> properly set for the upcoming `fold_setcond_zmask` call
> 
> This patch resolves issues with running some x86_64
> applications (e.g., FontForge, Krita) on riscv64
> 
> Signed-off-by: wannacu <wannacu2049@gmail.com>
> ---
>   tcg/optimize.c                   |  3 +++
>   tests/tcg/x86_64/Makefile.target |  1 +
>   tests/tcg/x86_64/setcond.c       | 28 ++++++++++++++++++++++++++++
>   3 files changed, 32 insertions(+)
>   create mode 100644 tests/tcg/x86_64/setcond.c
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index e9ef16b3c6..e580b8d8b1 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -834,6 +834,9 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
>                                ? INDEX_op_and_i32 : INDEX_op_and_i64);
>           TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
>           TCGArg tmp = arg_new_temp(ctx);
> +        /* Set z_mask for the follwing `fold_setcond_zmask` call. */
> +        arg_info(tmp)->z_mask = (ctx->type == TCG_TYPE_I32
> +                                      ? UINT32_MAX : UINT64_MAX);

I was curious as to why this helped, when arg_new_temp was supposed to be doing exactly 
this.  It turns out we were incorrectly reusing an old temp, not allocating a new one.


r~

