Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F831C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2BeJ-0006v7-8e; Tue, 08 Apr 2025 12:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BJ2-0005cM-LM; Tue, 08 Apr 2025 11:56:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIy-0005xS-2H; Tue, 08 Apr 2025 11:56:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CS4ku017794;
 Tue, 8 Apr 2025 15:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+jx38PsgWXjFgnLG5
 5CCmZLbTK/w2RDIZ1ATVyhkEVQ=; b=IjHvD0zsSjnScnn513XaAT7Hcw2GZdqGF
 thVzNNlJOjvqNiF/UhspdhHDHXaLBVSj0ppOUpn3IaZVzqqntheC0PWUTfx2ubuO
 oFsO+Wj36KGzDSK35K552m2c1CFK9rGDgzELlFGEyatQ5Xg9t+G6bSBsWRTX1uRr
 bZqEN/kyvzr/5pCoJKl87k5KNmDVnytDwDpxsbM9ecsCtysH8Twkvo1gKj485jff
 yfzmcdTlJe7/2g+DsHY2962XiD29+A/Cc5hj5+bTstMy+AEg+7k8S2PeFGnSlBXF
 5sj7hqWBDlvU6J48WrOlMhc4zqQzj6uPiHzE+QWtG2q2xqtfuofPg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u3124b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538E44Ic018863;
 Tue, 8 Apr 2025 15:55:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uhj2b1bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538Ftkfr29688446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CFA35803F;
 Tue,  8 Apr 2025 15:55:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E46495804E;
 Tue,  8 Apr 2025 15:55:44 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:44 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 10/24] pc-bios/s390-ccw: Introduce IPL Information Report
 Block (IIRB)
Date: Tue,  8 Apr 2025 11:55:12 -0400
Message-ID: <20250408155527.123341-11-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LiQ_sSq5sV690JsVG--U_ABGrW27k29a
X-Proofpoint-ORIG-GUID: LiQ_sSq5sV690JsVG--U_ABGrW27k29a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:35 -0400
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


