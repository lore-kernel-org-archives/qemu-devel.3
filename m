Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1E7C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 21:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWjR3-0000EX-9J; Wed, 24 Jul 2024 17:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjQy-0000A2-97; Wed, 24 Jul 2024 17:22:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjQs-0000Vd-Rk; Wed, 24 Jul 2024 17:22:01 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OLGA77020337;
 Wed, 24 Jul 2024 21:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 QgsukWEcvf6z0tcmWMdhOXMID3WtMdEKCMTLyTXpO14=; b=A5EGZFKvi8ilSxff
 wcl5F+J616fqNv0z4JmsAEACNNPTmwKmR96yCpxun4dg7n0LiOG8l+XpD7wlWihA
 Rgo9o6Q5Do+dzK6BsCmGQKgTsNtK2T2Uf8QnN4H7RAYk8v3u89IFs4M7NnrTN2Yw
 wR756YvEdN8bMV0U8kWZWHB5FRSOg6TarNu7YZIuulluxVaBehq2OFl5LAsKbbFZ
 0QkNvWrBLoI8GGTWvJq+NtldFIFePCH1SibDayWtMgg0DAVGoDYy+1xG4G07t6Ff
 XID1xsB4TU9X+IaHZ6Gc3WP1u7KxnkcXk0CP1sJVkhiKNt0a4hJbgd+ye6kVgQzC
 fFaFpA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k8pf030w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:55 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OLLts9031299;
 Wed, 24 Jul 2024 21:21:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k8pf030v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46OJFD7Q007861; Wed, 24 Jul 2024 21:21:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxna23d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46OLLmjZ33817162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 21:21:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD19E2006C;
 Wed, 24 Jul 2024 21:21:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DB4920063;
 Wed, 24 Jul 2024 21:21:47 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 21:21:47 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 07/11] pnv/xive2: Set Translation Table for the NVC port
 space
Date: Wed, 24 Jul 2024 16:21:26 -0500
Message-Id: <20240724212130.26811-8-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240724212130.26811-1-kowal@linux.ibm.com>
References: <20240724212130.26811-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A1PJcC4toWHg3EbnDVvyAv5JWTp_F6uM
X-Proofpoint-GUID: 2qPwp5AG3DkaKH-rJS8-ENQ6NBoD0nDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_24,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407240150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Set Translation Table for the NVC port space is missing.  The xive model
doesn't take into account the remapping of IO operations via the Set
Translation Table but firmware is allowed to define it for the Notify
Virtual Crowd (NVC), like it's already done for the other VST tables.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 84ae10b710..dab4c169a4 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -722,6 +722,7 @@ static int pnv_xive2_stt_set_data(PnvXive2 *xive, uint64_t val)
     case CQ_TAR_NVPG:
     case CQ_TAR_ESB:
     case CQ_TAR_END:
+    case CQ_TAR_NVC:
         xive->tables[tsel][entry] = val;
         break;
     default:
-- 
2.43.0


