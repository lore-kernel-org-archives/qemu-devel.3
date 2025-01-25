Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6702EC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhqJ-0000jc-Ig; Sat, 25 Jan 2025 10:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhqG-0000jJ-Su
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:13:00 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhqE-00024T-QU
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:13:00 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so4173507a91.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737817977; x=1738422777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8fYfuV+7rT4G5r0WFxz9cs+lsr11lCi3MLtz1pjnkI=;
 b=Bey9enjbqH1T0SUqp+r2BNcaSBq02cIzF6XifGp9pXfsXmSYsd6yiIbBYyu8+rnr62
 nufrGyixb84xNVh4v7hAdYOS64EDNlhfxpLllwzcMgB6FVE7Wzu0ZfCNVQAMRo0cOBB2
 mPJIqIBwpY59qiQDnFan2ZS1UF4MD4brfs3GpoBHSzrm5jzJpwW9/DbJ6lYsUvR54Iwg
 I7ecDoKezvTK/a4N5iX/346wbILc7xzfzgEUB/ofSitM3oaQVlh7cDLOniwFKE7ANUmE
 Ml7VvwW0aVfDl9dzw3vftGfzMmMxVXU1gYS7SOHEDd3HsKkr3PcHV/LCApu8Zh6HcFBf
 bAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737817977; x=1738422777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8fYfuV+7rT4G5r0WFxz9cs+lsr11lCi3MLtz1pjnkI=;
 b=hsJnYsrM2UHEan0gXmLIG96uGiwlixQ9/AAFa8Fld1sj9xiN3/zVIFQRMvwclMrjEG
 tPBmFCqLK646YAngYov4PFMnsMCnvTbmuDARjkA/lIhmRdT1G5wYO/NapFjxUJ5VDckt
 /pAiZFhX9OjhCUqXUYzj3GGwJjNM4y2wTnIccFG7+PddtYQXU8z10V3Jn/EWPMZAUovX
 nbNuB4KTEB6mCtktn4cQwmQ9lxDiSMICxTATPal1ccz1u9zPVIpAzkGLNf8VtCI/Wntf
 KmgShcwuWd/rbyWZg3g+HEjd8DADnpqx5boSIK1uaL/4SipvpXv0uEBFg7TKO7vPv9I7
 fDHg==
X-Gm-Message-State: AOJu0YxiY5iSVl+mkYnX+mfwqDIgDyDaCbClHuSdBgB60YFWRQkpolTL
 LPFEpvFeL0gjKILN3lDz1Xvtc1Xye6GdFMTAOYSeD2Do4thR1/N/FqcI4xhDDWQKvsbD5BhP9rh
 N
X-Gm-Gg: ASbGncsN6bB6l12cvkNcCR6AHdp1Zh54YHf52Xt3GGziYZQWelQrvLhrpuA5znP5gqv
 TFzwUryzSiZxiFLY0WMsVSj/P7QdpT2lGhRL4sY3dVuXPCvFXNzESBlOOPKEuaT6uyjWSO8DUV9
 diD8uyi4s1GwTCRoTgLbnsaIxyg58kQEcNU+7XEDcCUVLj22sEUP0o9zJCzshR/yoDXv7D/jfl4
 0Rcv/DIpaOfOJ7v6MK+GbdXZJ92QCMl70Xj/7Vjwn0v3n7iQma943pnAzKvvZzMuDxAEkWQQl5x
 nkQIEkhmGBUyWga+cxEEdA==
X-Google-Smtp-Source: AGHT+IG0f6J3k9/DniqTHF77pCgQhLt6FwE/SNvY0wYTjdc7m1poSp7VSSatjM01gUNwI8lTRhbnlQ==
X-Received: by 2002:a17:90b:2652:b0:2ee:599e:f411 with SMTP id
 98e67ed59e1d1-2f782d8cf56mr43552686a91.34.1737817977303; 
 Sat, 25 Jan 2025 07:12:57 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa83b24sm4063082a91.46.2025.01.25.07.12.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:12:56 -0800 (PST)
Message-ID: <cb179c1b-df81-4fab-b5aa-701d76f2a3d1@linaro.org>
Date: Sat, 25 Jan 2025 07:12:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/76] target/arm: Define new fp_status_a32 and
 fp_status_a64
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> We want to split the existing fp_status in the Arm CPUState into
> separate float_status fields for AArch32 and AArch64.  (This is
> because new control bits defined by FEAT_AFP only have an effect for
> AArch64, not AArch32.) To make this split we will:
>   * define new fp_status_a32 and fp_status_a64 which have
>     identical behaviour to the existing fp_status
>   * move existing uses of fp_status to fp_status_a32 or
>     fp_status_a64 as appropriate
>   * delete the old fp_status when it has no uses left
> 
> In this patch we add the new float_status fields.
> 
> We will also need to split fp_status_f16, but we will do that
> as a separate series of patches.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h           |  4 ++++
>   target/arm/tcg/translate.h | 12 ++++++++++++
>   target/arm/cpu.c           |  2 ++
>   target/arm/vfp_helper.c    | 12 ++++++++++++
>   4 files changed, 30 insertions(+)

Hmm.  My mistake for being slow about posting SME2 patches.
I converted fp_status* to an array indexed by ARMFPStatusFlavour.

> @@ -702,6 +708,12 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
>       case FPST_FPCR:
>           offset = offsetof(CPUARMState, vfp.fp_status);
>           break;
> +    case FPST_FPCR_A32:
> +        offset = offsetof(CPUARMState, vfp.fp_status_a32);
> +        break;
> +    case FPST_FPCR_A64:
> +        offset = offsetof(CPUARMState, vfp.fp_status_a64);
> +        break;
>       case FPST_FPCR_F16:
>           offset = offsetof(CPUARMState, vfp.fp_status_f16);
>           break;

... which eliminated this.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


