Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2193ECD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2ys-0004Ua-Mr; Fri, 26 Jun 2026 05:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wd2yo-0004U7-OC; Fri, 26 Jun 2026 05:36:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wd2ym-0003pl-UM; Fri, 26 Jun 2026 05:36:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65Q6mGNn2480849; Fri, 26 Jun 2026 09:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+z28A5xboEV1MfZxB79zXVH71yWojZNBUplhkcvVa
 UQ=; b=gjcd0v6bGLoEWFUbZR6Ps7Zekv/bhHgyp3OZJh+2ipx8khMypEMB7WJId
 OKbNSp9tnPqKwmzjqsxE0t8im3RVEDhJWJghZLpE1rDsXcKPpIwvEStA9tp9oTLX
 ckzEh6BZCqEOH5VvYNXf4pZxELjSoct6b6wvezezcKye8BFp25owbmbYMVMzKb+P
 tmwNPdSV4nrHVy57kHd4y/CYbPOW7o2R4yiv+c7kwq6T9IDlP6Qf9xeb1QUa2/gY
 J6TMVkw/Buan9xgA/qayuab2YItkvoLSObw6xaP9EtShPggtC7knvdAY1vKKN7TZ
 AmwOPCdqDn9TP8MM0bDlpAVp2z3BQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr6752-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 09:36:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q9Jdh3026133;
 Fri, 26 Jun 2026 09:36:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwtkmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 09:36:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65Q9a1JA39911688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2026 09:36:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2627B2004B;
 Fri, 26 Jun 2026 09:36:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51BFD20043;
 Fri, 26 Jun 2026 09:35:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.20.26])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2026 09:35:59 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: harshpb@linux.ibm.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, vaibhav@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] target/ppc: Expose the TB offset of the guest in QEMU
 monitor
Date: Fri, 26 Jun 2026 15:05:49 +0530
Message-ID: <20260626093554.69966-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3e4806 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ecBek0X_0OQ7Le1Cs18A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3NCBTYWx0ZWRfXxUpf8PxD3q4n
 Nw+FPgqIvSq+1/Zb+BfiH6wCwdqTRqzOxC+9aSnyO6yTXUso7oKp2dfFO/452oAoVlmG/h8TZdH
 9NB7u7A9diSToTw1tvy1m3rQ8hEFpy8dzfyvvIeFauk8CjBrvJ5ETWaXulu0yqFbOQNFqfLIqu9
 Yrf1nY3k6bTRW4rDp+ozbbdbTKzUsdLtirvjDvFd57lKJzX7sr8Ew/DS9w/5ccsP+JXTiRtXQtE
 7pRHqOvEjZQHTq4evW3kk6SJPfFK1dax/AcqTsLse4O3lo1R2tPwkba/meCfiCxS6miQAGhsAZg
 ZCgqLUXmnbElTXPwiFk7CiSqyqQx3InZHW8gECXlXAsOANG+q2HAap/93K8T5DTwdVYQZ4lSnct
 M9JSU2mdROCfCEUt3utjx4bF1O9uQ4rPdyiOtSjchq6CnoUbwNROJyd7IwBz10rnLmaRnvXjVdV
 TRnnNPfNBsfR0iHhLbQ==
X-Proofpoint-GUID: Ef6h9yZlddHKmgStTnpDYQNaBi5sRPEE
X-Proofpoint-ORIG-GUID: xJmLBEzIJiu0R_kQSOqZhdTVk4vR8DTw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3NCBTYWx0ZWRfX9OgNewNgvh4f
 Jk1SPtWUmjRLwG5U4CS9UkdnoAOECQHYfCXt4gMvCkd9El40TK92CsfcgkKrT52jfrVKZLuURWj
 Sq3acUgiHRBNm+dxUegG/DgZs6zwk2Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260074
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

  NOTE: The TB offset would be reported as a negative number in QEMU
  monitor. For this step, the minus sign must be ignored.

3. Transfer the guest logs to the host with scp/rsync

4. Unify the logs
trace-cmd report -i trace_host.dat -i trace_guest.dat > combined_log

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
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


