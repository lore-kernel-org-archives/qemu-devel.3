Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D4C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jby-0002mT-Pt; Wed, 09 Sep 2026 10:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4Jbt-0002ke-2a
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:49:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4Jbp-0007BS-Si
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:49:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BUFGT2376136
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 14:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mSiaHjamEiK
 gBhiTky4VCSqYrt7tGD65LQ7WnvRfMqE=; b=ojDHVwFRLF0qhGoDIqiteDJPNbS
 MrYFXDcaDyVpXwAuUebM3qsqZIqjTqR5PnyP0fiDQqgixGbctdA0oWF6yHEffdUE
 8NPiDQoiIGWfaRv2UhlUg2B5TvNgmiEfg9W9znrShvR72Ml8o0fgB1NRXv6V04xm
 897aV+pXcxcb/rY/sJxKTImRfZjxE9bTlGnTtF5vqJRWeH11C5YY/PL+tOX6ucIg
 5IQWkzLfMAPhUlpfmV3surU1EIjcDBU8rtTeFRqQx14lVXVUCP2IV0TTpAPHIVuq
 StHdiVbldFRtcIWADNqGbIxA/IFoyeCOr9ct5PqvsxILhz5e+p6fY7dnI2Q==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru11sw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:49:08 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-845f687dfa2so111506537b3.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788965348; x=1789570148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mSiaHjamEiKgBhiTky4VCSqYrt7tGD65LQ7WnvRfMqE=;
 b=NDYot32zGiXoAYRE9cRBVl60gEYP45JrWU2yGPgRSBaiz9kXluZUz7G/r8YIOkG3VV
 uXNe+rarGWkELLXq7IiLG6Hm9eJwcNY2SRAXVksdMGlh/ztG6xY5k7MJg3TzcdOuGB0a
 SAmwQYrnZ0O+ot2LLEz1wK/k9k3MnIqR97IyQ1xyE/K5QZYTcb3ZS4/VM+XSZsQHEeMT
 Dkz0F14N8l1NgWOi4z0OPxAckTBLuJ9EhcVo3PxzerVc+jDy2DB4cDZFBYfB5tPGoL2w
 K2S/iE9yHk+Q6dMmIDpFBIIw6AtpJxHFZ+mzLJHar24qvFFFLrf7EE17VvtB4KieaWen
 qKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788965348; x=1789570148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mSiaHjamEiKgBhiTky4VCSqYrt7tGD65LQ7WnvRfMqE=;
 b=Nv63NY2yOtAQyi5tag8mpFDaZcwGB5O+xpsQJTskYYqKtjydyfzAbHJuZdzZAsvi5+
 h6MtIEFncAjB4gA7EdrBa1XlaspRaIOrPzxOpdWplPqB3iCJJtQ8GRfAFW2PO7FXnAuf
 HDFyUkrvZXluWqptzqCXASv1+pNsMk2oOKHX2Fi/qqdfIJlF2hm0NBoi6H8OZbWsklo1
 2jRajZdo013u2GeXz7GXOA6ls8KmhIHVLOHa6UJAqzS2t0PGyx+hBQa99MuejvpUdvRH
 mnfllsUkM0xhdcUwgtcHpuUgxRP8FWiw7SAmudhx3uuqOI6tJ/ecjRdjesUVy7x1IGvU
 pwvg==
X-Gm-Message-State: AFuF++k+jIo72tSVOt9yq7sZH6X8ZRzQbliHjftt5mzYCeQd34+MC3j4
 kS77V4wexWWcKiVcC/VDKx0QQMaDyVJFuz4DvAOIQ9iSu1gZ7/1cat/NDXEq69PWx5r8lJTrgR0
 LxLNQ91SfPkC5umaGVT/wj8B0gSWs9h94f5CGcNg0DV+EX3ygJ6pzYVsNa+7RDFEtMA==
X-Gm-Gg: AYBFou1CZtqGaVkdVTZ2x/OJhJgDf2Uo2PaRtJLE0NrjJMlrvDwfoXgj+bW6OuwwgXi
 fqIAr5mlE28i/LjuakMY30lep7nN6/aRjFaOH/SjV2+KmAVjCJvQeRTQcLUF3rR4N7llLwvqApA
 30CUOgZvku9fsU+WVVntCmd+yWGhg1/tuxMsntwU4GgY9NhxWB/vdpDHjcJ+ZajIoIuK65M+34y
 5KXoulnOixPKAMaWEjx8uvX3X3QeiMBxqOBSa8pgXST1Jre71ACNjsQcy9Dl1O/DMPkFXleGRoA
 O7zVLiUT1E3rqc74WfGzreyNOh49N1z+o0SmGc2svgI+szvbrDAb2QtbmyxnMGaW5b2ZnZSnqwg
 ZWmTpwQRJgCyNLGFSKNVJOlBTyhHiSl+Wy+3o
X-Received: by 2002:a05:690e:11cc:b0:670:fce2:60b7 with SMTP id
 956f58d0204a3-670fce26dd9mr3798943d50.84.1788965343312; 
 Wed, 09 Sep 2026 07:49:03 -0700 (PDT)
X-Received: by 2002:a05:690e:11cc:b0:670:fce2:60b7 with SMTP id
 956f58d0204a3-670fce26dd9mr3798568d50.84.1788965338053; 
 Wed, 09 Sep 2026 07:48:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910464bf898sm125678886d6.7.2026.09.09.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:48:57 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 4/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Wed,  9 Sep 2026 11:48:37 -0300
Message-ID: <20260909144841.1766921-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa171e4 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=ITXOtABjXhpKHoTPUzwA:9
 a=MFSWADHSvvjO3QEy5MdX:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: RGhAlYerur4_pny-9nt4NM3XmDdn_GXD
X-Proofpoint-ORIG-GUID: RGhAlYerur4_pny-9nt4NM3XmDdn_GXD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX1bCK2x13Vgzg
 2KERHkaapkIQTRfB7AXYA5DNcautCIXzXtF1k2iNRHPWJPL95zH8fLV5cY1hCQTTCu+JRBT2H/d
 7Z2VOPDquJFujavjkk6n+kQjxVdHwVc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX+IPjZAoWKrnT
 dFcyLUNUhhWe3e9ZjAjFP0i6FPbALCB76f+66fXNQcFFEe09HVNHZkRnWeVw81rrv8Brap42fKF
 0NWko1x0yoLejRo3bZcARE+Av5PkJE/3oVw6dfKpn2DVYFZmXjZLSFDsk00OFRw7tx0e2NttBIU
 KOsLFL3r0F0prJ6b5SCWwmQ54+0f/QRlWdQe/W4HblYNly/pn4O0JcXDOUxnMPiOk6qQDPxUXSh
 MAkBFnmEIdWoNj806vpOehPhxninW436Fx30HXwRuJLr/FLpa2Ds2yCVniGRSU184GZnAhPo9B+
 +wmCdV1q1bKl8GXr83ld9QTshAdaGDfitX23znqHiJynbufv7uPAHAXJc4a9EMbyqVZaSzcXDtO
 dzHdt9krmPXBg5OfXFLbW5s7LEEy2ncyz0wv5zR4Vtj0dqwKEhukZK15P2AGYUQFE3azf8nVmGP
 POQzIaPkzGMRfhNhy+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090165
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


