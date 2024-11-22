Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5451BE69185
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXyC-0002L3-Jx; Fri, 22 Nov 2024 13:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXy7-0002KY-Pp
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:01:25 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXxu-0000iz-Ci
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:01:13 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e5f968230bso1192937b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732298469; x=1732903269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hJcAIFg1G/oIEynSgKhmMgbXnNk+qMNk6i+6+uzSWuU=;
 b=Ey+1wgmmjbXlBLMSXA9/l3HbzWlD37MtvoiM/5r+pAWGwf+4vMVRm9HmBc9kLf4lOE
 sBIq8HjpTyFkYvO0T2sqEfN0bW2KBeuGBVC1tzixzsDFNMj/epAaLEkb3b1+vKXdjGY6
 aSahtlgIjs2kkzZ4yE+w328rELm/JWUPoCcAWW++3VRDqEZi24K5kPUZlhB4pwcHLTev
 vJ19mmVEJd9HHcZpmlTKqpLUUIp5eV/bPUozUDwBkLxmoe37Jj1MIROTibPyA3pymtGB
 xUYz6h0v/MknPKm4PspPbgmEGI4sVx0EviPPu5Ot4SpLEx5AnHnoJ6cJCAvmbsA7jORB
 RJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732298469; x=1732903269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJcAIFg1G/oIEynSgKhmMgbXnNk+qMNk6i+6+uzSWuU=;
 b=s1ofssEs+KB4l8/5uapVmBmKBzEeyQe42Be4wON2AZnW5LQXK1v8vFHSxO/p2gnoPO
 omiqxoAFB2r1JCb5c8FgIb95sy9cQdF4Cq2kzhe0QcFpztSOj/In2PvGwz5XmLRl+0y9
 4Ljz9zMM1QejXWuE/hFw65SaxOdEs01pFyGiEmS5guHuKW8liFYC2BPvmScDXZ5GysMm
 bG7IA6FnGn9ElkN0AOcFcKdlKpQ0Riq5LLyfkhhrFU/jBZ49eaPK+WKCvm9cyTYFqQxy
 QWhP1HEUZ8CZdiNNONDm8CHughLueVE6b8g2EuD5p0SgZzeKwBin9/v1SFT58sNo9Uj5
 KOpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULg0GemoUi8j0Wrw/MI/dM6XnIiHXsgL2p01a3OBfYi+D/Vdn0p9UyLKQ/I4SvBMB/dbOIER5cTUk/@nongnu.org
X-Gm-Message-State: AOJu0YwVTWtXE4j9ocZTHjHUzSiuIauZpY63NEmBl1BbdrEQ1vz/2+zL
 JALRHpscHO8+q9HLpFQ96Xwekit/q1rTV0XJMkPGXBDWpurqriuYWEyby1Ouabo=
X-Gm-Gg: ASbGncvIzKnOvfrCptQLfYoRNXnpjrYR6VJsqBoI+pNOQVUJx/gZyvcOJBHKXjo5SOd
 S4L05kN7X+yQD9XCnb65U/umN1QK8hTo7QgBatoM5JHae3kV3dQ6Vdz+ul/t2da3SvSzsqJ4HTV
 Pq6EJC+EXzPyMdIfm5JclHOinr1jpTLFWZ+HXUThNwWwlqyCaSUTJMWovtSR5w0HCxfSpUbRtFP
 jkqRPjQWa3Y338iTqgCq/yRHeqDFTERt63fl9+nHaCT2lLWVHRsslGhwmqLjL3EVXsMiC4=
X-Google-Smtp-Source: AGHT+IGZ1IO4YBA6yG3ICJQ1ZSkIurt84nBeyjVrxUFvn28iAAjGadf8Kkb1Ugds6XqDaEkyDRuFSQ==
X-Received: by 2002:a05:6808:1882:b0:3e6:1057:21af with SMTP id
 5614622812f47-3e915af0592mr3562594b6e.41.1732298468859; 
 Fri, 22 Nov 2024 10:01:08 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e918632fbasm416119b6e.0.2024.11.22.10.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:01:08 -0800 (PST)
Message-ID: <a1e76d49-e307-4718-987a-839e0cbe074c@linaro.org>
Date: Fri, 22 Nov 2024 12:00:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/43] tcg: Add gvec functions for creating consant
 vectors
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-5-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> This commit adds a gvec function for copying data from constant array
> given in C to a gvec intptr_t.  For each element, a host store of
> each constant is performed, this is not ideal and will inflate TBs for
> large vectors.
> 
> Moreover, data will be copied during each run of the generated code
> impacting performance.  A more suitable solution might store constant
> vectors separately, this can be handled either on the QEMU or
> helper-to-tcg side.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>

This is invalid because generic code does not know how to index elements within the target 
vector, which this is doing with its per-element copy.

The code in target/arch/ knows the element ordering (though I suspect you have not taught 
llvm), and could arrange for the data to be put in the correct byte order, which could 
then be copied into place using plain host vector operations.  I won't attempt to riff on 
what such an interface would look like exactly, but I imagine that something sensible 
could be constructed with only a little effort.


r~

> ---
>   include/tcg/tcg-op-gvec-common.h |  2 ++
>   tcg/tcg-op-gvec.c                | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
> index 39b0c2f64e..409a56c633 100644
> --- a/include/tcg/tcg-op-gvec-common.h
> +++ b/include/tcg/tcg-op-gvec-common.h
> @@ -331,6 +331,8 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
>                             uint32_t s, uint32_t m);
>   void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t s,
>                             uint32_t m, uint64_t imm);
> +void tcg_gen_gvec_constant(unsigned vece, TCGv_env env, uint32_t dofs,
> +                           void *arr, uint32_t maxsz);
>   void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
>                             uint32_t m, TCGv_i32);
>   void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 80649dc0d2..71b6875129 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1835,6 +1835,36 @@ void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
>       do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
>   }
>   
> +
> +void tcg_gen_gvec_constant(unsigned vece, TCGv_env env, uint32_t dofs,
> +                           void *arr, uint32_t maxsz)
> +{
> +    uint32_t elsz = memop_size(vece);
> +    for (uint32_t i = 0; i < maxsz/elsz; ++i)
> +    {
> +        uint32_t off = i*elsz;
> +        uint8_t *elptr = (uint8_t *)arr + off;
> +        switch (vece) {
> +        case MO_8:
> +            tcg_gen_st8_i32(tcg_constant_i32(*elptr),
> +                            env, dofs + off);
> +            break;
> +        case MO_16:
> +            tcg_gen_st16_i32(tcg_constant_i32(*(uint16_t *) elptr),
> +                             env, dofs + off);
> +            break;
> +        case MO_32:
> +            tcg_gen_st_i32(tcg_constant_i32(*(uint32_t *) elptr),
> +                             env, dofs + off);
> +            break;
> +        case MO_64:
> +            tcg_gen_st_i64(tcg_constant_i64(*(uint64_t *) elptr),
> +                           env, dofs + off);
> +            break;
> +        }
> +    }
> +}
> +
>   void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         uint32_t oprsz, uint32_t maxsz)
>   {


