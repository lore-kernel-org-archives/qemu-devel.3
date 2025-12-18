Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53673D70DF2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWKEg-0005SQ-Eb; Thu, 18 Dec 2025 15:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEI-0005NP-Qd; Thu, 18 Dec 2025 15:04:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEH-00084C-4H; Thu, 18 Dec 2025 15:04:06 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJmPcE013740;
 Thu, 18 Dec 2025 20:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RX8oYuH+LZu27eUFF
 PFIY0yJcIcIJ23YT8nIwTJi/uU=; b=GpHqt8zqWpf5ybQOnoHi6Zhn0lforgmSh
 Nik9I6CyWUhi180JqLUIEBmbFZSDPuwNSSuXBUjqrCekLus6q1POTlVTcotu52d2
 O1IPadXsavKLelrZtpszosL3AZHpSu0EMslTlaGSt3tlt65Yhu3mJu8A5EPwd54p
 k8L9nx30QOeL4bCdxzHz51m2rcbC1hv2LwV4Y/YcZK39Jedlo/Zk3fIDaCWRq0su
 A/3WUzb7PGoY7HufDxFUUY5Wfgukfpjm5dApsDIs3AXr16POW5GDoCgGDEKv1Q/y
 1k7l00n4dNp/XKzv0dHCLYDw/PPvbn3I9z6eZnOG7FAI5X5G4K/FA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d02t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIK2PYF010155;
 Thu, 18 Dec 2025 20:04:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d02t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJYAvG031555;
 Thu, 18 Dec 2025 20:04:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvu84er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIK3xnH50266378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 20:04:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E340A58055;
 Thu, 18 Dec 2025 20:03:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8501158043;
 Thu, 18 Dec 2025 20:03:59 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 20:03:59 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
Date: Thu, 18 Dec 2025 14:03:50 -0600
Message-ID: <20251218200353.301866-2-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218200353.301866-1-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WYkBqkhX c=1 sm=1 tr=0 ts=69445e33 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=a50YP9O8wkpZPKg7Ci0A:9
X-Proofpoint-GUID: 8sZXk0eb3hrqlI0yp8u-zbCoptM2YiDj
X-Proofpoint-ORIG-GUID: gezuTAHHiMw0Bjj1xSzc-qtNaDuo7EsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2NCBTYWx0ZWRfX5Horla6WGjMw
 nmySwf+tag1ZI9SgI+neL+cYJFsQ1CWzOSA1+cIdLFau3OSjGI6BterJqJAjg5+qygHoS7SH8pI
 D2jqWx5LqqwUyL+pYbEu1tZ2qb//fliC3pUfnq4OuhU32TQ0SlaSzDgB90edUPWVZV6EYtuoNIu
 485IGbMnq5YYvT+z70KCjdS1Huua1QQES9ecCrCMG1tLW8T33+0ka3AGgGwlUhopHy6eFlbpH5x
 G6likD1n628OQrhzKiUpIMW0BsZc/mfnLTWSypsG8Lh85AbJccFSpZ/3wrIRVOqcpgM1+iAayl0
 kOIXNOOVWL8Helj1OWJKoaGf9BoplqwjyOmD5BMFeqN/2YQfGg6auFpUHLlgr9I6cslO5x4WxPW
 qBgFpf9Ml5UiqzG5+6K2rrvU7VLKt6iZyRsAh8BkrbLOT/2+V4D2W2ftXIXcN/g4mo35AdVJuJy
 +KDe9IL7mhUnvU2Oiog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512180164
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

This commit suppresses the following informational messages
regarding unimplemented pnv_chiptod registers:

pnv_chiptod: unimplemented register: Ox0
pnv_chiptod: unimplemented register: Ox1
pnv_chiptod: unimplemented register: Ox2
pnv_chiptod: unimplemented register: Ox3
pnv_chiptod: unimplemented register: Ox4
pnv_chiptod: unimplemented register: Ox5
pnv_chiptod: unimplemented register: Ox13

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_chiptod.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index f887a18cde..cd9b8ee348 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -145,6 +145,15 @@ static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
             val |= PPC_BIT(4);
         }
         break;
+    case TOD_M_PATH_CTRL_REG:
+    case TOD_PRI_PORT_0_CTRL_REG:
+    case TOD_PRI_PORT_1_CTRL_REG:
+    case TOD_SEC_PORT_0_CTRL_REG:
+    case TOD_SEC_PORT_1_CTRL_REG:
+    case TOD_S_PATH_CTRL_REG:
+    case TOD_TX_TTYPE_2_REG:
+        /* unimplemented, but suppressing logging for now */
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
                       HWADDR_PRIx "\n", addr >> 3);
@@ -420,6 +429,15 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
     case TOD_TX_TTYPE_5_REG:
         pctc->broadcast_ttype(chiptod, offset);
         break;
+    case TOD_M_PATH_CTRL_REG:
+    case TOD_PRI_PORT_0_CTRL_REG:
+    case TOD_PRI_PORT_1_CTRL_REG:
+    case TOD_SEC_PORT_0_CTRL_REG:
+    case TOD_SEC_PORT_1_CTRL_REG:
+    case TOD_S_PATH_CTRL_REG:
+    case TOD_TX_TTYPE_2_REG:
+        /* unimplemented, but suppressing logging for now */
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
                       HWADDR_PRIx "\n", addr >> 3);
-- 
2.47.3


