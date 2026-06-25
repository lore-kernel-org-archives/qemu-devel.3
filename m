Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1193CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsG9-00042J-U5; Thu, 25 Jun 2026 18:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsG8-000422-Pn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:09:20 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsG7-0006Qv-2k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:09:20 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-845c65e0a10so66920b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782425357; x=1783030157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ybh/hPDXlwYW9l69Hfeg6W+7gC/szGgEXmhIOniOMpY=;
 b=My+EPbR4FPhUbOFpdUNeA8zkKgCu99whPzuGJT0rK2qCPhnGSdwnCIRuWSl1tGu8Ir
 nYTQfqAmHfGSds8wydkBiVv9rqE9udAQEphfadgfN2WqjepEGB/2pGvirNEcWtv8ykXe
 6hQlYee6I8CGDRxvWOVCq4XTq6ObrxebU/yzyZAPISo2D59P3+5vV3gI2RxBoy/dbCnA
 tJthDplpar0ubF9l38eiC+3RfTT7Q6XIFcQpmqdzyEOsmZ4dWSNQO/tERMEca/zUyGD9
 ECDYXTQy/3kPSL18Le8E7xftI+7EEth+YApter0609e6YFVj9DxqDYTdbULOAt5o9iU4
 w1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782425357; x=1783030157;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ybh/hPDXlwYW9l69Hfeg6W+7gC/szGgEXmhIOniOMpY=;
 b=UVVw8uyHs98sllzT/Q0ktcgLHsgtWDJdMPbvqMdT9tYLekK7KX/eI3qDRu4kN84J0y
 vzGEcczAH+IHyyhtFX5Tyb9wkGDHextw2BTNrmbtv1SRknhG28zM8n0DX6mYd7oNNYIZ
 LchdEEQGnDZH3LOTWvckynSJxLe9VcyArDN8Pqa4S4SDS56OkOnE9zAEwinDbA2GCgep
 d6f6oZd139yCPVNkPrJZZKZi/QJe5L5kTtSgOaZoiQdBN1jBu8aTfv6kCXJQUyF5TS2I
 zsClAhUiwnY3kyi1NP2Bugh2pOizuL/U3sof7mgLJWLvtgCW16BvIKlhBOeW9oe2+jeT
 6K2A==
X-Gm-Message-State: AOJu0YwTf/18QA/3Hdf9ceID6y5YNm2rVOCD/VBsOT/7WE5W1X6HK/cx
 3GzGr7x9M3GFj1KLRIryfsQoM8fBS/ohqrzTMV060fNvyoQM7j8KQkat/Yi+QOiSCED3MEagV9N
 qKeAu
X-Gm-Gg: AfdE7ckXlMq2WswSji9Ugs3WiiJkbBp6GNwff3TsXeBOS+DdvFSArYcV7a+YZGctT1j
 daCnTfXz5MyDAS14rn+nB4NY1WL748Fbo/WpQh9IDdVaIkwkADmO4BCJ/5wLJHNAGsehrT4P2cg
 Z4lfK7Nq2RqKYevKzvZRgCwd8AqwG5jXC+QwqCA4+JzSVJRMvpdk/+9Fssl0uYrD+fEI/lwlGXO
 cYruEPJwVRgYx1e8orspvZycTr5J8C8H8MfFkX7Ym5qTB3DzMc/YQWEEjtHFkHWx8H3dB771vuE
 PaGenwqkdHdFeCAl5eepSf7f0/7rrEbg1MEX8q3ypIhrn22d2f0cB4KTOox+cblvqn8Ux38nFcg
 tfGYpUrPKA3Yhurt6M6oedmgI58Nr3mJTAyoT0HdtYvxyer+8Os1RNvc39rDfPRCLt1eSEiH7pj
 4Ie2XtYV7eJO1Gjik1dhdrXDGwX08ax5D6Dc1nhVBJHdt6a0I22+SJW/Jnww==
X-Received: by 2002:a05:6a00:94f1:b0:842:4327:6cfb with SMTP id
 d2e1a72fcca58-845b3b0411cmr4619990b3a.46.1782425356780; 
 Thu, 25 Jun 2026 15:09:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a411942asm5370279b3a.48.2026.06.25.15.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 15:09:16 -0700 (PDT)
Message-ID: <0274637d-77e4-4426-bf88-768ee821968a@linaro.org>
Date: Thu, 25 Jun 2026 15:09:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Update cc_op for SAHF
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Ping 2.

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


