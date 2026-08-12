Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39C3C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCSY-0007bk-Gy; Wed, 12 Aug 2026 13:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuCSK-0007ZA-GH; Wed, 12 Aug 2026 13:09:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuCSI-0007GR-Uj; Wed, 12 Aug 2026 13:09:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1gc14120485; Wed, 12 Aug 2026 17:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/T0WS4SIkRcrSpUP3
 8rfnpqeUflQc+kavwNr8Od2Nz0=; b=pZPthJsTxBsHvjvlLdEwhla1ZjYw+WQcc
 BfPXOKTn/BdpkK7mh1ixZkLk8Gx6vkm4QtN/YFeHckJgXWNy86pr5yfP9X9/64m7
 H2uvpWGPIcjbLr6dYXIohMBCK8K/88VSn01Oja7cU4lh9IFswK2HAN8AkzlG0t1v
 bAxd1nc6q2Laf223qG8qCwH6efvJmPvadTiNbR75NiOxfI0j1/u3gEctWKG1DOZM
 05Rn4NYAsQTJfSzLY+A6suQlP6+qWARtqd2tqPVUhpZVvrJYZC5SHOfVNDaA8vG1
 l2UJucgMYTFKrgGsHLzjsJ6Vxfwdbyq5LKuKQncU91uY9cDvtbExA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwau7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:09:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGuiXW021425;
 Wed, 12 Aug 2026 17:09:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w7737-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:09:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CH9M7L39780808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:09:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA3D22004B;
 Wed, 12 Aug 2026 17:09:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C71AC20043;
 Wed, 12 Aug 2026 17:09:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.117])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:09:19 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v6 3/3] target/ppc/kvm: Use host compatibility mode for nested
 guests
Date: Wed, 12 Aug 2026 22:38:54 +0530
Message-ID: <20260812170854.58709-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812170854.58709-1-amachhiw@linux.ibm.com>
References: <20260812170854.58709-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ca8c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Me7h5qUP0d1xqhSAURgA:9
X-Proofpoint-GUID: POFFskJEaacGD-eMMRNz_daIFFDQU6lS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX3xWsDl1nBKkO
 Jk4eT2mcHqrxW1rI89QcBmxYpl6h98fjI5MsuG7LExf6LrvM2k3OubRzeFtGlLrSmycgjcf7OV+
 gWjjk/6RCCsIiLlWhgTEXI2EgL3Q+X0esmFwKr0CF2jO3MVAqVKI8CaXuiF/IiIGJGbhVtYEJTd
 mcMFPUooYBTy+x1IRGYPhNunzYflxHNu6EXjJKZMSeU9J7hVVIpIFzQa/Fj0DQuAa1mcHhpxY9d
 zu5vEdTukDloFZpDj8iAin5jeYwRXL+BECmZhAoI6Tk24c0aTKO3KLlfG92mfgEB6EROQa5N0O0
 8yGnQKRiS5rLmYLb0RdK/WyeI1X8Ex7lvcjFF0hBAEVmSuuNyyRbTNm0yTNzzE2rp0ivLIqJNjw
 Dvuiv4ut9WZVjI1cC31wg55As/fYnCz+pDckqxxyLHomGf3zyEH+DaMLY0P2qEiLalz7nj3GuQT
 wLxw2ui3Y9hVRp/pK7w==
X-Proofpoint-ORIG-GUID: 7rrctBy4iANJzvQ_y_zWgh8zsvcpYO83
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX2cC9uLqWgZKp
 suKLq+2e7O3nu7iM5airvENgl7bBbDYVIvVroTa3R39eyzhv6AVnC3o82mqYYdcH8G+yyfSLoqm
 SngjPvPQ3JfVygh1xDYXImpZQ1jErh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
---
Changes in this version:
- Drop redundant #ifndef CONFIG_KVM / #error guard; kvm.c is only
  compiled when CONFIG_KVM is set (enforced by meson.build), so the
  check can never fire [BALATON]

 target/ppc/kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d4c5601a00c4..8e89a6c665c8 100644
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
2.50.1 (Apple Git-155)


