Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23E0C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9LsX-000376-K9; Wed, 23 Sep 2026 08:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9LsK-00035X-H7; Wed, 23 Sep 2026 08:15:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9LsI-0006CX-Gg; Wed, 23 Sep 2026 08:14:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8ZSQU1729315; Wed, 23 Sep 2026 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=KqpxyokqSSj1bJY4FfCPr0uIfjsVaxvvPhmofzl9y
 3M=; b=QLqftolMMGMx8gPGagiLE5ONcDeIwdNMoq08PZCwzHwbvfzPgSa4jOlgZ
 H8vw/V3KAFL0Bp2MUsNOHgl2+mylDijLItkHF8FU9h/NDbEFrST/CMxgr3f/rNcd
 RW1GS7VFzZ4OU4lhRe4KtN0wbLw2+iJhb5Iuo+9XG4EPtUsweeiQ5qBn7oH8WvjJ
 hJOOLNw1baLqwyeYnOGnJ7SIbJgE4KA6gKAsuof1hoihRbRx7G7W7uv6PGhusszm
 U+vJYoEDKtr28yyhKLQD7S9AkPHNZGWA0rT8CZobgmJsq87ytbE8IfK+AOTA4/jp
 yc3l3MJaktDdwjvHS3pGcfF2x7USg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqjk6u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 12:14:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N95gg2005711; Wed, 23 Sep 2026 12:14:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8rpuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 12:14:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NCEn1C45613398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 12:14:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 717602004B;
 Wed, 23 Sep 2026 12:14:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB25D20040;
 Wed, 23 Sep 2026 12:14:46 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 12:14:46 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: sourabhjain@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, adityag@linux.ibm.com,
 richard.henderson@linaro.org, mkchauras@gmail.com,
 sshegde@linux.ibm.com, srikar@linux.ibm.com, amachhiw@linux.ibm.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH] target/ppc: Stop vCPU thread before calling parent_unrealize
Date: Wed, 23 Sep 2026 17:44:44 +0530
Message-ID: <20260923121444.154175-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab3c2be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Mypnz8zva-T9gF3EKnkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX7NEUhmWheKyz
 p/7UL7UUrElmhYeQVfRljYBW7MiCQ6lCKvdfi1dEyQZPrHcxZdYuOepgQb5jLmQGYWaNAT9XQY4
 AQvjZFM01IlRjshwkxxw2rCQOk1eg/AIfckN59ll3/pHFvyXW/dZcmqTQn4Bea3ROQh06FVdfl1
 ze8iSAPFG/CpX+WdyJeEEm+C78nSXfEdnCGWRdwnsFFeFjxSy0eHcv1oX02RPbp5Tucs2l5jRRd
 EnA2UOnKymkFDZEJuo05t84vk/GF3QFLvn5g89XZCxHK5dKOgrmyMu0KNMp/KjZjPABUVlIHlk3
 KTIyAjla7n8K+kq/nZgtL9fxpGA8g9rjbBbi2bhpx3FWsEhTxGFVp76TDXyabpBrQtZ8yID8QaL
 Qw92PpLwUXQqlR7bLDP4PzrTHtDgtKo51UfIKhKkGrioqH03Iu+YafyMiywoa65Ed77mDvmEbCd
 GP9hhw74y1p4pvX+6iw==
X-Proofpoint-ORIG-GUID: P3QKIjy7phdYipKIvl8iPf05ih2mjqWQ
X-Proofpoint-GUID: R3t3IfUIigmmsIRgVLtVmK30L4K7KNba
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX7OgjelsKDM6A
 Dns+9+uHNLUYHAYfTgXucGgfMCbP+pp+cstlmBlLWFa8a4bJL+n1pqRHQoB3h4iWXNjAy5LpCNU
 GCHH0s4UA/ZoxJbozZ8YTncW38Vc98U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

During CPU hot-unplug (e.g. via dynamic reconfiguration unplug),
ppc_cpu_unrealize() invoked pcc->parent_unrealize(dev) before calling
cpu_remove_sync(CPU(cpu)).

pcc->parent_unrealize() calls cpu_common_unrealize(), which triggers
accel_cpu_common_unrealize() -> tcg_exec_unrealizefn() -> tlb_destroy().
This immediately frees the CPU's TLB tables and structures. Because the
vCPU thread had not yet been stopped and joined via cpu_remove_sync(),
the vCPU thread was still actively running its event loop and processing
queued CPU work (such as tcg_commit_cpu / tlb_flush).

This resulted in a race where the running vCPU thread accessed and freed
already-destroyed TLB tables concurrently with tlb_destroy(), leading to
Segfault (due to heap corruption).

AddressSanitizer build reported a double-free:

=================================================================
==121930==ERROR: AddressSanitizer: attempting double-free on 0x7ef8f3438800 in thread T14:
    #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
    #2 0x558bf6a391b1 in tlb_mmu_resize_locked accel/tcg/cputlb.c:249
    #3 0x558bf6a396b5 in tlb_flush_one_mmuidx_locked accel/tcg/cputlb.c:296
    #4 0x558bf6a39f91 in tlb_flush_by_mmuidx_async_work accel/tcg/cputlb.c:390
    #5 0x558bf6a3a200 in tlb_flush_by_mmuidx accel/tcg/cputlb.c:417
    #6 0x558bf6a3a22a in tlb_flush accel/tcg/cputlb.c:422
    #7 0x558bf73f31ac in tcg_commit_cpu system/physmem.c:3068
    #8 0x558bf6987c55 in process_queued_cpu_work cpu-common.c:378
    #9 0x558bf73a9913 in qemu_process_cpu_events_common system/cpus.c:402
    #10 0x558bf73a9a46 in qemu_process_cpu_events system/cpus.c:421
    #11 0x558bf6a65974 in mttcg_cpu_thread_fn accel/tcg/tcg-accel-ops-mttcg.c:90

0x7ef8f3438800 is located 0 bytes inside of 65536-byte region [0x7ef8f3438800,0x7ef8f3448800)
freed by thread T9 here:
    #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
    #2 0x558bf6a39a91 in tlb_destroy accel/tcg/cputlb.c:345
    #3 0x558bf6a16354 in tcg_exec_unrealizefn accel/tcg/cpu-exec.c:1094
    #4 0x558bf693d073 in accel_cpu_common_unrealize accel/accel-common.c:117
    #5 0x558bf6980e37 in cpu_common_unrealize hw/core/cpu-common.c:279
    #6 0x558bf6980dfa in cpu_common_unrealizefn hw/core/cpu-common.c:267
    #7 0x558bf763ef65 in ppc_cpu_unrealize target/ppc/cpu_init.c:6965
    #8 0x558bf7872199 in device_set_realized hw/core/qdev.c:618
    #14 0x558bf756068f in spapr_unrealize_vcpu hw/ppc/spapr_cpu_core.c:209

Fix this by moving cpu_remove_sync() before pcc->parent_unrealize(dev)
in ppc_cpu_unrealize(), ensuring the vCPU thread is stopped, has
finished processing its events, and is joined before CPU resources
and accelerator state are destroyed.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6c626843c9..b711f9c0a8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6962,10 +6962,10 @@ static void ppc_cpu_unrealize(DeviceState *dev)
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    pcc->parent_unrealize(dev);
-
     cpu_remove_sync(CPU(cpu));
 
+    pcc->parent_unrealize(dev);
+
     destroy_ppc_opcodes(cpu);
 }
 
-- 
2.54.0


