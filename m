Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3BECA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7ef-0002AI-Ai; Mon, 18 Aug 2025 17:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7eH-0001p1-1K; Mon, 18 Aug 2025 17:44:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7ds-0003mf-73; Mon, 18 Aug 2025 17:44:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILWDJ2027407;
 Mon, 18 Aug 2025 21:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zVsRMy487YGqQYGnZ
 b7xNwEfj7PaB5rOAdrql2G9ZBU=; b=tIQgTQ6cL88nMOAwcLKeZpV+PGotcxGIU
 HzaR1lboNPuIJOU5W3dOG8C9bxjT5yNSUv2bvgzfLfIG428brftaYIdga2nHNB66
 +qwo0MN/OtMAbYS/l1LaMX5Fu1oCeRMaoiRfdHULxm/ds+UREprIBfIOyedT6G/b
 Rm6C+mQxFvomTjFJdVs/aztUfUA98v373R1UfUaERWMGJS7NLqY96m2mTV+ivXuc
 QTW2irVsKNJZ9ht9vwxpnjnwL/E/oI/khkgbPlXm5SNb3kXBa4gOCQQRH8prlSOB
 QMVwaWYmLqQGrn5RlFM2WlTWx6xkuOn6eGj9b1fBA8T0gDCEh6GJA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g0cnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IHQGrE011893;
 Mon, 18 Aug 2025 21:43:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k4au7r8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57ILhf3R6357688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 21:43:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5002D58057;
 Mon, 18 Aug 2025 21:43:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 517F258058;
 Mon, 18 Aug 2025 21:43:40 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.98.172])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 21:43:40 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 13/29] pc-bios/s390-ccw: Introduce IPL Information Report
 Block (IIRB)
Date: Mon, 18 Aug 2025 17:43:06 -0400
Message-ID: <20250818214323.529501-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818214323.529501-1-zycai@linux.ibm.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YwWHryfinL9UWaqMO5OfW3Mi-LHiXlar
X-Authority-Analysis: v=2.4 cv=coObk04i c=1 sm=1 tr=0 ts=68a39e90 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=1JLT7A-2tSAM-sJnsQYA:9
X-Proofpoint-GUID: YwWHryfinL9UWaqMO5OfW3Mi-LHiXlar
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDAxNiBTYWx0ZWRfX1/6VPndZ/A76
 HTMUA8Tk9L48RaSvWr6m2gF0RIZDSMvg7oKO0U0g4TC1kChpcfyqcwGCS5XoOoOPYtnhheMpQmd
 LFi68kOECWDwl70dQbISqGH6NMMdveP+nujtFlmcWONueIpWcQdw/sTLDE2+DJyJhsYiep3peEJ
 ixKzBoqGOxymx7BgDrfgekK47Omb8yjEYvfB7UqDNpOt9qnBECGRRnzl78CvgTV0gpDEsoPNDpo
 htqIxe/9EzCxrEziP5vyxvk0dL6+iF63OhzB7Aa3YJsvzA1D/64TmnBK4/ocSAZ0MMLE2TXLRJe
 EczAEkpCIjqubkhprbfPBxOwidRg8jLDQnxK6ZTVuHsrXNM4cyjP54W428EynRRUBs5iqT6l+Gb
 3rVaE+qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

The IPL information report block (IIRB) contains information used
to locate IPL records and to report the results of signature verification
of one or more secure components of the load device.

IIRB is stored immediately following the IPL Parameter Block. Results on
component verification in any case (failure or success) are stored.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 14 ++++++++
 pc-bios/s390-ccw/iplb.h         | 62 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 385f8d85a8..4bc330c399 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -69,3 +69,17 @@ Subcode 1 - perform signature verification
     Perform signature-verification on a signed component, using certificates
     from the certificate store and leveraging qcrypto libraries to perform
     this operation.
+
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
index 08f259ff31..bdbc733e16 100644
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
+} __attribute__ ((packed));
+typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
+
+struct IplInfoBlockHeader {
+    uint32_t len;
+    uint8_t  ibt;
+    uint8_t  reserved1[3];
+    uint8_t  reserved2[8];
+} __attribute__ ((packed));
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
+} __attribute__ ((packed));
+typedef struct IplSignatureCertificateEntry IplSignatureCertificateEntry;
+
+struct IplSignatureCertificateList {
+    IplInfoBlockHeader            ipl_info_header;
+    IplSignatureCertificateEntry  cert_entries[MAX_CERTIFICATES];
+} __attribute__ ((packed));
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
+} __attribute__ ((packed));
+typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
+
+struct IplDeviceComponentList {
+    IplInfoBlockHeader       ipl_info_header;
+    IplDeviceComponentEntry  device_entries[MAX_CERTIFICATES];
+} __attribute__ ((packed));
+typedef struct IplDeviceComponentList IplDeviceComponentList;
+
+#define COMP_LIST_MAX   sizeof(IplDeviceComponentList)
+#define CERT_LIST_MAX   sizeof(IplSignatureCertificateList)
+
+struct IplInfoReportBlock {
+    IplInfoReportBlockHeader     hdr;
+    uint8_t                      info_blks[COMP_LIST_MAX + CERT_LIST_MAX];
+} __attribute__ ((packed));
+typedef struct IplInfoReportBlock IplInfoReportBlock;
+
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
-- 
2.50.1


