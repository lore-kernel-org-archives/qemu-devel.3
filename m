Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9638FCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXnl-0008CD-WD; Fri, 22 May 2026 17:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXnj-00085s-Dj
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:53:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXnh-0004wR-I1
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:53:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso79407505ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779486780; x=1780091580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/L/Y2b4ZlSZ2I2/kzKZb6Ix9JOWI17tT2WCv23JDITU=;
 b=vG7xToFTE3v7crRq6CjPite0VxpzlOr9KkgiRrmjukK6LMh9siSWivqyR4GRPk53hf
 EvCwSzAD38NIDrBXcfcGBW/pLMPqqK6C7rOynQFXG6v+D8YGTKpv3V0Hl7PwZqza4KvT
 hKu2Dzg5U1rV62H3SyuvpamXrqk9OMSgvM5fl+ssW+o6MqNHBgpEOrwvivPcagnqCFO5
 +Zw88Rsv91rZdA7fbbDrXwyflUMM5GqZrXZBv6a9ZLuaD6t3slF12Ftadr7v6EaijlbH
 +wVCZqJYKS5y9W0pAo3I3heLFvMYViGLOUCbS6L4wRheocLmi9FSQOqvC0valkvJdn2l
 oogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779486780; x=1780091580;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/L/Y2b4ZlSZ2I2/kzKZb6Ix9JOWI17tT2WCv23JDITU=;
 b=k/kG968jPk7Wo2lHN8B/WgjYr2ddu/FZ2VvptB5Ol8TjaOpY34KtJOMSv6hxDuoQOD
 veRMr+EZ5nBcjWq5l7cholZ++j7+SWUfaPeXky3+sEQ5cWKcTOUayEW/QXbDSXETUuFO
 Kc4Y1aM77WmaAl30iawEs6G3fEVn7u6gax+Mee+FRABA4dUK/NG5MxUOSCubGYMEgEOu
 RMO+FGbm5pUj+e595AgHkImwqhUh37rtng1Pc+TQl0LMGb9+8/IEBvDDBOF/dN89lr9T
 pmG9fZGMb88FdwE8zNBeyiqS8uDBVWXdS42Zei8piC3lgm2pKa6Jny4iBMMzD9YQu7Mh
 awUg==
X-Gm-Message-State: AOJu0YxLtWXQ2mIDRYEuszvG3QzZO2R+whNO3aIL8En/RzGLtpA9oDZi
 XDwhvyQe3Azra72Wau0qvHUoZqHBxVyJ8kzkvl5mHiDDSREWpkPHWvNOFJn+/WDn79r3N66lHgo
 BbT4l
X-Gm-Gg: Acq92OF+zH9Jq5PnEKTpfZUZh+8hEeN7xkyvtyr2rs7cCfK9LIQMGL0udGQKDCxOWLT
 3j2iBnCuCSZIii+dxy+f20kZysRNzAqT0zRruUCQJbMcCAvJiFawEksYCsozi24+LI+qQLPck0A
 2bW6qEKH3BTnkhXR+cvNu/fh9snvt7oQDEOv+EDrGYgm3IhNEr1sObQEf841vivFLjc7C/+6eyy
 yjZEcGlnt68l12QfFB7+ud/c9lfzy4xvwU6939EEPpRRso+b0qXayyGTY8VuM9lQTfCtR/V5FcZ
 JWhyrDyu6CHzApj4lfkA1N/TSToC+qD/jYuvRUjbK7eBVMEWkYFyRAzlqjg/vO5jk4MlLbSM+DV
 Yyo34VjQjOxdK5QBSjrQArib6IQkMTmEXTWUWfaMwARh7sLKJMKouqUDCP5ayDYnzx3um0Il0zj
 0S1xaEOMsHelzf1dBnRHjLWer+X+TxBdxvh+7RYxfj
X-Received: by 2002:a17:903:390d:b0:2ba:b643:1f81 with SMTP id
 d9443c01a7336-2beb038150emr59071675ad.15.1779486779637; 
 Fri, 22 May 2026 14:52:59 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58c3016sm37149695ad.56.2026.05.22.14.52.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 14:52:59 -0700 (PDT)
Message-ID: <61e21a16-daa6-42db-9a1c-5103264ded82@linaro.org>
Date: Fri, 22 May 2026 14:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
To: qemu-devel@nongnu.org
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
 <20260521122913.1565011-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521122913.1565011-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 5/21/26 05:29, Peter Maydell wrote:
> The SVE FCVTLT_hs operation produces a halfprec result, so we should

halfprec input.

> use the FPST_A64_F16 fpstatus for it.  Getting this wrong means we
> will incorrectly set FPCR.IDC for input-denormals when FPCR.AH=1.
> 
> We missed this instruction when we updated the halfproc-to-other
> conversion insns to use FPST_A64_F16 in commit e07b48995aaa
> as part of implementing FEAT_AHP.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e07b48995aaa ("target/arm: Use FPST_A64_F16 for halfprec-to-other conversions")a
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index bf9f0ae179..59b8c494a8 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7827,7 +7827,7 @@ TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
>              s->fpcr_ah ? FPST_AH : FPST_A64)
>   
>   TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
> -           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
> +           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
>   TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
>              gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
>   

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

