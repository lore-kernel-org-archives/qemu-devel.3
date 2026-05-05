Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F5ECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMF5-0007mk-Jm; Tue, 05 May 2026 16:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMF3-0007kG-P1; Tue, 05 May 2026 16:19:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMF1-0000Fr-Ve; Tue, 05 May 2026 16:19:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645HKrvF2578306; Tue, 5 May 2026 20:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=p2lWYc
 Qj09rovlfJi1pd/B+GTn7Bripb2R74MBKZsj4=; b=E0TfN4n6d99i4jaLvt8kF4
 oAerY/ikLYA4Rl3koCw+JfLLK0KiEaFo1CHk7OQQYSqcxHXBPe1gY5DEW9USB3z4
 bBq4w4cl3UyzuuZa4pTKD4I+3H3VmLw7WlWrQ795D0R9ocsTh2eu1VYd3gUGksbk
 +moUsg6ug5gSpt49xp1Y0B3ZyrkIEmHlZ1QFiThlpjyfz82HFiuo2z28d1uvUuwy
 b42haPEXxHXkmEjY/DECg/sSh8CBCdyj7OJOtqH+ICmSuigRGlLc+sFggnYrWERw
 e9VDrL8EU9Dpi5uw2f5zVT9noZP+pI+Cn1DeBsdqWn0CVf0CKRqwg+OZKnRCyi/A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4n721-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9Q12015549;
 Tue, 5 May 2026 20:19:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yb253-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJXJp26280568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CE2558059;
 Tue,  5 May 2026 20:19:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D44DF5805E;
 Tue,  5 May 2026 20:19:31 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:31 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 14/32] s390x/ipl: Introduce IPL Information Report Block
 (IIRB)
Date: Tue,  5 May 2026 16:18:46 -0400
Message-ID: <20260505201905.997996-15-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfX2C31Sw0eemjj
 Lu2nduQMi+MMIpjoEDvZTBJ0UFoS8cShYfWQWBAM07sRidUQ0J5U1c1865NRkoHvgzuV+i99jyO
 zOOA++8PvWWnGI91HSYB0Dc+Jpw9nqzpXJRtq0ukEdRJpOnWHWSkH0NjFzVRKhEn4IwuGj1xCkF
 woHGUgvm2Q/ikM4fTg+jehyCIPFoe3P5QEYnODAiUO6glD0oXdh5/GuDXYVU5PMGIFBDszCtzs6
 Z4R3qN9PujxowFubdkaAetv4jg//VJloqJ6WuMewqxCR2fyWjkX8988aR7iacxfHuILlUfRX+6R
 g/pCAFj/Rd46Iy9Id6TqWMozdojJKPEh1jiXxwTpIlvLixMrK5LLFvvou3DWONQd/cud9hTZDfr
 CUanE3FEZqkBl6niZfTvqcoXFPVdBC9OmNrbvD6XWAbr5FCMu32zQdvLJbdn+uig8yCjIEzKQ0Y
 ZIVIe4y4iFKkgbcJnBQ==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa50d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=1NTGDykL02WXTEG3Jz0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vRIdOLX0cdx8qBlhl3TVTYhW1c9bqF2K
X-Proofpoint-ORIG-GUID: vRIdOLX0cdx8qBlhl3TVTYhW1c9bqF2K
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
index f35e868e4c..c858d5b74b 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -97,3 +97,24 @@ Subcode 1 - perform signature verification
     * ``0x0302``: PKCS#7 format signature is invalid
     * ``0x0402``: signature-verification failed
     * ``0x0502``: length of Diag508SigVerifBlock is invalid
+
+IPL Information Report Block
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
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


