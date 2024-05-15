Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57660C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Iel-00018F-7h; Wed, 15 May 2024 13:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7IeE-00012s-7D; Wed, 15 May 2024 13:42:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7IeB-0006YP-2B; Wed, 15 May 2024 13:42:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FH0dtN018907; Wed, 15 May 2024 17:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mzWizbN0oiLw3S2B0TR+0ZNFAMrMm8gzHZ0tye51ztI=;
 b=A3E8f6bdKqhZqxqhbdVr43QkzRsvt+hEVnE1P7UgE4iLajD0/NWtgJn59LSByVZQVu5Z
 SjIEe7cMSq71+I1gDgx0zPiZKeFHufiG8c0u420L1E7s6iJ4tj8WwRg5+1+ijQb4sQfz
 Jdy+ilAX37RIU7XBaElGiKyUIy/PWRHclf/Ct6C4WVkPkxgdzj4wEnMj1YGKddpwnw3H
 54XKODnaYc5CplDGNLQ2W5Fuk0nVWJkxvsq4SU1j+ASpe8CR7TL0bE/JeFB3dwOVcXXe
 JcGJlNwAd+ISB0JCzuHVX7MuOQe0vE7xtwObidb7X/3g+eeENHrG7o46f4EdA1+ggc08 yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4xtvrfts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:23 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FHgNQR023562;
 Wed, 15 May 2024 17:42:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4xtvrftp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FFbI45006200; Wed, 15 May 2024 17:42:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmmvyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44FHgFfs35259090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 17:42:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBD752004F;
 Wed, 15 May 2024 17:42:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB1492004E;
 Wed, 15 May 2024 17:42:13 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 May 2024 17:42:13 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
Subject: [PATCH v3 3/5] hw/block: Add Microchip's 25CSM04 to m25p80
Date: Wed, 15 May 2024 12:41:47 -0500
Message-Id: <20240515174149.17713-4-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yoNNwqQNxE6J3R_Gk9yP5Nw97DW-oBZf
X-Proofpoint-GUID: rnH9kxMXR497_DsYoiLsV1CY-b2_8gJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=841 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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
---
 hw/block/m25p80.c | 3 +++
 hw/ppc/Kconfig    | 1 +
 2 files changed, 4 insertions(+)

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
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 6f9670b377..a93430b734 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -40,6 +40,7 @@ config POWERNV
     select PCA9552
     select PCA9554
     select SSI
+    select SSI_M25P80
 
 config PPC405
     bool
-- 
2.39.3


