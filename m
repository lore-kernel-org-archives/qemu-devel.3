Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B7C61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 20:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNzyp-0005lL-7Y; Sat, 07 Jun 2025 16:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uNzym-0005l0-Ow
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 16:17:24 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uNzyk-0004DQ-Ot
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 16:17:24 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so2322720a12.2
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749327441; x=1749932241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sk1uj3MF6YasjSJT1hBdiG4s7UY2rjon8O7m3fL3rRQ=;
 b=IvE3ngr2k/GosI9vblokDCTGPrpjISsitcbGpHMTtPovphk0LjHP9119UFIXNjoQ6i
 /WARYF22LjqiFLomQtVb60M69xq4ObuayKYXI7TgtlbnypTXgw+Ect2Mm2OJA5j/FrPa
 HSLuDDLNg3x4uq6xUUaH6erVOZLmxrLM13/PVrRQp4kHTbLuTzQNb1tg4rSdLQKwzBSM
 8DQKz5MX8mQ/F/xrqwKO4wRhWRZBuzErWcNfFKjLy/YLZ3LipFco0rGi3t5Fc532oYUk
 AMbCuhmmof+Tg8IBR6A39QQq5AStZzJUG6ek24KsdUd2eUhF0Xz3mRWW+UM9A3+/w5Cd
 NG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749327441; x=1749932241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sk1uj3MF6YasjSJT1hBdiG4s7UY2rjon8O7m3fL3rRQ=;
 b=qWWKPcMrF6U4FFwCKMn2SUARpMZgE66LqUrwvI6RXnV1VRUSHGOSr3dCOIFW93rE5l
 56Xe7pulnFdrUKaABSXHNPECrSlzEyayB45ifJdimkS3i+d5trl30HwXq44ya2XNrHag
 MA6FxEFE67qNkU3c9I4z4DndSQEktX/CGQMdDepDNP9pJ+q2ilRpTOEjqpmg89j+8iKr
 eFED9sUrWdEzj0bogE2sUpY0CpJhrD2ZVazHrlyXtt355FTPW9n4CskEe6sLRC/YDAfI
 i2qVQZpGSMW0U849i9J2xndzLD8ORq6zEGMc9JxTYvuj4fr/zPbMALuwglNQfU98GMvy
 cvSA==
X-Gm-Message-State: AOJu0YyNy1W1Ghh9iPSowzghzowxU4GFQkZA3GJKOZvdTtDhNpTcdozr
 lWYQnEjxjlCThHHx6/qiXQuJpXUy9oxbeNdhNVJHQfd9FcPjRW3vIMqmVIw1PxzzWjI=
X-Gm-Gg: ASbGncvDviwSeyUdbKVoTtaoWGNE426wgOA9MauKBP2LglrSql+vgibTy5cFKijV4GS
 pGhMkxdvjoq6jjyOStWEu1mVnFWXGwtxpRSyKToXkGDqdiPzyxi6oyaO6AlSu152SKv2+ABA/hd
 dtF6rd0n8HtLMg8963M3nnhunbmGKhhVReln6VQENt37Uwi7eJiwAN2zhps9RmGW8jlRL7Q0wiR
 8+x8YEXVeONPMhMRVnd1tGzSmUQpoXsdzeqAWlmBAnISGJcWx7otQCvALxWY4ti7Kp90Hxa9LoI
 3XhFOUC+aS1Ei8vKT+eLzEFxVvIu5s7Y5NvQb3zaI5ej3Lq6MiTPxZMKYRtR4d2ynv8=
X-Google-Smtp-Source: AGHT+IEngYO/5INFFrpaUA0tGXZKn2Pf75JQ2YDQBhAcVUlq3il7+5BBOL7gJMCEmfEp5bfB5HgO4g==
X-Received: by 2002:a17:902:ced0:b0:224:24d3:6103 with SMTP id
 d9443c01a7336-23601d7129bmr123354305ad.35.1749327440763; 
 Sat, 07 Jun 2025 13:17:20 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603406ac5sm30614685ad.176.2025.06.07.13.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 13:17:20 -0700 (PDT)
Message-ID: <ef6c7b15-04a7-42cf-a89b-c2674388810f@ventanamicro.com>
Date: Sat, 7 Jun 2025 17:17:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: add cva6 core type
To: Ben Dooks <ben.dooks@codethink.co.uk>, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-3-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250527112437.291445-3-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
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



On 5/27/25 8:24 AM, Ben Dooks wrote:
> Add TYPE_RISCV_CPU_CVA6 for the CVA6 core
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 11 +++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1ee05eb393..3daf75568c 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -34,6 +34,7 @@
>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>   #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
> +#define TYPE_RISCV_CPU_CVA6             RISCV_CPU_TYPE_NAME("cva6")
>   #define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
>   #define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
>   #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..fca45dc9d9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3009,6 +3009,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .misa_mxl_max = MXL_RV64,
>       ),
>   
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_CVA6, TYPE_RISCV_VENDOR_CPU,
> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | RVU,
> +        .misa_mxl_max = MXL_RV64,
> +        .cfg.max_satp_mode = VM_1_10_SV39,
> +        .priv_spec = PRIV_VERSION_1_12_0,
> +        .cfg.pmp = true,
> +        .cfg.mmu = true,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zicsr = true,
> +    ),
> +

The CPU is being added inside a "#if defined(TARGET_RISCV64)" block, meaning
that it's a 64-bit CPU only. But the CVA6 board added in patch 1 is being
added for both 32 and 64 bit emulations in hw/riscv/Kconfig:

config CVA6
     bool
     default y
     depends on RISCV32 || RISCV64  <------------------

This setup (after patch 3 is added) triggered a test failure in 'check-qtest',
when polling all available boards in qemu-system-riscv32, because it didn't find
a default 32 bit CPU for the cva6 board:

# starting QEMU: exec ./qemu-system-riscv32 -qtest unix:/tmp/qtest-1683816.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1683816.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine cva6 -accel qtest
----------------------------------- stderr -----------------------------------
qemu-system-riscv32: ../hw/core/machine.c:1574: is_cpu_type_supported: Assertion `cc != NULL' failed.
Broken pipe
../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)



We have 2 options here:

- if the CVA6 board is supposed to run in RISCV32 and RISCV64, then its default
CPU must be 32 bit compliant too. The CPU declaration in this patch must be moved
outside the "#if defined(TARGET_RISCV64)" block (e.g right after
TYPE_RISCV_CPU_SIFIVE_U);

- if the board is 64 bit only then the CPU declaration is fine, and we need to
change the board hw/riscv/Kconfig entry to "depends on RISCV64".


Thanks,

Daniel


>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
>           .misa_mxl_max = MXL_RV64
>       ),


