Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B30FD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSirD-0007PT-Jv; Mon, 08 Dec 2025 16:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirB-0007OO-Dt; Mon, 08 Dec 2025 16:33:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSir9-0000iC-UN; Mon, 08 Dec 2025 16:33:21 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8E186p006746;
 Mon, 8 Dec 2025 21:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YeEOstwoR7Ari1UVa
 JEgtlBqWVPMtPT6Q3rOBy4a7l4=; b=DQu9BKzqKLicCN58y8hi4A+n3uekBapgC
 E88D2xHCuKojyorZmsu6tq17JHzaVKlcixBbkujhALTCyxjt2m0vs57pzH5+qrDF
 khZpG95ktUfnaAaZxxJCNppWXr8qjo4G0ynSxR5B0X28L0Fcj8UYOuEl34rhQf+P
 /f5Rpm4NBIWmiaAvXUmFCkm/NWlEGT9lfSCATg5MgJ55ALbyM2WEB8XMuO/r8cAt
 BFoTzFNjVraaHSZDDTm2nflU7P/cuhx3PXliS3rSNEFd8r3cwQWhYYkBNhHtbB9Q
 s9BFsx8zIddCiU4EnNzgIH923Ua5M8aFjBB0RiIpu+VnmXvvhcsvw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvhmmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8HnxmU028147;
 Mon, 8 Dec 2025 21:33:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xqvx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:16 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LXEsd22348444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:33:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9C085805F;
 Mon,  8 Dec 2025 21:33:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 302FD5805C;
 Mon,  8 Dec 2025 21:33:13 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:33:13 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 13/29] pc-bios/s390-ccw: Introduce IPL Information Report
 Block (IIRB)
Date: Mon,  8 Dec 2025 16:32:30 -0500
Message-ID: <20251208213247.702569-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4zcdDK8qpcTT113YbF9jLZU8vVIIcyhR
X-Proofpoint-ORIG-GUID: 4zcdDK8qpcTT113YbF9jLZU8vVIIcyhR
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6937441d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=1JLT7A-2tSAM-sJnsQYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX1autfbco9CZo
 oWPorR0uu3mI/pi6QB6BsMviAS9EDz6yCBSRVMC4xr0dKZfsLfdCkoO8kFvVREUZOF8JvVKCOrB
 P2f9hFKHnGrQbK3sNYm2B4EKRips+5Xhlfv6ymSwFcy17XpWhbGsHpY/uIWgeiU9oX8MFaA2oN4
 A4s46bdrLNeQMbbF19Uw6+o3eXMQaMaToCh8snaRacuHOUkyV4kF4CZGDRka5azlv9IuqrbYVB4
 wZLeO2evw1LlP9tb+f8rAdFuqmY7UGTyNMjFTVbfuPzLS5TM8Ms2GlEvAA7+t15WUF95YACCwkT
 rIHvpkJqnMNTLfoQ/0OAU9qKcNKC+dCvkiojgJK6m9xZGHhiaDVdfnHTOp8BzBeoiatSwiRMu+B
 a/c/hWXRcHRx3uKlzp6hM57jf/8spA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The IPL information report block (IIRB) contains information used
to locate IPL records and to report the results of signature verification
of one or more secure components of the load device.

IIRB is stored immediately following the IPL Parameter Block. Results on
component verification in any case (failure or success) are stored.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 13 +++++++
 pc-bios/s390-ccw/iplb.h         | 62 +++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index be98dc143d..29c5d59b99 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -86,3 +86,16 @@ Subcode 1 - perform signature verification
     * ``0x0302``: PKCS#7 format signature is invalid
     * ``0x0402``: signature-verification failed
     * ``0x0502``: length of Diag508SigVerifBlock is invalid
+
+IPL Information Report Block
+----------------------------
+
+The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
+IPL Information Report Block (IIRB), which contains the results from secure IPL
+operations such as:
+
+* component data
+* verification results
+* certificate data
+
+The guest kernel will inspect the IIRB and build the keyring.
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 08f259ff31..cc3ecc69e5 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -23,6 +23,68 @@ extern QemuIplParameters qipl;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 extern bool have_iplb;
 
+struct IplInfoReportBlockHeader {
+    uint32_t len;
+    uint8_t  iirb_flags;
+    uint8_t  reserved1[2];
+    uint8_t  version;
+    uint8_t  reserved2[8];
+};
+typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
+
+struct IplInfoBlockHeader {
+    uint32_t len;
+    uint8_t  ibt;
+    uint8_t  reserved1[3];
+    uint8_t  reserved2[8];
+};
+typedef struct IplInfoBlockHeader IplInfoBlockHeader;
+
+enum IplIbt {
+    IPL_IBT_CERTIFICATES = 1,
+    IPL_IBT_COMPONENTS = 2,
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
+#define S390_IPL_COMPONENT_FLAG_SC  0x80
+#define S390_IPL_COMPONENT_FLAG_CSV 0x40
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
+    IplDeviceComponentEntry  device_entries[MAX_CERTIFICATES];
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
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
-- 
2.51.1


