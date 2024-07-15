Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599F6C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 18:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTQWz-0006tq-5S; Mon, 15 Jul 2024 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQWw-0006re-Os; Mon, 15 Jul 2024 14:34:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQWv-0007EU-4K; Mon, 15 Jul 2024 14:34:34 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FIQqIB001291;
 Mon, 15 Jul 2024 18:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=urfWThjjFr3ZYoB0jXnKk9ybnZ
 y/dhWicBOk/Re0UEw=; b=hfkKEEACr+TYNAfT3rD7FNmFF6eyH4O195jeRyel++
 pq1G0dE0JRyRi76uJ++5YZ3ujwaBk5afFQWwPYg5wJhAfBRxogmsVtcmaXmQhTiK
 aqZR5MtmMwy0XN6DE2TD66kkI5voHZgGKffv+XTBOZdYxaei7Q6v6vVkDlYEYgOk
 Z0ddoWPW9CA9p45df2lYlyFLG/EWRF9BCIopjowXxYjG8VmFDpqFoz7LwFRmDotM
 FOEvj75wspShV2petEpOD0SlXsUDbUj/4dPhEupF3qGwQb8Bz9H+dnxbxUNyLFDE
 nG85NnKFSUUZJwgyspfRLp2Y06wn0T9+7lZLo86D3I8A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d7rqr7eb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:21 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FIVHFD007101;
 Mon, 15 Jul 2024 18:34:21 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d7rqr7e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FExFZg028723; Mon, 15 Jul 2024 18:34:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c6m2ywy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FIYF6e13697476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 18:34:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BB5020040;
 Mon, 15 Jul 2024 18:34:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FE2C20043;
 Mon, 15 Jul 2024 18:34:14 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jul 2024 18:34:13 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 0/9] XIVE changes for Cache Watch, VSTs, STT and info pic
Date: Mon, 15 Jul 2024 13:33:23 -0500
Message-Id: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wsdzXdatImug5IyRcBpyPfOXyo4RFFDi
X-Proofpoint-ORIG-GUID: o3nyKDgdCPV-Me8EihtvYtonDQKeX5af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=563 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150143
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

These changes provide enhanced support of the External Interrupt Virtualization
Engine.  The changes are focused on the following areas:
 - Cache Watch, Cache Flush and Sync Injection
 - Virtual Structure Tables
 - Set Translation Table
 - 'info pic' command data that is dumped

Frederic Barrat (7):
  pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
  pnv/xive2: Add NVG and NVC to cache watch facility
  pnv/xive2: Configure Virtualization Structure Tables through the PC
  pnv/xive2: Enable VST NVG and NVC index compression
  pnv/xive2: Set Translation Table for the NVC port space
  pnv/xive2: Fail VST entry address computation if table has no VSD
  pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c

Michael Kowal (1):
  pnv/xive2: Structure/define alignment changes

Nicholas Piggin (1):
  pnv/xive: Support cache flush and queue sync inject with notifications

 hw/intc/pnv_xive2_regs.h    | 108 +++++++
 include/hw/ppc/pnv_chip.h   |   1 +
 include/hw/ppc/xive2_regs.h |   9 +
 hw/intc/pnv_xive2.c         | 563 ++++++++++++++++++++++++++++++------
 hw/intc/xive.c              |  12 +-
 hw/intc/xive2.c             |  33 ++-
 6 files changed, 630 insertions(+), 96 deletions(-)

--
2.43.0


