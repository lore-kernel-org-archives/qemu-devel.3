Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ACCC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBDM-00024s-J2; Sat, 21 Jun 2025 23:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBDK-00021e-Fq
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:17:50 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBDI-0004n9-TQ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:17:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2363497cc4dso26496605ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562267; x=1751167067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yxFEOYMEOEx7ADBWBHMZ5HVwjYGTnoH6TPI4kbIkcsA=;
 b=buNH+rWYyIOm4oLh7FP16A0bJ0Q2eXQacRMv5n00Ebb0XYV266sNRC7w3FwC+K3aIK
 zjEtSWqC/4dtj7bmLiTsyjLTn9y/j+nD+ZSXvqH2COLHIkUfhmws7ZHpykM16QRGL8n9
 +uqjIMK2qBKfD39EjhDGhpUDG1lmwRYyGpu7kHAYC11r8wt0abMmO3qKySzQQyzaSuRU
 DkCPssRAMQ18DNn1APkp2wMOuWZAo/3KvO3/F3lvJ9wrWxExnEug1ndXFfzplLvC0F2X
 HusEVRH0X+xYaOM8/46WCXTbSph9iDvkdTbd89wPhnM3tOzTIMSg9OK35wy189wknC9X
 9+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562267; x=1751167067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yxFEOYMEOEx7ADBWBHMZ5HVwjYGTnoH6TPI4kbIkcsA=;
 b=ukRPJ0QNYCbeOGmKfoaeLA5wV3uXAibnYlQN/uNOKo3pjglW7LEsudB7XUv+XaL7Pv
 S/W8EcrjtpFTqMxgBCOW7zGam7oGC+t2WU8U8d9QO6vbgLI958QOMVBRIcc+xsZkCoXt
 I6v0Bfp+tA0WiQ7MWi9YpsnVUZCvQIofjK1ho72Ny6zkeqMpyJjMekWsJwibuteF8sef
 GivxfDPwAeHmQKh5fDMgB8g67yRf85lLPFVZ6piOvo4Toiu6yaur3M3yGgNAiTCz70q6
 V2l4Mqh8z7wq1iwkrB+0axHJFCWAvsprIi7qmEv0VBAdsHmPEEWW4LEHKMHJIidy9fkv
 YaHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfE73/R0v4vvEnEXFxDnh5rnBPDb3tSMbD+gjmHzxRbm/CYTaXmAgWazu5bK4c0EI0l3koUbdSMMxt@nongnu.org
X-Gm-Message-State: AOJu0Yyx9yi7eNiPgV391H37K2AetaHbP+HV6Ot3ZIk3O0jrO09lFhjt
 TM2aX/zKjR2V1w0+7Vk35/WAWKzi+rJvIVzTUrMOarwjgrA3c/Lf8YyfSrLikv0QII8=
X-Gm-Gg: ASbGnculwoFg7TVX1B3RIsznrzv2T6402DF71Kmlh6ZTMbzH3OTacfFU9/i8ah/EjEB
 hkfbg6zeBMunuw4PydGF7/g1bBlHgSTNQpX0b5t3sjYvNFCg+D5jJDsd/1HQ6D8tocRghg94z/z
 Yls5hyWO0YtEBHUUqicbd42UQg3GAF+FLO3hlNuAGgCupAggRR1fx+WGght8f3Iy13syXAvuXZA
 7st2R2481JwFB1AJlIndu1bx7OdIZwy9/s7Q/4afYJ2OB02B5EaRtXhpGfoPfHeoOH5Eh5oYsTB
 f46qaH3WCAS265B9dTmcXCifzf/DUS5FzMGtaroGsB7NVWPVu2zJcwC7ob/zjzJfd1Z2+7LidIJ
 B7uCzCF38pofiTYJkBs9bcs1e6JWg
X-Google-Smtp-Source: AGHT+IEGcjgLP9TfLwJC+Z0A1fhEIEHttqDWdJ6+wo1ScMxl+FnaYEBlb97p1uFWnVZJ0Gr9DBMwhw==
X-Received: by 2002:a17:902:fa4e:b0:234:a033:b711 with SMTP id
 d9443c01a7336-237dc1d4cafmr82893385ad.50.1750562267523; 
 Sat, 21 Jun 2025 20:17:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83c7d45sm52205665ad.55.2025.06.21.20.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:17:47 -0700 (PDT)
Message-ID: <0f2aaf87-7c04-42d7-bc75-402e5022adc9@linaro.org>
Date: Sat, 21 Jun 2025 20:17:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 32/42] accel/split: Implement
 insert_breakpoint()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-33-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-33-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 40cd39aea5c..eb52d690c7c 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -258,7 +258,18 @@ static int split_update_guest_debug(CPUState *cpu)
>   static int split_insert_breakpoint(CPUState *cpu, int type,
>                                      vaddr addr, vaddr len)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +    int err = 0;
> +
> +    if (hwc->ops->insert_breakpoint) {
> +        err |= hwc->ops->insert_breakpoint(cpu, type, addr, len);
> +    }
> +    if (swc->ops->insert_breakpoint) {
> +        err |= swc->ops->insert_breakpoint(cpu, type, addr, len);
> +    }
> +    return err;
>   }
>   
>   static int split_remove_breakpoint(CPUState *cpu, int type,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

