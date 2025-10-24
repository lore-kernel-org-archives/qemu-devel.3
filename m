Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8032CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCE4u-0005iZ-Er; Fri, 24 Oct 2025 05:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4k-0005e3-AU; Fri, 24 Oct 2025 05:27:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4h-0003of-LU; Fri, 24 Oct 2025 05:27:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7c8j7028015;
 Fri, 24 Oct 2025 09:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Gq/WHDlUh8spgPYBp
 EywHSfRNf6ahpKsKuWx0r0w/P0=; b=d5+1SUfULlPUeK19jpgQBzlfRRvzgEX/j
 ntMJY65P7RK1GoTt5B/OOeDJQAAHPVFuOx6Byow03f9AbOFMCMTuwBSOJvdm4taS
 uOzLtkHk7vW2dgcjqyXtyBmGwVPia/JkvO95Fa+OWQQnCyXRJVIy0rbRI/iTFqqh
 C+OoMXn/jhYUM28BveS+5hmg2eho1DgzccbVXKGZmBkjb7PTpNcIacc22m965qCR
 unCaZ7RREVyiJ//ILTIvQIf3kyIC352b9n2LNfqmB/9Pcr7Jnxu0CLPoTcBr33gL
 nSFG0Cd7gJdmtOHSwZr7a2Nl4J6sSjOQ678/bRbTSalmry/QQF42Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fpmdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9R2v9003876;
 Fri, 24 Oct 2025 09:27:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fpmd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O62NVr024940;
 Fri, 24 Oct 2025 09:27:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkab0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9Qvvl27591286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:26:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A3622004B;
 Fri, 24 Oct 2025 09:26:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A44AE20040;
 Fri, 24 Oct 2025 09:26:54 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 09:26:54 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v9 4/6] core/loader: add check for zero size in
 load_image_targphys_as
Date: Fri, 24 Oct 2025 14:56:16 +0530
Message-ID: <20251024092616.1893092-7-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024092616.1893092-2-vishalc@linux.ibm.com>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fb4667 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=EMG23Z06JWfOmfJaRK0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: XYlBg0HRKC3sTjyow2U7j7UBZo8LcuPJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXy3bfjb0ma4UC
 3CP4yrcYxecNovPswjpgJ/Cx1F27q3vN5juxcRrFcWyIB12xjpwqiB8jtWoDeSkpfcK/OoQC+4C
 dGaMOGNgNcJAJV7TMvL0BJ3CjtCRRFzobi9J1aCxuP6R4H6vDetWcQLbM0vlP2DQNzA2bPZuUSQ
 Vj9ghg3wUBj4DlInW3A3jaEsFsjz7C1MGiJw5AFTlR2XoNwanw8LuD33gyrMHE57qXH9EZHRnuD
 fsfYn6oApw8a0g94YLcUbQ6H3iYQtxx9THkROnPvCQF2+sS/v1/XL3y5aSoyPgbm1IywP7KL28N
 QT2MaaQWZS/0E04QXSjLVrLrNrjl2lbyj0pAawg3sdd7gqzTV9U8ECPKixWURqZOUDqXoOMrPoi
 d0CYV9TjO+nThLva0M/93UQEOXoIOg==
X-Proofpoint-ORIG-GUID: lANj6Y7XqY55rI1gerHFX9XtGX66Eamd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Currently load_image_targphys_as() returns -1 on file open failure or
when max size is exceeded. Add an explicit check for zero-sized files
to catch this error early, since some callers check for size <= 0.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 48dd4e7b33..6717324527 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -141,6 +141,11 @@ ssize_t load_image_targphys_as(const char *filename,
         return -1;
     }
 
+    if (size == 0) {
+        error_setg(errp, "empty file: %s", filename);
+        return -1;
+    }
+
     if (size > max_sz) {
         error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
                    filename, max_sz / MiB);
-- 
2.51.0


