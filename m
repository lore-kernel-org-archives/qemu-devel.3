Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB52BC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjbY-0002Dz-VT; Mon, 23 Jun 2025 12:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uTjbX-0002Di-AG; Mon, 23 Jun 2025 12:01:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uTjbS-0008Pn-1h; Mon, 23 Jun 2025 12:01:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCSgHQ010062;
 Mon, 23 Jun 2025 16:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=YQyAwunxVTuX5eKaJ3wRqp5N6b9YYU6DfX+yDnTe2
 b8=; b=jGR23HeHjOY4Qs6zsbsqus7UiNOfDi+ymT5kOu/xCUutPCxZUfhmNLUUg
 UY3CsSizVn6zhEGnuQLZlf5fZoFpQuq9wZXJ76B+PXiG0rxwM+jaCgebTOmaLMcP
 sOkOr2UN0UDcjW0uZuPm7OHgr+b3thMRWKQCe8lOTg83eCDRi9YMzGlhEc7beoNk
 xVOCqSiQEp90dsjnWEIoVbGV6pkmENJDJkIG/YBl6mWGNuidmiLSPa9a8UrfcKOc
 oL1Pi/68mKu5/lZ6JGLU73CBiQHAr8r511TrHfYPg6u2GPZSfiAxTa3PaNZvGfVz
 H1zxfBU9NOHdBgvmeC/4YS5T8WABA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfe38gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:00:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NETN5q003970;
 Mon, 23 Jun 2025 16:00:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kfcj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:00:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NG0VIc38732092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 16:00:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95B3158043;
 Mon, 23 Jun 2025 16:00:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C826D58055;
 Mon, 23 Jun 2025 16:00:30 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.76.9]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 16:00:30 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, alifm@linux.ibm.com, jjherne@linux.ibm.com,
 walling@linux.ibm.com, jrossi@linux.ibm.com, qemu-devel@nongnu.org,
 zycai@linux.ibm.com
Subject: [PATCH] MAINTAINERS: add reviewers for some s390 areas
Date: Mon, 23 Jun 2025 12:00:30 -0400
Message-ID: <20250623160030.98281-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YY10EJI32toimqkfjw8yxdBldcOo6Iqb
X-Proofpoint-GUID: YY10EJI32toimqkfjw8yxdBldcOo6Iqb
X-Authority-Analysis: v=2.4 cv=BpqdwZX5 c=1 sm=1 tr=0 ts=68597a22 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=L8W7Q735O7B5DeafBR4A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5NiBTYWx0ZWRfX5vLgDy+GHof4
 ReJsTGzAcz15S0vlPZNm33y9WRAdFH0/J/wLEEOdz7u0c7uOErVttDnEAnF/jgH36iQVz3Xqo4T
 xP/8DZcMQ0kaAmMaEk/ZGvH/jaoFcplLAAR3ISZV3uCF7HpaqOWfGDrYbh6GY3qTbmlodGVU2tt
 Ww5jvoE0z6ahO8mRyt0Ic3FMWHMb2F0jM3kclMScv5VWJlX4rLmJl7SyvO4bn1UQ8C0dgR/Ur1y
 BgS3psYdDQjWpTkwhbk7Orw5uiz0/c7DxS6NKmk7FeVo7Bm9APlnaXztvPZgH+/j4SKh+Cswg/O
 GBDr5npwLKw9hpa99Iqk1pGcFnTgw8OJyZYNsfyqIqhU06JWSXM7xPnPsUdr1S/y+AKs1dLT4UP
 SMnKqWjq7KlefSJBjsaEtB2O5ezf56O87VX+jQrqDfAPIW0KosPavIG8kfEWxq/XKUBrScaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230096
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To improve review coverage, assign additional people as reviewers for
multiple s390 sections.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94c4076127..3ce6fce8ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -459,6 +459,8 @@ F: target/ppc/kvm.c
 S390 KVM CPUs
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Eric Farman <farman@linux.ibm.com>
+R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
 F: target/s390x/kvm/
 F: target/s390x/machine.c
@@ -1771,6 +1773,7 @@ S390 Virtio-ccw
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Eric Farman <farman@linux.ibm.com>
+R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
 F: hw/s390x/
 F: include/hw/s390x/
@@ -1782,6 +1785,8 @@ L: qemu-s390x@nongnu.org
 S390-ccw boot
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Thomas Huth <thuth@redhat.com>
+R: Jared Rossi <jrossi@linux.ibm.com>
+R: Zhuoying Cai <zycai@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
@@ -1802,6 +1807,7 @@ S390 channel subsystem
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Eric Farman <farman@linux.ibm.com>
+R: Farhan Ali <alifm@linux.ibm.com>
 S: Supported
 F: hw/s390x/ccw-device.[ch]
 F: hw/s390x/css.c
@@ -1822,6 +1828,7 @@ L: qemu-s390x@nongnu.org
 S390 SCLP-backed devices
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/event-facility.h
 F: include/hw/s390x/sclp.h
@@ -2809,6 +2816,7 @@ F: include/hw/timer/mips_gictimer.h
 S390 3270 device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Collin Walling <walling@linux.ibm.com>
 S: Odd fixes
 F: include/hw/s390x/3270-ccw.h
 F: hw/char/terminal3270.c
@@ -2818,6 +2826,7 @@ L: qemu-s390x@nongnu.org
 S390 diag 288 watchdog
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Collin Walling <walling@linux.ibm.com>
 S: Supported
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/watchdog/wdt_diag288.h
@@ -2826,6 +2835,7 @@ L: qemu-s390x@nongnu.org
 S390 storage key device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/storage-keys.h
 F: hw/s390x/s390-skeys*.c
@@ -2834,6 +2844,7 @@ L: qemu-s390x@nongnu.org
 S390 storage attribute device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/storage-attributes.h
 F: hw/s390x/s390-stattrib*.c
@@ -2843,6 +2854,7 @@ S390 floating interrupt controller
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: David Hildenbrand <david@redhat.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/intc/s390_flic*.c
 F: include/hw/s390x/s390_flic.h
-- 
2.49.0


