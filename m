Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919E6C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oNU-0000wx-Tv; Tue, 15 Apr 2025 18:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oNR-0000qZ-Ko
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:03:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oNP-0008Qc-Gf
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:03:33 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so100662b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754610; x=1745359410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lIevJkIXuYhX2BgfD1ZwCyD83HEprWLFq6aT/S4r3CM=;
 b=qLJ0NmwoFzVgtj+2rK6+iCVOilce2A1kMI/exxXtKH1P36uXTkLpG0YCEJ667vq4aI
 TF/MsbC4xyaMswNAi6+35lM9Qnnl597t6l1XHhJN7VbX0qPRZ/XlyxDEiiV6ALDjUN94
 a9d5UnfxpOn6/aCbZwV+TsCirDIlxAGhlhnHvusqTHa91XY7Q8HJQGe/i/b1c2BjOfnw
 iTVq91hQNw4jsGmNb1wqqcyhl89ZlFSxIpckTeGVfQAqSPfG4C7aa+VjeC1wn5po0LVc
 tRp26mfFohEcyS0j9dPuN3RsMasZxktMiuKgRWI9knONn3LDEu9HWteAR3WkAd6fYks+
 DGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754610; x=1745359410;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lIevJkIXuYhX2BgfD1ZwCyD83HEprWLFq6aT/S4r3CM=;
 b=hjq3fZD43aXuqHhtzwZw1zYnn6EUWnorYApwTpfwwIyKIhfCY/hfvTQeRGEB342PyZ
 xElotDIrfVjx6N1titJeVqQrVgbHa0YDsk4vx8F0+RNmfrOiXYsr7zGRKFR+oeLB39ZK
 OG3uVI9ivEBsa18MNugUT2PIsi8DwIDW8wgpnW8Erv8dtKtwCoB092LF+N8juXZ9eEj1
 ZAF9lJAsKabLfst2T7cgeCTy3np02lakE1zldxdlcFL0Lkqqs09dtBTdinhNvaFY43iV
 91Vn5q//ZID62ewAuWzpPpfy7J9U5u7WfZIiz/YXb6zP51Ky8P5VXi06wW9ZvgPWwy9F
 Txrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUD1kF3ip+f8q/E9VZ5Wk8nc/tIHIsiLv8ibbvqEEcAWgOvJP4ngiETcvvoN5enx++814o8TxTCOX8@nongnu.org
X-Gm-Message-State: AOJu0YwEl7JURgIN95JDMulD3JUoxzienesABE5L7C84dw6QVMoBhyu4
 yAaTbdvtDAh9bJkZ3hIr9vURJdqC9gaNdTB/5V+y9SWGexOHgRlmn1fHhSqDlL3P7Mk0avQsiwt
 FcAs=
X-Gm-Gg: ASbGncva9cBrGMHrtaPBDeoUZlXw3xuGdZZi3YHVdzC13ozsmHVt5I45yKmsZb3dO6v
 uFUZ9jsCKD2qo2rIDKOp1qJz0jNZweEgKYl5UG2kVpmLzH4QdXdzTZ5yk0sOaSFa+bvu3RHoI9P
 DZVI68RBavdfOhw9bO4idNiDRNYJlHVFeuJ1l9G/4IIAqNYWFpRI7oP40+HvTAZ4gg++UJVUQP+
 bAFUF/D/pXyvM9H3PSEHaTHqdcja9TEnnKhjOABbkA7LQYRkMRg+WS1soX3iOXGN4i1zMNaWw7d
 5zcC2PjP/RWEaUanE4VqVbx1v0mQqF+orJwJhJDrCvqu+lZwp9/ukg==
X-Google-Smtp-Source: AGHT+IGLVjLf8H4coqDqrB4RlYty2N9TUpNljJiFqD5gqs38zi4M8Jl1Cnrb1FCTSrFCoIQueUKcCQ==
X-Received: by 2002:a05:6a20:7492:b0:1ee:ba29:d8fa with SMTP id
 adf61e73a8af0-20398df16a7mr7936456637.6.1744754609944; 
 Tue, 15 Apr 2025 15:03:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220c2d46sm32779a12.21.2025.04.15.15.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:03:29 -0700 (PDT)
Message-ID: <0918aad4-fcd4-4b38-b641-9e6ad2b0b6d1@linaro.org>
Date: Tue, 15 Apr 2025 15:03:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 106/163] tcg: Expand fallback add2 with 32-bit
 operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-107-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-107-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> No need to expand to i64 to perform the add.
> This may smaller on a loongarch64 host, e.g.
> 
> 	bstrpick_d  r28, r27, 31, 0
> 	bstrpick_d  r29, r24, 31, 0
> 	add_d       r28, r28, r29
> 	addi_w      r29, r28, 0
> 	srai_d      r28, r28, 32
>    ---
> 	add_w       r28, r27, r24
> 	sltu        r29, r28, r24
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index edbb214f7c..8b1356c526 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1105,14 +1105,15 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>       if (TCG_TARGET_HAS_add2_i32) {
>           tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
>       } else {
> -        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> -        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
> -        tcg_gen_concat_i32_i64(t0, al, ah);
> -        tcg_gen_concat_i32_i64(t1, bl, bh);
> -        tcg_gen_add_i64(t0, t0, t1);
> -        tcg_gen_extr_i64_i32(rl, rh, t0);
> -        tcg_temp_free_i64(t0);
> -        tcg_temp_free_i64(t1);
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
> +        tcg_gen_add_i32(t0, al, bl);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
> +        tcg_gen_add_i32(rh, ah, bh);
> +        tcg_gen_add_i32(rh, rh, t1);
> +        tcg_gen_mov_i32(rl, t0);
> +        tcg_temp_free_i32(t0);
> +        tcg_temp_free_i32(t1);
>       }
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


