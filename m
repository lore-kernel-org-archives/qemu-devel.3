Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF2C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZJR-00038D-Vz; Tue, 30 Jun 2026 10:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJO-00036v-Pu; Tue, 30 Jun 2026 10:19:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJN-0005WD-Fn; Tue, 30 Jun 2026 10:19:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIZax2124815; Tue, 30 Jun 2026 14:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SUsuvVGycvJIKnTNT
 PviKdDQDMcuXH65rjYwP/o8hjs=; b=FAgc1WZUO1PPjWiDwoxu5c3sJikLsLsEs
 ++D6NmU7BqjeMlGiaS3yqeDVSGgORm5GY86cHqeTL90g/BHPP9BojmWqLvuwQUTJ
 w9VBcJU+tWtF5FI3iYwRh4MZMGynoAULhPLqjYelMD3goR98SZehPorKqxx2uLpV
 OI1DXgmorb6lQKYA07D3LraASMTkwtQzADHwmKLYRJZPz4bND7tgfGgTNv/AkAw8
 kXVpyOhA4VqEq5oIB8F4FiIJhIHZ++3Thj5TCU/STRXw4wK2VhOjyvCvAP3Qg2JO
 Mn8s3F4pprSi8WrlhMMsDCmvtUiiT2/osID+vgvY1x6FbxkBQMfrQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjq02p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UE4ani007623;
 Tue, 30 Jun 2026 14:19:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gaf9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UEJc2w24904342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 14:19:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13BCB58059;
 Tue, 30 Jun 2026 14:19:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE00858043;
 Tue, 30 Jun 2026 14:19:36 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.10.219])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 14:19:36 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH v2 6/6] s390x: Enable boot menu for virtio pci device
Date: Tue, 30 Jun 2026 10:19:17 -0400
Message-ID: <20260630141917.673995-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630141917.673995-1-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX+xNwLC2JGbMf
 VKlw/B2QgJOG2athMa16Th888H5JVFoZA0TOcJBPs1uHMaqvoDyLebZUhB02lCqHG86zZ3PgV5h
 zBsSJQR1YIsBFDcLh+SVgdrFUEIenP9pOlcm3EnN1/C6Hd8p1pSHpXvOGxes0BXG6eBHxiwkgtf
 o64/23MToqitW8a6MFunqo3pTy9eFBRpG5J35xdBK2RWdkQXpVxKEw/yPyzdgPW4p6Whf6faxl2
 TZf9dMNFq20kv74tcHULRkB0Jrb4Nv4k2YfDeeFXiDGs1utvQtmt4BpUMfCNoObBz3k+VyKwS5o
 V28JLxgphX7et+66ybxHc1D6KUmH0k6/baOHjc289FA7q/gY43k5v1zqeRoXbBzHhRBJSPsNlPa
 86/QHas0pJE3Rd5tFLqXmSZ9U5uPx96pcHsKs7FB+XQgIJI6tr/TWWh16cz87pHD5KIjieqorUh
 k9m4d2b0hzp2Yiqw+kg==
X-Proofpoint-GUID: FlLtM_bCGh-xn6V_Ea0tT9Hi-IheNzct
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a43d07c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UmcbZtfwkcGgJE0Tj-oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX3p+nL1WwSw9K
 tA3mURUQNfyppsbXtpifkF4lOO1oB8N64ap1sfD67XpyTnNUq2jA4CRc0fr2hV7WauQop0bF/Nu
 0TXbGC1wHISQ35IqIf22RX4f0N/B+Hs=
X-Proofpoint-ORIG-GUID: FlLtM_bCGh-xn6V_Ea0tT9Hi-IheNzct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Add S390_IPL_TYPE_PCI to the boot menu handling logic to enable
interactive boot menu support for virtio PCI devices on s390x.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
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
index 9c147ac5fa..8bc6e8eaa3 100644
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


