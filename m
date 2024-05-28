Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E115BC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmnW-0008Pl-HG; Mon, 27 May 2024 22:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sBmnU-0008PJ-AB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:42:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sBmnK-0003TJ-0P
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:42:44 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240528024227epoutp0366bdc850c29adcac9a2fb266e05bf01b~Thtihuy_k1332113321epoutp03r
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 02:42:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240528024227epoutp0366bdc850c29adcac9a2fb266e05bf01b~Thtihuy_k1332113321epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716864147;
 bh=kCvxzvP6Xbera+pHcnuspK3z4sIcQXnqJeN7D2vphYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p47GoaiOog4WbClAwRR0h6OZ6YlGwQfA4PGXcYbDgbM4pQxCtYO834cUaZSV5Ly5B
 GryT/Lz4FMjyo4cC8Jgk+dtHK9rE9uSR5ulKVuqdrdVSzVwJ0yYNcFEpWIyaOfXvsf
 8j6P9b+Y2oblLoJgoGggmiSCpNT00RJI1saDuTZQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20240528024227epcas2p30d3463ce241f9c205cfa39463034a580~ThtiM7kLB1098710987epcas2p3G;
 Tue, 28 May 2024 02:42:27 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VpGyB5tvNz4x9Py; Tue, 28 May
 2024 02:42:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 DE.1B.09806.29445566; Tue, 28 May 2024 11:42:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240528024226epcas2p2b6e8cbaf751f2e74087b9f6fb2ac6d3f~Thtgxua6R0275302753epcas2p2o;
 Tue, 28 May 2024 02:42:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240528024226epsmtrp2abe965ed8adf516793e9a4db6cb67962~Thtgw_2qR1471914719epsmtrp2Y;
 Tue, 28 May 2024 02:42:26 +0000 (GMT)
X-AuditID: b6c32a47-c6bff7000000264e-28-66554492f545
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 22.5F.08622.19445566; Tue, 28 May 2024 11:42:25 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240528024225epsmtip222730c14c9df3c55451c85cb64386e31~ThtglvGIc2463924639epsmtip2j;
 Tue, 28 May 2024 02:42:25 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v2 1/2] hw/ufs: Update MCQ-related fields to block/ufs.h
Date: Tue, 28 May 2024 11:31:05 +0900
Message-Id: <20240528023106.856777-2-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528023106.856777-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqe4kl9A0g0+rtSxuHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR2XbZKQmpqQW
 KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
 K+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/zctZa14IlO
 xeuW5ewNjH+Uuhg5OCQETCSOv3DvYuTiEBLYwSix/+kxJgjnE6PEk9NvmSGcb4wSX7c9YYHp
 OHm/BiK+l1Hi7pT9rBDOb0aJ60cWABVxcrAJqEs0TH0FZosIpEtcfreSFaSZWSBb4uENPZCw
 sICHxJ0f99hAbBYBVYl5C4+ygti8AtYSV7fOZwexJQTkJfYfPMsMYnMK2Eg8+HyYEaJGUOLk
 zCdg45mBapq3zgY7VELgHrvErT1bmCGaXSTmr97HCGELS7w6vgVqqJTE53d72SDscomfbyZB
 1VRIHJx1mw3iSXuJa89TIE7WlFi/Sx8iqixx5BbUVj6JjsN/2SHCvBIdbUIQM5QlPh46BLVf
 UmL5pddQezwk3nX8gAZtP6PEqtZuxgmMCrOQPDMLyTOzEBYvYGRexSiWWlCcm55abFRgDI/d
 5PzcTYzghKjlvoNxxtsPeocYmTgYDzFKcDArifCKzAtME+JNSaysSi3Kjy8qzUktPsRoCgzq
 icxSosn5wJScVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QDU02a
 mnn8rikbTiW3nbR+En58vg/j7dVTPlY9+PJ8s9o6vgPX5///57rc4HHQ3oRzH5vWKerbTc3v
 rS398So506fx1OJ84afnDu3ntHs4V9yUgft6m+dfkwhN6fsv38gZHDNuFzJs/jRjk/t5o2N1
 zw6ayj2dZj5P8KXLszk1Nq9sPHs8ktXjPBJS6pbnbpBdt7b1wPLtEUuvXHea+O2r+5aV12Kk
 lZc83m2ydvPsFRHBS3omRXmlJt0KVq4KvN6u7j2zQuamcExyntf+P5F3/jMeb/Bdrc0eGxnq
 tT6JX+yYTbZC+kWr129N10SFy/+av692qcvrM1FNhff8L3mdzeByVtg2vTPmuMo9xkVP8pRY
 ijMSDbWYi4oTAdkkFSURBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvO5El9A0gz+nrSxuHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR3HZpKTmZJal
 FunbJXBl/Ny1lrXgiU7F65bl7A2Mf5S6GDk4JARMJE7er+li5OIQEtjNKPH17BfWLkZOoLik
 xL7TN6FsYYn7LUdYIYp+Mko8/PqeDSTBJqAu0TD1FQuILSKQKbHwVQc7iM0skC/R1bGACcQW
 FvCQuPPjHlg9i4CqxLyFR8GG8gpYS1zdOp8dYoG8xP6DZ5lBbE4BG4kHnw8zgthCQDX/j+xi
 hqgXlDg58wkLxHx5ieats5knMArMQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66
 XnJ+7iZGcABrae1g3LPqg94hRiYOxkOMEhzMSiK8IvMC04R4UxIrq1KL8uOLSnNSiw8xSnOw
 KInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpgckxjOzfJbavp1Ev3eNZyPwgUnpj0vT5fJEPV
 sdP54vTePV8VXHn9NtxOErjxPUXDUeHx6xeL7l1TNiwqFNt3cR5bzIw5K5oeO2sdtnw5+ftk
 FX71/rNrJuilOz6821arcLZzPbv+0/szDxgdebQiNlcj1Epd7+tdj4ePkl8odTyw1j49ofR6
 wHRO+x2dNTzLxLdLzvrWflJR4cZpfWOWht175rR3Wx+LfqhpcXHe7qmWC/6vmvIklXvu2UlT
 kjbMF3q3Jd/VS77j3EufH49qS4xfJjE5d+qcLDPd7tjOIBmxaPm2LV377mVtbyuwCDhk9CGn
 JvHP1MkPj04NL33OsGJNnI16dn6KxMr8Ly9vX1FiKc5INNRiLipOBADQxyTozwIAAA==
X-CMS-MailID: 20240528024226epcas2p2b6e8cbaf751f2e74087b9f6fb2ac6d3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240528024226epcas2p2b6e8cbaf751f2e74087b9f6fb2ac6d3f
References: <20240528023106.856777-1-minwoo.im@samsung.com>
 <CGME20240528024226epcas2p2b6e8cbaf751f2e74087b9f6fb2ac6d3f@epcas2p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This patch is a prep patch for the following MCQ support patch for
hw/ufs.  This patch updated minimal mandatory fields to support MCQ
based on UFSHCI 4.0.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 include/block/ufs.h | 108 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index d61598b8f3..3513b6e772 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -7,7 +7,7 @@
 
 typedef struct QEMU_PACKED UfsReg {
     uint32_t cap;
-    uint32_t rsvd0;
+    uint32_t mcqcap;
     uint32_t ver;
     uint32_t rsvd1;
     uint32_t hcpid;
@@ -46,6 +46,13 @@ typedef struct QEMU_PACKED UfsReg {
     uint32_t rsvd7[4];
     uint32_t rsvd8[16];
     uint32_t ccap;
+    uint32_t rsvd9[127];
+    uint32_t config;
+    uint32_t rsvd10[3];
+    uint32_t rsvd11[28];
+    uint32_t mcqconfig;
+    uint32_t esilba;
+    uint32_t esiuba;
 } UfsReg;
 
 REG32(CAP, offsetof(UfsReg, cap))
@@ -57,6 +64,15 @@ REG32(CAP, offsetof(UfsReg, cap))
     FIELD(CAP, OODDS, 25, 1)
     FIELD(CAP, UICDMETMS, 26, 1)
     FIELD(CAP, CS, 28, 1)
+    FIELD(CAP, LSDBS, 29, 1)
+    FIELD(CAP, MCQS, 30, 1)
+REG32(MCQCAP, offsetof(UfsReg, mcqcap))
+    FIELD(MCQCAP, MAXQ, 0, 8)
+    FIELD(MCQCAP, SP, 8, 1)
+    FIELD(MCQCAP, RRP, 9, 1)
+    FIELD(MCQCAP, EIS, 10, 1)
+    FIELD(MCQCAP, QCFGPTR, 16, 8)
+    FIELD(MCQCAP, MIAG, 24, 8)
 REG32(VER, offsetof(UfsReg, ver))
 REG32(HCPID, offsetof(UfsReg, hcpid))
 REG32(HCMID, offsetof(UfsReg, hcmid))
@@ -78,6 +94,7 @@ REG32(IS, offsetof(UfsReg, is))
     FIELD(IS, HCFES, 16, 1)
     FIELD(IS, SBFES, 17, 1)
     FIELD(IS, CEFES, 18, 1)
+    FIELD(IS, CQES, 20, 1)
 REG32(IE, offsetof(UfsReg, ie))
     FIELD(IE, UTRCE, 0, 1)
     FIELD(IE, UDEPRIE, 1, 1)
@@ -95,6 +112,7 @@ REG32(IE, offsetof(UfsReg, ie))
     FIELD(IE, HCFEE, 16, 1)
     FIELD(IE, SBFEE, 17, 1)
     FIELD(IE, CEFEE, 18, 1)
+    FIELD(IE, CQEE, 20, 1)
 REG32(HCS, offsetof(UfsReg, hcs))
     FIELD(HCS, DP, 0, 1)
     FIELD(HCS, UTRLRDY, 1, 1)
@@ -128,6 +146,10 @@ REG32(UCMDARG1, offsetof(UfsReg, ucmdarg1))
 REG32(UCMDARG2, offsetof(UfsReg, ucmdarg2))
 REG32(UCMDARG3, offsetof(UfsReg, ucmdarg3))
 REG32(CCAP, offsetof(UfsReg, ccap))
+REG32(CONFIG, offsetof(UfsReg, config))
+    FIELD(CONFIG, QT, 0, 1)
+REG32(MCQCONFIG, offsetof(UfsReg, mcqconfig))
+    FIELD(MCQCONFIG, MAC, 8, 8)
 
 #define UFS_INTR_MASK                                    \
     ((1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
@@ -157,6 +179,69 @@ REG32(CCAP, offsetof(UfsReg, ccap))
     ((be32_to_cpu(dword2) >> UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_SHIFT) & \
      UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_MASK)
 
+typedef struct QEMU_PACKED UfsMcqReg {
+    uint32_t sqattr;
+    uint32_t sqlba;
+    uint32_t squba;
+    uint32_t sqdao;
+    uint32_t sqisao;
+    uint32_t sqcfg;
+    uint32_t rsvd0[2];
+    uint32_t cqattr;
+    uint32_t cqlba;
+    uint32_t cquba;
+    uint32_t cqdao;
+    uint32_t cqisao;
+    uint32_t cqcfg;
+    uint32_t rsvd1[2];
+} UfsMcqReg;
+
+REG32(SQATTR, offsetof(UfsMcqReg, sqattr))
+    FIELD(SQATTR, SIZE, 0, 16)
+    FIELD(SQATTR, CQID, 16, 8)
+    FIELD(SQATTR, SQPL, 28, 3)
+    FIELD(SQATTR, SQEN, 31, 1)
+REG32(SQLBA, offsetof(UfsMcqReg, sqlba))
+REG32(SQUBA, offsetof(UfsMcqReg, squba))
+REG32(SQDAO, offsetof(UfsMcqReg, sqdao))
+REG32(SQISAO, offsetof(UfsMcqReg, sqisao))
+REG32(SQCFG, offsetof(UfsMcqReg, sqcfg))
+REG32(CQATTR, offsetof(UfsMcqReg, cqattr))
+    FIELD(CQATTR, SIZE, 0, 16)
+    FIELD(CQATTR, CQEN, 31, 1)
+REG32(CQLBA, offsetof(UfsMcqReg, cqlba))
+REG32(CQUBA, offsetof(UfsMcqReg, cquba))
+REG32(CQDAO, offsetof(UfsMcqReg, cqdao))
+REG32(CQISAO, offsetof(UfsMcqReg, cqisao))
+REG32(CQCFG, offsetof(UfsMcqReg, cqcfg))
+
+typedef struct QEMU_PACKED UfsMcqSqReg {
+    uint32_t hp;
+    uint32_t tp;
+    uint32_t rtc;
+    uint32_t cti;
+    uint32_t rts;
+} UfsMcqSqReg;
+
+typedef struct QEMU_PACKED UfsMcqCqReg {
+    uint32_t hp;
+    uint32_t tp;
+} UfsMcqCqReg;
+
+typedef struct QEMU_PACKED UfsMcqSqIntReg {
+    uint32_t is;
+    uint32_t ie;
+} UfsMcqSqIntReg;
+
+typedef struct QEMU_PACKED UfsMcqCqIntReg {
+    uint32_t is;
+    uint32_t ie;
+    uint32_t iacr;
+} UfsMcqCqIntReg;
+
+REG32(CQIS, offsetof(UfsMcqCqIntReg, is))
+    FIELD(CQIS, TEPS, 0, 1)
+
 typedef struct QEMU_PACKED DeviceDescriptor {
     uint8_t length;
     uint8_t descriptor_idn;
@@ -1064,9 +1149,26 @@ typedef struct QEMU_PACKED UtpUpiuRsp {
     };
 } UtpUpiuRsp;
 
+/*
+ * MCQ Completion Queue Entry
+ */
+typedef UtpTransferReqDesc UfsSqEntry;
+typedef struct QEMU_PACKED UfsCqEntry {
+    uint64_t utp_addr;
+    uint16_t resp_len;
+    uint16_t resp_off;
+    uint16_t prdt_len;
+    uint16_t prdt_off;
+    uint8_t status;
+    uint8_t error;
+    uint16_t rsvd1;
+    uint32_t rsvd2[3];
+} UfsCqEntry;
+
 static inline void _ufs_check_size(void)
 {
-    QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x104);
+    QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x38C);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqReg) != 64);
     QEMU_BUILD_BUG_ON(sizeof(DeviceDescriptor) != 89);
     QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 87);
     QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
@@ -1086,5 +1188,7 @@ static inline void _ufs_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(UtpTaskReqDesc) != 80);
     QEMU_BUILD_BUG_ON(sizeof(UtpCmdRsp) != 40);
     QEMU_BUILD_BUG_ON(sizeof(UtpUpiuRsp) != 288);
+    QEMU_BUILD_BUG_ON(sizeof(UfsSqEntry) != 32);
+    QEMU_BUILD_BUG_ON(sizeof(UfsCqEntry) != 32);
 }
 #endif
-- 
2.34.1


