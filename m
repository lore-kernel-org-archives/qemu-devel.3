Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39891CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbtbf-00031s-Bl; Tue, 23 Jun 2026 01:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wbtbe-000319-03; Tue, 23 Jun 2026 01:23:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wbtbb-0002pY-JF; Tue, 23 Jun 2026 01:23:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0mKOJ408230; Tue, 23 Jun 2026 05:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=90FWyB3DhJKYVOPuSdDK9GbRJuff7/RtFMQ5typov
 BU=; b=MwAWiR8zOkNURG98MUPdneoAvmEvqOEpb8fc9mDz7n1uo90nU6wcXK8eC
 oZJQJD81FL6yZcjqiamxr4sCF0SOeunfx/mriBo0d/iHfkXEEfxrzaRLtWbic8wK
 nb98ruxiXG4034ssCUuNDKv2A4VqHMb5K5Yl/Omm/Lu3EyNDRQjFnzTgo7J/EvIJ
 HBiqNanH9Xs42Z+KxjWgjVhDAKuBKnQIuMd7YOQnqcpiBASwAjIAzsAq6bB2iyVF
 vfbSje2yTOklgRbAgUFMs2WikhnUT0fqDlSr3Ns2GBZqXvGrJK3aU0VsMJkym0nx
 luRFojnWvY/1PB0xZtONQy5b27IBQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3cs8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 05:23:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N5Jcac005461;
 Tue, 23 Jun 2026 05:23:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyhbu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 05:23:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N5N92b49283366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 05:23:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 109CE2004D;
 Tue, 23 Jun 2026 05:23:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47D9B20043;
 Tue, 23 Jun 2026 05:23:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.77])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 05:23:07 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, vaibhav@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] target/ppc: Expose the TB offset of the guest in QEMU monitor
Date: Tue, 23 Jun 2026 10:53:00 +0530
Message-ID: <20260623052303.5274-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a1842 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=d3w6aswedyHgzLyi0mcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0MCBTYWx0ZWRfX2Gjzfq99ha5H
 MY84cRW6lFRgqlaHHIMX3c89FzqC7dvhAZ0P1/DWmuv9KjPSZoQ9lgWao0qso4JnDQDfXSChbHO
 cS0tf1pKlLYnSD4PgjchFKB0PG7iFUs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0MCBTYWx0ZWRfX6T8bvFi8JUQZ
 UOLUKC5VtnisuGfIXDdVuQevwdiMQXmW/gMn1fhApOdDDFcc/XBpTGWKisFIh4taWvMqjkqAM6e
 5NFP4/jeBsAPzfWGCERJyD1ppBmrOQKk5msyAyzsWDOqxu9LADrB0UzURtZQSIVtCPPzsGIc2Uz
 S5wwExoVal2N6dp7YrYuO2c0qVmK+v2g37FV6aDnOgU4cDDv2QV7blYy8yimtSEUvgNsvIk7gJz
 HZixizOeBgfRs42Rw+9PgOec+Ou7Y2W9167z62BrOGDxAObEvjGLCFODxUQqxtk2k1Q5lfxkB6I
 IurMyf2bFxeR8UBYinZNTXP/wVmWuV0NKaLm7IpRBOBGqnlvbbt/uy80BEXFp2xWzXw6Qf9SMvk
 pYmZjEE+oYFoC2xXZ8XS9tchP7yuy6MkD7ctqe/4gzTqorz6qP4jaHpvPjCxRDJOYcOm/SXsM23
 4QJoht3oWqvdd2l0Z+Q==
X-Proofpoint-ORIG-GUID: 5-UvNMAi8T3vr89fVCCxKjVhieO8dVz-
X-Proofpoint-GUID: 89dOoyS8_iuCve2lU9xPAEYTb4H_u4vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

When debugging issues in KVM guests, it is sometimes helpful to have a
unified trace log of both guest and host to see where things are going
wrong. Expose the TB (timebase) offset through QEMU monitor to enable
capturing of unified log.

The below steps can be then used to get a unified log:
1. In host
trace-cmd record -e kvm_hv:kvm_guest_enter -e kvm_hv:kvm_guest_exit \
    -C ppc-tb -o trace_host.dat

2. In guest
trace-cmd record -e powerpc:hcall_entry -e powerpc:hcall_exit -C ppc-tb \
    --ts-offset <TB offset from QEMU monitor> -o trace_guest.dat

3. Transfer the guest logs to the host with scp/rsync

4. Unify the logs
trace-cmd report -i trace_host.dat -i trace_guest.dat > combined_log

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 hw/ppc/ppc.c          | 5 +++++
 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a512d4fa64..1e8eb0ceef 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -515,6 +515,11 @@ uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
     return ns_to_tb(tb_env->tb_freq, vmclk) + tb_offset;
 }
 
+int64_t cpu_ppc_load_tb_offset(CPUPPCState *env)
+{
+    return llabs(*(&env->tb_env->tb_offset));
+}
+
 uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 057c54bbb8..cbd5964b1a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1693,6 +1693,7 @@ void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
 void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
 uint64_t cpu_ppc_load_purr(CPUPPCState *env);
 void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
+int64_t cpu_ppc_load_tb_offset(CPUPPCState *env);
 #if !defined(CONFIG_USER_ONLY)
 target_ulong load_40x_pit(CPUPPCState *env);
 void store_40x_pit(CPUPPCState *env, target_ulong val);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a02187ce5a..a77adc3e62 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7620,8 +7620,10 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #if !defined(CONFIG_USER_ONLY)
     if (env->tb_env) {
         qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
+                     " TB_OFFSET %016" PRId64
                      " DECR " TARGET_FMT_lu "\n", cpu_ppc_load_tbu(env),
-                     cpu_ppc_load_tbl(env), cpu_ppc_load_decr(env));
+                     cpu_ppc_load_tbl(env), cpu_ppc_load_tb_offset(env),
+                     cpu_ppc_load_decr(env));
     }
 #else
     qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64 "\n", cpu_ppc_load_tbu(env),
-- 
2.54.0


