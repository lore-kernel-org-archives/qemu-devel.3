Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4784606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UaioQr2x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9s-0003EA-Ag; Thu, 19 Nov 2026 16:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9k-00039B-7v
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9g-0006Ze-R6
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:58:59 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Sd71936307
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KPV1ZXv9EGJ
 wTz9glzUKwTI5SWkFIm+3uFyt4FC4+aU=; b=UaioQr2xcJAIM2eT4tnZc+frNs6
 yUxu4kJJuXAGhj2xYBmgRIwi20yObdoZcqGY+hnAmLBSHA6pX5iPdVYz5954fddv
 Alm1YPaLHW3TJSr4N3W0B4VhU1ZYiS5sLzXKnCSvot7c7pxUtiMuh8KAsUfrPOiV
 FYhzBHW28OABkLHmZ3o/76fXuQxT6NV4bFiC5oWvK7fnuyae7l6hKaECKCAFbIPN
 FHXO/aWGMeMpyZGUktf1Lk7E1FWmgN4k8AbrQIVIAvstZhIfkHMkXDmJnI4lewJ8
 XsYcN3UFTAOa7jRtaMrMG0ODv2INHoxxXRS8egbVCh3q1ZW8fxswRg5CYbg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugt9j3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwrVn3770693; Thu, 19 Nov 2026 21:58:53 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6AJLwrw93770687
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:53 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 46B122575D; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 04/15] target/hexagon: reject HMX operands outside VTCM
Date: Thu, 19 Nov 2026 13:58:42 -0800
Message-ID: <20261119215853.987158-5-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: nNKPqxKc0Apt6y2L187SgQU5EwnaSEcv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXznPUjLnfiSxD
 BDVX4zcvIq1ZjC2b2HHXzgGdds68ZvRN05/DMUQddiOLeh9RfJszilbvIUmI/Jq5CwUWGQgquym
 2pDXSn/WnaSg/jSko8iaD2FFGsk2aaM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXzyJUAovGi76I
 CzXQDNFtkesbf7U0kQVy01J0lzW+8aWqvS44i9PTBLHbEwDEddy3pdwLeXMwbeZ0VVdgFHvIyx8
 7OZ5tC9rkQQAAsxoKw6v3fZgpqcFF6q2r3w6WjziNW566wLR6QX9zO7D714VYvm62K0nXwpaJ2c
 9RxwDyY9gJziSNPxK+46X/LqD+mc+vlnSa/dYqhSfwe1856ZZwq4lT6cJ8cd3jWOyB2nmXp2JVq
 ptt7YmLzRQFkOIGqEsq6t7eb9BsZnf+OHSKiSN6dzU4nARtSRSduWwLG3WqTWMRyGCfVRnQgIwD
 loPDQqZ7qMofwRza2Ay7/3xVuG8j3TRYZ2RYEZp9BQ5kN1ud7zu9hueI21GrLbatpdDSwlwYG6T
 9Y80U1lA0CyMr+ouepZGi1JxCQHpLX8+xb6jecuxgXcb/1cslOiYtHo8EGMWjrPePrvjzDrucKl
 qCXaHy8VSykkMleDevA==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6aff711e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=AOcVaDlDQPZahzFAqEIA:9
X-Proofpoint-ORIG-GUID: nNKPqxKc0Apt6y2L187SgQU5EwnaSEcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check activation and weight addresses against the machine VTCM range
before executing packet instructions. An invalid operand raises the
precise coprocessor VMEM address error and prevents packet commit.
HMX arithmetic remains unimplemented.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 hw/hexagon/hex-subsys.c      |  4 ++++
 include/hw/hexagon/hexagon.h |  2 ++
 target/hexagon/cpu.c         |  2 ++
 target/hexagon/cpu.h         |  2 ++
 target/hexagon/translate.c   | 26 ++++++++++++++++++++++++++
 target/hexagon/translate.h   |  4 ++++
 6 files changed, 40 insertions(+)

diff --git a/hw/hexagon/hex-subsys.c b/hw/hexagon/hex-subsys.c
index 52ec0cadac..d2e095bb91 100644
--- a/hw/hexagon/hex-subsys.c
+++ b/hw/hexagon/hex-subsys.c
@@ -181,6 +181,8 @@ void hex_subsys_create(HexagonCommonMachineState *hms,
                            sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
                            &address_space_memory);
 
+    hms->vtcm_base = (uint64_t)m_cfg->cfgtable.vtcm_base << 16;
+    hms->vtcm_size = (uint64_t)m_cfg->cfgtable.vtcm_size_kb << 10;
     if (m_cfg->cfgtable.vtcm_size_kb > 0) {
         memory_region_init_ram(&hms->vtcm, NULL, "vtcm.ram",
                                m_cfg->cfgtable.vtcm_size_kb * 1024,
@@ -204,6 +206,8 @@ void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
     Object *hmx;
 
     object_property_add_child(OBJECT(hms->cluster), "cpu[*]", OBJECT(cpu));
+    qdev_prop_set_uint64(cpu, "vtcm-base", hms->vtcm_base);
+    qdev_prop_set_uint64(cpu, "vtcm-size", hms->vtcm_size);
     object_property_set_link(OBJECT(cpu), "global-regs",
                              OBJECT(hms->glob_regs), &error_fatal);
     object_property_set_link(OBJECT(cpu), "tlb", OBJECT(hms->tlb),
diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
index 2ca4a518db..a856651fba 100644
--- a/include/hw/hexagon/hexagon.h
+++ b/include/hw/hexagon/hexagon.h
@@ -187,6 +187,8 @@ struct HexagonCommonMachineState {
     MemoryRegion cfgtable_rom;
     uint32_t cfgtable_data[HEXAGON_CFGSPACE_ENTRIES];
     MemoryRegion vtcm;
+    uint64_t vtcm_base;
+    uint64_t vtcm_size;
     DeviceState *cluster;
     DeviceState *l2vic;
     DeviceState *qtimer;
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 3575b31d19..effa95534b 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -69,6 +69,8 @@ static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
                      HexagonTLBState *),
     DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffff),
+    DEFINE_PROP_UINT64("vtcm-base", HexagonCPU, vtcm_base, 0),
+    DEFINE_PROP_UINT64("vtcm-size", HexagonCPU, vtcm_size, 0),
     DEFINE_PROP_LINK("l2vic", HexagonCPU, l2vic,
                      TYPE_HEX_L2VIC_INTERFACE, HexL2VicInterface *),
     DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 5739254f1f..1eb6c7d8bf 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -248,6 +248,8 @@ struct ArchCPU {
     HexagonHMXContextState *hmx_ctx;
     HexagonTLBState *tlb;
     uint32_t boot_addr;
+    uint64_t vtcm_base;
+    uint64_t vtcm_size;
     HexagonGlobalRegState *globalregs;
     uint32_t htid;
     HexL2VicInterface *l2vic;
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 10ed73590c..3601c4e9f3 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -149,6 +149,20 @@ void gen_precise_exception(int cause, uint32_t PC)
                                tcg_constant_i32(PC));
 }
 
+#ifndef CONFIG_USER_ONLY
+static void gen_hmx_check_address(DisasContext *ctx, TCGv_i32 address)
+{
+    TCGv_i64 offset = tcg_temp_new_i64();
+    TCGLabel *valid = gen_new_label();
+
+    tcg_gen_extu_i32_i64(offset, address);
+    tcg_gen_subi_i64(offset, offset, ctx->vtcm_base);
+    tcg_gen_brcondi_i64(TCG_COND_LTU, offset, ctx->vtcm_size, valid);
+    gen_precise_exception(HEX_CAUSE_COPROC_LDST, ctx->pkt.pc);
+    gen_set_label(valid);
+}
+#endif
+
 static void gen_exec_counters(DisasContext *ctx)
 {
     tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
@@ -946,6 +960,16 @@ static void gen_start_packet(DisasContext *ctx)
         gen_precise_exception(HEX_CAUSE_NO_COPROC2_ENABLE, ctx->pkt.pc);
         ctx->hmx_check_emitted = true;
     }
+    if (ctx->pkt.pkt_has_hmx) {
+        for (i = 0; i < ctx->pkt.num_insns; i++) {
+            Insn *insn = &ctx->pkt.insn[i];
+            if (GET_ATTRIB(insn->opcode, A_HMX) &&
+                (GET_ATTRIB(insn->opcode, A_PAIR_1OF2) ||
+                 GET_ATTRIB(insn->opcode, A_PAIR_2OF2))) {
+                gen_hmx_check_address(ctx, hex_gpr[insn->regno[0]]);
+            }
+        }
+    }
 #endif
 }
 
@@ -1583,6 +1607,8 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->hlx_coproc_enabled = hex_cpu->hlx != NULL &&
                               hex_cpu->hlx->contexts_bitmap != 0;
     ctx->hlx_check_emitted = false;
+    ctx->vtcm_base = hex_cpu->vtcm_base;
+    ctx->vtcm_size = hex_cpu->vtcm_size;
 #endif
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index c988c85f33..aaafcb0954 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -114,6 +114,10 @@ typedef struct DisasContext {
     DECLARE_BITMAP(lregs_updated_tmp, NUM_LREGS);
     bool hmx_coproc_enabled;
     bool hmx_check_emitted;
+#ifndef CONFIG_USER_ONLY
+    uint64_t vtcm_base;
+    uint64_t vtcm_size;
+#endif
 } DisasContext;
 
 bool is_gather_store_insn(DisasContext *ctx);
-- 
2.43.0


