Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAB7C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuayH-0004Pa-3X; Tue, 18 Mar 2025 13:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuaxb-0004Er-5h
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:42:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuaxZ-0000HK-5V
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:42:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso26581345e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742319754; x=1742924554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=17SVMOF/Nhdsp+4dVpqTL9OX4gq5t4F3wmy4D//jp7U=;
 b=thHJ92FEme+efF+vUJY5Vbekz+nxjFSM0/2TnxpDW4N1WnZu4JUfbSlL4d93mNJpOA
 DlG6tbTsXDhfrrhhaASIjPgsGGb4SWwo2RjHHPhkQaxtQz/dy0IYFI1YvT2cT8GGkQZa
 l3dd3Nk0Iq+6g1w2Dfnd3cL+BldfhEMrUTJwiD74/P3TzO3urRVezAP6shJDVkKMl5td
 AVhENo9kdkmr1bN21ivUjJiX8UGXIaD+7ID44pVgXC8/XGs3bt6SoS114BOzmFSyG6Z2
 MOjcshGI7jqTMiUf9jsJA8QeYk0kCOkR7gxZ/WvGixx13h4wp3lp1Ots3N5u53drm8tH
 Pd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742319754; x=1742924554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=17SVMOF/Nhdsp+4dVpqTL9OX4gq5t4F3wmy4D//jp7U=;
 b=thJTv+Cq0UeEpIhpLcsgHTa9CbX3YjvPgZMVfJMrTk5X7LQAbKd0bWB0Z/vPulCcFi
 KffDP/cz408fV31Z7NUXJYknM2xWmvOdz6K7rIB/s+q6RTGOCy9PvKDM+U6LN4oJ35TY
 0haS3F7U6erFA8C1KR3CMYEqjht8qzf7XtRFhU9KvFVCgEa64sjuAQzpq9WoQzgRTiLm
 TTRIKpdJUmb42IZ1fRUcCOGectA68GAAxNm5vXLo5PQbUsuTlOyfHPLE8cx7D6loraO5
 FN+/SISUeovqwrUEp4KaxkaZQO3tB2EfMVFzR7qG/tfrKl6f2tKl3K65KKlP434TXc65
 6yQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqetlM/LMNQN7gE4yg96tAOXtWPWa7Ub0PwIUp0ihrPwnVw8YKVBQStcC5LGc6X1DRoOnEVUpG7p8+@nongnu.org
X-Gm-Message-State: AOJu0YwX92lnmnQlCpMQXmCWFudrULFyRCGa27MnfOD7bGCP/b5BlgMV
 LT6MS6VDIHrC5vZAqlA098Dv2wx/D/5Eh7mNQBCe2ghrTDN7GyMy2nisUCBTeTk=
X-Gm-Gg: ASbGncuMNsdrx4sqOSrX12l2Pjkd1ftGc1aRPrqoJ+IOowyOwDX6Oi12ONHU14du5AU
 dcx7Dc+5my2ocYoe2lzPC1GZhoaxs1td0f1SWFwIX+u+h/Pmc0iQgIwDVSQQ7bXHBkAjOllvdba
 CeFin6+bmBGkN2LxGdjNGYqfeTyptTk/1olMOtGerzpyLDPdN/NyGDKUbwJPp1jMezsjeB8oJN7
 fqnVsajmiG9DlPmT1IFZyzFOdoZCe4FkklaEhuoZcJklcYk8OiBavd4Hl69FvONqYSfT6bc31Rd
 R/Ys/e5xO3MoOtJcJG9XdfRL6pJ836mGAevGmBz/gcBfvysqry02Ik1Bt4TuW4DKZkguTOtHv+X
 6S/4jQ3vRQ2tI
X-Google-Smtp-Source: AGHT+IHNhODWTF+JiipsrlWDdQ9MdXQw/X10v5jVQIbHnGx/mcJwin8Hy3ZzvMzwWdXdLV4Tkjm9qw==
X-Received: by 2002:a5d:6da2:0:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-39720966395mr18326969f8f.43.1742319753993; 
 Tue, 18 Mar 2025 10:42:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cdafsm18871927f8f.62.2025.03.18.10.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 10:42:33 -0700 (PDT)
Message-ID: <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
Date: Tue, 18 Mar 2025 18:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318045125.759259-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 18/3/25 05:51, Pierrick Bouvier wrote:
> Directly condition associated calls in target/arm/helper.c for now.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h    | 8 --------
>   target/arm/helper.c | 6 ++++++
>   2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 51b6428cfec..9205cbdec43 100644
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
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b46b2bffcf3..774e1ee0245 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6562,7 +6562,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>        */
>       new_len = sve_vqm1_for_el(env, cur_el);
>       if (new_len < old_len) {
> +#ifdef TARGET_AARCH64

What about using runtime check instead?

  if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && new_len < old_len) {

>           aarch64_sve_narrow_vq(env, new_len + 1);
> +#endif
>       }
>   }


