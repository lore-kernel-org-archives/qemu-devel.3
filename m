Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D981C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw7C-0002ka-UY; Wed, 04 Jun 2025 17:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7A-0002iG-5o; Wed, 04 Jun 2025 17:57:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw78-0006ze-IV; Wed, 04 Jun 2025 17:57:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554DUSuc017169;
 Wed, 4 Jun 2025 21:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+jx38PsgWXjFgnLG5
 5CCmZLbTK/w2RDIZ1ATVyhkEVQ=; b=SsVRxEmkfD+JrmQOB+xbm7eGBqN5z/umc
 KQBjBvxF9VbYxZktetpDTJmZ1g73lD+nFMb5kbW1erAYuDLoEeflCx88+mu3d6qC
 m/4/3YstjiLN3Fi2QgEToIfCj5i4hhEDhqYF8gYYPiqWE/sf4pl2ViZ5aycH8okR
 +P4raFqYOwTOcxl3aARYUG8K7iNgoNi3TkgppzqGfr7SJQbtkgAdYqbRQGsD739g
 eEeol3rRxqdMEwLbsv2YVg0JiJzmaDnK2+uEZIY3xgSQ2TahW8EqalXi28EG7ig4
 skJkKh44e2DpJlCb7g+L/Sda3W7egZsPIsIZbb++YuYJBTuVIE0pA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwums1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JWSLJ031690;
 Wed, 4 Jun 2025 21:57:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470cg01ypb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:36 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvZxu29754014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CA4758050;
 Wed,  4 Jun 2025 21:57:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0687D58045;
 Wed,  4 Jun 2025 21:57:33 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:32 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 13/28] pc-bios/s390-ccw: Introduce IPL Information Report
 Block (IIRB)
Date: Wed,  4 Jun 2025 17:56:41 -0400
Message-ID: <20250604215657.528142-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX2LzzWRqpModh
 PwjLTTHrTqqU12WdzIb9MLkHjULAWqMSTZfL2c7KDVfwGWqc7DZ4ui+VeVq3nz8P/67sEhM3f3J
 qJeEKev/kLRKiIo7HAW3QDP5R1mY5LrO94VnGaA3ovKNWT3H7wGj43qkRgGV9cMHag8+/w5hOR2
 qawQHHdYgibRxZhdD8FPqSVtGiSEpjEYubgh9ftdOVkUCciYA+1OFH8Vx21eSGlWLlxJW5aodlL
 m0pQrEULg2vY5aFep1BrCloEE6p4kI9a3YDsmWFrOUe9/jDFuYPtChn7UBwu8sS9V/JYUAPJm/t
 85ty6bcBuQs8MITcHQAxaCOlheXrAoaBRR35WpH0U0SZ34Pyuobd8QWnHTd0f4JFRo8YMn1t/7A
 /Kx4XCZfO4b2kmv5OsVoxoaJpAvGwr57po4hsglSdVWm8AW5brL9sc8SN23ZssBwRikV66v3
X-Proofpoint-GUID: VOoK8X8KcLRB3ki3ZWpXREDeax-4-B_L
X-Proofpoint-ORIG-GUID: VOoK8X8KcLRB3ki3ZWpXREDeax-4-B_L
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=6840c151 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=RgLmrGz4iiqVFuOO9qEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 pc-bios/s390-ccw/iplb.h | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

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
2.49.0


