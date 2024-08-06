Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3A4C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKYp-0007Jl-7p; Tue, 06 Aug 2024 09:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sbKYn-0007FB-Qm; Tue, 06 Aug 2024 09:49:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sbKYm-0000Bv-9J; Tue, 06 Aug 2024 09:49:09 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DOS2j026635;
 Tue, 6 Aug 2024 13:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=8/XQU+E7/extO
 /kTIUmTB1at76QAdFdBvr8baeNssT0=; b=nAvjMwf/SU+70xmZOv9f82aTTzD07
 GVyCZpNesUm26YzzbunPmz5RdZ548UiwZrvAhIJQ3ajRLpV3c8vGxJ4xRx/2wQs7
 URwZdV07iVtAKAHnzZesXdG4KpddSOA64BBfVlHYWnjNJ8OXspciUTW88eSLxvxJ
 AIhl7UaqXbMa/WhQU733SBRuSDYr3VG0hqzPtXPfun7JNebl39w4F1xoyYunsVoj
 MdMmNP2uqRs5DtDn1ML/DgKz20esutVPm8V7zC4W/lqeFD7qthG6SZuXzYCFoatA
 JHA11OBuRkvGr5rsBhdD/kfsWoOzqf3FgxP2x4/yztnt3wt3b5pxxcDaQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uj3vrea9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:59 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476DmwSj009138;
 Tue, 6 Aug 2024 13:48:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uj3vrea7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 476Bg31P024121; Tue, 6 Aug 2024 13:48:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpbwq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 476DmpoP20054300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Aug 2024 13:48:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 835912004B;
 Tue,  6 Aug 2024 13:48:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91D4020040;
 Tue,  6 Aug 2024 13:48:48 +0000 (GMT)
Received: from LAPTOP-UGTOAIPD.ibm.com (unknown [9.43.9.228])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Aug 2024 13:48:48 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v1 2/2] Fixes: Coverity CID 1558831
Date: Tue,  6 Aug 2024 19:18:29 +0530
Message-Id: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
References: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QXXnxvec7I2cUTEqQpfWiF6OanA1_0SD
X-Proofpoint-GUID: zvgA4QZDQhVf-gJguTMOYmCo25WZwgqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 mlxlogscore=944
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408060093
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In this commit the following coverity scan defect has been fixed
CID 1558831:  Resource leaks  (RESOURCE_LEAK)
  Variable "rsp_payload" going out of scope leaks the storage it
  points to.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index a33f682897..dbe06df224 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -237,6 +237,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
     }
     if (rsp_payload != NULL) {
         spi_response(s, s->N1_bits, rsp_payload);
+        pnv_spi_xfer_buffer_free(rsp_payload);
     }
 }
 
-- 
2.34.1


