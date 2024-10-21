Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08862D3C935
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2wFr-0000Zt-56; Mon, 21 Oct 2024 13:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wFp-0000ZI-8o
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:31:41 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wFm-0004Gk-Mp
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:31:41 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so3871651a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729531897; x=1730136697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=htmhe3uW6BEe0N2w6YHfI1YKOHTFcSo6L6OVyV6OVk8=;
 b=VEgyGPasKAUiB9b/ckgnBS4jDadXvkl+v2PK6Z2DcM4iWmdR1Xk4RXuGTbxuKB9Od3
 JGADZjJ0hQxz2xqszlGXbBdlfsNLAMywrRLZ+zAsCc69VQ1A9xlZuHjkTQQEhPboIxdG
 PNcPc9zsmSDyGZglvc3+/8iVHBx88pqvYoNf3grKitBMDvEeExal48qUqgsdqgWTnq+Z
 DY5tSbrT/veBy4efJG+03sd2DZSCH/QDxc4D4dlSrEcAyq+VQTqm66EQ7T0OgCrCSRRY
 VvOkuAk/fBD5kKKikFlyN1xsRfXl7hB1WFKB1wlqKnYhYTYphLpQsBc2DzjZD10hzdOu
 jNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531897; x=1730136697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=htmhe3uW6BEe0N2w6YHfI1YKOHTFcSo6L6OVyV6OVk8=;
 b=EiapJFAL1yghxMH0BXlveQPirJzavNjoMzBsx/BSsRq6uGywqk5o0xVI4KXfg/Clgj
 9xHcoKOQnpFonVGYlbZpfrEGuNTWVKqqnFv6PNjMILOp9mhX+d2JhLXS9UFQAbGQWMNi
 MPBJvTWWILUdeaeTxxPc7HWPFcsBAw7wOos8ziQ7tjK0xu72Lf2AVAikrnK4+MEuOSO/
 CKUXnrADHyZt4NpAU7Ya1gE6h+nmPmUKIJADUcVErhiKDuw4xLidZHnnZmm9vHxRyirS
 Xioks0wfpgurpzqHAFgDfZP1Wqb3iilwo7Q2gembkQuSkDR8CF7On7ZLF5NMGyHoG0Ly
 uyVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCYBG3vqnQNIkIIJgWoB61EmLENc08MNRGzHCdmADntByn8YUh3d67uhxznnwa0nHVnqhTzQh64HOB@nongnu.org
X-Gm-Message-State: AOJu0YyHSSxmXqtJO0ywTD0tvDVnKOXwamA00uw58lHE5m5CiVP6M1cl
 M+RXvK1+xhSSM41poL3RkRmHP7U9q/l/tIJDI7IhBZtIz9VJ0GqJ6pF9yqW0cH8=
X-Google-Smtp-Source: AGHT+IHVC+AjOFUj/gd3ZIyMFNaAkyJ4gq/NxZrOhgrhoxUreMZuHQiRMgchDb7zcsd6khHzrwB4YQ==
X-Received: by 2002:a05:6a21:3182:b0:1d9:3ed:28c0 with SMTP id
 adf61e73a8af0-1d92c49b151mr18355068637.2.1729531897151; 
 Mon, 21 Oct 2024 10:31:37 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabb91b5sm2904012a12.73.2024.10.21.10.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 10:31:36 -0700 (PDT)
Message-ID: <80ef4f57-e461-4bbc-8130-ba2cea14e88e@linaro.org>
Date: Mon, 21 Oct 2024 10:31:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] tcg: Reset data_gen_ptr correctly
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241016193140.2206352-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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



On 10/16/24 12:31, Richard Henderson wrote:
> This pointer needs to be reset after overflow just like
> code_buf and code_ptr.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 57a269469db ("tcg: Infrastructure for managing constant pools")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 5decd83cf4..0babae1b88 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1399,7 +1399,6 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
>           goto retry;
>       }
>       qatomic_set(&s->code_gen_ptr, next);
> -    s->data_gen_ptr = NULL;
>       return tb;
>   }
>   
> @@ -6172,6 +6171,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>        */
>       s->code_buf = tcg_splitwx_to_rw(tb->tc.ptr);
>       s->code_ptr = s->code_buf;
> +    s->data_gen_ptr = NULL;
>   
>   #ifdef TCG_TARGET_NEED_LDST_LABELS
>       QSIMPLEQ_INIT(&s->ldst_labels);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

