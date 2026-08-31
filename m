Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F05C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12iW-0003kU-Ky; Mon, 31 Aug 2026 10:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iU-0003aa-Oc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iR-0006ee-Ak
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBALWx2271657
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SSO/yeK3USA
 9FkI9TiWXCH2ECWBVT6V9x+RQhqdHd8M=; b=FBIsgo0YEjQ2LQLKEvhiT+J5MUp
 vmOunmSJxY4FVfThWf6iJNZKLsVfu/I2d0Bba250WBBTl4nWChR2OaWzosq+0CWH
 194Y6Wx3AYnf0rKdPaOXgv6eKbYZKACb/RrrGSh4O2wz25rNEgWRF+uv8vHfE9pp
 UoqRD2y87uElz7j1RVw0tIoEGJ102/1Gs/nQHXdzXMGW0mEo+sdZoy9F0LMD9qbT
 1RVYUm8wpD9LJPm5UlkSKUrXCv4/2jJHGe/Sa9wnCwgWqEeZ6WX4UkCl/w83gD0Z
 eUrLMXgOfUFpFV/W0l7J2NiyWxZ+4QhqUJr4Amq1srVf145du5xg2ghlA1g==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vah5kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:25 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7eb650e79adso4099626a34.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185425; x=1788790225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSO/yeK3USA9FkI9TiWXCH2ECWBVT6V9x+RQhqdHd8M=;
 b=D1Em6yfiT291TiOrxUrgFiuXq007QGopqHl6vFLBYBXX8Y5FrntdxgCF35tnu7OrI1
 QrDi7aEV9obxZ75unyTYGnG+8tLBGLBQxRLZrMdEr5BBriJgssECgecN8wTzn/LYkO5N
 0kL0qgdJ7f5NHom3a2PmebfaZqX8lrHIeMo0LoPyJFxWvOYd0SvXdWJUgx/l1ahI1Tn0
 bsfOH/BqfIiP3TH1ogQvH5LCnOGRnZApCLVJZLe0M+JabcUVysLOTT4WwUpZmOTUUN++
 t9g2Bei2qto3536ulvlypBRE0ktj/Ak2xxQlhw/JoCsKa6KVba5/+9oxX7S8REyTAW1q
 ew1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185425; x=1788790225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SSO/yeK3USA9FkI9TiWXCH2ECWBVT6V9x+RQhqdHd8M=;
 b=jL3X4RxK7LAPE8oxJVw5F4a4J0Q0M/HqfrSjVjEIU4tZruloCPkBUNb/5yJkBeSVKE
 +KX7Nx0kH+08oTDfnbWknqqN5k30sa19lpU5M9F5TMcGL3zkSmGWSreldXQw4jJMc9uG
 UoMimBqVQ6zDIqG2RSDPT9IL1JEbqF/kXBPaCim4hww5PrreK8d9Zid4A61eWXRXT0TD
 VZ6/YA73hxRDbwjiIoX0DdBlbXipeuXhuR26M5DkJO4KfUEAqIDM+TWkUYtyiXxlpM0B
 4gR8EI2L8JwurA9b+8L97spiZbc0IHqvspUy+LrAruULrIYs9d1Zf3Y9jxjMET2bkB15
 a02w==
X-Gm-Message-State: AFuF++nqCOK5Xzfk+yo9lV9Kxdfa7OxBA5jpyFtOa4KCOyXkCtOLN9Xd
 EtkYLeTLeYaaDx5B6mk0ZlfheJgOL1VjwJiB4OYHUDvVUd7LpeXdmSnhWH7rck8fLXb9AA21LTh
 hodVZeb+nY84/bgYHQL9yiQ0FniAq7yNs1iFLUKInvM8apTpUh0R3ZOsTuOVB8lzQIQ==
X-Gm-Gg: AR+sD13/BXE8J8bDPMdTNoSLU/h8nniHnK+oaOPA3Y9jBnqkn2vrmCPOUKx+tL1U2VP
 8sTOHSal7YXqYg57ZCFNMksQexhvF+rGa9pZZgVQM5aiTpFUqyRJEWW8r8FPLM3vfDk8Q54/BVq
 PG3EV+FJ1DrgRzSQabDDpHwcr5P9DXGCMYNgmAgkF4xqqzk9gEaNjWVGUm7lLhLbPC35JqGi+Dm
 3eU5epPnelxWXLc7Rao1W7dDxZSkaVNQkyz8jABngu6Cq95vbYNCBbTopMx/BO3Z4zzGRdWNTzZ
 eiqAvdhS9zCm5cGoqqbkrhjXMCRtIlAKbU08mo4LVn0V0R7CacVb69sA63X9PzsosLSeeWX5/au
 YOqagMM2S3DodG38sPJIaAzPBpAHXQlPQwx6LJA==
X-Received: by 2002:a05:6820:1c8c:b0:6b3:5475:5a47 with SMTP id
 006d021491bc7-6b35475f876mr8205784eaf.32.1788185424999; 
 Mon, 31 Aug 2026 07:10:24 -0700 (PDT)
X-Received: by 2002:a05:6820:1c8c:b0:6b3:5475:5a47 with SMTP id
 006d021491bc7-6b35475f876mr8205710eaf.32.1788185424261; 
 Mon, 31 Aug 2026 07:10:24 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:23 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 4/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Mon, 31 Aug 2026 11:10:03 -0300
Message-ID: <20260831141007.353854-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX14VYUsxOzmOY
 jl0I0CMpIYqD9G+mQvP/kgbd8BmRbRiLObZScURJ1V+ccuHeoMUXqC1F8GPC+3AJYQXTwb9VxpP
 FwZ6tgEEED+2VSJvo3tLkGSE2Ongj3AGpi5sDs/Gbec3MjNcgzpwIz4bhAgShrZ3JlUq/lsAte8
 iJAQwAzokghFzSoIyqanMR7ZWsVrPKuiXN69Mxyr9DuIlPEuozGysO50yiuly41gSyWKU1C2i3B
 mXTwVOw6Tddl8AMw5+yheUBW5Xew0NnQiidStAqm1JvpAL2HO6Pq13BNkXxTim1mvbdPh0yMxXN
 RuBjCsANDOTgChY7xgUgPa4IPpIf7ewhp98VO1U3DEV7QXN5IW14R8T54l60Q6jch451pdkHYfi
 VDMIif4joptCU2On0DZgXhJ0nVUD0lunwsUriXlM5DBmo4JnniG1Op7JkGIc3fmBXCffq+Sblh+
 Clzo33oK0oOn2dGnbOA==
X-Authority-Analysis: v=2.4 cv=YYmNIQRf c=1 sm=1 tr=0 ts=6a958b51 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=ITXOtABjXhpKHoTPUzwA:9
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX+N16oRP1hwns
 glTZXF5V1uuu96vO3JQWNEp3Atm9lbTa6ex4h9512jvb0Lv22pg+7z8l6vi0hu/ymWxDCkjRjHG
 RZRoUumpTtDFT+mLJ2eTFNSIoJM6P0k=
X-Proofpoint-GUID: tYgsInInCwjzsVPgAM9aLThNRvIryaMh
X-Proofpoint-ORIG-GUID: tYgsInInCwjzsVPgAM9aLThNRvIryaMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 target/riscv/helper.h                         |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc     |  6 ++++
 target/riscv/tcg/op_helper.c                  | 34 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b4c47d0738..0d9ae15e3e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -142,6 +142,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
 /* Hypervisor functions */
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index 4e57901880..42bf2ffb53 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -68,9 +68,15 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+#ifndef CONFIG_USER_ONLY
+        gen_update_pc(ctx, 0);
+        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
+        ctx->base.is_jmp = DISAS_NORETURN;
+#else
         tcg_gen_st_i64(tcg_constant_i64(ebreak_addr), tcg_env,
                       offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+#endif
     }
     return true;
 }
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 54269efee1..5db4f6aacd 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -489,6 +489,40 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+{
+    CPUState *cs = env_cpu(env);
+    bool enter_debug = false;
+
+    if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
+        if (env->virt_enabled) {
+            if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKVS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKVU;
+            }
+        } else {
+            if (env->priv == PRV_M) {
+                enter_debug = env->dcsr & DCSR_EBREAKM;
+            } else if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKU;
+            }
+        }
+    }
+
+    env->badaddr = pc;
+
+    if (enter_debug) {
+        riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
+        cs->exception_index = EXCP_DEBUG;
+        cpu_loop_exit_restore(cs, GETPC());
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.43.0


