Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D03FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRp-000400-L9; Thu, 01 Aug 2024 16:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRm-0003s5-Lh; Thu, 01 Aug 2024 16:30:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRj-0007OJ-Ac; Thu, 01 Aug 2024 16:30:50 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471JwZhU026196;
 Thu, 1 Aug 2024 20:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=fROQaJYVef/gF
 QfuzfqZzrc/USykQdsuMKfYGga3GXo=; b=Af0Bv6HPejKGrkcnW4cC3XM/1BqBv
 H8mCJuyjOs0+ooJEGEW/rri/1UuPR7tfqlCGFZUlQJlaRoc8SCq4esrCTAhSkBKZ
 JZwn99jZiU69+G77HotsA0Vn2Im9lr5tpQhCz48iu2oeFcTSQ6Mq5HjPvGKLK5bX
 ijFsE/8lIDmGR44zF9qLAcfDrd/4WJcp/yT0ygBIv/0nEIbGurWrZfz1//HH3HZ5
 Mygwni54Q/Rr0k9qEzF0+Bw5neiSxsyTG1rBeKRgECf+/7m1x7QPKuYCHR0RZlur
 YX0MvMZhLOvuZfkyo9MzUB6N0YzxXLwTRjUds3KNV0iDC+EX5NFSgDm4g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh05022s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:36 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUZfY013497;
 Thu, 1 Aug 2024 20:30:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh05022q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471JR5rA003935; Thu, 1 Aug 2024 20:30:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemughp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUTIZ53412098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4257720043;
 Thu,  1 Aug 2024 20:30:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18E082004B;
 Thu,  1 Aug 2024 20:30:28 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:27 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 07/13] ppc/xive2: Allow 1-byte write of Target field in TIMA
Date: Thu,  1 Aug 2024 15:30:02 -0500
Message-Id: <20240801203008.11224-8-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DVhS9FFEUnfZ54ALkiZiof9oihwGCgUg
X-Proofpoint-ORIG-GUID: uACKbfxFM0EZyzh2Aw-xgpdMLrij25YJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=818
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

When running PowerVM, the console is littered with XIVE traces regarding
invalid writes to TIMA address 0x100b6 due to a lack of support for writes
to the "TARGET" field which was added for XIVE GEN2.  To fix this, we add
special op support for 1-byte writes to this field.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2.h     |  2 ++
 include/hw/ppc/xive_regs.h |  1 +
 hw/intc/xive.c             |  2 ++
 hw/intc/xive2.c            | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index b7a7c33ddd..36bd0e747f 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -121,5 +121,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, unsigned size);
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size);
 
 #endif /* PPC_XIVE2_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 27a744d50d..f8f05deafd 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -79,6 +79,7 @@
 #define TM_INC                  0x5  /*  -   +   -   +  */
 #define TM_LGS                  0x5  /*  +   +   +   +  */ /* Rename P10 */
 #define TM_AGE                  0x6  /*  -   +   -   +  */
+#define TM_T                    0x6  /*  -   +   -   +  */ /* Rename P10 */
 #define TM_PIPR                 0x7  /*  -   +   -   +  */
 #define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8605dd618f..6229a6f870 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -546,6 +546,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
                                                      xive_tm_vt_poll },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, xive2_tm_set_hv_target,
+                                                     NULL },
 
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 9d19273bc8..eed0cc9c3c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -600,6 +600,19 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    regs[TM_T] = target;
+}
+
+void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_set_target(tctx, TM_QW3_HV_PHYS, value & 0xff);
+}
+
 /*
  * XIVE Router (aka. Virtualization Controller or IVRE)
  */
-- 
2.43.0


