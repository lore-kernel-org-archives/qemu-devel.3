Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE7DF94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJAz-0007aD-IF; Tue, 21 Apr 2026 18:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJAy-0007a1-7X
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:02:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJAw-0002P6-FQ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:02:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so2825443f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776808953; x=1777413753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3q3TXqWy2Bvx5GmRjj4JwHBHJOLk+sXFPKvFAVAEVA=;
 b=mg5ZNCovlFPXoZzd8OMrbdboo4nPC2Jy5tsEblEYP2S2Si/8JTCwkTx8XRMsdlc6Pl
 ZkIPfN+cUy+rEZST8f8i3fhMvTtXpEgdkMC0tMP64N5wMF8PyNvRruqHQaiRjcNXv4uE
 zvKoC2HweEHTtPeS2BR0hPXlKD6PWZQ2pLq+ZpfD6YMD+F59MDr3skvTmT4GZp/varSz
 s2WpliPGmAGY8Ri/IDrXEA892VchXe0ZfFryNYFcsX65zYjfGHN2RfJGwnY52c7FEhPB
 F42gDBBaMtmx0RrkGJ58gUyd5Aliinobqzp1YYBq7p/Zs04wPNEUKSoB9q42pnA6mbNH
 PdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776808953; x=1777413753;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x3q3TXqWy2Bvx5GmRjj4JwHBHJOLk+sXFPKvFAVAEVA=;
 b=YB4ybVbvEjqVFKP1mI07cHl8Oa4W0ruISbvsqHZ3jThF008hLeD5akngd/iGDXHS/7
 kFE7zovhqCgJ4NqzKzlbSWkqvi53uUbBwvLF1E8CD5iFkxZZNIiLTY7/cCF3Q5qeF9vc
 om77rX2R/3B1u8HDXK26HL2G8lAyxkeXiKjmLNoWCU6Gc+QeBlK+/Uw1jBpckJgsPMSD
 RvdmnhlfhhVsLCAdYEWGZodfLiHxNeEHYptC6DYxAq/oNYVqQw/2HYXAMpocXe1R/enn
 EU6COPb722P373XZbHFNBxk5JoGOv6n4n5NREc5oTu/DMA57N2vVrl5XCQY4lBx7EsDL
 /MRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cyi+kie56pcBiQ9eVGDkKiY/nAGIMKjdHwpJmKDSXvXBhcRWxAXVfieqITODUJFRGAQklL+RTECNT@nongnu.org
X-Gm-Message-State: AOJu0Yw0gZR+WIq2H0vpFfZe2nWb8k6tRH7K4Zfenp8N14lv3FDj/fQC
 Oyfq1OA3rDbebjzjUy628YJooKJX5ab88BZWXzYjAOuzS5oVQJzFfZRRtKBqQIxMYpE=
X-Gm-Gg: AeBDievwolKN0Fiuks6Qk8H/UcNqsjUDffKHaPxi8qQujlbnxKOfaDbH2W6VgQsWRn5
 pN09jf8WG7qMQdQzcHAaXR5YT+dv7oHIAYMjdAKSzf0X67qW6Zu+kW2a3x3ldvH3qVf+805Vjrq
 WAwUkGZY66u/1gnMQZywbO0zNHPatdPhlJnlgdxVZ0D46+zHaqbbJklgkmoJt+H3JDdpP+rFKXh
 UUfM6I1nhgWiohvI/F0ex6Pej5l/GDGOgeLJUUxxkXs6o3QhVb+z1gb9r6JJ+o2AWwRxHzcazLA
 VgbpqFLPBCMuPu1If/ia0NdIeaOKdLQh0RAFZrHHlpwlfLhzhG9zvUCpiRCgg3w5F9ork3pjCIW
 GyvuHv7Pv9Et1JDwTKM+GcvThCX0p0fhZgvX4qtMVBZhEAPyiiiUGOH2Fsy+XNmHscpsCUj4y04
 JeMKpgoKTcBHgnFKDOaDmGTs3An1JDRS4aY6T43Aja8qBzHyXIsUlNUp5syPlPd8TCOctLsgyle
 BFkorndkvhsqs8=
X-Received: by 2002:a05:6000:d81:b0:43f:e413:43ae with SMTP id
 ffacd0b85a97d-43fe41343cbmr19773287f8f.0.1776808952525; 
 Tue, 21 Apr 2026 15:02:32 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm40820962f8f.12.2026.04.21.15.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:02:31 -0700 (PDT)
Message-ID: <c2c0386f-7141-4845-9d95-adb3927d5054@linaro.org>
Date: Wed, 22 Apr 2026 00:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 16/4/26 23:03, Brian Cain wrote:
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 |  1 +
>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>   configs/targets/hexagon-softmmu.mak         |  7 +++++++
>   target/hexagon/cpu.h                        |  7 +------
>   target/hexagon/cpu.c                        |  3 +--
>   target/Kconfig                              |  1 +
>   target/hexagon/Kconfig                      |  2 ++
>   target/hexagon/meson.build                  | 13 ++++++++++++-
>   8 files changed, 32 insertions(+), 9 deletions(-)
>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>   create mode 100644 configs/targets/hexagon-softmmu.mak
>   create mode 100644 target/hexagon/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9a7c553dfa..ed661c9f12e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -254,6 +254,7 @@ F: linux-user/hexagon/
>   F: tests/tcg/hexagon/
>   F: disas/hexagon.c
>   F: configs/targets/hexagon-linux-user/default.mak
> +F: configs/devices/hexagon-softmmu/default.mak
>   F: docker/dockerfiles/debian-hexagon-cross.docker
>   F: gdbstub/gdb-xml/hexagon*.xml
>   F: docs/system/target-hexagon.rst

You really want to have multiple sections here. Easier to
discriminate who is responsable for what.

Suggestion:

- Hexagon TCG CPUs
   (and implicit linux-user)
- Hexagon Machines
   (and implicit softmmu hardware)


> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> new file mode 100644
> index 00000000000..fdfa29b4f39
> --- /dev/null
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -0,0 +1,7 @@
> +# Default configuration for hexagon-softmmu
> +
> +TARGET_ARCH=hexagon
> +TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
> +TARGET_LONG_BITS=32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y

\o/

> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 09d5cac4fe5..18dcfdb0b0a 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -37,12 +37,7 @@ typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>   #include "mmvec/mmvec.h"
>   #include "hw/core/registerfields.h"
>   
> -#ifndef CONFIG_USER_ONLY
> -#error "Hexagon does not support system emulation"
> -#endif
> -
> -#ifndef CONFIG_USER_ONLY
> -#endif
> +#include "reg_fields.h"

Please use full "target/hexagon/reg_fields.h" path.

>   
>   #define NUM_PREGS 4
>   #define TOTAL_PER_THREAD_REGS 64


> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 528beca3cd0..bc7a292e47b 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build

> +hexagon_softmmu_ss.add(files(
> +    'cpu_helper.c',
> +    'hex_mmu.c',
> +    'hex_interrupts.c',
> +    'hexswi.c',
> +    'machine.c',
> +))
> +
>   #
>   # Step 4.5
>   # We use flex/bison based idef-parser to generate TCG code for a lot
> @@ -262,7 +271,8 @@ hexagon_ss.add(files(
>   #     idef-generated-enabled-instructions
>   #
>   idef_parser_enabled = get_option('hexagon_idef_parser')
> -if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
> +if idef_parser_enabled and ('hexagon-linux-user' in target_dirs or
> +                            'hexagon-softmmu' in target_dirs)
>       idef_parser_input_generated = custom_target(
>           'idef_parser_input.h.inc',
>           output: 'idef_parser_input.h.inc',
> @@ -390,3 +400,4 @@ analyze_funcs_generated = custom_target(
>   hexagon_ss.add(analyze_funcs_generated)
>   
>   target_arch += {'hexagon': hexagon_ss}
> +target_system_arch += {'hexagon': hexagon_softmmu_ss}

Pierrick: is target_common_system_arch[] still relevant for a target
which use fixed endianness / wordsize?


