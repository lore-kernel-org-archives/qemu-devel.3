Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF79CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4eI-0007t8-6d; Fri, 26 Jun 2026 07:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wd4e5-0007nU-Tm; Fri, 26 Jun 2026 07:22:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wd4e4-0008Ip-8F; Fri, 26 Jun 2026 07:22:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QAIZbi2920256; Fri, 26 Jun 2026 11:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gZtEeLQL5njc0fX7x
 qlvS2jvVa7K3KKgWaqkYfD/GhY=; b=Ovqd17uQPEuAYiBj/7DlLjNHeCm7oR5OO
 2NC+MXxK6S136iuH4YnZx1j23WxjS81Y6SxM5FcTFO994OedJfJ9hbZg6ftoLKEC
 5g7yME6hNBh3R1PUqgaPN6rD0Hv/BNv85Buu7sRXj1JrlwSgeJJ31rvrAkwwqPT3
 NRgNG60hdeJ3tmJqUUfjCqnD0qZ/+iePs2tGuajsbn2VpbQVPutTvr8p74jklb2b
 ADpRC54hO81JPQoYuTvYL6QuRIKwBIvqTPv41ATXl3xr8mqfiAtx6bG4FAdHd5eE
 KTwmPVup6HTq9I0wLpZdN0UET5ZiCC0BLFClGPKmTfjmo5nbLFrGw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr6kcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 11:22:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QBJxtE029523;
 Fri, 26 Jun 2026 11:22:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qu1wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 11:22:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65QBMjEf53477800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2026 11:22:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AFA52004D;
 Fri, 26 Jun 2026 11:22:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90ACB2004B;
 Fri, 26 Jun 2026 11:22:43 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2026 11:22:43 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivangu@linux.ibm.com
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v2 1/2] ppc/pnv: avoid regenerating DTB if external DTB is
 present
Date: Fri, 26 Jun 2026 16:52:38 +0530
Message-ID: <20260626112239.177191-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112239.177191-1-shivangu@linux.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260626112239.177191-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3e610a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6hYU8IMl6WZeLP_gbRQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX2H7VE7sqROBL
 P3Xio7/9GsoHcWqvV69guko0QZXEDUBpQo0RFwg0sx5GykHWghOiWjArzMRtBPZnYkbssVOu2+6
 IzYmBbdw2/0wCdcB4IENmAeEWRguDXsNqxhM5IVDtngAeBoU6O3kbmhX1tueF7QIEpYvzPguI28
 yKryGGq1JUxIiiGdVzgC24rQ03hQRZCAz9CSY3vDeZ5yEFBiq3tpBRCmoM7qtvJCWzELVG3kD9C
 vO381xVC3pAPbQWgicOMhKIeZHac/+HMAdqB3808BTxqJndPzP5rrvt+km0k+iApTRJ0C5oqQsx
 1jCpVT0Mo4ofobZLU6dtW4lp/wubrGLqj3jYI7tDaIguHDyPvQqVnc7xUFRjSCWPovZBGd3FMMX
 9hAddSHNyP0yzOvyNq/bgJDnPrV1x/C+BrVOmvAnvCyDSd+Jm03qsuL4FLBqPGAgq9YMUJcsRVy
 T+kMChyBD5yGUCcVfYA==
X-Proofpoint-GUID: rDp6sVxW-i93yjCu3GvV_yL_Zg_Q1Hyz
X-Proofpoint-ORIG-GUID: QTTCq8sfE2wuiMImuPfAox5DJtHP9P5V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfXzqpA44R1OC+t
 OhsdOrZzgqZ99sz1OuJ2+GmZlo+u8ENs48l/pUsSy4YbYBEVELzjaaEEd9EpT3y8fb3/vn0aqWM
 aO98XUFT+ouykT902stchmAM5f/iaBw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260092
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Currently externally provided dtb is overwritten in `pnv_reset`.
Fix this by only creating dtb if not provided from `-dtb`.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/pnv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 62812f22f8..e44fb7e2dc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -803,9 +803,13 @@ static void pnv_reset(MachineState *machine, ResetType type)
         mpipl_write_succeeded = do_mpipl_write(pnv);
     }
 
-    /* Regenerate device tree */
-    fdt = pnv_dt_create(machine);
-    _FDT((fdt_pack(fdt)));
+    /* Only create new dt if not provided in -dtb */
+	if (!machine->dtb) {
+		fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(fdt)));
+	} else {
+	    fdt = machine->fdt;
+	}
 
     /*
      * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
-- 
2.54.0


