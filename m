Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D46CF8E4AB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcNY-0002EH-RU; Fri, 17 Apr 2026 02:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcNX-0002E8-Pl
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:08:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcNV-0003Ku-RS
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:08:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso2941495e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776406112; x=1777010912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWBnK5N/Sf1Og1ZrN/He67DYsISn5Rkcdx0Z8W2UiQE=;
 b=OEq3Qg2zvdhB0nNALcqTx6lPk6z0bGJjCRpeTPz76c70v3t+5oJZvYvpG4PuH3yYM0
 l+hKseul+5oIo83LPuqA836AZINFk9HePDMduqKTmcTVE8ioJeotq6Z7dSJxL+Ay2YJd
 JQMU+xPqQhFZld7QETcRJtBLhDHBAvt67GoYHQWbtbWNLFGf6cKHN9P5oIBk6Gi9FWdE
 iKLq6f9rr9ATLuqjeHGFW4aqM7bLBNKASzkmVpydsmDz7ukXm//FfITNJxljAhZGlx6M
 pAyOSq8QkYKH5BmKABosGx6cJj9sAZcLX0erZDwON8aJYvGziAZZ/ZACYTwvDbBcAWP+
 X0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776406112; x=1777010912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWBnK5N/Sf1Og1ZrN/He67DYsISn5Rkcdx0Z8W2UiQE=;
 b=FiHwesUdwijKIbnMEPF026u7D7ChSvsDp9goU+O5C69NEynnW920RGwQeeq3bEKw5B
 0DZ8MeBtTYhDstaHYmHHVwwl61sLnTgP7AD2y0FAu8syr/h5fVOfZdzZdJ8uE61Rhn0E
 js1x4HfsnBS24L7aDfFSNE/ewzWYKTrlEBerRxoZY1I++zt8VFmZyXfEudHJuz/I2xzP
 ZQ3IA5oJaoZZ0dGY9cOUyWq8XdyY41MkbBkoGNcMS56H1lrmrQ3ftcB1eaTNsXLIfXuz
 VLlwx2EEcpx5X77jq6q6HaO1bTxq+yFmdbx1NXMe1qpF6WSZeuEEd1eDJcE4shSSRYZ5
 etZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hoG3SgjvXxGge7k0lEGXm5ob51x1rvFqqRljOBoSM+KbpHn+hvnG+66FSr5ffMYGON9aKe9H5etqE@nongnu.org
X-Gm-Message-State: AOJu0YyUP9x9dDSdzwPPlEkwzgi8P0RgcFK0jM5a+/n3vcsfczJgL21O
 SJ3GGxgHC084r4J31ta2kccNcuJHLy4zlVl9sLlKOPijF6MXqcN3G0pz5Bdpg9yfYs8=
X-Gm-Gg: AeBDieuvASd96VieoI3ONN242ofbxnOvx4f6MxFxeU0+UNuj4gxSkG+QbMhX1CqjK3D
 kmedzANoS58cRoVQ+PNGDshHaWzL07J0JfhO1yhv2rvmUI3LA6JT98Y/fvijfpAWtU9uOXfT1Id
 sw7+CbTLWQsBngpJ8HiNERE6xt5W/7ik5yCLg1hfjljIyeZgzJ9QSyjyI2OeW483Otb4YpTnaLi
 qSCTQcKxM6tXbrZdapJieyGBzKywPWU2iDxioxzL5v4cuQbjvmnhZGKlf99BHrE2daqVLA6T88f
 iKz2c4HNuoFCYTaoDP7tX7BASHvhOEmO9StZgJ14T6C1w1+OjqYzMNAnELwUeany/ShSJkQbe3Z
 HRcbFor2f80BvQpN4yLG82u5jEZ6ikAGgJ/fdhKz04gYAVRxPa8xRAVAPes9mWGBG2H9aKJda2f
 nz96bTSyI4CHZnHBD2BBNFpQVYcLMc/SBoQcstVOKkdGKiyP6HjEwpYLzSekWMDPzq4CxDqsKxk
 Z5i
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-488fb796f95mr13289395e9.31.1776406111914; 
 Thu, 16 Apr 2026 23:08:31 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01c4sm31495415e9.9.2026.04.16.23.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:08:31 -0700 (PDT)
Message-ID: <846108b0-74cd-47e8-bed3-7b1f0fd39ea0@linaro.org>
Date: Fri, 17 Apr 2026 08:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 35/37] target/hexagon: Add stubs for
 modify_ssr/get_exe_mode
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-36-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260401152657.314902-36-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/4/26 17:26, Brian Cain wrote:
> Add hex_mmu.[ch], cpu mode helpers, and additional includes/stubs
> that integrate the TLB device with the CPU model.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu-param.h  |   4 +
>   target/hexagon/cpu.h        |  17 +++
>   target/hexagon/hex_mmu.h    |  26 ++++
>   target/hexagon/internal.h   |   9 ++
>   target/hexagon/sys_macros.h |   3 +
>   target/hexagon/cpu.c        |  24 ++++
>   target/hexagon/hex_mmu.c    | 268 ++++++++++++++++++++++++++++++++++++
>   target/hexagon/translate.c  |   2 +-
>   8 files changed, 352 insertions(+), 1 deletion(-)
>   create mode 100644 target/hexagon/hex_mmu.h
>   create mode 100644 target/hexagon/hex_mmu.c


> @@ -181,12 +196,14 @@ struct ArchCPU {


>   FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
> +FIELD(TB_FLAGS, MMU_INDEX, 1, 3)
>   FIELD(TB_FLAGS, PCYCLE_ENABLED, 4, 1)


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 4da1b01fcd1..4e9c65f785a 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -27,6 +27,13 @@
>   #include "tcg/tcg.h"
>   #include "exec/gdbstub.h"
>   #include "accel/tcg/cpu-ops.h"
> +#include "cpu_helper.h"
> +#include "hex_mmu.h"
> +
> +#ifndef CONFIG_USER_ONLY
> +#include "sys_macros.h"
> +#include "accel/tcg/cpu-ldst.h"
> +#endif
>   
>   static void hexagon_v66_cpu_init(Object *obj) { }
>   static void hexagon_v67_cpu_init(Object *obj) { }
> @@ -52,6 +59,7 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>   
>   static const Property hexagon_cpu_properties[] = {
>   #if !defined(CONFIG_USER_ONLY)
> +    DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
>   #endif
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>       DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
> @@ -279,7 +287,11 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
>       }
>   
>   #ifndef CONFIG_USER_ONLY
> +    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
> +                           cpu_mmu_index(env_cpu(env), false));
>       hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, 1);
> +#else
> +    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX, MMU_USER_IDX);

Maybe move this change (and translate.c below) in a preliminary patch.

>   #endif
>   
>       return (TCGTBCPUState){ .pc = pc, .flags = hex_flags };
> @@ -299,11 +311,15 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
>       cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
>   }
>   
> +
>   static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>   {
>       CPUState *cs = CPU(obj);
>       HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(obj);
>       CPUHexagonState *env = cpu_env(cs);
> +#ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
> +#endif
>   
>       if (mcc->parent_phases.hold) {
>           mcc->parent_phases.hold(obj, type);
> @@ -317,7 +333,14 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       memset(env->t_sreg, 0, sizeof(uint32_t) * NUM_SREGS);
>       memset(env->greg, 0, sizeof(uint32_t) * NUM_GREGS);
>       env->wait_next_pc = 0;
> +    env->tlb_lock_state = HEX_LOCK_UNLOCKED;
> +    env->k0_lock_state = HEX_LOCK_UNLOCKED;
> +    env->tlb_lock_count = 0;
> +    env->k0_lock_count = 0;
>       env->next_PC = 0;
> +
> +    env->t_sreg[HEX_SREG_HTID] = cpu->htid;
> +    env->threadId = cpu->htid;
>   #endif
>       env->cause_code = HEX_EVENT_NONE;
>   }
> @@ -346,6 +369,7 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>                                gdb_find_static_feature("hexagon-hvx.xml"));
>   
>       qemu_init_vcpu(cs);
> +
>       cpu_reset(cs);
>       mcc->parent_realize(dev, errp);
>   }

This is where we start to use the shared TLB, so 1/ consider adding
this hunk in this patch (not in part 3/3, that confused me):

-- >8 --
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 355abb4fd24..01781a76caf 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -68,6 +68,8 @@ static ObjectClass *hexagon_cpu_class_by_name(const 
char *cpu_model)

  static const Property hexagon_cpu_properties[] = {
  #if !defined(CONFIG_USER_ONLY)
+    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
+                     HexagonTLBState *),
      DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 
0xffffffff),
      DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
          TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
---

but 2/ there should be a check in hexagon_cpu_realize() that this "tlb"
link property is set, otherwise exit as fatal error.

I haven't looked at Hexagon architecture much yet but have the gut
feeling we should model as a container of various related cores and a
shared TLB (and surely few other components in that container).

> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 91dff442c80..07829063868 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -1005,7 +1005,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>       HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs));
>       uint32_t hex_flags = dcbase->tb->flags;
>   
> -    ctx->mem_idx = MMU_USER_IDX;
> +    ctx->mem_idx = FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
>       ctx->num_packets = 0;
>       ctx->num_insns = 0;
>       ctx->num_hvx_insns = 0;


