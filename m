Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE2EC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToIT-0004bK-DM; Tue, 16 Jul 2024 15:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIO-0004Mv-Qg; Tue, 16 Jul 2024 15:57:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIL-00068Y-NU; Tue, 16 Jul 2024 15:57:08 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GJucXX020661;
 Tue, 16 Jul 2024 19:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=IinQAZWqPKpFV
 LPBueiB9oMXFK3jmNAmi/uwWHQnvp0=; b=NZguwH3OOYJamR/wjuDEuOI1Y1oAZ
 t/IUA714TE6m6CEwyQDIps/4xoz5laIFpFKYAqLbXqNGrZ8bJAXiW7fokuCcMg+Q
 Ukj7wD2jrE0Sk5l+52X6L0vS0B8S5JAgCX/YaLwTjnRQbZaz5JS2tqoBXnVoD8GX
 sNPU98YY3DP/UzrKpl9AL04NKAXROeeR9kUyPDu+xzLbN2eVox0fIzJFEkNqjlw/
 Cd+AYH1X2wLjlr0LYe8gewu8AAEC17KKoJrmVx0pdfgJPu17pxX0W/IYXvkDSkq4
 HEnOy4dvPTtRFxWHsRHvd5/wpiRTRH1bjJ48lkwPYBAOg/iiyO01/hxAg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dwnv87xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:01 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GJv1Wl021362;
 Tue, 16 Jul 2024 19:57:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dwnv87xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46GHnD1W009594; Tue, 16 Jul 2024 19:57:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmgg85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46GJutaN10944822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 19:56:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D92B2004B;
 Tue, 16 Jul 2024 19:56:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EA5420040;
 Tue, 16 Jul 2024 19:56:54 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2024 19:56:54 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 6/9] pnv/xive2: Enable VST NVG and NVC index compression
Date: Tue, 16 Jul 2024 14:56:30 -0500
Message-Id: <20240716195633.12679-7-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ke7Yg1nATpPGrv-NmF0TadF8mqntxNVh
X-Proofpoint-ORIG-GUID: aEfpRowMPF3sZqzg5fDAFf4-jUMntc5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=896 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160144
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Enable NVG and NVC VST tables for index compression which indicates the number
of bits the address is shifted to the right for the table accesses.
The compression values are defined as:
   0000 - No compression
   0001 - 1 bit shift
   0010 - 2 bit shift
   ....
   1000 - 8 bit shift
   1001-1111 - No compression

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2_regs.h |  2 ++
 hw/intc/pnv_xive2.c      | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index ca05255d20..e8b87b3d2c 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -427,6 +427,8 @@
 #define X_PC_NXC_PROC_CONFIG                    0x28A
 #define PC_NXC_PROC_CONFIG                      0x450
 #define   PC_NXC_PROC_CONFIG_WATCH_ASSIGN       PPC_BITMASK(0, 3)
+#define   PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS PPC_BITMASK(32, 35)
+#define   PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS PPC_BITMASK(36, 39)
 
 /* NxC Cache Watch 0 Specification */
 #define X_PC_NXC_WATCH0_SPEC                    0x2A0
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index d4ee104300..84ae10b710 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -217,6 +217,20 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
     return pnv_xive2_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
 }
 
+static uint8_t pnv_xive2_nvc_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift =  GETFIELD(PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS,
+                              xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
+static uint8_t pnv_xive2_nvg_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift = GETFIELD(PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS,
+                             xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
 static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
                                    uint32_t idx)
 {
@@ -238,6 +252,12 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
         return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
     }
 
+    if (type == VST_NVG) {
+        idx >>= pnv_xive2_nvg_table_compress_shift(xive);
+    } else if (type == VST_NVC) {
+        idx >>= pnv_xive2_nvc_table_compress_shift(xive);
+    }
+
     if (VSD_INDIRECT & vsd) {
         return pnv_xive2_vst_addr_indirect(xive, type, vsd, idx);
     }
-- 
2.43.0


