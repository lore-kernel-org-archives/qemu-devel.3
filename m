Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72025CD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMF2-0007gZ-7D; Tue, 05 May 2026 16:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMEv-0007d2-J8; Tue, 05 May 2026 16:19:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMEt-0000Dp-NU; Tue, 05 May 2026 16:19:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645GQor42269289; Tue, 5 May 2026 20:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FOo4Z3llJv7TuAf19
 ikt7Nbygl/fu/XQK/Vkc32Qpbg=; b=kxcAi/i8iw2ktE35kN7alvMwbvEemKDzB
 2zCzk+g7cgtIkoisvq8M4npQMGpTqUioLwpwVK/2lftri/675YKwB0ynSuthR+ch
 mTNuT/3LmRTnWprk3ZxT6sz2H4PKoAcDJE+fJxJcpWsQoFN1jH2yXsghwW//MqNc
 66qgfGTbPeDmYbC7QXD8W+eT49sQ3jLe+tKAVOBxYkSewbcIUTyb2mtyCSQ8BiUH
 MzTn7PL08H2H8ywmcfpuIadsYWltqjnIsxa1SdepQcL2WbhW5yXzaFhDIyfw5T4g
 QBwAPCzUqFXm0oIrRQsPu/SwIQRXbsLKt6nG15kEMqmyXjFm7LEEQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4n71j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9RNk002871;
 Tue, 5 May 2026 20:19:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkju9vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJQ2U31130318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53FD358059;
 Tue,  5 May 2026 20:19:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5A5B5805B;
 Tue,  5 May 2026 20:19:24 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:24 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 10/32] hw/s390x: Define finite size for single entry
 VCEntry
Date: Tue,  5 May 2026 16:18:42 -0400
Message-ID: <20260505201905.997996-11-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfX5j7BJYKxDem4
 C5CJyHkeUrIVltHBWj/xz7uNjrHI1gTQ2SC80blIdY689cdvHNdI2sPpCvSbnD47/icov5JYV8y
 7hvclfhyN9u3qQA3R/j2ZnEMeQCeLnqtRoyzfQ2m5DMB//9h6Nxga0TinORJ5uwASY7tYDOa9Ue
 uxwF/t1RN4PNoJ8AuKWDJ8x92vXpHOk3p4wq5RGd/S61qxu2Uml/85aGxcUMPx4myoyHAfuslhc
 XqmmDfKK03kfcu6246arQSE57KAcVRzVeh8GLUAjbRQuOGEluJ4A7YUDN/aQBBiL9sDfDTqCOIg
 bRH9XusSHP4QYje9aEZTU1JeS3VpvLtWmrwZUVmrZIkfjXN7jIP4Bpp/kTgH8wy2Uy0+VSvo3ft
 lQD11cggqOVsJsZFZHT+go4U0Cm5t25ga2kA0B9UeqgiSUywNt/OdDgsf+f7yrHxQumCKcn+S4r
 MRlfHWPkqrXK7NtD7HQ==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa50d0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=b9XrvJAKYeRg4TRbuU0A:9
X-Proofpoint-GUID: WVkSFdY3QNjXwQ4Mpt2VHagVYbSIUWiv
X-Proofpoint-ORIG-GUID: WVkSFdY3QNjXwQ4Mpt2VHagVYbSIUWiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Define MAX_ENTRY_SIZE (8KB) and CERT_BUF_MAX_LEN to establish a finite
size for a single entry VCEntry. Add validation in update_cert_store() to
ensure certificate data does not exceed this limit.

This finite size definition is needed for proper memory allocation and
will be used in a later commit to handle VCEntry structures with known
size constraints.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/cert-store.c          | 15 +++++++++++++--
 include/hw/s390x/ipl/diag320.h |  3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
index a4f15627e9..221267781b 100644
--- a/hw/s390x/cert-store.c
+++ b/hw/s390x/cert-store.c
@@ -73,7 +73,7 @@ static S390IPLCertificate *init_cert(char *path, Error **errp)
     return cert;
 }
 
-static void update_cert_store(S390IPLCertificateStore *cert_store,
+static int update_cert_store(S390IPLCertificateStore *cert_store,
                               S390IPLCertificate *cert)
 {
     size_t data_buf_size;
@@ -87,6 +87,12 @@ static void update_cert_store(S390IPLCertificateStore *cert_store,
     cert_buf_size = ROUND_UP(cert->der_size, 4);
     data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
 
+    if (data_buf_size > CERT_BUF_MAX_LEN) {
+        error_report("Certificate data size %zu exceeds maximum buffer size %ld",
+                     data_buf_size, CERT_BUF_MAX_LEN);
+        return -1;
+    }
+
     if (cert_store->largest_cert_size < data_buf_size) {
         cert_store->largest_cert_size = data_buf_size;
     }
@@ -96,6 +102,8 @@ static void update_cert_store(S390IPLCertificateStore *cert_store,
     cert_store->certs[cert_store->count] = *cert;
     cert_store->total_bytes += data_buf_size;
     cert_store->count++;
+
+    return 0;
 }
 
 static GPtrArray *get_cert_paths(Error **errp)
@@ -214,7 +222,10 @@ void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
             exit(1);
         }
 
-        update_cert_store(cert_store, cert);
+        if (update_cert_store(cert_store, cert)) {
+            g_ptr_array_free(cert_path_builder, TRUE);
+            exit(1);
+        }
     }
 
     g_ptr_array_free(cert_path_builder, TRUE);
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 35c652ff56..75065d2fe4 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -83,6 +83,9 @@ struct VCEntry {
 };
 typedef struct VCEntry VCEntry;
 
+#define MAX_ENTRY_SIZE      (8 * 1024)
+#define CERT_BUF_MAX_LEN    (MAX_ENTRY_SIZE - sizeof(VCEntryHeader))
+
 struct VCBlockHeader {
     uint32_t in_len;
     uint32_t reserved0;
-- 
2.54.0


