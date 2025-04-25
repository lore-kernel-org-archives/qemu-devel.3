Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51705C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 05:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8BYZ-0000Cr-5L; Fri, 25 Apr 2025 01:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXq-0008To-8R; Fri, 25 Apr 2025 01:24:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXm-0004Gs-R2; Fri, 25 Apr 2025 01:24:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OLdXSo006742;
 Fri, 25 Apr 2025 05:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WgAkIjhhyN080c6NO
 RSVhfyoP6B6VhHanQuGf6xvM8w=; b=rowXk8HupEyZPGDkR6gdsdDSSJ1aj5fP6
 ODhK74F/mbHpckd8DhdLURgYl6rHTxMBRD4XQ91JAcRs2FKU1+3YNUMjL1rT4lvf
 GNn1FQVmY2YIcwjjQEn+OBBTfNIPOOLBsb3eSm8wFsQZhbEgqoAEXpA1TVhtEDiC
 QTml6GODUh40eIEHAhlg5RU2TzDMWWPpWHjbxibGSpN9SfnTTCTPbPPTH3mWnXTJ
 kfZ7+BBmd4qMQc3Vn3Rl16rjTEdQ4c7WQg9sLCO4BNGfaT+MybFVBIZqsJYQRTv6
 j7WNa4KnXIKwtdOTVJG5kTTTqMYipH5iydMmoNmntEStkiZm4grYA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9hfcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P45F4E028421;
 Fri, 25 Apr 2025 05:24:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvuq50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53P5O32u24118012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 05:24:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA34E58065;
 Fri, 25 Apr 2025 05:24:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2B175805A;
 Fri, 25 Apr 2025 05:24:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.76])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Apr 2025 05:24:02 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v7 1/6] linux-header: update-linux-header script changes
Date: Fri, 25 Apr 2025 01:23:56 -0400
Message-ID: <20250425052401.8287-2-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425052401.8287-1-rreyes@linux.ibm.com>
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fr1oM3oNjfHVyVLiSeBM7VpyeIr5UbKD
X-Proofpoint-ORIG-GUID: Fr1oM3oNjfHVyVLiSeBM7VpyeIr5UbKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzNSBTYWx0ZWRfX0+QGCRu/tNJL
 mve6OmZZkUSRTU3pNy0IQrWO/3g6aHG6jygBc5EldTsxOdsxizoTOMI9vufJtoWrKLWzqQTcBQr
 4b2mU99JKuBFs1bx4DB/itx6VE8LYcszj1b5i9+BbZ6g2IWdr3uZ+2CB6Bc6iFV5zJ7YZCPfKkG
 cBoiOK0puxIn8Y5wT4r0yX6G2PSjbc6UBmNfk4cuazdZM+FCXTwK7a+OhHAwUKEuotew+T3vK2w
 ofPG5MPqyTW3u+v8Go3WYPg7JCfPlin0cWvQ4Mx6L2rCqWdWIOwQ7R7mYBWfCVLuoTAaeckXvHs
 R4bubcROkuo563I8UwZ9mDZw4G2YJ4WJB5kdt4CKg6/juht+ur3kpVAQ1lYuUWQFev9tb7BwGTi
 bnQkvItpcAlKE11Z4QfgGEfyGophp3eTRCSE690pMJTUpc1yHpftgmlS+sRYFLkYey8A017l
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680b1c76 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=W0EDWCW3zNCZun0cewcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=901 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Kernel commit 8a141be3233a changed from using
ASSEMBLY to ASSEMBLER
Updated the update-linux-header script to match

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8913e4fb99..b43b8ef75a 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -177,7 +177,7 @@ EOF
 
         # Remove everything except the macros from bootparam.h avoiding the
         # unnecessary import of several video/ist/etc headers
-        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
+        sed -e '/__ASSEMBLER__/,/__ASSEMBLER__/d' \
                "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
-- 
2.48.1


