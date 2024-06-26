Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A13BC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMObS-0005tm-KM; Wed, 26 Jun 2024 05:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObQ-0005sH-2R; Wed, 26 Jun 2024 05:06:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObM-0005v2-IS; Wed, 26 Jun 2024 05:06:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8SYtp006380;
 Wed, 26 Jun 2024 09:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 06eiwRxYEfvHumpi+6WeiQinq+9LxH9LBhq2tCZVWds=; b=MGiPYisE9p6MnBRc
 9geQESrzc0qKACwGsivmuuUWEzn/HWos8dRpMKYqB8zjIrIr9ORItmXiyv68qsA1
 UL7HM9UYstnQNPMThNYQy9NyKAEfNPLItrQ9iaQE3ewG0TZgxa/yFH2ChKBW1zDV
 8RsQBnAZ3iZw2emEyFdHXR7e6UN1pSMV1mBHVCNh6Lmd8pb7x6f+3lF2kB8DMOcR
 RQnGrvDIypcW3fwq27Jxn+WiL3Xgs5+8sk/gC6J6lN3T7eoFdYdKSklQYs1spBKM
 W5u8e+c8RqQqky4VhEONcn1CKkXePh0ryVah3L4sHs6vnCUriKCrn978vfX3Vtv5
 FJhvEg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fgng2u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q95tOF029117;
 Wed, 26 Jun 2024 09:05:55 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fgng2u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45Q8TPxC018099; Wed, 26 Jun 2024 09:05:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xubjc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45Q95mdt30605948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 09:05:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC3EA2004B;
 Wed, 26 Jun 2024 09:05:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6F8D2004F;
 Wed, 26 Jun 2024 09:05:46 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2024 09:05:46 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v5 4/6] hw/block: Add Microchip's 25CSM04 to m25p80
Date: Wed, 26 Jun 2024 04:05:26 -0500
Message-Id: <20240626090528.812-5-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oigAWCF63cywgDUofaUR2D8PkpZhN_Ip
X-Proofpoint-GUID: qta_3ASPIQNHPDbSbaiR70Zv5_5fF3lH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=915
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260067
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add Microchip's 25CSM04 Serial EEPROM to m25p80.  25CSM04 provides 4 Mbits
of Serial EEPROM utilizing the Serial Peripheral Interface (SPI) compatible
bus. The device is organized as 524288 bytes of 8 bits each (512Kbyte) and
is optimized for use in consumer and industrial applications where reliable
and dependable nonvolatile memory storage is essential.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/block/m25p80.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 8dec134832..824a6c5c60 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -357,6 +357,9 @@ static const FlashPartInfo known_devices[] = {
       .sfdp_read = m25p80_sfdp_w25q512jv },
     { INFO("w25q01jvq",   0xef4021,      0,  64 << 10, 2048, ER_4K),
       .sfdp_read = m25p80_sfdp_w25q01jvq },
+
+    /* Microchip */
+    { INFO("25csm04",      0x29cc00,      0x100,  64 << 10,  8, 0) },
 };
 
 typedef enum {
-- 
2.39.3


