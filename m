Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11647CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAe-0008KO-Ja; Wed, 30 Sep 2026 11:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAb-0008Fo-7Q; Wed, 30 Sep 2026 11:24:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAZ-000211-4W; Wed, 30 Sep 2026 11:24:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5kiL3166822; Wed, 30 Sep 2026 15:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wet4OO4d/HR4Tc2ld
 cwnIQ7jNnxrHl024LLW2HWoLy4=; b=OLmPhqXCfU1qISjGd03A28I7SmAchzmdP
 ArMUzxPm0ttc1UW9zJpKbeZI6PhWVSe5Xg3iMD2YyiRxl51a60GOyYYcOyG/klFP
 UMAdd6ps74b9EO+Copgf+a9NzCP7TcdzI1cac9pZ8CDx7yBW8uETU8EbUqNWJH50
 ACigdCJQcaFEziX6hxF5qMZhRYXfzll06G92Bt/of2WoonDTgw+NPZDl2vJ8fAz/
 LaUbLQxMzWMRI02hEFyZa2NQczRyfhrK9lE7c1GSfeLwaPyC873pneUNlUYZxBBJ
 6iXCQEe+lQ2QTKmykAY6ARb6MkE5ffXxg7UMrwV1Ze2eQy/hMxG1Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptcv96-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEHve33569216; Wed, 30 Sep 2026 15:24:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9n2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFORs436438752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9373558066;
 Wed, 30 Sep 2026 15:24:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F6735805F;
 Wed, 30 Sep 2026 15:24:27 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:26 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 10/23] s390x: Expose pv attribute in QOM
Date: Wed, 30 Sep 2026 11:24:07 -0400
Message-ID: <20260930152420.1956230-11-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wqt_xrq6ti1FJ7kZCoZl0Z3VNAXrYGhx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXyO0j+H6ey7Uy
 sOmkAqyjOXvxQIBYgXVIYXwqW8bNufXxtoUteM/Jcj6DskODXOxzbUOt2XX27jBS7649WpNTFm7
 C/etlpaxztPGW0hlNvsLQrA8Jyxj24E3jV8tWbunT//A66j4ROwMzMZv9aNhlQd9xh93QCo0lp0
 W8nVPYn206luQuKg5yInXAUyKL9fM0PcJezmUhy3e6ciZ+NLyn5Y/0G3rdO/Lt9HRo4r17VEOzX
 vweJBSF6mBNKMNwEmTrvsZY/eDvgLePpUknLAZhFdjAUrVKyVB31Tyf8yovAw8tb8Ec0c0hq+sy
 DdtBzJhkruK8Drs/dtviVJiUeYBJz5QsvXPsEXLH9ApgibMn6hYKBU6MIqbIGP/4eV2GG5+QYyl
 hzQxd+sxiIwPGKk7s1KakFbcXwXM7oZI1/2i03s/7RakERWXO2AIngwVzAGi2ep16ranZrbsqdd
 y5xCrI5t2U9YP4S4N1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX5pA1Uhljgj7z
 awlRSpbvaNWX5UJ5vmfrjcCda3VLcR5FnT/7OWcOaZa/25GjXvx126MXiX10ttx1w2/chRfnk3S
 e2HggzKWYt6pku0g44L+cvwZkUizddw=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd29ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PPDVIYp6hs0TuBwBTBUA:9
X-Proofpoint-GUID: wqt_xrq6ti1FJ7kZCoZl0Z3VNAXrYGhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Janosch Frank <frankja@linux.ibm.com>

People doing VM management requested a way to query if a VM is in PV
or not. So this patch exposes the runtime PV attribute which is true
once the VM successfully made the switch into PV mode (according to
KVM) and did not yet reboot to drop out of it.

This of course does never replace attestation, it's merely QEMU's view
of the situation.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
CC: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260924142846.157848-1-frankja@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 docs/system/s390x/protvirt.rst | 11 +++++++++++
 hw/s390x/s390-virtio-ccw.c     | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/docs/system/s390x/protvirt.rst b/docs/system/s390x/protvirt.rst
index aee63ed7ec..7e6c6e10f4 100644
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
+property. This property is true if a guest successfully made the
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
2.55.0


