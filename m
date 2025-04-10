Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734C6C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 10:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2pON-0007wR-87; Thu, 10 Apr 2025 06:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1u2pOK-0007vk-I8; Thu, 10 Apr 2025 06:44:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1u2pOI-000440-Ne; Thu, 10 Apr 2025 06:44:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A6FWlR005759;
 Thu, 10 Apr 2025 10:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=W6Pp1nN0u9VE3yPMozkRTu3XvxoLdIIkl0GkyuAcR
 cs=; b=fvmXeU0ztvg5yviGcshgccyWho8bwAHEoULBMUiQ8jSE3YFoe6AYcLub+
 ZjUXjFEE+4pbmrE36+xxcgyuwRcn1KjlRAVMoe7Wvp5JI6C7aXqMGWcEHcWpf2QB
 NwT/HNSdwR7Isc0oolrGiwktK43BbjxZ3QIjONbEPmBI9HNgjGi8Qs3jfqvgdWKk
 qSPr+ZR1cgoIYFRdvVFEHQO5E26XDya166+wwDBZX4c0nRtTygek6pIoJ7R6UVaH
 OLRDkaf9fNN9QZZcSSCDgdRptxXkT4kDPVgmFQ9FGiLX0+pVIKmi+877lI708/78
 oAik5kK7TFK24mqdP3QQZBJ5zCy1A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x04044b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 10:44:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53AAf3O5017516;
 Thu, 10 Apr 2025 10:44:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x04044b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 10:44:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A8eTiI011069;
 Thu, 10 Apr 2025 10:44:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7ywsbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 10:44:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53AAi3V049152284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 10:44:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FCB82004B;
 Thu, 10 Apr 2025 10:44:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D73EF20040;
 Thu, 10 Apr 2025 10:44:01 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown
 [9.204.206.66]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Apr 2025 10:44:01 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 pbonzini@redhat.com, vaibhav@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH] hw/ppc/spapr_hcall: Return host mitigation characteristics in
 KVM mode
Date: Thu, 10 Apr 2025 16:13:53 +0530
Message-ID: <20250410104354.308714-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CgcgQ5YApJANyeB-7xQW7X-XT38F0tWN
X-Proofpoint-GUID: fwPwKQWeCdSrbVJnezC8KjNSbrYNL1zd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100078
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, on a P10 KVM guest, the mitigations seen in the output of
"lscpu" command are different from the host. The reason for this
behaviour is that when the KVM guest makes the "h_get_cpu_characteristics"
hcall, QEMU does not consider the data it received from the host via the
KVM_PPC_GET_CPU_CHAR ioctl, and just uses the values present in
spapr->eff.caps[], which in turn just contain the default values set in
spapr_machine_class_init().

Fix this behaviour by making sure that h_get_cpu_characteristics()
returns the data received from the KVM ioctl for a KVM guest.

Perf impact:
With null syscall benchmark[1], ~45% improvement is observed.

1. Vanilla QEMU
$ ./null_syscall
132.19 ns     456.54 cycles

2. With this patch
$ ./null_syscall
91.18 ns     314.57 cycles

[1]: https://ozlabs.org/~anton/junkcode/null_syscall.c

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c   | 6 ++++++
 include/hw/ppc/spapr.h | 1 +
 target/ppc/kvm.c       | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 406aea4ecb..6aec4e22fc 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1415,6 +1415,12 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
     uint8_t count_cache_flush_assist = spapr_get_cap(spapr,
                                                      SPAPR_CAP_CCF_ASSIST);
 
+    if (kvm_enabled()) {
+        args[0] = spapr->chars.character;
+        args[1] = spapr->chars.behaviour;
+        return H_SUCCESS;
+    }
+
     switch (safe_cache) {
     case SPAPR_CAP_WORKAROUND:
         characteristics |= H_CPU_CHAR_L1D_FLUSH_ORI30;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 39bd5bd5ed..b1e3ee1ae2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -283,6 +283,7 @@ struct SpaprMachineState {
     Error *fwnmi_migration_blocker;
 
     SpaprWatchdog wds[WDT_MAX_WATCHDOGS];
+    struct kvm_ppc_cpu_char chars;
 };
 
 #define H_SUCCESS         0
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 992356cb75..fee6c5d131 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2511,6 +2511,7 @@ bool kvmppc_has_cap_xive(void)
 
 static void kvmppc_get_cpu_characteristics(KVMState *s)
 {
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     struct kvm_ppc_cpu_char c;
     int ret;
 
@@ -2528,6 +2529,7 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
         return;
     }
 
+    spapr->chars = c;
     cap_ppc_safe_cache = parse_cap_ppc_safe_cache(c);
     cap_ppc_safe_bounds_check = parse_cap_ppc_safe_bounds_check(c);
     cap_ppc_safe_indirect_branch = parse_cap_ppc_safe_indirect_branch(c);
-- 
2.49.0


