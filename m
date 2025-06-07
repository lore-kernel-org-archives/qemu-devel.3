Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CF2C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 17:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNxkW-0002Bj-Ge; Sat, 07 Jun 2025 13:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uNxkU-0002B7-90
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 13:54:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uNxkS-0005wS-7y
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 13:54:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so2332973b3a.1
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749318866; x=1749923666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pIpT6/xTK019InUvYp5+Ol+QzS6xA0SyF2xfYpHC8ZY=;
 b=a1BMY7xWOQtuTviW/Egmazj1m4BRo27DxIVC5lm3gpc3yPDOZSm4iRuYhipnpKo7uk
 QXQjoyaW6YOxndvpAJSixWS0WYlAlfQ37RAmyFhUj1geN0PqaxP4lZWIvNGiFDVD5lM0
 FeP8KDx9I9sTNv/8tKYH8nklVnHjHsnGyRguSI82++JC7Y7YvzT0HK3aSS1qTze6WpKC
 XaGuDLmJg2LTtC1kOOzVH0iACoskofoK4Wjvc/vmHhWsxBgXPh/yeigsPKrpkeiy/V0j
 jhIg246EcJA3ikGHFrAF3dVCIlz1xTrPaapnqhC5TfHGAARxoBcggfSfIptwi3HTPTxZ
 4xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749318866; x=1749923666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIpT6/xTK019InUvYp5+Ol+QzS6xA0SyF2xfYpHC8ZY=;
 b=GwGnCk4GDiMOw10CINLexxTZZSOQxzHuTX4TTubS8DlujAaKLyWBIZR1KVo/unYeK9
 VJbxgnJhBZNXybdl4ogIIYObx5w7PHKs2kFJds4ybBdQRcAhTGVU61K3TlxrgKnU3f0w
 KTIjI/UhjQD/sMd+JW7WqMqiEas3Rtu745nyiOdbeM0Se1etwIiAoXm2B73zEr4TCQYl
 tvpgofc2Fik36Bs22+4nNYb7ce2QM/TT5/Y15n+4/hMpRh4z8Bwn8eSMZ0c5dVJRFMa4
 mZH8Bfx4bVJp1VRIoHS/BqgB5oQm90XAplFrbsHcaFN3+irgGxpAjRhuPU0KfYFsS379
 ydHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhz+83o9YYV7gPhBl/lT8y0zGUQA2/C4ckdNryIQZydpcKiyV6MkbbwTTsr42FIqJ3VdDNRHqqZ2xl@nongnu.org
X-Gm-Message-State: AOJu0Yywf7LHCSPnkb0FDmm2hEPigyQw58YL6zfgjRptntAq3ce+NGin
 v5OtB8leFq2jjARQT6estVg5gaSon3p11F8hIGrZYJf4q9sZVBSIoKpWfT48vU5IFpA=
X-Gm-Gg: ASbGncttaggP5eKVJW4gBlsnaTEfuc8BloW0DApj7574XtmAx1uY+iM1bwgKDkiRy0h
 OZ0IH02Glyu3peBD1jxZMunXOSEkb76B9es8g2JKxEoYzc6vjPw4M7gL8OKhJCXHiNbINyI7HhG
 VBk3qK1dU5D1Mlr/ftbtUVFVMV9eaw1p1FM4t4U/L80QVaBZBHSSol6ullvF2/esq+OkQwjIWRE
 OTv90oBXfdcm5jppWPm8q34bbb0wIN5NyRVwxSoEgLOOSq6qHcUFEOvdX6zt79Y87QIc7NXLNbO
 U9UyWdf7aelHh8DRqAwVVkhtJI2YA519CFxU2RUXrHkkefpVmgkEU7XP9nxgtbMApdY=
X-Google-Smtp-Source: AGHT+IHLfVGY+QCrSdmil3ZmGvabX1UegVfq5sAD7zMWl+cwuNu7t36AUVwVYpzaBe2TqruMv4Fgmg==
X-Received: by 2002:a05:6a00:9284:b0:740:afda:a742 with SMTP id
 d2e1a72fcca58-74827cfaca5mr11394656b3a.0.1749318865603; 
 Sat, 07 Jun 2025 10:54:25 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af3b6c8sm2995624b3a.8.2025.06.07.10.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 10:54:25 -0700 (PDT)
Message-ID: <4990220d-a4a6-49b4-a8db-929cf1100e31@ventanamicro.com>
Date: Sat, 7 Jun 2025 14:54:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target: riscv: Add Svrsw60t59b extension support
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, debug@rivosinc.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250605142126.1939798-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250605142126.1939798-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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



On 6/5/25 11:21 AM, Alexandre Ghiti wrote:
> The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
> for software to use.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> Changes in v2:
>   - Add support for IOMMU
>   - Make svrsw60t59b depend on sv39 (deepak)
> 
> Open question: svrsw60t59b in IOMMU should also depend on 64bit, but I
> did not find an easy to way in riscv_iommu_realize() to detect that, how
> should I do?


What controls the IOMMU behavior is the set of IOMMU capabilities that the driver
chooses to use. Other than that the device should be oblivious to the CPU word
size.

 From what I see in this patch you did the right thing: you added a new capability
to be advertised to software and that's it. It's up to software to decide whether
it's going to use it or not. You can advertise a 64 bit only IOMMU capability running
in a 32 bit CPU and it's up to the OS to not use/ignore it. In fact we already do
that: satp_mode related caps (e.g. RISCV_IOMMU_CAP_SV32X4) are 32/64 bits exclusive
but are always advertised.



Now, Svrsw60t59b being a 32 bit only extension requires special handling in
riscv_init_max_cpu_extensions() because the 'max' CPU has a 32 bit variant and
enabled everything by default. You can use this diff:


diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f93cd53f37..96201e15c6 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1612,6 +1612,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
  
      if (env->misa_mxl != MXL_RV32) {
          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
+    } else {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_svrsw60t59b), false);
      }
  
      /*


To fix this test break in 'make check-functional':

	Command: /home/danielhb/work/qemu/build/qemu-system-riscv32 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,fd=10 -serial chardev:console -cpu max -kernel /home/danielhb/.cache/qemu/download/872bc8f8e0d4661825d5f47f7bec64988e9d0a8bd5db8917d57e16f66d83b329 -append printk.time=0 root=/dev/vda console=ttyS0 -blockdev driver=raw,file.driver=file,file.filename=/home/danielhb/work/qemu/build/tests/functional/riscv32/test_riscv32_tuxrun.TuxRunRiscV32Test.test_riscv32_maxcpu/scratch/511ad34e63222db08d6c1da16fad224970de36517a784110956ba6a24a0ee5f6,node-name=hd0 -device virtio-blk-device,drive=hd0
	Output: qemu-system-riscv32: svrsw60t59b is not supported on RV32 and MMU-less platforms


Thanks,

Daniel


> 
>   hw/riscv/riscv-iommu-bits.h       | 1 +
>   hw/riscv/riscv-iommu.c            | 3 ++-
>   target/riscv/cpu.c                | 2 ++
>   target/riscv/cpu_bits.h           | 3 ++-
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/cpu_helper.c         | 3 ++-
>   target/riscv/tcg/tcg-cpu.c        | 6 ++++++
>   7 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 1017d73fc6..47fe01bee5 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -79,6 +79,7 @@ struct riscv_iommu_pq_record {
>   #define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
>   #define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
>   #define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SVRSW60T59B     BIT_ULL(14)
>   #define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
>   #define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
>   #define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index a877e5da84..36eda95a1c 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2355,7 +2355,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>       }
>       if (s->enable_g_stage) {
>           s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
> -                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
> +                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4 |
> +                  RISCV_IOMMU_CAP_SVRSW60T59B;
>       }
>   
>       if (s->hpm_cntrs > 0) {
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..13f1f56d95 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -228,6 +228,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>       ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>       ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
>       ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
> @@ -1282,6 +1283,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>       MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>       MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> +    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
>       MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>   
>       MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a30317c617..51eb7114da 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -675,7 +675,8 @@ typedef enum {
>   #define PTE_SOFT            0x300 /* Reserved for Software */
>   #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
>   #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
> -#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
> +#define PTE_RESERVED(svrsw60t59b)		\
> +		(svrsw60t59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
>   #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
>   
>   /* Page table PPN shift amount */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 59f134a419..ab61c1ccf2 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
>   BOOL_FIELD(ext_svinval)
>   BOOL_FIELD(ext_svnapot)
>   BOOL_FIELD(ext_svpbmt)
> +BOOL_FIELD(ext_svrsw60t59b)
>   BOOL_FIELD(ext_svvptc)
>   BOOL_FIELD(ext_svukte)
>   BOOL_FIELD(ext_zdinx)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2ed69d7c2d..3479a62cc7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1309,6 +1309,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       bool svade = riscv_cpu_cfg(env)->ext_svade;
>       bool svadu = riscv_cpu_cfg(env)->ext_svadu;
>       bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
> +    bool svrsw60t59b = riscv_cpu_cfg(env)->ext_svrsw60t59b;
>   
>       if (first_stage && two_stage && env->virt_enabled) {
>           pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
> @@ -1376,7 +1377,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>           if (riscv_cpu_sxl(env) == MXL_RV32) {
>               ppn = pte >> PTE_PPN_SHIFT;
>           } else {
> -            if (pte & PTE_RESERVED) {
> +            if (pte & PTE_RESERVED(svrsw60t59b)) {
>                   qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
>                                 "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
>                                 __func__, pte_addr, pte);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 305912b8dd..886006abc3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -804,6 +804,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           cpu->cfg.ext_ssctr = false;
>       }
>   
> +    if (cpu->cfg.ext_svrsw60t59b &&
> +        (!cpu->cfg.mmu || mcc->def->misa_mxl_max == MXL_RV32)) {
> +        error_setg(errp, "svrsw60t59b is not supported on RV32 and MMU-less platforms");
> +        return;
> +    }
> +
>       /*
>        * Disable isa extensions based on priv spec after we
>        * validated and set everything we need.


