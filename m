Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665E3C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whExt-0006zE-Gk; Tue, 07 Jul 2026 19:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExr-0006yO-U3; Tue, 07 Jul 2026 19:12:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExq-0008N4-Ac; Tue, 07 Jul 2026 19:12:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Mn0TB164339; Tue, 7 Jul 2026 23:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vPbsf0
 fQDz21lLYPEu+ScWbC6o6g/o4YbVFU/Zd/T54=; b=GynkWLOafH6iqiGNDyWMCR
 sA985QQxL+eo3HCGxlBo4R1y7UiS9eh5fZ9v4x36owAcd/nIaZ+UEEffNRHaqR70
 eFa+81CWqJRED3Sb9d4iufVJFHkh6aC1aDAP6xZ/MePML8xmqw6zmb1sLtFOCt5V
 g5eAoUv+SagIuKwWA/lwZgofW/33nUGVmH7WRJKHFaW/QstZixuTxzBqkXPh454x
 poIkjmiIZvBn+m03K2OFUFTdsNoaQFnHgvKJaGdj8mobC5AmsZIXd4JALpl1p7ca
 uiVkPc+1QvTdYVsY8IZMRH7mwTgp682X54tkaiu+NYas7//9lg6KvZdDPU/26vqA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stst4qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:12:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667N4aX8012039;
 Tue, 7 Jul 2026 23:12:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg4u45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:12:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NCPh926411616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:12:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C30D58054;
 Tue,  7 Jul 2026 23:12:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A7ED58045;
 Tue,  7 Jul 2026 23:12:22 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.32.2])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:12:22 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 15/33] s390x/ipl: Introduce IPL Information Report Block
 (IIRB)
Date: Tue,  7 Jul 2026 19:11:13 -0400
Message-ID: <20260707231132.2492104-16-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZI9r2BURka3VfgkwtepM0rcVPYTfzyBn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfX2NfEA7NxnuFz
 UZZRGHVwfARVoui9r5KiRVsZCdfOXDJ6tumO6ooFgI55w+IW4FjrsgSnicJN6nXmh+tP9JeQK5b
 cQxjxBoQGGRABFy6J5KBVtd/vTGjaBs=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4d87db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=1NTGDykL02WXTEG3Jz0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZI9r2BURka3VfgkwtepM0rcVPYTfzyBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfX6kpwC61u+Wyl
 bQr9giOMaIAuL553eP0z1dtIoDkOyJwfBfpzHo98ekdBCmWajQEXQZdU6eMmT4FZn2DVbu27Dyv
 0n4mbkLAG1n79feMmuBCYo+UKw6Zplzc3LTHTDkuru8q61rGCIsSMt1tUXDgtT587MbUCsThkqd
 +9VUI+sQrUfKcAVsYzvYvswTfMtOfPYbprxlww7xSijAuCh0tKuEmITuHpVNALpxfmF5IakG/0m
 LLnxmG8knSDJCsSxJFpqw9dTk8s/P74IR83lxzsRPMgJ3HE0KBtZi0GTajQbv4LIGj4FDl2QYwG
 u2AR/6mvE9kD1lQSJhGcpa3zO5mUxZl0XJzP/p/WlAJjGNQPLEX3OeQ3i57CN3rtfp+usj9+Zsd
 xI2OG59sD3O26uzXfb3uJPn4MhwrQ+c1eke12EblJL2l4X4FltFByZCCe/r5dfpfp+GmymHhExb
 oTFT5m5ww0TWFnvDOSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070224
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

The IPL information report block (IIRB) contains information used
to locate IPL records and to report the results of signature verification
of one or more secure components of the load device.

IIRB is stored immediately following the IPL Parameter Block. Results on
component verification in any case (failure or success) are stored.

The IIRB data is reserved and protected by the guest kernel during early
boot to prevent it from being overwritten before the certificate data is
permanently saved.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 21 +++++++++++
 include/hw/s390x/ipl/qipl.h     | 62 +++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index d8dcc77ba2..113acbeda9 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -101,3 +101,24 @@ Subcode 1 - perform signature verification
     * ``0x0302``: PKCS#7 format signature is invalid
     * ``0x0402``: signature-verification failed
     * ``0x0502``: length of Diag508SigVerifBlock is invalid
+
+IPL Information Report Block
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The IPL Parameter Block (IPLB), utilized for IPL operation, is extended with an
+IPL Information Report Block (IIRB), which contains the results from secure IPL
+operations such as:
+
+* component data
+* verification results
+* certificate data
+
+During early boot, the guest kernel reserves the memory region
+containing the IIRB. This preserves the data while the guest kernel is
+operating and during re-IPL.
+
+The guest kernel uses the contents in the IIRB for:
+
+* Boot logging: reports which components were loaded and verified.
+* kexec operations: builds the next kernel’s IPL report from the existing one.
+* Keying: installs IPL certificates into the platform trusted keyring.
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index ed1a91182a..45d25264f4 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -32,6 +32,9 @@ typedef enum S390IplType S390IplType;
 #define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
 
 #define MAX_CERTIFICATES  64
+/* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
+#define VIRTIO_MAX_BLOCK_SIZE   4096
+#define MAX_COMP_ENTRIES        ((VIRTIO_MAX_BLOCK_SIZE - 32) / 32)
 
 /*
  * The QEMU IPL Parameters will be stored at absolute address
@@ -146,4 +149,63 @@ union IplParameterBlock {
 } QEMU_PACKED;
 typedef union IplParameterBlock IplParameterBlock;
 
+struct IplInfoReportBlockHeader {
+    uint32_t len;
+    uint8_t  flags;
+    uint8_t  reserved1[11];
+};
+typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
+
+struct IplInfoBlockHeader {
+    uint32_t len;
+    uint8_t  type;
+    uint8_t  reserved1[11];
+};
+typedef struct IplInfoBlockHeader IplInfoBlockHeader;
+
+enum IplInfoBlockType {
+    IPL_INFO_BLOCK_TYPE_CERTIFICATES = 1,
+    IPL_INFO_BLOCK_TYPE_COMPONENTS = 2,
+};
+
+struct IplSignatureCertificateEntry {
+    uint64_t addr;
+    uint64_t len;
+};
+typedef struct IplSignatureCertificateEntry IplSignatureCertificateEntry;
+
+struct IplSignatureCertificateList {
+    IplInfoBlockHeader            ipl_info_header;
+    IplSignatureCertificateEntry  cert_entries[MAX_CERTIFICATES];
+};
+typedef struct IplSignatureCertificateList IplSignatureCertificateList;
+
+#define S390_IPL_DEV_COMP_FLAG_SC  0x80
+#define S390_IPL_DEV_COMP_FLAG_CSV 0x40
+
+struct IplDeviceComponentEntry {
+    uint64_t addr;
+    uint64_t len;
+    uint8_t  flags;
+    uint8_t  reserved1[5];
+    uint16_t cert_index;
+    uint8_t  reserved2[8];
+};
+typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
+
+struct IplDeviceComponentList {
+    IplInfoBlockHeader       ipl_info_header;
+    IplDeviceComponentEntry  device_entries[MAX_COMP_ENTRIES];
+};
+typedef struct IplDeviceComponentList IplDeviceComponentList;
+
+#define COMP_LIST_MAX   sizeof(IplDeviceComponentList)
+#define CERT_LIST_MAX   sizeof(IplSignatureCertificateList)
+
+struct IplInfoReportBlock {
+    IplInfoReportBlockHeader     hdr;
+    uint8_t                      info_blks[COMP_LIST_MAX + CERT_LIST_MAX];
+};
+typedef struct IplInfoReportBlock IplInfoReportBlock;
+
 #endif
-- 
2.54.0


