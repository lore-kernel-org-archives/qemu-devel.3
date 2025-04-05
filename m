Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCC4C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 08:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zMa-0005Wj-CJ; Sat, 05 Apr 2025 04:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zMQ-0005W7-Dt
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 04:58:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zMN-0006BE-A3
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 04:58:42 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22435603572so26949415ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743843516; x=1744448316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1w/R73rngvU//tt+kQ5UI+yzw8vbeBJQY7PBWnqBBf4=;
 b=SKKNa4zK1MiEcMCd4mrBWYPJlu9LK9l555COvAr0A527PEjTqBmqqRLHXDcscQveWD
 QpMUrfA7L3XamhEpRgaTrwGUrXGZKtm/BDA/f/34/JzYmkRsFXt4MgoVcWKceVbwCmNg
 6oIAZGibw85FDnjFteOo28l144DpE89lNJlw3utNoegDcNA8zDT0NOlgU8CkRv+1HNKk
 TisVYM5QQgPR7KpELNqxBpIpZJ49FsmkytVNlbfbhGrWHg79J3fJbs6YI2DmsOIaP1eC
 xyZOld5Q+H06b6kCsZ4o5tCh3FEh46aX+gCzcQul89j5jYGP8VbZ6ADIK4HP5LLVKT/e
 pGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743843516; x=1744448316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1w/R73rngvU//tt+kQ5UI+yzw8vbeBJQY7PBWnqBBf4=;
 b=QLh/BbvXjVJT9FIBpPZhH6/PYfu+mTPuJPcy4RxswKYeHMR+K3a70qvnRvOK31hZrC
 Jf1TpLCuYp2NGC2CJI7AoaNDvazRCk6jBlWaToTR3bYMENLf9jEVYCMgtxemO1yCeMTq
 KtBsY6Wswr5jhmHVm//86cHqRHv83lP7IbaLwTCZvp3pq4ImeEbVSZ2IcdeJzXw7rqO6
 F4HOgDkgzegKYjF22nsR1vOEhW5p+MiAGixyy1OcZv7tGIXmAUI12D9YKS+HKjizPE2x
 4lKr/3Dhs9QySv2GgbDLAmtUMLhbuyWVKP0VtFqzAqYKqnYZTqFkZh3+be97SspQOiGr
 jxJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbBQ1n2JND54JDiEuutQAaWZaeGWeVrM09gReOPanMqt6wYJmIHW3KYigC6+8KepfgpWdxeXkEB9Gd@nongnu.org
X-Gm-Message-State: AOJu0YyJdZ7Ugd4gAYcN4tgOn9vv70y3f994gFh7GW4J5jPiyFUe21ZE
 Z4KoN8q+Z03xR9BsDtWx3rEv31R6jKbxZYYL4xXjAjsy17YJw5zGwwuTnUb3Kbo=
X-Gm-Gg: ASbGnct17sAp0g+ou5iCR6RV2gNv48riZDueKQA83zMNnRdD10W6dSxXPicuJLTyOs7
 3cMwkD+P+h+bkz0mKgyhQAy95JgvBVGpv+XEFiLEMRydn+BbvExix7kA5AOFqT4sNw3kPB7xpP2
 vvbRPAsheAStI1jEQjbjST7XcDoKwaCZ1sB/HNE08T/TQ0XBtkFWKgY3EHYM1rHA4Te7AaLmOng
 kAQ0t50yo2YLCymqqgj7jmxLhxxPvXv6TdJKn2ZInlPxREYsLfkXSG06WmRdUcGTkwnfu5oscpc
 zE/P/TOZaaNeTyolb4uR+DsvSaU2Ibjc7nA+nKOMtas7GH0gsktR92rLV0i3
X-Google-Smtp-Source: AGHT+IEWCK/iRFz49W+/HhTPtQ+gFgT+e4CUwLN76rDBWPRP5Vt/wf/yoi4Eov0RlthCQFpoaqYrBw==
X-Received: by 2002:a17:902:f54a:b0:220:bcc5:2845 with SMTP id
 d9443c01a7336-22a8a858fa5mr69174215ad.7.1743843516194; 
 Sat, 05 Apr 2025 01:58:36 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978772ee4sm45162945ad.233.2025.04.05.01.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 01:58:35 -0700 (PDT)
Message-ID: <79afb8d1-23bc-4bfe-800d-c341f13662f3@ventanamicro.com>
Date: Sat, 5 Apr 2025 05:58:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] target/riscv: rvv: Source vector registers
 cannot overlap mask register
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-2-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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



On 3/29/25 11:44 AM, Max Chou wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
> 
> Add the relevant ISA paragraphs explaining why source (and destination)
> registers cannot overlap the mask register.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 29 ++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index b9883a5d323..20b1cb127b4 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -100,10 +100,33 @@ static bool require_scale_rvfmin(DisasContext *s)
>       }
>   }
>   
> -/* Destination vector register group cannot overlap source mask register. */
> -static bool require_vm(int vm, int vd)
> +/*
> + * Source and destination vector register groups cannot overlap source mask
> + * register:
> + *
> + * A vector register cannot be used to provide source operands with more than
> + * one EEW for a single instruction. A mask register source is considered to
> + * have EEW=1 for this constraint. An encoding that would result in the same
> + * vector register being read with two or more different EEWs, including when
> + * the vector register appears at different positions within two or more vector
> + * register groups, is reserved.
> + * (Section 5.2)
> + *
> + * A destination vector register group can overlap a source vector
> + * register group only if one of the following holds:
> + *  1. The destination EEW equals the source EEW.
> + *  2. The destination EEW is smaller than the source EEW and the overlap
> + *     is in the lowest-numbered part of the source register group.
> + *  3. The destination EEW is greater than the source EEW, the source EMUL
> + *     is at least 1, and the overlap is in the highest-numbered part of
> + *     the destination register group.
> + * For the purpose of determining register group overlap constraints, mask
> + * elements have EEW=1.
> + * (Section 5.2)
> + */
> +static bool require_vm(int vm, int v)
>   {
> -    return (vm != 0 || vd != 0);
> +    return (vm != 0 || v != 0);
>   }
>   
>   static bool require_nf(int vd, int nf, int lmul)


