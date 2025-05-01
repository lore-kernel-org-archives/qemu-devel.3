Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812B5C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAUpr-0006nr-98; Thu, 01 May 2025 10:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAUpi-0006nW-9U
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:24:15 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAUpg-0005ik-8j
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:24:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2295d78b45cso14315775ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746109450; x=1746714250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WLMfS/k/y7zSOJA/gPNu49/jJXMepUgkWPRE8r7YE8=;
 b=eiLebXZW5zfGYqNPH1U8CUfXHsbogxPbvMxBRvqVZbITrr5t2VVRIFX+z/7Z76xL2g
 IDUZOWtnXIb9kOIOBpTueNKmhtMga9NnRH0JoZqPJUzOVw3lDRG6hAgeYfLMJgznoE4n
 ykxwlI9SVgE3pFP9WIsGkVtnhtVK0ZRXY0whs58EYQiqvPS9HiF617iOZoRALzGjejJV
 LYxLpN8XSggHLQsq+3gn+K9vYFYkmqQhx3IFgADMJyX4xN2R8AURtb3eXpX61VoVg7pt
 92WXgpnV9NXRyPKSuaWkSl8SrWxMy7CnZ9+QDYB5rd64ImOE2ioDgklsoBEOYd48pgXS
 2FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746109450; x=1746714250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WLMfS/k/y7zSOJA/gPNu49/jJXMepUgkWPRE8r7YE8=;
 b=twu3wYhz+XY6s0sMfwqsJTW9sOBzE0kMq/aW9gPOX1NerzigYgNafLR5ZoReMuuJCq
 1rksFW2slJbXDEh5wzJh7C8T/mdTNBKO9WX+ab4a9tTo2FoE4v1QlBAXMRtPa5iLM0wQ
 maf3bqc34m4I+6AEKjXrN4bhTYKi4ArfZ8MBCfftcJ9Ts7kCfrgW3/tnmuI3eXBW5y74
 MvbE7djnI3uFfY7+TPoi9/x0yX95sCDUdM+Muhy9XwQBakBJlQ/kZizezakOobLUjE47
 Xhh4ebm03EL2+6TAVnY2QIZDpn1ywL4EVFgVvhWBc37iv1/f6zRxacnRftma+e1VF+SI
 84Lg==
X-Gm-Message-State: AOJu0YxAPjOs5KsItbYGKAP2PAvEuzG0xmW0PJkal0kZVPQOafX/RRAZ
 g7iBdfEB4XKSeAHubazdmiq3n59DOPWuYdNqoDsN+3rnC2/vnTTFBw6oBM59VIbbnrwyQ9T6nkH
 T
X-Gm-Gg: ASbGnctSEAgitUjGzNG7jWCfVSz9aDQBP1QFtfqpYq03m2/zzLBN9Cr3ebV+8sWxQ2O
 1wtoKYswYdbovhvX+KTD1c+8S+ebTPfj+Q4oDchg4sQhD/7JWWIMGyMfNJJAA7VRzmnihr9/E66
 jYdekrJkV2dQSPhbxVwFq+/MXiEH5vY9B/6HCGAKbaZNof78t6gdOKDyXxY1fZD31ITwuAfmvsO
 jImKf6QVnxmK6+goHzXK6iJT0plptd4A/j28c1u82VKKg/sttPq7eAyLbF4VvtgLN75W4kWrdmL
 cMyGyE7D2rGPUZWx0hFhAcWboXImusngqEzAxESfmitc8NISXsc00U1sC6rVVs6+ppZHpPGgOXr
 KbHRGcRI=
X-Google-Smtp-Source: AGHT+IHg8KuBb2zvZDC2sdHS99LHe/jZwU8TGRIGBvSIf5OYPAmke/DjYj+U6RE4NNbB0wvx8ZvAcA==
X-Received: by 2002:a17:902:f647:b0:220:c178:b2e with SMTP id
 d9443c01a7336-22df578a2b8mr115799885ad.17.1746109450144; 
 Thu, 01 May 2025 07:24:10 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc6dab4sm7079725ad.141.2025.05.01.07.24.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 07:24:09 -0700 (PDT)
Message-ID: <b7dcb3a9-fffe-43b7-a4f8-e688eae18330@linaro.org>
Date: Thu, 1 May 2025 07:24:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't assert() for ISB/SB inside IT block
To: qemu-devel@nongnu.org
References: <20250501125544.727038-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501125544.727038-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 5/1/25 05:55, Peter Maydell wrote:
> (NB: the TCG optimizer doesn't optimize out the jump-to-next, but
> we can't really avoid emitting it because we don't know at the
> point we're emitting the handling for the condexec check whether
> this insn is going to happen to be a nop for us or not.)

Heh.  For some reason I only fold unconditional branch-to-next.
I'll fix this.  Anyway,

> 
> Cc: qemu-stable@nongnu.org
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2942
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 88df9c482ab..e773ab72685 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -7760,7 +7760,8 @@ static bool arm_check_ss_active(DisasContext *dc)
>   
>   static void arm_post_translate_insn(DisasContext *dc)
>   {
> -    if (dc->condjmp && dc->base.is_jmp == DISAS_NEXT) {
> +    if (dc->condjmp &&
> +        (dc->base.is_jmp == DISAS_NEXT || dc->base.is_jmp == DISAS_TOO_MANY)) {
>           if (dc->pc_save != dc->condlabel.pc_save) {
>               gen_update_pc(dc, dc->condlabel.pc_save - dc->pc_save);
>           }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

