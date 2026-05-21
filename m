Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA8FCD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9hV-00023C-7y; Thu, 21 May 2026 16:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQ9hU-00022w-Fq; Thu, 21 May 2026 16:09:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQ9hS-00071B-LD; Thu, 21 May 2026 16:09:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LCREhU883231; Thu, 21 May 2026 20:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=zhDPMDRihvGQu4mc/Qmu5/NjYOMEnpVRj5WvLc+H4
 B8=; b=g3h1WIh/3cCK7V9H3etBG7r15Ym02psfAgAwLmxgbyodoCGW64D+CMIss
 ISpz+PR7xSiJJXHCvyzwHqY3dpLyNeqrIIFwhSkSaLVvJEJjW2MOqm4/RjIf7/dv
 iIkhZgEuzvBTuGuNZLyT6gEIgicim7shJvQiHQ1F1TTcLDT78DT+Rriyl3uH2AjQ
 0bXb9G4odeO/r4H+MxoQL1P8uesuQ9We4LoE5udkxSaBNhez7/ss2khujy/PIbTm
 TvNo/cQ8X5EKg9ll7AqW1E/aa1ZzaGo3UwcM7PpHHiBB/FmRRZvJvmcyjekKxNUB
 LkoGdP5QNUjt/7k5PbA36Vpyxvk3Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n0tpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 20:08:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LJd87J021368;
 Thu, 21 May 2026 20:08:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w61jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 20:08:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64LK8nrs49676726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 20:08:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCC3C2004B;
 Thu, 21 May 2026 20:08:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92AF52004D;
 Thu, 21 May 2026 20:08:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.116]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 May 2026 20:08:46 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PATCH 0/2] ppc/pnv: Make Power11 as the default CPU
Date: Fri, 22 May 2026 01:38:42 +0530
Message-ID: <20260521200844.1449023-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SUGJr4qZTCcRwtn12eXlOsqSimveNMID
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0f6657 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8 a=06ATd3cQ_zJXQtLGZ5QA:9
X-Proofpoint-ORIG-GUID: dpzaSISi2EoxM98BAeBYUWVhH9869jr0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIwMiBTYWx0ZWRfX+me9aYKIIis7
 E3ci/POCxnfRQGjSZ1RXoIRgnpV/MRTXzORK84A+/OVr4kF5MBOZlx6M9ZOLshmq8WZ+E6tgd3e
 4eixelN7WqL6k3dbdC+I8QSqihARNEucQT65FVJn73+hsIaaQRCTTF2irxJ2EMLvDdWrEngUPg/
 FaR0H2mqob7sKonRpRxKrtl4ygdbh/AUIBu6qE+tnsacS6Vp/vptL2XMFP2E6TJnf+Myz4Fg8AP
 0x3mX7bI/xU064qefsPWs0GbBVkoWLMYQNiPfRxXuPGeKHjdaTdeylfsvkaSv3tCeM/XZVMFWL2
 BX6ug/+9+LioPIDB/3oTU7SDmxwORhJCOiH+j841n8dbRYcxeyDi5bUvVnpyzKeBUiywP/medab
 8K4P1gMFGeizedscmeVJoU0yzY3BAyQ8roXFWR4PgrAdZlu90+O7LOj2QlQIbSUoNj65Gh/QZan
 eYUB09/ommyBep/XxXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210202
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Overview
========

Power11 is the newest supported Power processor merged last year.
Make it the default processor for PSeries and PowerNV.

Testing
=======
1. Git tree with patches: https://gitlab.com/adi-g15-ibm/qemu/-/tree/feat_default_p11
2. Gitlab Pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2542576926/

Aditya Gupta (2):
  ppc/pnv: Make PowerNV11 as the default powernv machine
  ppc/pseries: Make Power11 as default cpu for pseries

 hw/ppc/pnv.c   | 4 ++--
 hw/ppc/spapr.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.54.0


