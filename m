Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386BDEE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8gF-0000NT-Gi; Tue, 10 Sep 2024 17:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so8gE-0000MC-An
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:45:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so8gC-00045M-6b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:45:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20570b42f24so14199685ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726004741; x=1726609541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rFs9wKMPLjhDwpK7GP8LYEH9TXkqxtH1WIf3RHjBiUg=;
 b=CxsbQMN9cnSOFjR0i6VeJIUaIix3yYBO13e7TUVWHi/GI1tI7bg2nUHeoeWqztGZI4
 wo1gjvhrc1+ez21S2dtqCMW3JXZPZQ/9N54xTkE22wJorEkheJz5TaaY+JLthhAd4xdK
 AZAZXpJIkU+bCWoJzr86aRc83dJSzpsZk4+fWUnKcfJUqdxTXmLnvH6LRZcxPCWDrbD6
 v6P5pqNniMrDwqqUD5FH8JLZaMfl/BD3YxqKZKeMu3TOPA+6mRYVr+VZCczZku3Vl4wh
 qMxjZ7RRU52XV1J4Flu9tFKN4Ctk1PuIipsBlUvP9QaPFgtbqncd89WspCDHRRfwQPqG
 d5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726004741; x=1726609541;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rFs9wKMPLjhDwpK7GP8LYEH9TXkqxtH1WIf3RHjBiUg=;
 b=qWZNQWS4qVTSRjtNuPEY/ZfFTWmBjrKYsgdikZpv8Xi0XWpZ+uxDlnzZcoYFt0SUzf
 RFr8b4zsogRnKFLlZbq1tzjEA42gvdyo8h76/DOrW/yWBRQoUO4UuH0tcHbjEFxIKwXh
 /yZ1YGNXZ+84uN0F9n9hCoSqqlujUtkLyuAeSe0BikJlaPywuQ9i62nYk5CZ/xby3QWq
 Ua5atOf0JOacKwrvVFmx75sMsZuevqLyqucFBfVxuseYcYwEIda93WGFDMVCqNgMbE84
 5ziiBRcYejOztkJxLL1Th3zrka3VIXDXsmLo2VN1z35tnBsqtxWIgGy76mDK3F/OgA0K
 H2gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvMO245uPeVk8KfHxDBWd2kreoJ1KSU8zsJidvifr81fSo7Eu5xx3xuj8cDHnCiaLmgkvCqx3zIv08@nongnu.org
X-Gm-Message-State: AOJu0YyjJoYHyWpHjJ5wsoiXQs0t219wQxmsTE22lSZg0Enwepc8HwIh
 3dHTSAI5oelk7ZwiXWA9kftPoTaBHNkoqcj/dJeH2uPGdhxArRvHC15Jj4/1omI=
X-Google-Smtp-Source: AGHT+IGfGJ/OlEuJzacHAfMuKKQtrSWKp6SEwMo6GeaWmBsCCT5v3MvQhHc62UPsx0Val2GfCyA7zg==
X-Received: by 2002:a17:902:e844:b0:206:9a3f:15e5 with SMTP id
 d9443c01a7336-207521beb54mr10932635ad.32.1726004741442; 
 Tue, 10 Sep 2024 14:45:41 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710eea93csm52596465ad.127.2024.09.10.14.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 14:45:41 -0700 (PDT)
Message-ID: <38703ae2-78d1-4727-9509-26065f650f98@linaro.org>
Date: Tue, 10 Sep 2024 14:45:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg: Return TCGOp from tcg_gen_op[1-6]
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <20240910212351.977753-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240910212351.977753-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 9/10/24 14:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h | 12 ++++++------
>   tcg/tcg-op.c       | 23 +++++++++++++++--------
>   2 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
> index 52103f4164..8099248076 100644
> --- a/tcg/tcg-internal.h
> +++ b/tcg/tcg-internal.h
> @@ -92,12 +92,12 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
>    */
>   TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
>   
> -void tcg_gen_op1(TCGOpcode, TCGArg);
> -void tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
> -void tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
> -void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
> -void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
> -void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
> +TCGOp *tcg_gen_op1(TCGOpcode, TCGArg);
> +TCGOp *tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
> +TCGOp *tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
> +TCGOp *tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
> +TCGOp *tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
> +TCGOp *tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
>   
>   void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
>   void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index eff3728622..28c41b37a4 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -37,38 +37,43 @@
>    */
>   #define NI  __attribute__((noinline))
>   
> -void NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
> +TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
>   {
>       TCGOp *op = tcg_emit_op(opc, 1);
>       op->args[0] = a1;
> +    return op;
>   }
>   
> -void NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
> +TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
>   {
>       TCGOp *op = tcg_emit_op(opc, 2);
>       op->args[0] = a1;
>       op->args[1] = a2;
> +    return op;
>   }
>   
> -void NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
> +TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
>   {
>       TCGOp *op = tcg_emit_op(opc, 3);
>       op->args[0] = a1;
>       op->args[1] = a2;
>       op->args[2] = a3;
> +    return op;
>   }
>   
> -void NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3, TCGArg a4)
> +TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
> +                       TCGArg a3, TCGArg a4)
>   {
>       TCGOp *op = tcg_emit_op(opc, 4);
>       op->args[0] = a1;
>       op->args[1] = a2;
>       op->args[2] = a3;
>       op->args[3] = a4;
> +    return op;
>   }
>   
> -void NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
> -                     TCGArg a4, TCGArg a5)
> +TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
> +                       TCGArg a3, TCGArg a4, TCGArg a5)
>   {
>       TCGOp *op = tcg_emit_op(opc, 5);
>       op->args[0] = a1;
> @@ -76,10 +81,11 @@ void NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
>       op->args[2] = a3;
>       op->args[3] = a4;
>       op->args[4] = a5;
> +    return op;
>   }
>   
> -void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
> -                     TCGArg a4, TCGArg a5, TCGArg a6)
> +TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
> +                       TCGArg a4, TCGArg a5, TCGArg a6)
>   {
>       TCGOp *op = tcg_emit_op(opc, 6);
>       op->args[0] = a1;
> @@ -88,6 +94,7 @@ void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
>       op->args[3] = a4;
>       op->args[4] = a5;
>       op->args[5] = a6;
> +    return op;
>   }
>   
>   /*

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

