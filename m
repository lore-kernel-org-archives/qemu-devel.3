Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988F1CA9EC1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSc-0006Ym-CV; Fri, 09 Oct 2026 18:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSJ-0006Wh-5b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSH-0002dK-Jw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhXVO2545306
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Mr1crPBWe5m
 O0z7RVPkvDdMqMpkIgC7pGBfgQ4p9OLw=; b=GAagDve8ctlImiz96Nr6DbjTubr
 8M+7E3e8coza6AW1a60CfA9yrP9Vwpy0LuYubU6zlZvGSjweRCDqiHFlwKLRhrLS
 oCxckW1VYhm50hVV167L7sGYNly31RFH0ZWfr9WrwZNsNoGnU6eEkhLl4XpD58b2
 FX6MBpPxZa8SZZRh4NoW38SO6LRWGireOeRJ6CZx4YsdW1NIrj4ElsIknOWPeuyl
 zyuvQmAyR8OJaZB6LrypvFeFcqN1Sx/VcZ9tVsUwkX5M7bCtwZybkbLreSbPZZUo
 KLhpUldJmUL4WqaSrwkKkdYz0epYZGG8rDx0EedFMwjB1sxquR8m8oig51Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7ryx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so422199eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586364; x=1792191164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mr1crPBWe5mO0z7RVPkvDdMqMpkIgC7pGBfgQ4p9OLw=;
 b=flNZka/CayvziZzZs4new5SyQgb0ILiLJj492ded67fcZ81U+5MX+2uVGy2Rje7eIE
 LKhJNjSx7ff/l7SXDRliPFv4LoYJ6SBwWv5fuk2uXmPTQyaWfzlr62rIX+r9KiwEMp4z
 7w3zT61MTufnnwtGh2u54fH19v+KykwAQyfR7bQ8qZ+0HOGXcaU1r5lreO0dbR9fQMPT
 YWJNjU7NmumvoXd6yz+SElTRYOEnkMJC+iN+qtxXnlC7D/HlFKGV26b2VT0hOAQxRhhn
 Y3/Ln7shwYDNwSUYGYxp19UA1dhF9nFtHQx2KTmH0b37kOocZhWRUe9P+VE8ZKIh0bmc
 R15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586364; x=1792191164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mr1crPBWe5mO0z7RVPkvDdMqMpkIgC7pGBfgQ4p9OLw=;
 b=ih8TNIupr2gFDxHxwDnXdDwBFtxXClEhs8NsLIPVvh5OvcY+IqqNddAGowqUH7rzEr
 PAuzgabfmhT/J/Nkjx6Y5wc9qE32CVwDpNZuhODU75p0qZ6Ow7Ctr2LadpUlrXpRG5kD
 PTsDU4Q3GEQSn/lnTL1+OoVqDkKVKO1Bss54sshmMTQTo5OB0QOMtG9d0404K1HZdyob
 pIvZQj9DaAfysUxj6XSWRPan3J3EKU/3luGZQc9+IzOKFnTGf6qnX0y1dFOZ36i2ncYi
 C2/Ew4FJT3vEWx1Lz2+6Mt/pEC6tpIr82BzXVBDyAPtVmCrhisp/P4Spd1UvcaNTSsQ+
 hbZg==
X-Gm-Message-State: AFq9FYImhJuNNG+tRbyAdSnOYECOGMvLpPYtrRZup2mwjavWFj33W+vz
 G0FNwP53Dg0uxvqau5jlsBG3nVMTP3lqpQJ/EkuevPz6CimTH0pe0iyNa6slAt2OwgRBP5W4l9K
 jz2wsD2RL4hKetGfpc+HhsNLqW07A9rSASFwIrcHJ4PEKWCfqTPGGtn9TWWiSZoQCmw==
X-Gm-Gg: AYBFou3igzhFLOJ/0aWjj3HITrUa/aLHaTISuONQMm+8owUXwOIdSHJCETKFImvPdOE
 fqNDaGqu4eyvXUTMdUb/l+pusb5W3zOJbsqKrd+wlClc+g6LFstWSbmrl0NwN1cBP+wEKr5nMuY
 dOhv4J9noj8jefhLsoEPf8n35WHY8vh6oDgHDqkpalXjJsKQOwarCtRTXWqS1fDhfDXmVgp8vD2
 9y+Tl/1goyvN917rEHKCFfRxs8VORszIC/OBssj7p6VrIFoEHaE58wqhy1ac4pcLQ3aCFuEToas
 koiw0pN1NVFuVAsqmDdzq5tmqMWNvsPAdrO5fINpERCL0aXOhUOR4DkaTGA/tpb3p7TtOth0j35
 pVM0kFhQa/NgqjJIlg9RyfFAT7rj4iELIJ5HspjLTAOnUD16i/Wl3Ln1crN3n
X-Received: by 2002:a05:7022:e888:b0:168:6ad8:e89d with SMTP id
 a92af1059eb24-16a5dbfe727mr4594156c88.11.1791586363677; 
 Fri, 09 Oct 2026 15:52:43 -0700 (PDT)
X-Received: by 2002:a05:7022:e888:b0:168:6ad8:e89d with SMTP id
 a92af1059eb24-16a5dbfe727mr4594128c88.11.1791586363058; 
 Fri, 09 Oct 2026 15:52:43 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 08/11] target/arm: declare semihosting ops
Date: Fri,  9 Oct 2026 22:52:23 +0000
Message-ID: <20261009225226.10657-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX1p6BqITcSbTN
 UF1j//NA1CkUrEp8v8Px1UPDLfF6bozEEuNYvmulOkqtobWAv8R9BmKe4F9gr6oFLfR4TdPI4bK
 Mcnl+yvNJxr6i63O9wvrqi/27Zk63JUup8/kdW6HoWzgTC4NdCaYAXeYf6H3KnPZPgw0QABcoMT
 C3G/poOfl9/SAOmlMfSFzYA8Audiatj2f49lzh1RQ9/xMud+mhfT4NoXUsAMlnHmJ610HXejCQ8
 lVsF9uFsBJBCuCo4dlW/kQv/u3I2bO60+Vd4vGJBoM4zTOIfoO2EXFdO8Ii7ZqX6pTAYrPryb7P
 Anpo8gM5WqNDxj+jiNOf0I4y8Xo9FlDeWJ+mFlFH/RDthiUo+KgPR4VM+zH/g7SDPcU6SkL9qgn
 IoVN9IQLWLNFpd226B0k9LfSDpu9yhgWSrdxALRBCLGWOmCZH6UbKoH4xilf7o4/SOFu3W+2oj6
 VJMFF4WAVz/Yrvk/k7Q==
X-Proofpoint-ORIG-GUID: I_7giwlJTBMIiU7KX5vNWquzFgF8YXUX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfXyzey9wILEcjJ
 WekHTzL4/J1cGLuNQTg66We0gpbOLr8SXUgQZtKSTzXDFP/jj06YYDzb8X/6rTSaHTZznFS6obA
 rXk7yEx1I3yyCbcn0YzrEvo5mR2aU8w=
X-Authority-Analysis: v=2.4 cv=PaFqFShd c=1 sm=1 tr=0 ts=6ac9703c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=891gjW5_EiFNocZM0noA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: I_7giwlJTBMIiU7KX5vNWquzFgF8YXUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

For now, we keep the global common_* symbols defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/common-semi-target.c | 72 +++++++++++++++++++++++++++------
 target/arm/cpu.c                |  4 ++
 target/arm/internals.h          |  2 +
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
index 38d52deb3d6..5263c0435a8 100644
--- a/target/arm/common-semi-target.c
+++ b/target/arm/common-semi-target.c
@@ -10,9 +10,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "semihosting/common-semi.h"
+#include "internals.h"
 #include "target/arm/cpu-qom.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t arm_semi_arg(CPUState *cs, int argno)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -23,7 +24,7 @@ uint64_t common_semi_arg(CPUState *cs, int argno)
     }
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void arm_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -34,29 +35,74 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
     }
 }
 
+static void arm_semi_set_err(CPUState *cs, int err)
+{
+}
+
+static bool arm_semi_is_64bit(CPUState *cs)
+{
+    return is_a64(cpu_env(cs));
+}
+
+static bool arm_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return is_a64(cpu_env(cs));
+}
+
+static uint64_t arm_semi_stack_bottom(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    return is_a64(env) ? env->xregs[31] : env->regs[13];
+}
+
+static bool arm_semi_has_synccache(CPUState *cs)
+{
+    /* Ok for A64, invalid for A32/T32 */
+    return is_a64(cpu_env(cs));
+}
+
+const SemihostingCPUOps arm_semihosting_ops = {
+    .arg = arm_semi_arg,
+    .set_ret = arm_semi_set_ret,
+    .set_err = arm_semi_set_err,
+    .is_64bit = arm_semi_is_64bit,
+    .sys_exit_is_extended = arm_semi_sys_exit_is_extended,
+    .stack_bottom = arm_semi_stack_bottom,
+    .has_synccache = arm_semi_has_synccache,
+};
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return arm_semi_arg(cs, argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    arm_semi_set_ret(cs, ret);
+}
+
 void common_semi_set_err(CPUState *cs, int err)
 {
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return is_a64(cpu_env(cs));
+    arm_semi_set_err(cs, err);
 }
 
 bool is_64bit_semihosting(CPUArchState *env)
 {
-    return is_a64(env);
+    return arm_semi_is_64bit(env_cpu(env));
+}
+
+bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return arm_semi_sys_exit_is_extended(cs);
 }
 
 uint64_t common_semi_stack_bottom(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    return is_a64(env) ? env->xregs[31] : env->regs[13];
+    return arm_semi_stack_bottom(cs);
 }
 
 bool common_semi_has_synccache(CPUArchState *env)
 {
-    /* Ok for A64, invalid for A32/T32 */
-    return is_a64(env);
+    return arm_semi_has_synccache(env_cpu(env));
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10ac6c98318..81ec1ce21c6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2663,6 +2663,10 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
 
 #ifdef CONFIG_TCG
     cc->tcg_ops = &arm_tcg_ops;
+#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_LINUX)
+    /* semihosting is not supported for bsd-user */
+    cc->semi_ops = &arm_semihosting_ops;
+#endif
 #endif /* CONFIG_TCG */
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c41fa5225c7..e849e357cfe 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -437,6 +437,8 @@ bool arm_cpu_exec_halt(CPUState *cs);
 int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
+extern const struct SemihostingCPUOps arm_semihosting_ops;
+
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
     FPROUNDING_POSINF,
-- 
2.43.0


