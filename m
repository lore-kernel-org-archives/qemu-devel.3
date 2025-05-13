Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE01C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmKQ-00048U-Km; Tue, 13 May 2025 05:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmKP-00045k-G4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:53:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmKN-000651-E9
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:53:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a1b8e8b2b2so2803822f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130012; x=1747734812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uegRBGm39O320n5AE4KfodvzaUeh9Gf3K56Wk7L20XU=;
 b=cQvtaf1NyVvMIlROfRTYRaCJ8SeyTlpeheO5oMVL9jLCmqA6p+Yknk/0j3Ay+6s2Rv
 UWxv5z+qNqNZv6VSfThym+9rd/10419LNF97tPlRvLE/5zMo5P4zl3BFmpt8pjB/UnE4
 IQi4bKAhqjE8sG6H/pBlqz4M3k206ROV3KGvn67ansozsT1L4f5YXBfy7KDPL3qK+MjU
 NQ5VBaZZgFwZyBa1eD/xyxzz7oSCU+EIvOdfHtKr3jmFBuHRI7ccvCv/5w6Y5mEqa9R9
 02TJ+HB97BESVXLP3tbnzghg5Hb7+wVi3I5Wz0k8iFU6nFT3PQlhMU8/tqsBivLA3g5I
 8Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130012; x=1747734812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uegRBGm39O320n5AE4KfodvzaUeh9Gf3K56Wk7L20XU=;
 b=AnK3Xkkrok0AzQs+3CLbjOx2E8awzbVvQs005+eYevcnENUUkkVrmvrOee3zU0ZFfx
 c3hN9gSSOrOYaNSa/7Fs/7DKj+oTV6p4JSQHByxUZeUMu32CbfC2Cj527Hg9Ds/UW+GB
 xTOdreLOJDTzRu6o+kSfLVtWpXvNsn6+Bx7fKtxZroSHJ+P6lR6ijipCnc0dlII0Xjo/
 qJEILoIecJh45sb5MyiddrX3JB+NSc186PuRS0qZCBiIXgW8tMFelv9v+GKpK2A5RjhK
 DOBSggH+YaNp3v7rzNh9wnNayULZwTZFXb2p/cFK2U1yoC99teB5gLge5o5wmzQjQkCs
 /e4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEfvFdeHtZB7QscqbMtl/7AMQLmTzf7LLwaykXEXdm3VR23jKNTv0RDKEwWr+o28Rk4CW/LK4ZkNKk@nongnu.org
X-Gm-Message-State: AOJu0YwMlpQzPSdQmQ9ICmmEmpZo0Mk4Aus8QMe1CEBc0chlgZ34mitm
 WTBNZmUg44u95iov0eIVOSmEEZJMV7MaGV9PVTLsI4w8/mgQY1wbgVLvUjq7V0E=
X-Gm-Gg: ASbGncv7j1vcXac+l3B1f2IMLtEjAozLMgaJwiiShaeDn1KpZ6bIOt3JpIPpSBeCbT8
 JYWwMLL4HdD19hj21hcV+rmr0J+BCcOFtQjAxECaJvogULHbVXzE0yeCum1WTgb8UuJpGmNLfgx
 y1eRC2D5+TYcMOuML979eHDgD3MjhW78CYvtAX5TL4WDL5J3eohHVk+P1XmIaBSPO9IA8x0OXVs
 /SSP25rYLqn+oqb2uqOD18IwDvclJ1a41Bpw/QW6/e2wLDnu525u9Dz+InqHMlxw7QEHo9pNfAV
 l5tS8Hhx71Xzf6JKWvTLLdSMwVTVqMLUQYgoiaIlTUhMuMxvPs+OOlliHSNtaPm2WoB/4yrn8uI
 FmaEqgojStlTSaNBlpjAcSQ4=
X-Google-Smtp-Source: AGHT+IFv6Pcu/UGTmmvL8IPjJ6GqDfkzRvP2bfTalj39+8prBqUMkLnVMKblNt1CUJKOVZFr7zqe3A==
X-Received: by 2002:a05:6000:18a5:b0:38d:d701:419c with SMTP id
 ffacd0b85a97d-3a1f6482ba5mr13962597f8f.41.1747130012128; 
 Tue, 13 May 2025 02:53:32 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2f4sm15544504f8f.78.2025.05.13.02.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 02:53:31 -0700 (PDT)
Message-ID: <2f16acd5-ac5d-47a0-9eee-4af2d17a1288@linaro.org>
Date: Tue, 13 May 2025 10:53:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Compile common_ss files with right system
 header include paths
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Brad Smith <brad@comstyle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250513083343.148497-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513083343.148497-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Cc'ing Pierrick for 6f4e8a92bbd.

On 13/5/25 10:33, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Since commit 6f4e8a92bbd ("hw/arm: make most of the compilation units
> common"), compilation of some arm machines (like musicpal) fails on
> certain host systems like OpenBSD 7.6/7.7 since headers like <epoxy/gl.h>
> don't reside in /usr/include and we currently don't add the right
> CFLAGS for the common files to include the additional header search
> paths. Add a loop similar to what we already did in commit 727bb5b477e6
> to fix it.
> 
> With this fix applied, we can now also drop the explicit dependency
> on pixman for the arm musicpal machine.
> 
> Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [thuth: Add commit message + changes in hw/arm/meson.build]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build        | 27 ++++++++++++++++-----------
>   hw/arm/meson.build |  2 +-
>   2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 5ac64075be7..7131aa2b21d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3228,6 +3228,7 @@ config_devices_mak_list = []
>   config_devices_h = {}
>   config_target_h = {}
>   config_target_mak = {}
> +config_base_arch_mak = {}
>   
>   disassemblers = {
>     'alpha' : ['CONFIG_ALPHA_DIS'],
> @@ -3419,6 +3420,11 @@ foreach target : target_dirs
>       config_all_devices += config_devices
>     endif
>     config_target_mak += {target: config_target}
> +
> +  # build a merged config for all targets with the same TARGET_BASE_ARCH
> +  target_base_arch = config_target['TARGET_BASE_ARCH']
> +  config_base_arch = config_base_arch_mak.get(target_base_arch, {}) + config_target
> +  config_base_arch_mak += {target_base_arch: config_base_arch}
>   endforeach
>   target_dirs = actual_target_dirs
>   
> @@ -4099,28 +4105,27 @@ common_all = static_library('common',
>   
>   # construct common libraries per base architecture
>   hw_common_arch_libs = {}
> -foreach target : target_dirs
> -  config_target = config_target_mak[target]
> -  target_base_arch = config_target['TARGET_BASE_ARCH']
> +foreach target_base_arch, config_base_arch : config_base_arch_mak
> +  if target_base_arch in hw_common_arch
> +    base_arch_hw = hw_common_arch[target_base_arch].apply(config_base_arch, strict: false)
> +    base_arch_common = common_ss.apply(config_base_arch, strict: false)
>   
> -  # check if already generated
> -  if target_base_arch in hw_common_arch_libs
> -    continue
> -  endif
> +    lib_deps = base_arch_hw.dependencies()
> +    foreach dep : base_arch_common.dependencies()
> +      lib_deps += dep.partial_dependency(compile_args: true, includes: true)
> +    endforeach
>   
> -  if target_base_arch in hw_common_arch
>       target_inc = [include_directories('target' / target_base_arch)]
> -    src = hw_common_arch[target_base_arch]
>       lib = static_library(
>         'hw_' + target_base_arch,
>         build_by_default: false,
> -      sources: src.all_sources() + genh,
> +      sources: base_arch_hw.sources() + genh,
>         include_directories: common_user_inc + target_inc,
>         implicit_include_directories: false,
>         # prevent common code to access cpu compile time
>         # definition, but still allow access to cpu.h
>         c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],
> -      dependencies: src.all_dependencies())
> +      dependencies: lib_deps)
>       hw_common_arch_libs += {target_base_arch: lib}
>     endif
>   endforeach
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 5098795f61d..8e3bf495dbf 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
>   arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
>   arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
>   arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
> -arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
> +arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
>   arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
>   arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
>   arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))


