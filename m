Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884E6CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdan-0002op-1P; Thu, 28 May 2026 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdal-0002ne-Ds
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:28:19 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdaj-0007dr-Rr
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:28:19 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-83d5bbef760so5486985b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779985696; x=1780590496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PqE/hyiWAc2OYrVtFnbdWdCzfbp9l3B/SMhEsnWSY8E=;
 b=hlzZMcwBnajK87Yc8nimQwKqG8ZfnAcP+5H8MrGRawlQSg5lvIck31fnkHvvQeP2eP
 M0Xz/OJo7CWk1MzeAH9JH5v6sHZvIoe09tHFtF16OK+FgamhnDm8kN29QxVhvjo6Qmuv
 i1phng7u+oqOhGMDF9wqFvpBSSbQZJj6XAZ+b+Q1OJ/7f+Aa8kQ8mUrgWT/q6ptpCE5n
 5LgF1Unr9EVRWMGydzGXOGAj5IUVLelTWZj+m04q90IoLKKtvgfcaE/UsKvlJWptXuu1
 6wXRaSjlottrbd6NAIW9EqX9dPNPV78mQGezVpYlQ7XFbo0s3FYRocAl5jAyiAgUp4Ko
 /zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779985696; x=1780590496;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqE/hyiWAc2OYrVtFnbdWdCzfbp9l3B/SMhEsnWSY8E=;
 b=f0n/A4ScreDGMQ4rs9PzmhGb/CVqE9lu0jF3aN354zf7Ghz4QJ80WNjoUQkupYpPH9
 gQTUkfT6kCCZD+ob8EPo7cgHH5bGfkORWZfpiqlZMfPMSSiC94eCR7pJ+MZUC/vRVE8A
 1Q07S3HeVD+MUyhPD4tYKK4N7U9n1RcG9ps8xf12WplggfoiSzDAwEM1GPmnDn3GJQrC
 skpWhLJA0+y8VZ+vQuCwn1vJYDPnDXlNeW6NCIrq5fpaMJKPvB9fvjW5R4GtTRezHE6r
 7d5uupBbJjM9F5AypE2WHVNdIv7NLFQWAUaTmROIt9XIIjN2I3VsoqtFOfoJyae3XmVx
 JYFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+6Uw24DBHvZPnqlm6dK7gh82sV56wUSyTUw+nI0kxYvXs/7HH0blEl/k7TcobeemQMd8bWZqUSXFT@nongnu.org
X-Gm-Message-State: AOJu0Ywi/rRq32EEXwzHOLOMCyXTtNpcSzbo2IOBf/1m/uqiB/1PT0Ie
 s+hQWnWt4AOfxfoMeuqI2j78JNSC0FkXIFfaIlR3q7Dgff0q7Cw0alFz1tdi3ixO4lA=
X-Gm-Gg: Acq92OE1k31lfuFgpoBAwvjlHc35dW3aEbLiSBLeQyQBk3oroJSpG6QzUxGcrhFCjMx
 34XoMd2t5Hn2kOsJ78Ag+JpzTtc24Bz/nEoEXy+7KDjp+LTM84Ieb64XG67UBuueZMTE1Cc+4S/
 cN+OaOIUzjB2trhhzU/hUjubjrxB9Qfsb+hYK29vh8YgJ0HDddH89LJTn1JOTa0Jjtq1zzRPdPU
 xRF2EH9MwzcsO7qwcz462T5NOf5Q4WqhAFFHbll6SbT44rm5M1uxbGxrnguJ+fLz4l3OVV3uoQb
 f3EnLn/emaP6mqzk8+jwDkfIPV0RFuouZSmwATnTxjLsbJXujBJrj+ITYO4kJ8vfW2uFgoaGjGR
 uI+EhaoG60/bEw7+Xa+epjiXD2AKZO/1bH2GuH49bc6nN2y6lDPfjUJ3hgOFofXO/lx8J5Mbp3D
 M7bt1GKWC4ZLJPaUXyOOjk+rqTLu6iXq0w+VH8NpsjRSboUZ4=
X-Received: by 2002:a05:6a00:a90c:b0:834:e15a:19f7 with SMTP id
 d2e1a72fcca58-8415f3a5b7cmr27377190b3a.44.1779985696014; 
 Thu, 28 May 2026 09:28:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d70bb654sm6855410b3a.29.2026.05.28.09.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 09:28:15 -0700 (PDT)
Message-ID: <22833605-7e0b-466d-a3f1-f9771f5659ac@linaro.org>
Date: Thu, 28 May 2026 09:28:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: SME BFCVT, BFCVTN have "Alternate BFloat16
 behaviors"
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260521180854.1744788-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521180854.1744788-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/21/26 11:08, Peter Maydell wrote:
> The Arm ARM A1.5.10 notes that some instructions have "Alternate
> Bfloat16 behaviors" when FPCR.AH == 1.  We implement these using the
> FPST_AH and FPST_AH_F16 fp_status words.  The list includes the SME
> BFVCT (single-precision to BFloat16) and BFCVTN, but we forgot to
> make those use FPST_AH_F16 when we implemented them. (We get the
> ASIMD and SVE insns on the list right.)
> 
> Add the missing logic to select the right FPST.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 465d36db0e1 ("target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> (There will be a minor conflict with the rename of BFCVT to
> BFCVT_hs in RTH's FP8 series.)
> ---
>   target/arm/tcg/translate-sme.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
> index 08254b088e..8e56dedaa3 100644
> --- a/target/arm/tcg/translate-sme.c
> +++ b/target/arm/tcg/translate-sme.c
> @@ -1419,9 +1419,9 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
>   }
>   
>   TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
> -           FPST_A64, gen_helper_sme2_bfcvt)
> +           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
>   TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
> -           FPST_A64, gen_helper_sme2_bfcvtn)
> +           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
>   TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
>              FPST_A64, gen_helper_sme2_fcvt_n)
>   TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

