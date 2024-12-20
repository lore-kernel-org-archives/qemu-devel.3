Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjSx-0001Te-0U; Fri, 20 Dec 2024 15:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjSo-0001Qh-VW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:19:15 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjSm-0006oX-Dp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:19:09 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-728f1525565so2816764b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725947; x=1735330747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yQugzIp9lGKn9bpGcyKhR8bXsl5pPz9g7oE2ir4ERAQ=;
 b=W5r+3Hv6vQwXJ8kmGp6h4SVDPjQ8kAJKWAqb/ZJPVd7owQBacO/x7cxEfSiXGrYcx+
 a2+8KdQIEk6cXGmibOQYsb16tDSq/0GE6foygCmJNOesDhF/VlfD9t39iUlgtPqiNOND
 QsEFaC5hnRMKXpijMTOxGL02J1b+7AEDSU3UPe0+syuo8s3K4XxLX+iu1/WA2AYBme8e
 HC9pndS/4C38rw/TKn603MT83nC3tMEwKvELZCYBNAK+3+5YcfPjuTSvJkPsd/jG9JQN
 OyMTrGf2GhqHO2Q6cwzmdw+6tE0isJ+MBPx6+QVhUSufYUejsQWBpdg2YZm0YlNfD6+6
 UatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725947; x=1735330747;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQugzIp9lGKn9bpGcyKhR8bXsl5pPz9g7oE2ir4ERAQ=;
 b=btG+k+U0ngNYLmzNmYDL4c4TpfnzodkVm/+481F1wn+/mVa6w8yQVWf0kCGrVBwqtv
 q/VIZhqb0hwUn8hPQQoEcwV6QJQw/tu6PuFVUxOSLx86EEoy0QsWGM2n0EF/3sJOeuCB
 NIJHicqigRPZ1q4Qn2FZ62ZAu3E7cqik+spGWLIsNihBo1mEaAnk4cepKnwS4y/Erylx
 gvWQ2fMqhXmBdHmJxqe3quv8d4dBO8jSSxl1H0niXHrp12srpehRs1ojJAxgXKUSzX9z
 X/beDsMjUXolANHo40Ti/VLuFc+Ykq5LTfcyVbZdf+aZhT+DhktX53xDRZxe9+m2m39p
 liuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5cmzOOrFPX9bMHxARm1dHU0tho2FB/0aXJzUhwoDZsLCSbOZO/6cyk5bRqso7qcvjH5BvPl2z0zUh@nongnu.org
X-Gm-Message-State: AOJu0YzIDYKPJPMtw3v9HxudndaTdrFJYmZ2dlphT1sdpDs2/XN1O2JB
 hOsQIixouufAxhpGn5QvS84JZKw8r9asF40mAGfGmJ8Aa/Q7+/iDfs+Z2FE1ONc=
X-Gm-Gg: ASbGncs+riMd/HXcwRjiogjijHDrTNsck5aArXw2ewSRHYNPG2gQ4lfJ4kiEge3iiMv
 UYtneP4LYI+z7vVeTTeLb6ilD+0ZZeB/fhXABBV/Gs+EQjeedI7fi7V4FxvuyEeKvdKuolnCt2q
 FXJmCoeBBTbSk2IRHMpNoUiPq0DBhokCL1lMDcXrF/SsFT+vVNohQF5v9RBIPcr7a7YubVVmPTN
 w26Lh32hdim3IIpFdcyc7U9GgnC0+vufyaYXFAXwuZ0YV5sNTR6rOZ/PHkzDhsw685lsg==
X-Google-Smtp-Source: AGHT+IEWVy5PudQmINdZmrEJfXiwZBEej0LN674IgglWZEhU84oasfmeCREKNLtoVX6lbFQVl5CpiA==
X-Received: by 2002:a05:6a20:7487:b0:1e1:b023:6c98 with SMTP id
 adf61e73a8af0-1e5e0482bd2mr7759491637.26.1734725947072; 
 Fri, 20 Dec 2024 12:19:07 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b9fb38basm3214444a12.49.2024.12.20.12.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:19:06 -0800 (PST)
Message-ID: <57d6cd67-3268-4e99-9542-6030b1e6b459@linaro.org>
Date: Fri, 20 Dec 2024 12:19:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/51] tcg/optimize: Fix sign mask in fold_negsetcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-36-richard.henderson@linaro.org>
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

On 12/19/24 20:10, Richard Henderson wrote:
> The sign mask is about repetitions, a la clrsb64(), so the lsb
> itself can never be a repetition.  Thus ~1 not -1 is correct.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 5bfcb22a0e..63f80efeec 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2403,8 +2403,8 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
>           fold_setcond_tst_pow2(ctx, op, true);
>       }
>   
> -    /* Value is {0,-1} so all bits are repetitions of the sign. */
> -    return fold_masks_s(ctx, op, -1);
> +    /* Value is {0,-1} so all bits above lsb are repetitions of the lsb. */
> +    return fold_masks_s(ctx, op, ~1);
>   }
>   
>   static bool fold_setcond2(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


