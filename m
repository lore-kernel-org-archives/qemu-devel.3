Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB00C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izR-0005RX-O1; Mon, 21 Sep 2026 14:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz4-0005Gh-UX; Mon, 21 Sep 2026 14:43:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-0005zo-6V; Mon, 21 Sep 2026 14:43:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8KCw1869578; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YIgt+wFGB90zMvBau
 /vkmDAdOiAVegqKmYg3wMbX3zM=; b=ds/X5GCLdr5t/kehEBW3SZ2HkccGQN0j6
 GLSSEgAJBjsv+kL4euYkAdo+9SbkfuU0DdJBx+e6AlYDg3aUwi0hecXjw2oN2ike
 6PoFe1eTn2Nttn6A72LzVxMKZEAYCqAQBQmOSg0kFVkmYtzxPRZG57biTbEOz5ab
 Cl4/Y9ybqPtTevrW39YdKFeDUEuf8OPsgw+e7INqaMr3KxJqCF88B5CkdFKr2zXs
 hf+H/fgyS8ROkVYKPgIPTbpcs2iv8YTTfS37FAb8Y90mGYWwP2ysDZQY27Ymjiwc
 IHEzpm1cAzT0n2I3s/PCszuEznbMr/u1M64zP7e4LXRh/2AlvTG5w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs2720-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHZXK1489517; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq6s2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9tN54460686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4FC22004B;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83FD520043;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 6A4A4161696; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 2/9] virtio-ccw: Do not overwrite existing indicators
Date: Mon, 21 Sep 2026 20:42:58 +0200
Message-ID: <20260921184305.3791311-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=smRGcg3zAD8wOz9YheIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: L8bmJPwV05lmYm7AEIdL8ZycHQtTEMHv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX7W2BYH0HSivU
 chOMGxGQAktyh6Ozi/dqdV8SqHyJWVWTHc5NPFgtjx3rQW4nMXNxpKdYrZUOFSubDH731GR3FnH
 ReiTBp/n/qjWfr4YYjYBRkyDP0deVAM1gSDG0f+MNfj6DlXWPHdZGR7m5g30hU1jj4whSlFYpXc
 r7pUBGDbu7tBbBLHT+rq79ci9pGcX2+LiZdAaBQUtO5LGecitaWXpvx01ENTED2/uGVm84FToCT
 xfRWil3CdlTiM92toSlLIAgTVLE/iCQ33rBruYFRG6sHKbZyGEwvgTVurDVheoz+e1O/oSXGhvo
 2AIwwbq+O+YWzQwoblWQ/Fvr5Zs3oMrUKZkl51Nz3XzfnWfhoK3/eyW4htnXMn51FxZIRoMKidN
 i5uUwIdomoWWfHIUaPFzM32I3H0MxH2p5N8aldm34Bm91/DvhIhgwM/62HMRrbAWn/6aokiKQrK
 dGNrWn5MgaBxWNVYV8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfXy5k9GeRUrdxb
 +8LWLt4IY+jfOTm/IbMeR+WWi2ZW7VpMIIngSgWEzR4DJ3f3PXQuiyPqLz1O06KW6kOO7tN+QTl
 ZObMmOOeBr0lgzOjI9PRYGyrMqTAv8k=
X-Proofpoint-GUID: L8bmJPwV05lmYm7AEIdL8ZycHQtTEMHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
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

The various indicators pointers allow them to be overwritten,
but leak any existing structs that might be there. If indicators
exist, ensure that they are released before setting the new ones.

Both the regular and adapter interrupt paths check that they
aren't being asked to enable interrupts when the other one is
enabled, so just do this release once all the potential checks
are completed.

Cc: qemu-stable@nongnu.org
Fixes: 7bca3892cb ("s390x/virtio-ccw: reference-counted indicators")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index eb6378ea4c..f46f936150 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -582,6 +582,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ret) {
                 break;
             }
+            if (dev->indicators) {
+                /* Need to remove existing indicators first */
+                release_indicator(&dev->routes.adapter, dev->indicators)=
;
+                dev->indicators =3D NULL;
+            }
             indicators =3D be64_to_cpu(indicators);
             dev->indicators =3D get_indicator(indicators, sizeof(uint64_=
t));
             sch->curr_status.scsw.count =3D ccw.count - sizeof(indicator=
s);
@@ -606,6 +611,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ret) {
                 break;
             }
+            if (dev->indicators2) {
+                /* Need to remove existing indicators first */
+                release_indicator(&dev->routes.adapter, dev->indicators2=
);
+                dev->indicators2 =3D NULL;
+            }
             indicators =3D be64_to_cpu(indicators);
             dev->indicators2 =3D get_indicator(indicators, sizeof(uint64=
_t));
             sch->curr_status.scsw.count =3D ccw.count - sizeof(indicator=
s);
@@ -666,6 +676,17 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             } else if (thinint.isc > MAX_ISC) {
                 ret =3D -ENOSYS;
             } else {
+                if (dev->indicators) {
+                    /* Need to remove existing indicators first */
+                    release_indicator(&dev->routes.adapter, dev->indicat=
ors);
+                    dev->indicators =3D NULL;
+                }
+                if (dev->summary_indicator) {
+                    /* Need to remove existing indicators first */
+                    release_indicator(&dev->routes.adapter,
+                                      dev->summary_indicator);
+                    dev->summary_indicator =3D NULL;
+                }
                 thinint.ind_bit =3D be64_to_cpu(thinint.ind_bit);
                 thinint.summary_indicator =3D
                     be64_to_cpu(thinint.summary_indicator);
--=20
2.53.0


