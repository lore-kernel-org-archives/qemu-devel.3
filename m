Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB7BCD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9j-0007w2-Mh; Tue, 23 Jun 2026 20:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9S-0007Xz-F5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9Q-0003Ja-IF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwr57613932
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TCwdhiMRj9ZQNqm4F7nb8HIrgeLaw/oBfD3H8vDFPjs=; b=cSZDs6u0FEWIDfJj
 oPPY8ON8O+wpfeNzMkL9JiP7Ya5mX+LozOJJTJ2hK2FTUV7FPz4o87rrzQRBv2ZU
 TI2jaehElzD6bLZQ1zx/4GYRmVUt+sRJ93wTiarGc5yX6Jqbqs7WQT1V+Vjw5/9/
 LUomJzfEjxEUgTQqee9vxRt9D3ZDypXnBkzBGOLSMu7XGP6/yDEjvjkBykymPDb1
 IaxhLEHCDJWEYphQ+DpdodQ16dvYOuutWpSXe1eJcJw9CZubvGRrA7tcfXGKc+Gc
 rWAfsIkaCSaYk3mmwamHmCZhlKK3d8uukjJpOwSP4hhiGDtFoa3cfAyb8TJhXhbg
 WUf1AA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppykjfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dc0a6ab3bbso14301736d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259649; x=1782864449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCwdhiMRj9ZQNqm4F7nb8HIrgeLaw/oBfD3H8vDFPjs=;
 b=hScTkjTYbahNPrVJmD+slQ33ddcbZGRZmQ8MOS4bErnvy8jLjfrRGyFNBQLAIIuXQO
 s01JMIvBzCGWuDJnNJWDEKfTlJN9+HXLjJbLviX4BManm8c/qJTkbf8zs/hkaXP4MDSm
 mR891QKNJKQ6U0mPrPnafF65NBuEgIWFwu/wqniorPjGySmGVM+fbGnoSus2bdCS4+m4
 ZnnsfuSk+FqJfayIRy4PBNlXFK/RntB9OEX/MkN99PDejkhYCe3AVPK+rh3knm+CPtd4
 lzJQcFw6nmVPpah5vntsBnYU6zMH1M/yJQpx0u+Ix7cIfDjsDCENY9KTtj5tBFFJx2lU
 v8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259649; x=1782864449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TCwdhiMRj9ZQNqm4F7nb8HIrgeLaw/oBfD3H8vDFPjs=;
 b=OrrR9AbxHi3OkYMtjMx+fyy5U7PpJzt1W9hmU1WhaX/TTYNZ0somPg6uoIojElsgXQ
 R8LxpZqomCAkSY5l7r5zUtArkCc29zl63EPUbCDMGFcMhdRp1tuwrbCtakICQNmI+yWy
 pSJYgu3Paywrugf6PxLhF3qgzMKzHyBiz/Qaqo0xLYl3ORivEmMuJGoyIeJvyMk/X5nl
 J6kPzFcSgCxcS/SAtAgzquE+qM7l21LpieJRRp7DHQ4GQy4+Lu+KTIU76FYxW5sVQwxx
 XDVrJ4fLSrRqKuf6AtuVsg2TsDWICUq72luifLHKEaHDkgvkkY7fXnyFGgsewaujM67b
 Ak5w==
X-Gm-Message-State: AOJu0Yw4GMb7VlEij5xlBeZ1WDP1RzZsZd9dRLVmXzjjAELZNaHvnS5a
 79raofPWyh3WDZLCADGTWldwbSw5BiX/4Tr3CS3jxugXraPw0H0KB+l6ck1PXKfszzDCVvu/wpi
 0h9tQQy5xKWrgQ/os7FFXzgRg8nM4GMz+94Kg0hGEgYxv+1avqLsmqGPAtI+fhssiiw==
X-Gm-Gg: AfdE7clog2zn6s0wnA9N9j1nG/e7DEq+RsZk8BYrt+9JuiS2+0e6vUPpIP1BP5v+FWp
 og7FZEyKs8Tpgd07lRz5dKkfU0WFR5mn/KzexztRjbPj88h+/soPD5Y0Npo2cjbsx2hMGgA2lf3
 xySwUp1NdAkPiI14WBxtdUrH6h0JXHRQuUM9f49EIpLk5CzEEXaXRSPnEfrU9i4Ob0G0/r0JRGu
 VWvTMQyNbtBk6Wgj7GPfT5GHz3n69SNEuTYMKsDFBjdBTYCkGefH4RdwhLEXmXJ2yyFwOvVxO/1
 uFTSDfvi4Ah19jQpphNzDqgIz8uDUJfwjfgRGduJxD4flSbwWVvGYWxZx56MEjEZnslYhFy6pKY
 HjB/IqPF3PfI9A0EXbQOVocEmQQjBHX3SCJJCID4A49jvnw==
X-Received: by 2002:a05:6214:3286:b0:8df:9ea9:72e6 with SMTP id
 6a1803df08f44-8e52d7d6229mr25857656d6.5.1782259648991; 
 Tue, 23 Jun 2026 17:07:28 -0700 (PDT)
X-Received: by 2002:a05:6214:3286:b0:8df:9ea9:72e6 with SMTP id
 6a1803df08f44-8e52d7d6229mr25856966d6.5.1782259648384; 
 Tue, 23 Jun 2026 17:07:28 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:27 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
Date: Tue, 23 Jun 2026 21:06:23 -0300
Message-ID: <20260624000632.2149359-17-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXyEObXIsrBO2f
 pT2CUWrKexu4OHFbZbhOFIi4oU/XdKwY+sD646dntpSYJbf7RxWNcbytEZVDQDz0vKGvIWoWfRH
 fTbKwKMbhk7mWAUAOKK4EzottYSP4j58w6FNk4AQmm/QmCdESsguw7Urn3LyBHGrNLIy/+X2VGs
 4xii9pm3rMgibISXVRjJE00v7+2tnBWIvpFThE0nXjVjs9J7sPebSv+QIXp9aK8zso4wJsSpmNB
 gH4juC+j6JlGPKJSkFygm9pZ48r4OneurTiAxpUt4vlcpJh0ZRcKXL4E+ZBsAJhXFDLMNKOwd9a
 ph3lKL/gPLDFAWtbMJa2k4s/GQVuioBWorzUeQTxwELamMq1lXFX017DdiGlqRTIkCLK55U3iO6
 w67DVem9KhTxbWJlR5JF+ps/NTH2LQ==
X-Proofpoint-GUID: ncMSgYGFtvL3JX4ggFn1_KqjA3dZHWck
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3b1fc2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pBdMQyqLZ6fKue3OrpUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX7sCFDENwgpnZ
 Q5QGtparerlla/KAkXhhKtFlNBRrj39owKeoy30Ls0XQD3AcAqlURmDeB9EOAWH+vNYRPoywBFg
 xmuP22iRISXDbViy9bssPFhq35qhiMU=
X-Proofpoint-ORIG-GUID: ncMSgYGFtvL3JX4ggFn1_KqjA3dZHWck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
kvm_enabled() check, making it unavailable for TCG only builds.  We need
to do the same for riscv_cpu_update_mip() otherwise a KVM only build
will fail because it doesn't know what this function is.

Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
unguarded in cpu.c.

We have way more calls to deal with in time_helper.c which isn't using
kvm_riscv_set_irq() at all, so create a riscv_accel_set_irq() local
helper that will choose whether to use the KVM or TCG API.

The reason we're going through all this hassle in time_helper.c is
because hw/int/riscv_aclint.c uses it, and if we don't do something
about we won't have riscv_aclint working for KVM.  Whether this is a
real problem or not and we should remove aclint support for KVM is
question for another day.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 19 ++++++++++++++-----
 target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7bd5bc0fc1..8f9d2967ef 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1336,14 +1336,18 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         case IRQ_M_EXT:
             if (kvm_enabled()) {
                 kvm_riscv_set_irq(cpu, irq, level);
-            } else {
+            }
+
+            if (tcg_enabled()) {
                 riscv_cpu_update_mip(env, 1 << irq, BOOL_TO_MASK(level));
             }
              break;
         case IRQ_S_EXT:
             if (kvm_enabled()) {
                 kvm_riscv_set_irq(cpu, irq, level);
-            } else {
+            }
+
+            if (tcg_enabled()) {
                 env->external_seip = level;
                 riscv_cpu_update_mip(env, 1 << irq,
                                      BOOL_TO_MASK(level | env->software_seip));
@@ -1370,9 +1374,14 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
             env->hgeip |= 1ULL << irq;
         }
 
-        /* Update mip.SGEIP bit */
-        riscv_cpu_update_mip(env, MIP_SGEIP,
-                             BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
+        if (kvm_enabled()) {
+            kvm_riscv_set_irq(cpu, irq, level);
+        }
+        if (tcg_enabled()) {
+            /* Update mip.SGEIP bit */
+            riscv_cpu_update_mip(env, MIP_SGEIP,
+                                 BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
+        }
     } else {
         g_assert_not_reached();
     }
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 400e917354..ede1a4c2a3 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -21,19 +21,34 @@
 #include "cpu_bits.h"
 #include "time_helper.h"
 #include "hw/intc/riscv_aclint.h"
+#include "kvm/kvm_riscv.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
+
+static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
+{
+    if (kvm_enabled()) {
+        kvm_riscv_set_irq(cpu, irq, level);
+    }
+
+    if (tcg_enabled()) {
+        riscv_cpu_update_mip(&cpu->env, irq, level);
+    }
+}
+
 
 static void riscv_vstimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
     env->vstime_irq = 1;
-    riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
+    riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
 }
 
 static void riscv_stimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
-    riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
+    riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
 }
 
 /*
@@ -48,6 +63,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
     RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
     uint32_t timebase_freq;
     uint64_t rtc_r;
+    RISCVCPU *cpu;
 
     if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
         !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
@@ -63,6 +79,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
 
     timebase_freq = mtimer->timebase_freq;
     rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
+    cpu = env_archcpu(env);
 
     if (timecmp <= rtc_r) {
         /*
@@ -71,9 +88,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
          */
         if (timer_irq == MIP_VSTIP) {
             env->vstime_irq = 1;
-            riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
+            riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
         } else {
-            riscv_cpu_update_mip(env, MIP_STIP, BOOL_TO_MASK(1));
+            riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
         }
         return;
     }
@@ -81,9 +98,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
     /* Clear the [VS|S]TIP bit in mip */
     if (timer_irq == MIP_VSTIP) {
         env->vstime_irq = 0;
-        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(0));
     } else {
-        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(cpu, timer_irq, BOOL_TO_MASK(0));
     }
 
     /*
@@ -151,7 +168,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
 {
     /* Disable S-mode Timer IRQ and HW-based STIP */
     if ((timer_irq == MIP_STIP) && !get_field(env->menvcfg, MENVCFG_STCE)) {
-        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(env_archcpu(env), timer_irq, BOOL_TO_MASK(0));
         timer_del(timer);
         return;
     }
@@ -161,7 +178,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
         (!get_field(env->menvcfg, MENVCFG_STCE) ||
          !get_field(env->henvcfg, HENVCFG_STCE))) {
         env->vstime_irq = 0;
-        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(env_archcpu(env), 0, BOOL_TO_MASK(0));
         timer_del(timer);
         return;
     }
-- 
2.43.0


