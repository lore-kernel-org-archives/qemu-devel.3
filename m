Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E0BC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izL-0005ND-HX; Mon, 21 Sep 2026 14:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz5-0005Gj-8s; Mon, 21 Sep 2026 14:43:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-0005zk-4S; Mon, 21 Sep 2026 14:43:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8iii1903397; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=myPHJlndDveNHp5qe
 iGr3JnoVZa/YmVzGHgnnObBFos=; b=Pa5hN7t8AHf6AYkU3cvuurUDGS0e13dwc
 Y4A6sWrnvT4B0MHevEBy34POTZhpMvCvSPWiShDIIbMrzOW9A0vWw8bMsay85Dq6
 j7YLJi279q5U8KL+ySKDWEzOhGjx/+7gT1XtTQ1Z/Hb4keHp5wUIUWd6aYlNB5KM
 Wy1RdsaLLZg5tBujv8YvqaAmvnyjqumfgtAQmnaWdc5NrKQE97TCXDn5XAbXvtmC
 QYoEFZn5o2seCxmE0Ii1n+qHBOsVs9cMp23S3NEF5W3yrYRCDgb+BTNi45ApsP1E
 nrQNdDcBr76sRfyKdTO5pHK+KLPf0XwhK5vWnA5rey4ycumQppsaA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv21ss-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHkav167221; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk96ac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9do44892644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFFCA2004F;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE2322004D;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 74619162365; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 7/9] hw/intc/s390x: Fix check after g_try_realloc
Date: Mon, 21 Sep 2026 20:43:03 +0200
Message-ID: <20260921184305.3791311-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e8glU5yBvrWkuFRrNeb8jXzNDHhgITyF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX831kSQZRe7TR
 Q+8k5O7+ffJ85v0Gt2RMlqgkJpsV6/BVNob4bp2pNm+lS6Zj72/HhYTawW9uMr5QBToIrIHqaaE
 Tho4iq6h8MYsnpaSERGKY8QPwkeoE7M=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=M8FnGKaJMcETolB0Q_gA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: e8glU5yBvrWkuFRrNeb8jXzNDHhgITyF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfXzksffGJCN9ty
 Sxw+RQbSyYSZ7bXhuCTKNHvuU6j9fzcuslq5o7th8arZfxp2nmHpA+KuWOOS0eiBSGNMaYMBr0Z
 8K1vvEVodOIDc+nLkIrZnw/wQ219aUI4Gl3cD998Ru5Wxr0+gEvm+lmURd+k2zJ2SZ/NRZKx3Be
 DjLiEtcoKKFUBcX7Stmkqm697bdP1LztY+Q0tc8lYatWZ/FII9PzhDv3g1TH4x44Dj4vdQoUTK5
 smwd8VZlN8BoIsbtOOdLIRrMaQfQMWVxIq375MgGQyy5peNZkvP/RePsfQgV5yqgQgETL1NbcR8
 qd5yHQCDBl4YwlkI1sBplM1VNK9uVekYon8nGYJwX5rsL8NKIwwYwO4OdtU2mNcgzy7kMhH270N
 Hqss/SMopgfRr9AyIVmA7eIPoiP+uFCejuIG9TeslIcVFk4IbRS52lBoXBVXhs9Yv1Jpv36RJyC
 J0gJk4H76GbtEy8Fz2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210272
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

The loop to store pending IRQs uses g_try_realloc() to expand the
buffer being used, but the returned address is stored in a
pointer-to-pointer, thus the check is supposed to be examining
the contents of the pointer, and not the pointer itself.

Define a temporary variable to catch and test the returned pointer.
If it's NULL, return to the caller to perform the free on the
unmodified buffer. If it's not NULL, store it in the caller's
pointer and restart the loop against the new struct.

Cc: qemu-stable@nongnu.org
Fixes: 3a553fc658 ("s390x/kvm: implement floating-interrupt controller de=
vice")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 5e6d422fba..ebee6bca9c 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -254,6 +254,7 @@ static int __get_all_irqs(KVMS390FLICState *flic,
                           void **buf, int len)
 {
     int r;
+    void *realloc =3D NULL;
=20
     do {
         /* returns -ENOMEM if buffer is too small and number
@@ -263,10 +264,11 @@ static int __get_all_irqs(KVMS390FLICState *flic,
             break;
         }
         len *=3D 2;
-        *buf =3D g_try_realloc(*buf, len);
-        if (!buf) {
+        realloc =3D g_try_realloc(*buf, len);
+        if (!realloc) {
             return -ENOMEM;
         }
+        *buf =3D realloc;
     } while (r =3D=3D -ENOMEM && len <=3D KVM_S390_FLIC_MAX_BUFFER);
=20
     return r;
--=20
2.53.0


