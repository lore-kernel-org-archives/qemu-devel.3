Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2472FC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vC-0008O2-7C; Tue, 22 Sep 2026 16:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tv-000826-AA; Tue, 22 Sep 2026 16:15:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tr-0007fw-64; Tue, 22 Sep 2026 16:15:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7HKo1129652; Tue, 22 Sep 2026 20:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JMdkwqD9Zszzk7iBT
 rGR4/pIMvEXuGW8BOWpT6++kFc=; b=QAkQaAPYjePZ25Wak7btQpNY0E6NH88nq
 yJ6WoyUsLsTnxl67/ryGsYjPF/ThTqhEDTtGmtnGNk4vPxM4RSE40sgGNnCjFhsH
 DprMEfFX0LobklIND/0R1GVfAouE10WlhfMk4CnjkA5GA5V5wIaiZJTMUaI/xuF0
 4//mXSsrd/y9wJk7ssDEaNKjlJ+k7cRgYjC4Xj+i7u0rveFxLabQqkfZMUDCRz4W
 5ixD90d4rh9//G86CkHkhMJzvdgxcDR1Hzt9aCJOH8uvl0k1ImkqFQZoKV+qfqP/
 S1cyURu62UrwteDmy6/4nKCD355+Y91xtoJxwwjLDhXFp+KQrC2Og==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ftqx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHY643220305; Tue, 22 Sep 2026 20:15:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vkdxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFR4J47972798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE3852004B;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A085D20049;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 6C7E716162C; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 7/9] hw/intc/s390x: Fix check after g_try_realloc
Date: Tue, 22 Sep 2026 22:15:23 +0200
Message-ID: <20260922201526.2383047-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 77atNcqF2nOwGP3xTj4upL2QDml00iEy
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=M8FnGKaJMcETolB0Q_gA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfXwg41jtBfXNmC
 R3dRpw06EJHD4SJnMmNDM4RHHi25cEXR9fLPX+UcpcfmQWejqSqtvDfzqgoAyl4qtglV6RjBL9H
 SDhWS/jtNTNs86q8QfGLl4229sX/Ju1UDUwNUWVjutUi1o2k3QVZX98Wit2fr3BbDID4YVYpM+1
 z0Gn3Qy2RA2u61mbUwLHBI+7nykeq1WFEKWo+A/ViIBC7/ym4bQFxYwx2njqWihIevS0rXWwWCQ
 PQOUU43m7UVhemIqRjwiR6Y1HzBjaEHGRrIIh+8hff43d76jGqGYQINHw3YlDuI6X/zw/im+ZYj
 ri3lCwFZQMFDOWy326oFsI33otxJVuHxEPZNTXsC7hgHwRMgbIcPSp9Dle68ur2N1kuWug+CIpI
 v3uNPrxcXAJIBZrP/Rdni3DefIpQLqZCjDEO6PfyDmURUUSdk4XDT4RWkxYRi158QxHmTjkU9yl
 YWPwIqxeXYKryklGtTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX0BRwt/2ul0be
 G48gh4yKcw8sJFy/0DOPi7KY/PVOO0syqb5njDoW0BC55yCffaOKMrTc7pq8Cnlz5fxFmcYV2Iq
 LkKFJILj92Lan0F7UAwIOiXExuXOG2g=
X-Proofpoint-GUID: 77atNcqF2nOwGP3xTj4upL2QDml00iEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220293
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 5e6d422fba..63c6ce81d9 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -254,6 +254,7 @@ static int __get_all_irqs(KVMS390FLICState *flic,
                           void **buf, int len)
 {
     int r;
+    void *new_buf =3D NULL;
=20
     do {
         /* returns -ENOMEM if buffer is too small and number
@@ -263,10 +264,11 @@ static int __get_all_irqs(KVMS390FLICState *flic,
             break;
         }
         len *=3D 2;
-        *buf =3D g_try_realloc(*buf, len);
-        if (!buf) {
+        new_buf =3D g_try_realloc(*buf, len);
+        if (!new_buf) {
             return -ENOMEM;
         }
+        *buf =3D new_buf;
     } while (r =3D=3D -ENOMEM && len <=3D KVM_S390_FLIC_MAX_BUFFER);
=20
     return r;
--=20
2.53.0


