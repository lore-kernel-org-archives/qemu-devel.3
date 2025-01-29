Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF83C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 05:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td0hh-0001cN-1S; Wed, 29 Jan 2025 00:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1td0hg-0001cD-1s
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 00:33:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1td0hc-0006p8-HP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 00:33:31 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso114729355ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 21:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738128806; x=1738733606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qwsO3K1glESWuZ2JEl/lsipH/yeI8nLJ3iyn6ywczAI=;
 b=eHiQQ0eUdkahG2Hj4vlJVZulkH9+mnkncHLCeMy0TW/hDCC+we6R4Q58pVokSx1xmT
 spT82UftpKLB8qzTyn8zQWBa8009OPy/UvtCvSSe9lzaYyYL2Hio7R5ZaZ+Ac3ijWcyx
 Rysjjw+OsG5nBTJR831ewkxCJJjTfowvg259duEpdUBDpr/zpltiXNL5Lto9xim7DFsD
 VAOEbYWRSay8VC9l6uT1jNE2WzlpP7GoITMpmzhdXFXjLJpOMmsg8ukfLErj+TjHVgiH
 3djZyB5908Hrr/WiRde3MzpI5P6RPAciXQwZAjzQXReA1z1c2GA2YqpmEpzizEUfy90e
 4cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738128806; x=1738733606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qwsO3K1glESWuZ2JEl/lsipH/yeI8nLJ3iyn6ywczAI=;
 b=sFUgyrND4xRFqxv5ctYuxkgVuztiSrrLJl+etZtg5UQwIwOP0wOY+lOU4YNdtZUgR4
 wXj/sJBgAVx6VReYtoYiafluN+sC3FC7mYCZigINqOyLwLvpJz40t1YEkIDkJ6FpNnAa
 hEi6uAqJg3RQXzTNfwl97qE3NLr1966+jIfvCssB/J9IUQTOWiFaBTi967mns4bDQTkJ
 EIIiAmor5ZoHZQ8JBCB7ZKJCt78kBczXndSA5GiAT6MhGa8yIzU2P1N2CzZPPRWteSAH
 w/yVUUeX9kUd21Ze14gohuL5j0Bz4a2mBWJOaK95BJ/VUozAwWaKx3ElgT7LMk9cuOnr
 7U7A==
X-Gm-Message-State: AOJu0Yy234SZB5KunGIThG3IRgUHpmXtXwbeZMD3KZQcc+xuRflEoWoJ
 E65sSODfrpQzBEeEC0g37bxs5046ns5/oG7heEp4xZ7e2Lwbpbrtnb7DZ+qEviY=
X-Gm-Gg: ASbGncuFXLc+sj9TRfpvIVuK/tfeAtajhxcZwc+sW1zBcSawT4gRKIH1/Yfnd/gOPgD
 yRp8NGtebku7vbjTu5Q37qqohTcIeLU8c4IDe7wgsSRcXN528o7PP7c5KN+0e9jfFDq8K5hoRaX
 RIiafWrzbVzKus6OHX3ZM9MR+8M+US2Z6wKqgKD/8M1ZuJhq+zj/WqJZ8mjem0PeMFE3qSBcit0
 GEGKYgC0qZzqX6afL30tvq3fxT5IpgqujS0X/ApLTaa+rP7C/xLgf0O9hqbZ2KAi31lsFp56NWg
 gjW63qq1Rv4Ne6is7CZKGd2N6/EOMNEef9lbuFwYJQSGegy4FJa/Lyb2JQ==
X-Google-Smtp-Source: AGHT+IEJ1Ghwfm/evl/4VqxK8s+diOXBkhoG/1DLfr+1J6IuciV4cwmFzoGDW3d1wihsFU1yPXTkew==
X-Received: by 2002:a17:903:41cc:b0:216:73a5:ea16 with SMTP id
 d9443c01a7336-21dd7c66121mr23911505ad.21.1738128806288; 
 Tue, 28 Jan 2025 21:33:26 -0800 (PST)
Received: from [192.168.0.4] (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac49717de96sm9321251a12.77.2025.01.28.21.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 21:33:25 -0800 (PST)
Message-ID: <ccbf7be1-db49-4eb6-8ccb-32bcfd3b380a@linaro.org>
Date: Tue, 28 Jan 2025 21:33:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/hppa: Implement space register hashing for
 64-bit HP-UX
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-5-deller@kernel.org>
 <34f4e42f-b08a-42dd-ad11-f720f6d8a440@linaro.org>
 <6f445eb1-2626-4a08-abbb-580cdd7fe682@linaro.org> <Z5mph0gdQHbCsKit@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z5mph0gdQHbCsKit@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 20:07, Helge Deller wrote:
> What I'm not sure about is gva_offset_mask in those hunks and where you
> said I can't read from env:
...
> @@ -4635,6 +4641,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->tb_flags = ctx->base.tb->flags;
>       ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
>       ctx->psw_xb = ctx->tb_flags & (PSW_X | PSW_B);
> +    ctx->gva_offset_mask = cpu_env(cs)->gva_offset_mask;
>   
> Do I need to change the code in form_gva() to read at runtime from env
> instead?

That's one way to do it, sure.  But it's not so hard:

#define TB_FLAG_SPHASH  0x800

void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
                           uint64_t *pcsbase, uint32_t *pflags)
{
...
#ifdef CONFIG_USER_ONLY
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
#else
     if ((env->sr[4] == env->sr[5])
         & (env->sr[4] == env->sr[6])
         & (env->sr[4] == env->sr[7])) {
         flags |= TB_FLAG_SR_SAME;
     }
     if ((flags & PSW_W) &&
         (env->dr[2] & HPPA64_DIAG_SPHASH_ENABLE)) {
         flags |= TB_FLAG_SPHASH;
     }
#endif
...
}

Now tb_flags is constrained by both inputs to update_gva_offset_mask, and you *can* read 
from env->gva_offset_mask.  It's guaranteed to be the same every time.


>       nullify_over(ctx);
>       tcg_gen_st_i64(load_gpr(ctx, a->r1), tcg_env,
>                           offsetof(CPUHPPAState, dr[a->dr]));
> +    if (ctx->is_pa20 && (a->dr == 2)) {
> +        gen_helper_update_gva_offset_mask(tcg_env);
> +        /* Exit TB to recalculate gva_offset_mask on %dr2 */
> +        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
> +    }

Better comment:

     /* Update gva_offset_mask from the new value of %dr2 */
     gen_helper_update_gva_offset_mask(tcg_env);
     /* Exit to capture the new value for the next TB. */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;


r~

