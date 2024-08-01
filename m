Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84EDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRk-0003Xk-IV; Thu, 01 Aug 2024 16:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRe-0003NP-OX; Thu, 01 Aug 2024 16:30:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRc-0007LV-Li; Thu, 01 Aug 2024 16:30:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471KAkP2008579;
 Thu, 1 Aug 2024 20:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=zdJy1daR0QDrr
 HuiDrIp4CSYEBMf0S9T9xPOtJgFipI=; b=qP8Ey2blcEFGxDVDCza/J+UmXv+gK
 l8msfYlh4DKusjksdeI1vAkDUgDbBbim3019VZPgFwIzrBLNomb87KrLhkDCN6oR
 3nkjrDt0A9gns6daSrgT8W6LcXFVIZHc7+TjALCY2Wo//5p55IWM7HNuE+5RERow
 7wl2ipBPvJe8RIc6lc/J6fL8CpXUgVuvByuNmQqrWiGkuEfK5LFIL7zxbO8Z/+BM
 MjN8qfXNueg/ba3tQC9Pg2aM8+DR0fSySCMf14Z6waxgdoaTT6+YiJdB2LaRhhP/
 zw0E0OZ1TbAok+WtryoWMpuuYagcKDhzsW+N+1mJZBRDqlC0tvybfd+zw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh0501t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUVLE008134;
 Thu, 1 Aug 2024 20:30:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh0501t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471Hf2VX029103; Thu, 1 Aug 2024 20:30:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm13wum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUPbl55116126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4EFF20040;
 Thu,  1 Aug 2024 20:30:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6E162004E;
 Thu,  1 Aug 2024 20:30:23 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:23 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 04/13] pnv/xive2: Support for "OS LGS Push" TIMA operation
Date: Thu,  1 Aug 2024 15:29:59 -0500
Message-Id: <20240801203008.11224-5-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lEUkOB3OfsT4F7nqo8F4QZsI6yfFbBec
X-Proofpoint-GUID: jAhuonMfnMTIwHc7T5jfoDCA0f2Enk65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=960 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds support for single byte writes to offset 0x15 of the TIMA address
space.  This offset holds the Logical Server Group Size (LGS) field.
The field is used to evenly distribute the interrupt load among the
members of a group, but is unused in the current implementation so we
just support the writing of the value for now.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/xive.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8e62c7e75f..8605dd618f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -341,6 +341,19 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
     xive_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
 }
 
+static void xive_tctx_set_lgs(XiveTCTX *tctx, uint8_t ring, uint8_t lgs)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    regs[TM_LGS] = lgs;
+}
+
+static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive_tctx_set_lgs(tctx, TM_QW1_OS, value & 0xff);
+}
+
 /*
  * Adjust the IPB to allow a CPU to process event queues of other
  * priorities during one physical interrupt cycle.
@@ -525,6 +538,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
                                                      NULL },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
+                                                     NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
-- 
2.43.0


