Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA1DFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvNph-0000yG-An; Wed, 25 Feb 2026 17:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvNpg-0000xL-6A
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:58:16 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvNpd-00004v-JE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:58:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48374014a77so2623355e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 14:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772060292; x=1772665092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nnmWxKwSjLGsvLRMGffLLwGVkXR32Zz4nNHHayA+KyE=;
 b=Pbi0C6ZskoMy4mny98tVj/q1MnJHs3Reuxc+DTBhP6mT9XD1KbmlsCqJ2T2kHamNUd
 iFrMLgzpsh3P8MQ8RQDCQ1kNp9GJtKYrE3MOSczXg3J/FRzP5wU456O6/kK4U+pl0DsE
 XcJPo42cpGYiCodBG2BpHavkJt7O7qcq/bdKhD7BpvST3BZrbdxLHqkBlyI3cIUzp9BS
 XajfmK7oIghYzT4F9WTW17tDGn6aXD685Cb8iNn+9Tn8JwVD1HqsV15Xgirr7FTMYwqW
 dxr5js5mcRq/mGb4cITLy+WZZR/SLFf6ruOtAY7iapXZCc5dMD3nSqNcYiSMHsYPk4SY
 6Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060292; x=1772665092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nnmWxKwSjLGsvLRMGffLLwGVkXR32Zz4nNHHayA+KyE=;
 b=ZC9Mhl+2aIZvOBzj09XnEoRN4bk3G1465lRyQpeLbDGm34hU8M/LEd/BgDFcIoshWt
 pESUJXq7Kwa1lrWjVhlD3k5l7puOsmHplKCw5ss7qapdCSxnb3lryYbnWfBpvZaqZCbu
 q9uv8wucej4/8u0VPto4nz5qK0ACRWecoF+MObGylGMT3su7lwmVDQ8wPg9NjSM2J/wZ
 WQwJ0wbqtpzw2Ydf3jgZwEG+jSvS/U3SbL6O5X+l8CR+oCYpcukkIf7jEqIR5N3EQVSz
 qXrtXpyqmV1aiOxRUP9wZn2ZnbAgz4S0jEOg7BWM3CFI1GdCJ9kPOqCSTQFcE3OI1/nk
 Dc0g==
X-Gm-Message-State: AOJu0YyOuG4E9hhawI7hsei2/BEEbSa1vSyW8hVss/58P+iYDDmCFGvL
 EVUgz3+qR4Y4eVWqHqgAUI58VuPaxR0Ynpg62QjEJ3FdSbKw4oENqMX9IYLO9H+mODxqL6W+k98
 8GFq0pKU=
X-Gm-Gg: ATEYQzzoORjp6fDaA+pA2vAszSCMh/Mjg4pzEMhjofJB/Z2fPPRHlSGH44Q2nw1nhU0
 wzc0Wfhf8fsqRZRTjGBRT/YiL0byq9pA1mnIH1Q5Sor/QpgjUGVX1AiBqBm4zKEKcTKBi1RvCSP
 6mZhnRUPDl6mhXkAcfHlWx76wlWSoDpoeVNsN6GNPj7Om6DylxnzNca8skxHPnUOrhNgzv2z+Dr
 0SxGZYzTEHu6ZQzHGsqxYlUro6bKZ4FH0VuC/j860sxVoABHN55MTKzDqguuBW7HoX6RVXELGRX
 Z8wv6sQnITHc7WmeptQgeSvDnsDHsGU7dtZSnl0YT9iSMoO5xqwoGU63evCka2M8U5jcCt1wzVl
 nt2P8FfGJeqJ7wsGOBJMisyIeO5mPe+KdsmZnRli35GW4ixwLO51RA+E4pg0RkQ2YvDscOAZTn5
 p8l73wORjIdfnKtkbJRjfuzTSr1H4313cHR4jwfBDVNqs+eyjCOY2YhyJGOetvVhj1TjshQBD3/
 FbW
X-Received: by 2002:a05:600c:4f8a:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483a95beb5bmr322322295e9.12.1772060291579; 
 Wed, 25 Feb 2026 14:58:11 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c35910f1sm8362335e9.2.2026.02.25.14.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 14:58:11 -0800 (PST)
Message-ID: <5827d495-18e1-4f12-a8f5-7a48898bd889@linaro.org>
Date: Wed, 25 Feb 2026 23:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/50] gdbstub: Build once on various targets
 (single-binary)
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org
References: <20260219191955.83815-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/2/26 20:19, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (50):
>    target/ppc: Move user_only_helper.c to target_user_arch[] source set
>    target/ppc: Remove PPC_DEBUG_SPR left-over comment
>    target/i386: Inline GDB_FORCE_64 definition
>    target/avr: Fix typo in gdb-xml feature name
>    target/alpha: Document gdbstub register indexes
>    target/riscv: Extract monitor-related code to monitor.c
>    target/ppc: Fix CPUClass::gdb_num_core_regs value
>    target/ppc: Remove dead code depending on USE_APPLE_GDB
>    gdbstub: Always infer gdb_num_core_regs when using XML file
>    target/sparc: Introduce sparc_cpu_register_gdb_regs() stub
>    target/sparc: Restore 'gdb-xml/sparc64-cp0.xml'
>    target/sparc: Restore 'gdb-xml/sparc64-fpu.xml'
>    target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
>    target/sparc: Expose gdbstub registers to sparc32plus target
>    target/sparc: Expose gdbstub registers to sparc32 targets
>    monitor/hmp: Handle gdb-xml exposed registers via  gdb_get_register()
>    target/sparc: Remove MonitorDef register entries available via gdbstub
>    target/i386: Remove MonitorDef register entries available via gdbstub
>    target/m68k: Remove MonitorDef register entries available via gdbstub
>    target/ppc: Remove MonitorDef register entries available via gdbstub
>    target/ppc: Extract monitor-related code to monitor.c
>    target/or1k: Use XML register definitions from GDB
>    target/riscv: Remove empty target_monitor_defs() symbol
>    target/sparc: Factor sparc_cpu_gdb_write_register() out
>    target/ppc: Replace ldtul_p() -> ldn_p()
>    target/mips: Replace ldtul_p() -> ldn_p()
>    target/riscv: Replace ldtul_p() -> ldn_p()
>    target/riscv: Remove unnecessary target_ulong type uses
>    target/i386: Replace ldtul_p() -> ldn_p()
>    target/i386: Expand 64-bit definitions when TARGET_LONG_BITS == 64
>    gdbstub: Remove ldtul*() macros
>    target/alpha: Expand gdb_get_regl() -> gdb_get_reg64()
>    target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
>    target/rx: Expand gdb_get_regl() -> gdb_get_reg32()
>    target/sh4: Expand gdb_get_regl() -> gdb_get_reg32()
>    target/sparc: Expand gdb_get_regl() in gdb_get_rega()
>    gdbstub/helpers: Convert gdb_get_regl() macro to inlined helper
>    target/microblaze: Build 'gdbstub.c' once for system binaries
>    target/sh4: Build 'monitor.c' once for system binaries
>    target/sh4: Build 'gdbstub.c' once for system binaries
>    target/or1k: Rename 'openrisc' -> 'or1k' in meson.build
>    target/or1k: Build 'gdbstub.c' once for system single binary
>    target/alpha: Build 'gdbstub.c' once for system single binary
>    target/avr: Build 'gdbstub.c' once for system single binary
>    target/loongarch: Build 'gdbstub.c' once for system single binary
>    target/m68k: Build 'gdbstub.c' once for system single binary
>    target/rx: Build 'gdbstub.c' once for system single binary
>    target/s390x: Build 'gdbstub.c' once for system single binary
>    target/tricore: Build 'gdbstub.c' once for system single binary

Patches 1-49 queued, thanks.

