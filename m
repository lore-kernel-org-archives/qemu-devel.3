Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACE5C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBcD-0003kG-BB; Thu, 20 Feb 2025 13:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlBcB-0003jz-LQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:49:39 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlBcA-0006bI-26
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:49:39 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so2008861a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740077376; x=1740682176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zpLBcy+h7UgamPgXiiR6J43ZsDv3/IljAljJGrbqTwM=;
 b=cEic28203b0o3CVnzwM9ekjHcaejSpjKh/YGt+r5TkWRoLJ8IqY8Euh6DTxT7tsvBI
 gJVitWsGIzMnyTjaMzgQ28PPkcmL3x78BL6rKXxSrrQvvZ4CC0LkcX4jS2EhoqiSK29f
 //xxgcR96wyBgj2rmIuvRZVLZ+8lxr7AtA14SsZMF0Pt8SGLKTWZeS4vd5UmBcvYnGgW
 rZFKWlw7BPPREn+MMf1NvylAi785vND6fv5undThKwdnr67IAd3dEiSq7m/8N/pbYVW9
 Yud4xUoJQfxJVeb5DD7gQzh6/33pFpj8ZNjpEiCP7cS5x3yeuZ35d4cyd6bBdKOVRnGO
 AH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740077376; x=1740682176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zpLBcy+h7UgamPgXiiR6J43ZsDv3/IljAljJGrbqTwM=;
 b=RuYOM11bOz7Wn/BX4rJq831Rt7rjTAUkGVid91vOd5JJ0VXfwSHRiQNUrhOcUXTJpF
 HxmEQS6o6Pg58SKgxXzBnGSP+v24N4K7Ho4FzRew5EuwGGLzZMA31qBUiOXYzrGOfBP9
 WfuWXH/V8/SyrVN80QXx/Ta7xE2RfjHjNJ92FgiGqLpR/Mg3EVyUeu7M3Meusiy+GX2b
 gIsQjGDLvatEEty+02BfP85qeuEzjhoeCa4tgfplqlHodaApeIh1WDiH3lXpAxZPhrU9
 eCx4rFGTEN2yoQw7aNvGERcJcEM4G6py6J7Ab7J+t01AH57IbhPjQj4h7n8J70BC8ip7
 ZEOQ==
X-Gm-Message-State: AOJu0YyrzhLgRqdD6hocGpmjnL1Ce2PqqNUOOTfFtAptbH5ePLYnLEBi
 HL5hoSRG61cNb9XOaoZHp/rqhD2IQh0Y4A9IQ4MUqNsK3Fu3wiREpRdvoiTiSo87DfeABdWbjo2
 F
X-Gm-Gg: ASbGnct+HalJE9qlt+JgdypTBp1aE4QDRuqcuo3j9GcXYujakgO9hzvlLF715pQL1Ql
 Ze5R5rdwvLdaJocCat6RZdoqj2a7sbXfd1Oo6/Uq2arKpe3ETTRE/V4RyjIT5d3jfwcBtzju+UM
 8MxD5ePOpz9dd3ZJ6OjY1VIlDOoBFUXeU/MVTaWvaMKXuXMFD1rheKnxqUukdSyHQ3pmJRazbqL
 R/BCSGsbh3Hqhuvpnrms2ZrGWrBp1LSkA9kv+Qif8FvyOiSA10KRmXQm119nStu2IlfElFsUDKM
 t6WaxB13ux2HfbWuUmCyBdzxGlyuS4swwSvLWI//OE3elbgqNXIqJXs=
X-Google-Smtp-Source: AGHT+IGu9dNV+xV/oRkjTVhMHqDAfIopmW4jTfUHo4II4qJNWQpuv6oBKtt02yDSBWyJd4y2pu27HQ==
X-Received: by 2002:a17:90b:4c43:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-2fce78ab923mr419153a91.9.1740077376247; 
 Thu, 20 Feb 2025 10:49:36 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13b9145esm14186958a91.33.2025.02.20.10.49.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:49:35 -0800 (PST)
Message-ID: <97bea0ff-f93a-45a5-b8ec-2bb91e37f143@linaro.org>
Date: Thu, 20 Feb 2025 10:49:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix C extension disabling on misa write
To: qemu-devel@nongnu.org
References: <20250220163120.77328-1-vladimir.isaev@syntacore.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220163120.77328-1-vladimir.isaev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/20/25 08:31, Vladimir Isaev wrote:
> According to spec:
> Writing misa may increase IALIGN, e.g., by disabling the "C" extension. If an instruction that would
> write misa increases IALIGN, and the subsequent instruction’s address is not IALIGN-bit aligned, the
> write to misa is suppressed, leaving misa unchanged.
> 
> So we should suppress disabling "C" if it is already enabled and
> next instruction is not aligned to 4.
> 
> Fixes: f18637cd611c ("RISC-V: Add misa runtime write support")
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
> ---
>   target/riscv/csr.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index afb7544f0780..32f9b7b16f6f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2067,11 +2067,12 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>       val &= env->misa_ext_mask;
>   
>       /*
> -     * Suppress 'C' if next instruction is not aligned
> +     * Disabling 'C' increases IALIGN to 32. If subsequent instruction's address
> +     * is not 32-bit aligned, write to misa is suppressed.
>        * TODO: this should check next_pc
>        */
> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
> -        val &= ~RVC;
> +    if (!(val & RVC) && (env->misa_ext & RVC) && (GETPC() & 0x3)) {
> +        return RISCV_EXCP_NONE;
>       }

GETPC is a host thing, not a target thing.
Both the old and new code are very wrong.

You wanted to check env->pc, but this isn't updated before calling gen_helper_csr*w.

The simplest fix is to make sure that happens in the translator.

A slightly more complex fix that does not require all csr writes to update the pc would 
involve using cpu_unwind_state_data.  See target/openrisc/sys_helper.c for an example.


r~

