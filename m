Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5B0C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhGs-0007xx-5U; Fri, 03 Jul 2026 13:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGO-0007gv-WD; Fri, 03 Jul 2026 13:01:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGM-000345-PH; Fri, 03 Jul 2026 13:01:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJlNr3247555; Fri, 3 Jul 2026 17:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QGXDDUXKK2xre5/Sn
 nNg35LEW56O+VfWaEd/bKTCS6Y=; b=ZQuXwsAkQ+cQ8g5QUcK+AMj8VWbTDrV4Y
 o8D6aUes9KXuGby3LANS07XIKrmCjxU9vhuAp7C1gFlfzi9E4RZSeExX4WDda5Ti
 lidoBUwPrINxcJBrq36+v5UFM7vD7whD/TKJEnKjVAcHGf1K+Ll/B8Gr4CykNsPo
 Nrcf8OQH9hLpo952rM44cwJXotaGPdDnjZtuH9el72YRGWFWVHM2WRsa/Px6q2gx
 o20nMVbYktkRsP0KmUkDsXQni4nenxZmHOSxUrvUpT3OveZ4tBBzv1e3Xy3tYwJ5
 ddZuB5hDwHA/jz4Coyg7HD07VsA7xWr6YT9h+tLcxID5cL3Qkozdg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qafsu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Gnjj6003106;
 Fri, 3 Jul 2026 17:01:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhsndb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H19LE33096396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1078A5805C;
 Fri,  3 Jul 2026 17:01:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18A4758064;
 Fri,  3 Jul 2026 17:01:06 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:01:05 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 10/33] hw/s390x: Define finite size for single entry
 VCEntry
Date: Fri,  3 Jul 2026 13:00:07 -0400
Message-ID: <20260703170032.1893204-11-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXyQBm/KDXKvlL
 PwXA2ziRoQT0h4NINZDQQIimTBWNZVV/1vKq0lfJ6MfZ5AyCPOSt8iUFfOTziuupF9EefDTleEn
 q8Ea9YBIW1RCky5yR6R6zM87hxl3V6/FI6KnUanFXE/u8Y46ZAQQutJ9UCWLpfFWcK5Eumf/sOW
 dU+uofBAqwfd8tmS2iHTCcl64s44+G+axhoXnsQeOs2Wt8HBZm254SQddrHi977A7rSaP1NS4c6
 Q7wk2jQrVAQj/ZwXF5CA19o16NSSnjXi+25QmP4t7zPhfiv5HVLq72XJYXZbHM+GQ6lDLQX4vGF
 i2762ceSlLUy+M9G4snK1XhhD5u9xP1nuxN9QGiZWes0RaZo8q+S+lO9ONa/BSkzclMWhYd8rG3
 Ukrm7hptIoKILNTzJVEP60HE0X2QPjh7Ucdh7e8Bi29PtjHRRTI/n9NpgacVD5bkiGb3kO/2KBs
 JIEodscdBdml29xReqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXyPhMG1XB4V3u
 3cgx5D7oDVpfnLUcVHdz6dRPh3EWMzAqjHB0TQYL4l80huCU4F8eEkACAHXj2nYYxQ7EzMZ9QmU
 +leYYHOEqQ7TLcNuYmEoSIhL8YFbMhM=
X-Proofpoint-GUID: _4FovV8T5Q0RC-zBKI-E2PV0fJxwOlXr
X-Proofpoint-ORIG-GUID: _4FovV8T5Q0RC-zBKI-E2PV0fJxwOlXr
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a47ead7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=HeWPiYe96b1ufxwsDYQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030167
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Define MAX_VCENTRY_SIZE(8KB) and CERT_BUF_MAX_LEN to establish a finite
size for a single entry VCEntry. Add validation in update_cert_store()
to ensure certificate data does not exceed this limit.

This finite size definition is needed for proper memory allocation and
will be used in a later commit to handle VCEntry structures with known
size constraints.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/cert-store.c          | 6 ++++++
 include/hw/s390x/ipl/diag320.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
index aa2c1259eb..e5f79c4ed7 100644
--- a/hw/s390x/cert-store.c
+++ b/hw/s390x/cert-store.c
@@ -86,6 +86,12 @@ static int update_cert_store(S390IPLCertificateStore *cert_store,
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
2.54.0


