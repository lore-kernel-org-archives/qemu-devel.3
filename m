Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4643C3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSTU-0004x2-ST; Wed, 26 Mar 2025 11:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSTT-0004wk-CX
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:15:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSTP-0003lr-2Q
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:15:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22435603572so131225135ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002117; x=1743606917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRuv+jE4PO8e3/PC+M/1BBecSalttwEkWPvuS8n81bY=;
 b=Gbe26C57fTJz/P6wPMicz3Tv1F52XewOAIaWRG6vaWM98mbmieavoA5w5BBIEZK5nQ
 jOLo9OUwqoVhGzxLMREoVypRDUX377Um6xThQbEO1TAqSooxKOuD2Giqdav0w23KiINJ
 ZwxfrrWEZIm1emkFpwjAzcb6Bq7VlsWuT0qT1rNNFRDRuE4gRRH620zsj2YB4VKuvpgC
 g0l13//x1vdXoRu1e3Ix9yIryeTtJLT1fMyeCaAMOYdwtZbFDofex2tmSrI4LOOznSAE
 NYGuX9Brt5F43igJmlhxovgm2k+qF41hC4c65LYTyGncDFpr6vixcoFtfTSFefscnmOk
 71Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002117; x=1743606917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRuv+jE4PO8e3/PC+M/1BBecSalttwEkWPvuS8n81bY=;
 b=gDKumqoHXz+G1HxDVze1h89p0oVRcvh7bwxRZ7omCcJmSDiEnKifqJJFOA733iCPqs
 SOUWH/FQMNFeh2GQ/cKzr5EURsRtOW5ApekcrbaFCm2avAkO86NlyDoELtQOVCG9Qxfr
 +oti3nmzB8IKYiw3kyyOaDf91HSQLO5INJWPYhJMBCgwuNPCBf6ID8Vzzl0x2NVqW2iX
 szCLantVDa9fEQl7u7UlnYY7dEmQZva4bbIoxZFnDR7MafblMKG72WD+vBZfOba/BaNM
 h2IvjyIn/S5wyW2QgTE/7A+3Bf5Q7bxDLKZphiEO4khlv5svk0gLJ6YJ5jxT9quOM81J
 GGfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXorDADD4W/hVmg9JV+54rn1SnqEqGU2PEu6Elj9F+w1jQQ4ueyve56pydDPCzD+FvpIXS0fl1rbod9@nongnu.org
X-Gm-Message-State: AOJu0YxQU1pg22nIJ9we1oYXv0+/UcAlGY7eX7VcmAsRhId+aCDA1TiH
 qDWJ/YjgY3fqofxCIFzV5H35nMMmvb1QO4Cdg4Z+zeqbObHAh9C02d0aEdhSegk=
X-Gm-Gg: ASbGncsFeD/gONKxRvWanNVNVBSEbfM9zBHiKoKOxxV1SzUN6ERoVVIY391hDrHCUP3
 muN31fCpCw/qceeE5ZWheasaNOiorDaoHrEF0AlWkc1KoLh8rx73N4tJT+HskChB5L9/phFK0XK
 xFISjXMvI316uCqCQijfWk5TFJ3xsHh2qzIwM5W08XqkF4cPSlociNrA25mrauL2dLRDRBvpYVu
 TI8hzIbHK+4aGI6FWxMFu4XbL4IGTKX6huo9ZfNkpWkg407Pner0meNgJGqpdRm+AhkWiS7wUYY
 cK6ObDUX15XheldeQkYppXCSL4Li0dQhBQ8V+2+TWnUX2vUj79jdiYeWEw==
X-Google-Smtp-Source: AGHT+IH1wYx2aM7x8QlIU+2QC4Aqt6c50uUN5o0noUPD4srgy32DcX2YmCscYq7p8CdXjRyAKE9XXw==
X-Received: by 2002:a17:903:32c3:b0:226:5dbf:373f with SMTP id
 d9443c01a7336-22780c5413amr367868115ad.10.1743002117329; 
 Wed, 26 Mar 2025 08:15:17 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b2ebbsm301979a91.41.2025.03.26.08.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:15:16 -0700 (PDT)
Message-ID: <19eaef55-47f9-464a-a182-ae39e7ef453d@linaro.org>
Date: Wed, 26 Mar 2025 08:15:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/avr: Add defines for i/o port registers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325224403.4011975-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/25/25 15:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h    | 10 ++++++++++
>   target/avr/helper.c | 36 ++++++++++++++++++------------------
>   2 files changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index b49e7a7056..ebcdda20ac 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -45,6 +45,16 @@
>   /* Number of CPU registers */
>   #define NUMBER_OF_CPU_REGISTERS 32
>   
> +/* CPU registers mapped into i/o ports 0x38-0x3f. */
> +#define REG_38_RAMPD  0
> +#define REG_38_RAMPX  1
> +#define REG_38_RAMPY  2
> +#define REG_38_RAMPZ  3
> +#define REG_38_EIDN   4
> +#define REG_38_SPL    5
> +#define REG_38_SPH    6
> +#define REG_38_SREG   7
> +
>   /*
>    * Offsets of AVR memory regions in host memory space.
>    *
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index e5bf16c6b7..f8ada8b106 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -216,29 +216,29 @@ target_ulong helper_inb(CPUAVRState *env, uint32_t port)
>   {
>       target_ulong data = 0;
>   
> -    switch (port) {
> -    case 0x38: /* RAMPD */
> +    switch (port - 0x38) {
> +    case REG_38_RAMPD:
>           data = 0xff & (env->rampD >> 16);
>           break;
> -    case 0x39: /* RAMPX */
> +    case REG_38_RAMPX:
>           data = 0xff & (env->rampX >> 16);
>           break;
> -    case 0x3a: /* RAMPY */
> +    case REG_38_RAMPY:
>           data = 0xff & (env->rampY >> 16);
>           break;
> -    case 0x3b: /* RAMPZ */
> +    case REG_38_RAMPZ:
>           data = 0xff & (env->rampZ >> 16);
>           break;
> -    case 0x3c: /* EIND */
> +    case REG_38_EIDN:
>           data = 0xff & (env->eind >> 16);
>           break;
> -    case 0x3d: /* SPL */
> +    case REG_38_SPL:
>           data = env->sp & 0x00ff;
>           break;
> -    case 0x3e: /* SPH */
> +    case REG_38_SPH:
>           data = env->sp >> 8;
>           break;
> -    case 0x3f: /* SREG */
> +    case REG_38_SREG:
>           data = cpu_get_sreg(env);
>           break;
>       default:
> @@ -265,39 +265,39 @@ void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
>   {
>       data &= 0x000000ff;
>   
> -    switch (port) {
> -    case 0x38: /* RAMPD */
> +    switch (port - 0x38) {
> +    case REG_38_RAMPD:
>           if (avr_feature(env, AVR_FEATURE_RAMPD)) {
>               env->rampD = (data & 0xff) << 16;
>           }
>           break;
> -    case 0x39: /* RAMPX */
> +    case REG_38_RAMPX:
>           if (avr_feature(env, AVR_FEATURE_RAMPX)) {
>               env->rampX = (data & 0xff) << 16;
>           }
>           break;
> -    case 0x3a: /* RAMPY */
> +    case REG_38_RAMPY:
>           if (avr_feature(env, AVR_FEATURE_RAMPY)) {
>               env->rampY = (data & 0xff) << 16;
>           }
>           break;
> -    case 0x3b: /* RAMPZ */
> +    case REG_38_RAMPZ:
>           if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
>               env->rampZ = (data & 0xff) << 16;
>           }
>           break;
> -    case 0x3c: /* EIDN */
> +    case REG_38_EIDN:
>           env->eind = (data & 0xff) << 16;
>           break;
> -    case 0x3d: /* SPL */
> +    case REG_38_SPL:
>           env->sp = (env->sp & 0xff00) | (data);
>           break;
> -    case 0x3e: /* SPH */
> +    case REG_38_SPH:
>           if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
>               env->sp = (env->sp & 0x00ff) | (data << 8);
>           }
>           break;
> -    case 0x3f: /* SREG */
> +    case REG_38_SREG:
>           cpu_set_sreg(env, data);
>           break;
>       default:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


