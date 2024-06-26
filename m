Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE06EC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMObF-0005nN-6u; Wed, 26 Jun 2024 05:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObC-0005mQ-VR; Wed, 26 Jun 2024 05:05:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObB-0005oZ-H1; Wed, 26 Jun 2024 05:05:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8RFPJ027853;
 Wed, 26 Jun 2024 09:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=Y2L6Dj4n51A7B
 ZHgtaMYdzsl6pGGc5qhQyS7kXHLl3o=; b=OC7aJcR/V0S7/+cSGukWrJzF8Vjnu
 Jnqra2uIKWrkgAcsTWE7VZoiZydbHEXlWAOKbosO2cNo5hoBahj41KYOQ8v7SdfE
 tlyHmSn+GhZnLMUT7cXj/eSp0Bg5+7YAlrmxogFk5CnZoERtS5+dhtR5aVcgSgYs
 ryT9eN8omStoo/Yz9w1uCb2aAkyfe+QkfNLWOeftPjINXZp2pbXpDTf/pU9vz7Ai
 ljfW+t73qWTqHZczjtRjIKPDtM+cLgHoz4bGQ8At8GPWwUk8BRokj6Pb7HEBddxT
 DKwV82FVFFDl5c3sh+zRpwGSeFLJhXBSAfforyamZ4TJFT507RN7WVcZQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400f2m84kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q95iUG020978;
 Wed, 26 Jun 2024 09:05:44 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400f2m84kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45Q71nL8032373; Wed, 26 Jun 2024 09:05:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3ax4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45Q95c4Q53870864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 09:05:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8217C20065;
 Wed, 26 Jun 2024 09:05:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C5472004E;
 Wed, 26 Jun 2024 09:05:36 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2024 09:05:36 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v5 1/6] ppc/pnv: Remove ppc target dependency from pnv_xscom.h
Date: Wed, 26 Jun 2024 04:05:23 -0500
Message-Id: <20240626090528.812-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zcG4P1qZUA7Z2ls71w_6lsZWDZyng7qx
X-Proofpoint-ORIG-GUID: ZaUc3jh7xULGX4zCpRl-wLpFG1K7Gjb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 mlxlogscore=693 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

In this commit target specific dependency from include/hw/ppc/pnv_xscom.h
has been removed so that pnv_xscom.h can be included outside hw/ppc.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_xscom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 6209e18492..c8dd42bffd 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -21,9 +21,9 @@
 #define PPC_PNV_XSCOM_H
 
 #include "exec/memory.h"
-#include "hw/ppc/pnv.h"
 
 typedef struct PnvXScomInterface PnvXScomInterface;
+typedef struct PnvChip PnvChip;
 
 #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
 #define PNV_XSCOM_INTERFACE(obj) \
-- 
2.39.3


