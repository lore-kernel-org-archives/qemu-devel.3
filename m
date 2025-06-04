Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC847C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw8Y-0004aV-Ga; Wed, 04 Jun 2025 17:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw82-0003FR-3w; Wed, 04 Jun 2025 17:58:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7z-00073e-V9; Wed, 04 Jun 2025 17:58:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554EQqUe020207;
 Wed, 4 Jun 2025 21:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QQrn3Pn4Piy2fq5zL
 N/qv6w9Cflm5IrhYEE8Kbe7W7s=; b=SBhRV9Dt1GRs/Cl1W0kgSpHZZXS4kc/hS
 mtqnPuhMCEmJd2aD+hlrrT6nB5E/JWi++b6wkQVEk8evONCiCbKNEJrk+7taJGiy
 AiUAHtaV70ExOQczbPp6dD1kINtiYAhCKD8bYxqGNiAZl4H2LSIHpTJNYdFqg2DA
 kWsFyMHjC99Kr1IZDp7QAjDl+OCy3YRDPLNLLFAsULvNJMg3l9W8TeQjKLQ+BL41
 dNTyCtWGM8yaAJOhoVc0E6M0L2xiJsLr/dMoMHEBhpOvnwR5AE6lG9kT3OONvRnc
 xX3+WQ0NJ2BQLwLpvo765qtd8q0Y8Ndjm65PS9Xd0IRDFU9I8EemA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf0d637-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:58:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554J9eho031700;
 Wed, 4 Jun 2025 21:58:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470cg01yqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:58:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554Lw74p33751770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:58:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0493258045;
 Wed,  4 Jun 2025 21:58:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDA8958052;
 Wed,  4 Jun 2025 21:58:04 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:58:04 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 27/28] hw/s390x/ipl: Handle secure boot without specifying
 a boot device
Date: Wed,  4 Jun 2025 17:56:55 -0400
Message-ID: <20250604215657.528142-28-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZZeRgTwgSaaCvv0x_prIwRo-nMq_Tok5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX89+mr7gG2QvZ
 w+N1brFHEUtX0PhdZoT5i2xjHlBSVPuWjz2QzWiLOW8A3GUvLn3hIXXQHWGPL+Q3iDfKYln4lW4
 BwcwgSjii1oYyHtJKjIUEhSi0WqxNtn0NdNOHCAGVp778LYYgDUcVtxjDZbd9WFy++4fJvjhUy2
 GYY+pMvsoN1ie/J8tE6Lnx2lX9AUC68qg8//o0p7zX5HXZYvypannSAH96R/uupad8DmmiXh5mB
 2SlOXE+PVvCrizc4Ul6XDg71MfxZTQPWSXqdH9UPavUbUYwpHZvpvuc78A1JHkQxWgVOngmYvik
 1wIIObka0bZPL49nnrPC9PmO9tCmdA++Zt1rqlpS7WyubblCjVfytrLjsdeDDELGpUFK7QKstFh
 /VRZ9WPZ9QiwN1mA9GWBTscUhqA2WPx3GxmlhAStxGWoEtkkAebJgfPy8YJWZnsXlSxjccaM
X-Proofpoint-ORIG-GUID: ZZeRgTwgSaaCvv0x_prIwRo-nMq_Tok5
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=6840c171 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=98YBU2wH__9RKlX8yukA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=827 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index a196e1d648..da50b52c75 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -764,6 +764,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         s390_ipl_create_cert_store(&ipl->cert_store);
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
2.49.0


