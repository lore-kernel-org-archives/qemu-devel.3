Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD1ECDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wboxf-0000JC-Nq; Mon, 22 Jun 2026 20:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxe-0000HA-KO; Mon, 22 Jun 2026 20:25:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxd-0003by-0i; Mon, 22 Jun 2026 20:25:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmF5T3990916; Tue, 23 Jun 2026 00:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=oCHY057HD1t7itucA
 0Z6jljDaCq/K++NJlo4B3KASU4=; b=JofgXcqCmcsXGXuCHHKS7gF/STdwcLrOU
 oP4jkjnI1sayrzLdCJ0j+lRp4XnCUD4/uDwwfUjgWtfZmLAA6/bOUzmkk62EXiXg
 dsdE3Le+goJCpNIW41qHHWaEVFbZ6E6z9mzGDx7Htby/at2XFIao/xDvdKw8xOep
 p8LKvNikDzN0dSmuVAIPYeWNNXGNesuTcESi2SHB7+Q6VfUdlP3aVfxYhk45BpHM
 dNi6krBgApUeRXm6fGh8P1EuyHgVSDUlBznTw0YWne72f1Xn4ZzW1ee/P1QQhPvV
 4iQuL512Ye/e5/cd79sGu7zExJ1oeNXuSVUITR6GIuO8wTgqgNJwA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3bxye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0JoCh016683;
 Tue, 23 Jun 2026 00:25:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph8nyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0PmAK66585024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:25:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D584758065;
 Tue, 23 Jun 2026 00:25:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE44858053;
 Tue, 23 Jun 2026 00:25:47 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.116.241])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 00:25:47 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com,
 Jared Rossi <jrossi@us.ibm.com>
Subject: [PATCH 3/5] pc-bios/s390-ccw: write IPLB location for virtio-blk-pci
 IPL
Date: Mon, 22 Jun 2026 20:25:37 -0400
Message-ID: <20260623002539.126124-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260623002539.126124-1-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a39d28f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=IniV-qTpWqY4UDjBtQYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX4B7sO5r/CCu9
 823o9g0wmS0B+6+aQNVoqyZGUq/YiqgLjZDkxB1OHzIV7ONQ7Yjk+BOykJMQGArht+kaoqT/Izv
 bbocek+NigfPC7zU1zYqIQeUO2I8gSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX9sjKhD4qnIz0
 uBTSd+3GuKP05YieW31TYh+hk9qvMqdbO/K9pYOVeDjZJ/NhYimKHjdSYTx9NeEFF5GWzzOUXw1
 vFzlhASrI9GJDb0gUJyUQtyo9Ml9UM1pxN65KNxffpXLEO4O5EijOG303j9M519EsSEQMZiwAZH
 U9bqGz0PI40bgPXpjVLvyN/b9B4lmFOn/3KRX5TQX1/uENHXaQkmxc27giSfcXjVqCF1ubEwS3T
 JPz0bl75pm/hjpP86BFnfQFjIPF+748cOCNKgjqvy5eV6J+Y1BU+hBb05YbxzpJVYnuoxQ66Prj
 ZMdO1f4zWKoVcEql5uxiF78H0enG2DNhLrZIotGi75pDcNetE/dz7Wv4OCmA6vL/c9B+f0Zw4yl
 N4d2/jdIYj55tOhHWvocjO3zRSZe8pbNyVm720rK+lUbtcrv9MWQf7Adba+0ghvYa68n17YfMOb
 eCUlCL7V1qp9ig1dzTw==
X-Proofpoint-ORIG-GUID: Itg1zi4g-85w3ObZjFfFVL6BJRL7Wd5i
X-Proofpoint-GUID: Itg1zi4g-85w3ObZjFfFVL6BJRL7Wd5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230000
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

From: Joshua Daley <jdaley@linux.ibm.com>

When IPL type is PCI, cutype is unknown, so the IPLB location does not
get written to lowcore. Update the condition to check IPL type as well.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
signed-off-by: Jared Rossi <jrossi@us.ibm.com>
---
 pc-bios/s390-ccw/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 26287cfd81..1059fda03c 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -52,7 +52,8 @@ void write_subsystem_identification(void)
 
 void write_iplb_location(void)
 {
-    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
+    if ((cutype == CU_TYPE_VIRTIO || iplb.pbt == S390_IPL_TYPE_PCI) &&
+        virtio_get_device_type() != VIRTIO_ID_NET) {
         lowcore->ptr_iplb = ptr2u32(&iplb);
     }
 }
-- 
2.54.0


