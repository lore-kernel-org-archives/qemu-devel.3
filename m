Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05356F8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDa1y-0005cz-Jf; Thu, 16 Apr 2026 23:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDa1x-0005co-FO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:38:09 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDa1v-0000EY-Gh
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:38:08 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so1453795ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776397085; x=1777001885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AweiCWyk/zfOmCKKyvkWh+KQwVLfNuJB1A6SAcE5MqY=;
 b=GTf39ZKmzGWOpsb3oHMITb47QC7hPSNuD4qlA1wLmHK8SArQo9OsF7jdN0814XY9a6
 S/gD2Ghw3vMs9Lcjq8wLE1nqeaV0FiHEXvn/9/In0a6W4z5nBGO5FZr+4rK1Dg7w5u2H
 LGMxLaySMykel0tt/bbG3d69uS7WYGkIlZ45cGlr+YLXywu/6UKkHQFWDnyqcZ7/h8lL
 PUZ0RW6Z1NdXwZ5XFTmR85N5Kdt01eMPPQc6WrkavsRBlPtfgeKNEFd+P7A567o+doRt
 SggLCiWYbm1aJCOQDrLN/UxKTQN23O2TX0f4DkeEwG/HzVKSujCWZeekWhbTK+zWJOTC
 YbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776397085; x=1777001885;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AweiCWyk/zfOmCKKyvkWh+KQwVLfNuJB1A6SAcE5MqY=;
 b=AIICZZ9rt0IQ8hMU+EZbr2P4Xd5q3KjJ3rdWXDTV+OMxyTEzGEqfFM3aLf+kD9ZZ/p
 nPWKyFkcqgQ7QmU0WmOtgqEbQgPeyz/wShgyXhOfcMjYCMI9UCm9jUVaKCKXUM9cnXeb
 UA2dh+T6U5dAwOXNT6CMvdRbZOfnWWG5FgtepPd25WBO8m81dr51sWfyP1WUfSIsQ/Jj
 32rHjDU5+7ZX3sYVpm1EaX+PcEZhGmd4UWA63RNEFfII+KHHdy9nBI2o5YkEzfem2nWV
 KTjCair5Z51PghJMzZ5GAUm57IbU7iY9WGdNH9IRWMVg/cqzS15Izq/GWcYgzYLvL+Xt
 a1eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4mU2wM0hYcPgR1hyvMo48MDqHOXAEwY3qLSVwpMqVrSeWm9lWJF0hLBBYR7USVx0TH7nJ8S9wdNLz@nongnu.org
X-Gm-Message-State: AOJu0YxwEuOrYrxgkn0zchJPhiXZbr07oPN4Qg1Mf6lXjlL8cg36wAxc
 lcxzgaCPENSucSx4PKCISiBXLbM1ND0AeeUM4ZG9KYziL63sj5vcKtgc5BiZU0rT4i4=
X-Gm-Gg: AeBDieslnQkK8DrqdJnK+H1XID/le4A7Y5JwwFvU57JVGLjUQZYtSTw0DzDJ6gwhUDg
 hFZEneaU5XKRF8cJg/msGQO3JQfyHkB9Xg55Fd/gUDfDfGGsQqluIGf2LXcO+/fLQywvGuYOvvM
 a3gVyMEs+wmqipdwoP6iL3Oj+wDL6LL+PvIdlb49PrRmMbFDrLzimZqg32xt92GUjzDDFZAdNfa
 YNjYf0pK0a9zF0E3Wcxnj+I0oHTwGJ86l83VfuiHk7rhfLQphbuypR/fOTeYmyS5dsz4l5UsLrA
 EZR5Pz1K1XBXLLIz9N7DYmX+chjMZkI9V5Dua29rD01kjGumUPx0HLYV+m/ReAVmfi4wBLXUfJD
 8I3H0lkZiwhQbAYXDRk5m9mIXN0100b+lGgEtzn3aiRyAuRZNuHYPNUr5CHQVrtqoXwtM7FY337
 4/oQEW+Tj5ssaCGnqG4ckiYlsmA01uVWd6SVy4Kgvrie5tqcpStS3+7p7fzUuQuHq6tqbHFp9ei
 jOm39l2BDku/u/+pwt7osezESEAD2pKwmgn2x9CL/3MV3bO2kw077okj1bThcPUvudy6oX3fTzy
X-Received: by 2002:a17:903:2acb:b0:2b4:5ed3:415f with SMTP id
 d9443c01a7336-2b5f9f05bc9mr12209725ad.18.1776397084631; 
 Thu, 16 Apr 2026 20:38:04 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:f070:5202:7f33:1d99?
 (bg30dj09r5ydzrv5fbt6.ip6.superloop.au.
 [2401:d002:dc0f:2100:f070:5202:7f33:1d99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab405f3sm3852475ad.78.2026.04.16.20.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 20:38:04 -0700 (PDT)
Message-ID: <fce1dc36-2024-49a9-acbe-51422169b407@linaro.org>
Date: Fri, 17 Apr 2026 13:37:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416210508.30686-1-philmd@linaro.org>
 <20260416210508.30686-5-philmd@linaro.org>
 <bcbfb47e-022b-4db5-90d9-a91599ed227f@linaro.org>
 <4aa2a069-a7c3-48cd-b8ca-4b03adaa1227@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <4aa2a069-a7c3-48cd-b8ca-4b03adaa1227@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/17/26 13:29, Philippe Mathieu-Daudé wrote:
> On 17/4/26 01:07, Richard Henderson wrote:
>> On 4/17/26 07:05, Philippe Mathieu-Daudé wrote:
>>> Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
>>> Pass the MemOp alignment as argument to gen_ldst_multiple(). Keep
>>> using MO_UNALN for REL6 decoder but use MO_ALIGN for the pre-REL6
>>> part.
>>>
>>> Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
>>> Reported-by: Richard Henderson<richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>>> ---
>>>   target/mips/tcg/micromips_translate.c.inc | 16 +++++++++-------
>>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I'm not sure about our testing coverage here; I think I should
> use default_tcg_memop_mask in a previous patch, see
> mips_tr_init_disas_context():
> 
>     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
>                                    (ctx->insn_flags & (ISA_MIPS_R6 |
>                                    INSN_LOONGSON3A))) ? MO_UNALN
>                                                       : MO_ALIGN;

That sounds good as well.

r~

