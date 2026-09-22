Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1B4C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96w2-0000jT-US; Tue, 22 Sep 2026 16:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tv-000827-Cs; Tue, 22 Sep 2026 16:15:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tr-0007fn-AL; Tue, 22 Sep 2026 16:15:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI78RI1128992; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OJpxIhHsMztPzQL0e
 Ep1scuj7rvJmb5nCDOVz/uqYzs=; b=q5la7R+dWWQ/stGGDf7u+ptD2JtNrIFIL
 izd0CQsE/MnO6AsHsqxI910SkmD3FY9Xxch4sX2vV/yhJkw5qZoOP8sCBPWWa99H
 M2AXv1RxN5pCXi/0Us1UoU0F0TyUqzFf+CjVX+gGkrGBYRGAjjYzdRVHGi5qprDZ
 bOUJK9gT23LW8ATfbOBlBxq2DCnouR8zZVbBGjQzMsTcJQHMBTg0Vnhehe7s6uXg
 YkADKAE3OpBeGnS2kSk+oBiwIvyJCKAoSHc43gDS5p83lHk/8Xyu8ifSFC8GhQxh
 ybA5O1UeTyZzaJvmM333NBtXX9j3EBm3FqZRbnRhNDhUhvcC8R+gA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs7sf0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHWFw3198560; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjuba0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFRGh53477766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 953842004B;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77BA020043;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 60B2A1614F9; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 2/9] virtio-ccw: Do not overwrite existing indicators
Date: Tue, 22 Sep 2026 22:15:18 +0200
Message-ID: <20260922201526.2383047-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=smRGcg3zAD8wOz9YheIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: r59wVxL6v1uan8OLa4CD0ZFDA9MU0uRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX35IO7cD4t38Z
 cE292Z86X5nnQV4UPgKbCdblaSi4eoIqOPaDgtpxTglsKPJijaoGcVyBs1D1g/Vc7stAWhsGWYA
 BkGkmxcFda598gVcO+O3dLXgdiLXMIoMMbKGdo6MM+RR65E9QArWPowWSa+gfa5YeVtggRwmiyZ
 2i1ggt/L/Sh/C//SnNES049OYIqZl9sq+hDVeFxSAGhEER5ycayMhgW112QUc+ta0w05JzaEvra
 JRliWkdPE8L9v+A9sMNu2jzR+nTMxnunjD/wYVBOGGhvf1fQtnC3c2VQhSxWxVLxmy96uRvUH7q
 jvFRIdzUiI4xFPdtzGIGHEs7Go9h+YJHeRQpnCB0p5ddKhBTkgz2X0vF10CS2CNuZCHgWFPZS6x
 5OaoXIAE0+s7v9nmHrYKokahFNsmQE6f6ZTv5fehw5JVqDRBPLFWGZwEoqnOiPK+vCI5u5ijNUQ
 A9JZPvxRiMMj6Poye0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX6TGLOlKlUxN1
 khWI5gE2RpfVWUY81TIlK5YRaDHX6TnT+CEEqZP7mvmx2gPeAO2P/NnyRg/eFFt2LP3++PdIhTW
 o75uFxxYEpkIjCM0r2s+5KVSIQBiBTc=
X-Proofpoint-GUID: r59wVxL6v1uan8OLa4CD0ZFDA9MU0uRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
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

The various indicators pointers allow them to be overwritten,
but leak any existing structs that might be there. If indicators
exist, ensure that they are released before setting the new ones.

Both the regular and adapter interrupt paths check that they
aren't being asked to enable interrupts when the other one is
enabled, so just do this release once all the potential checks
are completed.

Cc: qemu-stable@nongnu.org
Fixes: 7bca3892cb ("s390x/virtio-ccw: reference-counted indicators")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


