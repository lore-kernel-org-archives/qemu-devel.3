Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A1C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqaN-0004pN-BT; Tue, 30 Jul 2024 13:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYqaM-0004jz-07; Tue, 30 Jul 2024 13:24:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYqaK-0006OG-B1; Tue, 30 Jul 2024 13:24:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UErlm0007123;
 Tue, 30 Jul 2024 17:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 06eiwRxYEfvHumpi+6WeiQinq+9LxH9LBhq2tCZVWds=; b=cifN2mfP4b6OlQ4A
 17pOphmyGYxP5ohBY9HYXDABV2LKgnFhN6zM2MRd2TUheMtHkiCPWdRPhYSKlKID
 aPHXD5noZIpO8InwRkDtZO551ug2Zql4MyoGRqaDN+We2ByxOCM20YHs8CwH2zID
 MS9FWCFepkX3dvfAu3hef0UGI/6+dqbnI6WBWYaHqE2YS2nYVE6M9X+3Mu9C6zxd
 vrKCqRLJRQyHNwo/XifcABw3J8siYRw0YaPJSgXkD2c6vlMEiagec5Fi4xnFZQ4l
 QZWLXRYoW8TwuPYuEClnE/V7/1NNbJQOkbjMds9N1v1T5Icmo3vfpObktcA7CDvK
 UozZBA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q1398nw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 17:24:19 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UHOIoW014989;
 Tue, 30 Jul 2024 17:24:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q1398nw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 17:24:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46UGdUW7029118; Tue, 30 Jul 2024 17:24:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm0pat7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 17:24:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46UHOBl044892582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 17:24:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD75920043;
 Tue, 30 Jul 2024 17:24:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD70B20040;
 Tue, 30 Jul 2024 17:24:09 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2024 17:24:09 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v6 4/6] hw/block: Add Microchip's 25CSM04 to m25p80
Date: Tue, 30 Jul 2024 12:23:41 -0500
Message-Id: <20240730172343.5818-5-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240730172343.5818-1-chalapathi.v@linux.ibm.com>
References: <20240730172343.5818-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bgmnOSY3JB3M1deaXPkGYhMoSBjfAgHv
X-Proofpoint-ORIG-GUID: KhjbbMW6jfRnzVs4eMewSCM0TgId_uOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=923 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407300115
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


