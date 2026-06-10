Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4954CCD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPxd-0004kO-Lq; Wed, 10 Jun 2026 16:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXPxV-0004i0-3i
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:55:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXPxS-00050s-GL
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:55:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJZTBq2559582
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 20:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KSamla7htbV
 j8o8hvsLFM4aVByvfQghDKcYFXmmfbA4=; b=h6ewhWlqIclKAD9bRMTUF2EWPQ3
 1gyzH2bzzWxtLBe6w9M/zsCWwtYuNlBfe3+gH0uJ6Vr8OQMnMWc6iu7+fzdgqFSY
 cHiUnayC0mO6dhr+jdsJXwNt2HR4RL6yaheyw8GY3VfbUdqZrqRj7VdlWH9zrK85
 bjqT7Ew4QK9zTabAHS8q/gQg03HfFYafFNeBYsKT4EVAyH5gYnyT4hPzxSRGb2Ap
 UWV6QkrK8eh3V+NosaQ4/eiSUcSh2ikoVi9fhVxvkWLHQ+1vvlw55Jl0w+f6I3TQ
 EQx9SVlZnoba3G4i99ozCooRLPehJS9EJ1ZTodZml+sZtqkJAMO3eIlunNg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71gd98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 20:55:29 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963a02dca36so6932842241.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781124928; x=1781729728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSamla7htbVj8o8hvsLFM4aVByvfQghDKcYFXmmfbA4=;
 b=fl0YiqaaH1HrlbjtVPtUEFVy1iJ/xy57E2usBHVplUjk8LiWG23KhzDmhbc+J4pWUu
 rrGIrDibGTrC4IzLCitpTV5fVxrSuub09phXFWrCi1+LuWtBVvGErUDDr1jJiqsC2Wcf
 lN87hR08phlUHcEhYqQNxJsZgUPm1hcZzZ+z8/GBaRXMQ6qEm6jGBvtYfIMxGj7M2GkN
 VbQaLYNkF4jU/GqH+xDlleU3Rg7grHXI3QjHtxhEeiGFAggVAzfjVfpeHEf1nBShQU0n
 ql//e6h1b2kn3kZS6Apbm0O2ZMalZ8P8Qz6Wd6K/Wc2HhmKbAvTrUZPOsFNULlcMOSkd
 iycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124928; x=1781729728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KSamla7htbVj8o8hvsLFM4aVByvfQghDKcYFXmmfbA4=;
 b=k/LGewXhRxv6MM8Eb0XJyhvJPfRXz9hObe1gxDYurgImFLL285vqW9pn47uhtkzfsx
 atZwW6FrDkt0M1RwEW1nbQP81F5Wp9JkPOOVxdWoQSnfDkVgS+dk5yTGxb84qamxQijC
 /GUme6LDAHKJlv7zGi83AfoOfC1C3j9pcuRlUR2s7jEzb5YF2Wflz5av9bb6U+HvPGbD
 jUpTE9WxsUa6Ifsht5+bnbUuJMDX2UtkUbaChLr8tyo14cFBwoEdD4zZ+kz8unUyqOG0
 sWkes/VcEnvSX/1kbXyoqfBETqInUASb4oL6uPxR3w5fFZfTaL6yrgGmxgmI3mCOZZ4j
 ouIg==
X-Gm-Message-State: AOJu0YxC0dTyAfLxSiOdswsSkMfwJQLos2yegyThiC8HfoLggtDLXHSw
 zN7TFEtuCvWq6I+prhLupEM3NUpQjplqS5YdFcBljIJKSH0MJskDV9kpugCHGhQp+ZYhKQhun4C
 5YXM58dR1i/FBoz7h1fTpVViAuQfyxC22OoDWkZYTgGqCyyAKlIx7fNijUqm1R2oH0Q==
X-Gm-Gg: Acq92OFpo6Uid1I3yoI5v6LnNAifn4s/V76JYd2RC03AI8eN0E0mLgUAKWmQM1kAsH+
 2+0qQ+esGizuqkGAX59Gv37Q/TgeFj3MabtYhdTc6aBABDSNXuG9YxKF+BQIefxb0tsVH68QpeF
 Xfr9nnpCAC5ucRaX8ieTBmNMI2qloevOGC2QW88+kFuRO2Gfolcp6JsGXU+oluHi6By82Yanvsn
 xZECeqSHPtrbkTBig52C+tMZlAmn9JURUxz+FvmAYsdRS0UJ2nl6WBukgFV728+oy/hAR8n18Sg
 STxvnWTFIYEy3HHxxw7oLwv27NhlWdPIQw9jxBEojQYF6LsQtOX6A3mU0SO/MPKe176qAE3uspR
 a8gG6ic9Gf+/fvxgc2tbKIZklvYqKNNHJaeqtgbSvlYdFynU58w2obR+WilXjZba+jZSORA==
X-Received: by 2002:a05:6122:2187:b0:5a2:9154:2792 with SMTP id
 71dfb90a1353d-5ba43d0d85emr568480e0c.7.1781124928344; 
 Wed, 10 Jun 2026 13:55:28 -0700 (PDT)
X-Received: by 2002:a05:6122:2187:b0:5a2:9154:2792 with SMTP id
 71dfb90a1353d-5ba43d0d85emr568029e0c.7.1781124919662; 
 Wed, 10 Jun 2026 13:55:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96413f91f2esm19548084241.4.2026.06.10.13.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:55:19 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/2] target/riscv: dynamic alloc of debug trigger arrays
Date: Wed, 10 Jun 2026 17:54:56 -0300
Message-ID: <20260610205457.1868701-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610205457.1868701-1-daniel.barboza@oss.qualcomm.com>
References: <20260610205457.1868701-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tWEl1Di210QD5_ocFOVfgIdPq-9iCDqm
X-Proofpoint-GUID: tWEl1Di210QD5_ocFOVfgIdPq-9iCDqm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwMCBTYWx0ZWRfX7fFDY4/Fdv75
 lIr3NTxE2BxykvVpYs/WsPBrerzpULAro7yP3mBqco7Zg7E2xOgxsTUCaw7TbuuSC0ZInKTEjbW
 NG/pxGIoHL4NrIM+dldAuUwMrTZKABbQVGRDN42QvoiR5ASKxT82NBnARtuXqbHef+U4gKO5rQO
 gbuZcMmi+C13x9vSroysTgzEUnoiNvCPTH6/y7TThdeN+B5VfJKbpV1arfKjvBe8suF7h+/50ui
 vAZS3Wq/EQDBEmlW0pdYuArdapEPM3tIfpHRy0flyhd08J5+iSqPrAoDXjHzXMo7jpqqall47xn
 8LaeEOXFGkJR/5kfbwXCAv0IFyhWd8cSVwxTbK7qEyLl85zKBG9hvL88cbnLa7+n8zJAUnj9V6x
 Yv0ygMiVStRqNt3pJI52YuDPcAdK5HBUXopoGEH117RVtR3Ky5w+x0W+1wiv+5LVsEvyWN1oOF1
 JoWDHncXZ4J03SOXpSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwMCBTYWx0ZWRfX/ZPRB3Qw7QRk
 kcYWv16NQPhyoOqBJpjBLzShzsEm2I44V9sn0uFxIc0LKq9Yk/b5MxhexNh7YQZqYxnAqAt80/I
 uIwNKtPEB4YvRbOwLG08LOAKc7qJABg=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a29cf41 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dNIk65s4wyamRQlK2jsA:9 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The debug trigger facility consists of a set of arrays: tdata1-3,
cpu_breakpoint, cpu_watchpoint and itrigger_timer.  All of them are
static allocated with RV_MAX_TRIGGERS (2).  This means that all RISC-V
cpus will have 2 triggers per hart.

The RISC-V Server Ref demands at least 11 triggers per hart, and several
CPUs in the wild works with 4+ triggers.  We need more flexibility, ergo
we need to parametrize the amount of triggers and make it configurable.

Before doing that we need to handle a situation faced in a previous
attempt [1].  We were unable to set the tdataN array length in
vmstate_debug, meaning that we would always migrate RV_MAX_TRIGGERS
regardless of the actual amount of triggers in play. To fix that we need
to change the tdata arrays from static to dynamic, allowing us to use
VMSTATE_VARRAY_UINT32().  This also means that, in contrast with [1], we
have the opportunity to turn all trigger arrays into dynamic allocation
and reduce the amount of stuff being carried by CPURISCVState, or in
other words, we can carry just what we're using instead of a static max
value.

All the forementioned trigger facility arrays are now dynamic.  They are
allocated during realize time in riscv_trigger_realize(), and their size
is expressed by env->num_triggers.  All relevant code is changed to use
env->num_triggers instead of the RV_MAX_TRIGGERS to loop through each
array.

This will make it easier for the next patch to parametrize
env->num_triggers.

[1] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d45@oss.qualcomm.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.h     | 18 ++++++++++++------
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 31 +++++++++++++++++++++++--------
 target/riscv/machine.c | 12 +++++++++---
 4 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c98652cd62..8345b9a207 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -467,12 +467,18 @@ struct CPUArchState {
     /* trigger module */
     uint16_t mcontext;
     uint8_t trigger_cur;
-    uint64_t tdata1[RV_MAX_TRIGGERS];
-    uint64_t tdata2[RV_MAX_TRIGGERS];
-    uint64_t tdata3[RV_MAX_TRIGGERS];
-    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
-    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
-    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
+    /*
+     * num_triggers is the length of tdata1, tdata2, tdata3,
+     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
+     * arrays.
+     */
+    uint32_t num_triggers;
+    uint64_t *tdata1;
+    uint64_t *tdata2;
+    uint64_t *tdata3;
+    struct CPUBreakpoint **cpu_breakpoint;
+    struct CPUWatchpoint **cpu_watchpoint;
+    QEMUTimer **itrigger_timer;
     int64_t last_icount;
     bool itrigger_enabled;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ec931a8c3d..82afad82db 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5436,7 +5436,7 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     /* return 0 in tdata1 to end the trigger enumeration */
-    if (env->trigger_cur >= RV_MAX_TRIGGERS && csrno == CSR_TDATA1) {
+    if (env->trigger_cur >= env->num_triggers && csrno == CSR_TDATA1) {
         *val = 0;
         return RISCV_EXCP_NONE;
     }
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 30d39ee5cd..8b31efdbc6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -172,7 +172,7 @@ target_ulong tselect_csr_read(CPURISCVState *env)
 
 void tselect_csr_write(CPURISCVState *env, target_ulong val)
 {
-    if (val < RV_MAX_TRIGGERS) {
+    if (val < env->num_triggers) {
         env->trigger_cur = val;
     }
 }
@@ -701,7 +701,7 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -721,7 +721,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
 void helper_itrigger_match(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -750,7 +750,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
     int64_t last_icount = env->last_icount, current_icount;
     current_icount = env->last_icount = icount_get_raw();
 
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -950,7 +950,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
     int i;
 
     QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        for (i = 0; i < env->num_triggers; i++) {
             trigger_type = get_trigger_type(env, i);
 
             if (!trigger_common_match(env, trigger_type, i)) {
@@ -996,7 +996,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     int flags;
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < env->num_triggers; i++) {
         trigger_type = get_trigger_type(env, i);
 
         if (!trigger_common_match(env, trigger_type, i)) {
@@ -1049,7 +1049,22 @@ void riscv_trigger_realize(CPURISCVState *env)
 {
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    /*
+     * Alloc env->tdata1/2/3, cpu_breakpoint, cpu_watchpoint and
+     * itrigger_timer dynamically.  This is overkill now
+     * given that they could be static arrays with RV_MAX_TRIGGERS
+     * but we'll parametrize the trigger number later, i.e. the
+     * array length won't be static.
+     */
+    env->num_triggers = RV_MAX_TRIGGERS;
+    env->tdata1 = g_new0(uint64_t, env->num_triggers);
+    env->tdata2 = g_new0(uint64_t, env->num_triggers);
+    env->tdata3 = g_new0(uint64_t, env->num_triggers);
+    env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
+    env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
+    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
+
+    for (i = 0; i < env->num_triggers; i++) {
         env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                               riscv_itrigger_timer_cb, env);
     }
@@ -1061,7 +1076,7 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     int i;
 
     /* init to type 2 triggers */
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < env->num_triggers; i++) {
         /*
          * type = TRIGGER_TYPE_AD_MATCH
          * dmode = 0 (both debug and M-mode can write tdata)
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6e70b145a5..b6b53a4840 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -247,9 +247,15 @@ static const VMStateDescription vmstate_debug = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(env.mcontext, RISCVCPU),
         VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_VARRAY_UINT32(env.tdata1, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_UINT32(env.tdata2, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.43.0


