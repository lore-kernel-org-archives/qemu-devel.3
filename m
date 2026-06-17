Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87997CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZq93-0006Gx-PF; Wed, 17 Jun 2026 09:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZq91-0006GO-8j
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:17:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZq8x-0002zL-75
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:17:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8W0WL2056645
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LaLnccJXwxVmIPAFAKsOEWNSj4MsI0S6SZFZlfFSfNI=; b=gSHeZCoUeQkd1sZV
 H48BxGqZBmIUg47XBAE9Q2YFNALZ8MXTLgZ5Ny2m72tY8jSHG2012bZzbva8estl
 oXaVwNcQeMRCK3DL+UH0q23BrVjt+avdgy5wgekZlBQc4nXETRjBPt1yVcWmOpyd
 W9F+CPoyK7iV5z4B1eEIhAR4cQzIFih1+fETluKL5nYnUPHEPxdfQd2VKNIVIgKS
 a8b7RYA9A86thrxVRhJGJ3RmHFL0JzYSXzb77Vp+RhSQKfdP/zZ0FtuGXJuy0KfD
 fYZLhiQ+Hr4a8/pC7j0zfVHWu/r29nrc5rddSdvnHS+xny7+SHbMiLzsYq9M0Wbs
 t1WnYQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesb9us-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:17:22 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7fefbbeed32so6301367b3.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781702241; x=1782307041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LaLnccJXwxVmIPAFAKsOEWNSj4MsI0S6SZFZlfFSfNI=;
 b=D7XIsCQF3NTQv/K6BAIBRGGWYMexu55q79ToLQkeBxtHHXjoa0vuof8MiTmc3esNWk
 wrY0azSq/cF3mx11wyC7dBo2DHlh9OldCry0hMFLoTcl05q0fzOtVKlYaciSoeGYPggA
 wsJgBV4dNtyqpfiv7PkRNXP88RpWPU/+SrPFMlRCs40JqCjeKXiCXfBsiQc/mG/X8BrV
 j0vBlsQmvBgzMuIvQf0wJ9jXyrS2tA8++TpW0Ogg74vFv20175U7sam/CXh+PTpSprNw
 /8Q3bIZQ1XJigS8Qxg21gJMq39z6jkztTRR0xb2uK/h8aA6lJxw1H2L2JczrUOV5rTMV
 jFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781702241; x=1782307041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LaLnccJXwxVmIPAFAKsOEWNSj4MsI0S6SZFZlfFSfNI=;
 b=G4tPZhsFbn3qNPuIrKxEBfQwoP9+PNRLlixxOHimH3jj/Sn/md9/GDl5m9OCdzTowt
 jqdkSWksTbnHyJ2vRbr5jpCuox/LHHRZqJgyyMybajcK/mc75gyk3uWM3JuMsohSGY18
 8Y0k7JZgzWxV/jAjGXiNisrH7ZxIOILGgGpMAsaNLtbBmMyRswkENL/4PUpHC2U7iu0s
 YzyOxuu2gNIGYvSSQ/pq0CqnmNBPnn5XtS6EtCld9kCUkW/P2zVSOxvPKVsFYIC9pkHq
 DyG249w7Jg4pyEkA/8HXLAnLX5zl3RWUM8RWj1GfDo50c6ZC0HVcomfspa4fVd3mi41f
 aUGQ==
X-Gm-Message-State: AOJu0YxWWq4n6U42wRBdG/iDmeimxP2I2fQLNeubyesY8CyzSItUAy+T
 FFDK71BJXB2Bvo4IWSxvdQGCjiYcxHVviiWcHwTZCq476sPLrswGAQcJ+BjCUNiYTXbB+EFTjbZ
 bl4oc6fLX24oouOPyOZ9sOmuD9BH8+yhb3qav+BRMMT7qPLVp9C8tKf8Qzh0rvDMzNA==
X-Gm-Gg: AfdE7cnCrzLcy40fjhf2XJNhMBQjwKJnFdSzN/jqe1Y8IsC4pihSnJsIMGr074UJ0jf
 /dAUavzgIN1Mpw6XoIWlBu+zIZfAzGFkCE/Ez/0iHfQ1Pt7O+Yb01R/77YhWLBUr3HrxGOPzGW1
 hu60i5CEa9peIvEFQ5rSJP7ueOWEWZe1iLKXFjaeavgLN4I2NVzF5AXwT3gsBGxFvo9INsljLsC
 Q5F+gVTeo9NpJwWc4pADXynnsANdYwgmyaYGupqbb9yblXobHZud31t0GTIl3CDVSbFoIOnOvkl
 ze1/LX69YTpSn/sG2Vz3v5xqw8YHh51G4rYV3hAhFjg3AYQXKPPuEwGOO2T0fUmJqcCUHOxOvqp
 JVfiDlBI8QVxazhLq4tdos7tV1KA8hPR0DskhNyM7HdkHB4Vt
X-Received: by 2002:a05:690c:6209:b0:7dc:7b3:6326 with SMTP id
 00721157ae682-7fe5d5a452cmr32865997b3.33.1781702241254; 
 Wed, 17 Jun 2026 06:17:21 -0700 (PDT)
X-Received: by 2002:a05:690c:6209:b0:7dc:7b3:6326 with SMTP id
 00721157ae682-7fe5d5a452cmr32865127b3.33.1781702240504; 
 Wed, 17 Jun 2026 06:17:20 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd345a5fesm44861707b3.36.2026.06.17.06.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 06:17:20 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 2/3] target/riscv: dynamic alloc of debug trigger arrays
Date: Wed, 17 Jun 2026 10:17:09 -0300
Message-ID: <20260617131710.1855353-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
References: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEyNiBTYWx0ZWRfX+uJARrvlRFCp
 KZAzB97F3KUlOnayZRHAcC6lMKSo7o6EA9sfNt16OUWjOJ55pGiYR7pW4HJs7zQNbRBRU3JVviH
 L3YghJRKtbZ8ZvfktzBW3KiC6r6OwAA=
X-Proofpoint-ORIG-GUID: lX-7qXUthUXZyZpMgd4Zs7HG_o_ecdtK
X-Authority-Analysis: v=2.4 cv=R6oz39RX c=1 sm=1 tr=0 ts=6a329e62 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=3hYV-RIbpzt_YiHVFz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: lX-7qXUthUXZyZpMgd4Zs7HG_o_ecdtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEyNiBTYWx0ZWRfX0x3VFw19a3yW
 l+4LPqXuewTDya4v7bJwrLs5Gmof4aowgSCPJIz4Q9ZgSihGuOj+OLqvR9I2e5CF6GMqQCa6Beh
 clRKYYkHw94BFTsCC5pXWuHl5DYOQMZM6f51Jlae58xv+1ckSqgGdseV3QDH7UO7Gv7ahDktXBX
 Lm9zPMWrVW+9RAyPA8jbWg302PxNVI9iPveYvuOrTsLIKJBQmTsUj3G/HDRv8hQgMFdoC/pU9Tq
 4Jgve5d5Ld/AtjQUC2muiW+LNn6CIVPuF0t/nMbp8MK8nqh9t+i331DA/tvQ/EPODldRM1k7ISg
 3j/u7OE7FhtNjulXCfTT8bYylMmWgaYC3opQ4+wEItP24wA4puJ2P8zX7P/xIxtHgrEhQPYUHiU
 zzsdhXCm1eyBEZ8OatIOD38+gDFRtFx2ZpfULc2ccJHSqLECS2nRPm1mwgobYLMqeNFMUtvdWzr
 iiNhZMPYKfPhefuAGBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170126
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
allocated and freed during realize/unrealize, and their size is
expressed by env->num_triggers.  All relevant code is changed to use
env->num_triggers instead of the RV_MAX_TRIGGERS to loop through each
array.

This will make it easier for the next patch to parametrize
env->num_triggers.

[1] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d45@oss.qualcomm.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c     |  6 ++++++
 target/riscv/cpu.h     | 18 +++++++++++------
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
 target/riscv/debug.h   |  1 +
 target/riscv/machine.c | 16 ++++++++++-----
 6 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b47e2b41c8..e7318fe9f9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1012,7 +1012,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 static void riscv_cpu_unrealize(DeviceState *dev)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *cpu = RISCV_CPU(dev);
 
+    if (cpu->cfg.debug) {
+        riscv_trigger_unrealize(&cpu->env);
+    }
+#endif
     mcc->parent_unrealize(dev);
 }
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 16e9f87b83..af246a56ed 100644
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
index 30d39ee5cd..9a4910c431 100644
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
@@ -1049,19 +1049,49 @@ void riscv_trigger_realize(CPURISCVState *env)
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
 }
 
+void riscv_trigger_unrealize(CPURISCVState *env)
+{
+    g_free(env->tdata1);
+    g_free(env->tdata2);
+    g_free(env->tdata3);
+
+    g_free(env->cpu_breakpoint);
+    g_free(env->cpu_watchpoint);
+
+    for (int i = 0; i < env->num_triggers; i++) {
+        timer_del(env->itrigger_timer[i]);
+    }
+    g_free(env->itrigger_timer);
+}
+
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
     int i;
 
     /* init to type 2 triggers */
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < env->num_triggers; i++) {
         /*
          * type = TRIGGER_TYPE_AD_MATCH
          * dmode = 0 (both debug and M-mode can write tdata)
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 55a3ac72e6..a25d099b37 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -148,6 +148,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 void riscv_trigger_realize(CPURISCVState *env);
+void riscv_trigger_unrealize(CPURISCVState *env);
 void riscv_trigger_reset_hold(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6e70b145a5..ba96ceceef 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -240,16 +240,22 @@ static int debug_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_debug = {
     .name = "cpu/debug",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .needed = debug_needed,
     .post_load = debug_post_load,
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


