Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BDEE88D6A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8mLh-00021v-8g; Fri, 03 Apr 2026 17:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mLf-00021U-P3
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:46:39 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mLe-0006KB-9q
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:46:39 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35c1d101355so914572a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775252796; x=1775857596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VjZVJYkFRske5nr2f9ZJZDHuMecbtzMWsssBKoJKSyc=;
 b=Y/Zzqd5FlIR8BUEjq18NKnnTDPMnagNR8P0UUOem5ZryS3qH73u8TDv3+mEDjV2RkP
 A7tzuytUit9OIuLNhV1Sez2/062wBGoxpwX1dno4o4SMv0hM/7PLwZanXINZlUdU2EHH
 AVRPGr+AU5WhZMk+oX1O0JDxFmKv+lHTxcrB9CU59eyVI3oG7h3VdPYgnXmgg5WF50ip
 qJnAaAHlVoKq571LNIuYsjc4Oqkg8jKFbx1wx5+UoujYFKI4joZ/xIog8kqH8w/a+ObO
 tDFEzMAwZ7fyd4CYSAckhHihHqHay2xB7neoJBsQuhB5Mg9w8rJskGQCwzqLrqRCNZyn
 K4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775252796; x=1775857596;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjZVJYkFRske5nr2f9ZJZDHuMecbtzMWsssBKoJKSyc=;
 b=DOqs5A1ruDA8UhOD9DcI8MPNWuVbNrU4OS9Y+o9WwfZlw5vCa5MMt0FIJJJLVMCjQV
 ynZxjWjXJFQUYuVzqLJzFH43F6C4uXQSm/Ek+EvRACFP6JBQRQ3nEoxz1j33IWcq+ydJ
 hhxjvufqBgCGdkIxxDLm0x3ZnWwBoj3cmB0ok1IIVYn/zgJASXqZT2HjWMggp5QC3rJx
 uTdtm+mtlfzwVC4hH5vK2lYuWsqNE8SJAh3FOqSJbzSudUQNb7AJHnkcm1VOZFWX7El4
 M5cJnGr0NOIkN2wcO0XjQKe2583gnD51yLhxgGNe5bWMnO4ZFWEDb6DSIMhhejhuH22i
 wkRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLEeZYeDGEeAm5662xzYuVIvAdZVDDZiaoiLmPylTiylzSCuuP+ramahNVsKbr6Zy1Armp/XMusbpk@nongnu.org
X-Gm-Message-State: AOJu0YwEgWZsgScOTY89CFBCRMbe7kpavMjT3qrrqCJ9QP3IY33h8GXE
 W5BGfaFbYe0JJoP22WzEHLQyc9DquPwCpR5d6/aa6f9mWfCz5PvvSksbgE3GEjak5kU=
X-Gm-Gg: AeBDieta8ly1ISBxYYojP1zLsM+lMzIcUcY1FnFHHcL219aUzsJi73zH1MIm8qbgn3A
 Pd0g+HdA+whxaRrP74/B8OXRpdOKzA0Ph94MAdGOgH2qxdoMSPTnQGPRiib55vDg8zIlhEO0QKQ
 RZZzWkXNauaz01Cb7tXxIegXhT3e/vOOiaRocpuwe2ryeZD4qU6EejR7q4eLLs64lzWXulHTuIZ
 TplRZEiDGWetBXihBIn1own6stw5M0wZ1bUfrajuUZUIYm2Kj419D8yxuIWk/NPNFOZyX8Qlr1Z
 wXZGnuss5Vxa866TwjKjzDd6Szv411me5Bs1bSSmC1+xbkJY5TWa4lTD8Fwes7Wr0FeuAglgOri
 X1Fnqqxyg1ERF1rA/4vhCFt9Co8zqQt2qod4azlYOevas5V1acrFZ+8FTbcSEjWnucp6b9stPAZ
 It0GQOW2SRFyJmp7DRQ+sBoI4Z9CBihcPMUdCJfFINGvQStbUnR5bX4DH8AUeVNHM4p6c=
X-Received: by 2002:a17:90b:17c1:b0:35b:e591:99d1 with SMTP id
 98e67ed59e1d1-35de69b8929mr3529440a91.29.1775252796508; 
 Fri, 03 Apr 2026 14:46:36 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35e34eesm6630377a91.2.2026.04.03.14.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:46:36 -0700 (PDT)
Message-ID: <76cec745-7b22-425f-a7b1-cf9f7d2786bf@linaro.org>
Date: Sat, 4 Apr 2026 07:46:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] target/hexagon: add v68 HVX IEEE float
 arithmetic insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/2/26 20:47, Matheus Tavares Bernardino wrote:
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index d7f4df5f96..d6ca51f175 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -300,6 +300,9 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
>       /* Default NaN value: sign bit set, all frac bits set */
>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
> +
> +    set_default_nan_mode(1, &env->hvx_fp_status);
> +    set_float_default_nan_pattern(0b01111111, &env->hvx_fp_status);
>   }

Do you still want to detect tininess before rounding?
I would find it unusual for two fp units to differ on this...


r~

