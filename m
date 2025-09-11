Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7411CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwiMt-0004vi-JU; Thu, 11 Sep 2025 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uwiMn-0004pK-Kp; Thu, 11 Sep 2025 10:33:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uwiMf-0002Qt-3T; Thu, 11 Sep 2025 10:33:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B63BE6024821;
 Thu, 11 Sep 2025 14:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=JCZEM+W/7YMGUhHjvYWtqcAniVYI3VzWeo2tV+Dky
 hM=; b=h2yNeXdJOzhZVHkhd3suuEGH3tqNAGte9svVV6eHwhZ2I1yQZN2aU4Dks
 AHiASpqDtaOZdh+G9+dE2j4DIfSapFVTU4taQampEopUfzdtrSqvStdynW8TZbCv
 tCHBdXZx9HnlCTw3dg3VAZuuNfv97z/FXjXEUZKHdpbQy6Yv8DscbOYE8c79ukVO
 x2l8svqUtIbtoJl8a/OOtQeLYs3waU550Eg0kmvB2Q/SuIR2dLF5MJB+delPQ7GD
 Fj7e1/mJqjt8EnkL3Ws8Scpt+vp3EKddX/WwAuOgkdKIpv4fXlzXWzmnFgulKVSd
 LN2ScUAKcFEE8bqh45gHmeyfq0ycA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx59dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 14:33:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BEVlEC026422;
 Thu, 11 Sep 2025 14:33:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx59dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 14:33:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDPZtH010671;
 Thu, 11 Sep 2025 14:33:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn66mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 14:33:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58BEXMfn49217992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Sep 2025 14:33:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 204C920040;
 Thu, 11 Sep 2025 14:33:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4EE72004B;
 Thu, 11 Sep 2025 14:33:19 +0000 (GMT)
Received: from mac.in.ibm.com (unknown [9.109.215.107])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Sep 2025 14:33:19 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: harshpb@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
 rathc@linux.ibm.com, pbonzini@redhat.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PATCH v3] hw/ppc/spapr_hcall: Return host mitigation characteristics
 in KVM mode
Date: Thu, 11 Sep 2025 20:02:42 +0530
Message-Id: <20250911143242.50274-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JaWqkUSOyZhFewTa0aXDHvbe7ly5M428
X-Proofpoint-ORIG-GUID: gOEMF88e9tCDW77VKpfetdWoLEg5CM7y
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c2ddb7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=voM4FWlXAAAA:8 a=VnNF1IyMAAAA:8 a=-q3l6OvWyFqWqzZG4aIA:9
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX/crDOqp4cG8w
 IUDXKvI9JC7SH2czRyco1Ps4GKQ9j869ILHu0hyMf3xedfNkeXuABJ00bsZMCNk4yoFIwxTYl8J
 QMDtlP/tcQTOd0yixproRLtzRMTJpJ0sqczVx0PDDXmmqm0ZPc6uMwswTg47l6Gvw3brXqMK0M/
 omefF+H1f/r3+QAJVYd5UK2Q2tc4TE4+a4IwfzIwgkefnGw9JbCCybRy2Xc9dx8w7TIin/U4KBw
 Fk6e9kc9Qc/gohL3ImphhYUNpsLDoUqwTTgo6n7QplVXHnxjU+XGFV6SCAscq9IuDM4yXf/cxSi
 TQrE5ZuFdJkNqMEMiCcze3vZQyvr4sl0gSO3GraiCc7ZA7JVQdBCTCNYA9PckmyGLi92XTjD5yB
 8n13orAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mitigation status seen in lscpu output:
1. P10 LPAR (host)
$ lscpu | grep -i mitigation
Vulnerability Spectre v1:             Mitigation; __user pointer sanitization, ori31 speculation barrier enabled
Vulnerability Spectre v2:             Mitigation; Software count cache flush (hardware accelerated), Software link stack flush

2. KVM guest on P10 LPAR with upstream QEMU
$ lscpu | grep -i mitig
Vulnerability L1tf:                   Mitigation; RFI Flush, L1D private per thread
Vulnerability Meltdown:               Mitigation; RFI Flush, L1D private per thread
Vulnerability Spec store bypass:      Mitigation; Kernel entry/exit barrier (eieio)
Vulnerability Spectre v1:             Mitigation; __user pointer sanitization
Vulnerability Spectre v2:             Mitigation; Software count cache flush (hardware accelerated), Software link stack flush

3. KVM guest on P10 LPAR (this patch applied)
$ lscpu | grep -i mitigation
Vulnerability Spectre v1:             Mitigation; __user pointer sanitization, ori31 speculation barrier enabled
Vulnerability Spectre v2:             Mitigation; Software count cache flush (hardware accelerated), Software link stack flush

Perf impact:
With null syscall benchmark[1], ~45% improvement is observed.

1. Vanilla QEMU
$ ./null_syscall
132.19 ns     456.54 cycles

2. With this patch
$ ./null_syscall
91.18 ns     314.57 cycles

[1]: https://ozlabs.org/~anton/junkcode/null_syscall.c

Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
Handle the case where KVM_PPC_GET_CPU_CHAR ioctl fails

v2 -> v3:
Add the lscpu output in the patch description

 hw/ppc/spapr_hcall.c   |  6 ++++++
 include/hw/ppc/spapr.h |  1 +
 target/ppc/kvm.c       | 13 ++++++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1e936f35e4..d617245849 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1415,6 +1415,12 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
     uint8_t count_cache_flush_assist = spapr_get_cap(spapr,
                                                      SPAPR_CAP_CCF_ASSIST);
 
+    if (kvm_enabled() && spapr->chars.character) {
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
index 015658049e..70e84408a3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2515,7 +2515,8 @@ bool kvmppc_has_cap_xive(void)
 
 static void kvmppc_get_cpu_characteristics(KVMState *s)
 {
-    struct kvm_ppc_cpu_char c;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    struct kvm_ppc_cpu_char c = {0};
     int ret;
 
     /* Assume broken */
@@ -2525,18 +2526,24 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
 
     ret = kvm_vm_check_extension(s, KVM_CAP_PPC_GET_CPU_CHAR);
     if (!ret) {
-        return;
+        goto err;
     }
     ret = kvm_vm_ioctl(s, KVM_PPC_GET_CPU_CHAR, &c);
     if (ret < 0) {
-        return;
+        goto err;
     }
 
+    spapr->chars = c;
     cap_ppc_safe_cache = parse_cap_ppc_safe_cache(c);
     cap_ppc_safe_bounds_check = parse_cap_ppc_safe_bounds_check(c);
     cap_ppc_safe_indirect_branch = parse_cap_ppc_safe_indirect_branch(c);
     cap_ppc_count_cache_flush_assist =
         parse_cap_ppc_count_cache_flush_assist(c);
+
+    return;
+
+err:
+    memset(&(spapr->chars), 0, sizeof(struct kvm_ppc_cpu_char));
 }
 
 int kvmppc_get_cap_safe_cache(void)
-- 
2.39.5 (Apple Git-154)


