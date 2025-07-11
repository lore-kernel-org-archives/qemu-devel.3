Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366BCC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL2e-0001cX-8E; Fri, 11 Jul 2025 17:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2b-0001Rf-Qu; Fri, 11 Jul 2025 17:12:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2a-00033o-5e; Fri, 11 Jul 2025 17:12:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BFdHvt029137;
 Fri, 11 Jul 2025 21:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QQrn3Pn4Piy2fq5zL
 N/qv6w9Cflm5IrhYEE8Kbe7W7s=; b=DsKVI7mtxYq2atG8zyPEEUAKZSi1LRn1g
 sD8ges8tjNOMmDHLJyYED2deiBpbBN/a6FpsTUpFj1Mqq2PtRjP7auvVEukgqX3H
 HakDQFPc2Zs27DC/4Y6fQCimZiaGfdMwT0QSwILgzNms6JHOfoGrEkitIgBPJ4Rz
 s3uSLhqPPXjUZ+JCgfDx5hcGgj2JUSIViWUzJUzLowggJCvq8S20uuRCB8AyWNYe
 7oim4bT6X+RFfplyxX9UR2dyWKCloKTJKXJzO8fQ8YNSYFPcxnrh7IDIyNRF1KqO
 i8+3jk7gWkNziXxv7vYjfNRqwWY2e1TjquMQO0GH5dDTduXTVTRJA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4n6vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BKXcOr002926;
 Fri, 11 Jul 2025 21:11:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmveev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBs3k7471814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3A0358067;
 Fri, 11 Jul 2025 21:11:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A53A5805C;
 Fri, 11 Jul 2025 21:11:53 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:53 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 27/28] hw/s390x/ipl: Handle secure boot without specifying
 a boot device
Date: Fri, 11 Jul 2025 17:11:03 -0400
Message-ID: <20250711211105.439554-28-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfX2PphT1Pml6SP
 qRg3U+Eo8N+KfmulD5aYRm0pBeyGWhFOwwd+EykA9z6YT/8Pcasj5LWvk2VbqtGQQ3UdCxpFy59
 bUTpPqWMNgBVnXkuKmXfnS0aMM0pN7rb0B2NQ1wRoWUHsr547HLdWevZV3y/r85PyNAxgsgUBkD
 zqoecoeUP6ie2Qz19HKh/XfXb6CDaSUUwzH3OqAGKCpQHbwTKQ6lRaDVBAktOxrAkPxMXg1U0K/
 DwflV0kuT6SSzYuV/hvm/qkhbYKIAzaLPSDob76j8Nhg2Okc6cocm9zJM5zilNhy2NroaLWb7ga
 mxdPuixFuSTe1K6vXJXqkdqLGLWAIl8RLOBcthPJx7PpfKw+YkHvhlxJG715a+e7fAn+FecpqUC
 /sw9R4KiRKIwkxVfJdyxy8TbMVESJyKZzxHtSiZpEmYigj+1MGxoi59UxOC0132p1QfbhlS+
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=68717e1d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=98YBU2wH__9RKlX8yukA:9
X-Proofpoint-ORIG-GUID: tkYsitj_1RVp4Fjf6KkS-hOm2GTtt_54
X-Proofpoint-GUID: tkYsitj_1RVp4Fjf6KkS-hOm2GTtt_54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=817 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


