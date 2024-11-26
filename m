Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63F8D3B980
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtWg-0002G4-PH; Tue, 26 Nov 2024 06:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tFtWf-0002Fe-Pd
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:14:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tFtWd-0000h0-6w
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:14:37 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21260209c68so48019905ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732619673; x=1733224473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8n9zNQNjW5lXFKwRJkPzIpvd1d97fLYtXwXsRX0/USI=;
 b=OlQ2qV+XXwY+dsi4+8gM7FnkqNGZC166sUBQLimClFfstCFjIS/fSXEKNd20YYiaIm
 4ydzuw9bCgh0gxMnnZ7+QruZvaSQZ2BLWMjNce3631OvZRnwRtnAgt7TMt9rvwtoO1Yl
 RiTtWfzMW+8Wh7r+UlbydHthf8NQZDt9ia3MgotisSqzQWCR86diy9IpsMfahQWcuHFI
 /A/d15Nr5mvBk5Qk/bRd6CTvkqQqIMyQbIFwElK9udtYRjodT2Qv+GWQ8cJypxffR8vZ
 43kpS9Y3jJgzniHIVEDgXJceeVyybah0eVAap2RUD7njl5284UoxfsGysCSmfT4p4NVu
 9hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732619673; x=1733224473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8n9zNQNjW5lXFKwRJkPzIpvd1d97fLYtXwXsRX0/USI=;
 b=TaUuNq8Z3T3SNqcFPTrzyQod6PDvogyXI8/W4ojQSTNEUE+Iq6e4D97pvU+16/uh7T
 n0CjwSv2HSoUtsNTfrtO+ns6Zp+FcRreszxoVssQvEgAGLRXbOe8sHCwkhiZuggXSmoG
 w8ko6Ha9BjaiGHWPa5e++RBVCt+PAt41an1m6U2edEdR7KK1OXi4KDVFJwj2EXtAGXrS
 UL1oBK6vtzYPgOrge2diJuNPPbN5Feh5I7pI42DVeQVe1TtWG1T0TNCvRvMpyB1SZO48
 HCQ8xZqvpHF0j1XYZ98rvnb9J3n6CmBlj4haOV4jMSuaHAiafJ5L/KQ4r0LFy6UHehzF
 FUVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvqPzHHahHNjhsFaLLUEVzyu7c7ZzaFweFxmWfucnNfpRI6APDkdsJWSBQvLY0QG4ETJcmtHMbIVkR@nongnu.org
X-Gm-Message-State: AOJu0Yx/SxMzr1XKEzhQufbxhPMaZYUavR/gJeSy4/zM5hcA1DcgBv0d
 EURukxTyjsvY+A716pWJJoOW08mr5fsAZxkJk4IzLH+vIySTGjqDh1/hkqQ+FfQ=
X-Gm-Gg: ASbGnctiQ7rA5japdyIOigOamn3TDJHyS7cfJeNkkvxbKr5j+oXqNokU8a0HCfv1qX9
 SByPRcauaDZzkeD4WMKLSfimeDRjWcm9BeGZRC1hxKWi/4yZsnF0e4cp+3JIzeA5FX74kCl05ch
 bGsi4gDDgTCuEukgu5MWUcZmCpVLBQwV2C3UgdNWcChMrXp/EUpHGnpMSQGbpqWI2x3byWHFsci
 QQhI+MPnQFEZebBEjxnW+jD+YEPF+A5iaBLENrkjjtxhZwDJAO+JdWS/6uGs+A=
X-Google-Smtp-Source: AGHT+IEH00QDMO19fg53t76XqycXdbugWF0vZzx2cso3uHjIOr3l6AbJ7SnTq8MwQSlSHlaEicFTMA==
X-Received: by 2002:a17:902:fc8e:b0:20d:120f:6afa with SMTP id
 d9443c01a7336-214e706376dmr43761115ad.26.1732619673618; 
 Tue, 26 Nov 2024 03:14:33 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724eb968e65sm6936128b3a.54.2024.11.26.03.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 03:14:32 -0800 (PST)
Message-ID: <f0fe7192-b3a1-4969-b633-6e5221b76038@ventanamicro.com>
Date: Tue, 26 Nov 2024 08:14:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] Add RISC-V Server Platform Reference Board
To: Fei Wu <fei2.wu@intel.com>, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org, atishp@rivosinc.com,
 ajones@ventanamicro.com, conor@kernel.org,
 heinrich.schuchardt@canonical.com, marcin.juszkiewicz@linaro.org
References: <20240312135222.3187945-1-fei2.wu@intel.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240312135222.3187945-1-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

Hi Fei,


How is this work going? Are you planning to send the v3?


Thanks,

Daniel

On 3/12/24 10:52 AM, Fei Wu wrote:
> The RISC-V Server Platform specification[1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform. This patchset provides a RISC-V Server Platform (RVSP)
> reference implementation on qemu which is in compliance with the spec
> as faithful as possible.
> 
> The reference board can be running with tag edk2-stable202308 in
> upstream edk2 repo[2].
> 
> The qemu command line used:
> 
> $QEMU -nographic -m 4G -smp 2 \
>      -machine rvsp-ref,pflash0=pflash0,pflash1=pflash1 \
>      -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
>      -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
>      -bios fw_dynamic.bin \
>      -drive file=$BRS_IMG,if=ide,format=raw
> 
> Since there is no ACPI table generated in this new machine type, a
> corresponding EDK-II platform (WIP) is needed to provide related ACPI
> tables.
> 
> For testing purposes only, we used a workaround to generate the ACPI
> tables in Qemu with a dedicated downstream patch.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform
> [2] https://github.com/tianocore/edk2.git
> 
> 
> v2:
> - move cpu definition the 1st patch
> - replace sifive_test with power reset syscon
> - add versioning scheme to fdt
> - integrate recent changes in virt.c
>    - use g_autofree
>    - create_fdt/finalize_fdt
>    - riscv_isa_write_fdt
> - some cleanups
> 
> 
> Fei Wu (2):
>    target/riscv: Add server platform reference cpu
>    hw/riscv: Add server platform reference machine
> 
>   configs/devices/riscv64-softmmu/default.mak |    1 +
>   hw/riscv/Kconfig                            |   12 +
>   hw/riscv/meson.build                        |    1 +
>   hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
>   target/riscv/cpu-qom.h                      |    1 +
>   target/riscv/cpu.c                          |   61 +
>   6 files changed, 1352 insertions(+)
>   create mode 100644 hw/riscv/server_platform_ref.c
> 


