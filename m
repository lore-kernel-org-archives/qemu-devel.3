Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F133C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9hKZ-0001wV-O4; Thu, 24 Sep 2026 07:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x9hKX-0001wD-CK; Thu, 24 Sep 2026 07:09:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x9hKP-0005J0-7g; Thu, 24 Sep 2026 07:09:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5cEDd1342813; Thu, 24 Sep 2026 11:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=zh2O0KoFkGROsPr1U+xWmcDCNT5+z9HUnqgIZwBKn
 3c=; b=hOTjPt5SqXsPB7P3QNgt+OAfZ25JkfDlj9EqsWKegpQBz/V91G8eVxTEs
 0/g95e589VR4H4I4qP5FeCnY+FIRKFuLSpFVXStpQdHk2XMW6GR4x8JyPK+k9xbq
 NEr7uaqXE4t9SBL+cmB33HtmbXQvgWBmoQ/9fcxnnWoXlybc+TnKW4r1W9hEX1kw
 TAwc2oFOyx00r1VhoPgSIFM/VPXVuyhUCqNZyu4EoQnNA//CjXoHz4np1A1+3Q7E
 /5ibYj+wTvlDksahPWkUdodxw6U5FzZxyTuMAB0Kw0LnyF6BTLxyIrxQkPCPbOcq
 RbeBFTlXA99/OpphTncfzF/foBtXQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2rksu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 11:09:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OAIJBk1554965; Thu, 24 Sep 2026 11:09:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jwbxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 11:09:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OB9DBm50069902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 11:09:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6170E20043;
 Thu, 24 Sep 2026 11:09:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E4C020040;
 Thu, 24 Sep 2026 11:09:13 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 11:09:13 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, brueckner@linux.ibm.com, borntraeger@de.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, david@kernel.org,
 iii@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v2] s390x: Expose pv attribute in QOM
Date: Thu, 24 Sep 2026 11:09:03 +0000
Message-ID: <20260924110909.146831-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GGXL6wt5KPvHPxo9wsShqg5g1PHVi6_g
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab504e0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PPDVIYp6hs0TuBwBTBUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX90Obltd+q2Ij
 Qod284rhDX4MmX3HqZfbWZ7LwOh5DZ50BU8mzUT8sLP45tpjcfsZ8fOy98D4ramEhd6Iwf8gaJx
 eopVppwJvrzUkxPv72Re2sJ/ojTgSRmYWtYAVM/2L5CZEdKe/zOapW0qthlAdhEjSB+ppjrr0Vf
 qDjBDbaEzgocI9lcwDX8g4FFGANXfGzNpPnpOtpLLdnNIdauw/3dme0FrYZaxl636K90DNlI7Cf
 6KJL2FfOLenBBg7JdsmyINFq2okssxryZzbZkGFN8tfLxSitVgqqFLEFKyH+TnyyGv/BPixRQQ1
 KX6Nm0fxMS7TuEJznMkliuFBmnPBX5604L1fg1bKMpmgzE6OjDqS76Z3whkfYqLcOE6yJ+yrKDc
 uW3w+jKnS+ySB2lxUnFQKqj9GFJp9Lz2i8jRd6+Q3j/Mw0ES3SxYfYhSyR6hir7gSELc5oq38gR
 gngnxQIMUCR5Wzs7Y3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX9RQCGMjHWfbp
 X9banTY6wnzowrURwpgRK9Imwa0do7FswbEt7K+E3+pZ6S4bXYR2U7SONJOrndUNwAv4+BjrbYw
 Ar8/BTMO1spsquBpoOWbPojEL972V44=
X-Proofpoint-GUID: GGXL6wt5KPvHPxo9wsShqg5g1PHVi6_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240046
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
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

People doing VM management requested a way to query if a VM is in PV
or not. So this patch exposes the runtime PV atrribute which is true
once the VM sucessfully made the switch into PV mode (according to
KVM) and did not yet reboot to drop out of it.

This of course does never replace attestation, it's merely QEMU's view
of the situation.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
CC: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 docs/system/s390x/protvirt.rst | 11 +++++++++++
 hw/s390x/s390-virtio-ccw.c     | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/docs/system/s390x/protvirt.rst b/docs/system/s390x/protvirt.rst
index aee63ed7ec..f4d25b5ae3 100644
--- a/docs/system/s390x/protvirt.rst
+++ b/docs/system/s390x/protvirt.rst
@@ -65,3 +65,14 @@ metadata. In case this boot method is used, the command line
 options -initrd and -cmdline are ineffective. The preparation of a PVM
 image is done via the ``genprotimg`` tool from the s390-tools
 collection.
+
+
+PV property
+-----------
+
+The s390x-ccw machine exposes the read-only runtime "pv"
+property. This property is true if a guest sucessfully made the
+transition into PV mode as reported by KVM and hasn't yet exited PV
+mode via a reboot. This does not replace PV attestation which is the
+only authoritative way to get a definitive answer if a guest is truly
+protected.
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7fb78d8fa1..9e2db872fb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -838,6 +838,13 @@ static inline void machine_set_secure_boot(Object *obj, bool value,
     ms->secure_boot = value;
 }
 
+static inline bool machine_get_pv(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return ms->pv;
+}
+
  /*
   * S390x-specific global compatibility properties.
   *
@@ -919,6 +926,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
                                    machine_set_secure_boot);
     object_class_property_set_description(oc, "secure-boot",
             "enable/disable secure boot");
+
+    object_class_property_add_bool(oc, "pv",
+                                   machine_get_pv,
+                                   NULL);
+    object_class_property_set_description(oc, "pv",
+            "true while the guest runs in protected virtualization mode (read-only)");
 }
 
 static inline void s390_machine_initfn(Object *obj)
-- 
2.53.0


