Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6960CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wboxj-0000MC-BI; Mon, 22 Jun 2026 20:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxi-0000Lc-An; Mon, 22 Jun 2026 20:25:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxg-0003d6-Q2; Mon, 22 Jun 2026 20:25:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmCq74133428; Tue, 23 Jun 2026 00:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zhSKiO/IHmLzfM3Do
 EVL6G2Q8QWGd7wtlJTGHm8RXHA=; b=L6VI3vl1e47PL2nMr7N7ttGA+arjdPM0g
 590knbf1NwuH3P13HHq6kQmsxunYh0IZeIK/8j3XHUNvC9lcr3ewKBFXGriw+7jj
 mKrTVIY1xuQSu2aCR2yqEh3Xg1iKA8o8p950INN1l8jaYW/v7YCsP87We9zrZ1vf
 MlnGTOkNMOq73RO2qGiKO2En0ciePcDrmtwkiIUtTwIyQPzvKHb8haOxPfrqxOxP
 94byqUFLyQIT654wsErSUonY285+S9TirxvNZqUE739OUfr0ckXj3+B3s6WzPNxL
 cbsXylD23U4rLmkWtDjbovvG6RHfBiKf8Eqa6Yd/FpQjtCu0z0UDw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqkv32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0JdtI024608;
 Tue, 23 Jun 2026 00:25:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg0h4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0Pqds66322826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:25:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8446F58059;
 Tue, 23 Jun 2026 00:25:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7085B58043;
 Tue, 23 Jun 2026 00:25:51 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.116.241])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 00:25:51 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com,
 Jared Rossi <jrossi@us.ibm.com>
Subject: [PATCH 5/5] s390x: Enable boot menu for virtio pci device
Date: Mon, 22 Jun 2026 20:25:39 -0400
Message-ID: <20260623002539.126124-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260623002539.126124-1-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a39d293 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=UmcbZtfwkcGgJE0Tj-oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfXxhQbWQhd4Vi/
 Euo1pPpgeWkY7gsooWLkQujMpZaVzryWT/9aOHEHEPD5SZLGYAg40o+vB8SmYYA1fxATKmfVWYq
 CGyhXED7WCL3FI5aMrhFTZtka0vDUAG9Dzm3EwBsNm4ryWVeF+ZkNOePB9W4W01EiBg4w6CQK89
 KwmFX34pOd59TwNYBSW7omOIhrFhnEBG59ITj4kNNt1TlQpdN/3AQBthpcX4MKCLfBdUawk28Az
 VOBTjqLZDMmUtEQgkR+nsDPxZGV5RFQTK6PBqIS+COOfIQmfsMJDGJVLOGCqY34t8GhJ9PB73YG
 5+QNZfhULXpzQ9vX9pvMHzBQXbbH/hw7YPepcNZothzzWHNbk0AMeAe8h1VTkPHX2VuvTa905av
 QxrLvCE6zdgnYc+7fDhdwvCTHA5CcKBtXeW4TYDYSWnFswxYm/yiFgLfjj5WBp+W7TpTWm7k2jD
 4LptC5w7e/iKLaXFuIQ==
X-Proofpoint-GUID: zE1bniD_9pAk3b6a3o7Rvb3AUy9gp9td
X-Proofpoint-ORIG-GUID: zE1bniD_9pAk3b6a3o7Rvb3AUy9gp9td
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX0fYgMgl7w3Lw
 6WtIhuILJarCAIfwgtgXk0jSSeEmLIV7kwcun8YScNx0DJewmSLYuAQKzrditRVaIV1Fi/VzYB3
 8UC5T28C9W2kU2Fufra2e2PxxwPmnz8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230000
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Add S390_IPL_TYPE_PCI to the boot menu handling logic to enable
interactive boot menu support for virtio PCI devices on s390x.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
signed-off-by: Jared Rossi <jrossi@us.ibm.com>
---
 hw/s390x/ipl.c          | 1 +
 pc-bios/s390-ccw/main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 4cca21c621..d5fdc3ea0f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -315,6 +315,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
             return;
         }
         break;
+    case S390_IPL_TYPE_PCI:
     case S390_IPL_TYPE_QEMU_SCSI:
         break;
     default:
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 567e97bf32..be83d598e2 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -185,6 +185,7 @@ static void menu_setup(VDev *vdev)
 
     switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
+    case S390_IPL_TYPE_PCI:
     case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
-- 
2.54.0


