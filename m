Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0000C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHG-0000Gs-Ey; Fri, 03 Jul 2026 13:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGg-0007rL-JB; Fri, 03 Jul 2026 13:01:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGe-0003E4-KD; Fri, 03 Jul 2026 13:01:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJ8tq3237356; Fri, 3 Jul 2026 17:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5/C4+8
 Obu9t+F8Dno8hhZNl0p8nzU7MhbERiaRJZ0wY=; b=RaP7S/TGo/zrTHeH4iBQf9
 Z1CGjmOdUAzve4z+Ck7kkXeI1i+gwb24wH5HNCAen99LGFntQ78bLzRFxHEC0AsZ
 mlnRIHnyPsbT2JU8j3/u7JSvbeeERwv1vBoHZ3Lus5exKMrYib8VFntmf5394m62
 19mmMQGjMSY98gZb/L1ZQq+CBUQGnFZ64IyvlwhGtr7uA59sXpx9BKniIkJ1QFAi
 ANXuqkPs0gazayHUZgGR/4Cn9PQpv/PGCRcCxe7ZhmaXe4szVIpJOnvfgatRiCt7
 AEQToPcSsyxWCcYxrR+BFA5wE4MxxU5CPTyFXjsc2qoYGpMZyJLOdKhueG0fcFjQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rffmf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Gnavo020075;
 Fri, 3 Jul 2026 17:01:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gsk61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H1PFL21955320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B9B85805D;
 Fri,  3 Jul 2026 17:01:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 221655805A;
 Fri,  3 Jul 2026 17:01:22 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:01:21 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 15/33] s390x/ipl: Introduce IPL Information Report Block
 (IIRB)
Date: Fri,  3 Jul 2026 13:00:12 -0400
Message-ID: <20260703170032.1893204-16-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47eae7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=1NTGDykL02WXTEG3Jz0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: epEsYLIF0PWiVlE4c5ZLl9HdDRZbpa4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX+5fO2W1VXzsF
 YWFFqWWZ3wp2J2DLbtKmNHTcL83lRKAsE1j9js9is+X+p3zaOABRQV+DCChIRP/k1sNCa2B+PjA
 OrhRFOtekGN+ESFs/Xdfa1M84v3IP4rSYhjscMoUFUJvFLdniI95vcEaXTEYS0AUBWO0dbgxJfP
 CgpyAFLnXxIXGXpOWLlMBkR3cUrPr71ibMi6GA31LAjLPk0FgqD8GzgVOONHMpGzNQ3ytB6nizO
 USySKWUOwDcsEGM+qI22WvE57o5T/kNWWtRNA8KzLp0G7DKFHzgLWlCgPq3+LBvTO0ftNaHr0AC
 nEDxHvrQeaam5Yd4D019GPW4fbfZzp6I1QON7u9reYwRuhqYGzGmKq5g0xdw64Rr7T1l5fTrDwQ
 ArMkfZFLKPQhulX8Jc2VtWiEcOzKgJiPRw8pQ8/0VYYdSJpjgnodDgwXOTfp/3eyzxpVwmfehvP
 jMZ9UApTLww7yMkEqkg==
X-Proofpoint-GUID: epEsYLIF0PWiVlE4c5ZLl9HdDRZbpa4B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXzVaE5Yk1h6mJ
 Ugu63QqQcG/S702K39Gn2uQ4bts5Guf5ArIEsZEW0UqtbNQtR2enBk34CNvFTKrDyQFoRQkfAKS
 AYwTqxYCk74qG/LF3KxlhbuVkMeBGrk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
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
index a8be863548..850e4a7497 100644
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


