Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981B9C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpke-00056B-GZ; Fri, 28 Aug 2026 02:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkc-00055l-S2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpka-0000gz-Ti
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22BoP2941184
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=v5nwDrWL3QJwJUdb6
 2yJxeHBNeMODvKAQEOwdSJp3tw=; b=fCabqYcSIVNB20iAhVfELNJczVCx3x4He
 NMTf1UircrKqH3hvl+5QkqcrZfL9j2nco3cBPUyJmfuOcFG/WeZ45sD1jX7xkWP3
 dlET6IJMqrwserg4A5LsYjbVDK1n5stOmlS511oQEJGbj/QkjhI48amgDop9aGf7
 vcWBwuYq7tuTYlpDF31mORGlbC3TaopS4/ccXtlT8vyE7KklwKKr2pAPmgtWZ+qf
 S7cQs/eRXgg1WrXEn/VMz1dDNiuws+tyDF87Qf3HpwE8ll889YdBEH2qHZmYcRbr
 Bk98aRs5qVuaIzxYqzjYtSaUKyv8wepTLlhZcXEhuyoYuek+Lt94A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eraarv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uNua003691
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhmjwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67Xk451511658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E35920040;
 Fri, 28 Aug 2026 06:07:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A04DC20043;
 Fri, 28 Aug 2026 06:07:31 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PULL 03/41] target/ppc/kvm: Use host compatibility mode for nested
 guests
Date: Fri, 28 Aug 2026 11:36:38 +0530
Message-ID: <20260828060716.91672-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G0boi_yfUgz00C_lMF2RZMGe4EHRogQy
X-Proofpoint-ORIG-GUID: G0boi_yfUgz00C_lMF2RZMGe4EHRogQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX6NoO1R/+U52Z
 2gGR0T0VGRQN0x0kE1cmz8ETdacG95yOLN3MvtAIImeEyNAIQi11GAHsTrDxZQwJwj0qsr0G5pL
 FmjhzN1XiS8MapnpKOklqxANIN1BwRqsZcKZdtYlwu+Ichn5Qv9I3nx1PxVrsy8SJ9wE/g4pK63
 vQVbNCrg5X3VcRosAKvNkIc3F9qMeJi0VoNPPcBQjrBBtWdUmIJSt3mpjPaL5zgaRBRbNJ9eC6M
 vDQjHSgSAbGPg7p67w9CITZkDQnDDKOkXZAnSmBP5teHunN2MUjZAJJgsB3mcUiZA9o3vd39cEg
 NXUHwTfa2vioahhFEoBFr01Goo0atptpMug0FF7WP9Sba7+MCePBqOYuK6XYPsQHsIJ9zEVSV2N
 LQ+s/WFgqGaCO40V4KiKxLhy7v/6xoV/AEyDbbY5AzjrDGwcTwA629GsS0SfV91WPJGluQ6bNxJ
 0lEqrcQalLDXoAh5klA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a9125aa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Me7h5qUP0d1xqhSAURgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX9kb4q1Ja3XLK
 iYF8Rt+ncR7uFvWxSnGr4aySLJQccRg+k119F65N+EY7SKaiP6m5rgl3SKmUj2ufe4hYU4lyxaU
 PY0AE0aJV/+OBQ8eJaPU+b5AzNX7fe8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

On POWER systems, the host CPU may run in a compatibility mode (e.g.,
a Power11 processor operating in Power10 compatibility mode). When
running nested KVM guests, QEMU currently derives the host CPU type
using mfpvr(), which reflects the physical processor version. This can
result in a mismatch between the CPU model used by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures
such as "KVM-NESTEDv2: couldn't set guest wide elements".

Update kvm_ppc_get_host_cpu_class() to check if the host is running in
a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
use the compatibility PVR instead of the raw hardware PVR when selecting
the CPU model. This ensures that QEMU selects a CPU model consistent
with the host compatibility mode, allowing nested guests to boot
correctly.

The guard uses #if defined(TARGET_PPC64) to prevent build breakage on
ppc32 targets where the POWER9/10/11 PVR constants are not defined.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260812170854.58709-4-amachhiw@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d4c5601a00..8e89a6c665 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2682,6 +2682,15 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     uint32_t host_pvr = mfpvr();
     PowerPCCPUClass *pvr_pcc;
 
+#if defined(TARGET_PPC64)
+    uint32_t compat_host_pvr;
+
+    compat_host_pvr = kvm_ppc_host_compat_pvr();
+    if (compat_host_pvr) {
+        host_pvr = compat_host_pvr;
+    }
+#endif /* TARGET_PPC64 */
+
     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
     if (pvr_pcc == NULL) {
         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
-- 
2.52.0


