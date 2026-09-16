Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2DDC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJh-0007e7-CR; Wed, 16 Sep 2026 16:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJP-0007Zo-5r; Wed, 16 Sep 2026 16:33:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJL-00030q-EA; Wed, 16 Sep 2026 16:32:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1dIi2330029; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Ycjpvrhm3Hk+/sjo2
 WGDZDV9uHNy/wRNVisP632dfzQ=; b=bKJeDx4GJwteV0YvEgwm6z1k/+2IQOqhJ
 wgrv+m/ztvaGLtg+eGe1aH86SpkMaYechJWQiI/OAv9ySDhZyrc+43YbUG8q15Eg
 hiaSrzKW+z9gvS+VUeMYCux75wOOt4dop9CU0r/xDTGShZF7qW0Vv4zpoBP50FRg
 Fht/iRAWeqhByIO7QePXQXyc5g5M6tiVeuuPju0ump3WXPjKIz7o9ISgy2gAzmFA
 3VTeXQqQeFVASWFW0it1f3c9ooKiuvP6Qjyb342LFd5u8+A4hbunAj/030EZ1vuH
 b+qRPhCLfjHqxCpSr4QKyd/jtW795dIJ5floYc7qsCQ1ps356Ge6A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqev64-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIvlvS2599802; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d8wg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWkXF43123058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA0B82004B;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9710D20043;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 7B590160EF5; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 2/9] virtio-ccw: Do not overwrite existing indicators
Date: Wed, 16 Sep 2026 22:32:34 +0200
Message-ID: <20260916203242.2509787-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX3h/V4513s43o
 YqyxIvfFGfP1azTb8htIPLRWZVdT2p1d/X0Y6N3JLc2rnx33NlHbG9pHHxUByJna3rHP87FqvMn
 dwjI24faeWTEjjTzn29lYR21+lOAPFxYsdzY0BdLWpBf5JkW/EhucTSVxeup08DoDu+ZvWOrQYB
 7VkgH/yAWZKG/IuL/So1PkhBxX3nUMw0/eh+KWcd41fSLDXh2d2tTztpVO/UkqtdZGTSSkNFZqW
 1Z5H/aoby5PFJ0ARvv11bnZEh/G1njyjiuxK1zXfjdrWmS7LCo9O2/ytO7GAa/vdicAhY/gU+is
 GojsgBztKIQc9r9evdNpm7NrBk5+EPZGA3pAFCdpN55Wf0vWihFykkz2p5Tcnga2R55ilL55pWt
 VQAfw+uT1DziMzWVpymk7sjnSENnLiyqjelHIEhcqYk4W4kOexj8diAKFtO3s5OtuyqzRqCd/h4
 QAaIBR6AIdB7FUoDymQ==
X-Proofpoint-GUID: M6cwLRoEuG3lBaSvBtweiO2PL0c9Jy7R
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=AcHJBQmbBjRtW04g4g8A:9
X-Proofpoint-ORIG-GUID: M6cwLRoEuG3lBaSvBtweiO2PL0c9Jy7R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX2hWj9zBZ4ZH0
 +CmjbydLnVzQRahAWokPuiZDDizjsyOsKvnHE7C/re5KOGMyYpvJ/ACUgAQqo9gIp2cH/kFs//Y
 hsidNPVCYHY23TNxG70cu9sIy4IQelE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160285
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
but leak any existing structs that might be there. The adapter
indicators path checks that it isn't converting from regular
to thin interrupts, but a check in the reverse direction isn't
performed.

Rather than unwinding the existing allocations to allow additional
assignments, just reject these duplicates.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index eb6378ea4c..d700db405b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -565,6 +565,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret =3D -EINVAL;
             break;
         }
+        if (dev->indicators) {
+            /* Do not set without un-setting first */
+            ret =3D -ENOSYS;
+            break;
+        }
         if (sch->thinint_active) {
             /* Trigger a command reject. */
             ret =3D -ENOSYS;
@@ -599,6 +604,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret =3D -EINVAL;
             break;
         }
+        if (dev->indicators2) {
+            /* Do not set without un-setting first */
+            ret =3D -ENOSYS;
+            break;
+        }
         if (!ccw.cda) {
             ret =3D -EFAULT;
         } else {
@@ -657,7 +667,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         }
         if (!ccw.cda) {
             ret =3D -EFAULT;
-        } else if (dev->indicators && !sch->thinint_active) {
+        } else if (dev->indicators || dev->summary_indicator) {
             /* Trigger a command reject. */
             ret =3D -ENOSYS;
         } else {
--=20
2.53.0


