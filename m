Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299E6CD1297
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIKfb-00038b-0x; Thu, 30 Apr 2026 02:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wIKf6-0002yq-Ub; Thu, 30 Apr 2026 02:14:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wIKf3-0006It-SF; Thu, 30 Apr 2026 02:14:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TLdf9P3991826; Thu, 30 Apr 2026 06:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pwvZmbPinPYK/5tr/
 2XxXcOE/ztPQAaOmkWyg9wPbVs=; b=K6MGg4aUQLqHZcocgX5eeIgL8e1UJnAmP
 VhLlOJdbTbHGAEAyVp0P0brjwROZw4+Giz8Zjveu4msnySf7/LnK/5bpOch3fNzT
 Xo5/1V6WirKem/alabR+Ez6RoiHOy9YHXuT5Tk4X3MH+azpc7MwIExyJVhfKQmvX
 Ik4XNpAOC+wMm7cq2N+y/w8BdYkwODCLVdFyvzLXiQm5lKFSdBDvxreeoiwrLaAu
 oJjQ9z1rpQuj239FZ8OjPA5b2E7lMeXqZ51T0BZ6+0V0SLVP3rCOVD/meJSeq5Fz
 500LADSdJxvM1sEErpHazb+UVuEUjmZQwsdauWTE/l6rbMgapbo+g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44xa4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 06:14:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U6CXZ4012526;
 Thu, 30 Apr 2026 06:14:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyhegr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 06:14:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63U6E2ru38076916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 06:14:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DCB220040;
 Thu, 30 Apr 2026 06:14:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B0092004B;
 Thu, 30 Apr 2026 06:13:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 06:13:58 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/ppc/kvm: Use host compatibility mode for nested
 guests
Date: Thu, 30 Apr 2026 11:43:33 +0530
Message-ID: <20260430061333.37905-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430061333.37905-1-amachhiw@linux.ibm.com>
References: <20260430061333.37905-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 37BV_D4pjXUlBrr9ACtUqSoOhBmvl7xK
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f2f32f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=n0kojfgqO0W5ScNLDTQA:9
X-Proofpoint-GUID: KD8zVK0cpXIPWATTqo3jZEvkAG5AhY6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX3+IK9R9bvGx5
 uj2BbKjZaE5F+yB3rBVD1fAWgJx8gwNbvYEJia02F1/utDin8YkizWL2p1MhaCVy9udvRWukhz0
 r9lSQlsuV4UsXSakK0zLErSDCn58n5CgReVvgaRFi7UqUVyDcwZ0MN5INLHBFrdjawKJ19T8R1P
 HdPeqcJKfj0bmFvJOjcUoZzhiljHlXq65Ohf8MQXCGJ/q3PhxhV13JnBmGyLIWY4xabzzMZ9dBF
 7yfqZo7K//QlfcukUM1JOoRHexM7a1dozIGvTbBmjJIMgRbEy45EU3bue2PkuXMv3b79ZMp5zt8
 nhlcCMSioe20othfZslK51T8dXJowgXD4Te/KLh8iPe2IeI0wA0tBcIGR13nE6H0RaWzQjPfQWd
 Xzz6VYzzwcS6pe24mF/CpG0XylHWh7T8spgpsfZ3gsgTc5YJKZf0oVEyl2dHCbW0+6L1QhWkl4X
 n9GlxNdZKQnlhaBG8mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On POWER systems, the host CPU may run in a compatibility mode (e.g.,
a Power11 processor operating in Power10 compatibility mode). In such
cases, the effective CPU level exposed to guests differs from the
physical processor generation.

When running nested KVM guests, QEMU currently derives the host CPU type
using mfpvr(), which reflects the physical processor version. This can
result in a mismatch between the CPU model used by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures.

In particular, booting a nested guest on a Power11 LPAR configured in
Power10 compatibility mode fails with errors such as:

  KVM-NESTEDv2: couldn't set guest wide elements

This occurs because QEMU selects a CPU model based on the physical
processor version, while the host operates in a lower compatibility
mode. As a result, KVM rejects the requested compatibility level during
guest initialization.

Add support for querying host compatibility capabilities via the
KVM_PPC_GET_COMPAT_CAPS ioctl and derive the effective PVR based on the
compatibility mode reported by KVM. When available, use this
compatibility PVR instead of the raw hardware PVR when selecting
the CPU model.

If the capability is not supported or the query fails, fall back to the
existing behavior.

This ensures that QEMU selects a CPU model consistent with the host
compatibility mode, allowing nested guests to boot correctly.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 target/ppc/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089c6..d384161f780b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2602,11 +2602,63 @@ bool kvmppc_supports_ail_3(void)
     return cap_ail_mode_3;
 }
 
+static target_ulong kvmppc_get_compat_caps(void)
+{
+    struct kvm_ppc_compat_caps host_compat;
+    target_ulong host_caps;
+    int ret;
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
+        return 0;
+    }
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
+    if (ret < 0) {
+        fprintf(stderr, "KVM: failed to get host capabilities\n");
+        return 0;
+    }
+
+    host_caps = host_compat.compat_capabilities;
+    return host_caps;
+}
+
+static uint32_t kvm_ppc_host_compat_pvr(void)
+{
+    uint32_t compat_host_pvr = 0;
+    int cap_idx = 0;
+    target_ulong host_caps = kvmppc_get_compat_caps();
+
+    if (host_caps) {
+        cap_idx = 63 - __builtin_ctzll(host_caps);
+        switch (cap_idx) {
+        case H_GUEST_CAP_P9_MODE_BMAP:
+            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
+            break;
+        case H_GUEST_CAP_P10_MODE_BMAP:
+            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
+            break;
+        case H_GUEST_CAP_P11_MODE_BMAP:
+            compat_host_pvr = CPU_POWERPC_POWER11_DD20;
+            break;
+        default:
+            break;
+        }
+    }
+
+    return compat_host_pvr;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
+    uint32_t compat_host_pvr;
     PowerPCCPUClass *pvr_pcc;
 
+    compat_host_pvr = kvm_ppc_host_compat_pvr();
+    if (compat_host_pvr) {
+        host_pvr = compat_host_pvr;
+    }
+
     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
     if (pvr_pcc == NULL) {
         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
-- 
2.50.1 (Apple Git-155)


