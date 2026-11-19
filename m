Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D5606A93E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FZ5ipPiK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8ve-0003Me-JY; Thu, 19 Nov 2026 15:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v6-0003B0-QY
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:52 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007Ia-9P
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:48 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Scn095119
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xfRj2/fOUHu
 LvCHmcF+QIAgUyPKbkygrO3t2TzJ1EKA=; b=FZ5ipPiK3nLC4X50c4nwdRKjwqO
 ab2hVZFsgbmPJJyaXyfBsgtLkC7nco6sMox3rSOFpQDULVZ07h4cQUXOa6DjKc5V
 ZFmp1aXGFp1BQVGuxWYrtovxTK5WhMUxHtQYkXpx+b4SuLZwYqsE/0w0BCG/clJX
 kzKXNR2VJW7VA+Vn/GGs+IrrFPtGR6CtYJIx3dn68MMu4R0W6ZUQ9HA+L1TUn7uM
 xF+P9X5Nj2cyz7uRHJF9sy4QVNFar4yPlnSn2lypcCCZArMVNN0cVH+9LxqdzamG
 Hnqb0t6ZgkKyXwq4+5eWC8Y7/l5U6k0Ke1+8qjc4vylqGYdN7BAI7pl72/w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1b48a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdfEq3698910; Thu, 19 Nov 2026 20:39:41 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJKdfcH3698901
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 7712825379; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 03/13] target/hexagon: reject HMX operands outside VTCM
Date: Thu, 19 Nov 2026 12:39:31 -0800
Message-ID: <20261119203941.899748-4-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=AOcVaDlDQPZahzFAqEIA:9
X-Proofpoint-ORIG-GUID: AyQsfOkDkSJZZ8zL8Ob5ePlvi0nyVih5
X-Proofpoint-GUID: AyQsfOkDkSJZZ8zL8Ob5ePlvi0nyVih5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfXwuRy/WUPWqyt
 6/a879ynZAcpHFEAzlWIVNVzGpRQMMBljrjc4R9iSp/B5Dj2HfBnAhNje3V9iKO5sBD/E8FZYIs
 w+AAnxk3iaDfBrXh03azNXX86bRe32Jfm8lcMQ9jFKKEJxl5asFZBcG2x+EUY29lmU6J3/ZfLA8
 uICbfvrGG4iglsJrx9SK8qAegTagW9zUoYM+m9JscQi+7LbSkbzEHT+l0utriPnnzPK2Bt0ffmk
 ycutPR03sSg2zdaFG80xBVPOqhDH9pX7iEAKx2RtQ8HwFeLYJCe+Tr+MT9CmWqnXUwvaG7+8n7G
 VSkts17NU8heevVHEVf2ULBsqaJbv8Y/M7FVHtgVersV3fkbc18fpc1lN/gSQfbfv9N5Un3pL5S
 42Kwi0geYpHxR+jIeK9FtAO5IIBEzUA6LkC1ZUttBcklrNCj+a1Zu/r/jEL1x0kyDQF3RQ8aclo
 VcyEaXKV22x9Flirquw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX/F5uKDjW0BLG
 dpEwMnlafUT1SzI3yzNvwReINAI+X58pttjVLc5NPbKo2clstaivwnWxivbMYZBLSCJzAIIwozg
 C9kcmJZohXkO/EJGMnZjaO2hIN1qa4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
index bc3b49ab06..f1aa56e463 100644
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


