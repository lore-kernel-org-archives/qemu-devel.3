Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6840ACD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIlv-0002s4-MX; Thu, 18 Jun 2026 15:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIlt-0002rH-OQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:51:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIls-0006VF-1Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:51:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2c6c57c5c07so10318685ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812286; x=1782417086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d5DX7P8J02HmVuynmoA9Z25TdOCgeLM2Zyu2GhUUhAw=;
 b=YmrzsYR5IEYvM943DDIzHko27j0I/ET3xbfLJlwwwYAORtIs21gGubsEipnPrxrMy5
 PBn+xHtredkcw6FiUgG5NeM7JlAcN/ddhpe+P9q1lI6pC53fsKigcBMq3TlxrXE4O9Ub
 iikUV+3OSoWkqPygbmx5uk4kW1OjsQDSuJPlrf8NkGcnINoVuLb2KGtD6OnRfoBdv33Y
 JDF8eBfGReb8tj1LmJ1yOq3RGne+NPt8OYWnan4ASdAoabTGmhuuqGwRmTHZa3oTf3FK
 UjfOvXi4F0kWtL+2qUcTiKYeday948G6HG+XPhnDXrVHrniH61zv8EqBSPXy9uigwB4a
 WN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812286; x=1782417086;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5DX7P8J02HmVuynmoA9Z25TdOCgeLM2Zyu2GhUUhAw=;
 b=l6tbKH89Mt/vi/KerzHlzF0c5nBQATZVdSPkNbf8K9VDjx07gXtUGJOHUnX5uMxFxO
 NUzwujlFmFKtAsmdbwUZK/9ckN2zOPsUe+Rn6FZD0n2K9FGl5Tg4V6WnGuLB+ji32jiH
 5oqQ64cTL9j+QO70L6ZWh6BWNC/etEntOn43btcA4oegY4wg2Ju5jLmWulTRvhhWkhus
 Z5zgtK1Y6bbuwHRjRehrInDaUWD90F5H8U4tBaOtDm7atP/R493Y9QRJQm4VZUQ/rjC3
 cXI00YgC63s2ZGwk1WnLJ7+6keVx9GBuvXkxRKlc4vUW21UgKavPlhBYTYHarLg9i0wG
 ogag==
X-Gm-Message-State: AOJu0YzcglKJyy+dMKTFbT0EOKkW7sN2OHUWChoMu1rybooiF+1R7gXb
 363e5OMELu6ZJ892UZgMpEV6TDWuyiw0UUyCkhqrVa0EmzHexup6n+6/ezp77qufO3bOHSyEgIv
 Uih7d
X-Gm-Gg: AfdE7clxMn1Z/rQ9NhM/yqIlKRjF37LGv17voMD4tXebJqfqWd1WrzwO9kAk6fC/DjT
 ds7XayzJkwZx0cZDw93uIoG8O1QHDImxX5Tm62O0Fl/4AFPX55SpIGJDdzDGB4eGozSdHRQsv9u
 Lh6pr+RVYTe1DKIg0d+reDS7INAPdn11/pRKB2bj5EJpg915O0B2aNk5qefOsVgQcIkwrSmNpqw
 aj5O5pqvQHPtsvQdp3yToY0lKAXDISCKvqPv/CQVzmjuHTOdvJfcN/buh7WjwfvzaF365Bp3vcn
 m0deSiS34XqtyDQo+nqggYGfKsbBHbEWhdN5NwWCiHVVVDun30u/Vzrwl1PKZCe9BtUBvMTtCa7
 61rdviKs7PWo7jO88oX4c2R+uQDi1KNVMz8YxTWxwcnD5rV3KHAFTuxDbCLGKfdGV4IHfFy0yuK
 7qpegGz4kXC3k9xZcu3A4D5YXxeOXhWhUwb3jQG0gdr5sFqaV6j778n4qcEg==
X-Received: by 2002:a17:903:22c5:b0:2ba:4ad9:70f6 with SMTP id
 d9443c01a7336-2c718f953c5mr6320435ad.31.1781812286422; 
 Thu, 18 Jun 2026 12:51:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c6b3c3a213sm92249405ad.40.2026.06.18.12.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 12:51:25 -0700 (PDT)
Message-ID: <d05214ee-ad67-4ae1-92c2-cf2b83db2909@linaro.org>
Date: Thu, 18 Jun 2026 12:51:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Update cc_op for SAHF
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Ping.

On 6/8/26 17:28, Richard Henderson wrote:
> Removing the call to gen_compute_eflags meant we no longer
> updated cc_op after computing EFLAGS.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: da7649c6aeef ("target/i386/tcg: do not compute all flags for SAHF")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3537
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index ce636b6c56..59948fe64d 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3768,10 +3768,13 @@ static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
>           return gen_illegal_opcode(s);
>       }
>       tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
> -    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
> -    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
> +    gen_neg_setcc(s, JCC_O << 1, s->T1);
> +    tcg_gen_andi_tl(s->T1, s->T1, CC_O);
>       tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
> -    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
> +    tcg_gen_or_tl(s->T0, s->T0, s->T1);
> +
> +    decode->cc_src = s->T0;
> +    decode->cc_op = CC_OP_EFLAGS;
>   }
>   
>   static void gen_SALC(DisasContext *s, X86DecodedInsn *decode)


