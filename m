Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C082AC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVll-0002A5-5V; Fri, 03 Jul 2026 00:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlZ-00029J-8E
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlG-000385-9m
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631IxiA1151701; Fri, 3 Jul 2026 04:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WgHVki
 7BX9aDh8hCxyIP4ZIcst3gC9SZO6fT3w+ArTQ=; b=PWJMbkxk7V+6IVTHV0PqhB
 d6QOzRrwtjTcQGjjPLmjDLVcn0ZEWcJuWGQVTArUq3OK88kM66hmP098lRGAPWe7
 PJoTol15cmV+ZA9yG+aR7Gb+lxwfMyMZw4fG2eL390tsOvUWKzVOoQyUO0P0/tai
 1HCH03BY67bsvYvpJMZgToyYMYN5dNluZ+o+M17GBFmx1H09dstRafwMYgfgpB1V
 0hGmayaumY6qn2ZH/WoKiYSyto7Wvs02+3yrVsnDTlYDqIa5aZ7UyZtj0CDc76ae
 jcVuqyVbX+aLm/Vd1nLfr3gm5CNY4S2HdkTSQFUC8YKqJYOfmK3axJa/LwcpVcZw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk4x87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 04:44:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634YZ8c002499;
 Fri, 3 Jul 2026 04:44:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhypxh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 04:44:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634iGiL38076802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 04:44:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A49C420043;
 Fri,  3 Jul 2026 04:44:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4944D20040;
 Fri,  3 Jul 2026 04:44:15 +0000 (GMT)
Received: from Mac-11.lan (unknown [9.39.22.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 04:44:15 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/7] Revert "hw/ppc: Deprecate 405 CPUs"
Date: Fri,  3 Jul 2026 10:13:57 +0530
Message-ID: <20260703044402.79723-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX9RW6XwcIi/Ya
 KDZdLJE0IZA4YQYRqQK81l89+NElHG2OkfV1FIXEBf3YKIBHm3UWoiGjPR/CVIpVvPijp8E9mlJ
 mi/fKlgYK8t1Mxi2AIxhmBPr+L8kmU0rEhWGBaisuFRiwFQ3oYaywXgVw5GooaZXMK3vfoTf09m
 DIZH5Fjd7jLDCf/780FnUaSNI9w2Zqs5UMGwPNWdHtYeukVDzMskMp1znA31+Ns4EwC440FqRbq
 gOp7IUFtD8QRuxvPuBrsDiwWQJJmNQrIFG0yKdv+ElsY9k+IIUEaEFcFbFXJEL5llqIiyYIaeQB
 9JPTjAmm/rEUzmRnuS9QLBFVZ9cvb54w73V+L8Bsy2SNpsvLVW6nQCwsXqIZWW+UWAefw2VQ6nT
 j7RPuBL5jxVx5nCKN6Vg6tPmjEbD2gI57qgTw/wmunGvqY8LbfY5H6iYINhPzwqavLD6imwKQgF
 qRhOseZ8xY2SNJ2xhUw==
X-Proofpoint-GUID: 5HG7AicGR_sT5pOXjhxEK-cm5XGQg0RS
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a473e25 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=kzH-N7ndX5ZrohmAGq0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX75bk06REliLH
 rSaH5YnIXAOY7XlnWCZbjwbz5hbegTeBVLaDXm4zhIYh7+wRfJU0M3lHf1RYRsdrsoLXdFVbZH/
 Go1smCSs+rrOmudDkxHinwLmqzaFTWw=
X-Proofpoint-ORIG-GUID: 5HG7AicGR_sT5pOXjhxEK-cm5XGQg0RS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030037
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

This reverts commit 52f0b59ec6b780f2a3e162d5862b90b406fa4697.

The PowerPC 405 CPU is used by the PPE42 CPU which was added to
QEMU v10.2.  The PPE42 CPU is basically a stripped down version
of the PowerPC 405 CPU and is used by the Power9, Power10, and
Power11 CPUs as an embedded processor to handle various tasks.
Also, IBM has plans to use the PowerPC 405 CPU model within a
year to model the On Chip Controller (OCC), which has an embedded
PPC405 CPU.  Therefore, this patch removes the PowerPC 405 CPU
from the deprecated list.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260505144621.1308457-1-milesg@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 docs/about/deprecated.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index cf3e1a007c..169c5dfe4f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -206,15 +206,6 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
 but for consistency these will get removed in a future release, too.
 Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 
-PPC 405 CPUs (since 10.0)
-'''''''''''''''''''''''''
-
-The PPC 405 CPU has no known users and the ``ref405ep`` machine was
-removed in QEMU 10.0. Since the IBM POWER [8-11] processors uses an
-embedded 405 for power management (OCC) and other internal tasks, it
-is theoretically possible to use QEMU to model them. Let's keep the
-CPU implementation for a while before removing all support.
-
 Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.52.0


