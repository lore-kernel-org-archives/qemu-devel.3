Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29E0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe2m-0006KS-8J; Tue, 17 Dec 2024 15:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe2l-0006KC-Eu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:19:47 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe2a-0000DL-7b
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:19:46 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso54698775ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466771; x=1735071571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B/vBU/XJ8Hk3w/s43RzmElYym04ZYZVy9gAcMCnpbAE=;
 b=ufNTlmVbet0JBbgQF9HWYZ4FmQTrCfm+cQdPwRSCssJN6sZ4e7CsLDpVoVl6oUqp1J
 en6/fdFz35yrEOu4hNsGVtZXXS+7PKl6ku6mcgu0XoieprtrJtweVFZObvNFnIJ6YoZZ
 ZUrAtWDzxMuS4O+qRnm4M7gOwqLJW4v2rUrxeXiQ2Ii3ra29GRHLPkM740OOf/px4b8b
 CYrbYBK1OZsHf1ns+R2HfTPtGIPcsQ7rHQH+2LqO8d5Tl3eehEBlVTJerIYl4WZKChqW
 b7r7AVRGPh20+rQvVVeyJOTLC4oDz2sgXnvMf0oU6heBUaU1hGMouuCiC82Xz2WL2aAZ
 gb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466771; x=1735071571;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B/vBU/XJ8Hk3w/s43RzmElYym04ZYZVy9gAcMCnpbAE=;
 b=hfjoMksfoc3mArVF1QOa29z0V/t4UxblrNoat4TqqqhF4+mYyHy8hoDu8VVXHp35a4
 Zr1p88t8qlE2axTxNd2Xe4AtYL2rIXE0jIQJ3KCGrY+dfjCVdFyKpUrow/kJ8RpyfIzo
 chQks1RDGjsaBCVPMxDwb9qg1QkmQ8juYSNNCMkS2+pXURl1uCWAmyM0xwFxIMF1lEyT
 hK9kfM0aJPgf+YwVl6YEusQvk648YyuivthlEifWAsaxhrYjSa8g5URZmwqoJFMJQxCW
 0jrQvBDmNLuoKIgvxzZAZzY0+1oMprTchbNJLq6yxXrmV2V480PX3kfAEY0+epCd84Rd
 Q67A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwutwxrW1Tf/Br9ooAgOmq+PZpiz2MvbjYpqxUbR8VnV7m2AzMP2iw+Dcw9IS4LtpI+7QMQyGtdhV5@nongnu.org
X-Gm-Message-State: AOJu0YyWYcgJ0wy7jcpeqvkYR9LzVyqxhYtEd42AAyXvFTTX+tjEPDCZ
 5KBwj4x6M51SwQZVzPuQ7BcppjZ2WA/Ju8omqdeEs0XDgkfGw0nmM8qSYXpusRk=
X-Gm-Gg: ASbGncs+mv8ndZoV9FSQw0UBHvVlQvMkquB9YT3axUtTGdEvPKCs9Ttq3XUbcvGGjsl
 /D9I2jrdRot1orXL4Ieqfz6XhTW2kIdlg9Sc4jpDqWTjcXrHRiFQX8KbvAIF+dUpqKhneWLYW2l
 BoSSgpeShwZR5fpGBCK7a78H0LgO5e1Zgpt24ZbJToK4m2oLZFIInHkYCf4x/EMh+yMjNdPO54F
 dMfZm/h6xieek52oVKt8soQPio0PvX9du4n55t+4zkYEdAxTu1EGjWoeBYkH2XTb+G2GA==
X-Google-Smtp-Source: AGHT+IH1vmpH7izX+mX7sq7/anwPzOBmkuq2Bld7TmtTsAB+tnMaK6BskpbnJr7VDYXXIk0N0trBSA==
X-Received: by 2002:a17:902:db08:b0:216:4165:c05e with SMTP id
 d9443c01a7336-218d710498cmr2266185ad.24.1734466771682; 
 Tue, 17 Dec 2024 12:19:31 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db74d8sm63672845ad.55.2024.12.17.12.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:19:31 -0800 (PST)
Message-ID: <c0d04aed-2d17-4933-a24f-27f623798057@linaro.org>
Date: Tue, 17 Dec 2024 12:19:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/46] tcg/optimize: Use fold_masks_z in fold_count_zeros
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
>   tcg/optimize.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 3363ebd48c..c97ec10989 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1088,7 +1088,6 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
>       return fold_masks_zsa(ctx, op, z_mask, s_mask, -1);
>   }
>   
> -__attribute__((unused))
>   static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
>   {
>       return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
> @@ -1592,9 +1591,9 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
>       default:
>           g_assert_not_reached();
>       }
> -    ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
> -    ctx->s_mask = smask_from_zmask(ctx->z_mask);
> -    return false;
> +    z_mask |= arg_info(op->args[2])->z_mask;
> +
> +    return fold_masks_z(ctx, op, z_mask);
>   }
>   
>   static bool fold_ctpop(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


