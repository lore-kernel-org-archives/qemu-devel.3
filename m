Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52104CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSj-0006ZV-Jr; Fri, 09 Oct 2026 18:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSH-0006Vv-Dw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSD-0002cv-8K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:42 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhUtk3371057
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZC3Um/evFrM
 0IPjuDis8svXG4Qk4P0SUfU4iVB3HMmo=; b=dTmN2qcXs1tWYqEzpsx/kX0CQV3
 iGVFcjUv7TJ0/6YaauF1AMx/+iqsyd5Qz9lOj7hNCUdIdL9DIy/PXeXljFYfzy2f
 mhwbR1EIS9AKewdunvF4ERUYg2T8h3uQiz79QMvQeoWUUEwiCd4W5RLDTDTuqWKt
 venl87m5Lys54zHqEkfM9UebkRRvCXRTy6mjj73qe/akB7bEBqgsly8ycQjU4QTs
 T2HVk1Q+Kz8z/RHTAN9w0MPfX/aIz0tFeAVMFxmpgC/q3L8JmM11W3DZfP06gvFJ
 VtZHLE4gt0iktpUL2pneP8IoIgTz15hxlksTwxlpI5m90EwXZsZ0CGB2X5w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8h0cf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3425098ae4bso7482920eec.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586359; x=1792191159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZC3Um/evFrM0IPjuDis8svXG4Qk4P0SUfU4iVB3HMmo=;
 b=MKKLl4hevefprN51O4RWTgG/mS/0tlEObZDxPLGIjlCvJNcWBc5Z6LSP79xp8v9wWf
 GR0Ufimb0QwxomrETnw5fcBZwR6ItUzHFM20XT+2QJd9HsCCWeottGS6bX4zKqs2mBTc
 S8vIafsJ5L+gq6fLMUorel/5cjhlkswGTGYBGb6sKjguFw+QzK13ohekcB8VPVUfZ/mP
 zhDwyrkXNSVKs2O8BZ+6FnwjeI7WnhxPYKfKrmt/Ou9cGXbdQmyZXYTsbguStlEVEjZC
 dPr5jv8FgSQ5rc/Uun3GaU8qRnub2H7GS5K/Izis4Jtmal7s/mDfHh1rbGyCYOpelG8n
 pzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586359; x=1792191159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZC3Um/evFrM0IPjuDis8svXG4Qk4P0SUfU4iVB3HMmo=;
 b=UrnU9lAsP/r2mzYj3qdeeExXZT6KkmMUrG79g0fenlGxTI3QKHkv/1NSnLKx2MiIYw
 HHmG3iokvebGaiv0hp6j5aYcVNEgizqX70695XDP/E4bNFMbjaavaTjAz8xelA+Gt6Xq
 B5lA9WeuXNKiz5F/JGPzSc1rPAa5SEBaRJaqy6mEuu0VU5PC6AU0g1fC8h7JtVqOJqRH
 0a/Jliz8mu7dcsB4/wHw7T4S6tpRMzKN0Wu6m/7SKd6RcSa60Ule8gjDxe23UwCzP1V/
 na8JLM0BWeyWbDacqbE/VHOlWdrlkYqQOrYI9yGa9WAGI/U9FQROG3rzxyaRwNacenzG
 DxKA==
X-Gm-Message-State: AFq9FYJVdDpGJ3Dx8JWFKPqgvv8U035dzYMoyfxXLl0Tw2g7ywqEfvQM
 FYZc+5sBb4D2IpSs6JwxoFvNizozZbNW379XL3zHr4mwMuVa0hjfiytwGgV72G8Kt21Ek7gTi4Q
 sqy9aNYlqqUdcrDfISlqjJMCanA+JL0VCD4r1CDcLLYOKi3csZoIfQ44zCgBeHLPopw==
X-Gm-Gg: AYBFou3CENuKn0h2yPaC4tF+gcIl63NEXC23Yb6eZx4zG3pnDA2roY/xEOXRmEaEU2F
 lTFNRJ8YZk9lrzalYPzKCWJ6lDflfNIFjbvAXYBPWvO6zjsTh0qPQXpXfVnnku2l7uUkjrdQVUc
 fTsP3ISDZCx11w2cVRxGfs/2fR4QARMigv/jTHFyWM/+XEJhZZegpYEerNxHxlPKbi3V+qu7YYQ
 oPvGIR9fFOERAix8JXXb6lCOAqe4yoj4UDF5XCdEFIe18+lyvtZGkh3mPbN3qF5lyQjtUKDvaxG
 9FRS6ihpUcJXis1XGiMToFe+2THiC4XKAHLrhn9sVM6VMir3VODGkFJSOkY75ur50vvtlpr9HPF
 UirbRGRH3XSwtzzzztPuNgrVCEVkZ797y3/Cb3RqfeJ1xk6fa7adk5Rmw9vCz
X-Received: by 2002:a05:7022:28d:10b0:15d:d7a2:3a88 with SMTP id
 a92af1059eb24-16a5dbfdef7mr3638893c88.18.1791586359063; 
 Fri, 09 Oct 2026 15:52:39 -0700 (PDT)
X-Received: by 2002:a05:7022:28d:10b0:15d:d7a2:3a88 with SMTP id
 a92af1059eb24-16a5dbfdef7mr3638874c88.18.1791586358545; 
 Fri, 09 Oct 2026 15:52:38 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/11] target/riscv: declare semihosting ops
Date: Fri,  9 Oct 2026 22:52:21 +0000
Message-ID: <20261009225226.10657-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX0kPTB4lKMCdy
 CJAR2XeOeQO840o8gXZ/Re5MiCIi7hfhqJLncnjTAltHhUm9aZ5UfJRVyGlGwKSLkJvQtUN6s67
 t3VXN50gbee8u69t+XFzHKKd3nKsB9Q=
X-Proofpoint-GUID: lnZuB3BDXg4YhzkQL5WTb2Ds3kzVKJfe
X-Proofpoint-ORIG-GUID: lnZuB3BDXg4YhzkQL5WTb2Ds3kzVKJfe
X-Authority-Analysis: v=2.4 cv=AMIlxa6n c=1 sm=1 tr=0 ts=6ac97038 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=LEcTRzdMclfuOSi9gY0A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX7R07CicT4g3Y
 8u3GZYEPuVVLINgOE68zSEukKMvfAmLkMFEHHE1/ZefzCvvtr5WIFJOMAwdPVqYj9+lO02S8Oho
 EobWVE1diFM31KrGBT/OlGpuTTKz/psnjuOl4ggGAcuUULhw3grIgl06q7IfN15p0XeQ3pvoLmK
 6UgpGgfPVQmCeZ9SkRMi6pdaXgBXBMD6l2acpwmTd7nnFF6cxXjP3LsfxqlSAGEjQe0ZD6wpCLY
 tv7Cu0Zas3G89ESM4w7dX+oHNZjJOh2vyTeCQLLYQvUjRuvceTEph0nzpZeTMuqvpG2wN/TvxWT
 CoZ4lRyQknA0T9lokuL+6VA/U7h8GTZkJ5x8WM6Y2Xc9hTr4bfWtYzWEvtv7eZclc1VOQ46d7qE
 ciwrO/U/MlKF+slvTPTSx83eJma7PmTvyMi6lHUbPtxxnkT2Aw2X795Njk9qTu+K7OMMIooDsbr
 qGaPqgoZD3IEBsoXe9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
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
 target/riscv/common-semi-target.c | 62 +++++++++++++++++++++++++++----
 target/riscv/cpu.c                |  4 ++
 target/riscv/internals.h          |  2 +
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index 38a00e160c3..7fa3bef6883 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -11,43 +11,89 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "semihosting/common-semi.h"
+#include "internals.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t riscv_semi_arg(CPUState *cs, int argno)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     return env->gpr[xA0 + argno];
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void riscv_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     env->gpr[xA0] = ret;
 }
 
+static void riscv_semi_set_err(CPUState *cs, int err)
+{
+}
+
+static bool riscv_semi_is_64bit(CPUState *cs)
+{
+    return riscv_cpu_mxl(cpu_env(cs)) != MXL_RV32;
+}
+
+static bool riscv_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return riscv_semi_is_64bit(cs);
+}
+
+static uint64_t riscv_semi_stack_bottom(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    return env->gpr[xSP];
+}
+
+static bool riscv_semi_has_synccache(CPUState *cs)
+{
+    return true;
+}
+
+const SemihostingCPUOps riscv_semihosting_ops = {
+    .arg = riscv_semi_arg,
+    .set_ret = riscv_semi_set_ret,
+    .set_err = riscv_semi_set_err,
+    .is_64bit = riscv_semi_is_64bit,
+    .sys_exit_is_extended = riscv_semi_sys_exit_is_extended,
+    .stack_bottom = riscv_semi_stack_bottom,
+    .has_synccache = riscv_semi_has_synccache,
+};
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return riscv_semi_arg(cs, argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    riscv_semi_set_ret(cs, ret);
+}
+
 void common_semi_set_err(CPUState *cs, int err)
 {
+    riscv_semi_set_err(cs, err);
 }
 
 bool is_64bit_semihosting(CPUArchState *env)
 {
-    return riscv_cpu_mxl(env) != MXL_RV32;
+    return riscv_semi_is_64bit(env_cpu(env));
 }
 
 bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return is_64bit_semihosting(cpu_env(cs));
+    return riscv_semi_sys_exit_is_extended(cs);
 }
 
 uint64_t common_semi_stack_bottom(CPUState *cs)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
-    return env->gpr[xSP];
+    return riscv_semi_stack_bottom(cs);
 }
 
 bool common_semi_has_synccache(CPUArchState *env)
 {
-    return true;
+    return riscv_semi_has_synccache(env_cpu(env));
 }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da4c1a090b9..63c709ac738 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3053,6 +3053,10 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     cc->gdb_arch_name = riscv_gdb_arch_name;
 #ifdef CONFIG_TCG
     cc->tcg_ops = &riscv_tcg_ops;
+#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_LINUX)
+    /* semihosting is not supported for bsd-user */
+    cc->semi_ops = &riscv_semihosting_ops;
+#endif
 #endif /* CONFIG_TCG */
 
     device_class_set_props(dc, riscv_cpu_properties);
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de960..f17d011d22f 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -206,6 +206,8 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
 bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
+extern const struct SemihostingCPUOps riscv_semihosting_ops;
+
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
                                             target_ulong addr,
-- 
2.43.0


