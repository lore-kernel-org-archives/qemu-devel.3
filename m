Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72985E77181
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnp2-0001fk-HJ; Mon, 09 Dec 2024 19:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnls-0004qO-1Q; Mon, 09 Dec 2024 19:06:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlp-0001xe-LS; Mon, 09 Dec 2024 19:06:35 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9M5hX1024353;
 Tue, 10 Dec 2024 00:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=71f3ZOaRS/QZ+MWyU
 QPbehEAUN79Ac9nued+m9dmfxs=; b=OXsq11aiUZUOhPdWjebe2PaUuW1svAsTx
 UF6qLzo50iFlwmMKjHNVFBJFIjVSQAc71qcBd6C1oWVHkf6kVhDX4oNVSZ9ZqzAL
 sUyRutPNF+OKcQFwaFhUic9ioPJ1ndhJ/9NMQ/I3csAHQfFex7n1OFeJdYqByKQO
 MdBnqjvNeLlwdoM+hke8lgTqsyeJMf1kh4NQnYNz27oc/6WC3LW8i4yOCEhlFwQC
 I+Z7cFoB0Tavy9K0xw/fez3hyWnWrHkRpTxeFdefz/Xdw2nXppnLGtcElVIcN6qE
 myVB3YvFV4nBx9q8uc8zK0+ktpciaUMHYg+tH9XoW2gnIHfCZOj2Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjba3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:26 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9NvuKs027636;
 Tue, 10 Dec 2024 00:06:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjba3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9NRhqh032491;
 Tue, 10 Dec 2024 00:06:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn118r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA06Lei29295028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:06:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC28A20043;
 Tue, 10 Dec 2024 00:06:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F145920040;
 Tue, 10 Dec 2024 00:06:19 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:06:19 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 12/14] pnv/xive: Support ESB Escalation
Date: Mon,  9 Dec 2024 18:05:25 -0600
Message-Id: <20241210000527.9541-23-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AFaoWKHUGdU7pfU8e6aQNdi24RDZTtAV
X-Proofpoint-ORIG-GUID: c0DfK7-c9bvTvupWsOTWdV7KVnuiY3tc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=997
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

END notification processing has an escalation path.  The escalation is
not always an END escalation but can be an ESB escalation.

Also added a check for 'resume' processing which log a message stating it
needs to be implemented.  This is not needed at the time but is part of
the END notification processing.

This change was taken from a patch provided by Michael Kowal

Suggested-by: Michael Kowal <kowal@us.ibm.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2.h      |  1 +
 include/hw/ppc/xive2_regs.h | 13 +++++---
 hw/intc/xive2.c             | 61 +++++++++++++++++++++++++++++--------
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 8cdf819174..2436ddb5e5 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -80,6 +80,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
 uint32_t xive2_router_get_config(Xive2Router *xrtr);
 
 void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
+void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
 
 /*
  * XIVE2 Presenter (POWER10)
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index b11395c563..164d61e605 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -39,15 +39,18 @@
 
 typedef struct Xive2Eas {
         uint64_t       w;
-#define EAS2_VALID                 PPC_BIT(0)
-#define EAS2_END_BLOCK             PPC_BITMASK(4, 7) /* Destination EQ block# */
-#define EAS2_END_INDEX             PPC_BITMASK(8, 31) /* Destination EQ index */
-#define EAS2_MASKED                PPC_BIT(32) /* Masked                 */
-#define EAS2_END_DATA              PPC_BITMASK(33, 63) /* written to the EQ */
+#define EAS2_VALID         PPC_BIT(0)
+#define EAS2_QOS           PPC_BIT(1, 2)       /* Quality of Service(unimp) */
+#define EAS2_RESUME        PPC_BIT(3)          /* END Resume(unimp) */
+#define EAS2_END_BLOCK     PPC_BITMASK(4, 7)   /* Destination EQ block# */
+#define EAS2_END_INDEX     PPC_BITMASK(8, 31)  /* Destination EQ index */
+#define EAS2_MASKED        PPC_BIT(32)         /* Masked */
+#define EAS2_END_DATA      PPC_BITMASK(33, 63) /* written to the EQ */
 } Xive2Eas;
 
 #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
 #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
+#define xive2_eas_is_resume(eas)  (be64_to_cpu((eas)->w) & EAS2_RESUME)
 
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf);
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index c29d8e4831..44b7743b2b 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1514,18 +1514,39 @@ do_escalation:
         }
     }
 
-    /*
-     * The END trigger becomes an Escalation trigger
-     */
-    xive2_router_end_notify(xrtr,
-                           xive_get_field32(END2_W4_END_BLOCK,     end.w4),
-                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
-                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+    if (xive2_end_is_escalate_end(&end)) {
+        /*
+         * Perform END Adaptive escalation processing
+         * The END trigger becomes an Escalation trigger
+         */
+        xive2_router_end_notify(xrtr,
+                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
+                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
+                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+    } /* end END adaptive escalation */
+
+    else {
+        uint32_t lisn;              /* Logical Interrupt Source Number */
+
+        /*
+         *  Perform ESB escalation processing
+         *      E[N] == 1 --> N
+         *      Req[Block] <- E[ESB_Block]
+         *      Req[Index] <- E[ESB_Index]
+         *      Req[Offset] <- 0x000
+         *      Execute <ESB Store> Req command
+         */
+        lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
+                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
+
+        xive2_notify(xrtr, lisn, true /* pq_checked */);
+    }
+
+    return;
 }
 
-void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
+void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
 {
-    Xive2Router *xrtr = XIVE2_ROUTER(xn);
     uint8_t eas_blk = XIVE_EAS_BLOCK(lisn);
     uint32_t eas_idx = XIVE_EAS_INDEX(lisn);
     Xive2Eas eas;
@@ -1568,13 +1589,29 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
         return;
     }
 
+    /* TODO: add support for EAS resume if ever needed */
+    if (xive2_eas_is_resume(&eas)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "XIVE: EAS resume processing unimplemented - LISN %x\n",
+                      lisn);
+        return;
+    }
+
     /*
      * The event trigger becomes an END trigger
      */
     xive2_router_end_notify(xrtr,
-                             xive_get_field64(EAS2_END_BLOCK, eas.w),
-                             xive_get_field64(EAS2_END_INDEX, eas.w),
-                             xive_get_field64(EAS2_END_DATA,  eas.w));
+                            xive_get_field64(EAS2_END_BLOCK, eas.w),
+                            xive_get_field64(EAS2_END_INDEX, eas.w),
+                            xive_get_field64(EAS2_END_DATA,  eas.w));
+}
+
+void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xn);
+
+    xive2_notify(xrtr, lisn, pq_checked);
+    return;
 }
 
 static Property xive2_router_properties[] = {
-- 
2.43.0


