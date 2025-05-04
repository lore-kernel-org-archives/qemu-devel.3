Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80041C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc52-00073z-Rb; Sun, 04 May 2025 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc4y-00070d-NO
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:20:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc4w-0007aO-W5
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:20:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so3519876b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375633; x=1746980433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJHceEEkeyxcT3zd6mSkgQuCloVcRXc5aoVen58Kk/E=;
 b=JsKyeS11xwjJ4LiEoiGPgOxKeHxiSXTvNq970DuM3OTsz4mgQe1BgH8rPJlfkac5eF
 eC8/y4WfdihAk8Lx4l7WRkxXCa5glP0H604exsiGzQvUm6RB2mBeKJuXwCpkvQpaMhP3
 wsuAuGHK/BhLr+XOO9yWP8J0Itw3a0enDk//btPgEvb5pgMFfR+z1g57D0DvwY0RAPUy
 prBagJsN8pkk8dcMYqB2fSqQaAXYLoAVMjdLkPDOkJwLbrKmZA+KL4EVTYnRcMlircVm
 ffNB372mCuMm0O6/7p99dY4DWqVhb7g8j5Xt/9hXuKI9IciEQq2hNslCf3CkAC00haop
 q7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375633; x=1746980433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJHceEEkeyxcT3zd6mSkgQuCloVcRXc5aoVen58Kk/E=;
 b=Lqf29zfvC20oyahMR9WH5Isqfge/7HJsTcFhUJ14fZoNeVQOL5YCYdy3tEVTt/2OtJ
 FEnc7PArZxvzuZtJ7F/N3cJ+twVSCuBMO0TOKMPkRuPTIeXnrsC6mQuQvUlVAVwRMw6E
 zexIhtWvQW1spdRvBEiGgiqj/iqWedjuQFY0WwXiaaSJ0wZb4hF5mITGzH+nJgHxd0N2
 8DNzOwtnH+4dXrXjZ6Ky+SwJrPap3Y2d/Oek+MJin4DsISVaep4IM5cn86fsqjX4dBWL
 XpdqTBUvqwYVD2wGko1U7ZLtZNrVKjAMmofyIRjcCg2BfcrbZhYa2s1q0mGEm3IM6rug
 IS/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhnmlXEm3bYfvMLzA7ZsujOa8YZ9zJI5JNBsNKDb8MmAjdzmYjy+BgNzKQquriWcycInzC8Ct4os1v@nongnu.org
X-Gm-Message-State: AOJu0Yyy0+1o2uKoY2POwUcWo3HT7nHucCNMdt/cPMaSiHP9e7Ew05xG
 Q84Pov6bVcreR2PY3rW4IRvgLSjUGdBx9bdTRv9POgHTkj5xdA10MJISc10qCow=
X-Gm-Gg: ASbGncuxkGOlrLH7qBzxvwZDcncMthIADu2pU9uyj3Ps3sFjKfoZhzi7GX/1+ilQiTd
 RmmB8kk+stRd5UcPygmzg0u4+oZVfJ3acmX86XPvnrHMth5uvwKuE5+8VHOlBqc/CtFrA+/jZ5r
 alM/tcI5dXPIlC8Et2mGxFd4kSb/KAXCN62cHXNi7uo7Pw0l4gpdFRAwYSGyGwu6VjxMmgYiW9c
 pxSQ3gTG2t03oT1dYXNV150m6rmNM0UVfdj+JtRWlDkBi94UZROqNYYajFkmu5YHiQnPxf2GAia
 663AHyEy1ByPULlUBDHyABY0g1ZIOOdCt4ag5zxFY3b7GTFr1BHuoOcEcCQik1HLyObEvNLf7V9
 6T9V5Cgsdid+kbiArJg==
X-Google-Smtp-Source: AGHT+IGtwwpdCoFgoeHENo7R8imMlsVj5gbbGhDx/+eRpKnO+uoh+dxjP4dhQqBg49qM6YaKXQNzeQ==
X-Received: by 2002:a05:6a00:6ca1:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-740589050bdmr16062495b3a.3.1746375633152; 
 Sun, 04 May 2025 09:20:33 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405905d029sm5162896b3a.134.2025.05.04.09.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:20:32 -0700 (PDT)
Message-ID: <2ce2b462-bce7-4160-b8fb-98ca2409df55@linaro.org>
Date: Sun, 4 May 2025 09:20:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 37/40] target/arm/machine: remove TARGET_AARCH64 from
 migration state
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-38-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-38-pierrick.bouvier@linaro.org>
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

On 5/3/25 22:29, Pierrick Bouvier wrote:
> This exposes two new subsections for arm: vmstate_sve and vmstate_za.
> Those sections have a ".needed" callback, which already allow to skip
> them when not needed.
> 
> vmstate_sve .needed is checking cpu_isar_feature(aa64_sve, cpu).
> vmstate_za .needed is checking ZA flag in cpu->env.svcr.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/machine.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index f7956898fa1..868246a98c0 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -241,7 +241,6 @@ static const VMStateDescription vmstate_iwmmxt = {
>       }
>   };
>   
> -#ifdef TARGET_AARCH64
>   /* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
>    * and ARMPredicateReg is actively empty.  This triggers errors
>    * in the expansion of the VMSTATE macros.
> @@ -321,7 +320,6 @@ static const VMStateDescription vmstate_za = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> -#endif /* AARCH64 */
>   
>   static bool serror_needed(void *opaque)
>   {
> @@ -1102,10 +1100,8 @@ const VMStateDescription vmstate_arm_cpu = {
>           &vmstate_pmsav7,
>           &vmstate_pmsav8,
>           &vmstate_m_security,
> -#ifdef TARGET_AARCH64
>           &vmstate_sve,
>           &vmstate_za,
> -#endif
>           &vmstate_serror,
>           &vmstate_irq_line_state,
>           &vmstate_wfxt_timer,


