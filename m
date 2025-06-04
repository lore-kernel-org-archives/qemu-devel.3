Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20191C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 18:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsjf-0003hj-3p; Wed, 04 Jun 2025 14:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMsjb-0003hB-A0
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 14:21:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMsjV-0007Re-W5
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 14:21:06 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso263794b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749061258; x=1749666058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pg2F9lPFMmRPn3RoQSEZTgJwwRSwIOSk9qAzYHyr8xs=;
 b=hKveVgDoURzeRN/8cxcxDvOV9bNaGmiGBgvCiKcHab8j+eRDhUGi9NadGkfGgo/9Lq
 46bHyrRRGpn0cJGYmYZDCjFL5HeAap5GHH/TwJemhUMxO4D3MwVvRUa8tPl0znheIJjU
 TfP7u4R1BIoqgYj55g6m1H+HzDHUg0MnKLmAcdM2PRkkfZ26JAGozjzprU5DLQVPPn1M
 fsfjkJgOIjTv3PDhF+5/i90M6YRuerCPnSgcqrUi7FNca9DmQ1DhfY/FVpYg0YiOfGNV
 4XtIFVLYuQsjjpU8ONOQIzLfM88VDh91KJC/tqPxYYPV9OweKpIMtR4O8bJpMJK62CM8
 FK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749061258; x=1749666058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pg2F9lPFMmRPn3RoQSEZTgJwwRSwIOSk9qAzYHyr8xs=;
 b=YC8KBeivOXojQY0yWrVy58frATzGw2KNjOLE37J4sbqiQuSHynt4TQPsl+gQtX7iBF
 wMUkuFHtxLrTpzPWjJLhNjQCqfFKLXu1Co3Iq82NDku5p7BeqPoTMC/LqrXMrMehH79X
 7HTQgXg7Y5t5PWkvUVjtcnE90iGIPaMqcyjdTQHKV7F/QcQ6iAhDwUOUTk3M1I3O6dJw
 tihl10CB96KQBIMJBanRa5+8UPoSDA8uJokjD9eV+GaDA0JbQ8BDgaJTGVW0R6DXQMlg
 FQH+n2jj6fH0sydzb9AEMs+PSwt9xHqhMKX5d7tVwZrOtt0XX03cF7kzWpoHxewwOYVe
 J8bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXOazPdcvLifZxUfdBEM2+XalFl58NpJkyI5/Edyhw2XzyfLGYO0uG4q70RFHUIkOHMA5sP+ImVW6V@nongnu.org
X-Gm-Message-State: AOJu0YyWBSf++l2nuCmGcR4fO9h+1cgBflVIiNjnRZhpb6AloYJD4ORX
 H+6LIk4ALPIh3W5jqaN4shgwtV3Vtkvvlg8N+170U5yfuncck5tGAXBl3pLniRu42fk=
X-Gm-Gg: ASbGnctddD3GW7iKS6+sy9WTC3uOCBgo+EzbFwLhXyE7wuCN7D9JMdTfvkI15Xw4XBj
 OTRwBPvwmVngkwVCyd4zJouXkMfX6w4F27hk22+zg5J+i3kwhY7cWDrxUu1ahcjzPZktOtuKf84
 361IJdfUhKnnsO7daYxn620pX/nAB53InPwlX4GecUQSCWwDgLfq6aw+MAU3TlxEwGca0Jy+pIK
 1su9xtOGG01ceneW4l0pTVvVlwwmKAffZQdSQTn+havV6ULBp/KWm6BEN9Xvk8iQbzdR9Swdbmd
 cjfV4VnyDXqd35iXAXnU+c6K5HzULhUFQGJ1/0W8dvfYPHB0I+4XWoOrK6RBaycT4iM=
X-Google-Smtp-Source: AGHT+IH76Jcv1T0S/UCHTWQZ8Q6FAR7C4FOa3LlEOheznZp0SKIGN09zAZj558laDvZFyIUHSKPhIQ==
X-Received: by 2002:a05:6a00:c8f:b0:736:73ad:365b with SMTP id
 d2e1a72fcca58-7480b400ed0mr5637760b3a.14.1749061257885; 
 Wed, 04 Jun 2025 11:20:57 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afe9639csm11860790b3a.17.2025.06.04.11.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 11:20:57 -0700 (PDT)
Message-ID: <14110641-4610-4f44-b192-2fd35f302e15@ventanamicro.com>
Date: Wed, 4 Jun 2025 15:20:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] target/riscv: Make PMP region count configurable
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20250522081236.4050-1-jay.chang@sifive.com>
 <20250522081236.4050-3-jay.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250522081236.4050-3-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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

It seems like this patch is breaking 'make check-functional':


>>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 LD_LIBRARY_PATH=/home/danielhb/work/qemu/build/contrib/plugins:/home/danielhb/work/qemu/build/tests/tcg/plugins MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QEMU_BUILD_ROOT=/home/danielhb/work/qemu/build QEMU_TEST_QEMU_IMG=/home/danielhb/work/qemu/build/qemu-img PYTHONPATH=/home/danielhb/work/qemu/python:/home/danielhb/work/qemu/tests/functional G_TEST_SLOW=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=229 MESON_TEST_ITERATION=1 QEMU_TEST_QEMU_BINARY=/home/danielhb/work/qemu/build/qemu-system-riscv64 /home/danielhb/work/qemu/build/pyvenv/bin/python3 /home/danielhb/work/qemu/tests/functional/test_riscv64_tuxrun.py


Summary of Failures:

11/12 qemu:func-thorough+func-riscv32-thorough+thorough / func-riscv32-riscv32_tuxrun TIMEOUT         90.02s   killed by signal 15 SIGTERM
12/12 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-riscv64_tuxrun TIMEOUT        120.13s   killed by signal 15 SIGTERM



Going through the code:



On 5/22/25 5:12 AM, Jay Chang wrote:
> Previously, the number of PMP regions was hardcoded to 16 in QEMU.
> This patch replaces the fixed value with a new `pmp_regions` field,
> allowing platforms to configure the number of PMP regions.
> 
> If no specific value is provided, the default number of PMP regions
> remains 16 to preserve the existing behavior.
> 
> A new CPU parameter num-pmp-regions has been introduced to the QEMU
> command line. For example:
> 
> 	-cpu rv64, g=true, c=true, pmp=true, num-pmp-regions=8
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/cpu.c                | 54 +++++++++++++++++++++++++++++--
>   target/riscv/cpu.h                |  3 +-
>   target/riscv/cpu_cfg_fields.h.inc |  1 +
>   target/riscv/csr.c                |  5 ++-
>   target/riscv/machine.c            |  3 +-
>   target/riscv/pmp.c                | 28 ++++++++++------
>   6 files changed, 80 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..8e32252c11 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1117,6 +1117,7 @@ static void riscv_cpu_init(Object *obj)
>       cpu->cfg.cbom_blocksize = 64;
>       cpu->cfg.cbop_blocksize = 64;
>       cpu->cfg.cboz_blocksize = 64;
> +    cpu->cfg.pmp_regions = 16;

pmp_regions is set to 16 in the base class, which is what we want to keep
the default intact. But then:

>       cpu->env.vext_ver = VEXT_VERSION_1_00_0;
>       cpu->cfg.max_satp_mode = -1;
>   
> @@ -1568,6 +1569,46 @@ static const PropertyInfo prop_pmp = {
>       .set = prop_pmp_set,
>   };
>   
> +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
> +                                     void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    uint8_t value;
> +
> +    visit_type_uint8(v, name, &value, errp);
> +
> +    if (cpu->cfg.pmp_regions != value && riscv_cpu_is_vendor(obj)) {
> +        cpu_set_prop_err(cpu, name, errp);
> +        return;
> +    }
> +
> +    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > OLD_MAX_RISCV_PMPS) {
> +        error_setg(errp, "Number of PMP regions exceeds maximum available");
> +        return;
> +    } else if (value > MAX_RISCV_PMPS) {
> +        error_setg(errp, "Number of PMP regions exceeds maximum available");
> +        return;
> +    }
> +
> +    cpu_option_add_user_setting(name, value);
> +    cpu->cfg.pmp_regions = value;
> +}
> +
> +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
> +                                     void *opaque, Error **errp)
> +{
> +    uint8_t value = RISCV_CPU(obj)->cfg.pmp_regions;
> +
> +    visit_type_uint8(v, name, &value, errp);
> +}
> +
> +static const PropertyInfo prop_num_pmp_regions = {
> +    .type = "uint8",
> +    .description = "num-pmp-regions",
> +    .get = prop_num_pmp_regions_get,
> +    .set = prop_num_pmp_regions_set,
> +};
> +
>   static int priv_spec_from_str(const char *priv_spec_str)
>   {
>       int priv_version = -1;
> @@ -2567,6 +2608,7 @@ static const Property riscv_cpu_properties[] = {
>   
>       {.name = "mmu", .info = &prop_mmu},
>       {.name = "pmp", .info = &prop_pmp},
> +    {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
>   
>       {.name = "priv_spec", .info = &prop_priv_spec},
>       {.name = "vext_spec", .info = &prop_vext_spec},
> @@ -2891,6 +2933,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
>           .cfg.mmu = true,
>           .cfg.pmp = true,
> +        .cfg.pmp_regions = 8,
>           .priv_spec = PRIV_VERSION_LATEST,
>       ),
>   
> @@ -2937,7 +2980,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.max_satp_mode = VM_1_10_MBARE,
>           .cfg.ext_zifencei = true,
>           .cfg.ext_zicsr = true,
> -        .cfg.pmp = true
> +        .cfg.pmp = true,
> +        .cfg.pmp_regions = 8

We can't set pmp_regions = 8 in the CPU definitions too. This will overwrite the
pmp_regions = 16 from the parent object. In short, we're changing the default
val for a lot of CPUs.

This diff fixes the test:

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d49c02dfe4..b84f08e582 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2933,7 +2933,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
          .cfg.mmu = true,
          .cfg.pmp = true,
-        .cfg.pmp_regions = 8,
          .priv_spec = PRIV_VERSION_LATEST,
      ),
  
@@ -3011,7 +3010,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
          .cfg.ext_zifencei = true,
          .cfg.ext_zicsr = true,
          .cfg.pmp = true,
-        .cfg.pmp_regions = 8,
          .cfg.ext_smepmp = true,
  
          .cfg.ext_zba = true,
@@ -3086,7 +3084,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
          .cfg.ext_xtheadmempair = true,
          .cfg.ext_xtheadsync = true,
          .cfg.pmp = true,
-        .cfg.pmp_regions = 8,
  
          .cfg.mvendorid = THEAD_VENDOR_ID,
  
@@ -3110,7 +3107,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
          .cfg.rvv_ta_all_1s = true,
          .cfg.misa_w = true,
          .cfg.pmp = true,
-        .cfg.pmp_regions = 8,
          .cfg.cbom_blocksize = 64,
          .cfg.cbop_blocksize = 64,
          .cfg.cboz_blocksize = 64,
@@ -3167,7 +3163,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
          .cfg.ext_zifencei = true,
          .cfg.ext_zicsr = true,
          .cfg.pmp = true,
-        .cfg.pmp_regions = 8,
          .cfg.ext_zicbom = true,
          .cfg.cbom_blocksize = 64,
          .cfg.cboz_blocksize = 64,
@@ -3212,7 +3207,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
  
          .cfg.mmu = true,
          .cfg.pmp = true,
-        .cfg.pmp_regions = 8,
  
          .cfg.max_satp_mode = VM_1_10_SV39,
      ),


I removed all "pmp_regions = 8" assignments but the Si-five ones. The generic
CPUs should retain the default pmp regions value, and every other vendor CPU
should set its own default if they want.


Thanks,

Daniel

>       ),
>   
>       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR_CPU,
> @@ -2948,7 +2992,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zifencei = true,
>           .cfg.ext_zicsr = true,
>           .cfg.mmu = true,
> -        .cfg.pmp = true
> +        .cfg.pmp = true,
> +        .cfg.pmp_regions = 8
>       ),
>   
>   #if defined(TARGET_RISCV32) || \
> @@ -2966,6 +3011,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zifencei = true,
>           .cfg.ext_zicsr = true,
>           .cfg.pmp = true,
> +        .cfg.pmp_regions = 8,
>           .cfg.ext_smepmp = true,
>   
>           .cfg.ext_zba = true,
> @@ -3040,6 +3086,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_xtheadmempair = true,
>           .cfg.ext_xtheadsync = true,
>           .cfg.pmp = true,
> +        .cfg.pmp_regions = 8,
>   
>           .cfg.mvendorid = THEAD_VENDOR_ID,
>   
> @@ -3063,6 +3110,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.rvv_ta_all_1s = true,
>           .cfg.misa_w = true,
>           .cfg.pmp = true,
> +        .cfg.pmp_regions = 8,
>           .cfg.cbom_blocksize = 64,
>           .cfg.cbop_blocksize = 64,
>           .cfg.cboz_blocksize = 64,
> @@ -3119,6 +3167,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zifencei = true,
>           .cfg.ext_zicsr = true,
>           .cfg.pmp = true,
> +        .cfg.pmp_regions = 8,
>           .cfg.ext_zicbom = true,
>           .cfg.cbom_blocksize = 64,
>           .cfg.cboz_blocksize = 64,
> @@ -3163,6 +3212,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>   
>           .cfg.mmu = true,
>           .cfg.pmp = true,
> +        .cfg.pmp_regions = 8,
>   
>           .cfg.max_satp_mode = VM_1_10_SV39,
>       ),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 229ade9ed9..67323a7d9d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -159,7 +159,8 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
>   
>   #define MMU_USER_IDX 3
>   
> -#define MAX_RISCV_PMPS (16)
> +#define MAX_RISCV_PMPS (64)
> +#define OLD_MAX_RISCV_PMPS (16)
>   
>   #if !defined(CONFIG_USER_ONLY)
>   #include "pmp.h"
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 59f134a419..33c4f9bac8 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)
>   TYPED_FIELD(uint16_t, cbom_blocksize, 0)
>   TYPED_FIELD(uint16_t, cbop_blocksize, 0)
>   TYPED_FIELD(uint16_t, cboz_blocksize, 0)
> +TYPED_FIELD(uint8_t,  pmp_regions, 0)
>   
>   TYPED_FIELD(int8_t, max_satp_mode, -1)
>   
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d6cd441133..6296ecd1e1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -738,7 +738,10 @@ static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
>   static RISCVException pmp(CPURISCVState *env, int csrno)
>   {
>       if (riscv_cpu_cfg(env)->pmp) {
> -        if (csrno <= CSR_PMPCFG3) {
> +        int max_pmpcfg = (env->priv_ver >= PRIV_VERSION_1_12_0) ?
> ++                              CSR_PMPCFG15 : CSR_PMPCFG3;
> +
> +        if (csrno <= max_pmpcfg) {
>               uint32_t reg_index = csrno - CSR_PMPCFG0;
>   
>               /* TODO: RV128 restriction check */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index c97e9ce9df..1600ec44f0 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id)
>       RISCVCPU *cpu = opaque;
>       CPURISCVState *env = &cpu->env;
>       int i;
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>   
> -    for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i = 0; i < pmp_regions; i++) {
>           pmp_update_rule_addr(env, i);
>       }
>       pmp_update_rule_nums(env);
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 5af295e410..3540327c9a 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -122,7 +122,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
>    */
>   static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>           return env->pmp_state.pmp[pmp_index].cfg_reg;
>       }
>   
> @@ -136,7 +138,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>    */
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>           if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
>               /* no change */
>               return false;
> @@ -236,9 +240,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>   void pmp_update_rule_nums(CPURISCVState *env)
>   {
>       int i;
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>   
>       env->pmp_state.num_rules = 0;
> -    for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i = 0; i < pmp_regions; i++) {
>           const uint8_t a_field =
>               pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>           if (PMP_AMATCH_OFF != a_field) {
> @@ -332,6 +337,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>       int pmp_size = 0;
>       hwaddr s = 0;
>       hwaddr e = 0;
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>   
>       /* Short cut if no rules */
>       if (0 == pmp_get_num_rules(env)) {
> @@ -356,7 +362,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>        * 1.10 draft priv spec states there is an implicit order
>        * from low to high
>        */
> -    for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i = 0; i < pmp_regions; i++) {
>           s = pmp_is_in_range(env, i, addr);
>           e = pmp_is_in_range(env, i, addr + pmp_size - 1);
>   
> @@ -527,8 +533,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>   {
>       trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
>       bool is_next_cfg_tor = false;
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>   
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>           if (env->pmp_state.pmp[addr_index].addr_reg == val) {
>               /* no change */
>               return;
> @@ -538,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>            * In TOR mode, need to check the lock bit of the next pmp
>            * (if there is a next).
>            */
> -        if (addr_index + 1 < MAX_RISCV_PMPS) {
> +        if (addr_index + 1 < pmp_regions) {
>               uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
>               is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
>   
> @@ -573,8 +580,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>   target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>   {
>       target_ulong val = 0;
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>   
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>           val = env->pmp_state.pmp[addr_index].addr_reg;
>           trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
>       } else {
> @@ -592,6 +600,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>   {
>       int i;
>       uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>       /* Update PMM field only if the value is valid according to Zjpm v1.0 */
>       if (riscv_cpu_cfg(env)->ext_smmpm &&
>           riscv_cpu_mxl(env) == MXL_RV64 &&
> @@ -603,7 +612,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>   
>       /* RLB cannot be enabled if it's already 0 and if any regions are locked */
>       if (!MSECCFG_RLB_ISSET(env)) {
> -        for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +        for (i = 0; i < pmp_regions; i++) {
>               if (pmp_is_locked(env, i)) {
>                   val &= ~MSECCFG_RLB;
>                   break;
> @@ -659,6 +668,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
>       hwaddr tlb_sa = addr & ~(TARGET_PAGE_SIZE - 1);
>       hwaddr tlb_ea = tlb_sa + TARGET_PAGE_SIZE - 1;
>       int i;
> +    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>   
>       /*
>        * If PMP is not supported or there are no PMP rules, the TLB page will not
> @@ -669,7 +679,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
>           return TARGET_PAGE_SIZE;
>       }
>   
> -    for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i = 0; i < pmp_regions; i++) {
>           if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) == PMP_AMATCH_OFF) {
>               continue;
>           }


