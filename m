Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A8BD1F9D4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0os7-0004qU-8L; Tue, 15 Oct 2024 17:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os5-0004mR-B6; Tue, 15 Oct 2024 17:14:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os3-0000RB-B5; Tue, 15 Oct 2024 17:14:25 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKt3NC006002;
 Tue, 15 Oct 2024 21:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Svg/kjtfh1RhNMOhq
 Dr8aPKWZ6dz2QWpYwWPsvVxroo=; b=kYt/Ni6piIKnvvSUT0eC6G98SCLlOxcm0
 i16C/Lb0Ssx5NJ/Axo3uKKLDWiOryfcSqSNz+7ivhY2aVn0v+Fvjk1OSFWgsoNx4
 mnvlOdmGi5+yG05dGCH+fO10v0E7FCJnC5/SBxZjpAwokFnWfzi9EMyG8gurHw4R
 yRykcIuPAerQ6rn1BIuuG5454B8IKm5pHDQFSIzgtkYUmRvWOP71I1gtnjVoS3XY
 npkJBfNDgURIANKbu76MboUlkvS0wSczxk6D5zpp2JDAAMQBxjuDIV+bk01UrLnW
 O4UudyhF9FvWt3M7X3A0jzetgGVUJHN2sy9X1GYajBAe1m+6hw2bw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429yun81y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLEB6V009261;
 Tue, 15 Oct 2024 21:14:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429yun81y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FI9ZpB006401;
 Tue, 15 Oct 2024 21:14:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk5v9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLE6N621758694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:14:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CDAA2004D;
 Tue, 15 Oct 2024 21:14:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 221DA20043;
 Tue, 15 Oct 2024 21:14:04 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:14:03 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 12/14] pnv/xive: Support ESB Escalation
Date: Tue, 15 Oct 2024 16:13:27 -0500
Message-Id: <20241015211329.21113-13-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vUQ8FOM1u2PofVgTWE6JT9VWbeEzllu_
X-Proofpoint-GUID: jOgnfPNRKrtvqmxXGkvaLCujJtTf5aaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=964 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 37aca4d26a..b17cc21ca6 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -82,6 +82,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
 uint32_t xive2_router_get_config(Xive2Router *xrtr);
 
 void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
+void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
 
 /*
  * XIVE2 Presenter (POWER10)
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 89236b9aaf..42cdc91452 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -40,15 +40,18 @@
 
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
index 41d689eaab..f812ba9624 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1511,18 +1511,39 @@ do_escalation:
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
@@ -1565,13 +1586,29 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
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


