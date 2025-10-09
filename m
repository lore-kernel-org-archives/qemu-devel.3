Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8063CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uTW-0006F5-Kp; Thu, 09 Oct 2025 13:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uTS-0006Dt-AA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:30:45 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uTM-0003is-61
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:30:42 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b523fb676efso933090a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031033; x=1760635833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2NSx8Y4MzlaHnSGXJ6BLv/wPvceFVbz/+V01eaXifs=;
 b=VFJrbituHFcPqRmwRNB8OXWhql5CR1txhulXetQYp6Pv8MiBGtno+vkXv8FNHBzvCS
 9kGPbbpYxi3QE0iuDqjr6T+dc3v1B7c+Y29CFItNyfCsf85ez8RRAB1yApnk56fyctus
 5HBj3fEMs3CodJSGUQN+0wMeL7oHrb2cyFCbhZBzy4WH5Byu6ly0L9VSdqmaCxxOH9kv
 Tmf6d07ELMfTy2CmNqqCjETQgCGdWskdvcEUx4LYE3MzCj3JIRmng6Gp5C3MNcBHIXM+
 S0L482w4yr+VBTh51g/LEcPxfLnBt+Lunh9yEIGGXiI1YbhX8fPymxoDSAEMIQjmZJ3l
 XrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031033; x=1760635833;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2NSx8Y4MzlaHnSGXJ6BLv/wPvceFVbz/+V01eaXifs=;
 b=hznK72IzQVTFlr6EJhlmp09x7BUolfdgYa4fertj9Ae0ZAPaWcwh0y2RBY/aCUfOMr
 Rr3J7brFyNZ/ecZOUueSvMPfnIcvJlZ+DVwx33P01raFmgbVt/wSbEPWbWtaIHDCR2AL
 qvExQY8wpLE/H+Db+cqUm7DJraEL6zOUBxiwuHSA/dYasfJ8SfsAxYyGyUw3QYetobIN
 lzEHmJwTUAI28VxqMvyzDxdNkUg/18jdyCmJn6o3KRHZKrRk40cZR61EfIxfhtiGjHbK
 XA9MeLtRQMUq3DB8BsLZ+YFi7+tWj42TSlA/LwGDUIb7o8O6+XjmD66QNXkH3cSHH3BH
 w8KQ==
X-Gm-Message-State: AOJu0Yzo1h3iN412MtzM2TVnNGfCDH1C1Qr00qPxp0giMIqa9cfl3ys0
 znZ2PZgDD4J8Bv/139d1oz4tdBf3ArJQ8vDC2q6zTB5Yb9TAVpwpTlnz6oZQzg3x79wXYCkvJxE
 QLwiK80k=
X-Gm-Gg: ASbGncslqmywKPIrDwGq7nW+xC7GGrd0KCHP1QyiDZ1kUfWPlQROj9W7N6WOxL3AEaW
 0G6Tn87t0+Ai9vvWZ+qX3PUdJ09qZEhh/Sk4n/jd5G0Our1r7Rj6v6e71yD//qVCjVCGyW69XMS
 R2TN1sZXf7X6KShi4btNAtGepWs6GAybn9vMoAeGAgdk4n/U6reFh1qWseXZvqWX6NgrNZV+lLS
 vtdBGGl973JmaQAuAALnSkUMNuIMsXSOGULeJsiWpVHRgpikyFSrBKul1xMKyWZCJZBYQUw06oi
 NxAOPtZBn/WFKClyDkI+PYntdHr57ID5p00Q3M6tOYWMXOT6nAYVZRep18gYOg+7m9jbSBjQRi3
 kC8FhCkPW6pq5ms9iwD1Z+QCcI+zBGCYmmePycl8A80R03vXjmBx9onak+F4jpiU1
X-Google-Smtp-Source: AGHT+IGnR0qQQov8Pq/bARVlKvgE2LtxL8I3oy2AvgYcoQtyTUUHil+qlE1b09yfkPGVDRrFQKd7fg==
X-Received: by 2002:a17:903:ac6:b0:28e:c9f6:867b with SMTP id
 d9443c01a7336-290272c516dmr101938895ad.23.1760031033235; 
 Thu, 09 Oct 2025 10:30:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de6de2sm34575555ad.18.2025.10.09.10.30.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:30:32 -0700 (PDT)
Message-ID: <660c0abe-ca16-44f0-bcea-2a752f5137ec@linaro.org>
Date: Thu, 9 Oct 2025 10:30:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] target/rx: Use MemOp type in gen_ld[u]() and gen_st()
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> The @size argument is of MemOp type. All callers respect that.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index c22ca78a055..9a2be2107bd 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -161,19 +161,19 @@ static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
>   }
>   
>   /* generic load wrapper */
> -static inline void rx_gen_ld(unsigned int size, TCGv reg, TCGv mem)
> +static inline void rx_gen_ld(MemOp size, TCGv reg, TCGv mem)
>   {
>       tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
>   }
>   
>   /* unsigned load wrapper */
> -static inline void rx_gen_ldu(unsigned int size, TCGv reg, TCGv mem)
> +static inline void rx_gen_ldu(MemOp size, TCGv reg, TCGv mem)
>   {
>       tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
>   }
>   
>   /* generic store wrapper */
> -static inline void rx_gen_st(unsigned int size, TCGv reg, TCGv mem)
> +static inline void rx_gen_st(MemOp size, TCGv reg, TCGv mem)
>   {
>       tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

