Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4468C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJm-0007he-5E; Wed, 16 Sep 2026 16:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJO-0007Zm-9b; Wed, 16 Sep 2026 16:33:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJK-00030o-Ri; Wed, 16 Sep 2026 16:32:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1lS2018176; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8AlmYIuwJaaZeD28Q
 GS35kIg0heTMAztLPpHIEvTag0=; b=IYJjphprNMTXMUQqaOtojItjV1JNN1v93
 Ex/ASuIOXpqmArzidMLl+UKr80m6b23PBUj5hMeYA8McNLT+C14KIVXLa/nxz2QQ
 c2x5iyzSzzQfW+7COXN+al49C1PDdE+xI0NA2wcNFMcSXQf1McDGA+n+879+1MlQ
 9Aa0vjvS/9KY90RAjEfBQQEfo+rvW1oXTH2+9IWRjnb60CBmWnEsjuwSJJ3Y2Xd5
 M4WCwQsWUMkwDbwXOmptUBs0cLX9CiK9aYsXStM7AaPG5KxTKDsnQoc7x+OUwcA4
 cPARIvDiNyV88mgRg4nLPQePoUidEJDB2x/2rp5mJtg8qgUf0rDBA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf56vtx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GJ1L131699576; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vgb06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWlXM37355794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0DFB20040;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C00AA2004E;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 87EC7161426; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 8/9] s390x/css: Expand check against no-data-count CCWs
Date: Wed, 16 Sep 2026 22:32:40 +0200
Message-ID: <20260916203242.2509787-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zr7kQ09Est50mcOQaN-ofI9fyAZzd3O4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfXxcgvXmz86A5P
 /9gvO5v7qvU5Jh0GGL7/DgOnB2ue0R838jrvP6fRzBNbpKefF90xDjyFkS/Hesn82Xp1EE5XVEn
 GX3kXw/Oe7dpdCuA6Vmb3oDsJlFnoXE=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=7sngsDgIDZXEPo7Uw5MA:9
 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: Zr7kQ09Est50mcOQaN-ofI9fyAZzd3O4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX9OR4KmjYBzdQ
 pH2jOocmekSpCXJhkIS7YxS6IMuGujDuV8mvcsBHaphlbuzsx+Ja4bR1b73piqaFdlpQmB+g53l
 +vVvY5sncbbnQYUYNwqXUh+oqXLkMV1b6fkbacs8FZMcZOXVWyfjEDW4CjISZyIkeePH0GHP5gB
 hsKvmbGzBHIp/3WQWCVsdfHw7W22TCxSCYiaGNj5Yi4W9akZuJ0DV7X2AFF4zKXSEEZJj9zll2H
 1y9lxeDEstekzabPaqQuBkhZe9adCb8CxvNQfJGteV0Ntnbppz4eMOBAWn6Yx8nlW8g7kWfLFMh
 wzoBpFT37/nnTP22GO5D/z5eBj/G5zn7tBXIAv8lqeqAc7Woy3MJx2uklwNdnJi8OcmaeVzuRkp
 U7Coiy9bcnt1Fvwwei4SJPU8JAVQB0/pPw6LGcNC5bm1cX/Ck56djn7jXES7SOT377O9Ou7utBD
 WKESKFMdJ1oKl3jYGmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160285
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

The channel subsystem will reject channel programs that incorporate
256 CCWs without a data transfer, but the existing check for this
does so against a data address of zero. Expand the check to include
other CCWs that are valid but would transfer no data.

Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 9da9128d88..c38549c7be 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1016,7 +1016,9 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr =
ccw_addr,
=20
     check_len =3D !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG=
_DC));
=20
-    if (!ccw.cda) {
+    if (!ccw.cda ||
+        (ccw.flags & CCW_FLAG_SKIP) ||
+        (ccw.cmd_code =3D=3D CCW_CMD_NOOP)) {
         if (sch->ccw_no_data_cnt =3D=3D 255) {
             return -EINVAL;
         }
--=20
2.53.0


