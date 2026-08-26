Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14551C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7N-0007cZ-K7; Wed, 26 Aug 2026 08:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7L-0007b2-Ss; Wed, 26 Aug 2026 08:52:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7J-0002UG-Re; Wed, 26 Aug 2026 08:52:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCWHK72878255; Wed, 26 Aug 2026 12:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3t7RBxm4Imxo8WcrX
 9e0/oyCeU2lf3/0iltDJC50VKw=; b=SLPafclqQNen/273ehexOuEVkhPEgkS9w
 2dlGc9U0PMdtRmnG6x77ZsYJOLPrjegjNQ7nxmOJRu0pqnLPUnzcguq29GuxCivI
 1Yz5NX+KkQTg1r1JTQPqlx13FVffn4469SMaQXPeAbBBXCTyebgBGmrU1xROnj8e
 M6qhPZlgSWUjz/UsVBufnnTBqP2+pclS0ZfbBkknHvR7CIvrN188d2NwnVKmYWnq
 TC5fXEGfeheInyHST2SgdhLNHziBkbxOWR/0JE8wVvxAJRNt1GkdhjlaEk3VN33z
 X+Jv4rWsIMrBW6BA+s1+UICuwFNSDGJo6i4r/oVXUMHmLbOUPQlzw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726epkk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfIv1002343;
 Wed, 26 Aug 2026 12:52:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k1xwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCpodt20382346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:51:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 972665805B;
 Wed, 26 Aug 2026 12:52:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3F8D58059;
 Wed, 26 Aug 2026 12:52:29 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:29 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 12/37] hw/s390x: Define finite size for single entry VCEntry
Date: Wed, 26 Aug 2026 08:51:47 -0400
Message-ID: <20260826125213.1901252-13-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8ee190 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HeWPiYe96b1ufxwsDYQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX+I1HDZeiZHEb
 Vhfr+4+vH876weaMCL56heGJL0QVDytZIDfGk4MbVVV2vzhXsSvXh6RUai6RB1+hhFh/zKR60ky
 4fVR43WlmjXkQj0uUHa33QRFrYS41VY=
X-Proofpoint-GUID: 2sFh8LuB4pcVvzp8dIWi9INc9w1GUAav
X-Proofpoint-ORIG-GUID: 2sFh8LuB4pcVvzp8dIWi9INc9w1GUAav
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX8vimKCRSQd5h
 gA1TFM0oqES5GM0M0Yih1GPbgbI42bzu9MJbAgjB2yRm95bOlJLzFpJZnDm+q6yMwYtYNzYpN0q
 iZuVMq/bFvlacVYSOoaBmVUGDioBZllRWktIqX33ybTaA41PYBsMXljO8p9fYza3j3jwxYan/M3
 /xs7hMaj4AgMCfHDKf82J8Lws7+XrFq0p0970fvvmeQIfH7aUBHjnPp5bgiIazRz1UGD7KZTb/t
 bhM5MlJtudk/5Kb/5UDh3nrraKRLHU/FXKzIDSKgbvlmDIStllmn6InI9aQPWO7uA2Ueaj0ysiO
 F144RcBwsM6WZNuPFdMHgQz1dfeiqFUhNCf2IFN0wsWLXm343YXb1ADO9BsYSHhMIttDuxL9JB4
 1RJ1C9IGDHrrosU65tmcgm9maOYagJOdBenogcwZyDt6XK2dKWlamzQH01urOZFdQFfedQYInqk
 /Nh/sbVsh1L+tZoDZ6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

Define MAX_VCENTRY_SIZE(8KB) and CERT_BUF_MAX_LEN to establish a finite
size for a single entry VCEntry. Add validation in update_cert_store()
to ensure certificate data does not exceed this limit.

This finite size definition is needed for proper memory allocation and
will be used in a later commit to handle VCEntry structures with known
size constraints.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-11-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/cert-store.c          | 6 ++++++
 include/hw/s390x/ipl/diag320.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
index c679406c2c..c086e75f75 100644
--- a/hw/s390x/cert-store.c
+++ b/hw/s390x/cert-store.c
@@ -91,6 +91,12 @@ static int update_cert_store(S390IPLCertificateStore *cert_store,
     cert_buf_size = ROUND_UP(cert->der_size, 4);
     data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
 
+    if (data_buf_size > CERT_BUF_MAX_LEN) {
+        error_report("Certificate data size %zu exceeds maximum buffer size %zu",
+                     data_buf_size, CERT_BUF_MAX_LEN);
+        return -1;
+    }
+
     if (cert_store->largest_cert_size < data_buf_size) {
         cert_store->largest_cert_size = data_buf_size;
     }
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 7fda2d44fd..f3c23a3176 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -92,6 +92,9 @@ struct VCEntry {
 };
 typedef struct VCEntry VCEntry;
 
+#define MAX_VCENTRY_SIZE      (8 * 1024)
+#define CERT_BUF_MAX_LEN      (MAX_VCENTRY_SIZE - sizeof(VCEntryHeader))
+
 struct VCBlockHeader {
     uint32_t in_len;
     uint32_t reserved0;
-- 
2.55.0


