Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83439D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSisG-0000FF-9t; Mon, 08 Dec 2025 16:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiru-0007rC-8M; Mon, 08 Dec 2025 16:34:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirr-0000my-Dw; Mon, 08 Dec 2025 16:34:06 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8L8JQ0017887;
 Mon, 8 Dec 2025 21:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DuoRUcjHOV+1ufsdf
 MBGE/kIzrSux4/aR14Wx8l/zos=; b=CNyWjhqOECyQUIGL7gyQpoKhWwZBXlz2j
 JzcgnJKTuLykm+of8RaLUBhHkXG2T46V6RkTr3IBotTJ9S4fJ7n6phT5/n6meUR8
 LqdroOWC975VCm+Bn+qkhRqqn+SNoRT5fO7Bx5Zt9MNRo11V9y07ibh+TgLFwHUC
 2RG86QLMYgUv2G/o+zaBUUmMg9alYy32z7boKybbMSVIqgC5gN+9cHd5C7DqP1yn
 p8BiZtQWUHcCmoSnxvrtC+43sfjbfgOkR8k6r3wXpSvjwEMy2K7PLzF+iMK0LeFK
 warXp58jE9K+wovSHug6tHMRC79g4yrXBOqrNKpRONNbNlFSy1/0A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvhmp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8ITc6d012432;
 Mon, 8 Dec 2025 21:33:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajqnq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LXdxT33620562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:33:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C03A58059;
 Mon,  8 Dec 2025 21:33:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5C7F5805B;
 Mon,  8 Dec 2025 21:33:37 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:33:37 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 26/29] hw/s390x/ipl: Handle secure boot without specifying
 a boot device
Date: Mon,  8 Dec 2025 16:32:43 -0500
Message-ID: <20251208213247.702569-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NPRYcIN4KeVAw8F02e-1frkXHlU1iVpj
X-Proofpoint-ORIG-GUID: NPRYcIN4KeVAw8F02e-1frkXHlU1iVpj
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=69374435 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=98YBU2wH__9RKlX8yukA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX8APUsWTBIN27
 iWZaiOvMVEGndrlwCeQ4/Pfx4NydoR8tVTtJ8gf2AtrL+9EBR2WxYUPhScrWm7JKAha6AQP9DC+
 Z3A9eI5tSNjpwFYKM5ZsQJgjZ2f2yqjyX1iSa9/O0pkpeYojZkrXbZ70mhftcoCittUOL4cStGX
 ZjdvH2r9OrvSbx4/J4V74cn3godgp8ORuKA0G698Y2cEDqbvWs7iacpvSuvR1B/OyVnS1AHJHKd
 LID5IITqxolo1OsXZf0K+qfaXkJSOhNgFl0o4+ZM1LMaBdrGWl5sXERMahU1HDwPtJkb9QbiBZl
 HRbkWH7vmo6ARXItffeTU1wY0KUCe5UsudD+iI4ig9EKHISQzBtthXHz2uO5NDO33dqgVZbosst
 nH+TsFJ1rfzvc/mEVd2GI/TC8P4ZKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If secure boot in audit mode or True Secure IPL mode is enabled without
specifying a boot device, the boot process will terminate with an error.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index bfac156afe..2809fb718d 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -771,6 +771,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         }
         if (!ipl->iplb_valid) {
             ipl->iplb_valid = s390_init_all_iplbs(ipl);
+
+            /*
+             * Secure IPL without specifying a boot device.
+             * IPLB is not generated if no boot device is defined.
+             */
+            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
+                !ipl->iplb_valid) {
+                error_report("No boot device defined for Secure IPL");
+                exit(1);
+            }
         } else {
             ipl->qipl.chain_len = 0;
         }
-- 
2.51.1


