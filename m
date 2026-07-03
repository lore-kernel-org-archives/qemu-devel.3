Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DA7C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVlw-0002CB-06; Fri, 03 Jul 2026 00:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlp-0002Aw-S8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVla-00038N-J4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631J8Kx1152093
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tAXWadD5R5xKBqELL
 SiKC9jxWaW/5igwUO1P6W/kf/I=; b=sIcobGZcHL/VUPvBrdZEjC5VgTwL2U3lZ
 pIgl1u6TaEzqSW2jpET17eqDaIhA8qGkMSmwxpfKQHkSyBzYdY83cgG4bPL0O9Ky
 6UxbWzEahF0IZzQguTXdZXlMZh7jyQWmB5/jrGBCgtq5Kl9Aoahe9OPa402Ztc7F
 bkXS49YnCAIUf23Sj0k59Zon3ZiF63ZoNfGGjofwoyO9S0kFZxldtt+HlwgI9+TJ
 mT49QDX0FN6sj1+yqcEEjTkYc8w68SwYv5bEdJBsVFTpAZjfcIHyimB0l4uu9mJI
 VTs2Xt/rqjAeuBIm7gzBbkQLMwuk1etMaItKEdG3NVy4CudsoijPg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk4x8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634Ydwu024098
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gq1n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634iKQK46137826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 04:44:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADC8720043;
 Fri,  3 Jul 2026 04:44:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02B7520040;
 Fri,  3 Jul 2026 04:44:19 +0000 (GMT)
Received: from Mac-11.lan (unknown [9.39.22.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 04:44:18 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Gautam Menghani <gautam@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Sneh Shikha Yadav <syadav@linux.ibm.com>
Subject: [PULL 4/7] target/ppc: Expose the TB offset of the guest in QEMU
 monitor
Date: Fri,  3 Jul 2026 10:13:59 +0530
Message-ID: <20260703044402.79723-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX5rFoJ2JBWgtY
 pqbGFPZixclDV/oRwc7fD1FPMQu5OzWcObcBgJIENCPGDDwdD3QvCODmRqUo0Iv023lDs/kUYpz
 NyR5aaTOC+2NNl97IjOKX/XBaiOOiZjiN9PzRyT8PA7RGi+h7MS/BazWxW+CdnvxzbIubtl9aJZ
 RUvBN34j21iNuNKR4g7PYSEAsny9cft/9lzB6jRBkP8lkJv3Zypf/T2+xquBF8ko+WtT/H4sHVB
 7JcdvoIOcUDtz0BTrHg0BBUL4F19/h9XVcq6UzNyod+1ARSTivNFaoh9+O6sgdU706plfbnuv/e
 aoyUSlC42+x8YFRD3Qh1HLrumQzQ6qv+NYVBGeDAF+Y1Y506S5f7+WMPe8g0mRNAZ5rkjkIDwUW
 mnZYU/cUk4F2oaMR8M9gwr4JgAHq6Gvut2scseEW63vHKaQYKymTJVTZrxDMLQx8ftvTljV4fb6
 0WlDoE+5mTOf8FVCyIA==
X-Proofpoint-GUID: nzawmD2NjzEl6W-gB5gz3UWLbPCjFb8y
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a473e29 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PgcIA1Eq-JhpffTm8awA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX/8jMX3j5Eq9w
 uK8dwQipjHTfZ05iPk8j5WZ5/Bfc6t+DuYpYUbgHPhLH8OxUmASetDZCbauf3yTb33tV63ePQbI
 LrVK9u66cY2n35ELt1y9l8/btIduTaI=
X-Proofpoint-ORIG-GUID: nzawmD2NjzEl6W-gB5gz3UWLbPCjFb8y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030037
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Gautam Menghani <gautam@linux.ibm.com>

When debugging issues in KVM guests, it is sometimes helpful to have a
unified trace log of both guest and host to see where things are going
wrong. Expose the TB (timebase) offset through QEMU monitor to enable
capturing of unified log.

The below steps can be then used for KVM guests to get a unified log:
1. In host
trace-cmd record -e kvm_hv:kvm_guest_enter -e kvm_hv:kvm_guest_exit \
    -C ppc-tb -o trace_host.dat

2. In guest
trace-cmd record -e powerpc:hcall_entry -e powerpc:hcall_exit -C ppc-tb \
    --ts-offset <TB offset from QEMU monitor> -o trace_guest.dat

  NOTE: The TB offset would be reported as a negative number in QEMU
  monitor. For this step, the minus sign must be ignored.

3. Transfer the guest logs to the host with scp/rsync

4. Unify the logs
trace-cmd report -i trace_host.dat -i trace_guest.dat > combined_log

In case of TCG guests, the TB offset would be
reported as 0 since the offset logic is not applicable in this case.

Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Sneh Shikha Yadav <syadav@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260629052602.78276-1-gautam@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/cpu.h      | 1 +
 hw/ppc/ppc.c          | 5 +++++
 target/ppc/cpu_init.c | 5 +++--
 3 files changed, 9 insertions(+), 2 deletions(-)

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
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a512d4fa64..b123b4cc1c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -515,6 +515,11 @@ uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
     return ns_to_tb(tb_env->tb_freq, vmclk) + tb_offset;
 }
 
+int64_t cpu_ppc_load_tb_offset(CPUPPCState *env)
+{
+    return env->tb_env->tb_offset;
+}
+
 uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a02187ce5a..8cab5e12b6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7620,8 +7620,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #if !defined(CONFIG_USER_ONLY)
     if (env->tb_env) {
         qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
-                     " DECR " TARGET_FMT_lu "\n", cpu_ppc_load_tbu(env),
-                     cpu_ppc_load_tbl(env), cpu_ppc_load_decr(env));
+                     " DECR " TARGET_FMT_lu " TB_OFFSET %016" PRId64 "\n",
+                     cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env),
+                     cpu_ppc_load_decr(env), cpu_ppc_load_tb_offset(env));
     }
 #else
     qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64 "\n", cpu_ppc_load_tbu(env),
-- 
2.52.0


