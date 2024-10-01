Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72331CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svevY-0006c8-MK; Tue, 01 Oct 2024 11:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svevV-0006Yq-76; Tue, 01 Oct 2024 11:36:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svevS-0006W8-Q0; Tue, 01 Oct 2024 11:36:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Et9vh008906;
 Tue, 1 Oct 2024 15:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:mime-version; s=pp1; bh=aEdt/bDhSDA0B
 wLzKp4CQhkKVnFzNqW6hVmzR3TaBIk=; b=sGpae2Ou+QIoebyizb6AE8X4+k2+5
 tW3nKcJcAEc1ztsMbYy8Otdk0Vq9LcMY/5C5oM1J1RUFUqJhVctU4deGZf6SyLtK
 MsBrPVdLqukTM8hEjAGS1BGork815iItcK2+0/EIeDay3AYGCZk+gbdRhGXlGBYX
 62/EggyXrbibDiSFPdca7ZQRv7DyhJOSknSbYNxWL6V/kj564i2YUFL9jG1jvSM/
 BythF+4Xknx3wmbPY4FiQq0KuxczpNfVnW/Pi2+4w7cGauXh0Ihcn2lFUqaNsbCa
 MuHwtrPRZ2jIYaNzonOgc9VqwuYvUBktXGvJrCrNMVwmWWTPt2fcyXH8w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420k8s07kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491FWifN026591;
 Tue, 1 Oct 2024 15:36:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420k8s07kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491ElOoE007923;
 Tue, 1 Oct 2024 15:36:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxwcx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491FaOZK34669304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 15:36:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36F9120043;
 Tue,  1 Oct 2024 15:36:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA22F20040;
 Tue,  1 Oct 2024 15:36:23 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.fritz.box (unknown
 [9.171.30.227]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 15:36:23 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Jens Remus <jremus@linux.ibm.com>
Subject: [PATCH v1 1/3] pc-bios/s390-ccw: Clarify alignment is in bytes
Date: Tue,  1 Oct 2024 17:36:16 +0200
Message-ID: <20241001153618.17791-2-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001153618.17791-1-mhartmay@linux.ibm.com>
References: <20241001153618.17791-1-mhartmay@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QBB2fVHnhiREZ4XnlC0_pAVhjrniVIJa
X-Proofpoint-ORIG-GUID: puY83N4d7MqcvybWTw-RGvq7JfrycrD7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010099
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jens Remus <jremus@linux.ibm.com>

The assembler directive .align [1] has architecture-dependent behavior,
which may be ambiguous for the reader. Some architectures perform the
alignment in bytes, others in power of two. s390 does in bytes.

Use the directive .balign [2] instead, to clarify that the alignment
request is in bytes. No functional change.

[1] https://sourceware.org/binutils/docs/as/Align.html
[2] https://sourceware.org/binutils/docs/as/Balign.html

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 pc-bios/s390-ccw/start.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 061b06591cff..576fc12c06e8 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -112,7 +112,7 @@ io_new_code:
     lctlg   %c6,%c6,0(%r15)
     br      %r14
 
-    .align  8
+    .balign 8
 bss_start_literal:
     .quad   __bss_start
 disabled_wait_psw:
@@ -125,7 +125,7 @@ io_new_mask:
     .quad   0x0000000180000000
 
 .bss
-    .align  8
+    .balign 8
 stack:
     .space  STACK_SIZE
     .size   stack,STACK_SIZE
-- 
2.43.0


