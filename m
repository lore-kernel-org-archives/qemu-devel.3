Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C91D232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Q4-0004mA-T7; Fri, 09 Jan 2026 01:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PU-0003pJ-F6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:50 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PO-0002qT-UQ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:45 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so2703130b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941741; x=1768546541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+XdEsEhM8+wyXLt72BIhQhNu5prCrMhg5aHsM0s/2w=;
 b=iWLYpR2GQwZqILafTNl8pM8tlNH3t2g99bSGdBLMSQeQNy/jTbfZrzYPA1xsts+85G
 M+4jTAn7O1MIwbh4Lg1BpYPElOvoP89OGnwZX86Bes6dlGqQ5HlBUiXih/JKbKvBqNmP
 H3ss9SxQw3HrDfBISZxb3GQmTGloR24ddwsQ9nwG1+CDkI/TzGXl6t5GW9Ql+R3jpGQa
 bzBzN60btEnpnlGW4JjLkNoyY0W0nB83XloutFvc8zLUa4yf+gl8Q9/WyEOa6IwIyon6
 aZ13Mnu6l043sQ1aucKmkRv0C10yVBYimuVgMFDYUzV2gooUb/m77+6GKCpEwPH/wJgL
 7gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941741; x=1768546541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C+XdEsEhM8+wyXLt72BIhQhNu5prCrMhg5aHsM0s/2w=;
 b=nWI3FsCQ2iRj1XJeq3R3C7fU17jqX202N2vEeC34+cNx6NpP4dbTcceC3b2PHlpRXl
 2BsLBLl/1xgW7znceOGOL1l+bq7M0mEf4zj5Vc13BHo2Njr5lvxaeXfPV7somlhXrIw5
 2G+GY5lI9VDUa882URbJTZvcUQh1xIsbpwg5t6O5Mcm0yiD/kQIhWB43XNxW4oC5lj7l
 f/03TdlK40nk7uK/hYjGqqjP70/Bs8x6R6bqvoHvSWOcV94mJAGcERwCLSdBqjAhB02c
 2ZfAN1tgvpnCQu4mLYI6lGKU6hFg+BqFubixw70wGrqC3/oN1moHPlqMGkdxI+Aejv0N
 0+vg==
X-Gm-Message-State: AOJu0YyMjhlbTueWvwcCqpxeqpK6g5fHD7X7BBbuQxbbCV7rDMPGWnG2
 CHH5LZ45Ao+YoAnJdnv/7OQUJjsSOuh7SORQsclE+5Mrdg3Srvul+G74C2xY2w==
X-Gm-Gg: AY/fxX68Xf3Djs9y75jsZxFh1M5CXXdHoHkPaezmHDzQe7PriRsjkdjoKDJePtb2xg1
 keadyO8H8rWnbNq2FZbigmCL3pOXOava6fE4zd+bd+L2sTMyhmezH8tZyHwfBHo4PtFCbDvnP0f
 6hJmsGbykIgrGV4RhhZQa9DPOWWSHnF5d8p+CewWY9bZsl2wG/gc90DJCDriy3vllBn6xGmMeRe
 ny+lggzSOrveoOdjMFkfSNEtBwkVRG69zxem9BEKkbDV+oWBasTvCS1WZ45705+bY2QaomEPpWz
 i47pOyf4iOTkxZDO1XqpwJmDt2D5CoUdQBuOJqAFDcIybqfWb+FByckz7aECtT25YA2ymRHL+ZK
 TocjHiDXWuTJ8l/wsfYjQaYGdk9HGfatoSE0Y57k9skBcIJ1sQdpSH3DywnDgtpmRnAQMQsf83R
 iLe61ZDuZtZogG5PS8h64kOYeWFM+x+YzQctonEFVxc1y7lVk3REcibQW4/mZTpgETg8FXvqjNQ
 nvDEmP/6Ya/BEQJNxE=
X-Google-Smtp-Source: AGHT+IFrnHQmkdiWMyzUlJglD9Hbsh/8IPmEjNRQmDfnF1/NnVVkZf9kMnrqPmnQCjJrNUJds5IOOA==
X-Received: by 2002:a05:6a20:430f:b0:366:14ac:e202 with SMTP id
 adf61e73a8af0-3898fa5442amr8298014637.64.1767941741268; 
 Thu, 08 Jan 2026 22:55:41 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:40 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/34] target/riscv: Fix size of trivial CPUArchState fields
Date: Fri,  9 Jan 2026 16:54:35 +1000
Message-ID: <20260109065459.19987-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Johansson <anjo@rev.ng>

This commits groups together all CPUArchState fields whose behaviour can
be retained by simply changing the size of the field.

Note, senvcfg is defined to be SXLEN bits wide, but is widened to 64
bits to match henvcfg and menvcfg.  Next, [m|h]edeleg are changed to
64 bits as defined privileged specification, and hvictl is fixed to 32
bits which holds all relevant values, see HVICTL_VALID_MASK.  The
remaining fields touched in the commit are widened from [H|S|M]XLEN
to 64-bit.

Note, the cpu/hyper, cpu/envcfg, cpu/jvt, and cpu VMSTATE versions are
bumped, breaking migration from older versions.

References to the privileged/unprivileged RISCV specification refer to
version 20250508.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251027181831.27016-2-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251103033713.904455-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 78 +++++++++++++++++++--------------------
 target/riscv/machine.c | 84 +++++++++++++++++++++---------------------
 2 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b3c0be5779..bc6e093ca2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -255,7 +255,7 @@ struct CPUArchState {
     /* 128-bit helpers upper part return value */
     target_ulong retxh;
 
-    target_ulong jvt;
+    uint64_t jvt;
 
     /* elp state for zicfilp extension */
     bool      elp;
@@ -272,7 +272,7 @@ struct CPUArchState {
     target_ulong priv;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
-    target_ulong senvcfg;
+    uint64_t senvcfg;
 
 #ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
@@ -314,18 +314,18 @@ struct CPUArchState {
      */
     uint64_t vsie;
 
-    target_ulong satp;   /* since: priv-1.10.0 */
-    target_ulong stval;
-    target_ulong medeleg;
+    uint64_t satp;   /* since: priv-1.10.0 */
+    uint64_t stval;
+    uint64_t medeleg;
 
-    target_ulong stvec;
-    target_ulong sepc;
-    target_ulong scause;
+    uint64_t stvec;
+    uint64_t sepc;
+    uint64_t scause;
 
-    target_ulong mtvec;
-    target_ulong mepc;
-    target_ulong mcause;
-    target_ulong mtval;  /* since: priv-1.10.0 */
+    uint64_t mtvec;
+    uint64_t mepc;
+    uint64_t mcause;
+    uint64_t mtval;  /* since: priv-1.10.0 */
 
     uint64_t mctrctl;
     uint32_t sctrdepth;
@@ -347,13 +347,13 @@ struct CPUArchState {
     uint64_t mvip;
 
     /* Hypervisor CSRs */
-    target_ulong hstatus;
-    target_ulong hedeleg;
+    uint64_t hstatus;
+    uint64_t hedeleg;
     uint64_t hideleg;
     uint32_t hcounteren;
-    target_ulong htval;
-    target_ulong htinst;
-    target_ulong hgatp;
+    uint64_t htval;
+    uint64_t htinst;
+    uint64_t hgatp;
     target_ulong hgeie;
     target_ulong hgeip;
     uint64_t htimedelta;
@@ -367,7 +367,7 @@ struct CPUArchState {
     uint64_t hvip;
 
     /* Hypervisor controlled virtual interrupt priorities */
-    target_ulong hvictl;
+    uint32_t hvictl;
     uint8_t hviprio[64];
 
     /* Upper 64-bits of 128-bit CSRs */
@@ -380,26 +380,26 @@ struct CPUArchState {
      * For RV64 this is a 64-bit vsstatus.
      */
     uint64_t vsstatus;
-    target_ulong vstvec;
-    target_ulong vsscratch;
-    target_ulong vsepc;
-    target_ulong vscause;
-    target_ulong vstval;
-    target_ulong vsatp;
+    uint64_t vstvec;
+    uint64_t vsscratch;
+    uint64_t vsepc;
+    uint64_t vscause;
+    uint64_t vstval;
+    uint64_t vsatp;
 
     /* AIA VS-mode CSRs */
     target_ulong vsiselect;
 
-    target_ulong mtval2;
-    target_ulong mtinst;
+    uint64_t mtval2;
+    uint64_t mtinst;
 
     /* HS Backup CSRs */
-    target_ulong stvec_hs;
-    target_ulong sscratch_hs;
-    target_ulong sepc_hs;
-    target_ulong scause_hs;
-    target_ulong stval_hs;
-    target_ulong satp_hs;
+    uint64_t stvec_hs;
+    uint64_t sscratch_hs;
+    uint64_t sepc_hs;
+    uint64_t scause_hs;
+    uint64_t stval_hs;
+    uint64_t satp_hs;
     uint64_t mstatus_hs;
 
     /*
@@ -436,8 +436,8 @@ struct CPUArchState {
 
     PMUFixedCtrState pmu_fixed_ctrs[2];
 
-    target_ulong sscratch;
-    target_ulong mscratch;
+    uint64_t sscratch;
+    uint64_t mscratch;
 
     /* Sstc CSRs */
     uint64_t stimecmp;
@@ -507,11 +507,11 @@ struct CPUArchState {
 #endif /* CONFIG_KVM */
 
     /* RNMI */
-    target_ulong mnscratch;
-    target_ulong mnepc;
-    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
-    target_ulong mnstatus;
-    target_ulong rnmip;
+    uint64_t mnscratch;
+    uint64_t mnepc;
+    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
+    uint64_t mnstatus;
+    uint64_t rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
 };
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 18d790af0d..f6ca017211 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -80,17 +80,17 @@ static bool hyper_needed(void *opaque)
 
 static const VMStateDescription vmstate_hyper = {
     .name = "cpu/hyper",
-    .version_id = 4,
-    .minimum_version_id = 4,
+    .version_id = 5,
+    .minimum_version_id = 5,
     .needed = hyper_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
-        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
+        VMSTATE_UINT64(env.hstatus, RISCVCPU),
+        VMSTATE_UINT64(env.hedeleg, RISCVCPU),
         VMSTATE_UINT64(env.hideleg, RISCVCPU),
         VMSTATE_UINT32(env.hcounteren, RISCVCPU),
-        VMSTATE_UINTTL(env.htval, RISCVCPU),
-        VMSTATE_UINTTL(env.htinst, RISCVCPU),
-        VMSTATE_UINTTL(env.hgatp, RISCVCPU),
+        VMSTATE_UINT64(env.htval, RISCVCPU),
+        VMSTATE_UINT64(env.htinst, RISCVCPU),
+        VMSTATE_UINT64(env.hgatp, RISCVCPU),
         VMSTATE_UINTTL(env.hgeie, RISCVCPU),
         VMSTATE_UINTTL(env.hgeip, RISCVCPU),
         VMSTATE_UINT64(env.hvien, RISCVCPU),
@@ -98,28 +98,28 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.htimedelta, RISCVCPU),
         VMSTATE_UINT64(env.vstimecmp, RISCVCPU),
 
-        VMSTATE_UINTTL(env.hvictl, RISCVCPU),
+        VMSTATE_UINT32(env.hvictl, RISCVCPU),
         VMSTATE_UINT8_ARRAY(env.hviprio, RISCVCPU, 64),
 
         VMSTATE_UINT64(env.vsstatus, RISCVCPU),
-        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
-        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
-        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
-        VMSTATE_UINTTL(env.vscause, RISCVCPU),
-        VMSTATE_UINTTL(env.vstval, RISCVCPU),
-        VMSTATE_UINTTL(env.vsatp, RISCVCPU),
+        VMSTATE_UINT64(env.vstvec, RISCVCPU),
+        VMSTATE_UINT64(env.vsscratch, RISCVCPU),
+        VMSTATE_UINT64(env.vsepc, RISCVCPU),
+        VMSTATE_UINT64(env.vscause, RISCVCPU),
+        VMSTATE_UINT64(env.vstval, RISCVCPU),
+        VMSTATE_UINT64(env.vsatp, RISCVCPU),
         VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
         VMSTATE_UINT64(env.vsie, RISCVCPU),
 
-        VMSTATE_UINTTL(env.mtval2, RISCVCPU),
-        VMSTATE_UINTTL(env.mtinst, RISCVCPU),
+        VMSTATE_UINT64(env.mtval2, RISCVCPU),
+        VMSTATE_UINT64(env.mtinst, RISCVCPU),
 
-        VMSTATE_UINTTL(env.stvec_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.sscratch_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.sepc_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.scause_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.stval_hs, RISCVCPU),
-        VMSTATE_UINTTL(env.satp_hs, RISCVCPU),
+        VMSTATE_UINT64(env.stvec_hs, RISCVCPU),
+        VMSTATE_UINT64(env.sscratch_hs, RISCVCPU),
+        VMSTATE_UINT64(env.sepc_hs, RISCVCPU),
+        VMSTATE_UINT64(env.scause_hs, RISCVCPU),
+        VMSTATE_UINT64(env.stval_hs, RISCVCPU),
+        VMSTATE_UINT64(env.satp_hs, RISCVCPU),
         VMSTATE_UINT64(env.mstatus_hs, RISCVCPU),
 
         VMSTATE_END_OF_LIST()
@@ -291,12 +291,12 @@ static bool envcfg_needed(void *opaque)
 
 static const VMStateDescription vmstate_envcfg = {
     .name = "cpu/envcfg",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = envcfg_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.menvcfg, RISCVCPU),
-        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
+        VMSTATE_UINT64(env.senvcfg, RISCVCPU),
         VMSTATE_UINT64(env.henvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -356,11 +356,11 @@ static bool jvt_needed(void *opaque)
 
 static const VMStateDescription vmstate_jvt = {
     .name = "cpu/jvt",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = jvt_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.jvt, RISCVCPU),
+        VMSTATE_UINT64(env.jvt, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -427,8 +427,8 @@ static const VMStateDescription vmstate_sstc = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 10,
-    .minimum_version_id = 10,
+    .version_id = 11,
+    .minimum_version_id = 11,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -459,16 +459,16 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.mvip, RISCVCPU),
         VMSTATE_UINT64(env.sie, RISCVCPU),
         VMSTATE_UINT64(env.mideleg, RISCVCPU),
-        VMSTATE_UINTTL(env.satp, RISCVCPU),
-        VMSTATE_UINTTL(env.stval, RISCVCPU),
-        VMSTATE_UINTTL(env.medeleg, RISCVCPU),
-        VMSTATE_UINTTL(env.stvec, RISCVCPU),
-        VMSTATE_UINTTL(env.sepc, RISCVCPU),
-        VMSTATE_UINTTL(env.scause, RISCVCPU),
-        VMSTATE_UINTTL(env.mtvec, RISCVCPU),
-        VMSTATE_UINTTL(env.mepc, RISCVCPU),
-        VMSTATE_UINTTL(env.mcause, RISCVCPU),
-        VMSTATE_UINTTL(env.mtval, RISCVCPU),
+        VMSTATE_UINT64(env.satp, RISCVCPU),
+        VMSTATE_UINT64(env.stval, RISCVCPU),
+        VMSTATE_UINT64(env.medeleg, RISCVCPU),
+        VMSTATE_UINT64(env.stvec, RISCVCPU),
+        VMSTATE_UINT64(env.sepc, RISCVCPU),
+        VMSTATE_UINT64(env.scause, RISCVCPU),
+        VMSTATE_UINT64(env.mtvec, RISCVCPU),
+        VMSTATE_UINT64(env.mepc, RISCVCPU),
+        VMSTATE_UINT64(env.mcause, RISCVCPU),
+        VMSTATE_UINT64(env.mtval, RISCVCPU),
         VMSTATE_UINTTL(env.miselect, RISCVCPU),
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
@@ -479,8 +479,8 @@ const VMStateDescription vmstate_riscv_cpu = {
                              vmstate_pmu_ctr_state, PMUCTRState),
         VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
         VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHPMEVENTS),
-        VMSTATE_UINTTL(env.sscratch, RISCVCPU),
-        VMSTATE_UINTTL(env.mscratch, RISCVCPU),
+        VMSTATE_UINT64(env.sscratch, RISCVCPU),
+        VMSTATE_UINT64(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.stimecmp, RISCVCPU),
 
         VMSTATE_END_OF_LIST()
-- 
2.52.0


