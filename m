Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FF3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZJP-000374-25; Tue, 30 Jun 2026 10:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJN-00036J-Jt; Tue, 30 Jun 2026 10:19:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJM-0005Vs-6d; Tue, 30 Jun 2026 10:19:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIXAF2233767; Tue, 30 Jun 2026 14:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hHQ3pW9JcrtI+tPaR
 JvyGlJZ1wykwhIp5eYzCM93v8w=; b=l5E7u/TadVtdGFVEOWjLSUGYXr2oEKoDY
 AFizlHmZvYwrh5R9UCyk8n+dA1FkDc1uFQHu8erpSM+gvQSEofuYapfvA5EgejLj
 MNx3+728OWO2noc54G8OZKqAH1+qSyn2i8LrEFBh3t64LGp5Xd2lPMU63T50wH2r
 Siqu8bthCJXwVnIUMTZNkl0WuysDixlCjImva6kSkXt2adxm7hOxJjverqWvwIVo
 2H4bu0PryOzv2IdQYrKktWfEGc6SO5++zY9hbQNjD5cLeMgViru65dasvk9JI3AF
 scCKt824FpjqYDjw4DdnpApySSngZHDqwVAMsanzMc2alzYZDXX8g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5q8be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UE4geI012687;
 Tue, 30 Jun 2026 14:19:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyac8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UEJ3Hk15401684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 14:19:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1839558053;
 Tue, 30 Jun 2026 14:19:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3B5458043;
 Tue, 30 Jun 2026 14:19:34 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.10.219])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 14:19:34 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH v2 5/6] pc-bios/s390-ccw: write IPLB location for non-net
 virtio devices
Date: Tue, 30 Jun 2026 10:19:16 -0400
Message-ID: <20260630141917.673995-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630141917.673995-1-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX4WIau6qSpn8J
 Om+Bc00MMFbJt1hiiQG4r+YAHENFTvA5j18CUadqr2cz4xr4Fd7Dwo3TetqIcBVV/aLpOASHkR5
 JmJKJ1jySbX0q0AteXhQO4gAq2Minf6Jd/YNMCJtnlnl27dtYuFST1jk1xWLhezWjjZd/0DOTpc
 qWP/bRavbuw+KzIC4ALvdKMV9wPHs91SFirFiDa4rjNm6t354cWrfCOa5pwV6LWdoB3UVkn0soc
 qYdAswrbHAmv3asSWnxN1kc1no+CaD0Qccmlz2P4sUrxBARMxu4ZFEtYBdcY/RkoKRIQT2xf+Wm
 3fTV3Bk9F5H0HUWlJ4/12SvIxj4Bm9eqDc5Ub9imFlghFsCwI82dxhjQih10tVOkk8VTzjQ/7zO
 /8NwDfcp4Cg8xaH3CsLsPhL4kZU0naMzYhTWIsSzbCLa72ksrar02W3go30DT3US1KU91xGx6gU
 N96U5BXROsviR8zxTbw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43d07a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Eh1SWvY1evcEpyuAkaEA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: y8Tsxp3xuYtT-kcXCGkhzXNAos3wI154
X-Proofpoint-GUID: y8Tsxp3xuYtT-kcXCGkhzXNAos3wI154
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX5liUx1IN2VNM
 1Bf7qqoD3ofPNJDKbAU8/8cItrz75GtGYZ7X47veOVl5Grnkw0ft15mJ4RCPuMZUSvBiR6qcLY3
 9+lW7X5XqHWROOQbFwEeqeeYQy2c2iQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

From: Jared Rossi <jrossi@linux.ibm.com>

When IPL type is PCI, cutype is unknown, so the IPLB location does not
get written to lowcore.  Instead of checking cutype, check if the device
is virtio generically, which covers both CCW and PCI variants.  Net devices
are excluded.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index fb47d29bb1..9c147ac5fa 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -52,7 +52,8 @@ void write_subsystem_identification(void)
 
 void write_iplb_location(void)
 {
-    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
+    if (virtio_is_supported(virtio_get_device()) &&
+        virtio_get_device_type() != VIRTIO_ID_NET) {
         lowcore->ptr_iplb = ptr2u32(&iplb);
     }
 }
-- 
2.54.0


