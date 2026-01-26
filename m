Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCBAD13C09
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkMTT-0004Xh-NH; Mon, 26 Jan 2026 08:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkMTR-0004VA-VB
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:17:45 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkMTO-0004JD-LT
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:17:45 -0500
Received: by mail-lj1-x241.google.com with SMTP id
 38308e7fff4ca-38319cbc8fbso39625001fa.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 05:17:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769433460; cv=none;
 d=google.com; s=arc-20240605;
 b=jWXrLmzjw7onM37+Sbh2n5ifzDf9D91eCNZYL9gXBsXoOm+Uc2A26QZ1pYI4CqXpxu
 tmNcB63Z5b/S82/SGtbQdaDdPT/k++Q1zB+njf9LEPRT3MQyEPLOCPtDPBSwlVsQq41g
 ryMceX+10p8tXuJxXiYkJWbwAcsYEB6kWtBl52VWB3Ez32Yoy8ppCcWyaC1dv5SRJBWv
 tcK57x8rj0exgsB7tOk/qe2F+T+f/KBLv7d3avO9I21/Ew/Ei81muCnKguaQcrnHfrYC
 ZozOlAK3IeCIZRA496PYtoEwcpsZgq972KF+H8klk4/0mVTrtY0nra0fwPryZjB9YSNR
 SdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W8ZOLU8QMrrUnI9VQnrZb5mOiIKy8gWDrPhGzxBHNbo=;
 fh=j7DfXhfW7wek3nsfaGL5UShsOnrRgkxEEgq+xoP9A/8=;
 b=b9wKzD5EN8Xhivm+a8xi10cafXycEtE3XwQAhdUhSq3W4gFmL6s+lBSCLQJW5L1ivr
 mXhSsHhIzUskNgfp6FCZhh5+9jq+6CAeyxU3y1is9a3Fs9TxEfyz9jWFizInTr5Brum0
 428FkjmacnvW/2JlctivuRAdk4b3aKyix0HAZJxt+bMVOeV9dlkrqi51bIzz/+fYbwgl
 ZI543XXPFitQCZqsQ7zh4p03waJYK2wuEPyJKdotoBUOKYFwAJlrd3CfwX9XCQW0ay3w
 30+A9YAV5IVrssQ+Fp8yBp64sfYc+eV6DnVYx+KeAoNnED8civ8lbdoF5BTIHXHe67yp
 NxRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769433460; x=1770038260; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W8ZOLU8QMrrUnI9VQnrZb5mOiIKy8gWDrPhGzxBHNbo=;
 b=KKJXfhw+7dkLrVbLOPL7DV6/bWi6+OKQ8WOtQuzhxoU/p4tiJNT5Bcpi318A2Mjoz+
 59s/8QCFAvn+9mjVRy96TDl3IO4qJDL5BYkep6UiLiI0EbTpvNQsDuCBnbNM1mP4VwDA
 Rb5/EIg4zcojsUe9ysjTWicgkQw6e4vRrPe8oFO+UjirggJ7W6G3w7t0odXQi6it5a6X
 Is1+T17yykBv1n+4e9dEjjfnn+7JTTNx1w54tmvCoA+kppmbtxC+DNbbJu5aApuJYqdc
 5Bx6a8W4/KFCfQxJ+SAKxVe8bjOMVL9AaFAhzHTxyRsjGYD2VZmtZg6XlFVHSSGFgtCG
 9sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769433460; x=1770038260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8ZOLU8QMrrUnI9VQnrZb5mOiIKy8gWDrPhGzxBHNbo=;
 b=tFgDXNgUjRNsptL2R6LFOnoQ1zmXrJgH8htKCPFGFw1u9URSNTpi0Qk5YzcoZTAxpH
 5uqyrdfHtpraZJ1g+AYSEJFxpcmO9w1L4Ty7D54MdSZ7rrJIfBifoNaUrylrEUOJYDDh
 eYRqID3tyQr6AVFgE8UsSAwEZoBINzXS/ZwWJVq64bYaHHNkjH9Que2i0gq4rWg6RSU+
 eic8lxW1m3o0YLDbDLg7FZ7eME9GXUa2u8Lg0PzwnGplOU9QvuwsesCmm2rcjL37XYr8
 vEdGxDAO3+JQeOqhrRmA6VHFbj/SdVqHhwC9eN+VZBajGQhoIuojc0QHFVJlw3GpP+Ys
 6H9A==
X-Gm-Message-State: AOJu0Yz4rrCAk1CY65SSX6ZI01BSTNhmgXvW0wZqyIUksUX9M2Tja8wq
 /+lBCskKSFV/bCM6N8NQI03OUzexLEN5qaz2G0xTHKVM2+LH6fwMv93jHy0vBXwLiJepNrWELrq
 XHINA+6JRkWOF/Eat8OQaW8yJofUkVmo=
X-Gm-Gg: AZuq6aLmw3ec1jgTf7Q1axAOPg/G9Hd5sq/hhnABM3yQ5hXq1SepfqtJBW0oInmHiZ0
 OEDkZ6nzjKRVt7ee3WXQFBEicgThAwzVuDMHaP5sjc3//fWyYsYqyI9U67eRtq8m2yCh/3WWrqE
 5NVc77erHThgXI0YSyA8Nmwn9dDVHwT9XG6dtKPZs4po6k59IFJ/WoD0YeccyLAif490SdpxFge
 bXlLLjl6rhkZg1tbAuymiEJYTh0VKm2O0hfyVEosvxo53COnXYigm7wc5tGTQl7MyQhMgx7rOrC
 dK+iwtt6FyfoS9IOhG9QnvD/p3Fsv3ucptmUSJg=
X-Received: by 2002:a05:651c:325c:b0:383:b3:77e0 with SMTP id
 38308e7fff4ca-385fa142ff1mr16756371fa.26.1769433459781; Mon, 26 Jan 2026
 05:17:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
 <329a6d5fde74c5cce615053e7f4a0e1c48a27a1b.1768892407.git.chao.liu.zevorn@gmail.com>
 <f6019bbf-1860-4de2-8af6-fdb17cc56139@ventanamicro.com>
In-Reply-To: <f6019bbf-1860-4de2-8af6-fdb17cc56139@ventanamicro.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
Date: Mon, 26 Jan 2026 21:16:57 +0800
X-Gm-Features: AZwV_QjUnH2dDipkOOTvXnY15E7PMcLYNPY50kWRG9YyIPRump-UHElTNhmlQJw
Message-ID: <CAGL8uCU96wSWSX+Hb_JY8Nt5kRBEFDO1JoGvpiPs60+qXQZCpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/7] target/riscv: add sdext debug CSRs state
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn
Content-Type: multipart/alternative; boundary="000000000000d2f4cf06494a545d"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-lj1-x241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d2f4cf06494a545d
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,
On 1/26/2026 8:47 PM, Daniel Henrique Barboza wrote:

Hi Chao,

I wasn't able to apply this patch. Applied all Max's series first, then
tried to apply yours.

The conflict in target/riscv/cpu.c seems to indicate you're basing the
patches on top of something that we don't have upstream:

diff a/target/riscv/cpu.c b/target/riscv/cpu.c    (rejected hunks)
@@ -788,6 +789,11 @@ static void riscv_cpu_reset_hold(Object *obj,
ResetType type)
     set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
     set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
     env->vill = true;
+    env->debug_mode = false;
+    env->dcsr = DCSR_DEBUGVER(4);
+    env->dpc = 0;
+    env->dscratch[0] = 0;
+    env->dscratch[1] = 0;

 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.ext_sdtrig) {


The 'set_ocp_fp8*' lines over here can't be find anywhere else in QEMU, so
I suppose you're basing the patches on top of something else.

If you could base the patches on top of alistair/riscv-to-apply.next tree,
plus Max's patches, that would be great.


This series is based on the master commit: 06a24591: "disas/riscv: Add
support of Zvfofp4min extension".
Max's patches have been merged into the master branch.
Thanks,
Chao



On 1/20/2026 5:23 AM, Chao Liu wrote:

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
them to Debug Mode (or host debugger access).

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
<chao.liu.zevorn@gmail.com>
---
  target/riscv/cpu.c                |   9 +++
  target/riscv/cpu.h                |   4 +
  target/riscv/cpu_bits.h           |  33 ++++++++
  target/riscv/cpu_cfg_fields.h.inc |   1 +
  target/riscv/csr.c                | 126 ++++++++++++++++++++++++++++++
  target/riscv/machine.c            |  20 +++++
  6 files changed, 193 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f1b977f0ee..bd6cff33cf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -211,6 +211,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
      ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
      ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
@@ -788,6 +789,11 @@ static void riscv_cpu_reset_hold(Object *obj,
ResetType type)
      set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
      set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
      env->vill = true;
+    env->debug_mode = false;
+    env->dcsr = DCSR_DEBUGVER(4);
+    env->dpc = 0;
+    env->dscratch[0] = 0;
+    env->dscratch[1] = 0;
    #ifndef CONFIG_USER_ONLY
      if (cpu->cfg.ext_sdtrig) {
@@ -1140,6 +1146,9 @@ static void riscv_cpu_init(Object *obj)
       */
      cpu->cfg.ext_sdtrig = true;
  +    /* sdext is not fully implemented, so it is disabled by default. */
+    cpu->cfg.ext_sdext = false;
+
      if (mcc->def->profile) {
          mcc->def->profile->enabled = true;
      }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0676ed53..2a265faae5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -476,6 +476,10 @@ struct CPUArchState {
        /* True if in debugger mode.  */
      bool debugger;
+    bool debug_mode;
+    target_ulong dcsr;
+    target_ulong dpc;
+    target_ulong dscratch[2];
        uint64_t mstateen[SMSTATEEN_MAX_COUNT];
      uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..bb59f7ff56 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -467,6 +467,39 @@
  #define CSR_DCSR            0x7b0
  #define CSR_DPC             0x7b1
  #define CSR_DSCRATCH        0x7b2
+#define CSR_DSCRATCH1       0x7b3
+
+/* DCSR fields */
+#define DCSR_XDEBUGVER_SHIFT    28
+#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_DEBUGVER(val)      ((target_ulong)(val) <<
DCSR_XDEBUGVER_SHIFT)
+#define DCSR_EXTCAUSE_SHIFT     24
+#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
+#define DCSR_CETRIG             BIT(19)
+#define DCSR_PELP               BIT(18)
+#define DCSR_EBREAKVS           BIT(17)
+#define DCSR_EBREAKVU           BIT(16)
+#define DCSR_EBREAKM            BIT(15)
+#define DCSR_EBREAKS            BIT(13)
+#define DCSR_EBREAKU            BIT(12)
+#define DCSR_STEPIE             BIT(11)
+#define DCSR_STOPCOUNT          BIT(10)
+#define DCSR_STOPTIME           BIT(9)
+#define DCSR_CAUSE_SHIFT        6
+#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
+#define DCSR_V                  BIT(5)
+#define DCSR_MPRVEN             BIT(4)
+#define DCSR_NMIP               BIT(3)
+#define DCSR_STEP               BIT(2)
+#define DCSR_PRV_MASK           0x3u
+
+#define DCSR_CAUSE_EBREAK       1
+#define DCSR_CAUSE_TRIGGER      2
+#define DCSR_CAUSE_HALTREQ      3
+#define DCSR_CAUSE_STEP         4
+#define DCSR_CAUSE_RESET        5
+#define DCSR_CAUSE_GROUP        6
+#define DCSR_CAUSE_OTHER        7
    /* Performance Counters */
  #define CSR_MHPMCOUNTER3    0xb03
diff --git a/target/riscv/cpu_cfg_fields.h.inc
b/target/riscv/cpu_cfg_fields.h.inc
index a8c133d663..99b5529161 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
  BOOL_FIELD(ext_zimop)
  BOOL_FIELD(ext_zcmop)
  BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_sdext)
  BOOL_FIELD(ext_sdtrig)
  BOOL_FIELD(ext_smstateen)
  BOOL_FIELD(ext_sstc)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 870fad87ac..3e38c943e0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3136,6 +3136,126 @@ static RISCVException write_mtval(CPURISCVState
*env, int csrno,
      return RISCV_EXCP_NONE;
  }
  +#if !defined(CONFIG_USER_ONLY)
+static RISCVException sdext(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_sdext) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (!env->debug_mode && !env->debugger) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_visible_mask(CPURISCVState *env)
+{
+    target_ulong mask = (target_ulong)-1;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!riscv_has_ext(env, RVH)) {
+        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
+    }
+    if (!riscv_has_ext(env, RVS)) {
+        mask &= ~DCSR_EBREAKS;
+    }
+    if (!riscv_has_ext(env, RVU)) {
+        mask &= ~DCSR_EBREAKU;
+    }
+    if (!cpu->cfg.ext_zicfilp) {
+        mask &= ~DCSR_PELP;
+    }
+    if (!cpu->cfg.ext_smdbltrp) {
+        mask &= ~DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException read_dcsr(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = env->dcsr & dcsr_visible_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_writable_mask(CPURISCVState *env)
+{
+    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
+                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
+                        DCSR_STEP | DCSR_PRV_MASK;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    mask |= DCSR_MPRVEN;
+
+    if (riscv_has_ext(env, RVH)) {
+        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
+    }
+    if (riscv_has_ext(env, RVS)) {
+        mask |= DCSR_EBREAKS;
+    }
+    if (riscv_has_ext(env, RVU)) {
+        mask |= DCSR_EBREAKU;
+    }
+    if (cpu->cfg.ext_zicfilp) {
+        mask |= DCSR_PELP;
+    }
+    if (cpu->cfg.ext_smdbltrp) {
+        mask |= DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException write_dcsr(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    target_ulong mask = dcsr_writable_mask(env);
+    target_ulong new_val = env->dcsr;
+
+    new_val &= ~mask;
+    new_val |= val & mask;
+    new_val &= ~DCSR_XDEBUGVER_MASK;
+    new_val |= DCSR_DEBUGVER(4);
+    env->dcsr = new_val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dpc(CPURISCVState *env, int csrno,
+                               target_ulong *val)
+{
+    *val = env->dpc & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dpc(CPURISCVState *env, int csrno,
+                                target_ulong val, uintptr_t ra)
+{
+    env->dpc = val & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dscratch(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    *val = env->dscratch[index];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dscratch(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    env->dscratch[index] = val;
+    return RISCV_EXCP_NONE;
+}
+#endif /* !CONFIG_USER_ONLY */
+
  /* Execution environment configuration setup */
  static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong *val)
@@ -6297,6 +6417,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
      [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata
},
      [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore
},
      [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext
},
+#if !defined(CONFIG_USER_ONLY)
+    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
+    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
+    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch
},
+    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch
},
+#endif
        [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL,
rmw_xctrctl    },
      [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL,
rmw_xctrctl    },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 62c51c8033..52264cf047 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -248,6 +248,25 @@ static const VMStateDescription vmstate_sdtrig = {
          VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
          VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
          VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sdext = {
+    .name = "cpu/sdext",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdtrig_needed,
+    .post_load = sdtrig_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
          VMSTATE_END_OF_LIST()
      }
  };
@@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
          &vmstate_ctr,
          &vmstate_sstc,
          &vmstate_sdtrig,
+        &vmstate_sdext,
          NULL
      }
  };

--000000000000d2f4cf06494a545d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><u></u>

 =20
   =20
 =20
  <div>
    <p><font face=3D"monospace"><br>
      </font></p>
    <p><font face=3D"monospace">Hi Daniel,</font></p>
    <div><font face=3D"monospace">On 1/26/2026
        8:47 PM, Daniel Henrique Barboza wrote:<br>
      </font></div>
    <blockquote type=3D"cite"><font face=3D"monospace">Hi Chao,
        <br>
      </font>
      <font face=3D"monospace"><br>
        I wasn&#39;t able to apply this patch. Applied all Max&#39;s series
        first, then tried to apply yours.
        <br>
      </font>
      <font face=3D"monospace"><br>
        The conflict in target/riscv/cpu.c seems to indicate you&#39;re
        basing the patches on top of something that we don&#39;t have
        upstream:
        <br>
      </font>
      <font face=3D"monospace"><br>
        diff a/target/riscv/cpu.c b/target/riscv/cpu.c=C2=A0=C2=A0=C2=A0 (r=
ejected
        hunks)
        <br>
        @@ -788,6 +789,11 @@ static void riscv_cpu_reset_hold(Object
        *obj, ResetType type)
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0 set_ocp_fp8_same_canonical_nan(true,
        &amp;env-&gt;fp_status);
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0 set_ocp_fp8e5m2_no_signal_nan(true,
        &amp;env-&gt;fp_status);
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;vill =3D true;
        <br>
        +=C2=A0=C2=A0=C2=A0 env-&gt;debug_mode =3D false;
        <br>
        +=C2=A0=C2=A0=C2=A0 env-&gt;dcsr =3D DCSR_DEBUGVER(4);
        <br>
        +=C2=A0=C2=A0=C2=A0 env-&gt;dpc =3D 0;
        <br>
        +=C2=A0=C2=A0=C2=A0 env-&gt;dscratch[0] =3D 0;
        <br>
        +=C2=A0=C2=A0=C2=A0 env-&gt;dscratch[1] =3D 0;
        <br>
      </font>
      <font face=3D"monospace"><br>
        =C2=A0#ifndef CONFIG_USER_ONLY
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0 if (cpu-&gt;cfg.ext_sdtrig) {
        <br>
      </font>
      <font face=3D"monospace"><br>
      </font>
      <font face=3D"monospace"><br>
        The &#39;set_ocp_fp8*&#39; lines over here can&#39;t be find anywhe=
re else
        in QEMU, so I suppose you&#39;re basing the patches on top of
        something else.
        <br>
      </font>
      <font face=3D"monospace"><br>
        If you could base the patches on top of
        alistair/riscv-to-apply.next tree, plus Max&#39;s patches, that
        would be great.=C2=A0</font><font face=3D"monospace"><br></font></b=
lockquote><blockquote type=3D"cite">
      <font face=3D"monospace"><br></font></blockquote><div class=3D"gmail-=
paragraph-UMKeIJ"><font face=3D"monospace">This series is based on the mast=
er commit: 06a24591: &quot;disas/riscv: Add support of Zvfofp4min extension=
&quot;.</font></div>
<div class=3D"gmail-paragraph-UMKeIJ"><font face=3D"monospace"><span style=
=3D"padding-left:0.1px">
</span></font></div>
<div class=3D"gmail-paragraph-UMKeIJ"><font face=3D"monospace">Max&#39;s pa=
tches have been merged into the master branch.</font></div>
<div class=3D"gmail-paragraph-UMKeIJ"><font face=3D"monospace"><span style=
=3D"padding-left:0.1px">
</span></font></div>
<div class=3D"gmail-paragraph-UMKeIJ"><font face=3D"monospace">Thanks,</fon=
t></div>
<div class=3D"gmail-paragraph-UMKeIJ"><font face=3D"monospace">Chao</font><=
/div><blockquote type=3D"cite"><font face=3D"monospace">
      </font>
      <font face=3D"monospace"><br>
      </font>
      <font face=3D"monospace"><br>
        On 1/20/2026 5:23 AM, Chao Liu wrote:
        <br>
      </font>
      <blockquote type=3D"cite"><font face=3D"monospace">RISC-V Debug
          Specification:
          <br>
          <a href=3D"https://github.com/riscv/riscv-debug-spec/releases/tag=
/1.0" target=3D"_blank">https://github.com/riscv/riscv-debug-spec/releases/=
tag/1.0</a>
          <br>
        </font>
        <font face=3D"monospace"><br>
          Add architectural state for Sdext Debug Mode: debug_mode,
          dcsr, dpc
          <br>
          and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and
          gate
          <br>
          them to Debug Mode (or host debugger access).
          <br>
        </font>
        <font face=3D"monospace"><br>
          Signed-off-by: Chao Liu <a href=3D"mailto:chao.liu.zevorn@gmail.c=
om" target=3D"_blank">&lt;chao.liu.zevorn@gmail.com&gt;</a>
          <br>
          ---
          <br>
          =C2=A0 target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +++
          <br>
          =C2=A0 target/riscv/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
          <br>
          =C2=A0 target/riscv/cpu_bits.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 33 ++++++++
          <br>
          =C2=A0 target/riscv/cpu_cfg_fields.h.inc |=C2=A0=C2=A0 1 +
          <br>
          =C2=A0 target/riscv/csr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 126
          ++++++++++++++++++++++++++++++
          <br>
          =C2=A0 target/riscv/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +++++
          <br>
          =C2=A0 6 files changed, 193 insertions(+)
          <br>
        </font>
        <font face=3D"monospace"><br>
          diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
          <br>
          index f1b977f0ee..bd6cff33cf 100644
          <br>
          --- a/target/riscv/cpu.c
          <br>
          +++ b/target/riscv/cpu.c
          <br>
          @@ -211,6 +211,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERS=
ION_1_12_0, ext_zvkt),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISA_EXT_DATA_ENTRY(zhinx, PRIV_VER=
SION_1_12_0,
          ext_zhinx),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_=
VERSION_1_12_0,
          ext_zhinxmin),
          <br>
          +=C2=A0=C2=A0=C2=A0 ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0=
,
          ext_sdext),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VE=
RSION_1_12_0,
          ext_sdtrig),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISA_EXT_DATA_ENTRY(shcounterenw, P=
RIV_VERSION_1_12_0,
          has_priv_1_12),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISA_EXT_DATA_ENTRY(sha, PRIV_VERSI=
ON_1_12_0, ext_sha),
          <br>
          @@ -788,6 +789,11 @@ static void riscv_cpu_reset_hold(Object
          *obj, ResetType type)
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_ocp_fp8_same_canonical_nan(tru=
e,
          &amp;env-&gt;fp_status);
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_ocp_fp8e5m2_no_signal_nan(true=
,
          &amp;env-&gt;fp_status);
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;vill =3D true;
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;debug_mode =3D false;
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;dcsr =3D DCSR_DEBUGVER(4);
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;dpc =3D 0;
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;dscratch[0] =3D 0;
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;dscratch[1] =3D 0;
          <br>
          =C2=A0 =C2=A0 #ifndef CONFIG_USER_ONLY
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu-&gt;cfg.ext_sdtrig) {
          <br>
          @@ -1140,6 +1146,9 @@ static void riscv_cpu_init(Object *obj)
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu-&gt;cfg.ext_sdtrig =3D true;
          <br>
          =C2=A0 +=C2=A0=C2=A0=C2=A0 /* sdext is not fully implemented, so =
it is disabled by
          default. */
          <br>
          +=C2=A0=C2=A0=C2=A0 cpu-&gt;cfg.ext_sdext =3D false;
          <br>
          +
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mcc-&gt;def-&gt;profile) {
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcc-&gt;de=
f-&gt;profile-&gt;enabled =3D true;
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
          <br>
          diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
          <br>
          index 4c0676ed53..2a265faae5 100644
          <br>
          --- a/target/riscv/cpu.h
          <br>
          +++ b/target/riscv/cpu.h
          <br>
          @@ -476,6 +476,10 @@ struct CPUArchState {
          <br>
          =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* True if in debugger mode=
.=C2=A0 */
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool debugger;
          <br>
          +=C2=A0=C2=A0=C2=A0 bool debug_mode;
          <br>
          +=C2=A0=C2=A0=C2=A0 target_ulong dcsr;
          <br>
          +=C2=A0=C2=A0=C2=A0 target_ulong dpc;
          <br>
          +=C2=A0=C2=A0=C2=A0 target_ulong dscratch[2];
          <br>
          =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t mstateen[SMSTATEEN=
_MAX_COUNT];
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t hstateen[SMSTATEEN_MAX_CO=
UNT];
          <br>
          diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
          <br>
          index b62dd82fe7..bb59f7ff56 100644
          <br>
          --- a/target/riscv/cpu_bits.h
          <br>
          +++ b/target/riscv/cpu_bits.h
          <br>
          @@ -467,6 +467,39 @@
          <br>
          =C2=A0 #define CSR_DCSR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x7b0
          <br>
          =C2=A0 #define CSR_DPC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x7b1
          <br>
          =C2=A0 #define CSR_DSCRATCH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x7b2
          <br>
          +#define CSR_DSCRATCH1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x7b3
          <br>
          +
          <br>
          +/* DCSR fields */
          <br>
          +#define DCSR_XDEBUGVER_SHIFT=C2=A0=C2=A0=C2=A0 28
          <br>
          +#define DCSR_XDEBUGVER_MASK=C2=A0=C2=A0=C2=A0=C2=A0 (0xfu &lt;&l=
t;
          DCSR_XDEBUGVER_SHIFT)
          <br>
          +#define DCSR_DEBUGVER(val)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((targe=
t_ulong)(val) &lt;&lt;
          DCSR_XDEBUGVER_SHIFT)
          <br>
          +#define DCSR_EXTCAUSE_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 24
          <br>
          +#define DCSR_EXTCAUSE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x7u &=
lt;&lt;
          DCSR_EXTCAUSE_SHIFT)
          <br>
          +#define DCSR_CETRIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(19)
          <br>
          +#define DCSR_PELP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(18)
          <br>
          +#define DCSR_EBREAKVS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BIT(17)
          <br>
          +#define DCSR_EBREAKVU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BIT(16)
          <br>
          +#define DCSR_EBREAKM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(15)
          <br>
          +#define DCSR_EBREAKS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(13)
          <br>
          +#define DCSR_EBREAKU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(12)
          <br>
          +#define DCSR_STEPIE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(11)
          <br>
          +#define DCSR_STOPCOUNT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(10)
          <br>
          +#define DCSR_STOPTIME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BIT(9)
          <br>
          +#define DCSR_CAUSE_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 6
          <br>
          +#define DCSR_CAUSE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0x7u &lt;&lt;
          DCSR_CAUSE_SHIFT)
          <br>
          +#define DCSR_V=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5)
          <br>
          +#define DCSR_MPRVEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4)
          <br>
          +#define DCSR_NMIP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3)
          <br>
          +#define DCSR_STEP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2)
          <br>
          +#define DCSR_PRV_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x3u
          <br>
          +
          <br>
          +#define DCSR_CAUSE_EBREAK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
          <br>
          +#define DCSR_CAUSE_TRIGGER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
          <br>
          +#define DCSR_CAUSE_HALTREQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
          <br>
          +#define DCSR_CAUSE_STEP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 4
          <br>
          +#define DCSR_CAUSE_RESET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 5
          <br>
          +#define DCSR_CAUSE_GROUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 6
          <br>
          +#define DCSR_CAUSE_OTHER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 7
          <br>
          =C2=A0 =C2=A0 /* Performance Counters */
          <br>
          =C2=A0 #define CSR_MHPMCOUNTER3=C2=A0=C2=A0=C2=A0 0xb03
          <br>
          diff --git a/target/riscv/cpu_cfg_fields.h.inc
          b/target/riscv/cpu_cfg_fields.h.inc
          <br>
          index a8c133d663..99b5529161 100644
          <br>
          --- a/target/riscv/cpu_cfg_fields.h.inc
          <br>
          +++ b/target/riscv/cpu_cfg_fields.h.inc
          <br>
          @@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
          <br>
          =C2=A0 BOOL_FIELD(ext_zimop)
          <br>
          =C2=A0 BOOL_FIELD(ext_zcmop)
          <br>
          =C2=A0 BOOL_FIELD(ext_ztso)
          <br>
          +BOOL_FIELD(ext_sdext)
          <br>
          =C2=A0 BOOL_FIELD(ext_sdtrig)
          <br>
          =C2=A0 BOOL_FIELD(ext_smstateen)
          <br>
          =C2=A0 BOOL_FIELD(ext_sstc)
          <br>
          diff --git a/target/riscv/csr.c b/target/riscv/csr.c
          <br>
          index 870fad87ac..3e38c943e0 100644
          <br>
          --- a/target/riscv/csr.c
          <br>
          +++ b/target/riscv/csr.c
          <br>
          @@ -3136,6 +3136,126 @@ static RISCVException
          write_mtval(CPURISCVState *env, int csrno,
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          =C2=A0 }
          <br>
          =C2=A0 +#if !defined(CONFIG_USER_ONLY)
          <br>
          +static RISCVException sdext(CPURISCVState *env, int csrno)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 if (!riscv_cpu_cfg(env)-&gt;ext_sdext) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_ILL=
EGAL_INST;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 if (!env-&gt;debug_mode &amp;&amp; !env-&gt;d=
ebugger) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_ILL=
EGAL_INST;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          +}
          <br>
          +
          <br>
          +static target_ulong dcsr_visible_mask(CPURISCVState *env)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 target_ulong mask =3D (target_ulong)-1;
          <br>
          +=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =3D env_archcpu(env);
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 if (!riscv_has_ext(env, RVH)) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask &amp;=3D ~(DCSR_=
EBREAKVS | DCSR_EBREAKVU |
          DCSR_V);
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (!riscv_has_ext(env, RVS)) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask &amp;=3D ~DCSR_E=
BREAKS;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (!riscv_has_ext(env, RVU)) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask &amp;=3D ~DCSR_E=
BREAKU;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (!cpu-&gt;cfg.ext_zicfilp) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask &amp;=3D ~DCSR_P=
ELP;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (!cpu-&gt;cfg.ext_smdbltrp) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask &amp;=3D ~DCSR_C=
ETRIG;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 return mask;
          <br>
          +}
          <br>
          +
          <br>
          +static RISCVException read_dcsr(CPURISCVState *env, int
          csrno,
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong *val)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 *val =3D env-&gt;dcsr &amp; dcsr_visible_mask=
(env);
          <br>
          +=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          +}
          <br>
          +
          <br>
          +static target_ulong dcsr_writable_mask(CPURISCVState *env)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 target_ulong mask =3D DCSR_EBREAKM | DCSR_EBR=
EAKS |
          DCSR_EBREAKU |
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 DCSR_STEPIE | DCSR_STOPCOUNT |
          DCSR_STOPTIME |
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 DCSR_STEP | DCSR_PRV_MASK;
          <br>
          +=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =3D env_archcpu(env);
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 mask |=3D DCSR_MPRVEN;
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 if (riscv_has_ext(env, RVH)) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D DCSR_EBREAK=
VS | DCSR_EBREAKVU | DCSR_V;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (riscv_has_ext(env, RVS)) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D DCSR_EBREAK=
S;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (riscv_has_ext(env, RVU)) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D DCSR_EBREAK=
U;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (cpu-&gt;cfg.ext_zicfilp) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D DCSR_PELP;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +=C2=A0=C2=A0=C2=A0 if (cpu-&gt;cfg.ext_smdbltrp) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D DCSR_CETRIG=
;
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 return mask;
          <br>
          +}
          <br>
          +
          <br>
          +static RISCVException write_dcsr(CPURISCVState *env, int
          csrno,
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong val, ui=
ntptr_t
          ra)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 target_ulong mask =3D dcsr_writable_mask(env)=
;
          <br>
          +=C2=A0=C2=A0=C2=A0 target_ulong new_val =3D env-&gt;dcsr;
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 new_val &amp;=3D ~mask;
          <br>
          +=C2=A0=C2=A0=C2=A0 new_val |=3D val &amp; mask;
          <br>
          +=C2=A0=C2=A0=C2=A0 new_val &amp;=3D ~DCSR_XDEBUGVER_MASK;
          <br>
          +=C2=A0=C2=A0=C2=A0 new_val |=3D DCSR_DEBUGVER(4);
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;dcsr =3D new_val;
          <br>
          +=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          +}
          <br>
          +
          <br>
          +static RISCVException read_dpc(CPURISCVState *env, int csrno,
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong *val)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 *val =3D env-&gt;dpc &amp; get_xepc_mask(env)=
;
          <br>
          +=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          +}
          <br>
          +
          <br>
          +static RISCVException write_dpc(CPURISCVState *env, int
          csrno,
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong val, uintptr_=
t
          ra)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;dpc =3D val &amp; get_xepc_mask(env);
          <br>
          +=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          +}
          <br>
          +
          <br>
          +static RISCVException read_dscratch(CPURISCVState *env, int
          csrno,
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ta=
rget_ulong *val)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 int index =3D (csrno =3D=3D CSR_DSCRATCH1) ? =
1 : 0;
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 *val =3D env-&gt;dscratch[index];
          <br>
          +=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          +}
          <br>
          +
          <br>
          +static RISCVException write_dscratch(CPURISCVState *env, int
          csrno,
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 target_ulong val,
          uintptr_t ra)
          <br>
          +{
          <br>
          +=C2=A0=C2=A0=C2=A0 int index =3D (csrno =3D=3D CSR_DSCRATCH1) ? =
1 : 0;
          <br>
          +
          <br>
          +=C2=A0=C2=A0=C2=A0 env-&gt;dscratch[index] =3D val;
          <br>
          +=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
          <br>
          +}
          <br>
          +#endif /* !CONFIG_USER_ONLY */
          <br>
          +
          <br>
          =C2=A0 /* Execution environment configuration setup */
          <br>
          =C2=A0 static RISCVException read_menvcfg(CPURISCVState *env, int
          csrno,
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 target_ulong *val)
          <br>
          @@ -6297,6 +6417,12 @@ riscv_csr_operations
          csr_ops[CSR_TABLE_SIZE] =3D {
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [CSR_TDATA3]=C2=A0=C2=A0=C2=A0 =3D=
=C2=A0 { &quot;tdata3&quot;,=C2=A0=C2=A0 debug, read_tdata,=C2=A0=C2=A0=C2=
=A0
          write_tdata=C2=A0=C2=A0=C2=A0 },
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [CSR_TINFO]=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D=C2=A0 { &quot;tinfo&quot;,=C2=A0=C2=A0=C2=A0 debug, read_tinfo,=C2=
=A0=C2=A0=C2=A0
          write_ignore=C2=A0=C2=A0 },
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [CSR_MCONTEXT]=C2=A0 =3D=C2=A0 { &=
quot;mcontext&quot;, debug, read_mcontext,
          write_mcontext },
          <br>
          +#if !defined(CONFIG_USER_ONLY)
          <br>
          +=C2=A0=C2=A0=C2=A0 [CSR_DCSR]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
=C2=A0 { &quot;dcsr&quot;,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdext, read_dcsr,=
=C2=A0=C2=A0=C2=A0=C2=A0
          write_dcsr },
          <br>
          +=C2=A0=C2=A0=C2=A0 [CSR_DPC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D=C2=A0 { &quot;dpc&quot;,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdext, re=
ad_dpc,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
          write_dpc },
          <br>
          +=C2=A0=C2=A0=C2=A0 [CSR_DSCRATCH]=C2=A0 =3D=C2=A0 { &quot;dscrat=
ch0&quot;, sdext, read_dscratch,
          write_dscratch },
          <br>
          +=C2=A0=C2=A0=C2=A0 [CSR_DSCRATCH1] =3D=C2=A0 { &quot;dscratch1&q=
uot;, sdext, read_dscratch,
          write_dscratch },
          <br>
          +#endif
          <br>
          =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [CSR_MCTRCTL]=C2=A0=C2=A0=
=C2=A0 =3D { &quot;mctrctl&quot;,=C2=A0=C2=A0=C2=A0 ctr_mmode,=C2=A0 NULL,
          NULL, rmw_xctrctl=C2=A0=C2=A0=C2=A0 },
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [CSR_SCTRCTL]=C2=A0=C2=A0=C2=A0 =
=3D { &quot;sctrctl&quot;,=C2=A0=C2=A0=C2=A0 ctr_smode,=C2=A0 NULL,
          NULL, rmw_xctrctl=C2=A0=C2=A0=C2=A0 },
          <br>
          diff --git a/target/riscv/machine.c b/target/riscv/machine.c
          <br>
          index 62c51c8033..52264cf047 100644
          <br>
          --- a/target/riscv/machine.c
          <br>
          +++ b/target/riscv/machine.c
          <br>
          @@ -248,6 +248,25 @@ static const VMStateDescription
          vmstate_sdtrig =3D {
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UI=
NTTL_ARRAY(env.tdata1, RISCVCPU,
          RV_MAX_TRIGGERS),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UI=
NTTL_ARRAY(env.tdata2, RISCVCPU,
          RV_MAX_TRIGGERS),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UI=
NTTL_ARRAY(env.tdata3, RISCVCPU,
          RV_MAX_TRIGGERS),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL_V(env.de=
bug_mode, RISCVCPU, 3),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL_V(env.=
dcsr, RISCVCPU, 3),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL_V(env.=
dpc, RISCVCPU, 3),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL_ARRAY_=
V(env.dscratch, RISCVCPU, 2, 3),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()
          <br>
          +=C2=A0=C2=A0=C2=A0 }
          <br>
          +};
          <br>
          +
          <br>
          +static const VMStateDescription vmstate_sdext =3D {
          <br>
          +=C2=A0=C2=A0=C2=A0 .name =3D &quot;cpu/sdext&quot;,
          <br>
          +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
          <br>
          +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
          <br>
          +=C2=A0=C2=A0=C2=A0 .needed =3D sdtrig_needed,
          <br>
          +=C2=A0=C2=A0=C2=A0 .post_load =3D sdtrig_post_load,
          <br>
          +=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL_V(env.de=
bug_mode, RISCVCPU, 3),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL_V(env.=
dcsr, RISCVCPU, 3),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL_V(env.=
dpc, RISCVCPU, 3),
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL_ARRAY_=
V(env.dscratch, RISCVCPU, 2, 3),
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_EN=
D_OF_LIST()
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
          <br>
          =C2=A0 };
          <br>
          @@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu
          =3D {
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &amp;vmsta=
te_ctr,
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &amp;vmsta=
te_sstc,
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &amp;vmsta=
te_sdtrig,
          <br>
          +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &amp;vmstate_sdext,
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
          <br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
          <br>
          =C2=A0 };
          <br>
        </font></blockquote>
      <font face=3D"monospace"><br>
      </font></blockquote>
  </div>

</div>

--000000000000d2f4cf06494a545d--

