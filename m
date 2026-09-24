Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6104C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kdF-0003dv-K2; Thu, 24 Sep 2026 10:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcs-0003Sr-6v
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcq-0004Yj-FX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6PZr2183761; Thu, 24 Sep 2026 14:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yjbm6/FawI1nsNNe2
 hKmcyMUVhmwHSeqgUTV3xKC+DQ=; b=Ee/i6ASuTBal4mJBeGr00FQ3Ke3M2mveg
 To29PXXjnKv4IbRXVdpq8iy6HkespPmibF/9dxyqIaiH/VbUizRyOHta6xNytt/m
 pNT7HUXBWLQIJdjVABu55TcSkIpfBH2WXrMarSPxg+e87us0S8MMQOMVKZq3cR+i
 L2tY3DlSDGXEHc0AUKfruc+9OWDPGxlm30h9faMHUAxn75WVjW8RLc2ds4rt7jLN
 6Zmlaay3TH5NOLiumVcm6I6uW3/nN+/6iVWuxCQ6lNUxOap+6Qvo4GFVZi+vCDmX
 g/86Kh9/ucF8P/vbQ0uObKdWln3URl8bdcb8o8xxiehSsnTJZllhA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgshp2e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENglZ2243977; Thu, 24 Sep 2026 14:40:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qp9uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEebfx2949664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C1505805C;
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A16A5805B;
 Thu, 24 Sep 2026 14:40:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:36 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 08/10] hw/tpm: crb: Implement tpm_ppi_uninit and use it in
 tpm_crb_unrealize
Date: Thu, 24 Sep 2026 10:40:24 -0400
Message-ID: <20260924144026.953360-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab53666 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=RjRD9IDzg1SnJ7wAG4QA:9
X-Proofpoint-ORIG-GUID: KT11DOQBvX4yatz3lLyv2jwIQHzz_Nbq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX0RDzmOfEddBo
 wbxNMHKs/PPGX8JxaLbDcpvyRtPtBTyOylIMBXUT+JdHUeEU4ouqQQrQ9GVrkK5Bg78SKE4LuPh
 Q+1Tt9LnFXGWFei9NSkD6i9BwXDdKudDj+SXV7xZh6YzDQQLwhcnvTBAvvewWcJemrLApYdgknJ
 IWkGucd+25MNM5laLKSvNJHQ5fHD3jKO6A0+cHuX3v1PmVT0aiUtVFUVgu8s6C96HX402gwZJTx
 6RrZgvm4IKWnYBV82kXYC0VbTJ+xWA2OMn4GcZIeTeRHuGfBoa/JPJfUH52ihqWrJt681EdfcyB
 s8stS8Afs1VsJXXCe3zImrRK8Xq2rDAwOFyq70UVzWF32GaC0tGk7Gcsdbq0evyIT1+MnqS07To
 k2v0fbtbG80RXglOjszS91Z2535mjal7h5pI+UF6CIQvLYoz5FlT6Ft0+QItIv5/Yg8Km+Op073
 UgWnadFasgXopUtFCeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX4j4IVPNHPwKF
 TdaTXSVIGHAG1k4JSxIR9z2jU09i4MRJArJZU/YJ4qWWOyVKY5UGCgPoxCUJTJMX0gmXYvqg5gN
 jKj2fbLnX3VCo78ig81HvJMJgA6My0U=
X-Proofpoint-GUID: ODe8j1cE95OasIj3k3wmO51uleau4TDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

Implement tpm_ppi_uninit and use it for proper teardown of the PPI in
tpm_crb_unrealize.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c |  3 +++
 hw/tpm/tpm_ppi.c | 10 ++++++++++
 hw/tpm/tpm_ppi.h | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 9a9677db6b..92d36608d0 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -16,6 +16,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qemu/memalign.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -529,6 +530,8 @@ static void tpm_crb_unrealize(DeviceState *dev)
     if (s->migration_blocker) {
         migrate_del_blocker(&s->migration_blocker);
     }
+
+    tpm_ppi_uninit(&s->ppi, get_system_memory(), OBJECT(s));
 }
 
 static void tpm_crb_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index f0c34291dc..35baa083f2 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -57,3 +57,13 @@ void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
 
     memory_region_add_subregion(m, addr, &tpmppi->ram);
 }
+
+void tpm_ppi_uninit(TPMPPI *tpmppi, MemoryRegion *m, Object *obj)
+{
+    memory_region_del_subregion(m, &tpmppi->ram);
+
+    vmstate_unregister_ram(&tpmppi->ram, DEVICE(obj));
+
+    qemu_vfree(tpmppi->buf);
+    tpmppi->buf = NULL;
+}
diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index 88f316ee95..c173889033 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -32,6 +32,16 @@ typedef struct TPMPPI {
 void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
                   hwaddr addr, Object *obj);
 
+/**
+ * tpm_ppi_uninit:
+ * @tpmppi: a TPMPPI
+ * @m: the address-space / MemoryRegion to use
+ * @obj: the owner object
+ *
+ * Function to unregister the TPM PPI region.
+ */
+void tpm_ppi_uninit(TPMPPI *tpmppi, MemoryRegion *m, Object *obj);
+
 /**
  * tpm_ppi_reset:
  * @tpmppi: a TPMPPI
-- 
2.55.0


