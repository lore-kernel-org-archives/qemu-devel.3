Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B4CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XSQ-0002dL-1f; Wed, 23 Apr 2025 06:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XSO-0002cz-VR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:35:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XSM-0006A3-SR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:35:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so70719265e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745404552; x=1746009352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Cci1q2MqOEEjR8mHsIcoWBuM8IIoi4/eXXTYv+/9LI=;
 b=nS5etkhRKH2zJ/ZFxTJ3xvFGvqSw7fub7R1glRvZj2YDw3xwZu/EQDgCedkad/vW0M
 nvPCBiL+CZINg1gg/tULUICbsscPc2Vfgm+yDWlKbE5Uo4ep8+FYswT/KLEEkPKAaXna
 YoRpZXvf7C9nWsrA8dgnpiyxPPwqbiaUiFA6c50XrGCtVCaHWPVL2kxVBYJ5+0gNw6fM
 89JuWojLtAMHNjD/QYlmxWBsWcfe+M/XVq15A5tDDg6rKzHgMvgmHB+dTZuU3DhZUfTB
 Awa/6jRwAPCoLyxTr0Bi7dZ9kiUyW/S5bzpLBctNhU1HDvLCoTH3f6mCfgh9gByiubP5
 4k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745404552; x=1746009352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Cci1q2MqOEEjR8mHsIcoWBuM8IIoi4/eXXTYv+/9LI=;
 b=Xr/AiyRrMGPHMYjz6ZxjoeECdejy2uheawF6TW64t46Os36MAk6vYjdd6sLcO7+jH6
 P5M+WqNTlvPWfgbXajYvllLq9uSojqNfknyirbCTQvugOwgAHhhkfJI7+Ig/A7xzlK3c
 FaWkH4Hsi5IUYIRgh5VayqcoZCWAeEyokCZ7kdptLnBXmP14aXYhZTsjbWVwFsQns/Kr
 /qR9CmJcjMA0XhfQvxoiOOOffv/GdtuLHMnfStUzIgyndSI3y4kB4aNs1PL17HV2G9Jg
 ic6Or4t75DKlzh+UK4j3Wy7Zt0AB8uZpj0SQCnSd327qhM+zErqdWdR9mJoriaGyowKU
 tTXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrvDgQU0P2jlhQPDfe229a03bhGobQSuI/cGFN3iZG//iwbflLnG2vABIj0DznQdkKz7DGs4ZSRiyW@nongnu.org
X-Gm-Message-State: AOJu0Yz9EZI2cZ36+6kmxt4caKzguvH12VOYLwZE6IgJeRyGIUaVRh3v
 tbGbF9+LlkA3geWUJjTfKr8wEh8Q5keUriitk1nbEyPKWOnLLlOBLUkdbw6ut8U=
X-Gm-Gg: ASbGncvqua2n4OqRl3StIDuNecncd1ilCwZIw7xmFr3LUdlNLM+aFYkcSypD8w/vme8
 jZywlIzImFYjfyYeeie53PAOBnWr9C0S/D6Xt7fVrCMN2AL1b7+w1B+OVZUrlzIWOFRtkuhybgm
 UiP3HRklMPAaSklqpMOJsnw7KbTscBB2ObAjHnOxp4ahrt9R4gDTFPfDeF0oOCCpY2Uvwm6Zq7L
 0i8AyQAmnSrtEmxmeP+D9V3THCuAt6tEasAUhIGP7H1Qb6d3hjkcndMRDpmlckG0OGL+f35ox3j
 u0gzta89AWaB7xm9IBEnGLO7yE9xMyXdGAv2gZcaCN5cS6eZKz3LnZR5/Sa2F+/RzVkK7hjB77K
 aEH9L1gBK
X-Google-Smtp-Source: AGHT+IG4DFlN75eE7zJ+0IrN1EU1bwAvz4efPX2WBuXw30xOrR621YeDWeBwVygXN1X2R6d4KZiitA==
X-Received: by 2002:a05:600c:5491:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-4406abfa9d3mr142762065e9.22.1745404552183; 
 Wed, 23 Apr 2025 03:35:52 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d21720sm20904845e9.12.2025.04.23.03.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:35:51 -0700 (PDT)
Message-ID: <4a8da7b6-7773-453d-b704-0991caa3cd97@linaro.org>
Date: Wed, 23 Apr 2025 12:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 118/147] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-119-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-119-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Directly condition associated calls in target/arm/helper.c for now.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-23-pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h    | 8 --------
>   target/arm/helper.c | 6 ++++++
>   2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index b1c3e46326..c1a0faed3a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>    */
>   void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
>   
> -#ifdef TARGET_AARCH64
>   int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>   int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>   void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
> @@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
>   #endif
>   }
>   
> -#else
> -static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
> -static inline void aarch64_sve_change_el(CPUARMState *env, int o,
> -                                         int n, bool a)
> -{ }
> -#endif
> -
>   void aarch64_sync_32_to_64(CPUARMState *env);
>   void aarch64_sync_64_to_32(CPUARMState *env);
>   

Should we complete squashing:

-- >8 --
diff --git a/target/arm/internals.h b/target/arm/internals.h
index cf4ab17bc08..f9353887415 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1810,7 +1810,6 @@ static inline uint64_t 
pmu_counter_mask(CPUARMState *env)
    return (1ULL << 31) | ((1ULL << pmu_num_counters(env)) - 1);
  }

-#ifdef TARGET_AARCH64
  GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
  int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
  int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
@@ -1820,7 +1819,6 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs, 
GByteArray *buf, int reg);
  int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
  int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
  int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
-#endif
  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
  void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
  void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
---

?

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index becbbbd0d8..7fb6e88630 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6563,7 +6563,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>        */
>       new_len = sve_vqm1_for_el(env, cur_el);
>       if (new_len < old_len) {
> +#ifdef TARGET_AARCH64
>           aarch64_sve_narrow_vq(env, new_len + 1);
> +#endif
>       }
>   }
>   
> @@ -10628,7 +10630,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>            * Note that new_el can never be 0.  If cur_el is 0, then
>            * el0_a64 is is_a64(), else el0_a64 is ignored.
>            */
> +#ifdef TARGET_AARCH64
>           aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
> +#endif
>       }
>   
>       if (cur_el < new_el) {
> @@ -11640,7 +11644,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
>   
>       /* When changing vector length, clear inaccessible state.  */
>       if (new_len < old_len) {
> +#ifdef TARGET_AARCH64
>           aarch64_sve_narrow_vq(env, new_len + 1);
> +#endif
>       }
>   }
>   #endif


