Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F35C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7b-0007rv-VL; Wed, 26 Aug 2026 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7U-0007jg-8H; Wed, 26 Aug 2026 08:52:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7R-0002cA-Br; Wed, 26 Aug 2026 08:52:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW79T3893912; Wed, 26 Aug 2026 12:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=w/jC++
 J0n/f/K+phumqfP9X2FW+B59+gZMz3nKE3RP4=; b=FgGdmtvyRrwep6HAoX7BSl
 5xt5dot1tgD0T0zP+ipWYj4kOKMf0VoB7FMHvRKpw9P2MbVWzHxgynT7JjHaiHZL
 QV5hw3ewoezGukvwPHO4YFVZQzIBDDCFhxTsGFGxpeOruIRIz4rOCkxqTzQjKwph
 iEQswKy8iwESq3jOw6jeEz3bs6rRpBeVjOlRUzXWC3v+k6b4e/WLIFL8oYF9VHlu
 VUkWUVyXTJXLVZAoKxj5SFXXHw49FCL3MshmHH+kePAebRqpQqJnnRUZAl+taRUW
 eJGZ0X0OULcQVCjtxgZ+n2LoBQioMhctFu49MvJz0i+H8Xm2GoFQjAowz4Thzpag
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hxs9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfHXj002980;
 Wed, 26 Aug 2026 12:52:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qa5m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqbBu21561910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DA385805D;
 Wed, 26 Aug 2026 12:52:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 312A558059;
 Wed, 26 Aug 2026 12:52:36 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:36 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 17/37] s390x/ipl: Introduce IPL Information Report Block (IIRB)
Date: Wed, 26 Aug 2026 08:51:52 -0400
Message-ID: <20260826125213.1901252-18-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX+cFBoKAeOCOQ
 dTr/l4eWe8tyMDQYE++7Fs3te8FYZvtxDH4Z0VHXkG6oYg6YL4fP3nTEsDLGFZJit6pIOo4F5ZQ
 SHwvZbxn70yv6Wl5eSDv9/h/fSek/no=
X-Proofpoint-GUID: wYk82r9gR5KxwZA9pMTtflQEfJRbVMxm
X-Proofpoint-ORIG-GUID: wYk82r9gR5KxwZA9pMTtflQEfJRbVMxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX9hiCYPvrVnGM
 EDqYlFYUeNMnlYh+2SsPMozWzY3DiKfojBEQ3uL9giJZ7LafM5HpjEAXEFkB8EF647XhgHO2JEj
 n96CBKOe+qpBQdn3CetYlt4fyQWaYduQX/IE4puaZyXPJiia6oQd52pth/F+HyZFoUWNs4NpzFe
 bNOSZE6wszF2A14ovzWZihl8GV/BLtMOpYyUjTJvkgrA6nHFw4NoyKUPcmE/eQVCHqi2dQ7cpBt
 ftoBF9Eop8y2Z87VjoChOxE9vhM28LnDcexaXNn41+WC9Mx1g29BA3PxHyok8CfFAO71yb/RB4J
 WiqtGlAKDmHF3m9eueisbl04d5W7TqX0Vkuk9tSZWBBR+sbWggC8+knAZP30wacAzYJGDToSkj3
 zpN/ARqEofsQNShwF2rwLNqDHSKDIIcm0Hr0yFYmc2XOS+OOtRJvTtkngdoOrxO/wJy6IR0vYdd
 zLu4jVP5zSVYN0LLVjg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ee197 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1NTGDykL02WXTEG3Jz0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
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

The IPL information report block (IIRB) contains information used
to locate IPL records and to report the results of signature verification
of one or more secure components of the load device.

IIRB is stored immediately following the IPL Parameter Block. Results on
component verification in any case (failure or success) are stored.

The IIRB data is reserved and protected by the guest kernel during early
boot to prevent it from being overwritten before the certificate data is
permanently saved.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-16-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
index 0ec6a6d1a7..571f831780 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -34,6 +34,9 @@ typedef enum S390IplType S390IplType;
 #define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
 
 #define MAX_CERTIFICATES  64
+/* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
+#define VIRTIO_MAX_BLOCK_SIZE   4096
+#define MAX_COMP_ENTRIES        ((VIRTIO_MAX_BLOCK_SIZE - 32) / 32)
 
 /*
  * The QEMU IPL Parameters will be stored at absolute address
@@ -148,4 +151,63 @@ union IplParameterBlock {
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
2.55.0


