Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031EACA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHWP-0004ZZ-Ch; Mon, 28 Sep 2026 16:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVS-0004Ki-9b
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVQ-0006io-1a
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHvYWG3196125
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+jur7FAE6Qf
 cfD+cdA4kUAKUyO24WaKjM8+7HQPArBQ=; b=NtSnFMis6ntHLWOFqqHe4rfGHuO
 X7OfmgA0QdSWgNm0mUwm6Kkrmf6GCIw/W6uba16/NssKkZ8eFC+K8fFFXKMmif72
 hhIJ6LzGZy2WHOsEdmXJm3pXaVQtEqTElrav1oAYmxu3FZl8NRIIsxhcGFez3wPi
 NLsEMBLMWQnHDihoMDVIYEWtJeEwhu5eFPl+3NhRwdxaYJ4kpQdxyTKeoB8t00WU
 ZCi/JFYQxOeK4v6+jpeWVDzsAjqlRoXoavoCz81X5o5QiYaEsA/Gj8Utk8O85uca
 a7+LDUOjGXEIvJ/miHg4FsS20v11zVKjthTXxEJGUV7+rppIom8gLpTVWGw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03gjam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a3f673221so981870885a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790625557; x=1791230357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+jur7FAE6QfcfD+cdA4kUAKUyO24WaKjM8+7HQPArBQ=;
 b=Kr56ooeQtnWpgVbB1kMIEgtX7hX7MjzVq+dQCyDBUtmIHXzuc3sKqkDQCm24yb0hT7
 MaadX7MHG+gMrvj2ES33cLXRzKnNZ5V7qT7SX04M38kXSzNGxs85YygF4GvkKQCgRY/H
 bDotTCqqNxAdeeI5jxFFHV2erBhOQMpYNWRj5lQcH7z++qbbtlX+mnELmWjTYYrcSeBr
 yvzMyZKY9i50n7AEJqlXECFO/9HCaUqcU5ixkbn4l+qJckS5ryRy6TUkLhjSmw0kie2V
 KJ99bZgWMaZ9RbJ4VGhjhv5ayqNu2QSXD/tdP0HlFYmeFx9SD0wX51yLnh+ol/EfUT3g
 EvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790625557; x=1791230357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+jur7FAE6QfcfD+cdA4kUAKUyO24WaKjM8+7HQPArBQ=;
 b=x7LfUI4qE8RqB6mgfHFsLNEFqgFQr83oNV4NN27Gv8S25eYmUWVDgpPeU7HA5HjG4s
 HQMY4ywioBKndK3kuP8ZlS/9Qa3pkRHfdlkgNL2Pl6q3wg5yrEyWFzKW+miDDvRov8Fk
 wZGrB3vKO+t2dcczOUThgMKVoEScCRocKReOvTX9VKmep8oi9KRZvkheTs6E38nZTYAU
 8McTWXAXtrl+TaduUctnsbuffK2xv2UASv2DbeMAyCR/16c2Y8lcptaXIWXLw2J10wFa
 SXcK8N0fe9hZYm3UMqQL5IgLhV5dwTe1a44DpX/sVs0MAcoOb/FiH83XIxtpICfVmpJz
 VwGw==
X-Gm-Message-State: AFuF++kWHGOl+70k4gkawJ0e8OP1ygK6eJ308r7x47li1Qicf1PfkZjn
 ER1AsXNZhPMSnG7ge+MajZRtOHTvaKAuS+7sEBvITGG2aHxgDKMfRVObyRZrBsZ4qNOLKTIbzEX
 ob95pjRdBorL3nj2sTMtz7PYqVNhzcRyu4vl2nIJ3y0Mo18R57kBq5XQfSUMlDot2zA==
X-Gm-Gg: AYBFou2PQmXqc7pdbDF6M1Va5ZNDX27khLJj23iNbo2ivEIEjse+8pMwk/YXY73KueF
 wLrA50hGkcqflzIasOSJUBILaPiFj18hrDn4603E2wVz12dMhcWqs0/QQusFQ97R8P6lp+IwOt4
 GyaAQadQ3bnK6m7HR9pe19Ujyh93H7DpEanuetp83y3SHEIRYCIP6n9MSk2ZaAsrvkpw0l7GFXR
 oJZE54mrSzXVIGb+B1Jw4H0RG4cSfeqmiTdJ8cABO7p4vz89clThozs9+WytNKQYwfl+ouyp81i
 I5iDQ4ZXn9QXQABRhQSkhSQQqTrjL0VCVJ5YhRwWelFK743XkKX9MyOVXqUiIztrNHnI4fUjaVU
 REp7Q01eHTaVe67LUvQSeeXSEPvNrVvG/zTw=
X-Received: by 2002:a05:620a:1789:b0:93b:d7a1:ba0f with SMTP id
 af79cd13be357-93c47554f70mr2232462785a.58.1790625557414; 
 Mon, 28 Sep 2026 12:59:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:93b:d7a1:ba0f with SMTP id
 af79cd13be357-93c47554f70mr2232458085a.58.1790625556874; 
 Mon, 28 Sep 2026 12:59:16 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9143d0a64b9sm75905556d6.35.2026.09.28.12.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:59:16 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v10 3/7] target/riscv: add dret instruction
Date: Mon, 28 Sep 2026 16:58:57 -0300
Message-ID: <20260928195902.2045235-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
References: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX0AymnMV0BAYE
 NdMP6cVAGp543RFxCtnLVUotgr5FMz2BvJYznSFy0hQN/Wk0MP51WzJ4PcjQpFkAB3qk9HeAUHo
 Zfjd55Hdy3PF6ldXIbpXxsgaEx4nsPQ=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abac716 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=JF9118EUAAAA:8
 a=69EAbJreAAAA:8 a=2wZ2TuoAFSEcmpuqsd8A:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=_Ge82aPy-h_wFa7gWU4u:22 a=xVlTc564ipvMDusKsbsT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX9iK6HMvihHyw
 a2EtAtNNLsW8XDX8rnpl/r/YW0ecjF1/WggNeVLPJcGXsXUQ2vlGc74QYnnU06kYkWmm7HFueVD
 BP32DwnJM6pAcT2utjSODgDoB5dYm5MFo8W2BmLJz/qvHTaN0qoByEYbERO3s4Uh2Oyo8y5byle
 ULrjcsx2JMok0jlbqsi4o/QKJm/MDQurQrATBNrVdl9fsA0b/oKu6r+YjMUgfRNOTBxr4DiqAAN
 OoaJ5HzGxyncik0J/ljMr0sGhHGVyOsD3vZYbdcn6w4F2w8r7giacYTcYHOog5eNvQaL89Ot3JF
 1KFE9sRtJSUPcmR6YwiDxeBuUBaaBEYJFnjMbNP0EoTQnhMbTwZMnGh2Bclj/vXD/1H6ejhpxFI
 3rrTUwoMdxDBAWu6xJ6ht5DI6AwuaDKiuoU5wZquvypi0rfzRPwIH1X/xEZpA6fzhBviWLfnhbn
 q8+9hB5ksLWvuWSaRHA==
X-Proofpoint-GUID: tI_YLGm__SFPgrhBznQO6LKfSR4NhGut
X-Proofpoint-ORIG-GUID: tI_YLGm__SFPgrhBznQO6LKfSR4NhGut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc      | 18 ++++++++++++++++++
 target/riscv/tcg/op_helper.c                   | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index aab92bf132..a790595b40 100644
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
index ebbbb01179..f1a042d57f 100644
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
index b67c7718db..dbdaa64f5e 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -508,6 +508,24 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_dret(CPURISCVState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    return 0;
+#else
+    target_ulong retpc;
+
+    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    retpc = env->dpc & get_xepc_mask(env);
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


