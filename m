Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939F1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 05:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we4Vv-0006Yw-TN; Mon, 29 Jun 2026 01:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1we4Vt-0006YF-7n; Mon, 29 Jun 2026 01:26:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1we4Vr-0003Rz-5W; Mon, 29 Jun 2026 01:26:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T3IVZK2099017; Mon, 29 Jun 2026 05:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=y9B76BQLWgZkKEVgJvWKZWTjDOV1klvlpTMpw6AMu
 I0=; b=ClFQl+gEafBgqE8Dgx29TsOoKA3o7svtm3AvPnJ6DvFYXsxiKUzeVD/dH
 dUbfj5u1TaLeFFbQddaVX60upxiLDwVVNMmm1PrjYd2T1LEWnjikSnnS6mxViDQQ
 vNhtXrZGinLSymcK4q8Pz+dT66cSS/uI4Y1S2oKPOSIpwyW6tbTsV3Qq8HW8tabD
 peXTxfn9ac2VW66I7OQ3xtJ53dd8UB259Vq5aa9o5AD8E/YPK5DzjfucygsAZEAL
 2IuJg0j3GyOhCOv2W97rxfAva2epdEmIFc1LaY1/U0E3i5LcrOS7serOc/IDcdgS
 8oCwSLroTBJV3aeQLsKy+z/UWZ2Bw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdqms1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 05:26:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T5K2IU027310;
 Mon, 29 Jun 2026 05:26:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g3t49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 05:26:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65T5QMPa48103926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 05:26:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4708C2004B;
 Mon, 29 Jun 2026 05:26:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE70C20040;
 Mon, 29 Jun 2026 05:26:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.84.253.84])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jun 2026 05:26:19 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: harshpb@linux.ibm.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, vaibhav@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [RESEND PATCH v2] target/ppc: Expose the TB offset of the guest in
 QEMU monitor
Date: Mon, 29 Jun 2026 10:56:01 +0530
Message-ID: <20260629052602.78276-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6tHVcx3JrwcinXeGdQvcRhkiWyRHk1xj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0MyBTYWx0ZWRfXwQG7/Hy9dVzv
 4gc5q3mjeMl/A1LVijN+Ctl8iVarsp7R/psKhqXuoxCeNU2DvSz7odnMMK+pIZ2Ffu6+4Tre9Ji
 E7Ykh9jgrxCifjL5GHrfJDXL08r+g+U=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a420203 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PgcIA1Eq-JhpffTm8awA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0MyBTYWx0ZWRfX6gQvcCACAjal
 XsV2Tjnz++TJu3KiFhphha+6XmNTHoM5nh7Gdx8fh/MvIC8zTyDStkLqtBXgzjLRuTrbFS9uKnq
 UX3Pjk1e7JTuMS2a8/wRKyTAkCbehPudD+oxOZQzA/7cgVH5Vdpzf2UYou/xv8pko9M1JUQNRkN
 9dfufGOf4/eHmqqRx9mB1JnwDKShXbKyR9xSnCbjVA8H64Yk8ztktz+7lFRmrlneaHyfWuGSL/T
 BwbvGWE+TTqFnk3+4fJz17+QCO2qyDHlAIQM6KRx15EDPnFV8KwR/LyQG4KTwKF9aFpIwi6pqlf
 o0ubVAwn8GfwUKPloHZc093V7FL5uQ4GFtkBqlr9CfFSljkSwBmSDUiEIPHHinL2KZm9YaZZSTT
 Fn3IlNjeCrsPBhbT8r8MRqlUu8LQRvf6cLM51msaLJ7rahC1X0aovesB1hPUSAfaxzZUpUVyCN5
 OdT0p0h6dJTMluEchnw==
X-Proofpoint-ORIG-GUID: UW1kEGQNGJSuGbm1MyPANm7phGYDX95i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290043
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
Reviewed-by: Vaibhav Jain<vaibhav@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2 -> v2 resend:
1. Add the tested-by and reviewed-by tags.
2. Add a small comment in patch description for TB offset in TCG guests.

v1 -> v2:
1. Remove extra deref and ref code (Vaibhav)
2. Fix the QEMU monitor output to add the new field at the end (Vaibhav)

 hw/ppc/ppc.c          | 5 +++++
 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 5 +++--
 3 files changed, 9 insertions(+), 2 deletions(-)

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
2.54.0


