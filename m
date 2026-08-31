Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0DDC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12iV-0003dE-Id; Mon, 31 Aug 2026 10:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iT-0003V6-Br
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iO-0006dm-AI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBALih3862492
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PGIWkUNQGNb
 E3Jrb3b9emrRpCm7vdZXSJ3jZQJLP29Q=; b=mXI8G+uHhr7U9tije/dtEXuHI6C
 OZn3OD2wkhPrFJFHH1YDHrvPNmlUlBV1+TV84PJfVWNtYwc0KP5/+N8OwE2UiNna
 gcCD5d1xOJ9C7BUSXnjXXCU8hzJG60CafhVZyS4fRxcO5NOGvxmTkOHU23FgyxVN
 bS2Oluv2e1KVAXBu8tc1tSZFoNIy6dEZUtT4/OjIVe96OUrhAsrf+f2+ObOM98dR
 8HJ6MHJLvx8cKS03muARk+elsDPs2HhTzaIWN1oAXNFBTzVhpO4PYBSqaKlpg2gC
 e+wKhYfEE+k/9romsdNKha+LtgbfhDyRMz8pUGtPX/vJcK6GG7d0AakMHSw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4pm9uc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:22 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4574f1cac98so6709168fac.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185422; x=1788790222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGIWkUNQGNbE3Jrb3b9emrRpCm7vdZXSJ3jZQJLP29Q=;
 b=Wcm1x/HxDMsGENmNTVqG8kASufotCKR/J1SjYlpFditenAefwpRuk6/DQCTbx0MeRC
 dtQz2VtANyAsPCk2aHZbfTJM2nKrfJIyvoOLlMRFuJpi6QapArS6XsS8wImdDlBRSYDp
 PuaQ57nHBC0B1e+qSXsqHpcQmpXSrqk/s8SguHNigTdw/NMZNiHV7C1xK9wvgG1qZBiD
 ewg2IEN8iWV1pE5fp44KTtGKEc9HKDvlOIf2ALy6cRkBO94Fb7c8Og6CXX+wCQLesFCS
 FlceW18SUHFGs/KWVqdYHpaeKhXjd+M6UISW4Z1pGrYnmPjw27Kd6UnxCPYCVU42uwuZ
 WtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185422; x=1788790222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PGIWkUNQGNbE3Jrb3b9emrRpCm7vdZXSJ3jZQJLP29Q=;
 b=aSw+m9loXrL5RI2lJXHjPXCwmjN3sg/FrSnJHFymkygdWuklJwZFozdnZa5S1p4xyF
 vNdfJ8ibYIp2Uf3ePZcKYgksYnBua7pOKIXJx6aumG7rmnWVzaDDX5yr2W6ZlMG8vm+Z
 D5jU/0g2GHUZyqgo08R2HvipKH984wjkQRLGhqTODmANrvIYvSqkZKIHqJGDShtiQzFd
 PhNgf7uVMNT4fOZhHRgo16wMk6g7cx1gDsmle3wr9jIPDHksFS1+Mo4ofYlFSAYEE4LV
 y9SOolUL4M5JauWWKBRV3sXOb0yWd+hSMdCyjwvwldTwztNYHZKSixxNBG9Hw8HHV9ki
 YslQ==
X-Gm-Message-State: AFuF++l01svEZgDubbzmOD0munogz3I0LwWRkaFr/mw1uBD3sMGjYkFt
 hBBsSKtX2Tj5U5kx2rwjHy2Ues6u4SAqhJiTNES6uwgTjTy73Y0xcCJdF1AqfH43g9z7i2xCcV5
 0xCZsqWnFwezhEF7yBEMtGMLIhCsAUsrDBWLuguj2JoqwSEh2Io9qSAPVhetGzg0W4Q==
X-Gm-Gg: AYBFou1a0119hXNvEq/u9SPietwXyNJrHgaDvKE5vJfBmGVxs6NglxTPlzx1ogFRUAb
 IqbF5MXfzRBgSO43/L65UYGhUjv8s0ZKjzS98PMr6JRX4b2CmB0SzSjZrIxZNpFs39+tw2fMUY+
 2LRQVhIeApY2Amo5yCfPVjZeoV4WhkxZ1QND+zA0+rrMkqwDEKK/ok6KbL7B+wOzgP24Bu9NdJe
 /voc80SP6kzddcdvjckTg/wEbvkmrMn5+27f0dQA7mRdHL9VXqZPuiB2q4xm77jqGIiE39X6iyN
 eWQ2In2jzdVhy4InE1xkUMXhvvWccXvmL28gb1ZKXxthqGy+pmyNuBUtYn+HAOksyRVU8aB0alL
 z8hHJj3YHlbMWJre2eBaij6Lub6cIRnTMbS7TNA==
X-Received: by 2002:a05:6870:a40b:b0:46a:ad97:9ba with SMTP id
 586e51a60fabf-46aada707aemr11051104fac.8.1788185421946; 
 Mon, 31 Aug 2026 07:10:21 -0700 (PDT)
X-Received: by 2002:a05:6870:a40b:b0:46a:ad97:9ba with SMTP id
 586e51a60fabf-46aada707aemr11050975fac.8.1788185421294; 
 Mon, 31 Aug 2026 07:10:21 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:20 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 3/7] target/riscv: add dret instruction
Date: Mon, 31 Aug 2026 11:10:02 -0300
Message-ID: <20260831141007.353854-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zDoDL6TINhf3AJXb2sdZRwFx4QUDUlBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX0gEc/9HVQTen
 UX/8aVCEe79oIJQNip+wEU3xxcu2zwpC2WT7ieFYlBJzhrrcWjmwHvIxsjzCYI2PgzvIpe47j/4
 wDjPdQczXcHFTg8urnhUJzWvRczdXpkN3ZoplLKeNu7wuGi9zLV7U+NsnLgh5tUhW/AIcJLraMZ
 d4OoPn7Gc9nhgJAo23QseSVLLtLtXZkaxeEJMsoT/4gmVm6FJIyQeJvoOmPlvKy5N0TefKMD/7z
 XcVjUBY3aTWnUKf4aMkPxlcSOfHdlE1UuTEKrE3lC7/LRz+m9dpIP33D/0vXlbE932iJvKANfWY
 V9Pq2+5DamggnO4/6yS9BfZlE8uAqrVnPXf+YzN5D4kJ53iLgKIBkdyQzWSfSe4uQ34GtvbTRAz
 hqKk2GojALtxO36XBDtJA7gzXgB9onFEI0is0e10Zlk2cLFifElzQKfTUvo5Ix5BjExK3dmPBuz
 Xk+I6urgtyuJU/q1SvA==
X-Proofpoint-GUID: zDoDL6TINhf3AJXb2sdZRwFx4QUDUlBm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX0ymfmPKcgrBN
 neH6WwSuyYiHjVxb0jHEZm+T3r7lwRYhBp0dAOjGBHvaeXFABxTulig9gnzDJIWzF9RovEaRlHz
 sbHtkf/Rc4P5Bn67RUCXTF/kxuW3aGg=
X-Authority-Analysis: v=2.4 cv=GbQnWwXL c=1 sm=1 tr=0 ts=6a958b4e cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=2wZ2TuoAFSEcmpuqsd8A:9
 a=1zu1i0D7hVQfj8NKfPKu:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc      | 18 ++++++++++++++++++
 target/riscv/tcg/op_helper.c                   | 16 ++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4fc2d3a155..b4c47d0738 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index aa02dae3c9..46b00411ff 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
+dret        0111101    10010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67..4e57901880 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -125,6 +125,24 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_dret(DisasContext *ctx, arg_dret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->cfg_ptr->ext_sdext) {
+        return false;
+    }
+    decode_save_opc(ctx, 0);
+    translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
+    gen_helper_dret(cpu_pc, tcg_env);
+    exit_tb(ctx); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 3e94005d2b..54269efee1 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -473,6 +473,22 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_dret(CPURISCVState *env)
+{
+    uintptr_t ra = GETPC();
+#ifdef CONFIG_USER_ONLY
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    return 0;
+#else
+    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+    target_ulong retpc = env->dpc & get_xepc_mask(env);
+    riscv_cpu_leave_debug_mode(env);
+    return retpc;
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.43.0


