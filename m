Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61B5E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe2o-0006LH-An; Tue, 17 Dec 2024 15:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe2m-0006L4-Sa
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:19:48 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe2l-0000F1-7t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:19:48 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso5058365b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466784; x=1735071584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VjCc5P4y7HrBoLZImqYaQLeyBjkTA3BHHO5UksDHqpI=;
 b=tsWrt5sbaMwS5O2rqABpe2OPzpTjwFE32BGPQYAE/GgwJ9+erM6v6dTrqMD54aYWYJ
 2xUQB6Vs344fHatkGA/2vF27LVjqWr6hxITXbB2kswLqkqyYF0fEKYD7SWkbTfyhooCd
 W5OmaWlIVqcgqa8FxYC8+zhauEuC26WBitjDdV1tqeNGFSfZumR2pMdM61neEXNb28kB
 xHnpf4ajayb+REV+e5d0ZXPxlpv2oScBZBBWz3PWFKRPWKHAhitltGtD6XRhhmNK59fG
 WoIu6VRVfWoDE8eDB/hZ7Oh/UyduoZ5erLRdshndqylrWMun34+I7yFXEoemHN/3Lm1g
 KWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466784; x=1735071584;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VjCc5P4y7HrBoLZImqYaQLeyBjkTA3BHHO5UksDHqpI=;
 b=u5MDDOsdWMrMUqmuJ07dtffaQbWtTx1vrXbIyHK6u9KYR2hgj/7J9s2OXDQCMIiKCP
 w3PrHwzSk7hDw8tnxPK2Bzaj5Z/efZGcTXXxt2MtVzYEaxcanFoi9XMXjNiwK8YeXZ2o
 6LEquvYPIWve2htfHhUL3itsH47B0DsbJfrkKzkXMMNRyoVv9oqceu0q/6rvoBSuZtNX
 9lw9sn0otBLSoNb3QWdw3GgPQovOGKB+6fuqc91k9L+QuzlcwQse6/bCDWjQPB5HDDMM
 /Yyox3yyfqZQ5/v/yDwiaKoANXWaQFcbUm54lSpb0kEM9r0RCsln4iZiW5++n6WdWH2F
 IfRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI5WUDBiMhEwGd/lQW1jAm3ZUaRNoTMTEc46GPWiXPsrAatGC8e2qjAeTS23ynLsB2vwAjwGTJUhxn@nongnu.org
X-Gm-Message-State: AOJu0Yw6BPdZ/Sz6jpVr3AcjHpuajdlC8oV7DLPeLInsaU/eVVI92V47
 QU5y7Z+P97sM57RXcPKR21cNbdvOkyRvm+XpnI/AtYJugk5RbtcHrvBuiyPmUmQ=
X-Gm-Gg: ASbGncsS4FDr1KHF4cdZ24R33IkhXaiI6o2krW0fN5svEACtAm4KBDIQCtDoLODmpBw
 zfmCogl/WIVFt5MjDrSvj8E/SXOy247oVm/+jH3RM3kBUs3gW0AWfFkclAoGCTkmy3bTH+PHZ6E
 hTrbRjbsSGyfB5fbo0e67uBiwHHYi9/2GSO0JvzLoQj8KKUHPtFUlfpYcQMq+URBJyiB4VTzcdC
 q6pd4RscQupTfSIDKjQdjx07Ch+dg5vV9LeoUhFiKSs7yvAvHfVj6MvQSDZsWBQ/Fpu3Q==
X-Google-Smtp-Source: AGHT+IGBEFXb6FYN1UGlUKPpMGY4bHFhkyaiiULXo549AWvEHnQQaSH6i4d/knKexB8fVgK/9JQp2A==
X-Received: by 2002:a05:6a21:1510:b0:1db:e536:158e with SMTP id
 adf61e73a8af0-1e5b482279emr692641637.22.1734466784265; 
 Tue, 17 Dec 2024 12:19:44 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-819f4bb2d1csm1218155a12.7.2024.12.17.12.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:19:43 -0800 (PST)
Message-ID: <a0dd0667-57bc-4a7e-9536-9ec2d6f78080@linaro.org>
Date: Tue, 17 Dec 2024 12:19:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/46] tcg/optimize: Use fold_masks_z in fold_ctpop
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index c97ec10989..424ed7674d 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1598,22 +1598,23 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_ctpop(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t z_mask;
> +
>       if (fold_const1(ctx, op)) {
>           return true;
>       }
>   
>       switch (ctx->type) {
>       case TCG_TYPE_I32:
> -        ctx->z_mask = 32 | 31;
> +        z_mask = 32 | 31;
>           break;
>       case TCG_TYPE_I64:
> -        ctx->z_mask = 64 | 63;
> +        z_mask = 64 | 63;
>           break;
>       default:
>           g_assert_not_reached();
>       }
> -    ctx->s_mask = smask_from_zmask(ctx->z_mask);
> -    return false;
> +    return fold_masks_z(ctx, op, z_mask);
>   }
>   
>   static bool fold_deposit(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


