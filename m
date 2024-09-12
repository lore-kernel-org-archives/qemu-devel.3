Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5FFEEE266
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 20:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqmC-0002XH-8u; Thu, 12 Sep 2024 16:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqm9-0002U8-TY; Thu, 12 Sep 2024 16:50:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqm8-00078i-5P; Thu, 12 Sep 2024 16:50:49 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CBoDwA017312;
 Thu, 12 Sep 2024 20:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 YG5wgjs6sC2GONtg6oOgjo1KLY9C4L5MgZOwUrI9XgA=; b=RhPCriEwiqKHWbaf
 WFsg2ZSblesxoJlzsnXJga39Qhd3130VBq29alby/Q13gt3i+Q1hSH9cqTgtMg/7
 H5GsNbQw9al28SVzxGAS8PXXCdEK/hxQlXiSBjXLTY43G4nZ+N5UkTQjc2aSrVfa
 pTojGCrOYuF++y25hsKdT4soBf+zSsT7VfPJ6cMX9YiUW9SYymIJbHiJhqY4LYPr
 11HjQ6vkskGs5HeSvnhIYD66sgLFZUwoA/NUOV8jXG2JVXm1NYdNvtgln4C30nxv
 YosKM3YwSXjQAXEWVQkXj19mStQq/1jLEa6Qi1i2pnBORmPMOIWaS6FXWce0Rthq
 RpEH1w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebap3ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKohaV004085;
 Thu, 12 Sep 2024 20:50:43 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebap3ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIdIYs013471;
 Thu, 12 Sep 2024 20:50:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmj2kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKocCn35783080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:50:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6DBD20049;
 Thu, 12 Sep 2024 20:50:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 865AC20040;
 Thu, 12 Sep 2024 20:50:37 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:50:37 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 02/14] pnv/xive2: Define OGEN field in the TIMA
Date: Thu, 12 Sep 2024 15:50:16 -0500
Message-Id: <20240912205028.15854-3-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912205028.15854-1-kowal@linux.ibm.com>
References: <20240912205028.15854-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cnbXaM5mGk6wRLNQTB6gTEO0sd_vPiLA
X-Proofpoint-GUID: XR6u1LK9JmZRnoJ_0rSKUATbwFNJhP8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=648 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409120149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The OGEN field at offset 0x1F is a new field for Gen2 TIMA. This
patch defines it.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive_regs.h | 1 +
 hw/intc/xive.c             | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 9d52d464d9..9062c6abf6 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -79,6 +79,7 @@
 #define TM_INC                  0x5  /*  -   +   -   +  */
 #define TM_AGE                  0x6  /*  -   +   -   +  */
 #define TM_PIPR                 0x7  /*  -   +   -   +  */
+#define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
 
 #define TM_WORD0                0x0
 #define TM_WORD1                0x4
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2fb38e2102..136d82338a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -742,6 +742,10 @@ void xive_tctx_reset(XiveTCTX *tctx)
     tctx->regs[TM_QW1_OS + TM_LSMFB] = 0xFF;
     tctx->regs[TM_QW1_OS + TM_ACK_CNT] = 0xFF;
     tctx->regs[TM_QW1_OS + TM_AGE] = 0xFF;
+    if (!(xive_presenter_get_config(tctx->xptr) &
+          XIVE_PRESENTER_GEN1_TIMA_OS)) {
+        tctx->regs[TM_QW1_OS + TM_OGEN] = 2;
+    }
 
     /*
      * Initialize PIPR to 0xFF to avoid phantom interrupts when the
-- 
2.43.0


