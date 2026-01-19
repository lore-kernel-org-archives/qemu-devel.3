Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FC5D29C28
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq6H-0000Vy-AR; Mon, 19 Jan 2026 09:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vhq5w-0000Nd-AX
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:19:05 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vhq5u-0001kk-Am
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:19:04 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so29957215ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768832340; x=1769437140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbeXQg7wdyPMdZ1NdyneqHstd+QgsASKfM2ty1zMcgc=;
 b=ZyAwmGVv6LXHUzXa0ZYR4whtVLg4kZ38X02sCfdj2BkyDKhexYXsFqV7/uSnOcuAH9
 3UW3dNoIC5dBwmzOfdYHf37LLIN0GM71IhwwMalA09RJ9xHoOybuhuZ7LBh11FxJWyzV
 p/CgJyK+cwDSn59nPVE3wly90pCqKeQUg5/eEV9QuL3BSmx5E56vnaIGRqkvGdkYuAdF
 t1Gt7kWxdnxx4ewT0b34vTxGBLdzJVZoQ46E/AIdV9+M/nyfCePU9Oad4kxA8xDz98Wj
 4Mvdr/4ERGToLjjawsqwCuJhYd0un6Be4i0sxQI+lClYCEjTAHhOxcbqai0zsw8AtJkz
 Jy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768832340; x=1769437140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QbeXQg7wdyPMdZ1NdyneqHstd+QgsASKfM2ty1zMcgc=;
 b=B0ZYebvBf953/+022t/vjCgIVfmILAyaa4uqJ/4O4sQMnkkufTpKiPAxJyie0ehgHU
 JmrmtMNlJ5UCBzYHDf/K0PHjaPYBs3QtCUq9LLl2V5rIMr8WzpbSbHPyOABfd9lHI2SJ
 fIX9VrkRyhEUKn8DXE/1f7bD6oYvHTSEacaK/UcR4j/er4l70NudYeDcwJUtUuEIZpA+
 mC5WAuIXh5JtGY1ZOEVrPzSioqEhb/RU6151cvm39RAON7xRPQsAm1ORiGcF4x97wwkn
 YoYQp2l71Ky7u+QP3zdqX5yFbYnx9Vuz/fkP3N86n3cLXK8YGy5kO64oAUQV1Ebc1PcJ
 ZOBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwKPhzR12gGNRsaC0dZX1jy8/9McJOim9d3Eo5AM/7AgcADJPp2ZIUy+KLogXb1rwmCANZSIRbRYT2@nongnu.org
X-Gm-Message-State: AOJu0YzfZgQ7zhNI1yCccOZnuJyOK3AivsQWb4ixv3LJIchmZJKcSbKf
 0l6TyNFmweePNtWGAzWaREDMpGLLrYDRlGg7QTu5dipPG5Ol775fawpr
X-Gm-Gg: AZuq6aKvcaBSWT4zTCx5If9wGDO2P674JO2+n+XUsBThRDRBX4gmkxlY0vh+/LWSGbY
 ZkK+/a6Se3IyrrZt6WS2Nc/6fPh/+ykf0QZ9bWg2A3dHLugJDGh9ubEd3dZyoAxM3kIUZ4ru0PD
 cpLsTw/CgmFxbxGJUuMCH7yy3inQLqvXUSqO/yhtnBkkd4GlOwPf7Jp41nDCn+Dyznwms330YR+
 I77VFJqus6OCO4xW5lWOUPOsAc64hBc1BRzxW3qjKH3xCKEYm4RAi04J7BX+LLVAkSAOCr5WjDU
 /a7xLI7DMXVaIqvvkCbQ05RZ9Dl+NqBQwS2Qu8I3raNsTi2A2NyvZuPWrnGm8J6HlVr20Gv6+vh
 kUpp7f0ARiGylutVH6EJLDIayCcdmj7yHTc0rUQEqTet758jVVspvvLIUg6obOefjtvNc9guMhU
 TaMTySlx64XB2i30thUK1Y1EaVOyibwL3CvwCF/nv9EReaj9vXqW42+hxp2gA=
X-Received: by 2002:a17:903:1ae6:b0:2a2:f0cd:4351 with SMTP id
 d9443c01a7336-2a7175c3241mr105612185ad.37.1768832339473; 
 Mon, 19 Jan 2026 06:18:59 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.22.240])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190c9e85sm96458745ad.26.2026.01.19.06.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 06:18:59 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: dbarboza@ventanamicro.com
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 wangjingwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com
Subject: Re: [RFC PATCH v1 1/8] riscv: split sdext and sdtrig config bits
Date: Mon, 19 Jan 2026 22:18:49 +0800
Message-ID: <20260119141849.773459-1-chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d7fa00f7-7e10-454c-b4b1-03ac4862fc9d@ventanamicro.com>
References: <d7fa00f7-7e10-454c-b4b1-03ac4862fc9d@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Daniel:

On 1/19/2026 9:19 PM, Daniel Henrique Barboza wrote:
>On 1/17/2026 1:27 AM, Chao Liu wrote:
>> Add cfg.ext_sdext and cfg.ext_sdtrig and expose them as ISA
>> extensions. Keep the legacy 'debug' CPU property as a global kill
>> switch and force-disable both when it is off.


>I would rather put the 'debug' flag in deprecation. It's a flag that at
>this moment means 'enable sdtrig' and I'd rather get rid of it than
>making it enable sdext too.

>But deprecating 'debug' is out of scope for this work and we can handle
>it later. Matter of fact I might drop patches deprecating it today.

>About enabling sdext by default, the patch is breaking bios-table-test
>because we're adding an extra string in riscv,isa ...

Thanks for the review :)

Enabling sdext by default is indeed not a good idea, especially when it is
not fully implemented,

so I agree to set it to disable by default until it is fully available before
considering whether to enable it by default.

>>
>> Trigger CSRs (tselect/tdata*/tinfo/mcontext) and trigger setup now
>> depend on ext_sdtrig instead of cfg.debug.
>>
>> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> ---
>>   target/riscv/cpu.c                | 18 +++++++++++++++---
>>   target/riscv/cpu_cfg_fields.h.inc |  2 ++
>>   target/riscv/csr.c                | 16 ++++++++--------
>>   target/riscv/machine.c            |  4 ++--
>>   target/riscv/tcg/tcg-cpu.c        | 11 +----------
>>   5 files changed, 28 insertions(+), 23 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 73d4280d7c..bc0b385cc1 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -189,7 +189,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
>> +    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
>> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>>       ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>>       ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>>       ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
>> @@ -783,7 +784,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>       env->vill = true;
>>
>>   #ifndef CONFIG_USER_ONLY
>> -    if (cpu->cfg.debug) {
>> +    if (cpu->cfg.ext_sdtrig) {
>>           riscv_trigger_reset_hold(env);
>>       }
>>
>> @@ -922,6 +923,15 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>>               return;
>>           }
>>       }
>> +
>> +    /*
>> +     * Keep the legacy 'debug' CPU property as a global kill switch.
>> +     * If it is off, force-disable Sdext/Sdtrig regardless of ISA strings.
>> +     */
>> +    if (!cpu->cfg.debug) {
>> +        cpu->cfg.ext_sdext = false;
>> +        cpu->cfg.ext_sdtrig = false;
>> +    }
>>   }
>>
>>   static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>> @@ -946,7 +956,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>       riscv_cpu_register_gdb_regs_for_features(cs);
>>
>>   #ifndef CONFIG_USER_ONLY
>> -    if (cpu->cfg.debug) {
>> +    if (cpu->cfg.ext_sdtrig) {
>>           riscv_trigger_realize(&cpu->env);
>>       }
>>   #endif
>> @@ -1112,6 +1122,8 @@ static void riscv_cpu_init(Object *obj)
>>        */
>>       RISCV_CPU(obj)->cfg.ext_zicntr = !mcc->def->bare;
>>       RISCV_CPU(obj)->cfg.ext_zihpm = !mcc->def->bare;
>> +    RISCV_CPU(obj)->cfg.ext_sdext = true;
>> +    RISCV_CPU(obj)->cfg.ext_sdtrig = true;


> ^ here. Every time we change the defaults we have to dance around
> bios-tables-test due to riscv,isa changes.

> If we really want sdext to be enabled by default we should (1) only
> enable it when the feature is already fully implemented and (2) changing
> bios-tables-test according to avoid leaving broken tests.

I agree, as stated above.

> The remaining of the patch has the right idea, like here:


>>
>>       /* Default values for non-bool cpu properties */
>>       cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>> index a154ecdc79..9701319195 100644
>> --- a/target/riscv/cpu_cfg_fields.h.inc
>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>> @@ -44,6 +44,8 @@ BOOL_FIELD(ext_zihpm)
>>   BOOL_FIELD(ext_zimop)
>>   BOOL_FIELD(ext_zcmop)
>>   BOOL_FIELD(ext_ztso)
>> +BOOL_FIELD(ext_sdext)
>> +BOOL_FIELD(ext_sdtrig)
>>   BOOL_FIELD(ext_smstateen)
>>   BOOL_FIELD(ext_sstc)
>>   BOOL_FIELD(ext_smcdeleg)
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 5c91658c3d..4f071b1db2 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -775,9 +775,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>>       return RISCV_EXCP_ILLEGAL_INST;
>>   }
>>
>> -static RISCVException debug(CPURISCVState *env, int csrno)
>> +static RISCVException sdtrig(CPURISCVState *env, int csrno)
>>   {
>> -    if (riscv_cpu_cfg(env)->debug) {
>> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
>>           return RISCV_EXCP_NONE;
>>       }

> debug == sdtrig is what we want and we should use 'sdtrig' everywhere
> 'debug' is appearing, but there's a particular way to go about it. We
> need to add getters/setters for 'debug' that would enable/disable
> sdtrig. We should avoid adding this kind of handling in init() or
> finalize().

> I can do that in a deprecation patch. You can use your patches to handle
> sdext only.

Thanks! I agree with this plan. I will focus on the implementation of sdext in
subsequent patches.

If you have patches related to handling debug flags, I will rebase them to
continue the work on sdext.

Thanks,
Chao

