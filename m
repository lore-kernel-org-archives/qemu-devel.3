Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F59C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XoH-0002kI-Of; Mon, 07 Sep 2026 07:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xo2-0002h7-QS
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xo0-0003Eu-S2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AmxaL3180859
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e3Yq/xUprvY
 vn7B1vx6090CtG1lk3xvMaGBB2wcxsBg=; b=Hdab29kfzr6BxLSeorw+bQGirfE
 Pma9jlgcecwJbMALO94hxSvYi5SOPGzkJac5AeSzjCaG3tRmn6w8DGE/iKl7TmpJ
 KEWtMORy5IsB87Cw5fMcLbACyHyCHjVkxoNX37wLxzBqTLftRb8D3NS0oxY4Dimy
 Z3tMBWoIU+ZdsyYqeYKd9ZGYrBLsron1TXYHZxb9LHd+ZRGnC9OSozSEZmBOHFLk
 i89ZLyoZI1gadgdtHVmgHwN636rYJwbr+pu3RfId5swSCcxxcgcHrH9a4WaKn8PG
 U0dJPIbvgxpLLVM5Ilp4DJ0EkHN/K6JgeAjpLPralook/uo6NdhX2aPHUxw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsw20scy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:46:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso59395896d6.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781590; x=1789386390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e3Yq/xUprvYvn7B1vx6090CtG1lk3xvMaGBB2wcxsBg=;
 b=HYS4Nu+bJ3PSe/ccFivg6PeLe9Q2HDJ0ytHGpyZMMTdr7ROn1BFzeEttZZ8rSfYAT0
 8co/22dw+QDhaWHI0dZ/04dd//uDKkZO4cA0vBu3RhIRrxvPc9BwvydM6Njhm6pAllvl
 mCjM9SBG7tddFVsiUfr9geuntFG8nJSO2tjc7w0HlENMX3uHSt3prNLt7i3nhAs0ggD9
 QHxZMnYjqWrEPPYsxvwmtPqqkJZ5qzrk56CIs5tm4PKwE4VAwdTdL4dr0BFuKYmej3EX
 XIxmUVm8Vy9zqwpcgtSOubNYLrtWflw9T0Uz06EhuTfCYRCcxefCy3gsNIBSDqZWZRd+
 /l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781590; x=1789386390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e3Yq/xUprvYvn7B1vx6090CtG1lk3xvMaGBB2wcxsBg=;
 b=BJTeZ3CLW7hnsx8T6IqA3KZPXmgJJqYlg2hU4AoUTZN9cp58FWZiSC765mYPdwsBF+
 xCAFYaTVeZiu0oL/PQS7NBFsAen/7ayLYH1WKiY+FHKgJ0PAAmpydR79Fh+aJc1Uta1q
 UeOwNMKXWWCnCyCqA6OwKF+gzrOBPIzRJA80Flg2Ef5aRpDQRzPKp1V0SDtXAb3TcoMK
 DZpJyIOVT8iWJ2p+Y8qTIMi0bD4kWr6vXgcRMrsuC5gXajGWDkSjgI+yKvKf+y67K7y+
 cH/vlXNdvWCIV3GMdMq/GR98WhAW+cTQ5+e78K5tGI+JfHORPIKp+3nP8eQoqmO7ZdIW
 KcBg==
X-Gm-Message-State: AFuF++no80PEU86fteWZskAjK70GVlJ6N2TDUV2YWrq/Fei5ErAJCjfz
 DkcGQH0CQ0OJ1QmDTYK0kOoPzrSEbt4MGQQCRojpLqvuEamdHTx5U7xj/O9SXqu59FN5rVt1RSm
 yNIaM4Q7Olx480SA1TUBqJ47yfe3ouvNc+k1MWdUJh23C4NrwCjoHsoMcoBh3bQs6pA==
X-Gm-Gg: AYBFou1WeCInqcNtOXjb9ojUQpRz45+2PyjHYHV8i+wzn1wIgvE9V6NAdNjEGIYKU2p
 trJbeEFtOScGXWZDvKgsR3VUXnQYCmIGbAbXcNdvetTodRLKDEVfDtrtAUZlN6Bz74/uGR354cn
 F1djysArBJn3GIbkGmvnDtPTXT3msMmFOD6RldtRGXXVIdxfErTyUR4ZIlHP9rB4tivqNlCwU7C
 2DPl1vIZN4W/PiM2bm7cncZZm+P/uadw5VBvdqqPCmwouFnKY5ykzHy8/ygKfjvHYvqANpDHmPr
 7Hs157xRRO1ZbOc7j+lquFetvG1cJpiHk0v/cG8ehVDeNHNmn1x9sdMO6LXGbxURAX4XPAvELU4
 ypu1sJwKzl90DBhCC8q+UHTbpS4I6ObLn4NlQ
X-Received: by 2002:a05:6214:4689:b0:910:345a:b805 with SMTP id
 6a1803df08f44-9103f0de5e6mr319838936d6.36.1788781590220; 
 Mon, 07 Sep 2026 04:46:30 -0700 (PDT)
X-Received: by 2002:a05:6214:4689:b0:910:345a:b805 with SMTP id
 6a1803df08f44-9103f0de5e6mr319838326d6.36.1788781589734; 
 Mon, 07 Sep 2026 04:46:29 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040679e13sm89834876d6.26.2026.09.07.04.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:29 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 2/7] target/riscv: add sdext Debug Mode helpers
Date: Mon,  7 Sep 2026 08:46:09 -0300
Message-ID: <20260907114615.1609913-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
References: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RndTv1rFpHtYIPrdlQ9KGiEIS2A3b2xq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX1AyEuCDycf2D
 sl9j5enx6DV2d5MMRLDEw/BM56YGh7iDGLxtCG/vMQd2hDHwiWRJoV8G0ncNMcKEK+VZSmHb6qp
 drTskO/Vq38IAPEhJJASL4piKbKuJ0c=
X-Authority-Analysis: v=2.4 cv=eKwjSnp1 c=1 sm=1 tr=0 ts=6a9ea417 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=Mp8isO8jnsZoTyD_AnUA:9
 a=1HOtulTD9v-eNWfpl4qZ:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX5KtMjKu3Uw3O
 u1LJezq652lEC9+pnvNhtwENjEv6LdIzAS3VwKm5uQj7DMk+y3Tngd/st7DqyT8YP3rVIpYdOy9
 ytSZmSSF1x/Ln47OfbWRKtphJakHmVHGdU/V+QPx0CbACOOjbqh41aJEczo2BOETX7pWqxsKEmp
 lTFlUM/sq5MaJMQGa1NH+8lFXWOLeBZZcgcWsaEP08g1owa+BPgvUv7eWJ9lN/ggy1hCkZ8Vpxf
 LUeomh0AGySQwcvSjEWYjHr1peEmYUyRu/DQdk5nK1SAjMmDC9wgdbmD2Pgj3LBCGjh90B/kFsW
 M7a65De34JF3K9hdORDAj1UBT3rbgyUhPdd/6SzbKxNIAbzEgDrK0I8aH50Mk4NFTMwCD9iwWWA
 URkgQmQ8L3wem2xJ/XEZsn0AIewlcAnLsEBw67oSZdE/pmSYCdqXxy5dHXbNYNdcA7uorYUg9w6
 4FzE8SqeOI6W1GnWCJw==
X-Proofpoint-GUID: RndTv1rFpHtYIPrdlQ9KGiEIS2A3b2xq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add helpers to enter/leave Debug Mode and to update dpc/dcsr.
Model resume without a Debug Module by leaving Debug Mode at
cpu_exec_enter and continuing from dpc.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.h            |  3 ++
 target/riscv/tcg/cpu_helper.c | 85 +++++++++++++++++++++++++++++++++++
 target/riscv/tcg/debug.c      |  5 +++
 target/riscv/tcg/tcg-cpu.c    | 14 ++++++
 4 files changed, 107 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7b343d7a3e..82eb61a18c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -671,6 +671,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause);
+void riscv_cpu_leave_debug_mode(CPURISCVState *env);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..e6d948991c 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -132,6 +132,91 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool riscv_sdext_enabled(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_sdext;
+}
+#endif
+
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+
+    env->debug_mode = true;
+    env->dpc = pc & get_xepc_mask(env);
+    env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
+    env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
+    env->dcsr |= env->priv & DCSR_PRV_MASK;
+    if (env->virt_enabled && riscv_has_ext(env, RVH)) {
+        env->dcsr |= DCSR_V;
+    }
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        if (env->elp) {
+            env->dcsr |= DCSR_PELP;
+        } else {
+            env->dcsr &= ~DCSR_PELP;
+        }
+        env->elp = false;
+    }
+#endif
+}
+
+void riscv_cpu_leave_debug_mode(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+
+    target_ulong new_priv = env->dcsr & DCSR_PRV_MASK;
+    bool new_virt = riscv_has_ext(env, RVH) && (env->dcsr & DCSR_V);
+
+    if (new_priv > PRV_M) {
+        new_priv = PRV_M;
+    }
+    if (new_priv == PRV_M) {
+        new_virt = false;
+    }
+
+    if (new_priv == PRV_S && !riscv_has_ext(env, RVS)) {
+        new_priv = PRV_M;
+        new_virt = false;
+    } else if (new_priv == PRV_U && !riscv_has_ext(env, RVU)) {
+        new_priv = riscv_has_ext(env, RVS) ? PRV_S : PRV_M;
+        new_virt = false;
+    }
+
+    env->debug_mode = false;
+    riscv_cpu_set_mode(env, new_priv, new_virt);
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        env->elp = cpu_get_fcfien(env) && (env->dcsr & DCSR_PELP);
+        env->dcsr &= ~DCSR_PELP;
+    }
+
+    if (new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, 0);
+    }
+
+    if (env_archcpu(env)->cfg.ext_smdbltrp && new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
+    }
+    if (env_archcpu(env)->cfg.ext_ssdbltrp && (new_priv == PRV_U || new_virt)) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_SDT, 0);
+        if (new_virt && new_priv == PRV_U) {
+            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+        }
+    }
+#endif
+}
+
+
 /*
  * Returns the effective PMM field.
  *
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index e4d719a1da..2537515f54 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -973,6 +973,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
+    /* Triggers must not match or fire while in Debug Mode. */
+    if (env->debug_mode) {
+        return;
+    }
+
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
             do_trigger_action(env, DBG_ACTION_BP);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b68160af83..959a1e89c8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -269,6 +269,19 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
     }
     return extract64(result, 0, 64 - pm_len);
 }
+
+static void riscv_cpu_exec_enter(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (!cpu->cfg.ext_sdext || !env->debug_mode) {
+        return;
+    }
+    target_ulong pc = env->dpc;
+    riscv_cpu_leave_debug_mode(env);
+    env->pc = pc;
+}
 #endif
 
 const TCGCPUOps riscv_tcg_ops = {
@@ -285,6 +298,7 @@ const TCGCPUOps riscv_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
+    .cpu_exec_enter = riscv_cpu_exec_enter,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


